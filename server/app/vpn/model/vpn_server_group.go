// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2024-10-11 16:02:19
// 生成路径: gfast/app/vpn/model/vpn_server_group.go
// 生成人：gfast
// ==========================================================================

package model

// VpnServerGroup is the golang structure for table vpn_server_group.
type VpnServerGroup struct {
	ServerGroupId   int    `orm:"server_group_id,primary" json:"serverGroupId"` // ID
	ServerGroupName string `orm:"server_group_name" json:"serverGroupName"`     // 分组名
}
type VpnServerGroup2 struct {
	VpnServerGroup
	Servers int `orm:"servers" json:"servers"` // servers
}
