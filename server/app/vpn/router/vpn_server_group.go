// ==========================================================================
// GFast自动生成路由代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2024-10-11 16:02:19
// 生成路径: gfast/app/vpn/router/vpn_server_group.go
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
			group.Group("/vpnServerGroup", func(group *ghttp.RouterGroup) {
				//gToken拦截器
				sysApi.GfToken.AuthMiddleware(group)
				//context拦截器
				group.Middleware(middleware.Ctx, middleware.Auth)
				group.GET("list", api.VpnServerGroup.List)
				group.GET("get", api.VpnServerGroup.Get)
				group.POST("add", api.VpnServerGroup.Add)
				group.PUT("edit", api.VpnServerGroup.Edit)
				group.DELETE("delete", api.VpnServerGroup.Delete)
			})
		})
	})
}
