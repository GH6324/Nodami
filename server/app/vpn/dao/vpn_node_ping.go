// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2024-10-14 16:40:33
// 生成路径: gfast/app/vpn/dao/vpn_node_ping.go
// 生成人：gfast
// ==========================================================================

package dao

import (
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao/internal"
)

// vpnNodePingDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnNodePingDao struct {
	*internal.VpnNodePingDao
}

var (
	// VpnNodePing is globally public accessible object for table tools_gen_table operations.
	VpnNodePing = vpnNodePingDao{
		internal.NewVpnNodePingDao(),
	}
)

// Fill with you ideas below.

// VpnNodePingSearchReq 分页请求参数
type VpnNodePingSearchReq struct {
	ServerId   string `p:"serverId"`   //服务器ID
	NationName string `p:"nationName"` //地区名称
	PingUrl    string `p:"pingUrl"`    //延迟测试URL
	SpeedUrl   string `p:"speedUrl"`   //测速URL
	GrpcPort   string `p:"grpcPort"`   //GrpcPort
	comModel.PageReq
}

// VpnNodePingAddReq 添加操作请求参数
type VpnNodePingAddReq struct {
	ServerId   int    `p:"serverId" v:"required#服务器ID不能为空"`
	NationName string `p:"nationName" v:"required#地区名称不能为空"`
	PingUrl    string `p:"pingUrl" v:"required#延迟测试URL不能为空"`
	SpeedUrl   string `p:"speedUrl" v:"required#测速URL不能为空"`
	//GrpcPort   int    `p:"grpcPort" v:"required#GrpcPort不能为空"`
}

// VpnNodePingEditReq 修改操作请求参数
type VpnNodePingEditReq struct {
	PingId     int    `p:"pingId" v:"required#主键ID不能为空"`
	ServerId   int    `p:"serverId" v:"required#服务器ID不能为空"`
	NationName string `p:"nationName" v:"required#地区名称不能为空"`
	PingUrl    string `p:"pingUrl" v:"required#延迟测试URL不能为空"`
	SpeedUrl   string `p:"speedUrl" v:"required#测速URL不能为空"`
	//GrpcPort   int    `p:"grpcPort" v:"required#GrpcPort不能为空"`
}
