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

	subscriptionID := r.GetInt("subscriptionID")
	config, err := service.VpnNodeService.GetAppClashConfig(r.GetCtx(), subscriptionID)
	if err != nil {
		c.JsonExit(r, -1, err.Error(), nil)
		return
	}
	yamlData, err := yaml.Marshal(&config)
	if err != nil {
		c.JsonExit(r, -1, err.Error(), nil)
		return
	}
	//encoded := base64.StdEncoding.EncodeToString(yamlData)
	gg := "#本订阅地址由开源项目 Nodami 搭建管理。\n\n"
	gg += "#Nodami 是一款功能强大的多节点、多服务器管理面板，支持一键部署和管理多个代理服务器。通过该面板，您可以轻松搭建和管理如 Shadowsocks、Vmess、Vless、Trojan、Hysteria2、Socks5 等主流协议的节点。\n\n"
	gg += "#Nodami 让服务器管理更加高效，简化了技术部署，适合个人、企业和开发者使用。\n\n"
	gg += "#⭐ 欢迎访问我们的 GitHub 项目地址:https://github.com/YoyoCrafts/Nodami  如果您喜欢，记得点个 ⭐ Star 来支持我们！\n\n"
	library.TextExit(r, gg+string(yamlData))
}
