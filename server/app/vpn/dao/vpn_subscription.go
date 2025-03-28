// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2025-03-28 13:06:30
// 生成路径: gfast/app/vpn/dao/vpn_subscription.go
// 生成人：gfast
// ==========================================================================

package dao

import (
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao/internal"
)

// vpnSubscriptionDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnSubscriptionDao struct {
	*internal.VpnSubscriptionDao
}

var (
	// VpnSubscription is globally public accessible object for table tools_gen_table operations.
	VpnSubscription = vpnSubscriptionDao{
		internal.NewVpnSubscriptionDao(),
	}
)

// Fill with you ideas below.

// VpnSubscriptionSearchReq 分页请求参数
type VpnSubscriptionSearchReq struct {
	SubscriptionId string `p:"subscriptionId"` //订阅ID
	Name           string `p:"name"`           //订阅名称
	comModel.PageReq
}

// VpnSubscriptionAddReq 添加操作请求参数
type VpnSubscriptionAddReq struct {
	Name         string      `p:"name" v:"required#订阅名称不能为空"`
	NodeGroupIds interface{} `p:"nodeGroupIds" v:"required#订阅节点分组不能空"`
	UUID         string
}

// VpnSubscriptionEditReq 修改操作请求参数
type VpnSubscriptionEditReq struct {
	SubscriptionId int         `p:"subscriptionId" v:"required#主键ID不能为空"`
	Name           string      `p:"name" v:"required#订阅名称不能为空"`
	NodeGroupIds   interface{} `p:"nodeGroupIds" v:"required#订阅节点分组不能空"`
}
