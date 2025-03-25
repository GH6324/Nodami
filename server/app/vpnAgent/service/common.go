package service

import (
	"common/commonInfo"
	"context"
	"fmt"
	"gfast/app/common/global"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"
	"gfast/app/vpn/service"
	vpnClientService "gfast/app/vpnClient/service"
	"gfast/cache"
	"gfast/task/queueTraffics"
	"github.com/gogf/gf/frame/g"
	"github.com/spf13/cast"
)

type vpnAgentService struct {
	nodeStatus   chan []commonInfo.NodeStatus
	logs         chan *commonInfo.LogUploadInfo
	serverInfo   chan *commonInfo.ServerInfo
	requestInfos chan []commonInfo.RequestInfo
}

var VpnAgentService = new(vpnAgentService)

func init() {
	v := VpnAgentService
	v.nodeStatus = make(chan []commonInfo.NodeStatus, 1000)
	v.logs = make(chan *commonInfo.LogUploadInfo, 1000)
	v.serverInfo = make(chan *commonInfo.ServerInfo, 1000)
	v.requestInfos = make(chan []commonInfo.RequestInfo, 1000)
	go func(s *vpnAgentService) {
		for {
			select {
			case req := <-s.logs:
				go logs(req)
			case req := <-s.serverInfo:
				go serverInfo(req)
			}
		}
	}(v)
}

func logs(req *commonInfo.LogUploadInfo) {
	err := service.SaveLog(req.ServerId, req.LogName, service.NOCOLOR, req.Log)
	if err != nil {
		g.Log().Error(err)
	}
}

func serverInfo(req *commonInfo.ServerInfo) {

	mem := (float64(req.Mem.Current) / float64(req.Mem.Total)) * 100
	disk := (float64(req.Disk.Current) / float64(req.Disk.Total)) * 100
	_, err := dao.VpnServer.DB().Model(dao.VpnServer.Table).
		Where(dao.VpnServer.Columns.ServerId, req.ServerId).
		Data(map[string]interface{}{
			dao.VpnServer.Columns.Status:   1,
			dao.VpnServer.Columns.Up:       req.NetTraffic.Sent,
			dao.VpnServer.Columns.Down:     req.NetTraffic.Recv,
			dao.VpnServer.Columns.RealCpu:  cast.ToFloat32(fmt.Sprintf("%.2f", req.Cpu)),
			dao.VpnServer.Columns.RealMem:  cast.ToFloat32(fmt.Sprintf("%.2f", mem)),
			dao.VpnServer.Columns.RealDisk: cast.ToFloat32(fmt.Sprintf("%.2f", disk)),
			dao.VpnServer.Columns.RealUp:   req.NetIO.Up,
			dao.VpnServer.Columns.RealDown: req.NetIO.Down,
		}).Update()
	if err != nil {
		g.Log().Error(err)
		return
	}
	cache.Set(fmt.Sprintf("%s:%d", global.ServerInfoToken, req.ServerId), req, 60*60)
}

func (c *vpnAgentService) PublicIPs(req *commonInfo.ServerIPsInfo) {
	cache.Set(fmt.Sprintf("%s:%d", global.ServerIpsToken, req.ServerId), req, 0)
	return
}

type AgentTransfers struct {
	EntranceServerId int    `json:"entranceServerId"`
	EntranceServerIp string `json:"entranceServerIp"`
	ExitServerId     int    `json:"exitServerId"`
	ExitServerIp     string `json:"exitServerIp"`
	ServerId         int    `json:"serverId"`
	ServerIp         string `json:"serverIp"`
}

func (c *vpnAgentService) agentTransfers(transfers []model.VpnNodeTransfer) []AgentTransfers {
	value := make([]AgentTransfers, 0)
	agentTransfers := AgentTransfers{}
	for index, v := range transfers {
		if agentTransfers.EntranceServerId == 0 {
			agentTransfers.EntranceServerId = v.EntranceServerId
			agentTransfers.EntranceServerIp = v.EntranceServerIp
			agentTransfers.ServerId = v.ExitServerId
			agentTransfers.ServerIp = v.ExitServerIp
		}

		if agentTransfers.ServerId == v.EntranceServerId || (len(transfers)-1) == index {
			agentTransfers.ExitServerId = v.ExitServerId
			agentTransfers.ExitServerIp = v.ExitServerIp
			value = append(value, agentTransfers)
			agentTransfers = AgentTransfers{}
		}
	}
	return value

}

func (c *vpnAgentService) AgentNodes(ctx context.Context, serverId int, nodeId int) (nodesRes commonInfo.NodesRes, err error) {
	nodeModels, err := vpnClientService.VpnNodeService.Nodes(ctx, nodeId, serverId)
	if err != nil {
		return
	}

	nodesRes = commonInfo.NodesRes{
		FrpNodeConfigs:    make([]commonInfo.FrpNodeConfig, 0),
		SingBoxNodes:      make([]commonInfo.NodesConfig, 0),
		HysteriaTransfers: make([]commonInfo.Transfer, 0),
		SingBoxTransfers:  make([]commonInfo.SingBoxTransfer, 0),
	}

	for _, v := range nodeModels {

		if v.ServerId == serverId && v.FrpServerId > 0 {
			frpNodeConfig := commonInfo.FrpNodeConfig{
				NodeId:     int32(v.NodeId),
				ServerAddr: v.FrpServerIp,
				LocalPort:  v.VpnPort,
				RemotePort: v.FrpPort,
			}
			if v.FrpProtocol == commonInfo.Frp_Kcp {
				frpNodeConfig.Protocol = "kcp"
			}
			if v.FrpProtocol == commonInfo.Frp_Tcp {
				frpNodeConfig.Protocol = "tcp"
			}
			if v.FrpProtocol == commonInfo.Frp_Quic {
				frpNodeConfig.Protocol = "quic"
			}
			nodesRes.FrpNodeConfigs = append(nodesRes.FrpNodeConfigs, frpNodeConfig)
		}

		isSameServer := v.ServerId == serverId

		isDefaultTransit := v.TransitProtocol == "" || v.TransitProtocol == commonInfo.Protocol_Hysteria

		if isSameServer && v.TransitProtocol == commonInfo.HysteriaOut {

			nodesConfig := commonInfo.NodesConfig{
				NodeId:         int32(v.NodeId),
				ServerId:       int32(v.ServerId),
				OutIp:          v.OutIp,
				Protocol:       v.TransitProtocol,
				NodeServerIp:   v.ServerIp,
				NodeServerPort: v.VpnPort,
			}

			nodesRes.SingBoxNodes = append(nodesRes.SingBoxNodes, nodesConfig)

		}

		if isSameServer && isDefaultTransit {

			nodesConfig := commonInfo.NodesConfig{
				NodeId:            int32(v.NodeId),
				ServerId:          int32(v.ServerId),
				OutIp:             v.OutIp,
				Ws:                v.Ws == 1,
				WsPath:            v.WsPath,
				Protocol:          v.Protocol,
				Method:            v.Method,
				NodeServerIp:      v.ServerIp,
				NodeServerPort:    v.VpnPort,
				TransitServerPort: v.TransitPort,
				FrpServerIp:       v.FrpServerIp,
				FrpServerPort:     v.FrpPort,
			}

			nodesRes.SingBoxNodes = append(nodesRes.SingBoxNodes, nodesConfig)

		}

		if v.TransitProtocol != "" {
			if v.TransitProtocol == commonInfo.HysteriaOut {

				for ii, vv := range v.Transfers {
					if vv.EntranceServerId != serverId {
						continue
					}

					remotePort := v.TransitPort
					if ii == (len(v.Transfers) - 1) {
						remotePort = v.VpnPort

					}
					transfer := commonInfo.SingBoxTransfer{
						ExitServerId:   vv.ExitServerId,
						ExitServerIp:   vv.ExitServerIp,
						ExitServerPort: remotePort,
						InLocalPort:    v.TransitPort,
					}

					if ii == 0 {
						nodesConfig := commonInfo.NodesConfig{
							NodeId:         int32(v.NodeId),
							ServerId:       int32(v.ServerId),
							Ws:             v.Ws == 1,
							WsPath:         v.WsPath,
							Protocol:       v.Protocol,
							Method:         v.Method,
							NodeServerIp:   v.ServerIp,
							NodeServerPort: v.TransitPort,
						}

						nodesRes.SingBoxNodes = append(nodesRes.SingBoxNodes, nodesConfig)
						transfer.InLocalNodeId = v.NodeId
					}

					nodesRes.SingBoxTransfers = append(nodesRes.SingBoxTransfers, transfer)
				}

			} else if v.TransitProtocol == commonInfo.Protocol_Hysteria {
				transfers := c.agentTransfers(v.Transfers)

				for ii, vv := range transfers {

					if vv.EntranceServerId != serverId {
						continue
					}

					remotePort := v.TransitPort
					if ii == (len(transfers) - 1) {
						remotePort = v.VpnPort
					}

					transfer := commonInfo.Transfer{
						ExitServerId: vv.ServerId,
						ExitServerIp: vv.ServerIp,
						LocalPort:    v.TransitPort,
						RemotePort:   remotePort,
						RemoteIp:     vv.ExitServerIp,
					}

					nodesRes.HysteriaTransfers = append(nodesRes.HysteriaTransfers, transfer)
				}
			}

		}

	}
	return
}

func (c *vpnAgentService) SendTraffics(req *commonInfo.TrafficsInfo) (err error) {

	for _, v := range req.Traffics {
		if v.IsGlobal {
			queueTraffics.GetGlobalQueue().Push(&queueTraffics.GlobalQueueInfo{
				ServerId: req.ServerId,
				NodeId:   v.NodeId,
				Up:       v.Up,
				Down:     v.Down,
			})
		} else {
			queueTraffics.GetEmailQueue().Push(&queueTraffics.EmailQueueInfo{
				Email: v.Email,
				Up:    v.Up,
				Down:  v.Down,
			})
		}
	}
	return
}

func (c *vpnAgentService) SendNodeStatus(req []commonInfo.NodeStatus) (err error) {
	c.nodeStatus <- req
	return err
}

func (c *vpnAgentService) SendLogMsg(req *commonInfo.LogUploadInfo) (err error) {
	c.logs <- req
	return err
}

func (c *vpnAgentService) SendServerInfo(req *commonInfo.ServerInfo) (err error) {
	c.serverInfo <- req
	return
}

func (c *vpnAgentService) GetServerInfo(serverId int) (req *model.VpnServer, err error) {
	return service.VpnServer.GetInfoById(serverId)
}
