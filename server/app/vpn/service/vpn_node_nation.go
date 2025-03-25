// ==========================================================================
// GFast自动生成业务逻辑层相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/service/vpn_node_nation.go
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

type vpnNodeNation struct {
}

var VpnNodeNation = new(vpnNodeNation)

// GetList 获取任务列表
func (s *vpnNodeNation) GetList(req *dao.VpnNodeNationSearchReq) (total, page int, list []*model.VpnNodeNation, err error) {
	m := dao.VpnNodeNation.Ctx(req.Ctx)
	if req.NationId != "" {
		m = m.Where(dao.VpnNodeNation.Columns.NationId+" = ?", req.NationId)
	}
	if req.NationName != "" {
		m = m.Where(dao.VpnNodeNation.Columns.NationName+" like ?", "%"+req.NationName+"%")
	}
	if req.NationImg != "" {
		m = m.Where(dao.VpnNodeNation.Columns.NationImg+" = ?", req.NationImg)
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
	order := "nation_id desc"
	if req.OrderBy != "" {
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
func (s *vpnNodeNation) GetInfoById(ctx context.Context, id int) (info *model.VpnNodeNation, err error) {
	if id == 0 {

		return
	}
	err = dao.VpnNodeNation.Ctx(ctx).Where(dao.VpnNodeNation.Columns.NationId, id).Scan(&info)
	if err != nil {
		g.Log().Error(err)
	}
	if info == nil || err != nil {
		err = gerror.New("获取信息失败")
	}
	return
}

// Add 添加
func (s *vpnNodeNation) Add(ctx context.Context, req *dao.VpnNodeNationAddReq) (err error) {
	_, err = dao.VpnNodeNation.Ctx(ctx).Insert(req)
	return
}

// Edit 修改
func (s *vpnNodeNation) Edit(ctx context.Context, req *dao.VpnNodeNationEditReq) error {
	_, err := dao.VpnNodeNation.Ctx(ctx).FieldsEx(dao.VpnNodeNation.Columns.NationId).Where(dao.VpnNodeNation.Columns.NationId, req.NationId).
		Update(req)
	return err
}

// DeleteByIds 删除
func (s *vpnNodeNation) DeleteByIds(ctx context.Context, ids []int) (err error) {
	if len(ids) == 0 {

		return
	}
	_, err = dao.VpnNodeNation.Ctx(ctx).Delete(dao.VpnNodeNation.Columns.NationId+" in (?)", ids)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("删除失败")
	}
	return
}
