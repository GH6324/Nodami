package router

import (
	"gfast/app/vpnAgent/api"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
)

var vpnAgentApi = api.VpnAgentApi

var (
	maxConcurrent = 10 // 最大并发数
	semaphore     = make(chan struct{}, maxConcurrent)
)

func limitedHandler(c *ghttp.Request, handlerFunc func(*ghttp.Request)) {
	semaphore <- struct{}{}
	defer func() {
		<-semaphore
	}()
	handlerFunc(c)
}

// 加载路由
func init() {
	s := g.Server()
	s.Group("/", func(group *ghttp.RouterGroup) {
		group.GET("/agent/install/agent/:serverId", vpnAgentApi.InstallAgentSh)
		group.GET("/agent/install/docker/*sh", vpnAgentApi.InstallDocker)
		group.GET("/agent/install/mirrors/*sh", vpnAgentApi.InstallMirrors)
		group.GET("/down/:fileName", vpnAgentApi.Down)
		group.POST("/agent/nodes", vpnAgentApi.Nodes)

	})
}
