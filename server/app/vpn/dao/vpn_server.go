// ==========================================================================
// GFast自动生成dao操作代码，无需手动修改，重新生成不会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/dao/vpn_server.go
// 生成人：gfast
// ==========================================================================

package dao

import (
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao/internal"
	"github.com/gogf/gf/os/gtime"
)

// vpnServerDao is the manager for logic model data accessing and custom defined data operations functions management.
// You can define custom methods on it to extend its functionality as you wish.
type vpnServerDao struct {
	*internal.VpnServerDao
}

var (
	// VpnServer is globally public accessible object for table tools_gen_table operations.
	VpnServer = vpnServerDao{
		internal.NewVpnServerDao(),
	}
)

// Fill with you ideas below.

// VpnServerSearchReq 分页请求参数
type VpnServerSearchReq struct {
	ServerId           string `p:"serverId"`           //id
	ServerName         string `p:"serverName"`         //服务器名称
	ServerIp           string `p:"serverIp"`           //服务器IP
	ServerSshProt      string `p:"serverSshProt"`      //服务器ssh端口
	ServerSshUser      string `p:"serverSshUser"`      //用户名
	ServerSshPasswrod  string `p:"serverSshPasswrod"`  //服务器ssh密码
	ServerSshPublicKey string `p:"serverSshPublicKey"` //服务器ssh秘钥
	ServerSshLoginType string `p:"serverSshLoginType"` //登录方式
	ServerGroupId      string `p:"serverGroupId"`
	IsPppoe            string `p:"isPppoe"`
	Status             string `p:"status"`       //状态
	Other              string `p:"other"`        //注释
	AbnormalLoad       bool   `p:"abnormalLoad"` //负载异常
	comModel.PageReq
}

// VpnServerAdds 添加操作请求参数
type VpnServerAdds struct {
	ServerName         string `p:"serverName" `
	ServerIp           string `p:"serverIp" `
	ServerAddress      string `p:"serverAddress"`
	ServerSshProt      int    `p:"serverSshProt" `
	ServerSshUser      string `p:"serverSshUser" `
	ServerSshPasswrod  string `p:"serverSshPasswrod" `
	ServerSshPublicKey string `p:"serverSshPublicKey" `
	ServerSshLoginType string `p:"serverSshLoginType"`
}

// VpnServerAddReq 添加操作请求参数
type VpnServerAddReq struct {
	VpnServerAddReqs   []*VpnServerAdds `p:"serverAdds"`
	ServerGroupId      int              `p:"serverGroupId" v:"required#服务器分组不能空"`
	ServerName         string           `p:"serverName"`
	ServerIp           string           `p:"serverIp"`
	ServerSshProt      int              `p:"serverSshProt"`
	ServerSshUser      string           `p:"serverSshUser"`
	ServerSshPasswrod  string           `p:"serverSshPasswrod" `
	ServerSshPublicKey string           `p:"serverSshPublicKey" `
	ServerSshLoginType string           `p:"serverSshLoginType"`
	Up                 int
	Down               int
	Other              string `p:"other" `
	IsPppoe            int    `p:"isPppoe"`
	PppoeRestart       int    `p:"pppoeRestart"`
	PppoeHour          int    `p:"pppoeHour"`
	PppoeRetime        *gtime.Time
	Status             int
	PppoeCycle         int    `p:"pppoeCycle"`
	ProxyAddr          string `p:"proxyAddr"`
}

// VpnServerEditReq 修改操作请求参数
type VpnServerEditReq struct {
	ServerId           int    `p:"serverId" v:"required#主键ID不能为空"`
	ServerName         string `p:"serverName" v:"required#服务器名称不能为空"`
	ServiceMerchantsId int    `p:"serviceMerchantsId"`
	ServerGroupId      int    `p:"serverGroupId" v:"required#服务器分组不能空"`
	ServerIp           string `p:"serverIp" v:"required#服务器IP不能为空"`
	ServerSshProt      int    `p:"serverSshProt" v:"required#服务器ssh端口不能为空"`
	ServerSshUser      string `p:"serverSshUser" v:"required#用户名不能为空"`
	ServerSshPasswrod  string `p:"serverSshPasswrod" `
	ServerSshPublicKey string `p:"serverSshPublicKey" `
	ServerSshLoginType string `p:"serverSshLoginType" v:"required#登录方式不能为空"`
	Other              string `p:"other" `
	IsPppoe            int    `p:"isPppoe"`
	PppoeRestart       int    `p:"pppoeRestart"`
	PppoeHour          int    `p:"pppoeHour"`
	PppoeCycle         int    `p:"pppoeCycle"`
	ProxyAddr          string `p:"proxyAddr"`
}

// VpnServerEditsReq 修改操作请求参数
type VpnServerEditsReq struct {
	ServerIds     []int  `p:"serverIds" v:"required#主键ID不能为空"`
	IsPppoe       int    `p:"isPppoe"`
	PppoeRestart  int    `p:"pppoeRestart"`
	PppoeHour     int    `p:"pppoeHour"`
	PppoeCycle    int    `p:"pppoeCycle"`
	ProxyAddr     string `p:"proxyAddr"`
	ServerGroupId int    `p:"serverGroupId"`
}

// VpnServerStatusReq 设置用户状态参数
type VpnServerStatusReq struct {
	ServerId int `p:"serverId" v:"required#主键ID不能为空"`
	Status   int `p:"status" v:"required#状态不能为空"`
}
