// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/dao/vpn_node.go
// 生成人：gfast
// ==========================================================================

package dao

import (
	"gfast/app/vpn/dao/internal"
)

// vpnNodeTransferDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnNodeTransferDao struct {
	*internal.VpnNodeTransferDao
}

var (
	// VpnNodeTransferDao is globally public accessible object for table tools_gen_table operations.
	VpnNodeTransfer = vpnNodeTransferDao{
		internal.NewVpnNodeTransferDao(),
	}
)
