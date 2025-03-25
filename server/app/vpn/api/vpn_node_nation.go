// ==========================================================================
// GFast自动生成控制器相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2023-11-13 14:52:14
// 生成路径: gfast/app/vpn/api/vpn_node_nation.go
// 生成人：gfast
// ==========================================================================

package api

import (
	sysApi "gfast/app/system/api"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/service"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
)

type vpnNodeNation struct {
	sysApi.SystemBase
}

var VpnNodeNation = new(vpnNodeNation)

// List 列表
func (c *vpnNodeNation) List(r *ghttp.Request) {
	var req *dao.VpnNodeNationSearchReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	req.Ctx = r.GetCtx()
	total, page, list, err := service.VpnNodeNation.GetList(req)
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
func (c *vpnNodeNation) Add(r *ghttp.Request) {
	var req *dao.VpnNodeNationAddReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	err := service.VpnNodeNation.Add(r.GetCtx(), req)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "添加成功")
}

// Get 获取
func (c *vpnNodeNation) Get(r *ghttp.Request) {
	id := r.GetInt("id")
	info, err := service.VpnNodeNation.GetInfoById(r.GetCtx(), id)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, info)
}

// Edit 修改
func (c *vpnNodeNation) Edit(r *ghttp.Request) {
	var req *dao.VpnNodeNationEditReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	err := service.VpnNodeNation.Edit(r.GetCtx(), req)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "修改成功")
}

// Delete 删除
func (c *vpnNodeNation) Delete(r *ghttp.Request) {
	ids := r.GetInts("ids")
	err := service.VpnNodeNation.DeleteByIds(r.GetCtx(), ids)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "删除成功")
}
