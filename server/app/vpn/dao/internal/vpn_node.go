// ==========================================================================
// GFast自动生成dao internal操作代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/dao/internal/vpn_node.go
// 生成人：gfast
// ==========================================================================

package internal

import (
	"context"
	"reflect"

	"github.com/gogf/gf/database/gdb"
	"github.com/gogf/gf/frame/g"
)

// VpnNodeDao is the manager for logic model data accessing and custom defined data operations functions management.
type VpnNodeDao struct {
	Table   string         // Table is the underlying table name of the DAO.
	Group   string         // Group is the database configuration group name of current DAO.
	Columns VpnNodeColumns // Columns is the short type for Columns, which contains all the column names of Table for convenient usage.
}

// VpnNodeColumns defines and stores column names for table vpn_node.
type VpnNodeColumns struct {
	NodeId                          string // 节点ID
	NationId                        string // 地区ID
	TransitPort                     string // 中转服务器端口
	TransitProtocol                 string // 中转服务协议
	Up                              string // 上行流量
	Down                            string // 下行流量
	OtuType                         string // 1默认IP 2指定IP 3指定节点ID
	OutIp                           string // 出口IP
	Protocol                        string // 协议
	VpnPort                         string // VPN 端口
	Ping                            string // ping 数据
	Method                          string // 加密方式
	FrpProtocol                     string // 内网穿透协议
	FrpPort                         string // 内网穿透端口
	FrpServerId                     string // 内网穿透服务器ID
	ServerId                        string // 服务器ID
	Other                           string // 注释
	CreatedAt                       string // 创建时间
	UpdatedAt                       string // 更新时间
	NodeGroupId                     string
	TransportProtocol               string
	StreamSettingsHost              string
	StreamSettingsPath              string
	StreamSettingsServiceName       string
	StreamSettingsReality           string
	StreamSettingsCongestionControl string
}

// 实例化表结构与字段的对应关系
var vpnNodeColumns = VpnNodeColumns{
	NodeId:                          "node_id",
	NationId:                        "nation_id",
	TransitPort:                     "transit_port",
	TransitProtocol:                 "transit_protocol",
	Up:                              "up",
	Down:                            "down",
	OtuType:                         "otu_type",
	OutIp:                           "out_ip",
	Protocol:                        "protocol",
	VpnPort:                         "vpn_port",
	Ping:                            "ping",
	Method:                          "method",
	FrpProtocol:                     "frp_protocol",
	FrpPort:                         "frp_port",
	FrpServerId:                     "frp_server_id",
	ServerId:                        "server_id",
	Other:                           "other",
	CreatedAt:                       "created_at",
	UpdatedAt:                       "updated_at",
	StreamSettingsHost:              "stream_settings_host",
	StreamSettingsPath:              "stream_settings_path",
	StreamSettingsServiceName:       "stream_settings_service_name",
	StreamSettingsReality:           "stream_settings_reality",
	StreamSettingsCongestionControl: "stream_settings_congestion_control",
	TransportProtocol:               "transport_protocol",
	NodeGroupId:                     "node_group_id",
}

// NewVpnNodeDao creates and returns a new DAO object for table data access.
func NewVpnNodeDao() *VpnNodeDao {
	return &VpnNodeDao{
		Group:   "default",
		Table:   "vpn_node",
		Columns: vpnNodeColumns,
	}
}

func (dao *VpnNodeDao) Fields(table, as bool, excludeFields ...string) []string {

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

func (dao *VpnNodeDao) contains(slice []string, item string) bool {
	for _, a := range slice {
		if a == item || a == ("`"+item+"`") {
			return true
		}
	}
	return false
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *VpnNodeDao) DB() gdb.DB {
	return g.DB(dao.Group)
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *VpnNodeDao) Ctx(ctx context.Context) *gdb.Model {
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
func (dao *VpnNodeDao) Transaction(ctx context.Context, f func(ctx context.Context, tx *gdb.TX) error) (err error) {
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
