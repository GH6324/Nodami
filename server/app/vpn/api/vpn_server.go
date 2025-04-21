// ==========================================================================
// GFast自动生成控制器相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/api/vpn_server.go
// 生成人：gfast
// ==========================================================================

package api

import (
	"fmt"
	sysApi "gfast/app/system/api"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/service"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
	"github.com/spf13/cast"
	"net"
)

type vpnServer struct {
	sysApi.SystemBase
}

var VpnServer = new(vpnServer)

// List 列表
func (c *vpnServer) List(r *ghttp.Request) {
	var req *dao.VpnServerSearchReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	req.Ctx = r.GetCtx()
	total, page, list, err := service.VpnServer.GetList(req)
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
func (c *vpnServer) Add(r *ghttp.Request) {
	var req *dao.VpnServerAddReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}

	if req.IsPppoe == 0 {
		req.IsPppoe = -1
	}

	if req.PppoeRestart == 0 {
		req.PppoeRestart = -1
	}

	req.Status = -1

	if req.VpnServerAddReqs != nil {
		if len(req.VpnServerAddReqs) == 0 {
			c.SusJsonExit(r, "没有可以导入的服务器")
		}
		ok := 0
		errs := 0
		for _, v := range req.VpnServerAddReqs {
			addReq := dao.VpnServerAddReq{
				ServerGroupId:      req.ServerGroupId,
				ServerName:         req.ServerName,
				ServerIp:           req.ServerIp,
				ServerSshProt:      req.ServerSshProt,
				ServerSshUser:      req.ServerSshUser,
				ServerSshPasswrod:  req.ServerSshPasswrod,
				ServerSshPublicKey: req.ServerSshPublicKey,
				ServerSshLoginType: req.ServerSshLoginType,
				Other:              req.Other,
				IsPppoe:            req.IsPppoe,
				PppoeRestart:       req.PppoeRestart,
				PppoeHour:          req.PppoeHour,
				Status:             req.Status,
				PppoeCycle:         req.PppoeCycle,
				ProxyAddr:          req.ProxyAddr,
			}
			if v.ServerAddress != "" {
				serverIp, serverSshProt, err := net.SplitHostPort(v.ServerAddress)
				if err == nil {
					if serverIp != "" {
						addReq.ServerIp = serverIp
					}

					if serverSshProt != "" {
						addReq.ServerSshProt = cast.ToInt(serverSshProt)
					}
				}
			}

			if v.ServerSshProt > 0 {
				addReq.ServerSshProt = v.ServerSshProt
			}
			if v.ServerSshUser != "" {
				addReq.ServerSshUser = v.ServerSshUser
			}
			if v.ServerSshPasswrod != "" {
				addReq.ServerSshPasswrod = v.ServerSshPasswrod
			}
			if v.ServerSshPublicKey != "" {
				addReq.ServerSshPublicKey = v.ServerSshPublicKey
			}
			if v.ServerSshLoginType != "" {
				addReq.ServerSshLoginType = v.ServerSshLoginType
			}
			if v.ServerIp != "" {
				addReq.ServerIp = v.ServerIp
			}
			if len(addReq.ServerName) > 0 {
				addReq.ServerName = addReq.ServerName + "#" + v.ServerName
			} else {
				addReq.ServerName = v.ServerName
			}

			if addReq.ServerIp == "" || addReq.ServerSshProt == 0 {
				continue
			}
			err := service.VpnServer.Add(&addReq)
			if err != nil {
				errs++
				continue
			}
			ok++
		}

		c.SusJsonExit(r, fmt.Sprintf("添加成功 %d个  添加失败 %d个", ok, errs))
		return
	} else {
		err := service.VpnServer.Add(req)
		if err != nil {
			c.FailJsonExit(r, err.Error())
		}
		c.SusJsonExit(r, "添加成功")
	}

}

// Get 获取
func (c *vpnServer) Get(r *ghttp.Request) {
	id := r.GetInt("id")
	info, err := service.VpnServer.GetInfoById(id)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, info)
}

// Edit 修改
func (c *vpnServer) Edit(r *ghttp.Request) {
	var req *dao.VpnServerEditReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	err := service.VpnServer.Edit(r.GetCtx(), req)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "修改成功")
}

func (c *vpnServer) Edits(r *ghttp.Request) {
	var req *dao.VpnServerEditsReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	err := service.VpnServer.Edits(r.GetCtx(), req)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "修改成功")
}

// Delete 删除
func (c *vpnServer) Delete(r *ghttp.Request) {
	ids := r.GetInts("ids")

	err := service.VpnServer.DeleteByIds(r.GetCtx(), ids)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "删除成功")
}

// ChangeStatus 修改状态
func (c *vpnServer) ChangeStatus(r *ghttp.Request) {
	var req *dao.VpnServerStatusReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	if err := service.VpnServer.ChangeStatus(r.GetCtx(), req); err != nil {
		c.FailJsonExit(r, err.Error())
	} else {
		c.SusJsonExit(r, "状态设置成功")
	}
}

func (c *vpnServer) ReStartServer(r *ghttp.Request) {
	ids := r.GetInts("ids")
	for _, v := range ids {
		service.Reboot(v)
	}
	c.SusJsonExit(r, "提交成功")
}

func (c *vpnServer) PppoeReStart(r *ghttp.Request) {
	ids := r.GetInts("ids")
	for _, v := range ids {
		x, ok := service.ResGetServer(v)
		if ok {
			if x.IsPppoe {
				go x.PppoeReStart(true)
			}
		}
	}
	c.SusJsonExit(r, "提交成功")
}

func (c *vpnServer) ReStartVpnServer(r *ghttp.Request) {
	ids := r.GetInts("ids")
	for _, v := range ids {
		service.Restart(v)
	}
	c.SusJsonExit(r, "提交成功")
}

func (c *vpnServer) Log(r *ghttp.Request) {
	id := r.GetInt("serverId")
	c.SusJsonExit(r, service.GetLog(id))
}

func (c *vpnServer) Info(r *ghttp.Request) {
	id := r.GetInt("serverId")
	req, _ := service.GetServerInfo(id)
	req.NetIO.Up = req.NetIO.Up * 8
	req.NetIO.Down = req.NetIO.Down * 8
	c.SusJsonExit(r, req)
}

type PingRes struct {
	InServerId int     `json:"inServerId"`
	ToServerId int     `json:"toServerId"`
	Value      float64 `json:"value"`
}

func (c *vpnServer) PingServer(r *ghttp.Request) {
	serverId := r.GetInt("inServerId")
	toServerId := r.GetInt("toServerId")
	res := &PingRes{
		InServerId: serverId,
		ToServerId: toServerId,
	}
	var err error
	res.Value, err = service.PingIp(serverId, toServerId)
	if err != nil {
		res.Value = -1
	}
	c.SusJsonExit(r, res)
}
