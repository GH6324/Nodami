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
	"net"
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
	ServerIpV4 string `json:"serverIpV4"`
	ServerIpV6 string `json:"serverIpV6"`
}

var Settings = new(settings)

func GetPublicIPv4() (string, error) {
	services := []string{
		"https://ipv4.ident.me",
		"https://api.ipify.org",
		"https://ipinfo.io/ip",
		"https://ifconfig.me",
		"https://checkip.amazonaws.com",
	}

	client := http.Client{Timeout: 5 * time.Second}

	for _, url := range services {
		resp, err := client.Get(url)
		if err != nil {
			continue
		}
		body, err := io.ReadAll(resp.Body)
		resp.Body.Close()
		if err != nil {
			continue
		}

		ip := strings.TrimSpace(string(body))
		parsed := net.ParseIP(ip)
		if parsed != nil && parsed.To4() != nil {
			return ip, nil
		}
	}

	return "", errors.New("failed to retrieve public IPv4")
}
func GetPublicIPv6() (string, error) {
	services := []string{
		"https://ipv6.ident.me",
		"https://api64.ipify.org",
		"https://ifconfig.me", // 会根据客户端优先级返回 IPv6
	}

	client := http.Client{Timeout: 5 * time.Second}

	for _, url := range services {
		resp, err := client.Get(url)
		if err != nil {
			continue
		}
		body, err := io.ReadAll(resp.Body)
		resp.Body.Close()
		if err != nil {
			continue
		}

		ip := strings.TrimSpace(string(body))
		parsed := net.ParseIP(ip)
		if parsed != nil && parsed.To4() == nil {
			return fmt.Sprintf("%s", ip), nil
		}
	}

	return "", errors.New("failed to retrieve public IPv6")
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

	if strings.TrimSpace(Settings.Agent.ServerIpV4) == "" {
		Settings.Agent.ServerIpV4, err = GetPublicIPv4()
		if err != nil {
			g.Log().Errorf(err.Error())
		}
	}
	if strings.TrimSpace(Settings.Agent.ServerIpV6) == "" {
		Settings.Agent.ServerIpV6, err = GetPublicIPv6()
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

func GetAgentAPI(isIpv6 bool) string {
	if g.Cfg().GetString("debug.ip") != "" {
		return fmt.Sprintf("http://%s:%d", g.Cfg().GetString("debug.ip"), g.Cfg().GetInt("debug.api"))
	}
	if isIpv6 {
		return fmt.Sprintf("http://%s:%d", TrimSpaceIpv6(Settings.Agent.ServerIpV6), 18080)
	}
	return fmt.Sprintf("http://%s:%d", strings.TrimSpace(Settings.Agent.ServerIpV4), 18080)

}

func GetAgentMqtt(isIpv6 bool) string {
	if g.Cfg().GetString("debug.ip") != "" {
		return fmt.Sprintf("tcp://%s:%d", g.Cfg().GetString("debug.ip"), g.Cfg().GetInt("debug.mqtt"))
	}
	if isIpv6 {
		return fmt.Sprintf("tcp://%s:%d", TrimSpaceIpv6(Settings.Agent.ServerIpV6), 1883)
	}
	return fmt.Sprintf("tcp://%s:%d", strings.TrimSpace(Settings.Agent.ServerIpV4), 1883)
}
