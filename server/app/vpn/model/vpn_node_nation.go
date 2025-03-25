// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/model/vpn_node_nation.go
// 生成人：gfast
// ==========================================================================

package model

// VpnNodeNation is the golang structure for table vpn_node_nation.
type VpnNodeNation struct {
	NationId   int    `orm:"nation_id,primary" json:"nationId"` // id
	NationName string `orm:"nation_name" json:"nationName"`     // 国家名称
	NationImg  string `orm:"nation_img" json:"nationImg"`       // Icon
}
