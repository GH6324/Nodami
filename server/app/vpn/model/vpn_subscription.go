// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2025-03-28 13:06:30
// 生成路径: gfast/app/vpn/model/vpn_subscription.go
// 生成人：gfast
// ==========================================================================

package model

// VpnSubscription is the golang structure for table vpn_subscription.
type VpnSubscription struct {
	SubscriptionId int    `orm:"subscription_id,primary" json:"subscriptionId"` // 订阅ID
	Name           string `orm:"name" json:"name"`                              // 订阅名称
	NodeGroupIds   string `json:"nodeGroupIds" orm:"node_group_ids"`
	UUID           string `json:"uuid" orm:"uuid"`
}
