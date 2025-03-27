package commonInfo

import (
	"context"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"google.golang.org/grpc"
	"os/exec"
	"reflect"
	"regexp"
	"sort"
	"strconv"
	"strings"
	"sync"
	"time"
)

const (
	Protocol_Shadowsocks = "shadowsocks"
	Protocol_VMess       = "vmess"
	Protocol_VLess       = "vless"
	Protocol_Trojan      = "trojan"
	Protocol_Socks       = "socks"
	Protocol_Hysteria    = "hysteria"
	Dokodemo_Door        = "dokodemo-door"

	Shadowsocks_Grpc = "shadowsocks-grpc"
	HysteriaOut      = "hysteria-out"

	Protocol_Hysteria_Proxy    = "hysteria_proxy"
	Protocol_Shadowsocks_Proxy = "shadowsocks_proxy"
)

const (
	Frp_Kcp  = "frp_kcp"
	Frp_Tcp  = "frp_tcp"
	Frp_Quic = "frp_quic"
)

const (
	Xray    = "xray"
	SingBox = "singBox"
)

type EncryptData struct {
	Data string `json:"data"`
}

type Res struct {
	Code int         `json:"code"`
	Msg  string      `json:"msg"`
	Data interface{} `json:"data"`
}

type RequestInfo struct {
	User string    `json:"user"`
	Time time.Time `json:"time"`
	Host string    `json:"host"`
}
type OffUsersReq struct {
	NodeId int `json:"nodeId"`
}
type CommonReq struct {
	ServerId int `p:"serverId"  v:"required"`
}
type TrafficsInfo struct {
	ServerId int       `json:"serverId"`
	Traffics []Traffic `json:"traffics"`
}
type ServerIPsInfo struct {
	ServerId  int      `json:"serverId"`
	ServerIps []string `json:"serverIps"`
}
type Traffic struct {
	IsGlobal bool   `json:"isGlobal"` // 是否是全局数据
	Email    string `json:"email"`    // Email
	NodeId   int    `json:"nodeId"`
	Up       int64  `json:"up"`   // 上传流量
	Down     int64  `json:"down"` // 下载流量
}
type NodeStatus struct {
	Status       int32 `json:"status"`
	OnlineLink   int32 `json:"onlineLink"`
	OnlineClient int32 `json:"onlineClient"`
	NodeId       int   `json:"nodeId"`
}

type NodeIds struct {
	NodeId int `json:"nodeId"`
	Port   int `json:"port"`
}

type NodeStatusReq struct {
	NodeStatus []NodeStatus `json:"nodeStatus"`
}

// 日志上传信息
type LogUploadInfo struct {
	ServerId int    `json:"serverId"` // 服务器ID
	LogName  string `json:"logName"`  // 日志名称
	Log      string `json:"log"`      // 日志内容
}

// 服务器信息
type ServerInfo struct {
	ServerId   int            `json:"serverId"`   // 服务器ID
	Cpu        float64        `json:"cpu"`        // CPU使用率
	Mem        MemInfo        `json:"mem"`        // 内存信息
	Swap       SwapInfo       `json:"swap"`       // 交换分区信息
	Disk       DiskInfo       `json:"disk"`       // 磁盘信息
	Uptime     uint64         `json:"uptime"`     // 运行时间
	Loads      []float64      `json:"loads"`      // 负载信息，表示1分钟、5分钟和15分钟的平均负载
	TcpCount   int32          `json:"tcpCount"`   // TCP连接数
	UdpCount   int32          `json:"udpCount"`   // UDP连接数
	MainIp     string         `json:"mainIp"`     // 主IP地址
	NetIO      NetIOInfo      `json:"netIO"`      // 网络IO信息
	NetTraffic NetTrafficInfo `json:"netTraffic"` // 网络流量信息
}

// 内存信息
type MemInfo struct {
	Current uint64 `json:"current"` // 当前内存使用量
	Total   uint64 `json:"total"`   // 总内存
}

// 交换分区信息
type SwapInfo struct {
	Current uint64 `json:"current"` // 当前交换分区使用量
	Total   uint64 `json:"total"`   // 总交换分区
}

// 磁盘信息
type DiskInfo struct {
	Current uint64 `json:"current"` // 当前磁盘使用量
	Total   uint64 `json:"total"`   // 总磁盘容量
}

// 网络IO信息
type NetIOInfo struct {
	Up   uint64 `json:"up"`   // 上传数据量
	Down uint64 `json:"down"` // 下载数据量
}

// 网络流量信息
type NetTrafficInfo struct {
	Sent uint64 `json:"sent"` // 已发送数据量
	Recv uint64 `json:"recv"` // 已接收数据量
}

func ShadowsocksPass(method string, uuid string) string {

	length := 0
	encoded1 := ""
	encoded2 := ""
	switch method {
	case "2022-blake3-aes-128-gcm":
		length = 16
	case "2022-blake3-aes-256-gcm":
		length = 32
	case "2022-blake3-chacha20-poly1305":
		length = 32
	default:
		return uuid
	}
	encoded1 = shadowsocksHash(method, length)
	encoded2 = shadowsocksHash(uuid, length)

	return encoded1 + ":" + encoded2
}

func ShadowsocksHash(method string, uuid string) string {
	length := 0
	switch method {
	case "2022-blake3-aes-128-gcm":
		length = 16
	case "2022-blake3-aes-256-gcm":
		length = 32
	case "2022-blake3-chacha20-poly1305":
		length = 32
	default:
		return uuid
	}
	return shadowsocksHash(uuid, length)
}

func shadowsocksHash(s string, length int) string {
	hash := sha256.New()
	hash.Write([]byte(s))
	hashed := hash.Sum(nil)[:length]
	return base64.StdEncoding.EncodeToString(hashed)
}

type Transfer struct {
	ExitServerId int    `json:"exitServerId"`
	ExitServerIp string `json:"exitServerIp"`
	LocalPort    int    `json:"localPort"`
	RemotePort   int    `json:"remotePort"`
	RemoteIp     string `json:"remoteIp"`
}

type XrayTransfer struct {
	Protocol       string `json:"protocol"`
	ExitServerId   int    `json:"exitServerId"`
	ExitServerIp   string `json:"exitServerIp"`
	ExitServerPort int    `json:"exitServerPort"`
	ExitNode       bool   `json:"exitNode"`
	InLocalPort    int    `json:"inLocalPort"`
	InLocalNodeId  int    `json:"inLocalNodeId"`
}

type SingBoxTransfer struct {
	ExitServerId   int    `json:"exitServerId"`
	ExitServerIp   string `json:"exitServerIp"`
	ExitServerPort int    `json:"exitServerPort"`
	InLocalPort    int    `json:"inLocalPort"`
	InLocalNodeId  int    `json:"inLocalNodeId"`
	ExitNode       bool   `json:"exitNode"`
}

type Nodes struct {
	NodesConfigs []NodesConfig
}

type NodesConfig struct {
	NodeId                    int32  `json:"nodeId"`
	ServerId                  int32  `json:"serverId"`
	OutIp                     string `json:"outIp"`
	Protocol                  string `json:"protocol"`
	DomainName                string `json:"domainName"`
	TransportProtocol         string `json:"transportProtocol"`
	StreamSettingsHost        string `json:"streamSettingsHost"`
	StreamSettingsPath        string `json:"streamSettingsPath"`
	StreamSettingsReality     int    `json:"streamSettingsReality"`
	StreamSettingsServiceName string `json:"streamSettingsServiceName"`
	NodeServerIp              string `json:"nodeServerIp"`
	NodeServerPort            int    `json:"vpnPort"`
	TransitServerPort         int    `json:"transitPort"`
	FrpServerIp               string `json:"frpServerIp"`
	FrpServerPort             int    `json:"frpServerPort"`
	ServerCore                string `json:"serverCore"`
	Method                    string `json:"method"`
}

type NodesRes struct {
	FrpNodeConfigs    []FrpNodeConfig
	SingBoxNodes      []NodesConfig
	HysteriaTransfers []Transfer
	SingBoxTransfers  []SingBoxTransfer
}

type FrpNodeConfig struct {
	NodeId     int32  `json:"nodeId"`
	ServerAddr string `json:"serverAddr"`
	LocalPort  int    `json:"localPort"`
	RemotePort int    `json:"remotePort"`
	Protocol   string `json:"protocol"`
}

type OffUsers struct {
	Globals map[string]bool     `json:"globals"`
	Tags    map[string]*OffUser `json:"tags"`
}

type OffUser struct {
	Value map[string]bool `json:"value"`
}

func CEncrypt(data interface{}) string {
	if data == nil {
		return ""
	}
	by, _ := json.Marshal(data)
	//plainText := string(by)
	plainText := base64.StdEncoding.EncodeToString(by)
	shift := 10
	var cipherText string
	for _, char := range plainText {
		cipherChar := (int(char) + shift) % 256 // 对字符进行位移操作
		cipherText += string(cipherChar)
	}
	return base64.StdEncoding.EncodeToString([]byte(cipherText))
}

func CDecrypt(cipherText string) (string, error) {
	shift := 10
	cipher, err := base64.StdEncoding.DecodeString(cipherText)
	if err != nil {
		return "", err
	}
	cipherText = string(cipher)
	var plainText string
	for _, char := range cipherText {
		plainChar := (int(char) - shift + 256) % 256 // 对字符进行反向位移操作
		plainText += string(plainChar)
	}
	cipher, err = base64.StdEncoding.DecodeString(plainText)
	if err != nil {
		return "", err
	}
	plainText = string(cipher)
	return plainText, nil
}

// encrypt 使用AES-GCM模式加密

func GetNodeIdToTag(nodeId int32, OutOrIn bool) string {
	if OutOrIn {
		return fmt.Sprintf("nodeId-%d-Outbounds", nodeId)
	}
	return fmt.Sprintf("nodeId-%d-Inbound", nodeId)
}
func GetNodeIdToTagVpnServerTransit(nodeId int32) string {
	return fmt.Sprintf("nodeId-%d-Transit", nodeId)
}

func GetToTagNodeId(tag string) (nodeId int, bounds string, err error) {
	n, err := fmt.Sscanf(tag, "nodeId-%d-%s", &nodeId, &bounds)
	if err != nil {
		return
	}
	if n < 1 {
		err = fmt.Errorf("invalid tag format: %s", tag)
		return
	}
	return
}

func GetUidNodeIdCodeTOEmail(nodeId int) string {
	return fmt.Sprintf("email-nodeId-%d@xray.com", nodeId)
}

func GetUidNodeIdCodeFoEmail(email string) (int, error) {
	re := regexp.MustCompile(`email-nodeId-(\d+)-code-\[(.*?)\]@xray\.com`)
	matches := re.FindStringSubmatch(email)
	if len(matches) < 2 {
		return 0, fmt.Errorf("format not recognized")
	}
	nodeId, err := strconv.Atoi(matches[0])
	if err != nil {
		return 0, fmt.Errorf("error parsing NodeID: %s", err)
	}
	return nodeId, nil
}

var locks = make(map[string]*sync.RWMutex) // 这里修改成存储 *sync.Mutex
var lock sync.RWMutex

func getKeyLock(key string) (mutex *sync.RWMutex, ok bool) { // 返回 *sync.Mutex
	lock.RLock()
	defer lock.RUnlock()
	mutex, ok = locks[key]
	return
}

func addKeyLock(key string) *sync.RWMutex { // 返回 *sync.Mutex
	lock.Lock()
	defer lock.Unlock()
	mutex := &sync.RWMutex{} // 创建一个 *sync.Mutex
	locks[key] = mutex
	return mutex
}

func GetKeyLock(key string, a ...interface{}) *sync.RWMutex { // 返回 *sync.Mutex
	if a != nil {
		for _, v := range a {
			key += fmt.Sprintf(":%v", v)
		}
	}
	mutex, ok := getKeyLock(key)
	if !ok {
		mutex = addKeyLock(key)
	}
	return mutex
}

type ConfigObject struct {
	Log       *LogObject              `protobuf:"bytes,1,opt,name=log,proto3" json:"log,omitempty"`
	Dns       *DnsObject              `protobuf:"bytes,2,opt,name=dns,proto3" json:"dns,omitempty"`
	Policy    *PolicyObject           `protobuf:"bytes,3,opt,name=policy,proto3" json:"policy,omitempty"`
	Api       *ApiObject              `protobuf:"bytes,4,opt,name=api,proto3" json:"api,omitempty"`
	Inbounds  []*InboundObject        `protobuf:"bytes,5,rep,name=inbounds,proto3" json:"inbounds,omitempty"`
	Outbounds []*OutboundsObject      `protobuf:"bytes,6,rep,name=outbounds,proto3" json:"outbounds,omitempty"`
	Routing   *RoutingObject          `protobuf:"bytes,7,opt,name=routing,proto3" json:"routing,omitempty"`
	Stats     *map[string]interface{} `protobuf:"bytes,8,opt,name=stats,proto3" json:"stats,omitempty"`
}

type LogObject struct {
	Access   string `json:"access,omitempty"`
	Error    string `json:"error,omitempty"`
	Loglevel string `json:"loglevel,omitempty"`
	DnsLog   bool   `json:"dnsLog"`
}

type DnsObject struct {
	Servers []string `protobuf:"bytes,1,rep,name=servers,proto3" json:"servers,omitempty"`
}

type PolicyLevels struct {
	Handshake         int32 `protobuf:"varint,1,opt,name=handshake,proto3" json:"handshake,omitempty"`
	ConnIdle          int32 `protobuf:"varint,2,opt,name=connIdle,proto3" json:"connIdle,omitempty"`
	UplinkOnly        int32 `protobuf:"varint,3,opt,name=uplinkOnly,proto3" json:"uplinkOnly,omitempty"`
	DownlinkOnly      int32 `protobuf:"varint,4,opt,name=downlinkOnly,proto3" json:"downlinkOnly,omitempty"`
	StatsUserUplink   bool  `protobuf:"varint,5,opt,name=statsUserUplink,proto3" json:"statsUserUplink,omitempty"`
	StatsUserDownlink bool  `protobuf:"varint,6,opt,name=statsUserDownlink,proto3" json:"statsUserDownlink,omitempty"`
	BufferSize        int32 `protobuf:"varint,7,opt,name=bufferSize,proto3" json:"bufferSize,omitempty"`
}

type PolicySystemConfig struct {
	StatsInboundUplink   bool `protobuf:"varint,1,opt,name=statsInboundUplink,proto3" json:"statsInboundUplink,omitempty"`
	StatsInboundDownlink bool `protobuf:"varint,2,opt,name=statsInboundDownlink,proto3" json:"statsInboundDownlink,omitempty"`
}

type PolicyObject struct {
	Levels map[string]*PolicyLevels `protobuf:"bytes,1,rep,name=levels,proto3" json:"levels,omitempty" protobuf_key:"bytes,1,opt,name=key,proto3" protobuf_val:"bytes,2,opt,name=value,proto3"`
	System *PolicySystemConfig      `protobuf:"bytes,2,opt,name=system,proto3" json:"system,omitempty"`
}

type ApiObject struct {
	Tag      string   `protobuf:"bytes,1,opt,name=tag,proto3" json:"tag,omitempty"`
	Services []string `protobuf:"bytes,2,rep,name=services,proto3" json:"services,omitempty"`
}

type SniffingObject struct {
	Enabled      bool     `protobuf:"varint,1,opt,name=enabled,proto3" json:"enabled,omitempty"`
	DestOverride []string `protobuf:"bytes,2,rep,name=destOverride,proto3" json:"destOverride,omitempty"`
}

type InboundObject struct {
	Listen         string                `protobuf:"bytes,1,opt,name=listen,proto3" json:"listen,omitempty"`
	Port           int32                 `protobuf:"varint,2,opt,name=port,proto3" json:"port,omitempty"`
	Protocol       string                `protobuf:"bytes,3,opt,name=protocol,proto3" json:"protocol,omitempty"`
	Settings       *SettingsObject       `protobuf:"bytes,4,opt,name=settings,proto3" json:"settings,omitempty"`
	StreamSettings *StreamSettingsObject `protobuf:"bytes,6,opt,name=streamSettings,proto3" json:"streamSettings,omitempty"`
	Sniffing       *SniffingObject       `protobuf:"bytes,7,opt,name=sniffing,proto3" json:"sniffing,omitempty"`
	Tag            string                `protobuf:"bytes,5,opt,name=tag,proto3" json:"tag,omitempty"`
	NodeId         int32                 `protobuf:"varint,8,opt,name=nodeId,proto3" json:"nodeId,omitempty"`
}

type SettingsObject struct {
	Address    string            `protobuf:"bytes,1,opt,name=address,proto3" json:"address,omitempty"`
	Auth       string            `protobuf:"bytes,8,opt,name=auth,proto3" json:"auth,omitempty"`
	Accounts   []*Clients        `protobuf:"bytes,7,rep,name=accounts,proto3" json:"accounts,omitempty"`
	Decryption string            `protobuf:"bytes,6,opt,name=decryption,proto3" json:"decryption,omitempty"`
	Password   string            `protobuf:"bytes,2,opt,name=password,proto3" json:"password,omitempty"`
	Method     string            `protobuf:"bytes,2,opt,name=method,proto3" json:"method,omitempty"`
	Clients    []*Clients        `protobuf:"bytes,3,rep,name=clients,proto3" json:"clients,omitempty"`
	Network    string            `protobuf:"bytes,4,opt,name=network,proto3" json:"network,omitempty"`
	Port       int32             `protobuf:"varint,5,opt,name=port,proto3" json:"port,omitempty"`
	Udp        bool              `protobuf:"varint,5,opt,name=udp,proto3" json:"udp,omitempty"`
	Ip         string            `protobuf:"bytes,4,opt,name=ip,proto3" json:"ip,omitempty"`
	Fallback   []*FallbackObject `protobuf:"bytes,4,opt,name=fallback,proto3" json:"fallback,omitempty"`
}
type FallbackObject struct {
	Name string `json:"name,omitempty"`
	Alpn string `json:"alpn,omitempty"`
	Path string `json:"path,omitempty"`
	Dest int    `json:"dest,omitempty"`
	Xver int    `json:"xver,omitempty"`
}

type WsSettingsObject struct {
	Path    string         `protobuf:"bytes,1,opt,name=path,proto3" json:"path,omitempty"`
	Headers *HeadersObject `protobuf:"bytes,2,opt,name=headers,proto3" json:"headers,omitempty"`
}

type HeadersObject struct {
	Host string `protobuf:"bytes,1,opt,name=host,proto3" json:"host,omitempty"`
}

type CertificatesObject struct {
	Certificate []string `protobuf:"bytes,1,rep,name=certificate,proto3" json:"certificate,omitempty"`
	Key         []string `protobuf:"bytes,2,rep,name=key,proto3" json:"key,omitempty"`
}

type TLSObject struct {
	ServerName        string               `protobuf:"bytes,1,opt,name=serverName,proto3" json:"serverName,omitempty"`
	DisableSystemRoot bool                 `protobuf:"varint,3,opt,name=disableSystemRoot,proto3" json:"disableSystemRoot,omitempty"`
	Certificates      []CertificatesObject `protobuf:"bytes,2,rep,name=certificates,proto3" json:"certificates,omitempty"`
}

type StreamSettingsObject struct {
	Network         string                 `protobuf:"bytes,1,opt,name=network,proto3" json:"network,omitempty"`
	Security        string                 `protobuf:"bytes,2,opt,name=security,proto3" json:"security,omitempty"`
	TlsSettings     *TLSObject             `protobuf:"bytes,4,opt,name=tlsSettings,proto3" json:"tlsSettings,omitempty"`
	WsSettings      *WsSettingsObject      `protobuf:"bytes,3,opt,name=wsSettings,proto3" json:"wsSettings,omitempty"`
	XhttpSettings   *XhttpSettingsObject   `protobuf:"bytes,3,opt,name=xhttpSettings,proto3" json:"xhttpSettings,omitempty"`
	GRPCSettings    *GRPCSettingsObject    `protobuf:"bytes,3,opt,name=grpcSettings,proto3" json:"grpcSettings,omitempty"`
	RealitySettings *RealitySettingsObject `protobuf:"bytes,3,opt,name=realitySettings,proto3" json:"realitySettings,omitempty"`
}

type RealitySettingsObject struct {
	Show         bool     `json:"show"`
	Target       string   `json:"target,omitempty"`
	Dest         string   `json:"dest,omitempty"`
	Xver         int      `json:"xver,omitempty"`
	ServerNames  []string `json:"serverNames,omitempty"`
	PrivateKey   string   `json:"privateKey,omitempty"`
	MinClientVer string   `json:"minClientVer,omitempty"`
	MaxClientVer string   `json:"maxClientVer,omitempty"`
	MaxTimeDiff  int      `json:"maxTimeDiff,omitempty"`
	ShortIds     []string `json:"shortIds,omitempty"`
	Fingerprint  string   `json:"fingerprint,omitempty"`
	ServerName   string   `json:"serverName,omitempty"`
	PublicKey    string   `json:"publicKey,omitempty"`
	ShortId      string   `json:"shortId,omitempty"`
	SpiderX      string   `json:"spiderX,omitempty"`
}

type GRPCSettingsObject struct {
	Authority           string `json:"authority,omitempty"`
	ServiceName         string `json:"serviceName,omitempty"`
	MultiMode           bool   `json:"multiMode,omitempty"`
	UserAgent           string `json:"user_agent,omitempty"`
	IdleTimeout         int    `json:"idle_timeout,omitempty"`
	HealthCheckTimeout  int    `json:"health_check_timeout,omitempty"`
	PermitWithoutStream bool   `json:"permit_without_stream,omitempty"`
	InitialWindowsSize  int    `json:"initial_windows_size,omitempty"`
}

type XhttpSettingsObject struct {
	Mode string `json:"mode,omitempty"`
	Path string `json:"path,omitempty"`
}

type Clients struct {
	Email    string `protobuf:"bytes,1,opt,name=email,proto3" json:"email,omitempty"`
	Password string `protobuf:"bytes,2,opt,name=password,proto3" json:"password,omitempty"`
	Id       string `protobuf:"bytes,3,opt,name=id,proto3" json:"id,omitempty"`
	Method   string `protobuf:"bytes,4,opt,name=method,proto3" json:"method,omitempty"`
	Uid      int32  `protobuf:"varint,5,opt,name=uid,proto3" json:"uid,omitempty"`
	User     string `protobuf:"bytes,6,opt,name=user,proto3" json:"user,omitempty"`
	Pass     string `protobuf:"bytes,7,opt,name=pass,proto3" json:"pass,omitempty"`
}

type OutboundsObject struct {
	SendThrough    string                  `protobuf:"bytes,1,opt,name=sendThrough,proto3" json:"sendThrough,omitempty"`
	Protocol       string                  `protobuf:"bytes,2,opt,name=protocol,proto3" json:"protocol,omitempty"`
	Settings       *map[string]interface{} `protobuf:"bytes,3,opt,name=settings,proto3" json:"settings,omitempty"`
	Tag            string                  `protobuf:"bytes,4,opt,name=tag,proto3" json:"tag,omitempty"`
	Mux            *MuxObject              `json:"mux,omitempty"`
	StreamSettings *StreamSettingsObject   `json:"streamSettings,omitempty"`
}

type MuxObject struct {
	Enabled         bool   `json:"enabled"`
	Concurrency     int    `json:"concurrency"`
	XudpConcurrency int    `json:"xudpConcurrency"`
	XudpProxyUDP443 string `json:"xudpProxyUDP443"`
}

type RoutingObject struct {
	DomainStrategy string        `protobuf:"bytes,1,opt,name=domainStrategy,proto3" json:"domainStrategy,omitempty"`
	DomainMatcher  string        `protobuf:"bytes,2,opt,name=domainMatcher,proto3" json:"domainMatcher,omitempty"`
	Rules          []*RuleObject `protobuf:"bytes,3,rep,name=rules,proto3" json:"rules,omitempty"`
	Balancers      []interface{} `protobuf:"bytes,4,rep,name=balancers,proto3" json:"balancers,omitempty"`
}

type RuleObject struct {
	DomainMatcher string   `protobuf:"bytes,7,opt,name=type,proto3" json:"domainMatcher,omitempty"`
	Type          string   `protobuf:"bytes,1,opt,name=type,proto3" json:"type,omitempty"`
	InboundTag    []string `protobuf:"bytes,2,rep,name=inboundTag,proto3" json:"inboundTag,omitempty"`
	Domain        []string `protobuf:"bytes,3,rep,name=domain,proto3" json:"domain,omitempty"`
	OutboundTag   string   `protobuf:"bytes,4,opt,name=outboundTag,proto3" json:"outboundTag,omitempty"`
	Ip            []string `protobuf:"bytes,5,rep,name=ip,proto3" json:"ip,omitempty"`
	Protocol      []string `protobuf:"bytes,6,rep,name=protocol,proto3" json:"protocol,omitempty"`
	Port          string   `protobuf:"bytes,8,opt,name=type,proto3" json:"port,omitempty"`
}

func SpeedPing(cxt context.Context, serverIp, pingUrl string, grpcPort int, proxies string, speed bool) (res int, err error) {

	conn, err := grpc.Dial(fmt.Sprintf("%s:%d", serverIp, grpcPort), grpc.WithInsecure())
	if err != nil {
		return 0, err
	}
	defer conn.Close()

	client := NewClashSpeedClient(conn)

	var response *Response
	if speed {
		response, err = client.SpeedTest(cxt, &Proxie{
			Proxies: proxies,
			Url:     pingUrl,
		})
		if err != nil {
			return
		}
		res = int(response.Res)
		return
	}
	response, err = client.URLTest(cxt, &Proxie{
		Proxies: proxies,
		Url:     pingUrl,
	})
	if err != nil {
		return
	}
	res = int(response.Res)
	return
}

type ByAnyType[T any] struct {
	Items    []T
	LessFunc func(T, T) bool
}

func (a ByAnyType[T]) Len() int           { return len(a.Items) }
func (a ByAnyType[T]) Swap(i, j int)      { a.Items[i], a.Items[j] = a.Items[j], a.Items[i] }
func (a ByAnyType[T]) Less(i, j int) bool { return a.LessFunc(a.Items[i], a.Items[j]) }

// EqualAnyOrder  old历史数组  new新数组   excludeFields排查比对的字段  lessFunc:自定义排序
func EqualAnyOrder[T any](old, new []T, excludeFields []string, lessFunc func(T, T) bool) bool {
	if old == nil || new == nil || len(old) != len(new) {
		return false
	}
	sort.Sort(ByAnyType[T]{Items: old, LessFunc: lessFunc})
	sort.Sort(ByAnyType[T]{Items: new, LessFunc: lessFunc})
	for i := range new {
		if !isEqualNodes(new[i], old[i], excludeFields) {
			return false
		}
	}
	for i := range old {
		if !isEqualNodes(new[i], old[i], excludeFields) {
			return false
		}
	}
	return true
}

// EqualAnyOrder  old历史数组  new新数组   excludeFields排查比对的字段
func isEqualNodes(nodeA, nodeB interface{}, excludeFields []string) bool {
	if nodeA == nil && nodeB != nil {
		return false
	}
	if nodeA != nil && nodeB == nil {
		return false
	}
	valA := reflect.ValueOf(nodeA)
	valB := reflect.ValueOf(nodeB)

	excluded := make(map[string]struct{})
	for _, field := range excludeFields {
		excluded[field] = struct{}{}
	}

	// Iterate through fields of the struct
	for i := 0; i < valA.NumField(); i++ {
		fieldName := valA.Type().Field(i).Name

		// If field is in the excluded list, skip
		if _, ok := excluded[fieldName]; ok {
			continue
		}

		if valA.Field(i).Interface() != valB.Field(i).Interface() {
			return false
		}
	}
	return true
}

func getConnectionsCount(protocol string) (int32, error) {
	cmdString := fmt.Sprintf("lsof -i %s | grep ESTABLISHED", protocol)
	if strings.ToLower(protocol) == "udp" {
		cmdString = fmt.Sprintf("lsof -i  %s", protocol)
	}
	cmd := exec.Command("bash", "-c", cmdString)
	output, err := cmd.Output()
	if err != nil {
		// 检查是否为 exit status 1
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 1 {
			// Grep 未找到任何匹配项，认为是正常情况，返回 0 连接
			return 0, nil
		}
		return 0, err
	}

	lines := strings.Split(string(output), "\n")
	count := len(lines) - 1 // 减去最后的空行
	if count < 0 {
		count = 0
	}
	return int32(count), nil
}

func GetTCPCount() (int32, error) {
	return getConnectionsCount("tcp")
}

func GetUDPCount() (int32, error) {
	return getConnectionsCount("udp")
}
