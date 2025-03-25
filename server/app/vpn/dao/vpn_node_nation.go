// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/dao/vpn_node_nation.go
// 生成人：gfast
// ==========================================================================

package dao

import (
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao/internal"
)

// vpnNodeNationDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnNodeNationDao struct {
	*internal.VpnNodeNationDao
}

var (
	// VpnNodeNation is globally public accessible object for table tools_gen_table operations.
	VpnNodeNation = vpnNodeNationDao{
		internal.NewVpnNodeNationDao(),
	}
)

// Fill with you ideas below.

// VpnNodeNationSearchReq 分页请求参数
type VpnNodeNationSearchReq struct {
	NationId   string `p:"nationId"`   //id
	NationName string `p:"nationName"` //国家名称
	NationImg  string `p:"nationImg"`  //Icon
	comModel.PageReq
}

// VpnNodeNationAddReq 添加操作请求参数
type VpnNodeNationAddReq struct {
	NationName string `p:"nationName" v:"required#国家名称不能为空"`
	NationImg  string `p:"nationImg" `
}

// VpnNodeNationEditReq 修改操作请求参数
type VpnNodeNationEditReq struct {
	NationId   int    `p:"nationId" v:"required#主键ID不能为空"`
	NationName string `p:"nationName" v:"required#国家名称不能为空"`
	NationImg  string `p:"nationImg" `
}
