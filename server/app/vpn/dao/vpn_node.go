// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/dao/vpn_node.go
// 生成人：gfast
// ==========================================================================

package dao

import (
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao/internal"
)

// vpnNodeDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnNodeDao struct {
	*internal.VpnNodeDao
}

var (
	// VpnNode is globally public accessible object for table tools_gen_table operations.
	VpnNode = vpnNodeDao{
		internal.NewVpnNodeDao(),
	}
)

// Fill with you ideas below.

// VpnNodeSearchReq 分页请求参数
type VpnNodeSearchReq struct {
	NodeId          string `p:"nodeId"`
	NotNodeId       string `p:"nodeIdNo"`
	ServerId        string `p:"serverId"`        //服务器
	OutIp           string `p:"outIp"`           //出口IP
	Protocol        string `p:"protocol"`        //协议
	TransitProtocol string `p:"transitProtocol"` //中转服务协议
	Other           string `p:"other"`
	NationId        string `p:"nationId" `
	comModel.PageReq
}

// VpnNodeAddReq 添加操作请求参数
type VpnNodeAddReq struct {
	AddType                   int        `p:"addType"` //0单节点  1多ip服务器多节点 2多服务器多节点
	ServerId                  int        `p:"serverId"`
	ServerIds                 []int      `p:"serverIds"`
	TransitPort               int        `p:"transitPort" `
	TransitProtocol           string     `p:"transitProtocol" `
	Transfers                 []TranceId `p:"transfers" `
	Protocol                  string     `p:"protocol" v:"required#协议不能是空"`
	OtuType                   int        `p:"otuType" v:"required#出口类型不能空"` // 1默认 2指定IP 3指定节点ID
	NationId                  int        `p:"nationId" v:"required#nationId不能空"`
	OutIp                     string     `p:"outIp"`
	VpnPort                   int        `p:"vpnPort" `
	Method                    string     `p:"method"`
	FrpServerId               int        `p:"frpServerId"`
	FrpProtocol               string     `p:"frpProtocol"`
	FrpPort                   int        `p:"frpPort"`
	Other                     string     `p:"other"`
	TransportProtocol         string     `p:"transportProtocol" `         //
	StreamSettingsHost        string     `p:"streamSettingsHost"`         //
	StreamSettingsPath        string     `p:"streamSettingsPath" `        //
	StreamSettingsServiceName string     `p:"streamSettingsServiceName" ` //
	StreamSettingsReality     int        `p:"streamSettingsReality"`
}

// VpnNodeEditReq 修改操作请求参数
type VpnNodeEditReq struct {
	NodeId                    int        `p:"nodeId"     v:"required#主键ID不能为空"`
	ServerId                  int        `p:"serverId"   v:"required#服务器不能为空"`
	Protocol                  string     `p:"protocol" v:"required#协议不能是空"`
	OtuType                   int        `p:"otuType" v:"required#出口类型不能空"` // 1默认 2指定IP 3指定节点ID
	NationId                  int        `p:"nationId" v:"required#nationId不能空"`
	TransitPort               int        `p:"transitPort" `
	TransitProtocol           string     `p:"transitProtocol" `
	Transfers                 []TranceId `p:"transfers" `
	OutIp                     string     `p:"outIp"`
	VpnPort                   int        `p:"vpnPort"`
	Method                    string     `p:"method"`
	FrpServerId               int        `p:"frpServerId"`
	FrpProtocol               string     `p:"frpProtocol"`
	FrpPort                   int        `p:"frpPort"`
	Other                     string     `p:"other"`
	TransportProtocol         string     `p:"transportProtocol" `         //
	StreamSettingsHost        string     `p:"streamSettingsHost"`         //
	StreamSettingsPath        string     `p:"streamSettingsPath" `        //
	StreamSettingsServiceName string     `p:"streamSettingsServiceName" ` //
	StreamSettingsReality     int        `p:"streamSettingsReality"`
}

// VpnNodeEditReqs 修改操作请求参数
type VpnNodeEditReqs struct {
	NodeIds         []int  `p:"nodeIds" v:"required#主键ID不能为空"`
	TransitProtocol string `p:"transitProtocol" `
	FrpServerId     int    `p:"frpServerId"`
	FrpProtocol     string `p:"frpProtocol"`
	NationId        int    `p:"nationId"`
}

type TranceId struct {
	EntranceServerId int `p:"entranceServerId"`
}

type ClashConfig struct {
	// @description 本地的http代理端口
	Port int `yaml:"port,omitempty" json:"port,omitempty"`
	// @description 本地的socks5代理端口
	SocksPort int `yaml:"socks-port,omitempty" json:"socks-port,omitempty"`
	// @description 本地的透明代理服务端口
	RedirPort int `yaml:"redir-port,omitempty" json:"redir-port,omitempty"`
	// @description  HTTP(S) 和 SOCKS 代理混合端口
	MixedPort int `yaml:"mixed-port,omitempty" json:"mixed-port,omitempty"`
	// @description 允许局域网共享，设置成true时发挥作用
	AllowLan bool `yaml:"allow-lan,omitempty" json:"allow-lan,omitempty"`
	// @PreferH3是否开启 DOH 的 http/3
	PreferH3 bool `yaml:"prefer-h3,omitempty" json:"prefer-h3,omitempty"`
	// @description rule（按规则放行）  Global（全局走Clash）
	Mode string `yaml:"mode,omitempty" json:"mode,omitempty"`
	// @description  silent（完全不输出日志）/warning（仅warning等级日志）/error（仅error等级日志）/info（正常输出）/debug（调试模式/嘈杂模式，输出最详细
	LogLevel string `yaml:"log-level,omitempty" json:"log-level,omitempty"`
	// @description  tcp并发
	TcpConcurrent bool `yaml:"tcp-concurrent,omitempty" json:"tcp-concurrent,omitempty"`
	// @description  RESTful Web API 监听地址
	ExternalController string `yaml:"external-controller,omitempty" json:"external-controller,omitempty"`
	// @description  RESTful API 密钥
	Secret string `yaml:"secret,omitempty" json:"secret,omitempty"`
	// @description  当设置为 false 时, 解析器不会将主机名解析为 IPv6 地址
	IPv6 bool `yaml:"ipv6" json:"ipv6"`
	// @description  GeoDataMode
	GeoDataMode bool `yaml:"geodata-mode" json:"geodata-mode,omitempty"`
	// @description  GeoDataLoader
	GeoDataLoader string `yaml:"geodata-loader" json:"geodata-loader,omitempty"`
	// @description  GeoAutoUpdate
	GeoAutoUpdate     bool `yaml:"geo-auto-update" json:"geo-auto-update,omitempty"`
	GeoUpdateInterval int  `yaml:"geo-update-interval,omitempty" json:"geo-update-interval,omitempty"`
	// @description  自定义hosts # '*.clash.dev': 127.0.0.1
	Hosts []string `yaml:"hosts,omitempty" json:"hosts,omitempty"`
	// @description  Dns
	Dns     Dns      `yaml:"dns,omitempty" json:"dns,omitempty"`
	Sniffer *Sniffer `yaml:"sniffer,omitempty" json:"sniffer,omitempty"`
	Tun     *Tun     `yaml:"tun,omitempty" json:"tun,omitempty"`
	// @description  全部节点
	Proxies     []*Proxie      `yaml:"proxies,omitempty" json:"proxies,omitempty"`
	ProxyGroups []*Group       `yaml:"proxy-groups" json:"proxy-groups,omitempty"`
	Rules       []string       `yaml:"rules" json:"rules"`
	Tunnels     []*Tunnels     `yaml:"tunnels,omitempty" json:"tunnels,omitempty"`
	Profile     *Profile       `yaml:"profile,omitempty" json:"profile,omitempty"`
	GeoxUrl     *GeoxUrlStruct `yaml:"geox-url,omitempty" json:"geox-url,omitempty"`
	Listeners   []RawListeners `yaml:"listeners,omitempty" json:"listeners,omitempty"`
}
type RawListeners struct {
	Name        string            `yaml:"name" json:"name"`
	Type        string            `yaml:"type" json:"type"`
	Port        int               `yaml:"port" json:"port"`
	Listen      string            `yaml:"listen,omitempty" json:"listen"`
	Cipher      string            `yaml:"cipher,omitempty" json:"cipher,omitempty"`
	Password    string            `yaml:"password,omitempty" json:"password,omitempty"`
	Users       map[string]string `yaml:"users,omitempty" json:"users,omitempty"`
	Udp         bool              `yaml:"udp,omitempty" json:"udp,omitempty"`
	Up          string            `yaml:"up,omitempty" json:"udp,omitempty"`
	Down        string            `yaml:"down,omitempty" json:"down,omitempty"`
	Alpn        []string          `yaml:"alpn,omitempty" json:"alpn,omitempty"`
	Certificate string            `yaml:"certificate" json:"certificate"`
	PrivateKey  string            `yaml:"private-key" json:"private-key"`
	Proxy       string            `yaml:"proxy,omitempty" json:"proxy,omitempty"`
}

type GeoxUrlStruct struct {
	GeoIpUrl   string `yaml:"geoip,omitempty" json:"geoip,omitempty"`
	GeoSiteUrl string `yaml:"geosite,omitempty" json:"geosite,omitempty"`
	MMDbUrl    string `yaml:"mmdb,omitempty" json:"mmdb,omitempty"`
	AsnUrl     string `yaml:"asn,omitempty" json:"asn,omitempty"`
}
type Tunnels struct {
	Network []string `yaml:"network" json:"network"`
	Address string   `yaml:"address" json:"address"`
	Target  string   `yaml:"target" json:"target"`
}
type Profile struct {
	//# 储存 API 对策略组的选择，以供下次启动时使用
	StoreSelected bool `yaml:"store-selected,omitempty" json:"store-selected,omitempty"`
	//# 储存 fakeip 映射表，域名再次发生连接时，使用原有映射地址
	StoreFakeIp bool `yaml:"store-fake-ip,omitempty" json:"store-fake-ip,omitempty"`
}
type Tun struct {
	Enable              bool                     `yaml:"enable" json:"enable"`
	Stack               string                   `yaml:"stack" json:"stack"`
	Device              string                   `yaml:"device" json:"device"`
	AutoDetectInterface bool                     `yaml:"auto-detect-interface" json:"auto-detect-interface"`
	AutoRoute           bool                     `yaml:"auto-route" json:"auto-route"`
	DnsHijack           []map[string]interface{} `yaml:"dns-hijack" json:"dns-hijack"`
	StrictRoute         bool                     `yaml:"strict-route" json:"strict-route"`
}
type Sniffer struct {
	Enable              bool   `yaml:"enable" json:"enable"`
	OverrideDestination bool   `yaml:"override-destination" json:"override-destination"`
	ForceDnsMapping     bool   `yaml:"force-dns-mapping" json:"force-dns-mapping"`
	ParsePureIp         bool   `yaml:"parse-pure-ip" json:"parse-pure-ip"`
	Sniff               *Sniff `yaml:"sniff,omitempty"  json:"sniff,omitempty"`
}
type Sniff struct {
	HTTP *SniffData `yaml:"HTTP,omitempty" json:"HTTP,omitempty"`
	TLS  *SniffData `yaml:"TLS,omitempty" json:"TLS,omitempty"`
	QUIC *SniffData `yaml:"QUIC,omitempty" json:"QUIC,omitempty"`
}
type SniffData struct {
	Ports []interface{} `yaml:"ports" json:"ports"`
}
type Dns struct {
	Enable                bool                   `yaml:"enable,omitempty" json:"enable,omitempty"`
	IPv6                  bool                   `yaml:"ipv6" json:"ipv6"`
	PreferH3              bool                   `yaml:"prefer-h3,omitempty" json:"prefer-h3,omitempty"`
	Listen                string                 `yaml:"listen,omitempty" json:"listen,omitempty"`
	EnhancedMode          string                 `yaml:"enhanced-mode,omitempty" json:"enhanced-mode,omitempty"`
	FakeIpRange           string                 `yaml:"fake-ip-range,omitempty" json:"fake-ip-range,omitempty"`
	FakeIpFilter          []string               `yaml:"fake-ip-filter,omitempty" json:"fake-ip-filter,omitempty"`
	NameserverPolicy      map[string]interface{} `yaml:"nameserver-policy,omitempty" json:"nameserver-policy,omitempty"`
	DefaultNameserver     []string               `yaml:"default-nameserver,omitempty" json:"default-nameserver,omitempty"`
	ProxyServerNameServer []string               `yaml:"proxy-server-nameserver,omitempty" json:"proxy-server-nameserver,omitempty"`
	Nameserver            []string               `yaml:"nameserver,omitempty" json:"nameserver,omitempty"`
	Fallback              []string               `yaml:"fallback,omitempty" json:"fallback,omitempty"`
	FallbackFilter        FallbackFilter         `yaml:"fallback-filter,omitempty" json:"fallback-filter,omitempty"`
	UseHosts              bool                   `yaml:"use-hosts,omitempty" json:"use-hosts,omitempty"`
}
type FallbackFilter struct {
	Geoip     bool     `yaml:"geoip,omitempty" json:"geoip,omitempty"`
	GeoipCode string   `yaml:"geoip-code,omitempty" json:"geoip-code,omitempty"`
	IpCidr    []string `yaml:"ipcidr,omitempty" json:"ipcidr,omitempty"`
	Domain    []string `yaml:"domain,omitempty" json:"domain,omitempty"`
}
type Proxie struct {
	//  @description 节点名称
	Name string `yaml:"name,omitempty" json:"name,omitempty" `
	//  @description 节点服务器host
	Server string `yaml:"server,omitempty" json:"server,omitempty"`
	//  @description 节点端口
	Port interface{} `yaml:"port,omitempty" json:"port,omitempty"`
	//  @description 节点类型 ss ssr vmess socks5 http snell trojan
	Type string `yaml:"type,omitempty" json:"type,omitempty"`
	// @description 加密方法
	Cipher string `yaml:"cipher,omitempty" json:"cipher,omitempty"`
	Sni    string `yaml:"sni,omitempty" json:"sni,omitempty"`
	// @description 密码
	Password string `yaml:"password,omitempty" json:"password,omitempty"`
	// @description username
	UserName string `yaml:"username,omitempty" json:"username,omitempty"`
	// @description Shadowsocks 插件  obfs 和 v2ray-plugin.
	Plugin string `yaml:"plugin,omitempty" json:"plugin,omitempty"`
	// @description 传输配置
	PluginOpts *PluginOpts `yaml:"plugin-opts,omitempty" json:"plugin-opts,omitempty"`

	Smux *SmuxOpts `yaml:"smux,omitempty" json:"smux,omitempty"`

	UUID    string `yaml:"uuid,omitempty" json:"uuid,omitempty"`
	AlterID *int   `yaml:"alterId,omitempty" json:"alterId,omitempty"`
	UDP     bool   `yaml:"udp,omitempty" json:"udp,omitempty"`

	TLS            bool   `yaml:"tls,omitempty" json:"tls,omitempty"`
	TFO            bool   `yaml:"tfo,omitempty" json:"tfo,omitempty"`
	Down           string `yaml:"down,omitempty" json:"down,omitempty"`
	Up             string `yaml:"up,omitempty" json:"up,omitempty"`
	SkipCertVerify bool   `yaml:"skip-cert-verify,omitempty" json:"skip-cert-verify,omitempty"`
	// @description 优先于 wss 主机
	ServerName string `yaml:"servername,omitempty" json:"servername,omitempty"`
	// @description 优先于 wss 主机
	Network string `yaml:"network,omitempty" json:"network,omitempty"`
	// @description 优先于 wss 主机
	WsOpts      *WsOpts      `yaml:"ws-opts,omitempty" json:"ws-opts,omitempty"`
	GrpcOpts    *GrpcOpts    `yaml:"grpc-opts,omitempty" json:"grpc-opts,omitempty"`
	SSOpts      *SSOpts      `yaml:"ss-opts,omitempty" json:"ss-opts,omitempty"`
	RealityOpts *RealityOpts `yaml:"reality-opts,omitempty" json:"reality-opts,omitempty"`
	// @description 出口IP 仅支持direct
	SendThrough       string `yaml:"send-through,omitempty" json:"send-through,omitempty"`
	ClientFingerprint string `yaml:"client-fingerprint,omitempty" json:"client-fingerprint,omitempty"`
}
type GrpcOpts struct {
	GrpcServiceName string `yaml:"grpc-service-name,omitempty" json:"grpc-service-name,omitempty"`
}
type RealityOpts struct {
	PublicKey string `yaml:"public-key,omitempty" json:"public-key,omitempty"`
	ShortId   string `yaml:"short-id,omitempty" json:"short-id,omitempty"`
}

type SSOpts struct {
	Enabled  bool   `yaml:"enabled" json:"enabled"`
	Method   string `yaml:"method,omitempty" json:"method,omitempty"`
	Password string `yaml:"password,omitempty" json:"password,omitempty"`
}

type SmuxOpts struct {
	Enabled        bool        `yaml:"enabled,omitempty" json:"enabled,omitempty"`
	Protocol       string      `yaml:"protocol,omitempty" json:"protocol,omitempty"`               //多路复用协议，支持如下协议，默认使用 h2mux
	MaxConnections int         `yaml:"max-connections,omitempty" json:"max-connections,omitempty"` //最大连接数量
	MinStreams     int         `yaml:"min-streams,omitempty" json:"min-streams,omitempty"`         //在打开新连接之前，连接中的最小多路复用流数量
	MaxStreams     int         `yaml:"max-streams,omitempty" json:"max-streams,omitempty"`         //在打开新连接之前，连接中的最大多路复用流数量
	OnlyTcp        bool        `yaml:"only-tcp,omitempty" json:"only-tcp,omitempty"`               //仅允许 tcp
	Padding        bool        `yaml:"padding,omitempty" json:"padding,omitempty"`                 //启用填充
	BrutalOpts     *BrutalOpts `yaml:"brutal-opts,omitempty" json:"brutal-opts,omitempty"`
}
type BrutalOpts struct {
	Enabled bool   `yaml:"enabled,omitempty" json:"enabled,omitempty"`
	Up      string `yaml:"up,omitempty" json:"up,omitempty"`
	Down    string `yaml:"down,omitempty" json:"down,omitempty"`
}
type WsOpts struct {
	Path                string                 `yaml:"path,omitempty" json:"path,omitempty"`
	Headers             map[string]interface{} `yaml:"headers,omitempty" json:"headers,omitempty"`
	MaxEarlyData        string                 `yaml:"max-early-data,omitempty" json:"max-early-data,omitempty"`
	EarlyDataHeaderName string                 `yaml:"early-data-header-name,omitempty" json:"early-data-header-name,omitempty"`
}
type PluginOpts struct {
	// @description  websocket
	Mode           string                 `yaml:"mode,omitempty" json:"mode,omitempty"`
	Tls            bool                   `yaml:"tls,omitempty" json:"tls,omitempty"`
	SkipCertVerify bool                   `yaml:"skip-cert-verify,omitempty" json:"skip-cert-verify,omitempty"`
	Host           string                 `yaml:"host,omitempty" json:"host,omitempty"`
	Path           string                 `yaml:"path,omitempty" json:"path,omitempty"`
	Mux            bool                   `yaml:"mux" json:"mux"`
	Headers        map[string]interface{} `yaml:"headers,omitempty" json:"headers,omitempty"`
}
type Group struct {
	// @description 线路名称
	Name string `yaml:"name" json:"name"`
	// @description 分组类型  relay 中继  select 手动选择 fallback 自动故障转移   url-test 自动选择最快  round-robin 自动轮询 load-balance 负载均衡 分组只显示select的
	Type string `yaml:"type" json:"type"`
	// @description 分组全部节点
	Proxies []string `yaml:"proxies" json:"proxies"`
	// @description 测试可用心的接口
	URL string `yaml:"url,omitempty" json:"url,omitempty"`
	// @description 批量检测完后切换节点所需的延迟差
	Interval interface{} `yaml:"interval,omitempty" json:"interval,omitempty"`
	// @description 接受的延迟容差
	Tolerance interface{} `yaml:"tolerance,omitempty" json:"tolerance,omitempty"`
}
