// ==========================================================================
// GFast自动生成业务逻辑层相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2024-10-11 16:02:19
// 生成路径: gfast/app/vpn/service/vpn_server_group.go
// 生成人：gfast
// ==========================================================================

package service

import (
	"context"
	"fmt"
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"
	"github.com/gogf/gf/database/gdb"
	"github.com/gogf/gf/errors/gerror"
	"github.com/gogf/gf/frame/g"
)

type vpnServerGroup struct {
}

var VpnServerGroup = new(vpnServerGroup)

// GetList 获取任务列表
func (s *vpnServerGroup) GetList(req *dao.VpnServerGroupSearchReq) (total, page int, list []*model.VpnServerGroup2, err error) {
	m := dao.VpnServerGroup.Ctx(req.Ctx)
	if req.ServerGroupId != "" {
		m = m.Where(dao.VpnServerGroup.Columns.ServerGroupId+" = ?", req.ServerGroupId)
	}
	if req.ServerGroupName != "" {
		m = m.Where(dao.VpnServerGroup.Columns.ServerGroupName+" like ?", "%"+req.ServerGroupName+"%")
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
	order := "servers asc"
	if req.OrderBy != "" {
		order = req.OrderBy
	}

	err = m.Page(page, req.PageSize).
		Fields(
			fmt.Sprintf("*,(SELECT count(1) FROM %s WHERE %s = %s.%s ) as servers",
				dao.VpnServer.Table,
				dao.VpnServer.Columns.ServerGroupId,
				dao.VpnServerGroup.Table,
				dao.VpnServerGroup.Columns.ServerGroupId,
			)).
		Order(order).
		Scan(&list)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("获取数据失败")
	}

	return
}

// GetInfoById 通过id获取
func (s *vpnServerGroup) GetInfoById(ctx context.Context, id int) (info *model.VpnServerGroup, err error) {
	if id == 0 {

		return
	}
	err = dao.VpnServerGroup.Ctx(ctx).Where(dao.VpnServerGroup.Columns.ServerGroupId, id).Scan(&info)
	if err != nil {
		g.Log().Error(err)
	}
	if info == nil || err != nil {
		err = gerror.New("获取信息失败")
	}
	return
}

// Add 添加
func (s *vpnServerGroup) Add(ctx context.Context, req *dao.VpnServerGroupAddReq) (err error) {
	_, err = dao.VpnServerGroup.Ctx(ctx).Insert(req)
	return
}

// Edit 修改
func (s *vpnServerGroup) Edit(ctx context.Context, req *dao.VpnServerGroupEditReq) error {
	_, err := dao.VpnServerGroup.Ctx(ctx).FieldsEx(dao.VpnServerGroup.Columns.ServerGroupId).Where(dao.VpnServerGroup.Columns.ServerGroupId, req.ServerGroupId).
		Update(req)
	return err
}

// DeleteByIds 删除
func (s *vpnServerGroup) DeleteByIds(ctx context.Context, ids []int) (err error) {
	if len(ids) == 0 {

		return
	}

	return dao.VpnServerGroup.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		_, err = tx.Model(dao.VpnServerGroup.Table).Delete(dao.VpnServerGroup.Columns.ServerGroupId+" in (?)", ids)
		if err != nil {
			g.Log().Error(err)
			err = gerror.New("删除失败")
			return err
		}

		var servers []*model.VpnServer
		err = dao.VpnServer.Ctx(ctx).Where(dao.VpnServer.Columns.ServerGroupId+" in (?)", ids).Scan(&servers)
		if err != nil {
			g.Log().Error(err)
			err = gerror.New("删除失败")
			return err
		}

		var serverIds []int
		for _, v := range servers {
			serverIds = append(serverIds, v.ServerId)
		}

		return VpnServer.DeleteByIds(ctx, serverIds)
	})

}
