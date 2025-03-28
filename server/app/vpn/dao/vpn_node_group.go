// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2025-03-28 13:34:00
// 生成路径: gfast/app/vpn/dao/vpn_node_group.go
// 生成人：gfast
// ==========================================================================


package dao
import (
    comModel "gfast/app/common/model"
    "gfast/app/vpn/dao/internal"    
)
// vpnNodeGroupDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnNodeGroupDao struct {
	*internal.VpnNodeGroupDao
}
var (
    // VpnNodeGroup is globally public accessible object for table tools_gen_table operations.
    VpnNodeGroup = vpnNodeGroupDao{
        internal.NewVpnNodeGroupDao(),
    }
)


// Fill with you ideas below.


// VpnNodeGroupSearchReq 分页请求参数
type VpnNodeGroupSearchReq struct {    
    NodeGroupId  string `p:"nodeGroupId"` //ID    
    NodeGroupName  string `p:"nodeGroupName"` //分组名    
    comModel.PageReq
}
// VpnNodeGroupAddReq 添加操作请求参数
type VpnNodeGroupAddReq struct {    
    NodeGroupName  string   `p:"nodeGroupName" v:"required#分组名不能为空"`    
}
// VpnNodeGroupEditReq 修改操作请求参数
type VpnNodeGroupEditReq struct {
    NodeGroupId    int  `p:"nodeGroupId" v:"required#主键ID不能为空"`    
    NodeGroupName  string `p:"nodeGroupName" v:"required#分组名不能为空"`    
}
