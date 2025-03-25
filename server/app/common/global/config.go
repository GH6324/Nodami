package global

import (
	"encoding/json"
	"errors"
	"fmt"
	"github.com/gogf/gf/frame/g"
	"io"
	"net/http"
	"strings"
	"time"
)

type settings struct {
	Agent *SettingsAgent `json:"agent"`
}

type SettingsAgent struct {
	CommonUUID string `json:"commonUUID"`
	ServerIp   string `json:"serverIp"`
}

var Settings = new(settings)

func getPublicIP() (string, error) {
	services := []string{
		"https://api.ipify.org",
		"https://ipinfo.io/ip",
		"https://ifconfig.me",
		"https://checkip.amazonaws.com",
	}

	client := http.Client{
		Timeout: 5 * time.Second,
	}

	for _, url := range services {
		resp, err := client.Get(url)
		if err != nil {
			continue
		}
		defer resp.Body.Close()

		body, err := io.ReadAll(resp.Body)
		if err != nil {
			continue
		}

		ip := strings.TrimSpace(string(body))
		if ip != "" {
			return ip, nil
		}
	}

	return "", errors.New("failed to get public IP from all services")
}

func SetSettings(jsonData []byte) error {

	err := json.Unmarshal(jsonData, &Settings)
	if err != nil {
		return err
	}

	if Settings.Agent.ServerIp == "" {
		Settings.Agent.ServerIp, err = getPublicIP()
		if err != nil {
			g.Log().Errorf(err.Error())
		}
	}

	return nil
}

func GetAgentAPI() string {
	return fmt.Sprintf("http://%s:%d", Settings.Agent.ServerIp, 18080)
	//return fmt.Sprintf("http://%s:%d", "13.200.154.248", 18200)
}

func GetAgentMqtt() string {
	return fmt.Sprintf("tcp://%s:%d", Settings.Agent.ServerIp, 1883)
	//return fmt.Sprintf("tcp://%s:%d", "13.200.154.248", 11190)
}
