package core

import (
	"fmt"
	"github.com/spf13/cast"
	"io"
	"log"
	"mime/multipart"
	"net"
	"os"
	"strings"
	"sync"
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

var mu sync.Mutex

func (sclient *SSHClient) RunCommand(command string) (string, error) {
	mu.Lock()
	defer mu.Unlock()
	if sclient.Client == nil {
		return "", fmt.Errorf("client is nil")
	}
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

func (sclient *SSHClient) GetBandwidth() (networkBytes []NetworkByte, err error) {
	networkBytes = make([]NetworkByte, 0)
	netInterfaces, err := sclient.RunCommand("ls /sys/class/net/")
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

			networkData, err := sclient.RunCommand(fmt.Sprintf("cat /proc/net/dev | grep '%s:'", iface))
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
					UpSpeed:   (float64(upSpeed) - lastStat.UpSpeed) / float64(duration) * 8,
					DomSpeed:  (float64(domSpeed) - lastStat.DomSpeed) / float64(duration) * 8,
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

func (sclient *SSHClient) GetPublicIP() string {
	ipSources := []string{
		"https://api.ipify.org",
		"https://ipinfo.io/ip",
		"https://checkip.amazonaws.com",
		"http://4.ipw.cn/", // 可保留作为兜底
	}

	for _, url := range ipSources {
		cmd := fmt.Sprintf("curl -s %s", url)
		ip, err := sclient.RunCommand(cmd)
		if err != nil {
			continue
		}
		ip = strings.TrimSpace(ip)
		if net.ParseIP(ip) != nil && net.ParseIP(ip).To4() != nil {
			return ip
		}
	}

	return ""
}

func (sclient *SSHClient) GetPublicIPv6() string {
	ipv6Sources := []string{
		"https://api64.ipify.org",
		"https://ipv6.ident.me",
		"https://ifconfig.co/ip",
	}

	for _, url := range ipv6Sources {
		out, err := sclient.RunCommand(fmt.Sprintf("curl -g -6 -s  %s", url))
		if err != nil {
			continue
		}
		ip := strings.TrimSpace(out)
		if ip != "" {
			return ip
		}
	}
	return ""
}

type DiskInfo struct {
	Total       int64   `json:"total"`
	Used        int64   `json:"used"`
	Free        int64   `json:"free"`
	FreePercent float64 `json:"freePercent"`
}

func (sclient *SSHClient) GetMemoryInfo() (mem *DiskInfo, swap *DiskInfo, err error) {
	mem = &DiskInfo{}
	swap = &DiskInfo{}
	memoryInfo, err := sclient.RunCommand("free -h")
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

func (sclient *SSHClient) GetDiskInfo() (*DiskInfo, error) {
	// 使用 df 命令获取磁盘空间信息
	diskInfo, err := sclient.RunCommand("df -B1") // -B1 用于统一使用 bytes 为单位
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

func (sclient *SSHClient) GetConnections() (tcp, udp int, err error) {
	var tcpConnections, udpConnections string
	// 检查 netstat 是否存在
	_, err = sclient.RunCommand("command -v netstat >/dev/null 2>&1")
	if err != nil {
		// 自动安装 netstat 所属的包（net-tools）
		_, installErr := sclient.RunCommand(`
			if [ -f /etc/debian_version ]; then
				sudo apt-get update && sudo apt-get install -y net-tools
			elif [ -f /etc/redhat-release ]; then
				sudo yum install -y net-tools
			elif command -v apk >/dev/null 2>&1; then
				sudo apk add net-tools
			else
				exit 1
			fi
		`)
		if installErr != nil {
			err = fmt.Errorf("netstat 未安装，且安装失败: %v", installErr)
			return
		}
	}
	tcpConnections, err = sclient.RunCommand("netstat -ant | grep ESTABLISHED | wc -l")
	if err != nil {
		err = fmt.Errorf("获取TCP连接数失败: %v", err)
		return
	}
	tcp = cast.ToInt(strings.TrimSpace(tcpConnections))
	udpConnections, err = sclient.RunCommand("netstat -anu | wc -l")
	if err != nil {
		err = fmt.Errorf("获取UDP连接数失败: %v", err)
		return
	}
	udp = cast.ToInt(strings.TrimSpace(udpConnections))
	return
}

func (sclient *SSHClient) GetCPUCores() (cpuCores int, err error) {
	// 获取 CPU 核心数
	cores, err := sclient.RunCommand("nproc")
	if err != nil {
		err = fmt.Errorf("获取CPU核心数失败: %v", err)
		return
	}
	cpuCores = cast.ToInt(strings.TrimSpace(cores))
	return
}

func (sclient *SSHClient) GetCPUUsage() (usage float64, err error) {
	// 获取当前的 CPU 使用情况
	lastCpuInfo, err := sclient.RunCommand("cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}'")
	if err != nil {
		return 0, fmt.Errorf("无法获取 CPU 信息: %v", err)
	}

	// 提取当前的 CPU 时间信息
	lastCpuFields := strings.Fields(lastCpuInfo)
	if len(lastCpuFields) < 8 {
		return 0, fmt.Errorf("获取的 CPU 信息格式不正确，期望 8 个字段，实际得到 %d 个", len(lastCpuFields))
	}

	// 提取空闲时间和总时间
	lastSysIdle := cast.ToUint64(lastCpuFields[3])
	lastTotalCpuTime := cast.ToUint64(lastCpuFields[0]) + cast.ToUint64(lastCpuFields[1]) +
		cast.ToUint64(lastCpuFields[2]) + cast.ToUint64(lastCpuFields[3]) +
		cast.ToUint64(lastCpuFields[4]) + cast.ToUint64(lastCpuFields[5]) +
		cast.ToUint64(lastCpuFields[6]) + cast.ToUint64(lastCpuFields[7])

	// 暂停并等待一段时间（与脚本中的 sleep 相同）
	time.Sleep(5 * time.Second)

	// 获取下一次的 CPU 时间信息
	nextCpuInfo, err := sclient.RunCommand("cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}'")
	if err != nil {
		return 0, fmt.Errorf("无法获取下一次 CPU 信息: %v", err)
	}

	// 提取下一次的 CPU 时间信息
	nextCpuFields := strings.Fields(nextCpuInfo)
	if len(nextCpuFields) < 8 {
		return 0, fmt.Errorf("获取的 CPU 信息格式不正确，期望 8 个字段，实际得到 %d 个", len(nextCpuFields))
	}

	// 提取空闲时间和总时间
	nextSysIdle := cast.ToUint64(nextCpuFields[3])
	nextTotalCpuTime := cast.ToUint64(nextCpuFields[0]) + cast.ToUint64(nextCpuFields[1]) +
		cast.ToUint64(nextCpuFields[2]) + cast.ToUint64(nextCpuFields[3]) +
		cast.ToUint64(nextCpuFields[4]) + cast.ToUint64(nextCpuFields[5]) +
		cast.ToUint64(nextCpuFields[6]) + cast.ToUint64(nextCpuFields[7])

	// 计算空闲时间和总时间的差值
	systemIdle := float64(nextSysIdle - lastSysIdle)
	totalTime := float64(nextTotalCpuTime - lastTotalCpuTime)

	// 计算 CPU 使用率
	usage = 100 - (systemIdle / totalTime * 100)

	return cast.ToFloat64(fmt.Sprintf("%.2f", usage)), nil
}
