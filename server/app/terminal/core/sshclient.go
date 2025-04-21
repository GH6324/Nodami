package core

import (
	"fmt"
	"gfast/app/vpn/service"
	"github.com/gorilla/websocket"
	"golang.org/x/crypto/ssh"
	"golang.org/x/net/proxy"
	"log"
	"net"
	"net/url"
	"strconv"
	"strings"
	"time"
)

// DecodedMsgToSSHClient 字符串信息解析为ssh客户端
func DecodedMsgToSSHClient(serverId int) (SSHClient, error) {
	client := SSHClient{}
	s, ok := service.GetServer(serverId, true)
	if !ok {
		err := fmt.Errorf("serverId:%d 不存在", serverId)
		return client, err
	}
	client.Server = s

	return client, nil
}

// GenerateClient 创建ssh客户端
func (sclient *SSHClient) GenerateClient() error {
	var (
		auth         []ssh.AuthMethod
		clientConfig *ssh.ClientConfig
		client       *ssh.Client
		config       ssh.Config
		err          error
	)
	auth = make([]ssh.AuthMethod, 0)
	if strings.ToLower(sclient.Server.LoginType) == "password" {
		auth = append(auth, ssh.Password(sclient.Server.Password))
	} else {
		if signer, err := ssh.ParsePrivateKey([]byte(sclient.Server.PublicKey)); err != nil {
			return err
		} else {
			auth = append(auth, ssh.PublicKeys(signer))
		}
	}
	config = ssh.Config{
		Ciphers: []string{"aes128-ctr", "aes192-ctr", "aes256-ctr", "aes128-gcm@openssh.com", "arcfour256", "arcfour128", "aes128-cbc", "3des-cbc", "aes192-cbc", "aes256-cbc"},
	}
	clientConfig = &ssh.ClientConfig{
		User:    sclient.Server.User,
		Auth:    auth,
		Timeout: 5 * time.Second,
		Config:  config,
		HostKeyCallback: func(hostname string, remote net.Addr, key ssh.PublicKey) error {
			return nil
		},
	}

	if strings.TrimSpace(sclient.Server.ProxyAddr) != "" {
		var proxyAuth *proxy.Auth
		proxyURL, r := url.Parse(strings.TrimSpace(sclient.Server.ProxyAddr))
		if r != nil {
			return r
		}

		if proxyURL.User != nil {
			proxyUser := proxyURL.User.Username()
			proxyPassword, _ := proxyURL.User.Password()
			proxyAuth = &proxy.Auth{
				User:     proxyUser,
				Password: proxyPassword,
			}
		}

		dialer, r := proxy.SOCKS5("tcp", proxyURL.Host, proxyAuth, proxy.Direct)
		if r != nil {
			return r
		}

		conn, r := dialer.Dial("tcp", sclient.Server.SSHAddr)
		if r != nil {
			return r
		}

		clientConn, chans, reqs, r := ssh.NewClientConn(conn, sclient.Server.SSHAddr, clientConfig)
		if r != nil {
			return r
		}

		client = ssh.NewClient(clientConn, chans, reqs)
	} else {
		if client, err = ssh.Dial("tcp", sclient.Server.SSHAddr, clientConfig); err != nil {
			return err
		}
	}

	sclient.Client = client
	return nil
}

// InitTerminal 初始化终端
func (sclient *SSHClient) InitTerminal(ws *websocket.Conn, rows, cols int) *SSHClient {
	sshSession, err := sclient.Client.NewSession()
	if err != nil {
		log.Println(err)
		return nil
	}
	sclient.Session = sshSession
	sclient.StdinPipe, _ = sshSession.StdinPipe()
	wsOutput := new(wsOutput)
	//ssh.stdout and stderr will write output into comboWriter
	sshSession.Stdout = wsOutput
	sshSession.Stderr = wsOutput
	wsOutput.ws = ws
	modes := ssh.TerminalModes{
		ssh.ECHO:          1,
		ssh.TTY_OP_ISPEED: 14400,
		ssh.TTY_OP_OSPEED: 14400,
	}

	if err := sshSession.RequestPty("xterm", rows, cols, modes); err != nil {
		return nil
	}
	if err := sshSession.Shell(); err != nil {
		return nil
	}
	return sclient
}

// Connect ws连接
func (sclient *SSHClient) Connect(ws *websocket.Conn, timeout time.Duration, closeTip string) {
	stopCh := make(chan struct{})
	//这里第一个协程获取用户的输入
	go func() {
		for {
			// p为用户输入
			_, p, err := ws.ReadMessage()
			if err != nil {
				close(stopCh)
				return
			}
			if string(p) == "ping" {
				continue
			}
			if strings.Contains(string(p), "resize") {
				resizeSlice := strings.Split(string(p), ":")
				rows, _ := strconv.Atoi(resizeSlice[1])
				cols, _ := strconv.Atoi(resizeSlice[2])
				err := sclient.Session.WindowChange(rows, cols)
				if err != nil {
					log.Println(err)
					close(stopCh)
					return
				}
				continue
			}
			_, err = sclient.StdinPipe.Write(p)
			if err != nil {
				close(stopCh)
				return
			}
		}
	}()

	defer func() {
		ws.Close()
		sclient.Close()

		if err := recover(); err != nil {
			log.Println(err)
		}
	}()
	// 设置ws超时时间timer
	stopTimer := time.NewTimer(timeout)
	defer stopTimer.Stop()
	// 主循环
	for {
		select {
		case <-stopCh:
			return
		case <-stopTimer.C:
			ws.WriteMessage(1, []byte(fmt.Sprintf("\u001B[33m%s\u001B[0m", closeTip)))
			return
		}
	}
}
