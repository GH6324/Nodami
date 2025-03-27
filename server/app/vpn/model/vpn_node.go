// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/model/vpn_node.go
// 生成人：gfast
// ==========================================================================

package model

import "github.com/gogf/gf/os/gtime"

// VpnNode is the golang structure for table vpn_node.
type VpnNode struct {
	NodeId                    int         `json:"nodeId" gorm:"column:node_id;primaryKey;autoIncrement"` // 节点 ID (主键)
	NationId                  int         `json:"nationId" gorm:"column:nation_id"`                      // 地区 ID
	TransitPort               int         `json:"transitPort" gorm:"column:transit_port"`                // 中转服务器端口
	TransitProtocol           string      `json:"transitProtocol" gorm:"column:transit_protocol"`        // 中转服务协议
	Up                        int64       `json:"up" gorm:"column:up"`                                   // 上行流量
	Down                      int64       `json:"down"     gorm:"column:down"`                           // 下行流量
	OtuType                   int         `json:"otuType"   gorm:"column:otu_type"`                      // 1默认IP 2指定IP 3指定节点ID
	OutIp                     string      `json:"outIp"   gorm:"column:otu_ip"`
	Protocol                  string      `json:"protocol" gorm:"column:protocol"`                                      // 协议
	VpnPort                   int         `json:"vpnPort" gorm:"column:vpn_port"`                                       // VPN 端口
	Ping                      string      `json:"ping" gorm:"column:ping"`                                              // ping
	Method                    string      `json:"method" gorm:"column:method"`                                          // 加密方式
	FrpProtocol               string      `json:"frpProtocol" gorm:"column:frp_protocol"`                               // 内网穿透协议
	FrpPort                   int         `json:"frpPort" gorm:"column:frp_port"`                                       // 内网穿透端口
	FrpServerId               int         `json:"frpServerId" gorm:"column:frp_server_id"`                              // 内网穿透服务器 ID
	ServerId                  int         `json:"serverId" gorm:"column:server_id"`                                     // 服务器 ID
	Other                     string      `json:"other" gorm:"column:other"`                                            //
	CreatedAt                 *gtime.Time `json:"createdAt" gorm:"column:created_at"`                                   // 创建时间
	UpdatedAt                 *gtime.Time `json:"updatedAt" gorm:"column:updated_at"`                                   // 更新时间
	TransportProtocol         string      `json:"transportProtocol" gorm:"column:transport_protocol"`                   //
	StreamSettingsHost        string      `json:"streamSettingsHost" gorm:"column:stream_settings_host"`                //
	StreamSettingsPath        string      `json:"streamSettingsPath" gorm:"column:stream_settings_path"`                //
	StreamSettingsServiceName string      `json:"streamSettingsServiceName" gorm:"column:stream_settings_service_name"` //
	StreamSettingsReality     int         `json:"streamSettingsReality" gorm:"column:stream_settings_reality"`          //
}

type VpnNodeInfo struct {
	VpnNode
	VpnNodeNation
	ServerId    int               `json:"serverId" gorm:"column:server_id"`
	NationId    int               `json:"nationId" gorm:"column:nation_id"`
	Other       string            `json:"other" gorm:"column:other"`
	ServerName  string            `orm:"server_name" json:"serverName"`
	ServerIp    string            `orm:"server_ip" json:"serverIp"`
	Transfers   []VpnNodeTransfer `json:"transfers"`
	NationName  string            `json:"nationName"`
	FrpServerIp string            `json:"frpServerIp"`
}

type PingInfo struct {
	NationName string `json:"nationName"`
	Ping       int    `json:"ping"`
	PingId     int    `json:"pingId"`
}

type SpeedInfo struct {
	NationName string `json:"nationName"`
	Speed      string `json:"speed"`
	SpeedFlow  int    `json:"speedFlow"`
	PingId     int    `json:"pingId"`
}
