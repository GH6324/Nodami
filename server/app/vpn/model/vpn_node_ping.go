// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2024-10-14 16:40:33
// 生成路径: gfast/app/vpn/model/vpn_node_ping.go
// 生成人：gfast
// ==========================================================================

package model

// VpnNodePing is the golang structure for table vpn_node_ping.
type VpnNodePing struct {
	PingId     int    `orm:"ping_id,primary" json:"pingId"` // ID
	ServerId   int    `orm:"server_id" json:"serverId"`     // 服务器ID
	NationName string `orm:"nation_name" json:"nationName"` // 地区名称
	PingUrl    string `orm:"ping_url" json:"pingUrl"`       // 延迟测试URL
	SpeedUrl   string `orm:"speed_url" json:"speedUrl"`     // 测速URL
}

type VpnNodePing2 struct {
	VpnNodePing
	ServerIp string `orm:"server_ip" json:"serverIp"`
}
