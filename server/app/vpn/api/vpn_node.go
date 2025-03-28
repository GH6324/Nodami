// ==========================================================================
// GFast自动生成控制器相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/api/vpn_node.go
// 生成人：gfast
// ==========================================================================

package api

import (
	"common/commonInfo"
	"fmt"
	"gfast/app/common/global"
	sysApi "gfast/app/system/api"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"
	"gfast/app/vpn/service"
	"gfast/cache"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
)

type vpnNode struct {
	sysApi.SystemBase
}

var VpnNode = new(vpnNode)

// List 列表
func (c *vpnNode) List(r *ghttp.Request) {
	var req *dao.VpnNodeSearchReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	req.Ctx = r.GetCtx()
	total, page, list, err := service.VpnNode.GetList(req)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	result := g.Map{
		"currentPage": page,
		"total":       total,
		"list":        list,
	}
	c.SusJsonExit(r, result)
}

// Add 添加
func (c *vpnNode) Add(r *ghttp.Request) {
	var req *dao.VpnNodeAddReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}

	if req.ServerId == 0 && len(req.ServerIds) == 0 {
		c.FailJsonExit(r, "未选择节点服务器")
	}

	vpnNodeModel := model.VpnNode{
		ServerId:                        req.ServerId,
		TransitPort:                     req.TransitPort,
		TransitProtocol:                 req.TransitProtocol,
		Protocol:                        req.Protocol,
		OtuType:                         req.OtuType,
		OutIp:                           req.OutIp,
		NationId:                        req.NationId,
		VpnPort:                         req.VpnPort,
		TransportProtocol:               req.TransportProtocol,
		StreamSettingsHost:              req.StreamSettingsHost,
		StreamSettingsPath:              req.StreamSettingsPath,
		StreamSettingsServiceName:       req.StreamSettingsServiceName,
		Method:                          req.Method,
		FrpServerId:                     req.FrpServerId,
		FrpProtocol:                     req.FrpProtocol,
		FrpPort:                         req.FrpPort,
		Other:                           req.Other,
		StreamSettingsReality:           req.StreamSettingsReality,
		NodeGroupId:                     req.NodeGroupId,
		StreamSettingsCongestionControl: req.StreamSettingsCongestionControl,
	}

	if req.AddType == 0 {
		err := service.VpnNode.Add(r.GetCtx(), &vpnNodeModel, req.Transfers)
		if err != nil {
			g.Log().Error(err.Error())
			c.FailJsonExit(r, "添加失败")
		}
		c.SusJsonExit(r, "添加成功")
		return
	}

	if req.AddType == 1 {
		ipsReq := &commonInfo.ServerIPsInfo{}
		key := fmt.Sprintf("%s:%d", global.ServerIpsToken, req.ServerId)
		err := cache.GetToType(key, ipsReq)
		if err != nil {
			g.Log().Error(err.Error())
			c.FailJsonExit(r, fmt.Sprintf("%s err：%s", key, err.Error()))
			return
		}

		if ipsReq.ServerIps == nil || len(ipsReq.ServerIps) == 0 {
			c.FailJsonExit(r, "该服务器IP绑定存在异常未发现多IP")
			return
		}

		var oks, errs int
		for _, ip := range ipsReq.ServerIps {
			add := vpnNodeModel
			add.OtuType = 2
			add.OutIp = ip
			err = service.VpnNode.Add(r.GetCtx(), &add, req.Transfers)
			if err != nil {
				g.Log().Error(err.Error())
				errs++
			} else {
				oks++
			}
		}
		c.SusJsonExit(r, fmt.Sprintf("成功添加 %d个 失败 %d个", oks, errs))
		return
	}

	if req.AddType == 3 {
		if len(req.ServerIds) == 0 {
			c.FailJsonExit(r, "未选择服务器")
		}
		if req.OtuType == 2 {
			c.FailJsonExit(r, "多服务器批量添加 不可以指定出口ip")
		}

		var oks, errs int
		for _, v := range req.ServerIds {
			add := vpnNodeModel
			add.ServerId = v
			err := service.VpnNode.Add(r.GetCtx(), &add, req.Transfers)
			if err != nil {
				errs++
			} else {
				oks++
			}
		}
		c.SusJsonExit(r, fmt.Sprintf("成功添加 %d个 失败 %d个", oks, errs))

	}

	c.FailJsonExit(r, "未选择添加方式")
}

// Get 获取
func (c *vpnNode) Get(r *ghttp.Request) {
	id := r.GetInt("id")
	info, err := service.VpnNode.GetInfoById(r.GetCtx(), id)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, info)
}

// Edit 修改
func (c *vpnNode) Edit(r *ghttp.Request) {
	var req *dao.VpnNodeEditReq

	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	vpnNodeModel := model.VpnNode{
		NodeId:                          req.NodeId,
		ServerId:                        req.ServerId,
		TransitPort:                     req.TransitPort,
		TransitProtocol:                 req.TransitProtocol,
		Protocol:                        req.Protocol,
		OtuType:                         req.OtuType,
		OutIp:                           req.OutIp,
		NationId:                        req.NationId,
		VpnPort:                         req.VpnPort,
		TransportProtocol:               req.TransportProtocol,
		StreamSettingsHost:              req.StreamSettingsHost,
		StreamSettingsPath:              req.StreamSettingsPath,
		StreamSettingsServiceName:       req.StreamSettingsServiceName,
		Method:                          req.Method,
		FrpServerId:                     req.FrpServerId,
		FrpProtocol:                     req.FrpProtocol,
		FrpPort:                         req.FrpPort,
		Other:                           req.Other,
		StreamSettingsReality:           req.StreamSettingsReality,
		NodeGroupId:                     req.NodeGroupId,
		StreamSettingsCongestionControl: req.StreamSettingsCongestionControl,
	}

	err := service.VpnNode.Edit(r.GetCtx(), &vpnNodeModel, req.Transfers)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "修改成功")
}

func (c *vpnNode) Edits(r *ghttp.Request) {
	var req *dao.VpnNodeEditReqs
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}

	err := service.VpnNode.Edits(r.GetCtx(), req)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "修改成功")
}

func (c *vpnNode) Delete(r *ghttp.Request) {
	ids := r.GetInts("ids")
	err := service.VpnNode.DeleteByIds(r.GetCtx(), ids)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "删除成功")
}

func (c *vpnNode) NodeURLTest(r *ghttp.Request) {
	nodeId := r.GetInt("id")
	pingId := r.GetInt("pingId")
	sm, err := service.VpnNode.SpeedPing(r.GetCtx(), nodeId, pingId, false)
	if err != nil {
		sm = -1
		g.Log().Error(err.Error())
	}
	c.SusJsonExit(r, sm)
}

func (c *vpnNode) NodeSpeedTest(r *ghttp.Request) {
	nodeId := r.GetInt("id")
	pingId := r.GetInt("pingId")
	speed, err := service.VpnNode.SpeedPing(r.GetCtx(), nodeId, pingId, true)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, speed)
}
