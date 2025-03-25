// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/model/vpn_node.go
// 生成人：gfast
// ==========================================================================

package model

// VpnNodeTransfer is the golang structure for table vpn_node.
type VpnNodeTransfer struct {
	TransferId       int    `json:"transferId" gorm:"column:transfer_id;primaryKey;autoIncrement"`
	NodeId           int    `json:"nodeId" gorm:"column:node_id"`
	EntranceServerId int    `json:"entranceServerId" gorm:"column:entrance_server_id"`
	EntranceServerIp string `json:"entranceServerIp" gorm:"column:entrance_server_ip"`
	ExitServerId     int    `json:"exitServerId" gorm:"column:exit_server_id"`
	ExitServerIp     string `json:"exitServerIp" gorm:"column:exit_server_ip"`
}
