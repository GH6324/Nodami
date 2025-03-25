package mqttserver

import (
	"fmt"
	"gfast/library"
	"gfast/mqttserver/subscription"
	"github.com/gogf/gf/frame/g"
	"sync"
	"time"

	mqtt "github.com/eclipse/paho.mqtt.golang"
)

var onceAgent sync.Once
var clientMu sync.Mutex

func reconnect(client mqtt.Client) {
	if client != nil {
		retryCount := 0
		maxRetries := 50
		retryInterval := 5 * time.Second
		for retryCount < maxRetries {
			g.Log().Infof("Agent 尝试重新连接 MQTT... (第 %d 次重试)", retryCount+1)
			if token := client.Connect(); token.Wait() && token.Error() == nil {
				g.Log().Info("Agent MQTT 重连成功")
				return
			}
			retryCount++
			time.Sleep(retryInterval)
		}
		clientMu.Lock()
		defer clientMu.Unlock()
	}
}

func InitAgentClient() {
	onceAgent.Do(func() {

		opts := mqtt.NewClientOptions().
			AddBroker(g.Cfg().GetString("mqtt.server")).
			SetUsername(g.Cfg().GetString("mqtt.user")).
			SetPassword(g.Cfg().GetString("mqtt.pass")).
			SetClientID(fmt.Sprintf("vpn_server:%s", library.GenerateUniqueID())).
			SetKeepAlive(10 * time.Second).
			SetCleanSession(false).
			SetWriteTimeout(20 * time.Second).
			SetPingTimeout(10 * time.Second).
			SetDefaultPublishHandler(func(client mqtt.Client, msg mqtt.Message) {
				//g.Log().Errorf("Received message: %s from topic: %s\n", msg.Payload(), msg.Topic())
			})

		opts.SetConnectTimeout(10 * time.Second)
		opts.OnConnectionLost = func(client mqtt.Client, err error) {
			g.Log().Error("Agent mqtt 连接丢失")
			reconnect(client)
		}
		opts.OnConnect = func(c mqtt.Client) {
			g.Log().Info("Agent mqtt 连接成功")
			subscription.Subscription(c)
		}
		opts.SetAutoReconnect(false) // 启用自动重连

		client := mqtt.NewClient(opts)
		if token := client.Connect(); token.Wait() && token.Error() != nil {
			g.Log().Panic(token.Error())
		}
	})
	return
}
