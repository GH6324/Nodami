/*
* @desc:测试定时任务
* @company:云南省奇讯科技有限公司
* @Author: yixiaohu
* @Date:   2021/7/16 15:52
 */

package task

import (
	"context"
	"encoding/json"
	"fmt"
	"gfast/app/vpn/dao"
	"gfast/app/vpn/model"
	"gfast/app/vpn/service"
	"gfast/task/queueTraffics"
	"github.com/gogf/gf/frame/g"
	"sync"
	"time"
)

// NodeServersPppoeReStartTask 拨号服务器定时拨号
func NodeServersPppoeReStartTask() {

	vpnServers := make([]model.VpnServer, 0)
	err := dao.VpnServer.DB().Model(dao.VpnServer.Table).
		Where(fmt.Sprintf("DATE_ADD(%s, INTERVAL %s DAY) <= CURDATE()", dao.VpnServer.Columns.PppoeRetime, dao.VpnServer.Columns.PppoeCycle)).
		Where(dao.VpnServer.Columns.PppoeRestart, 1).
		Where(dao.VpnServer.Columns.IsPppoe, 1).
		Where("HOUR(NOW()) = " + dao.VpnServer.Columns.PppoeHour).
		Scan(&vpnServers)
	if err != nil {
		g.Log().Error(err.Error())
		return
	}

	for _, v := range vpnServers {
		x, ok := service.GetServer(v.ServerId, false)
		if ok {
			go x.PppoeReStart(true)
			dao.VpnServer.DB().Model(dao.VpnServer.Table).Where(dao.VpnServer.Columns.ServerId, v.ServerId).Data(dao.VpnServer.Columns.PppoeRetime, time.Now().Format("2006-01-02 15:04:05")).Update()
		}

	}

}

// ServerOnlineTask 服务器在线状态
func ServerOnlineTask() {

	currentTime := time.Now()
	pastTime := currentTime.Add(-60 * time.Second)
	updatedAt := pastTime.Format("2006-01-02 15:04:05")

	_, err := dao.VpnServer.DB().Model(dao.VpnServer.Table).
		Where(fmt.Sprintf("%s <= ?", dao.VpnServer.Columns.UpdatedAt), updatedAt).
		Update(map[string]interface{}{dao.VpnServer.Columns.Status: -1})
	if err != nil {
		g.Log().Error(err.Error())
	}
}

// NodeURLTestTask 节点延迟测试
func NodeURLTestTask() {
	ctx := context.Background()

	vpnNodes := make([]model.VpnNode, 0)
	err := dao.VpnNode.Ctx(ctx).Scan(&vpnNodes)
	if err != nil {
		g.Log().Error(err.Error())
		return
	}

	vpnNodePing := make([]model.VpnNodePing, 0)
	err = dao.VpnNodePing.Ctx(ctx).Scan(&vpnNodePing)
	if err != nil {
		g.Log().Error(err.Error())
		return
	}

	if len(vpnNodePing) == 0 {
		return
	}

	var wg sync.WaitGroup
	concurrencyLimit := 10 // 设置最大并发数量
	sem := make(chan struct{}, concurrencyLimit)

	for _, node := range vpnNodes {
		wg.Add(1)
		sem <- struct{}{}

		go func(node model.VpnNode, vpnNodePing []model.VpnNodePing) {
			defer func() {
				if r := recover(); r != nil {
					g.Log().Error(r.(string))
				}
				wg.Done()
				<-sem
			}()

			pings := make([]model.PingInfo, 0)
			for _, v := range vpnNodePing {
				var sm int
				sm, err = service.VpnNode.SpeedPing(ctx, node.NodeId, v.PingId, false)
				//if err != nil {
				//	g.Log().Error(err.Error())
				//}
				pingMap := model.PingInfo{}
				pingMap.NationName = v.NationName
				pingMap.Ping = sm
				pingMap.PingId = v.PingId
				pings = append(pings, pingMap)
			}

			pingsString, err := json.Marshal(pings)
			if err != nil {
				g.Log().Error(err.Error())
				return
			}

			dao.VpnNode.DB().Model(dao.VpnNode.Table).
				Where(dao.VpnNode.Columns.NodeId, node.NodeId).
				Data(g.Map{
					dao.VpnNode.Columns.Ping: pingsString,
				}).
				Update()

		}(node, vpnNodePing)
	}
	wg.Wait()
}

// GlobalTrafficsTask 节点流量统计
func GlobalTrafficsTask() {

	globalQueueInfos := queueTraffics.GetGlobalQueue().Pop(500)
	var err error
	defer func() {
		if err != nil {
			for _, v := range globalQueueInfos {
				queueTraffics.GetGlobalQueue().Push(v)
			}
		}
	}()

	var wg sync.WaitGroup
	var maxConcurrency = 30
	limitChan := make(chan struct{}, maxConcurrency)

	for _, value := range globalQueueInfos {
		wg.Add(1)
		limitChan <- struct{}{}
		go func(v *queueTraffics.GlobalQueueInfo) {
			defer wg.Done()
			defer func() {
				<-limitChan
			}()
			if v.NodeId > 0 && (v.Up > 0 || v.Down > 0) {
				_, err = g.DB().Model(dao.VpnNode.Table).Where(dao.VpnNode.Columns.NodeId, v.NodeId).
					Data(
						fmt.Sprintf(
							"%s = %s + ?,%s = %s + ?",
							dao.VpnNode.Columns.Up,
							dao.VpnNode.Columns.Up,
							dao.VpnNode.Columns.Down,
							dao.VpnNode.Columns.Down,
						), v.Up, v.Down).
					Update()
				if err != nil {
					g.Log().Error(err)
					return
				}
			}
		}(value)

	}
	wg.Wait()

	sum := queueTraffics.GetGlobalQueue().Sum()
	if sum > 500 {
		g.Log().Warningf("待处理GlobalQueue超过500个")
	}
	if sum > 500 {
		go GlobalTrafficsTask()
	}
}
