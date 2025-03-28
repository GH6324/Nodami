// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2025-03-28 13:34:00
// 生成路径: gfast/app/vpn/model/vpn_node_group.go
// 生成人：gfast
// ==========================================================================


package model
// VpnNodeGroup is the golang structure for table vpn_node_group.
type VpnNodeGroup struct {	
         NodeGroupId       int         `orm:"node_group_id,primary" json:"nodeGroupId"`    // ID    
         NodeGroupName    string         `orm:"node_group_name" json:"nodeGroupName"`    // 分组名    
}