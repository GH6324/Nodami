// ==========================================================================
// GFast自动生成业务逻辑层相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/service/vpn_server.go
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
	"github.com/gogf/gf/os/gtime"
	"strings"

	"github.com/gogf/gf/errors/gerror"
	"github.com/gogf/gf/frame/g"
	"time"
)

type vpnServer struct {
}

var VpnServer = new(vpnServer)

func (s *vpnServer) CountByStatus(ctx context.Context, status int) (int, error) {
	m := dao.VpnServer.Ctx(ctx).Where("status=?", status)
	count, err := m.Count()
	if err != nil {
		return 0, err
	}
	return count, nil
}

// GetList 获取任务列表
func (s *vpnServer) GetList(req *dao.VpnServerSearchReq) (total, page int, list []*model.VpnServer2, err error) {
	m := dao.VpnServer.Ctx(req.Ctx).
		LeftJoin(dao.VpnServerGroup.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnServerGroup.Table, dao.VpnServerGroup.Columns.ServerGroupId, dao.VpnServer.Table, dao.VpnServer.Columns.ServerGroupId))

	if req.ServerId != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerId+" = ?", req.ServerId)
	}
	if req.IsPppoe != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.IsPppoe+" = ?", req.IsPppoe)
	}
	if req.ServerName != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerName+" like ?", "%"+req.ServerName+"%")
	}
	if req.ServerIp != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerIp+" like ?", "%"+req.ServerIp+"%")
	}
	if req.ServerSshProt != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerSshProt+" = ?", req.ServerSshProt)
	}
	if req.ServerSshUser != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerSshUser+" = ?", req.ServerSshUser)
	}
	if req.ServerSshPasswrod != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerSshPassword+" = ?", req.ServerSshPasswrod)
	}
	if req.ServerSshPublicKey != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerSshPublicKey+" = ?", req.ServerSshPublicKey)
	}
	if req.ServerSshLoginType != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerSshLoginType+" = ?", req.ServerSshLoginType)
	}

	if req.Other != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.Other+" = ?", req.Other)
	}

	if req.AbnormalLoad {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.RealCpu+"> ? or "+dao.VpnServer.Table+"."+dao.VpnServer.Columns.RealDisk+"> ? or "+dao.VpnServer.Table+"."+dao.VpnServer.Columns.RealMem+"> ?", 80, 80, 80)
	}
	if req.ServerGroupId != "" {
		m = m.Where(dao.VpnServer.Table+"."+dao.VpnServer.Columns.ServerGroupId+" = ?", req.ServerGroupId)
	}

	if req.Search != "" {
		m = m.Where(fmt.Sprintf("%s.%s = ? or %s.%s like ? or %s.%s like ? or %s.%s like ? or %s.%s like ? or %s.%s like ?",
			dao.VpnServer.Table,
			dao.VpnServer.Columns.ServerId,
			dao.VpnServer.Table,
			dao.VpnServer.Columns.ServerIp,
			dao.VpnServer.Table,
			dao.VpnServer.Columns.ServerName,
			dao.VpnServer.Table,
			dao.VpnServer.Columns.Other,
			dao.VpnNodeNation.Table,
			dao.VpnNodeNation.Columns.NationName,
			dao.VpnServerGroup.Table,
			dao.VpnServerGroup.Columns.ServerGroupName,
		), req.Search, "%"+req.Search+"%", "%"+req.Search+"%", "%"+req.Search+"%", "%"+req.Search+"%", "%"+req.Search+"%")
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
	order := dao.VpnServer.Table + "." + "server_id desc"
	if req.OrderBy != "" {
		order = req.OrderBy
		if !strings.Contains(order, "server_id") {
			order += "," + dao.VpnServer.Table + "." + "server_id desc"
		}
	}

	m = m.Fields(
		fmt.Sprintf("%s.*,(SELECT count(1) FROM %s WHERE %s = %s.%s OR %s = %s.%s OR  (%s.%s in (SELECT %s FROM %s WHERE entrance_server_id = %s.%s or exit_server_id = %s.%s))) as nodes,(%s.%s ) as %s",
			dao.VpnServer.Table,

			dao.VpnNode.Table,

			dao.VpnNode.Columns.ServerId,
			dao.VpnServer.Table,
			dao.VpnServer.Columns.ServerId,

			dao.VpnNode.Columns.FrpServerId,
			dao.VpnServer.Table,
			dao.VpnServer.Columns.ServerId,

			dao.VpnNode.Table,
			dao.VpnNode.Columns.NodeId,
			dao.VpnNode.Columns.NodeId,
			dao.VpnNodeTransfer.Table,

			dao.VpnServer.Table,
			dao.VpnServer.Columns.ServerId,
			dao.VpnServer.Table,
			dao.VpnServer.Columns.ServerId,

			dao.VpnServerGroup.Table,
			dao.VpnServerGroup.Columns.ServerGroupName,
			dao.VpnServerGroup.Columns.ServerGroupName,
		))
	err = m.Page(page, req.PageSize).Order(order).Scan(&list)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("获取数据失败")
	}

	for _, v := range list {
		v.RealUp = v.RealUp * 8
		v.RealDown = v.RealDown * 8
	}
	return
}

// GetInfoById 通过id获取
func (s *vpnServer) GetInfoById(id int) (info *model.VpnServer, err error) {
	if id == 0 {

		return
	}
	err = g.DB().Model(model.VpnServer{}).Where(dao.VpnServer.Columns.ServerId, id).Scan(&info)
	if err != nil {
		g.Log().Error(err)
	}
	if info == nil || err != nil {
		err = gerror.New("获取信息失败")
	}
	return
}

// Add 添加
func (s *vpnServer) Add(req *dao.VpnServerAddReq) (err error) {

	count, err := dao.VpnServer.DB().Model(dao.VpnServer.Table).Where(dao.VpnServer.Columns.ServerIp, req.ServerIp).Where(dao.VpnServer.Columns.ServerSshProt, req.ServerSshProt).Count()
	if err != nil {
		return
	}

	if count > 0 {
		err = fmt.Errorf("该服务器已经存在")
		return
	}
	req.PppoeRetime = gtime.New()
	result, err := dao.VpnServer.DB().Model(dao.VpnServer.Table).Insert(req)
	if err == nil {
		var serverId int64
		serverId, err = result.LastInsertId()
		if err == nil {
			Restart(int(serverId))
		}
	}
	return
}

// Edit 修改
func (s *vpnServer) Edit(ctx context.Context, req *dao.VpnServerEditReq) error {

	info, err := s.GetInfoById(req.ServerId)
	if err != nil {
		return err
	}

	if info.ServerIp != req.ServerIp || info.ServerSshProt != req.ServerSshProt {
		var count int
		count, err = dao.VpnServer.Ctx(ctx).Where(dao.VpnServer.Columns.ServerIp, req.ServerIp).Where(dao.VpnServer.Columns.ServerSshProt, req.ServerSshProt).Count()
		if err != nil {
			return err
		}

		if count > 0 {
			return fmt.Errorf("该服务器已经存在")
		}

		UnInstall(info.ServerId)
		time.Sleep(1 * time.Second)
	}

	if info.ServerIp != req.ServerIp || info.ServerSshProt != req.ServerSshProt || info.ProxyAddr != req.ProxyAddr || info.ServerSshUser != req.ServerSshUser || info.ServerSshPasswrod != req.ServerSshPasswrod || info.ServerSshPublicKey != req.ServerSshPublicKey {
		defer Restart(req.ServerId)
	}

	err = dao.VpnServer.Ctx(ctx).Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		_, err = dao.VpnServer.Ctx(ctx).FieldsEx(dao.VpnServer.Columns.ServerId, dao.VpnServer.Columns.CreatedAt).Where(dao.VpnServer.Columns.ServerId, req.ServerId).Update(req)
		if err != nil {
			return err
		}
		dao.VpnNodeTransfer.Ctx(ctx).Where(dao.VpnNodeTransfer.Columns.EntranceServerId, req.ServerId).Update(g.Map{
			dao.VpnNodeTransfer.Columns.EntranceServerIp: req.ServerIp,
		})
		dao.VpnNodeTransfer.Ctx(ctx).Where(dao.VpnNodeTransfer.Columns.ExitServerId, req.ServerId).Update(g.Map{
			dao.VpnNodeTransfer.Columns.ExitServerIp: req.ServerIp,
		})
		return nil

	})
	return err
}

func (s *vpnServer) Edits(ctx context.Context, req *dao.VpnServerEditsReq) error {
	data := make(map[string]interface{})

	if req.IsPppoe != 0 {
		data[dao.VpnServer.Columns.IsPppoe] = req.IsPppoe
	}
	if req.PppoeRestart != 0 {
		data[dao.VpnServer.Columns.PppoeRestart] = req.PppoeRestart
	}
	if req.PppoeHour != 0 {
		data[dao.VpnServer.Columns.PppoeHour] = req.PppoeHour
	}
	if req.PppoeCycle != 0 {
		data[dao.VpnServer.Columns.PppoeCycle] = req.PppoeCycle
	}
	if req.ProxyAddr != "" {
		data[dao.VpnServer.Columns.ProxyAddr] = req.ProxyAddr
	}

	if req.ServerGroupId != 0 {
		data[dao.VpnServer.Columns.ServerGroupId] = req.ServerGroupId
	}

	_, err := dao.VpnServer.Ctx(ctx).
		FieldsEx(dao.VpnServer.Columns.ServerId, dao.VpnServer.Columns.CreatedAt).
		Where(dao.VpnServer.Columns.ServerId+" in (?)", req.ServerIds).Data(data).
		Update()

	if req.ProxyAddr != "" {
		for _, v := range req.ServerIds {
			Restart(v)
		}
	}

	return err
}

// DeleteByIds 删除
func (s *vpnServer) DeleteByIds(ctx context.Context, ids []int) (err error) {
	if len(ids) == 0 {

		return
	}

	for _, v := range ids {
		Stop(v)
	}

	err = dao.VpnServer.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		_, err = dao.VpnServer.Ctx(ctx).Delete(dao.VpnServer.Columns.ServerId+" in (?)", ids)
		if err != nil {
			g.Log().Error(err)
			err = gerror.New("删除失败")
			return err
		}

		list := make([]*model.VpnNode, 0)
		err = dao.VpnNode.Ctx(ctx).Where(dao.VpnNode.Columns.ServerId+" in (?)", ids).Scan(&list)
		if err != nil {
			g.Log().Error(err)
			err = gerror.New("删除失败")
			return err
		}
		var nodeIds []int
		for _, v := range list {
			nodeIds = append(nodeIds, v.NodeId)
		}
		err = VpnNode.DeleteByIds(ctx, nodeIds)
		if err != nil {
			g.Log().Error(err)
			err = gerror.New("删除失败")
			return err
		}

		return nil

	})
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("删除失败")
		return err
	}
	return
}

// ChangeStatus 修改状态
func (s *vpnServer) ChangeStatus(ctx context.Context, req *dao.VpnServerStatusReq) error {
	_, err := dao.VpnServer.Ctx(ctx).WherePri(req.ServerId).Update(g.Map{
		dao.VpnServer.Columns.Status: req.Status,
	})
	return err
}

func (s *vpnServer) PingIp(ctx context.Context, nodeId int) (nodeInfo model.VpnNodeInfo, err error) {

	m := dao.VpnNode.Ctx(ctx).
		LeftJoin(dao.VpnServer.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnServer.Table, dao.VpnServer.Columns.ServerId, dao.VpnNode.Table, dao.VpnNode.Columns.ServerId)).
		LeftJoin(fmt.Sprintf("%s as frpServer", dao.VpnServer.Table), fmt.Sprintf("frpServer.%s=%s.%s", dao.VpnServer.Columns.ServerId, dao.VpnNode.Table, dao.VpnNode.Columns.FrpServerId)).
		LeftJoin(dao.VpnNodeNation.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnNode.Table, dao.VpnNode.Columns.NationId, dao.VpnNodeNation.Table, dao.VpnNodeNation.Columns.NationId))

	m = m.Where(fmt.Sprintf("%s.%s >0 ", dao.VpnNode.Table, dao.VpnNode.Columns.NodeId))

	m = m.Where(fmt.Sprintf("%s.%s  = ? ", dao.VpnNode.Table, dao.VpnNode.Columns.NodeId), nodeId)

	fields := make([]string, 0)
	fields = append(fields, dao.VpnNode.Fields(true, true)...)
	fields = append(fields,
		fmt.Sprintf("%s.%s as %s", dao.VpnServer.Table, dao.VpnServer.Columns.ServerIp, dao.VpnServer.Columns.ServerIp),
		fmt.Sprintf("%s.%s as frpServerIp", "frpServer", dao.VpnServer.Columns.ServerIp),
		fmt.Sprintf("%s.%s  as %s", dao.VpnNodeNation.Table, dao.VpnNodeNation.Columns.NationName, dao.VpnNodeNation.Columns.NationName),
	)

	err = m.Fields(fields).Scan(&nodeInfo)
	if err != nil {
		return
	}

	nodeInfo.Transfers = make([]model.VpnNodeTransfer, 0)
	dao.VpnNodeTransfer.Ctx(ctx).Where(dao.VpnNodeTransfer.Columns.NodeId, nodeInfo.NodeId).Order(dao.VpnNodeTransfer.Columns.TransferId + " ASC").Scan(&nodeInfo.Transfers)

	return
}
