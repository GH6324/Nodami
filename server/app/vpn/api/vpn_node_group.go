// ==========================================================================
// GFast自动生成控制器相关代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2025-03-28 13:34:00
// 生成路径: gfast/app/vpn/api/vpn_node_group.go
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
type vpnNodeGroup struct {    
    sysApi.SystemBase    
}
var VpnNodeGroup = new(vpnNodeGroup)
// List 列表
func (c *vpnNodeGroup) List(r *ghttp.Request) {
	var req *dao.VpnNodeGroupSearchReq
	//获取参数
	if err := r.Parse(&req); err != nil {
		c.FailJsonExit(r, err.(gvalid.Error).FirstString())
	}
	req.Ctx = r.GetCtx()
	total, page, list, err := service.VpnNodeGroup.GetList(req)
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
func (c *vpnNodeGroup) Add(r *ghttp.Request) {
    var req *dao.VpnNodeGroupAddReq
    //获取参数
    if err := r.Parse(&req); err != nil {
        c.FailJsonExit(r, err.(gvalid.Error).FirstString())
    }    
    err := service.VpnNodeGroup.Add(r.GetCtx(),req)
    if err != nil {
        c.FailJsonExit(r, err.Error())
    }
    c.SusJsonExit(r, "添加成功")
}
// Get 获取
func (c *vpnNodeGroup) Get(r *ghttp.Request) {
	id := r.GetInt("id")
	info, err := service.VpnNodeGroup.GetInfoById(r.GetCtx(),id)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, info)
}
// Edit 修改
func (c *vpnNodeGroup) Edit(r *ghttp.Request) {
    var req *dao.VpnNodeGroupEditReq
    //获取参数
    if err := r.Parse(&req); err != nil {
        c.FailJsonExit(r, err.(gvalid.Error).FirstString())
    }    
    err := service.VpnNodeGroup.Edit(r.GetCtx(),req)
    if err != nil {
        c.FailJsonExit(r, err.Error())
    }
    c.SusJsonExit(r, "修改成功")
}
// Delete 删除
func (c *vpnNodeGroup) Delete(r *ghttp.Request) {
	ids := r.GetInts("ids")
	err := service.VpnNodeGroup.DeleteByIds(r.GetCtx(),ids)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, "删除成功")
}
