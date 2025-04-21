package core

import (
	"fmt"
	"github.com/gogf/gf/frame/g"
	"github.com/spf13/cast"
	"io"
	"log"
	"mime/multipart"
	"os"
	"strings"
	"time"

	"github.com/pkg/sftp"
)

func parseUint64(value string) uint64 {
	var result uint64
	fmt.Sscanf(value, "%d", &result)
	return result
}
func parseSize(sizeStr string) int64 {
	var size float64
	var unit string
	_, err := fmt.Sscanf(sizeStr, "%f%s", &size, &unit)
	if err != nil {
		return 0
	}

	switch unit {
	case "T", "Ti", "TB", "TiB":
		size *= 1024 * 1024 * 1024 * 1024
	case "G", "Gi", "GB", "GiB":
		size *= 1024 * 1024 * 1024
	case "M", "Mi", "MB", "MiB":
		size *= 1024 * 1024
	case "K", "Ki", "KB", "KiB":
		size *= 1024
	}

	return int64(size)
}

// CreateSftp 创建sftp客户端
func (sclient *SSHClient) CreateSftp() error {
	err := sclient.GenerateClient()
	if err != nil {
		return err
	}
	client, err := sftp.NewClient(sclient.Client)
	if err != nil {
		return err
	}
	sclient.Sftp = client
	return nil
}

// Mkdirs 创建目录
func (sclient *SSHClient) Mkdirs(path string) error {
	if _, err := sclient.Sftp.Stat(path); os.IsNotExist(err) {
		return sclient.Sftp.MkdirAll(path)
	}
	return nil
}

// Download 下载文件
func (sclient *SSHClient) Download(srcPath string) (*sftp.File, error) {
	return sclient.Sftp.Open(srcPath)
}

// Upload 上传文件
func (sclient *SSHClient) Upload(file multipart.File, id, dstPath string) error {
	dstFile, err := sclient.Sftp.Create(dstPath)
	if err != nil {
		return err
	}
	defer dstFile.Close()
	defer func() {
		// 上传完后删掉slice里面的数据
		if len(WcList) < 2 {
			WcList = nil
		} else {
			for i := 0; i < len(WcList); i++ {
				if WcList[i].Id == id {
					WcList = append(WcList[:i], WcList[i+1:]...)
					break
				}
			}
		}
	}()
	wc := WriteCounter{Id: id}
	WcList = append(WcList, &wc)
	_, err = io.Copy(dstFile, io.TeeReader(file, &wc))
	if err != nil {
		return err
	}
	return nil
}

type NetworkByte struct {
	IfaceName string  `json:"ifaceName"`
	UpSpeed   float64 `json:"upSpeed"`
	DomSpeed  float64 `json:"domSpeed"`
	tmestamp  time.Time
}

func (sclient *SSHClient) runCommand(command string) (string, error) {
	sshSession, err := sclient.Client.NewSession()
	if err != nil {
		return "", err
	}

	// 执行命令并获取输出
	var result strings.Builder
	sshSession.Stdout = &result
	sshSession.Stderr = os.Stderr
	err = sshSession.Run(command)
	if err != nil {
		return "", fmt.Errorf("failed to run command: %v", err)
	}
	return result.String(), nil
}

func (sclient *SSHClient) getBandwidth() (networkBytes []NetworkByte, err error) {
	networkBytes = make([]NetworkByte, 0)
	netInterfaces, err := sclient.runCommand("ls /sys/class/net/")
	if err != nil {
		log.Printf("获取网卡列表失败: %v\n", err)
		return
	}
	interfaces := strings.Fields(netInterfaces)
	lastStats := make(map[string]NetworkByte)
	interval := 1 * time.Second
	for i := 0; i < 2; i++ {

		for _, iface := range interfaces {
			if shouldIgnoreInterface(iface) {
				continue
			}

			networkData, err := sclient.runCommand(fmt.Sprintf("cat /proc/net/dev | grep '%s:'", iface))
			if err != nil {
				continue
			}

			fields := strings.Fields(networkData)

			if len(fields) < 17 {
				continue
			}

			upSpeed := parseUint64(fields[1])
			domSpeed := parseUint64(fields[9])

			lastStat, exists := lastStats[iface]
			if exists {
				duration := time.Now().Sub(lastStat.tmestamp).Seconds()
				networkBytes = append(networkBytes, NetworkByte{
					IfaceName: iface,
					UpSpeed:   (float64(upSpeed) - lastStat.UpSpeed) / float64(duration),
					DomSpeed:  (float64(domSpeed) - lastStat.DomSpeed) / float64(duration),
				})
			} else {
				lastStats[iface] = NetworkByte{
					IfaceName: iface,
					UpSpeed:   float64(upSpeed),
					DomSpeed:  float64(domSpeed),
					tmestamp:  time.Now(),
				}
			}

		}

		time.Sleep(interval)
	}
	return
}
func shouldIgnoreInterface(iface string) bool {
	ignoredPrefixes := []string{"lo", "docker", "veth", "br-", "vmnet", "virbr", "tun", "tap"}

	for _, prefix := range ignoredPrefixes {
		if strings.HasPrefix(iface, prefix) {
			return true
		}
	}
	return false
}

//func (sclient *SSHClient) getBandwidth() (networkBytes []NetworkByte, err error) {
//	networkBytes = make([]NetworkByte, 0)
//	netInterfaces, err := sclient.runCommand("ls /sys/class/net/")
//	if err != nil {
//		return
//	}
//	interfaces := strings.Fields(netInterfaces)
//
//	for _, iface := range interfaces {
//		var networkData string
//		networkData, err = sclient.runCommand(fmt.Sprintf("cat /proc/net/dev | grep %s", iface))
//		if err != nil {
//			continue
//		}
//
//		fields := strings.Fields(networkData)
//
//		if len(fields) < 17 {
//			continue
//		}
//
//		rxBytes := parseUint64(fields[1])
//		txBytes := parseUint64(fields[9])
//
//		networkBytes = append(networkBytes, NetworkByte{
//			IfaceName: iface,
//			UpSpeed:   float64(rxBytes / 8),
//			DomSpeed:  float64(txBytes / 8),
//		})
//
//	}
//	return
//}

func (sclient *SSHClient) GetPublicIP() string {
	ip, err := sclient.runCommand("curl -s https://api.ipify.org")
	if err != nil {
		return "_"
	}
	return strings.TrimSpace(ip)
}

func (sclient *SSHClient) GetPublicIPv6() string {
	ipv6, err := sclient.runCommand("curl -s http://6.ipw.cn/")
	if err != nil {
		return ""
	}
	return strings.TrimSpace(ipv6)
}

type DiskInfo struct {
	Total       int64   `json:"total"`
	Used        int64   `json:"used"`
	Free        int64   `json:"free"`
	FreePercent float64 `json:"freePercent"`
}

func (sclient *SSHClient) getMemoryInfo() (mem *DiskInfo, swap *DiskInfo, err error) {
	mem = &DiskInfo{}
	swap = &DiskInfo{}
	memoryInfo, err := sclient.runCommand("free -h")
	if err != nil {
		return
	}

	lines := strings.Split(memoryInfo, "\n")
	for _, line := range lines {
		if strings.Contains(line, "Mem") {
			fields := strings.Fields(line)
			if len(fields) > 3 {
				mem.Total = parseSize(fields[1])
				mem.Used = parseSize(fields[2])
				mem.Free = parseSize(fields[3])
				mem.FreePercent = float64(mem.Used) / float64(mem.Total) * 100
			}
		}

		if strings.Contains(line, "Swap") {
			fields := strings.Fields(line)
			if len(fields) > 3 {
				swap.Total = parseSize(fields[1])
				swap.Used = parseSize(fields[2])
				swap.Free = parseSize(fields[3])
				swap.FreePercent = float64(swap.Used) / float64(swap.Total) * 100
			}
		}
	}

	return
}

func (sclient *SSHClient) getDiskInfo() (*DiskInfo, error) {
	// 使用 df 命令获取磁盘空间信息
	diskInfo, err := sclient.runCommand("df -B1") // -B1 用于统一使用 bytes 为单位
	if err != nil {
		return nil, fmt.Errorf("获取磁盘空间信息失败: %v", err)
	}

	lines := strings.Split(diskInfo, "\n")
	var total, used, free uint64

	for _, line := range lines {
		// 只处理真正的磁盘分区（以 /dev 开头）
		if strings.HasPrefix(line, "/dev") {
			fields := strings.Fields(line)
			if len(fields) < 6 {
				continue
			}

			// 直接解析 bytes，累加总量
			partTotal := parseUint64(fields[1])
			partUsed := parseUint64(fields[2])
			partFree := parseUint64(fields[3])

			total += partTotal
			used += partUsed
			free += partFree
		}
	}

	if total == 0 {
		return nil, fmt.Errorf("未能获取到磁盘空间信息")
	}

	freePercent := float64(used) / float64(total) * 100

	return &DiskInfo{
		Total:       int64(total),
		Used:        int64(used),
		Free:        int64(free),
		FreePercent: freePercent,
	}, nil
}

type ServerInfo struct {
	PublicIPv4     string        `json:"publicIPv4"`     //ipv4地址
	PublicIPv6     string        `json:"publicIPv6"`     //ipv6地址
	NetworkBytes   []NetworkByte `json:"networkBytes"`   //实时宽带
	TcpConnections int           `json:"tcpConnections"` //tcp连接数
	UdpConnections int           `json:"udpConnections"` //udp连接数
	CPUCores       int           `json:"cpuCores"`       //核心数
	CPUUsage       float64       `json:"cpuUsage"`       //使用比例
	Mem            *DiskInfo     `json:"mem"`
	Swap           *DiskInfo     `json:"swap"`
	Disk           *DiskInfo     `json:"disk"`
}

func (sclient *SSHClient) GetServerInfo() (serverInfo *ServerInfo, err error) {

	serverInfo = &ServerInfo{}
	serverInfo.NetworkBytes, err = sclient.getBandwidth()
	if err != nil {
		g.Log().Errorf("获取实时宽带失败 %s", err)
	}
	_, err = sclient.runCommand("which netstat || (apt-get update -y && apt-get install -y net-tools) || (yum install -y net-tools)")
	if err != nil {
		g.Log().Errorf("netstat安装失败 %s", err)
	}

	var tcpConnections, udpConnections string
	tcpConnections, err = sclient.runCommand("netstat -ant | grep ESTABLISHED | wc -l")
	if err != nil {
		g.Log().Errorf("获取TCP连接数失败: %v\n", err)
	} else {
		serverInfo.TcpConnections = cast.ToInt(strings.TrimSpace(tcpConnections))
	}

	udpConnections, err = sclient.runCommand("netstat -anu | wc -l")
	if err != nil {
		g.Log().Errorf("获取UDP连接数失败: %v\n", err)
	} else {
		serverInfo.UdpConnections = cast.ToInt(strings.TrimSpace(udpConnections))
	}

	// 获取 CPU 核心数
	cpuCores, err := sclient.runCommand("nproc")
	if err != nil {
		g.Log().Errorf("获取CPU核心数失败: %v\n", err)
	} else {
		serverInfo.CPUCores = cast.ToInt(strings.TrimSpace(cpuCores))
	}

	// 获取 CPU 占用情况
	cpuUsage, err := sclient.runCommand("top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'")
	if err != nil {
		g.Log().Errorf("获取CPU占用情况失败: %v\n", err)
	} else {
		serverInfo.CPUUsage = cast.ToFloat64(strings.TrimSpace(cpuUsage))
	}

	serverInfo.Mem, serverInfo.Swap, err = sclient.getMemoryInfo()
	if err != nil {
		g.Log().Errorf("获取内存信息失败: %v\n", err)
	}

	// 获取硬盘占用情况
	serverInfo.Disk, err = sclient.getDiskInfo()
	if err != nil {
		g.Log().Errorf("获取硬盘占用情况失败: %v\n", err)
	}
	return
}
