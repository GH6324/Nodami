// ==========================================================================
// GFast自动生成业务逻辑层相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2024-10-14 16:40:33
// 生成路径: gfast/app/vpn/service/vpn_node_ping.go
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

type vpnNodePing struct {
}

var VpnNodePing = new(vpnNodePing)

// GetList 获取任务列表
func (s *vpnNodePing) GetList(req *dao.VpnNodePingSearchReq) (total, page int, list []*model.VpnNodePing, err error) {
	m := dao.VpnNodePing.Ctx(req.Ctx)
	if req.ServerId != "" {
		m = m.Where(dao.VpnNodePing.Columns.ServerId+" = ?", req.ServerId)
	}
	if req.NationName != "" {
		m = m.Where(dao.VpnNodePing.Columns.NationName+" like ?", "%"+req.NationName+"%")
	}
	if req.PingUrl != "" {
		m = m.Where(dao.VpnNodePing.Columns.PingUrl+" = ?", req.PingUrl)
	}
	if req.SpeedUrl != "" {
		m = m.Where(dao.VpnNodePing.Columns.SpeedUrl+" = ?", req.SpeedUrl)
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
	order := "ping_id asc"
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
func (s *vpnNodePing) GetInfoById(ctx context.Context, id int) (info *model.VpnNodePing, err error) {
	if id == 0 {
		err = gerror.New("参数错误")
		return
	}
	err = dao.VpnNodePing.Ctx(ctx).Where(dao.VpnNodePing.Columns.PingId, id).Scan(&info)
	if err != nil {
		g.Log().Error(err)
	}
	if info == nil || err != nil {
		err = gerror.New("获取信息失败")
	}
	return
}

// Add 添加
func (s *vpnNodePing) Add(ctx context.Context, req *dao.VpnNodePingAddReq) (err error) {
	_, err = dao.VpnNodePing.Ctx(ctx).Insert(req)
	return
}

// Edit 修改
func (s *vpnNodePing) Edit(ctx context.Context, req *dao.VpnNodePingEditReq) error {
	_, err := dao.VpnNodePing.Ctx(ctx).FieldsEx(dao.VpnNodePing.Columns.PingId).Where(dao.VpnNodePing.Columns.PingId, req.PingId).
		Update(req)
	return err
}

// DeleteByIds 删除
func (s *vpnNodePing) DeleteByIds(ctx context.Context, ids []int) (err error) {
	if len(ids) == 0 {
		return
	}
	_, err = dao.VpnNodePing.Ctx(ctx).Delete(dao.VpnNodePing.Columns.PingId+" in (?)", ids)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("删除失败")
	}
	return
}
