// ==========================================================================
// GFast自动生成路由代码，只生成一次，按需修改,再次生成不会覆盖.
// 生成日期：2025-03-28 13:34:00
// 生成路径: gfast/app/vpn/router/vpn_node_group.go
// 生成人：gfast
// ==========================================================================


package router
import (
    "gfast/app/vpn/api"
    "gfast/middleware"
    "github.com/gogf/gf/frame/g"
    "github.com/gogf/gf/net/ghttp"    
    sysApi "gfast/app/system/api"    
)
//加载路由
func init() {
    s := g.Server()
    s.Group("/", func(group *ghttp.RouterGroup) {
        group.Group("/vpn", func(group *ghttp.RouterGroup) {
            group.Group("/vpnNodeGroup", func(group *ghttp.RouterGroup) {
                //gToken拦截器                
                sysApi.GfToken.AuthMiddleware(group)                
                //context拦截器
                group.Middleware(middleware.Ctx, middleware.Auth)                
                //后台操作日志记录
                group.Hook("/*", ghttp.HookAfterOutput, sysApi.SysOperLog.OperationLog)                
                group.GET("list", api.VpnNodeGroup.List)
                group.GET("get", api.VpnNodeGroup.Get)
                group.POST("add", api.VpnNodeGroup.Add)
                group.PUT("edit", api.VpnNodeGroup.Edit)
                group.DELETE("delete", api.VpnNodeGroup.Delete)                
            })
        })
    })
}
