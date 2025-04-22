// ==========================================================================
// GFast自动生成业务逻辑层相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/service/vpn_node.go
// 生成人：gfast
// ==========================================================================

package service

import (
	"common/commonInfo"
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	comModel "gfast/app/common/model"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"
	vpnClient "gfast/app/vpnClient/service"
	"gfast/library"
	"github.com/gogf/gf/database/gdb"
	"github.com/gogf/gf/errors/gerror"
	"github.com/gogf/gf/frame/g"
	"github.com/spf13/cast"
	"sync"
)

type vpnNode struct {
}

var VpnNode = new(vpnNode)

func (s *vpnNode) CountByStatus(ctx context.Context) (int, error) {
	m := dao.VpnNode.Ctx(ctx)
	count, err := m.Count()
	if err != nil {
		return 0, err
	}
	return count, nil
}

func (s *vpnNode) GetList(req *dao.VpnNodeSearchReq) (total, page int, list []*model.VpnNodeInfo, err error) {

	m := dao.VpnNode.Ctx(req.Ctx).
		LeftJoin(dao.VpnNodeNation.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnNodeNation.Table, dao.VpnNodeNation.Columns.NationId, dao.VpnNode.Table, dao.VpnNode.Columns.NationId)).
		LeftJoin(dao.VpnServer.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnServer.Table, dao.VpnServer.Columns.ServerId, dao.VpnNode.Table, dao.VpnNode.Columns.ServerId))

	if cast.ToInt(req.NodeId) > 0 {
		m = m.Where(dao.VpnNode.Table+"."+dao.VpnNode.Columns.NodeId+" = ?", req.NodeId)
	}
	if cast.ToInt(req.NotNodeId) > 0 {
		m = m.Where(dao.VpnNode.Table+"."+dao.VpnNode.Columns.NodeId+" != ?", req.NotNodeId)
	}

	if cast.ToInt(req.ServerId) > 0 {
		m = m.Where(fmt.Sprintf("%s.%s = ? or (%s.%s in (SELECT %s FROM vpn_node_transfer WHERE entrance_server_id = ? or exit_server_id  = ?))",
			dao.VpnNode.Table,
			dao.VpnNode.Columns.ServerId,
			dao.VpnNode.Table,
			dao.VpnNode.Columns.NodeId,
			dao.VpnNode.Columns.NodeId,
		), req.ServerId, req.ServerId, req.ServerId)
	}

	if req.OutIp != "" {
		m = m.Where(dao.VpnNode.Table+"."+dao.VpnNode.Columns.OutIp+" = ?", req.OutIp)
	}

	if req.Protocol != "" {
		m = m.Where(dao.VpnNode.Table+"."+dao.VpnNode.Columns.Protocol+" = ?", req.Protocol)
	}

	if req.NodeGroupId != "" {
		m = m.Where(dao.VpnNode.Table+"."+dao.VpnNode.Columns.NodeGroupId+" = ?", req.NodeGroupId)
	}

	if cast.ToInt(req.NationId) > 0 {
		m = m.Where(dao.VpnNode.Table+"."+dao.VpnNode.Columns.NationId+" = ?", req.NationId)
	}

	if req.Search != "" {
		m = m.Where(fmt.Sprintf("%s.%s = ? or %s.%s like ? or %s.%s like ? or %s.%s like ?",
			dao.VpnNode.Table,
			dao.VpnNode.Columns.NodeId,
			dao.VpnNode.Table,
			dao.VpnNode.Columns.OutIp,
			dao.VpnNode.Table,
			dao.VpnNode.Columns.Other,
			dao.VpnNodeNation.Table,
			dao.VpnNodeNation.Columns.NationName,
		), req.Search, "%"+req.Search+"%", "%"+req.Search+"%", "%"+req.Search+"%")
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

	order := fmt.Sprintf("%s.%s desc", dao.VpnNode.Table, dao.VpnNode.Columns.NodeId)
	if req.OrderBy != "" {
		order = req.OrderBy
	}

	fields := make([]string, 0)
	fields = append(fields, dao.VpnNode.Fields(true, true)...)
	fields = append(fields, dao.VpnServer.Fields(true, false, dao.VpnNode.Fields(false, false)...)...)
	fields = append(fields, dao.VpnNodeNation.Fields(true, false, dao.VpnNode.Fields(false, false)...)...)

	err = m.Page(page, req.PageSize).Order(order).Fields(fields).Scan(&list)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("获取数据失败")
	}

	for _, v := range list {
		v.Transfers = make([]model.VpnNodeTransfer, 0)
		dao.VpnNodeTransfer.Ctx(req.Ctx).Where(dao.VpnNodeTransfer.Columns.NodeId, v.NodeId).Order(dao.VpnNodeTransfer.Columns.TransferId + " ASC").Scan(&v.Transfers)
	}
	return
}

func (s *vpnNode) GetInfoById(ctx context.Context, nodeId int) (info *model.VpnNodeInfo, err error) {

	fields := make([]string, 0)
	fields = append(fields, dao.VpnNode.Fields(true, true)...)
	fields = append(fields, dao.VpnServer.Fields(true, false, dao.VpnNode.Fields(false, false)...)...)
	fields = append(fields, dao.VpnNodeNation.Fields(true, false, dao.VpnNode.Fields(false, false)...)...)
	fields = append(fields, fmt.Sprintf("%s.%s as frpServerIp", "frpServer", dao.VpnServer.Columns.ServerIp))
	err = dao.VpnNode.Ctx(ctx).
		LeftJoin(dao.VpnNodeNation.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnNodeNation.Table, dao.VpnNodeNation.Columns.NationId, dao.VpnNode.Table, dao.VpnNode.Columns.NationId)).
		LeftJoin(dao.VpnServer.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnServer.Table, dao.VpnServer.Columns.ServerId, dao.VpnNode.Table, dao.VpnNode.Columns.ServerId)).
		LeftJoin(fmt.Sprintf("%s as frpServer", dao.VpnServer.Table), fmt.Sprintf("frpServer.%s=%s.%s", dao.VpnServer.Columns.ServerId, dao.VpnNode.Table, dao.VpnNode.Columns.FrpServerId)).
		Where(dao.VpnNode.Table+"."+dao.VpnNode.Columns.NodeId, nodeId).
		Fields(fields).
		Scan(&info)

	if err != nil {
		g.Log().Error(err)
	}
	if info == nil || err != nil {
		err = gerror.New("获取信息失败")
	}

	info.Transfers = make([]model.VpnNodeTransfer, 0)
	err = dao.VpnNodeTransfer.Ctx(ctx).Where(dao.VpnNodeTransfer.Columns.NodeId, info.NodeId).Order(dao.VpnNodeTransfer.Columns.TransferId + " ASC").Scan(&info.Transfers)
	if err != nil {
		return
	}

	info.Proxie = vpnClient.VpnNodeService.GetClashProxie(info, 0, library.Settings.Agent.CommonUUID)
	return
}

func (s *vpnNode) getPort(ctx context.Context, nodeId int, serverIds []int, port int) (availablePort int, err error) {
	type vpnNodePort struct {
		Port int `json:"port"`
	}
	frpPorts := make([]vpnNodePort, 0)
	m := dao.VpnNode.Ctx(ctx)
	if nodeId > 0 {
		m = m.Where(dao.VpnNode.Columns.NodeId+"!=?", nodeId)
	}

	err = m.WhereIn(dao.VpnNode.Columns.FrpServerId, serverIds).Fields(dao.VpnNode.Columns.FrpPort + " as port").Scan(&frpPorts)
	if err != nil {
		return
	}

	vpnPorts := make([]vpnNodePort, 0)
	err = m.WhereIn(dao.VpnNode.Columns.ServerId, serverIds).Fields(dao.VpnNode.Columns.VpnPort + " as port").Scan(&vpnPorts)
	if err != nil {
		return
	}

	transitPorts := make([]vpnNodePort, 0)
	err = dao.VpnNode.Ctx(ctx).LeftJoin(dao.VpnNodeTransfer.Table, fmt.Sprintf("%s.%s = %s.%s",
		dao.VpnNode.Table, dao.VpnNode.Columns.NodeId,
		dao.VpnNodeTransfer.Table, dao.VpnNodeTransfer.Columns.NodeId,
	)).
		WhereIn(dao.VpnNodeTransfer.Table+"."+dao.VpnNodeTransfer.Columns.EntranceServerId, serverIds).
		Where(fmt.Sprintf("%s.%s != %d", dao.VpnNode.Table, dao.VpnNode.Columns.NodeId, nodeId)).
		Fields(dao.VpnNode.Table + "." + dao.VpnNode.Columns.TransitPort + " as port").Scan(&transitPorts)
	if err != nil {
		return
	}

	occupyPortList := append(append(frpPorts, vpnPorts...), transitPorts...)

	occupyPortMap := make(map[int]bool)
	for _, v := range occupyPortList {
		occupyPortMap[v.Port] = true
	}

	if port > 0 {
		if _, ok := occupyPortMap[port]; !ok {
			availablePort = port
			return
		}
	}

	for i := 10000; i <= 60000; i++ {
		if _, ok := occupyPortMap[i]; !ok {
			availablePort = i
			return
		}
	}
	err = fmt.Errorf("无可用的端口")
	return
}

func (s *vpnNode) GetAutoPort(ctx context.Context, nodeId int, serverIds []int, port *int) (err error) {
	autoPort, err := s.getPort(ctx, nodeId, serverIds, *port)
	if err != nil {
		return
	}
	if *port > 0 && *port != autoPort {
		err = fmt.Errorf("serverId: %v  端口 %d 已被占用", serverIds, *port)
		return
	}
	*port = autoPort
	return
}

func (s *vpnNode) commonVpnNode(ctx context.Context, req *model.VpnNode, transfers []dao.TranceId) (err error) {

	err = s.GetAutoPort(ctx, req.NodeId, []int{req.ServerId}, &req.VpnPort)
	if err != nil {
		return
	}
	if req.TransitProtocol != "" && transfers != nil && len(transfers) > 0 {
		serverIds := []int{}
		for _, transfer := range transfers {
			serverIds = append(serverIds, transfer.EntranceServerId)
		}

		err = s.GetAutoPort(ctx, req.NodeId, serverIds, &req.TransitPort)
		if err != nil {
			return
		}
	}

	if req.FrpServerId > 0 && req.FrpProtocol != "" {
		err = s.GetAutoPort(ctx, req.NodeId, []int{req.FrpServerId}, &req.FrpPort)
		if err != nil {
			return
		}
	}

	if req.TransitProtocol == "" || transfers == nil || len(transfers) == 0 || req.TransitPort == 0 {
		req.TransitPort = 0
		req.TransitProtocol = ""
	}

	if req.FrpProtocol == "" || req.FrpServerId == 0 || req.FrpPort == 0 {
		req.FrpProtocol = ""
		req.FrpServerId = 0
		req.FrpPort = 0
	}

	return
}

var mm sync.Mutex

func (s *vpnNode) Add(ctx context.Context, req *model.VpnNode, transfers []dao.TranceId) (err error) {
	mm.Lock()
	defer mm.Unlock()

	err = s.commonVpnNode(ctx, req, transfers)
	if err != nil {
		return
	}

	if req.Ping == "" {
		pingInfos := make([]*model.PingInfo, 0)
		nodePings := make([]*model.VpnNodePing, 0)
		err = dao.VpnNodePing.Ctx(context.Background()).Scan(&nodePings)
		if err != nil {
			return
		}
		for _, v := range nodePings {
			pingInfos = append(pingInfos, &model.PingInfo{
				NationName: v.NationName,
				Ping:       0,
				PingId:     v.PingId,
			})
		}
		var pingByte []byte
		pingByte, err = json.Marshal(pingInfos)
		if err != nil {
			return
		}
		req.Ping = string(pingByte)
	}

	err = dao.VpnNode.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		var result sql.Result
		result, err = tx.Model(dao.VpnNode.Table).Insert(req)
		if err != nil {
			return err
		}

		var nodeId int64
		nodeId, err = result.LastInsertId()
		if err != nil {
			return err
		}
		req.NodeId = int(nodeId)
		err = s.AddVpnNodeTransfer(ctx, req, transfers)
		return err

	})
	if err != nil {
		return
	}

	return nil
}

func (s *vpnNode) AddVpnNodeTransfer(ctx context.Context, req *model.VpnNode, transfers []dao.TranceId) error {

	_, err := dao.VpnNodeTransfer.Ctx(ctx).Delete(dao.VpnNodeTransfer.Columns.NodeId+" = ?", req.NodeId)
	if err != nil {
		return err
	}

	if transfers == nil || len(transfers) == 0 {
		return nil
	}

	baseExitServerInfo, err := VpnServer.GetInfoById(req.ServerId)
	if err != nil {
		return err
	}

	if req.FrpProtocol != "" && req.FrpServerId > 0 {
		baseExitServerInfo, err = VpnServer.GetInfoById(req.FrpServerId)
		if err != nil {
			return err
		}
	}

	for index, v := range transfers {
		entranceServerInfo, r := VpnServer.GetInfoById(v.EntranceServerId)
		if r != nil {
			return r
		}

		if entranceServerInfo == nil {
			return fmt.Errorf("转发节点%d 未找到", v)
		}
		exitServerInfo := baseExitServerInfo
		if (len(transfers) - 1) > index {
			exitServerInfo, err = VpnServer.GetInfoById(transfers[index+1].EntranceServerId)
			if err != nil {
				return err
			}
		}

		_, err = dao.VpnNodeTransfer.Ctx(ctx).Insert(model.VpnNodeTransfer{
			NodeId:           req.NodeId,
			EntranceServerId: v.EntranceServerId,
			EntranceServerIp: entranceServerInfo.ServerIp,
			ExitServerId:     exitServerInfo.ServerId,
			ExitServerIp:     exitServerInfo.ServerIp,
		})
		if err != nil {
			return err
		}

	}
	return nil
}

func (s *vpnNode) Edit(ctx context.Context, req *model.VpnNode, transfers []dao.TranceId) (err error) {
	mm.Lock()
	defer mm.Unlock()

	err = s.commonVpnNode(ctx, req, transfers)
	if err != nil {
		return
	}

	return dao.VpnNode.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {

		_, err = tx.Model(dao.VpnNode.Table).FieldsEx(dao.VpnNode.Columns.Ping, dao.VpnNode.Columns.NodeId).Where(dao.VpnNode.Columns.NodeId, req.NodeId).Data(req).Update()
		if err != nil {
			g.Log().Error(err)
			return err
		}

		err = s.AddVpnNodeTransfer(ctx, req, transfers)
		return err

	})

}

func (s *vpnNode) Edits(ctx context.Context, req *dao.VpnNodeEditReqs) (err error) {
	mm.Lock()
	defer mm.Unlock()

	vpnNodes := make([]*model.VpnNode, 0)
	for _, v := range req.NodeIds {
		info := &model.VpnNode{}
		err = dao.VpnNode.Ctx(ctx).Where(dao.VpnNode.Columns.NodeId, v).Scan(&info)
		if err != nil {
			return
		}
		vpnNodes = append(vpnNodes, info)
	}

	return dao.VpnNode.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {

		for _, v := range vpnNodes {
			if req.TransitProtocol != "" {
				v.TransitProtocol = req.TransitProtocol
			}

			if req.FrpServerId != 0 {
				v.FrpServerId = req.FrpServerId
			}
			if req.FrpProtocol != "" {
				v.FrpProtocol = req.FrpProtocol
			}
			if req.NationId != 0 {
				v.NationId = req.NationId
			}

			err = s.commonVpnNode(ctx, v, []dao.TranceId{})
			if err != nil {
				return err
			}

			return dao.VpnNode.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {

				_, err = tx.Model(dao.VpnNode.Table).FieldsEx(dao.VpnNode.Columns.Ping, dao.VpnNode.Columns.NodeId).Where(dao.VpnNode.Columns.NodeId, v.NodeId).Data(req).Update()
				return err

			})
		}
		return nil
	})

}

func (s *vpnNode) DeleteByIds(ctx context.Context, ids []int) (err error) {
	if len(ids) == 0 {
		return
	}

	dao.VpnNode.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		_, err = tx.Model(dao.VpnNode.Table).Delete(dao.VpnNode.Columns.NodeId+" in (?)", ids)
		return err
	})

	return
}

func (s *vpnNode) SpeedPing(ctx context.Context, nodeId, pingId int, speed bool) (sm int, err error) {

	defer func() {
		if err != nil {
			sm = -1
		}
	}()
	proxies, err := vpnClient.VpnNodeService.GetClashProxies(ctx, nodeId, 0)
	if err != nil {
		return
	}

	if len(proxies) == 0 {
		err = fmt.Errorf("没有找到该节点")
		return
	}

	modelNodePing := &model.VpnNodePing2{}
	err = dao.VpnNodePing.Ctx(ctx).
		LeftJoin(dao.VpnServer.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnNodePing.Table, dao.VpnNodePing.Columns.ServerId, dao.VpnServer.Table, dao.VpnServer.Columns.ServerId)).
		Where(fmt.Sprintf("%s.%s = ?", dao.VpnNodePing.Table, dao.VpnNodePing.Columns.PingId), pingId).
		Fields(append(dao.VpnNodePing.Fields(true, true), dao.VpnServer.Fields(true, false)...)).
		Scan(&modelNodePing)
	if err != nil {
		return
	}

	proxiesString, err := json.Marshal(proxies[0])
	if err != nil {
		return
	}

	testUrl := modelNodePing.PingUrl
	if speed {
		testUrl = modelNodePing.SpeedUrl
	}
	sm, err = commonInfo.SpeedPing(ctx, modelNodePing.ServerIp, testUrl, 1703, string(proxiesString), speed)

	return
}
