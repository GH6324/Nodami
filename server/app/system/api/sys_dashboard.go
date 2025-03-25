package api

import (
	"gfast/app/system/dao"
	"gfast/app/vpn/service"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/os/gtime"
)

type sysDashboard struct {
	SystemBase
	startTime *gtime.Time
}

var SysDashboard = &sysDashboard{
	startTime: gtime.Now(),
}

func (c *sysDashboard) Info(r *ghttp.Request) {

	rsp := new(dao.DashboardRsp)
	var err error

	rsp.OnlineServer, err = service.VpnServer.CountByStatus(r.GetCtx(), 1)
	if err != nil {
		c.FailJsonExit(r, err.Error())
		return
	}
	rsp.OfflineServer, err = service.VpnServer.CountByStatus(r.GetCtx(), -1)
	if err != nil {
		c.FailJsonExit(r, err.Error())
		return
	}

	rsp.Nodes, err = service.VpnNode.CountByStatus(r.GetCtx())
	if err != nil {
		c.FailJsonExit(r, err.Error())
		return
	}

	c.SusJsonExit(r, rsp)
}

func (c *sysDashboard) Chart(r *ghttp.Request) {

	rsp := new(dao.DashboardChartRsp)

	c.SusJsonExit(r, rsp)
}
