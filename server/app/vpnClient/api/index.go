package api

import (
	sysApi "gfast/app/system/api"
	"gfast/app/vpnClient/service"
	"gfast/library"
	"github.com/gogf/gf/net/ghttp"
	"gopkg.in/yaml.v3"
)

type vpnClientApi struct {
	sysApi.SystemBase
}

var VpnClientApi = new(vpnClientApi)

func (c *vpnClientApi) Subscription(r *ghttp.Request) {
	config, err := service.VpnNodeService.GetAppClashConfig(r.GetCtx())
	if err != nil {
		c.JsonExit(r, -1, err.Error(), nil)
		return
	}
	yamlData, err := yaml.Marshal(&config)
	if err != nil {
		c.JsonExit(r, -1, err.Error(), nil)
		return
	}

	library.TextExit(r, string(yamlData))
}
