// ==========================================================================
// GFast自动生成model代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/model/vpn_server.go
// 生成人：gfast
// ==========================================================================

package model

import "github.com/gogf/gf/os/gtime"

// VpnServer is the golang structure for table vpn_server.
type VpnServer struct {
	ServerId           int         `orm:"server_id,primary" json:"serverId"`               // id
	ServerName         string      `orm:"server_name" json:"serverName"`                   // 服务器名称
	ServerIp           string      `orm:"server_ip" json:"serverIp"`                       // 服务器IP
	ServerSshProt      int         `orm:"server_ssh_prot" json:"serverSshProt"`            // 服务器ssh端口
	ServerSshUser      string      `orm:"server_ssh_user" json:"serverSshUser"`            // 用户名
	ServerSshPasswrod  string      `orm:"server_ssh_passwrod" json:"serverSshPasswrod"`    // 服务器ssh密码
	ServerSshPublicKey string      `orm:"server_ssh_public_key" json:"serverSshPublicKey"` // 服务器ssh秘钥
	ServerSshLoginType string      `orm:"server_ssh_login_type" json:"serverSshLoginType"` // 登录方式
	Status             int         `orm:"status" json:"status"`                            // 状态
	Up                 int         `orm:"up" json:"up"`                                    // 上行流量 kb
	Down               int         `orm:"down" json:"down"`                                // 下行流量 kb
	Other              string      `orm:"other" json:"other"`                              // 注释
	IsPppoe            int         `orm:"is_pppoe" json:"isPppoe"`
	PppoeRestart       int         `orm:"pppoe_restart" json:"pppoeRestart"`
	PppoeHour          int         `orm:"pppoe_hour" json:"pppoeHour"`
	PppoeCycle         int         `orm:"pppoe_cycle" json:"pppoeCycle"`
	PppoeRetime        *gtime.Time `orm:"pppoe_retime" json:"pppoeRetime"`
	RealUp             int         `orm:"real_up" json:"realUp"`     // 实时上行流量 kb
	RealDown           int         `orm:"real_down" json:"realDown"` // 实时下行流量 kb
	RealCPU            float64     `orm:"real_cpu" json:"realCpu"`
	RealDisk           float64     `orm:"real_disk" json:"realDisk"`
	RealMem            float64     `orm:"real_mem" json:"realMem"`
	ServerDns          string      `orm:"server_dns" json:"serverDns"`
	ProxyAddr          string      `orm:"proxy_addr" json:"proxyAddr"`
	ServerGroupId      int         `orm:"server_group_id" json:"serverGroupId"`
	CreatedAt          *gtime.Time `orm:"created_at" json:"createdAt"` // 创建时间
	UpdatedAt          *gtime.Time `orm:"updated_at" json:"updatedAt"` // 更新时间
}

type VpnServer2 struct {
	VpnServer
	Nodes           int    `orm:"nodes" json:"nodes"`
	ServerGroupName string `orm:"server_group_name" json:"serverGroupName"`
}
