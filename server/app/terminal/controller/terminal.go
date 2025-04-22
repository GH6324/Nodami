package controller

import (
	"context"
	"gfast/app/terminal/core"
	"gfast/task"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"net/http"
	"sync"
	"time"

	"github.com/gorilla/websocket"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

// TermWs 获取终端ws
func (s *terminalFile) TermWs(c *ghttp.Request, timeout time.Duration) {
	serverId := c.GetInt("serverId")
	col := c.GetInt("cols", 150)
	row := c.GetInt("rows", 35)
	closeTip := c.GetString("closeTip", "Connection timed out!")
	sshClient, err := core.DecodedMsgToSSHClient(serverId)
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	wsConn, err := upgrader.Upgrade(c.Response.Writer, c.Request, nil)
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	err = sshClient.GenerateClient()
	if err != nil {
		wsConn.WriteMessage(1, []byte(err.Error()))
		wsConn.Close()
		s.FailJsonExit(c, err.Error())
		return
	}
	sshClient.InitTerminal(wsConn, row, col)
	sshClient.Connect(wsConn, timeout, closeTip)
	c.Exit()
}

var wsWriteMu sync.Mutex

func (s *terminalFile) Info(c *ghttp.Request) {
	serverId := c.GetInt("serverId")
	sshClient, err := core.DecodedMsgToSSHClient(serverId)
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}

	wsConn, err := upgrader.Upgrade(c.Response.Writer, c.Request, nil)
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	err = sshClient.GenerateClient()
	if err != nil {
		wsConn.WriteMessage(1, []byte(err.Error()))
		wsConn.Close()
		s.FailJsonExit(c, err.Error())
		return
	}

	writeJSON := func(data interface{}) {
		wsWriteMu.Lock()
		defer wsWriteMu.Unlock()
		_ = wsConn.WriteJSON(data)
	}
	go func() {
		publicIPv4 := sshClient.GetPublicIP()
		publicIPv6 := sshClient.GetPublicIPv6()
		cpuCores, err := sshClient.GetCPUCores()
		if err != nil {
			g.Log().Errorf("获取CPU核心数失败 %s", err)
		}
		writeJSON(g.Map{
			"common": g.Map{
				"publicIPv4": publicIPv4,
				"publicIPv6": publicIPv6,
				"cpuCores":   cpuCores,
			},
		})
	}()

	ctx, cancel := context.WithCancel(context.Background())
	done := make(chan struct{})
	go func() {
		for {
			_, _, err := wsConn.ReadMessage()
			if err != nil {
				cancel()
				close(done)
				sshClient.Close()
				return
			}
		}
	}()

	task.TimerTask(ctx, 1, func() {
		if networkBytes, err := sshClient.GetBandwidth(); err == nil {
			writeJSON(g.Map{"networkBytes": networkBytes})
		} else {
			g.Log().Errorf("获取实时宽带失败 %s", err)
		}
	})

	task.TimerTask(ctx, 10, func() {
		if tcp, udp, err := sshClient.GetConnections(); err == nil {
			writeJSON(g.Map{"connections": g.Map{
				"tcpConnections": tcp,
				"udpConnections": udp,
			}})
		} else {
			g.Log().Errorf("获取连接数失败 %s", err)
		}
	})

	task.TimerTask(ctx, 2, func() {
		if usage, err := sshClient.GetCPUUsage(); err == nil {
			writeJSON(g.Map{"usage": usage})
		} else {
			g.Log().Errorf("获取CPU使用率失败 %s", err)
		}
	})

	task.TimerTask(ctx, 2, func() {
		if mem, swap, err := sshClient.GetMemoryInfo(); err == nil {
			writeJSON(g.Map{"memory": g.Map{
				"mem":  mem,
				"swap": swap,
			}})
		} else {
			g.Log().Errorf("获取内存信息失败 %s", err)
		}
	})

	task.TimerTask(ctx, 30, func() {
		if disk, err := sshClient.GetDiskInfo(); err == nil {
			writeJSON(g.Map{"disk": disk})
		} else {
			g.Log().Errorf("获取磁盘信息失败 %s", err)
		}
	})

	<-done // 阻塞主 goroutine
	c.Exit()
}
