package main

import (
	_ "gfast/boot"
	"gfast/mqttserver"
	_ "gfast/router"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/swagger"
	"log"
	"net/http"
	_ "net/http/pprof"
)

// @title       VPN
// @version     1.0
// @description VPN后台管理
// @schemes     http https
func main() {

	go func() {
		log.Println(http.ListenAndServe("0.0.0.0:26060", nil))
	}()
	go func() {
		g.Log().Info("InitAgentClient")
		mqttserver.InitAgentClient()
	}()
	g.Log().Info("Server")
	s := g.Server()
	s.Plugin(&swagger.Swagger{})
	s.Run()
}
