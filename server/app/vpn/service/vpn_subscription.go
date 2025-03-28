// ==========================================================================
// GFast自动生成业务逻辑层相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2025-03-28 13:06:30
// 生成路径: gfast/app/vpn/service/vpn_subscription.go
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
	"github.com/google/uuid"
)

type vpnSubscription struct {
}

var VpnSubscription = new(vpnSubscription)

// GetList 获取任务列表
func (s *vpnSubscription) GetList(req *dao.VpnSubscriptionSearchReq) (total, page int, list []*model.VpnSubscription, err error) {
	m := dao.VpnSubscription.Ctx(req.Ctx)
	if req.SubscriptionId != "" {
		m = m.Where(dao.VpnSubscription.Columns.SubscriptionId+" = ?", req.SubscriptionId)
	}
	if req.Name != "" {
		m = m.Where(dao.VpnSubscription.Columns.Name+" like ?", "%"+req.Name+"%")
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
	order := "subscription_id asc"
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
func (s *vpnSubscription) GetInfoById(ctx context.Context, id int) (info *model.VpnSubscription, err error) {
	if id == 0 {
		err = gerror.New("参数错误")
		return
	}
	err = dao.VpnSubscription.Ctx(ctx).Where(dao.VpnSubscription.Columns.SubscriptionId, id).Scan(&info)
	if err != nil {
		g.Log().Error(err)
	}
	if info == nil || err != nil {
		err = gerror.New("获取信息失败")
	}
	return
}

// Add 添加
func (s *vpnSubscription) Add(ctx context.Context, req *dao.VpnSubscriptionAddReq) (err error) {
	UUID, _ := uuid.NewUUID()
	req.UUID = UUID.String()
	_, err = dao.VpnSubscription.Ctx(ctx).Insert(req)
	return
}

// Edit 修改
func (s *vpnSubscription) Edit(ctx context.Context, req *dao.VpnSubscriptionEditReq) error {
	_, err := dao.VpnSubscription.Ctx(ctx).FieldsEx(dao.VpnSubscription.Columns.SubscriptionId, dao.VpnSubscription.Columns.UUID).Where(dao.VpnSubscription.Columns.SubscriptionId, req.SubscriptionId).
		Update(req)
	return err
}

// DeleteByIds 删除
func (s *vpnSubscription) DeleteByIds(ctx context.Context, ids []int) (err error) {
	if len(ids) == 0 {
		return
	}
	_, err = dao.VpnSubscription.Ctx(ctx).Delete(dao.VpnSubscription.Columns.SubscriptionId+" in (?)", ids)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("删除失败")
	}
	return
}
