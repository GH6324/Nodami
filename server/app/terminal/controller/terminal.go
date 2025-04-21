package controller

import (
	"gfast/app/terminal/core"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"net/http"
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

	publicIPv4 := sshClient.GetPublicIP()
	publicIPv6 := sshClient.GetPublicIPv6()

	ticker := time.NewTicker(1 * time.Second)
	defer ticker.Stop()

	done := make(chan struct{})
	go func() {
		for {
			_, _, err = wsConn.ReadMessage()
			if err != nil {
				close(done)
				sshClient.Close()
				return
			}
		}
	}()

	for {
		select {
		case <-done:
			return
		case <-ticker.C:
			var serverInfo *core.ServerInfo
			serverInfo, err = sshClient.GetServerInfo()
			if err != nil {
				g.Log().Errorf(err.Error())
				continue
			}
			serverInfo.PublicIPv4 = publicIPv4
			serverInfo.PublicIPv6 = publicIPv6

			err = wsConn.WriteJSON(serverInfo)
			if err != nil {
				g.Log().Errorf(err.Error())
				return
			}
		}
	}

	c.Exit()
}
