package router

import (
	"gfast/app/vpnClient/api"

	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
)

var vpnClientApi = api.VpnClientApi

// 加载路由
func init() {
	s := g.Server()
	s.Group("/", func(group *ghttp.RouterGroup) {
		group.GET("/client/subscription", vpnClientApi.Subscription)
		group.POST("/client/subscription", vpnClientApi.Subscription)
		group.GET("/client/subscription/:subscriptionID", vpnClientApi.Subscription)
		group.POST("/client/subscription/:subscriptionID", vpnClientApi.Subscription)

	})

}
