package library

import (
	"encoding/base64"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"gfast/app/common/global"
	"gfast/cache"
	"github.com/gogf/gf/frame/g"
	"golang.org/x/crypto/curve25519"
	"io"
	"math/rand"
	"net/http"
	"strings"
	"time"
)

type settings struct {
	Agent   *SettingsAgent `json:"agent"`
	Peality *Peality       `json:"peality"`
}

type Peality struct {
	ShortIds []string `json:"shortIds"`
	Private  string   `json:"private"`
	Public   string   `json:"public"`
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

func generateShortIDs(count int) []string {
	rand.Seed(time.Now().UnixNano())
	var result []string

	// 只允许 4、6、8 位 hex 长度
	validLens := []int{4, 6, 8}

	for i := 0; i < count; i++ {
		hexLen := validLens[rand.Intn(len(validLens))] // 随机选一个合法长度
		byteLen := hexLen / 2
		b := make([]byte, byteLen)
		rand.Read(b)
		hexStr := hex.EncodeToString(b)
		result = append(result, hexStr)
	}

	return result
}

func curve25519Genkey() (private string, public string) {

	private = "mDdmpD2EO2SiVCF5Az_Q5BF3yMvPEYYtl0HeJQVbNHY"
	public = "pcOQ5dXAHtrxEm9XWcyegrvD-WePPnabWGypgK_CxD8"

	var err error
	var privateKey, publicKey []byte
	var encoding *base64.Encoding
	encoding = base64.RawURLEncoding

	if privateKey == nil {
		privateKey = make([]byte, curve25519.ScalarSize)
		if _, err = rand.Read(privateKey); err != nil {
			return
		}
	}

	privateKey[0] &= 248
	privateKey[31] &= 127
	privateKey[31] |= 64

	if publicKey, err = curve25519.X25519(privateKey, curve25519.Basepoint); err != nil {
		return
	}
	private = encoding.EncodeToString(privateKey)
	public = encoding.EncodeToString(publicKey)

	return
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

	Settings.Peality = &Peality{}
	if cache.Exists(global.SysWebSet + ":pealitynew2") {
		cache.GetToType(global.SysWebSet+":pealitynew2", Settings.Peality)
	}

	if Settings.Peality.ShortIds == nil {
		Settings.Peality.ShortIds = generateShortIDs(10)
	}

	if Settings.Peality.Private == "" || Settings.Peality.Public == "" {
		Settings.Peality.Private, Settings.Peality.Public = curve25519Genkey()
	}

	cache.Set(global.SysWebSet+":pealitynew2", Settings.Peality, 0)
	fmt.Printf("\nShortIds:%v\n", strings.Join(Settings.Peality.ShortIds, "\",\""))
	fmt.Printf("\nPrivate:%v\n", Settings.Peality.Private)
	fmt.Printf("\nPublic:%v\n", Settings.Peality.Public)
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
