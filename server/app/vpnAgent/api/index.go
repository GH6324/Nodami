package api

import (
	"common/commonInfo"
	"encoding/json"
	"fmt"
	sysApi "gfast/app/system/api"
	sysService "gfast/app/system/service"
	"gfast/app/vpnAgent/service"
	"gfast/library"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"os"
	"strings"
)

type vpnAgentApi struct {
	sysApi.SystemBase
}

var VpnAgentApi = new(vpnAgentApi)

func (c *vpnAgentApi) Nodes(r *ghttp.Request) {
	var req *commonInfo.CommonReq
	if err := r.Parse(&req); err != nil {
		c.JsonExit(r, 1000, "参数错误", nil)
		return
	}
	nodes, err := service.VpnAgentService.AgentNodes(r.GetCtx(), req.ServerId, 0)
	if err != nil {
		c.JsonExit(r, 1000, err.Error(), nil)
		return
	}

	c.JsonExit(r, 0, "", nodes)
}

func (c vpnAgentApi) InstallAgentSh(r *ghttp.Request) {
	serverId := r.GetInt("serverId")
	req, err := service.VpnAgentService.GetServerInfo(serverId)
	if err != nil {
		r.Response.WriteExit("#!/usr/bin/env bash\necho \"获取服务器信息失败\"")
		return
	}

	list, err := sysService.SysDictData.DictDataAllList("serverDNS")
	if err != nil {
		r.Response.WriteExit("#!/usr/bin/env bash\necho \"serverDNS 获取失败\"")
		return
	}

	serverDns := ""
	for _, v := range list {
		if v.DictLabel == req.ServerDns {
			serverDns = v.DictValue
		}
	}

	content, _ := os.ReadFile("./config/agentInstall/install.sh")
	sh := strings.Replace(string(content), "{{settings.serverId}}", fmt.Sprint(serverId), 1)
	sh = strings.Replace(sh, "{{settings.serverApiUrl}}", library.GetAgentAPI(), 1)
	sh = strings.Replace(sh, "{{frpCommon.startFrps}}", "true", 1)
	sh = strings.Replace(sh, "{{xrayCommon.commonUuid}}", library.Settings.Agent.CommonUUID, 1)
	sh = strings.Replace(sh, "{{settings.mqttServer}}", library.GetAgentMqtt(), 1)
	sh = strings.Replace(sh, "{{settings.mqttPort}}", "0", 1)
	sh = strings.ReplaceAll(sh, "{{dnsServers}}", serverDns)
	sh = strings.Replace(sh, "{{settings.mqttUser}}", g.Cfg().GetString("mqtt.user"), 1)
	sh = strings.Replace(sh, "{{settings.mqttPass}}", g.Cfg().GetString("mqtt.pass"), 1)
	sh = strings.ReplaceAll(sh, "{{server.docker}}", fmt.Sprintf("curl -sSL %s/agent/install/docker/main.sh", library.GetAgentAPI()))
	sh = strings.ReplaceAll(sh, "{{server.mirrors}}", fmt.Sprintf("curl -sSL %s/agent/install/mirrors/main.sh", library.GetAgentAPI()))
	sh = strings.ReplaceAll(sh, "{{agent_api}}", library.GetAgentAPI())

	shortIds, _ := json.Marshal(library.Settings.Peality.ShortIds)
	sh = strings.ReplaceAll(sh, "{{peality.shortIds}}", string(shortIds))
	sh = strings.ReplaceAll(sh, "{{peality.private}}", library.Settings.Peality.Private)
	sh = strings.ReplaceAll(sh, "{{peality.public}}", library.Settings.Peality.Public)
	r.Response.WriteExit(sh)
}

func (c vpnAgentApi) InstallDocker(r *ghttp.Request) {
	content, _ := os.ReadFile("./config/agentInstall/docker.sh")
	r.Response.WriteExit(string(content))
}

func (c vpnAgentApi) InstallMirrors(r *ghttp.Request) {
	content, _ := os.ReadFile("./config/agentInstall/mirrors.sh")
	r.Response.WriteExit(string(content))
}

func (c vpnAgentApi) Down(r *ghttp.Request) {
	rawPath := r.GetString("fileName")
	fileName := strings.Split(rawPath, "?")[0] // /agent_sing_box.zip

	content, _ := os.ReadFile("./docker/bao/nginx/wwwroot/agent_server/" + fileName)
	r.Response.WriteExit(string(content))
}
