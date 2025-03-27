package service

import (
	"common/commonInfo"
	"context"
	"encoding/json"
	"fmt"
	"gfast/app/common/global"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"
	"gfast/cache"
	"gfast/library"
	"github.com/gogf/gf/frame/g"
	"math/rand"
	"time"
)

type vpnNodeService struct {
}

var VpnNodeService = new(vpnNodeService)

func (c *vpnNodeService) Nodes(ctx context.Context, nodeId int, serverId ...int) (nodeModels []*model.VpnNodeInfo, err error) {
	nodeModels = make([]*model.VpnNodeInfo, 0)
	m := dao.VpnNode.Ctx(ctx).
		LeftJoin(dao.VpnServer.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnServer.Table, dao.VpnServer.Columns.ServerId, dao.VpnNode.Table, dao.VpnNode.Columns.ServerId)).
		LeftJoin(fmt.Sprintf("%s as frpServer", dao.VpnServer.Table), fmt.Sprintf("frpServer.%s=%s.%s", dao.VpnServer.Columns.ServerId, dao.VpnNode.Table, dao.VpnNode.Columns.FrpServerId)).
		LeftJoin(dao.VpnNodeNation.Table, fmt.Sprintf("%s.%s=%s.%s", dao.VpnNode.Table, dao.VpnNode.Columns.NationId, dao.VpnNodeNation.Table, dao.VpnNodeNation.Columns.NationId))

	m = m.Where(fmt.Sprintf("%s.%s >0 ", dao.VpnNode.Table, dao.VpnNode.Columns.NodeId))

	if serverId != nil && len(serverId) > 0 {
		m = m.Where(fmt.Sprintf("%s.%s = ? or (%s.%s in (SELECT %s FROM vpn_node_transfer WHERE entrance_server_id = ? or exit_server_id  = ?))",
			dao.VpnNode.Table,
			dao.VpnNode.Columns.ServerId,
			dao.VpnNode.Table,
			dao.VpnNode.Columns.NodeId,
			dao.VpnNode.Columns.NodeId,
		), serverId[0], serverId[0], serverId[0])
	}

	if nodeId > 0 {
		m = m.Where(fmt.Sprintf("%s.%s  = ? ", dao.VpnNode.Table, dao.VpnNode.Columns.NodeId), nodeId)
	}

	fields := make([]string, 0)
	fields = append(fields, dao.VpnNode.Fields(true, true)...)
	fields = append(fields,
		fmt.Sprintf("%s.%s as %s", dao.VpnServer.Table, dao.VpnServer.Columns.ServerIp, dao.VpnServer.Columns.ServerIp),
		fmt.Sprintf("%s.%s as frpServerIp", "frpServer", dao.VpnServer.Columns.ServerIp),
		fmt.Sprintf("%s.%s  as %s", dao.VpnNodeNation.Table, dao.VpnNodeNation.Columns.NationName, dao.VpnNodeNation.Columns.NationName),
		fmt.Sprintf("%s.%s  as %s", dao.VpnNodeNation.Table, dao.VpnNodeNation.Columns.NationImg, dao.VpnNodeNation.Columns.NationImg),
	)

	err = m.Fields(fields).Scan(&nodeModels)
	if err != nil {
		return
	}

	for _, v := range nodeModels {
		v.Transfers = make([]model.VpnNodeTransfer, 0)
		key := fmt.Sprintf("%s:transfers:nodeId:%d", global.CacheAgent, v.NodeId)
		if cache.Exists(key) {
			cache.GetToType(key, &v.Transfers)
		} else {
			dao.VpnNodeTransfer.Ctx(ctx).Where(dao.VpnNodeTransfer.Columns.NodeId, v.NodeId).Order(dao.VpnNodeTransfer.Columns.TransferId + " ASC").Scan(&v.Transfers)
			if v.Transfers != nil && len(v.Transfers) > 0 {
				cache.Set(key, v.Transfers, 10)
			}
		}

	}

	return
}

func (c *vpnNodeService) GetClashProxies(ctx context.Context, nodeId int) (proxies []*dao.Proxie, err error) {

	nodes, err := c.Nodes(ctx, nodeId)
	if err != nil {
		return
	}
	if len(nodes) == 0 {
		err = fmt.Errorf("没有可用节点 请先添加节点")
		return
	}

	proxies = make([]*dao.Proxie, 0)

	for _, node := range nodes {
		proxie := &dao.Proxie{
			Name:           fmt.Sprintf("%s:%d", node.NationName, node.NodeId),
			UDP:            true,
			Port:           node.VpnPort,
			Server:         node.ServerIp,
			SkipCertVerify: true,
		}

		if node.TransportProtocol != "" && (node.Protocol == commonInfo.Protocol_VMess || node.Protocol == commonInfo.Protocol_VLess || node.Protocol == commonInfo.Protocol_Trojan) {

			proxie.TLS = true
			proxie.ClientFingerprint = "chrome"
			proxie.ServerName = node.StreamSettingsHost
			proxie.Sni = node.StreamSettingsHost

			if node.TransportProtocol == "websocket" {
				proxie.Network = "ws"
				proxie.WsOpts = &dao.WsOpts{}
				proxie.WsOpts.Path = node.StreamSettingsPath
				proxie.WsOpts.Headers = map[string]interface{}{
					"Host": node.StreamSettingsHost,
				}
			}

			if node.TransportProtocol == "grpc" {
				proxie.Network = "grpc"
				proxie.GrpcOpts = &dao.GrpcOpts{
					GrpcServiceName: node.StreamSettingsServiceName,
				}

				if node.StreamSettingsReality == 1 && node.Protocol != commonInfo.Protocol_VMess {
					proxie.RealityOpts = &dao.RealityOpts{
						PublicKey: library.Settings.Peality.Public,
						ShortId:   library.Settings.Peality.ShortIds[rand.New(rand.NewSource(time.Now().UnixNano())).Intn(len(library.Settings.Peality.ShortIds))],
					}
				}
			}
		}

		mationNameMap := make(map[string]string)
		r := json.Unmarshal([]byte(node.NationName), &mationNameMap)
		if r == nil {
			if v, ok := mationNameMap["zh_cn"]; ok {
				proxie.Name = fmt.Sprintf("%s#%d", v, node.NodeId)
			}
		}

		if node.FrpServerId > 0 && node.FrpProtocol != "" {
			proxie.Server = node.FrpServerIp
			proxie.Port = node.FrpPort
		}

		if len(node.Transfers) > 0 && node.TransitProtocol != "" {
			proxie.Server = node.Transfers[0].EntranceServerIp
			proxie.Port = node.TransitPort
		}

		pass := library.Settings.Agent.CommonUUID
		if node.Protocol == commonInfo.Protocol_VMess {
			alterID := 0
			proxie.AlterID = &alterID
			proxie.Type = "vmess"
			proxie.Cipher = "auto"
			proxie.UUID = pass
		}

		if node.Protocol == commonInfo.Protocol_VLess {
			proxie.Type = "vless"
			proxie.UUID = pass
		}

		if node.Protocol == commonInfo.Protocol_Trojan {
			proxie.Type = "trojan"
			proxie.Password = pass
		}

		if node.Protocol == commonInfo.Protocol_Shadowsocks {
			proxie.Type = "ss"
			proxie.Cipher = node.Method
			proxie.Password = commonInfo.ShadowsocksPass(proxie.Cipher, pass)

		}

		if node.Protocol == commonInfo.Protocol_Socks {
			proxie.Type = "socks5"
			proxie.UserName = commonInfo.GetUidNodeIdCodeTOEmail(node.NodeId)
			proxie.Password = pass
		}

		if node.Protocol == commonInfo.Protocol_Hysteria {
			proxie.Type = "hysteria2"
			proxie.Password = pass
			proxie.Sni = "www.bing.com"
		}

		proxies = append(proxies, proxie)
	}

	return
}

func (c *vpnNodeService) GetAppClashConfig(ctx context.Context) (config *dao.ClashConfig, err error) {

	proxies, err := c.GetClashProxies(ctx, 0)
	if err != nil {
		return
	}

	config = &dao.ClashConfig{
		Mode:              "rule",
		LogLevel:          g.Cfg().GetString("server.clashLevel"),
		Secret:            "",
		AllowLan:          true,
		TcpConcurrent:     true,
		IPv6:              false,
		GeoDataMode:       false,
		GeoAutoUpdate:     false,
		GeoUpdateInterval: 24,
		Proxies:           []*dao.Proxie{},
		Profile: &dao.Profile{
			StoreSelected: true,
			StoreFakeIp:   true,
		},
		ProxyGroups: []*dao.Group{
			{
				Name: "直连",
				Type: "select",
				Proxies: []string{
					"DIRECT",
				},
			},
			{
				Name: "禁止",
				Type: "select",
				Proxies: []string{
					"REJECT",
				},
			},
		},
		Rules: []string{
			"IP-CIDR,127.0.0.1/32,直连,no-resolve",
			"GEOIP,CN,中国大陆选择",
			//"GEOSITE,cn,中国大陆选择",
			"MATCH,海外流量选择",
		},

		GeoxUrl: &dao.GeoxUrlStruct{
			GeoIpUrl:   "https://vlink-hk.oss-cn-hongkong.aliyuncs.com/geoip.dat",
			GeoSiteUrl: "https://vlink-hk.oss-cn-hongkong.aliyuncs.com/geosite.dat",
		},
	}

	config.Dns = dao.Dns{
		Enable:       true,
		IPv6:         false,
		PreferH3:     true,
		Listen:       ":7893",
		EnhancedMode: "fake-ip", //fake-ip redir-host
		//FakeIpRange:  "200.0.0.1/8",
		FakeIpFilter: []string{
			"*.lan",
		},
		UseHosts: true,
		DefaultNameserver: []string{
			"114.114.114.114#直连",
			"8.8.8.8#直连",
			"114.114.115.115#直连",
			"8.8.4.4#直连",
			"https://101.6.6.6:8443/dns-query#select&skip-cert-verify=true",
			"https://8.8.8.8/dns-query#select&skip-cert-verify=true",
			"https://223.5.5.5/dns-query#select&skip-cert-verify=true",
			"https://45.11.45.11/dns-query/dns-query#select&skip-cert-verify=true",
			"https://120.53.53.53/dns-query#select&skip-cert-verify=true",
			"https://8.8.8.8/dns-query#直连",
			"https://185.222.222.222/dns-query#直连",
		},
		ProxyServerNameServer: []string{
			"114.114.114.114",
			"8.8.8.8",
			"114.114.115.115",
			"8.8.4.4",
		},
		Nameserver: []string{
			"https://101.6.6.6:8443/dns-query#select&skip-cert-verify=true",
			"https://8.8.8.8/dns-query#select&skip-cert-verify=true",
			"https://223.5.5.5/dns-query#select&skip-cert-verify=true",
			"https://45.11.45.11/dns-query/dns-query#select&skip-cert-verify=true",
			"https://120.53.53.53/dns-query#select&skip-cert-verify=true",
			"https://8.8.8.8/dns-query#直连",
			"https://185.222.222.222/dns-query#直连",
			"8.8.8.8#直连",
			"8.8.4.4#直连",
		},
	}

	selectGroup := &dao.Group{
		Name: "海外流量选择",
		Type: "select",
		Proxies: []string{
			"故障自动转移",
			"自动选择最快",
			"直连",
			"禁止",
		},
	}
	cnGroup := &dao.Group{
		Name: "中国大陆选择",
		Type: "select",
		Proxies: []string{
			"故障自动转移",
			"自动选择最快",
			"直连",
			"禁止",
		},
	}

	urltest := &dao.Group{
		Name:    "自动选择最快",
		Type:    "url-test",
		Proxies: []string{},
	}
	fallback := &dao.Group{
		Name: "故障自动转移",
		Type: "fallback",
		Proxies: []string{
			"自动选择最快",
		},
	}

	config.ProxyGroups = append(config.ProxyGroups, []*dao.Group{
		selectGroup, cnGroup, urltest, fallback,
	}...)

	for _, v := range proxies {
		config.Proxies = append(config.Proxies, v)
		selectGroup.Proxies = append(selectGroup.Proxies, v.Name)
		urltest.Proxies = append(urltest.Proxies, v.Name)
		fallback.Proxies = append(fallback.Proxies, v.Name)
		cnGroup.Proxies = append(cnGroup.Proxies, v.Name)
	}

	return
}
