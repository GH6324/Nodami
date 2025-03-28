// ==========================================================================
// GFast自动生成业务逻辑层相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2025-03-28 13:34:00
// 生成路径: gfast/app/vpn/service/vpn_node_group.go
// 生成人：gfast
// ==========================================================================


package service
import (
    "context"
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"	
	"github.com/gogf/gf/errors/gerror"
	"github.com/gogf/gf/frame/g"
)
type vpnNodeGroup struct {
}
var VpnNodeGroup = new(vpnNodeGroup)
// GetList 获取任务列表
func (s *vpnNodeGroup) GetList(req *dao.VpnNodeGroupSearchReq) (total, page int, list []*model.VpnNodeGroup, err error) {
	m := dao.VpnNodeGroup.Ctx(req.Ctx)     
        if req.NodeGroupId != "" {
            m = m.Where(dao.VpnNodeGroup.Columns.NodeGroupId+" = ?", req.NodeGroupId)
        }    
        if req.NodeGroupName != "" {
            m = m.Where(dao.VpnNodeGroup.Columns.NodeGroupName+" like ?", "%"+req.NodeGroupName+"%")
        }
	total, err = m.Count()
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("获取总行数失败")
		return
	}    
    if req.PageNum == 0 {
        req.PageNum = 1
    }
    page = req.PageNum
    if req.PageSize == 0 {
        req.PageSize = comModel.PageSize
    }
    order:= "node_group_id asc"
    if req.OrderBy!=""{
        order = req.OrderBy
    }
    err = m.Page(page, req.PageSize).Order(order).Scan(&list)    
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("获取数据失败")
	}
	return
}
// GetInfoById 通过id获取
func (s *vpnNodeGroup) GetInfoById(ctx context.Context,id int) (info *model.VpnNodeGroup, err error) {
	if id == 0 {
		err = gerror.New("参数错误")
		return
	}
	err = dao.VpnNodeGroup.Ctx(ctx).Where(dao.VpnNodeGroup.Columns.NodeGroupId, id).Scan(&info)
	if err != nil {
		g.Log().Error(err)
	}
	if info == nil || err != nil {
		err = gerror.New("获取信息失败")
	}
	return
}
// Add 添加
func (s *vpnNodeGroup) Add(ctx context.Context,req *dao.VpnNodeGroupAddReq) (err error) {
	_, err = dao.VpnNodeGroup.Ctx(ctx).Insert(req)
	return
}
// Edit 修改
func (s *vpnNodeGroup) Edit(ctx context.Context,req *dao.VpnNodeGroupEditReq) error {    
	_, err := dao.VpnNodeGroup.Ctx(ctx).FieldsEx(dao.VpnNodeGroup.Columns.NodeGroupId).Where(dao.VpnNodeGroup.Columns.NodeGroupId, req.NodeGroupId).
		Update(req)
	return err
}
// DeleteByIds 删除
func (s *vpnNodeGroup) DeleteByIds(ctx context.Context,ids []int) (err error) {
	if len(ids) == 0 {
		return
	}	
	_, err = dao.VpnNodeGroup.Ctx(ctx).Delete(dao.VpnNodeGroup.Columns.NodeGroupId+" in (?)", ids)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("删除失败")
	}
	return
}
