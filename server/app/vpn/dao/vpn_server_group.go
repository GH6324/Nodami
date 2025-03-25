// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2024-10-11 16:02:19
// 生成路径: gfast/app/vpn/dao/vpn_server_group.go
// 生成人：gfast
// ==========================================================================

package dao

import (
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao/internal"
)

// vpnServerGroupDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnServerGroupDao struct {
	*internal.VpnServerGroupDao
}

var (
	// VpnServerGroup is globally public accessible object for table tools_gen_table operations.
	VpnServerGroup = vpnServerGroupDao{
		internal.NewVpnServerGroupDao(),
	}
)

// Fill with you ideas below.

// VpnServerGroupSearchReq 分页请求参数
type VpnServerGroupSearchReq struct {
	ServerGroupId   string `p:"serverGroupId"`   //ID
	ServerGroupName string `p:"serverGroupName"` //分组名
	comModel.PageReq
}

// VpnServerGroupAddReq 添加操作请求参数
type VpnServerGroupAddReq struct {
	ServerGroupName string `p:"serverGroupName" v:"required#分组名不能为空"`
}

// VpnServerGroupEditReq 修改操作请求参数
type VpnServerGroupEditReq struct {
	ServerGroupId   int    `p:"serverGroupId" v:"required#主键ID不能为空"`
	ServerGroupName string `p:"serverGroupName" v:"required#分组名不能为空"`
}
