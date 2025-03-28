// ==========================================================================
// GFast自动生成dao internal操作代码，无需手动修改，重新生成会自动覆盖.
// 生成日期：2025-03-28 13:34:00
// 生成路径: gfast/app/vpn/dao/internal/vpn_node_group.go
// 生成人：gfast
// ==========================================================================


package internal
import (
    "context"
    "github.com/gogf/gf/database/gdb"
    "github.com/gogf/gf/frame/g"
    "reflect"
)
// VpnNodeGroupDao is the manager for logic model data accessing and custom defined data operations functions management.
type VpnNodeGroupDao struct {
    Table   string         // Table is the underlying table name of the DAO.
    Group   string         // Group is the database configuration group name of current DAO.
    Columns VpnNodeGroupColumns // Columns is the short type for Columns, which contains all the column names of Table for convenient usage.
}
// VpnNodeGroupColumns defines and stores column names for table vpn_node_group.
type VpnNodeGroupColumns struct {    
    NodeGroupId  string  // ID    
    NodeGroupName  string  // 分组名    
}
var vpnNodeGroupColumns = VpnNodeGroupColumns{    
    NodeGroupId:  "node_group_id",    
    NodeGroupName:  "node_group_name",    
}
// NewVpnNodeGroupDao creates and returns a new DAO object for table data access.
func NewVpnNodeGroupDao() *VpnNodeGroupDao {
	return &VpnNodeGroupDao{
        Group:    "default",
        Table: "vpn_node_group",
        Columns:vpnNodeGroupColumns,
	}
}
func (dao *VpnNodeGroupDao) Fields(table,as bool, excludeFields ...string) []string {
	var result []string
	v := reflect.ValueOf(dao.Columns)
	for i := 0; i < v.NumField(); i++ {
		fieldValue := v.Field(i).String()
		if excludeFields != nil && dao.contains(excludeFields, fieldValue) {
			continue
		}
		field := "`" + fieldValue + "`"
		if table {
			field = 	dao.Table + "." + field
		}
		if as {
			field += " as " + fieldValue
		}
		result = append(result, field)
	}
	return result
}
func (dao *VpnNodeGroupDao) contains(slice []string, item string) bool {
	for _, a := range slice {
		if a == item || a == ("`"+item+"`") {
			return true
		}
	}
	return false
}
// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *VpnNodeGroupDao) DB() gdb.DB {
	return g.DB(dao.Group)
}
// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *VpnNodeGroupDao) Ctx(ctx context.Context) *gdb.Model {
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
func (dao *VpnNodeGroupDao) Transaction(ctx context.Context, f func(ctx context.Context, tx *gdb.TX) error) (err error) {
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
