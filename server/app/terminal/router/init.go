package router

import (
	"gfast/app/terminal/controller"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"time"
)

// 加载路由
func init() {
	s := g.Server()
	s.Group("/terminal", func(group *ghttp.RouterGroup) {
		group.GET("/term", func(c *ghttp.Request) {
			controller.TerminalFile.TermWs(c, time.Duration(60)*time.Minute)
		})
		group.GET("/info", func(c *ghttp.Request) {
			controller.TerminalFile.Info(c)
		})

		group.GET("/file/list", func(c *ghttp.Request) {
			controller.TerminalFile.FileList(c)
		})
		group.GET("/file/download", func(c *ghttp.Request) {
			controller.TerminalFile.DownloadFile(c)
		})
		group.POST("/file/upload", func(c *ghttp.Request) {
			controller.TerminalFile.UploadFile(c)
		})
		group.GET("/file/progress", func(c *ghttp.Request) {
			controller.TerminalFile.UploadProgressWs(c)
		})
	})
}
