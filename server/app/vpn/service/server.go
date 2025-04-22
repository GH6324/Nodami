package service

import (
	"bufio"
	"bytes"
	"common/commonInfo"
	"errors"
	"fmt"
	"gfast/app/common/global"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"
	"gfast/cache"
	"gfast/library"
	"github.com/gogf/gf/frame/g"
	"golang.org/x/crypto/ssh"
	"golang.org/x/net/proxy"
	"io"
	"net"
	"net/url"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"time"
)

const (
	NOCOLOR = "NOCOLOR"
	INFO    = "INFO"
	WARN    = "WARN"
	ERROR   = "ERROR"
	DEBUG   = "DEBUG"
)

type Server struct {
	Id        int    `json:"Id"`
	User      string `json:"User"`
	Password  string `json:"Password"`
	PublicKey string `json:"PublicKey"`
	Host      string `json:"Host"`
	Port      int    `json:"Port"`
	LoginType string `json:"LoginType"`
	IsPppoe   bool
	ProxyAddr string `json:"proxyAddr"`
	sshClient *ssh.Client
	SSHAddr   string
}

type sshServer struct {
	sessions map[int]Server
}

var SSHServer = &sshServer{
	sessions: make(map[int]Server),
}

func GetServer(serverId int, new bool) (*Server, bool) {
	lock := library.GetKeyLock("sshServer")
	lock.Lock()
	defer lock.Unlock()
	s, ok := SSHServer.sessions[serverId]
	if !ok || s.Id == 0 || new {
		vpnServerInfo := model.VpnServer{}
		err := dao.VpnServer.DB().Model(dao.VpnServer.Table).Where(dao.VpnServer.Columns.ServerId, serverId).Scan(&vpnServerInfo)
		if err != nil {
			return nil, false
		}
		s = Server{
			Id:        vpnServerInfo.ServerId,
			User:      vpnServerInfo.ServerSshUser,
			Password:  vpnServerInfo.ServerSshPasswrod,
			PublicKey: vpnServerInfo.ServerSshPublicKey,
			Host:      vpnServerInfo.ServerIp,
			Port:      vpnServerInfo.ServerSshProt,
			LoginType: vpnServerInfo.ServerSshLoginType,
			IsPppoe:   vpnServerInfo.IsPppoe == 1,
			ProxyAddr: vpnServerInfo.ProxyAddr,
		}

		s.SSHAddr = fmt.Sprintf("%s:%d", strings.TrimSpace(s.Host), s.Port)
		if library.IsIPv6(s.SSHAddr) {
			s.SSHAddr = fmt.Sprintf("[%s]:%d", strings.TrimSpace(s.Host), s.Port)
		}
		SSHServer.sessions[serverId] = s
	}

	return &s, true

}

func ResGetServer(serverId int) (*Server, bool) {
	return GetServer(serverId, true)

}

func Restart(serverId int) {
	go func() {
		x, ok := ResGetServer(serverId)
		if ok {

			filePath := fmt.Sprintf("%s/%d", g.Cfg().GetString("server.LogPathAgent"), serverId)
			os.RemoveAll(filePath)
			SaveLog(x.Id, INFO, "清理日志成功")

			SaveLog(x.Id, INFO, "开始删除ip缓存")
			cache.Del(fmt.Sprintf("%s:%d", global.ServerInfoToken, x.Id))
			SaveLog(x.Id, INFO, "删除ip缓存成功")

			if x.IsPppoe {
				SaveLog(x.Id, INFO, "拨号服务器检查拨号状态")
				if !x.PppoeReStart(false) {
					SaveLog(x.Id, ERROR, "重新拨号失败")
				}
			}

			SaveLog(x.Id, INFO, "开始启动")
			x.run()
		}
	}()

}
func Stop(serverId int) {
	go func() {
		x, ok := ResGetServer(serverId)
		if ok {
			SaveLog(x.Id, INFO, "删除日志")
			filePath := fmt.Sprintf("%s/%d", g.Cfg().GetString("server.LogPathAgent"), serverId)
			os.RemoveAll(filePath)

			SaveLog(x.Id, INFO, "删除ip缓存")
			cache.Del(fmt.Sprintf("%s:%d", global.ServerInfoToken, x.Id))

			SaveLog(x.Id, INFO, "开始停止")
			x.stop()
		}
	}()

}
func UnInstall(serverId int) {
	go func() {
		x, ok := ResGetServer(serverId)
		if ok {
			SaveLog(x.Id, INFO, "删除日志")
			filePath := fmt.Sprintf("%s/%d", g.Cfg().GetString("server.LogPathAgent"), serverId)
			os.RemoveAll(filePath)

			SaveLog(x.Id, INFO, "删除ip缓存")
			cache.Del(fmt.Sprintf("%s:%d", global.ServerInfoToken, x.Id))

			SaveLog(x.Id, INFO, "开始停止")
			x.stop()
		}
	}()

}
func Reboot(serverId int) {
	go func() {
		x, ok := ResGetServer(serverId)
		if ok {
			SaveLog(x.Id, INFO, "删除日志")
			filePath := fmt.Sprintf("%s/%d", g.Cfg().GetString("server.LogPathAgent"), serverId)
			os.RemoveAll(filePath)

			SaveLog(x.Id, INFO, "删除ip缓存")
			cache.Del(fmt.Sprintf("%s:%d", global.ServerInfoToken, x.Id))

			SaveLog(x.Id, INFO, "开始重启服务器")
			client, err := x.login()
			if err != nil {
				SaveLog(x.Id, ERROR, err.Error())
				return
			}
			defer client.Close()

			session, err := client.NewSession()
			if err != nil {
				SaveLog(x.Id, ERROR, err.Error())
				return
			}
			defer session.Close()

			_, err = session.Output("reboot")
			if err != nil {
				SaveLog(x.Id, ERROR, err.Error())
			}
		}
	}()
}
func SaveLog(serverId int, level, msg string) (err error) {
	currentTime := time.Now().Format("2006-01-02 15:04:05")
	log := fmt.Sprintf("[%s] [%s]  [%s]", currentTime, level, msg)
	if level == NOCOLOR {
		log = msg
	}
	filePath := fmt.Sprintf("%s/%d/ssh.log", g.Cfg().GetString("server.LogPathAgent"), serverId)

	dir := filepath.Dir(filePath)
	if _, err = os.Stat(dir); os.IsNotExist(err) {
		err = os.MkdirAll(dir, 0755)
		if err != nil {
			return
		}
	}

	file, err := os.OpenFile(filePath, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		return
	}
	defer file.Close()

	// 检查并保持日志行数不超过200行
	lineCount, err := lineCounter(file)
	if err != nil {
		g.Log().Error(err)
		return
	}

	if lineCount >= 2000 {
		err = removeFirstLine(filePath)
		if err != nil {
			return
		}
	}

	// 写入日志
	_, err = file.WriteString(log + "\n")
	if err != nil {
		return
	}

	commonInfo.CheckAndRotateLogFile(filePath, 3*1024*1024)

	return
}

// lineCounter 计算文件的行数
func lineCounter(r io.Reader) (int, error) {
	buf := bufio.NewReader(r)
	lineCount := 0
	for {
		_, err := buf.ReadString('\n') // 读取一行
		if err != nil {
			if err == io.EOF { // 文件读取结束
				return lineCount, nil
			}
			return lineCount, err // 其他错误
		}
		lineCount++ // 每读取一行，计数器加1
	}
}

// removeFirstLine 删除文件的第一行
func removeFirstLine(filePath string) error {
	input, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}

	lines := strings.Split(string(input), "\n")
	if len(lines) <= 1 {
		return nil
	}

	output := strings.Join(lines[1:], "\n")
	err = os.WriteFile(filePath, []byte(output), 0666)
	return err
}

func GetLog(serverId int) string {

	filePath := fmt.Sprintf("%s/%d/ssh.log", g.Cfg().GetString("server.LogPathAgent"), serverId)
	file, err := os.Open(filePath)
	if err != nil {
		return ""
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var lines []string

	// 逐行读取文件内容，并将每行数据存储到切片中
	for scanner.Scan() {
		line := scanner.Text()
		lines = append(lines, line)
	}

	if err = scanner.Err(); err != nil {
		return ""
	}

	// 判断文件行数是否大于2000行
	if len(lines) > 1000 {
		// 只保留最后2000行
		lines = lines[len(lines)-1000:]
	}

	// 将切片中的行数据拼接为字符串
	result := strings.Join(lines, "\n")

	return result
}

func GetServerInfo(serverId int) (req *commonInfo.ServerInfo, err error) {
	req = &commonInfo.ServerInfo{}
	err = cache.GetToType(fmt.Sprintf("%s:%d", global.ServerInfoToken, serverId), req)
	return
}

func delRunSessions(serverId int) {
	lock := library.GetKeyLock("runSessions")
	lock.Lock()
	defer lock.Unlock()
	s, ok := GetServer(serverId, false)
	if ok {
		if s.sshClient != nil {
			s.sshClient.Close()
			s.sshClient = nil
		}
	}
}
func setRunSessions(serverId int, session *ssh.Client) {
	lock := library.GetKeyLock("runSessions")
	lock.Lock()
	defer lock.Unlock()
	s, ok := GetServer(serverId, true)
	if ok {
		s.sshClient = session
	}
}

func (x *Server) login() (client *ssh.Client, err error) {

	config := &ssh.ClientConfig{
		User:            strings.TrimSpace(x.User),
		HostKeyCallback: ssh.InsecureIgnoreHostKey(),
		Timeout:         10 * time.Second,
	}
	if strings.ToLower(x.LoginType) == "password" {
		config.Auth = []ssh.AuthMethod{
			ssh.Password(strings.TrimSpace(x.Password)),
		}
	} else {
		var key ssh.Signer
		key, err = ssh.ParsePrivateKey([]byte(strings.TrimSpace(x.PublicKey)))
		if err != nil {
			return
		}
		config.Auth = []ssh.AuthMethod{
			ssh.PublicKeys(key),
		}
	}

	// 如果设置了代理地址，使用 SOCKS5 代理
	if strings.TrimSpace(x.ProxyAddr) != "" {
		var auth *proxy.Auth
		var proxyURL *url.URL
		proxyURL, err = url.Parse(strings.TrimSpace(x.ProxyAddr))
		if err != nil {
			return nil, fmt.Errorf("invalid proxy URL: %w", err)
		}

		if proxyURL.User != nil {
			proxyUser := proxyURL.User.Username()
			proxyPassword, _ := proxyURL.User.Password()
			auth = &proxy.Auth{
				User:     proxyUser,
				Password: proxyPassword,
			}
		}

		var dialer proxy.Dialer
		proxyHost := proxyURL.Host
		dialer, err = proxy.SOCKS5("tcp", proxyHost, auth, proxy.Direct)
		if err != nil {
			return
		}

		var conn net.Conn
		conn, err = dialer.Dial("tcp", x.SSHAddr)
		if err != nil {
			return
		}

		var clientConn ssh.Conn
		var chans <-chan ssh.NewChannel
		var reqs <-chan *ssh.Request
		clientConn, chans, reqs, err = ssh.NewClientConn(conn, x.SSHAddr, config)
		if err != nil {
			return
		}

		client = ssh.NewClient(clientConn, chans, reqs)
	} else {
		// 直接连接
		client, err = ssh.Dial("tcp", x.SSHAddr, config)
		if err != nil {
			return
		}
	}
	if err != nil {
		return
	}
	return
}
func (x *Server) run() {
	lock := library.GetKeyLock("RunXray", x.Id)
	lock.Lock()
	defer lock.Unlock()
	delRunSessions(x.Id)

	var err error
	defer func() {
		if err != nil {
			SaveLog(x.Id, ERROR, err.Error())
			return
		}
	}()

	client, err := x.login()
	if err != nil {
		return
	}
	defer client.Close()

	session, err := client.NewSession()
	if err != nil {
		return
	}

	setRunSessions(x.Id, client)
	defer session.Close()
	defer delRunSessions(x.Id)

	out, err := session.StdoutPipe()
	if err != nil {
		return
	}

	errPipe, err := session.StderrPipe()
	if err != nil {
		return
	}

	go func(reader io.Reader) {
		scanner := bufio.NewScanner(reader)
		for scanner.Scan() {
			line := scanner.Text()
			if !strings.HasSuffix(line, "\n") {
				line += "\n"
			}
			SaveLog(x.Id, INFO, line)
		}
		if err = scanner.Err(); err != nil {
			SaveLog(x.Id, ERROR, err.Error())
		}
	}(out)

	go func(reader io.Reader) {
		scanner := bufio.NewScanner(reader)
		for scanner.Scan() {
			line := scanner.Text()
			if !strings.HasSuffix(line, "\n") {
				line += "\n"
			}
			SaveLog(x.Id, INFO, line)
		}
		if err = scanner.Err(); err != nil {
			SaveLog(x.Id, ERROR, err.Error())
		}
	}(errPipe)

	isSudo := ""
	if x.User != "root" {
		isSudo = "sudo"
	}

	dnsCmd := fmt.Sprintf(`%s bash -c 'echo -e "nameserver 114.114.114.114\nnameserver 8.8.8.8" > /etc/resolv.conf'`, isSudo)
	curlInstallCmd := fmt.Sprintf(`command -v curl >/dev/null 2>&1 || {
    if [ -f /etc/centos-release ]; then
        %s yum install -y curl;
    elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
        %s apt-get update && %s apt-get install -y curl;
    else
        echo "Unsupported OS. Please install curl manually." && exit 1;
    fi;
    }`, isSudo, isSudo, isSudo)
	agentDomCmd := fmt.Sprintf(`curl -o start.sh %s/agent/install/agent/%d?%d`, library.GetAgentAPI(), x.Id, time.Now().Unix())

	cmdString := fmt.Sprintf(`%s && %s && %s && %s chmod +x start.sh && %s ./start.sh`, dnsCmd, curlInstallCmd, agentDomCmd, isSudo, isSudo)

	SaveLog(x.Id, INFO, cmdString)
	err = session.Start(cmdString)
	if err != nil {
		return
	}

	err = session.Wait()
	if err != nil {
		return
	}
	return
}
func (x *Server) stop() {

	lock := library.GetKeyLock("StopXray", x.Id)
	lock.Lock()
	defer lock.Unlock()
	delRunSessions(x.Id)

	var err error
	defer func() {
		if err != nil {
			SaveLog(x.Id, ERROR, err.Error())
			return
		}
	}()

	client, err := x.login()
	if err != nil {
		return
	}

	defer client.Close()

	cmdSting := "docker stop fendou_agent && docker rm fendou_agent"
	if x.User != "root" {
		cmdSting = "sudo docker stop fendou_agent &&sudo docker rm fendou_agent"
	}
	output, err := x.combinedOutput(client, cmdSting)
	if err != nil {
		SaveLog(x.Id, ERROR, err.Error())
		return
	}
	SaveLog(x.Id, INFO, output)
}

func (x *Server) combinedOutput(client *ssh.Client, sh string) (output string, err error) {
	session, err := client.NewSession()
	if err != nil {
		return
	}
	defer session.Close()

	var stdoutBuf bytes.Buffer
	session.Stdout = &stdoutBuf
	if err = session.Run(sh); err != nil {
		return
	}
	output = stdoutBuf.String()
	return
}

func PingIp(serverId int, pingServerId int) (ping float64, err error) {

	x, ok := GetServer(serverId, false)
	if !ok {
		err = fmt.Errorf("不存在的服务器:%d", serverId)
		return
	}

	pingX, ok := GetServer(pingServerId, false)
	if !ok {
		err = fmt.Errorf("不存在的服务器:%d", pingServerId)
		return
	}
	ip := pingX.Host

	client, err := x.login()
	if err != nil {
		SaveLog(x.Id, ERROR, fmt.Sprintf("登录远程服务器%s:%d\n代理:%s\n错误:%s", x.ProxyAddr, x.Port, x.ProxyAddr, err.Error()))
		return
	}
	defer client.Close()

	parsePingLine := func(line string) []string {
		re := regexp.MustCompile(`time=(\d+(\.\d+)?)\s*ms`)
		return re.FindStringSubmatch(line)
	}
	parsePingOutput := func(stdoutPipe io.Reader) (string, error) {
		scanner := bufio.NewScanner(stdoutPipe)
		var averageResponseTime string

		// 遍历每一行输出
		for scanner.Scan() {
			line := scanner.Text()

			// 尝试匹配不同格式的 ping 输出
			if matches := parsePingLine(line); matches != nil {
				averageResponseTime = matches[1]
				break
			}
		}

		if err = scanner.Err(); err != nil {
			return "", err
		}

		if averageResponseTime == "" {
			return "", errors.New("无法解析平均响应时间")
		}

		return averageResponseTime, nil
	}

	pingCombined := "ping -c 3 " + ip
	output, err := x.combinedOutput(client, pingCombined)
	if err != nil {
		SaveLog(x.Id, ERROR, fmt.Sprintf("%s combinedOutput失败: %s", pingCombined, err.Error()))
	}

	averageResponseTime, err := parsePingOutput(strings.NewReader(string(output)))
	if err != nil {
		SaveLog(x.Id, ERROR, fmt.Sprintf("%s parsePingOutput失败: %s", pingCombined, err.Error()))
		return
	}
	ping, err = strconv.ParseFloat(averageResponseTime, 64)

	return
}

func (x *Server) PppoeReStart(enforce bool) bool {
	lock := commonInfo.GetKeyLock("PppoeReStart", x.Id)
	lock.Lock()
	defer lock.Unlock()

	client, err := x.login()
	if err != nil {
		SaveLog(x.Id, ERROR, "登录远程服务器失败: "+err.Error())
		return false
	}
	defer client.Close()

	output, err := x.combinedOutput(client, "pppoe-status")
	if err != nil {
		SaveLog(x.Id, WARN, "拨号服务器拨号状态: "+err.Error())
	}

	if !strings.Contains(output, "running") {
		SaveLog(x.Id, INFO, "拨号状态 未检测到 准备重拨")
		enforce = true
	}

	if strings.Contains(output, "running") {
		if enforce {
			SaveLog(x.Id, INFO, "断开拨号")
			output, err = x.combinedOutput(client, "adsl-stop")
			if err != nil {
				SaveLog(x.Id, ERROR, "拨号服务器断开拨号异常: "+err.Error()+"  output:"+output)
			}
			x.combinedOutput(client, "ps -ef|grep ppp*|grep -v grep|awk '{print $2}'| xargs kill -9")

		} else {
			//SaveLog(x.Id,  INFO, "拨号状态正常 无需重拨")
			return true
		}
	}

	if enforce {
		SaveLog(x.Id, INFO, "重新拨号")
		output, err = x.combinedOutput(client, "adsl-start")
		if err != nil {
			SaveLog(x.Id, ERROR, "拨号服务器拨号异常: "+err.Error()+"  output:"+output)
			return false
		}

		output, err = x.combinedOutput(client, "pppoe-status")
		if err != nil {
			SaveLog(x.Id, ERROR, "拨号服务器重拨后状态异常: "+err.Error())
			return false
		}

		if !strings.Contains(output, "running") {
			SaveLog(x.Id, ERROR, "拨号服务器重拨后状态异常: "+output)
			return false
		}
		SaveLog(x.Id, INFO, "重拨完成")
	}
	return true
}
