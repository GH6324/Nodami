// ==========================================================================
// GFast自动生成路由代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2024-10-14 16:40:33
// 生成路径: gfast/app/vpn/router/vpn_node_ping.go
// 生成人：gfast
// ==========================================================================

package router

import (
	sysApi "gfast/app/system/api"
	"gfast/app/vpn/api"
	"gfast/middleware"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
)

// 加载路由
func init() {
	s := g.Server()
	s.Group("/", func(group *ghttp.RouterGroup) {
		group.Group("/vpn", func(group *ghttp.RouterGroup) {
			group.Group("/vpnNodePing", func(group *ghttp.RouterGroup) {
				//gToken拦截器
				sysApi.GfToken.AuthMiddleware(group)
				//context拦截器
				group.Middleware(middleware.Ctx, middleware.Auth)
				//后台操作日志记录
				group.Hook("/*", ghttp.HookAfterOutput, sysApi.SysOperLog.OperationLog)
				group.GET("list", api.VpnNodePing.List)
				group.GET("get", api.VpnNodePing.Get)
				group.POST("add", api.VpnNodePing.Add)
				group.PUT("edit", api.VpnNodePing.Edit)
				group.DELETE("delete", api.VpnNodePing.Delete)
			})
		})
	})
}
