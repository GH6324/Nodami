// ==========================================================================
// GFast自动生成dao internal操作代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2024-10-11 16:02:19
// 生成路径: gfast/app/vpn/dao/internal/vpn_server_group.go
// 生成人：gfast
// ==========================================================================

package internal

import (
	"context"
	"reflect"

	"github.com/gogf/gf/database/gdb"
	"github.com/gogf/gf/frame/g"
)

// VpnServerGroupDao is the manager for logic model data accessing and custom defined data operations functions management.
type VpnServerGroupDao struct {
	Table   string                // Table is the underlying table name of the DAO.
	Group   string                // Group is the database configuration group name of current DAO.
	Columns VpnServerGroupColumns // Columns is the short type for Columns, which contains all the column names of Table for convenient usage.
}

// VpnServerGroupColumns defines and stores column names for table vpn_server_group.
type VpnServerGroupColumns struct {
	ServerGroupId   string // ID
	ServerGroupName string // 分组名
}

var vpnServerGroupColumns = VpnServerGroupColumns{
	ServerGroupId:   "server_group_id",
	ServerGroupName: "server_group_name",
}

// NewVpnServerGroupDao creates and returns a new DAO object for table data access.
func NewVpnServerGroupDao() *VpnServerGroupDao {
	return &VpnServerGroupDao{
		Group:   "default",
		Table:   "vpn_server_group",
		Columns: vpnServerGroupColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *VpnServerGroupDao) DB() gdb.DB {
	return g.DB(dao.Group)
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *VpnServerGroupDao) Ctx(ctx context.Context) *gdb.Model {
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
func (dao *VpnServerGroupDao) Transaction(ctx context.Context, f func(ctx context.Context, tx *gdb.TX) error) (err error) {
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
func (dao *VpnServerGroupDao) Fields(table, as bool, excludeFields ...string) []string {

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

func (dao *VpnServerGroupDao) contains(slice []string, item string) bool {
	for _, a := range slice {
		if a == item || a == ("`"+item+"`") {
			return true
		}
	}
	return false
}
