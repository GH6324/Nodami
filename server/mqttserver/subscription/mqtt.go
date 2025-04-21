package subscription

import (
	"common/commonInfo"
	"encoding/json"
	"gfast/app/vpnAgent/service"
	mqtt "github.com/eclipse/paho.mqtt.golang"
	"github.com/sirupsen/logrus"
)

func Subscription(client mqtt.Client) {

	decrypt := func(data []byte, req interface{}) (err error) {
		err = json.Unmarshal(data, req)
		return
	}

	if token := client.Subscribe("/agent/sendTraffics", 1, func(client mqtt.Client, msg mqtt.Message) {
		go func() {
			req := &commonInfo.TrafficsInfo{}
			err := decrypt(msg.Payload(), req)
			if err != nil {
				logrus.Error(err.Error())
				return
			}
			service.VpnAgentService.SendTraffics(req)
		}()

	}); token.Wait() && token.Error() != nil {
		logrus.Error(token.Error())
	}

	if token := client.Subscribe("/agent/sendServerIPs", 1, func(client mqtt.Client, msg mqtt.Message) {
		go func() {
			req := &commonInfo.ServerIPsInfo{}
			err := decrypt(msg.Payload(), req)
			if err != nil {
				logrus.Error(err.Error())
				return
			}
			service.VpnAgentService.PublicIPs(req)
		}()

	}); token.Wait() && token.Error() != nil {
		logrus.Error(token.Error())
	}

	if token := client.Subscribe("/agent/sendServerInfo", 1, func(client mqtt.Client, msg mqtt.Message) {

		go func() {
			req := &commonInfo.ServerInfo{}
			err := decrypt(msg.Payload(), req)
			if err != nil {
				logrus.Error(err.Error())
				return
			}
			service.VpnAgentService.SendServerInfo(req)
		}()
	}); token.Wait() && token.Error() != nil {
		logrus.Error(token.Error())
	}

}
