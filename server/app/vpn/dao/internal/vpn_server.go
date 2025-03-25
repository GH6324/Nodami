// ==========================================================================
// GFast自动生成dao internal操作代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/dao/internal/vpn_server.go
// 生成人：gfast
// ==========================================================================

package internal

import (
	"context"
	"reflect"

	"github.com/gogf/gf/database/gdb"
	"github.com/gogf/gf/frame/g"
)

// VpnServerDao is the manager for logic model data accessing and custom defined data operations functions management.
type VpnServerDao struct {
	Table   string           // Table is the underlying table name of the DAO.
	Group   string           // Group is the database configuration group name of current DAO.
	Columns VpnServerColumns // Columns is the short type for Columns, which contains all the column names of Table for convenient usage.
}

// VpnServerColumns defines and stores column names for table vpn_server.

type VpnServerColumns struct {
	ServerId           string // 服务器ID
	ServerName         string // 服务器名称
	ServerIp           string // 服务器IP
	ServerGroupId      string // 分组
	ServerSshProt      string // 服务器SSH端口
	ServerSshUser      string // 服务器SSH用户名
	ServerSshPassword  string // 服务器SSH密码
	ServerSshPublicKey string // 服务器SSH秘钥
	ServerSshLoginType string // 登录方式 password ro public_key
	Status             string // 状态 (-1离线 1在线)
	Up                 string // 上行流量 (字节)
	Down               string // 下行流量 (字节)
	Other              string // 注释
	IsPppoe            string // 是否是拨号服务器
	PppoeRestart       string // 是否定时重拨
	PppoeHour          string // 几点钟重拨
	PppoeCycle         string // 间隔周期 (单位天)
	PppoeRetime        string // 上次重启时间
	RealUp             string // 实时上行流量
	RealDown           string // 实时下行流量
	RealCpu            string // 实时CPU使用率 (浮点数，2位小数)
	RealDisk           string // 实时磁盘使用率 (浮点数，2位小数)
	RealMem            string // 实时内存使用率 (浮点数，2位小数)
	ProxyAddr          string // SSH代理
	UpdatedAt          string // 更新时间
	CreatedAt          string // 创建时间
}

// 实例化表结构与字段的对应关系
var vpnServerColumns = VpnServerColumns{
	ServerId:           "server_id",
	ServerName:         "server_name",
	ServerIp:           "server_ip",
	ServerGroupId:      "server_group_id",
	ServerSshProt:      "server_ssh_prot",
	ServerSshUser:      "server_ssh_user",
	ServerSshPassword:  "server_ssh_passwrod",
	ServerSshPublicKey: "server_ssh_public_key",
	ServerSshLoginType: "server_ssh_login_type",
	Status:             "status",
	Up:                 "up",
	Down:               "down",
	Other:              "other",
	IsPppoe:            "is_pppoe",
	PppoeRestart:       "pppoe_restart",
	PppoeHour:          "pppoe_hour",
	PppoeCycle:         "pppoe_cycle",
	PppoeRetime:        "pppoe_retime",
	RealUp:             "real_up",
	RealDown:           "real_down",
	RealCpu:            "real_cpu",
	RealDisk:           "real_disk",
	RealMem:            "real_mem",
	ProxyAddr:          "proxy_addr",
	UpdatedAt:          "updated_at",
	CreatedAt:          "created_at",
}

// NewVpnServerDao creates and returns a new DAO object for table data access.
func NewVpnServerDao() *VpnServerDao {
	return &VpnServerDao{
		Group:   "default",
		Table:   "vpn_server",
		Columns: vpnServerColumns,
	}
}

func (dao *VpnServerDao) Fields(table, as bool, excludeFields ...string) []string {

	var result []string
	v := reflect.ValueOf(dao.Columns)
	for i := 0; i < v.NumField(); i++ {
		fieldValue := v.Field(i).String()
		if excludeFields != nil && dao.contains(excludeFields, fieldValue) {
			continue
		}
		field := "`" + fieldValue + "`"
		if table {
			field = dao.Table + "." + field
		}
		if as {
			field += " as " + fieldValue
		}
		result = append(result, field)
	}

	return result
}

func (dao *VpnServerDao) contains(slice []string, item string) bool {
	for _, a := range slice {
		if a == item || a == ("`"+item+"`") {
			return true
		}
	}
	return false
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *VpnServerDao) DB() gdb.DB {
	return g.DB(dao.Group)
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *VpnServerDao) Ctx(ctx context.Context) *gdb.Model {
	tx, ok := ctx.Value("txKey").(*gdb.TX)
	if ok {
		return tx.Model(dao.Table).Safe().Ctx(ctx)
	}
	return dao.DB().Model(dao.Table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *VpnServerDao) Transaction(ctx context.Context, f func(ctx context.Context, tx *gdb.TX) error) (err error) {
	if ctx != nil {
		tx, ok := ctx.Value("txKey").(*gdb.TX)
		if ok {
			return f(ctx, tx)
		}
	}
	return dao.Ctx(ctx).Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		ctx = context.WithValue(ctx, "txKey", tx)
		return f(ctx, tx)
	})
}
