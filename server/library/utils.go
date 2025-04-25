package library

import (
	"context"
	"crypto/md5"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"gfast/cache"
	"io"
	"log"
	"math"
	"math/rand"
	"net"
	"net/url"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strings"
	"sync"
	"time"

	"github.com/cloudflare/cloudflare-go"
	"github.com/gogf/gf/crypto/gmd5"
	"github.com/gogf/gf/database/gdb"
	"github.com/gogf/gf/encoding/gcharset"
	"github.com/gogf/gf/encoding/gjson"
	"github.com/gogf/gf/encoding/gurl"
	"github.com/gogf/gf/errors/gerror"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/os/gtime"
	"github.com/gogf/gf/text/gstr"
	"github.com/gogf/gf/util/gconv"
	"github.com/google/uuid"
	"github.com/oschwald/geoip2-golang"
)

// 获取设备的 MAC 地址
func GetMacAddress() string {
	interfaces, err := net.Interfaces()
	if err != nil {
		log.Fatal(err)
	}
	for _, i := range interfaces {
		if i.HardwareAddr != nil && len(i.HardwareAddr.String()) > 0 {
			return i.HardwareAddr.String()
		}
	}
	return ""
}

// 基于 MAC 地址生成唯一 ID
func GenerateUniqueID() string {
	hash := sha256.Sum256([]byte(GetMacAddress()))
	return hex.EncodeToString(hash[:]) // 转为十六进制字符串
}

func NewPromotionCode() string {
	u := uuid.New()
	hasher := md5.New()
	hasher.Write(u[:])
	hash := hasher.Sum(nil)
	hashStr := hex.EncodeToString(hash)
	shortID := strings.ToLower(hashStr[:6])
	key := fmt.Sprintf("PromotionCode:%s", shortID)
	if !cache.Exists(key) {
		return shortID
	}
	return NewPromotionCode()
}

func CipherPass(pass string) string {
	hasher := md5.New()
	hasher.Write([]byte(pass + "12wq"))
	return hex.EncodeToString(hasher.Sum(nil))
}

func RoundTo(val float64, decimalPlaces int) float64 {
	shift := math.Pow(10, float64(decimalPlaces))
	return math.Round(val*shift) / shift
}

// 密码加密
func EncryptPassword(password, salt string) string {
	return gmd5.MustEncryptString(gmd5.MustEncryptString(password) + gmd5.MustEncryptString(salt))
}

// 时间戳转 yyyy-MM-dd HH:mm:ss
func TimeStampToDateTime(timeStamp int64) string {
	tm := gtime.NewFromTimeStamp(timeStamp)
	return tm.Format("Y-m-d H:i:s")
}

// 时间戳转 yyyy-MM-dd
func TimeStampToDate(timeStamp int64) string {
	tm := gtime.NewFromTimeStamp(timeStamp)
	return tm.Format("Y-m-d")
}

// 获取当前请求接口域名
func GetDomain(r *ghttp.Request) (string, error) {
	pathInfo, err := gurl.ParseURL(r.GetUrl(), -1)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("解析附件路径失败")
		return "", err
	}
	return fmt.Sprintf("%s://%s:%s/", pathInfo["scheme"], pathInfo["host"], pathInfo["port"]), nil
}

// 获取客户端IP
func GetClientIp(r *ghttp.Request) string {
	ip := r.Header.Get("X-Forwarded-For")
	if ip == "" {
		ip = r.GetClientIp()
	}
	return ip
}

// 服务端ip
func GetLocalIP() (ip string, err error) {
	addrs, err := net.InterfaceAddrs()
	if err != nil {
		return
	}
	for _, addr := range addrs {
		ipAddr, ok := addr.(*net.IPNet)
		if !ok {
			continue
		}
		if ipAddr.IP.IsLoopback() {
			continue
		}
		if !ipAddr.IP.IsGlobalUnicast() {
			continue
		}
		return ipAddr.IP.String(), nil
	}
	return
}

func StructToMap(input interface{}) (map[string]interface{}, error) {
	jsonString, err := json.Marshal(input)
	if err != nil {
		return nil, err
	}
	var result map[string]interface{}
	err = json.Unmarshal(jsonString, &result)

	return result, err
}

// 获取ip所属城市
func GetCityByIp2(ip string) string {
	if ip == "" {
		return ""
	}
	if ip == "[::1]" || ip == "127.0.0.1" {
		return "内网IP"
	}
	url := "http://whois.pconline.com.cn/ipJson.jsp?json=true&ip=" + ip
	bytes := g.Client().GetBytes(url)
	src := string(bytes)
	srcCharset := "GBK"
	tmp, _ := gcharset.ToUTF8(srcCharset, src)
	json, err := gjson.DecodeToJson(tmp)
	if err != nil {
		return ""
	}
	if json.GetInt("code") == 0 {
		city := fmt.Sprintf("%s %s", json.GetString("pro"), json.GetString("city"))
		return city
	} else {
		return ""
	}
}

func GetCityByIp(ip string) string {

	db, err := geoip2.Open("config/GeoLite2-City.mmdb")
	if err != nil {
		return GetCityByIp2(ip)
	}
	defer db.Close()

	ipnew := net.ParseIP(ip)
	ipInfo, err := db.City(ipnew)
	if err != nil {
		return GetCityByIp2(ip)
	}

	city, ok := ipInfo.City.Names["zh-CN"]
	if !ok || len(city) == 0 {
		city = ipInfo.City.Names["en"]
	}
	if city != "" {
		return city
	}

	if len(ipInfo.Subdivisions) > 0 {
		city, ok = ipInfo.Subdivisions[0].Names["zh-CN"]
		if !ok || len(city) == 0 {
			city, _ = ipInfo.Subdivisions[0].Names["en"]
		}
		if city != "" {
			return city
		}
	}

	city, ok = ipInfo.Country.Names["zh-CN"]
	if !ok || len(city) == 0 {
		city, _ = ipInfo.Country.Names["en"]
	}
	if city != "" {
		return city
	}

	return GetCityByIp2(ip)
}

func GetCountryByIp(ip string) string {

	db, err := geoip2.Open("config/GeoLite2-City.mmdb")
	if err != nil {
		return GetCityByIp2(ip)
	}
	defer db.Close()

	ipnew := net.ParseIP(ip)
	ipInfo, err := db.City(ipnew)
	if err != nil {
		return GetCityByIp2(ip)
	}

	country, ok := ipInfo.Country.Names["zh-CN"]
	if !ok || len(country) == 0 {
		country, _ = ipInfo.Country.Names["en"]
	}
	if country != "" {
		return country
	}

	return ""
}

// 日期字符串转时间戳（秒）
func StrToTimestamp(dateStr string) int64 {
	tm, err := gtime.StrToTime(dateStr)
	if err != nil {
		g.Log().Error(err)
		return 0
	}
	return tm.Timestamp()
}

// GetDbConfig get db config
func GetDbConfig() (cfg *gdb.ConfigNode, err error) {
	cfg = g.DB().GetConfig()
	err = ParseDSN(cfg)
	return
}

// ParseDSN parses the DSN string to a Config
func ParseDSN(cfg *gdb.ConfigNode) (err error) {
	defer func() {
		if r := recover(); r != nil {
			err = gerror.New(r.(string))
		}
	}()
	dsn := cfg.Link
	if dsn == "" {
		return
	}
	foundSlash := false
	// gfast:123456@tcp(192.168.0.212:3306)/gfast-v2
	for i := len(dsn) - 1; i >= 0; i-- {
		if dsn[i] == '/' {
			foundSlash = true
			var j, k int

			// left part is empty if i <= 0
			if i > 0 {
				// [username[:password]@][protocol[(address)]]
				// Find the last '@' in dsn[:i]
				for j = i; j >= 0; j-- {
					if dsn[j] == '@' {
						// username[:password]
						// Find the first ':' in dsn[:j]
						for k = 0; k < j; k++ {
							if dsn[k] == ':' {
								cfg.Pass = dsn[k+1 : j]
								cfg.User = dsn[:k]
								break
							}
						}
						break
					}
				}

				// gfast:123456@tcp(192.168.0.212:3306)/gfast-v2
				// [protocol[(address)]]
				// Find the first '(' in dsn[j+1:i]
				var h int
				for k = j + 1; k < i; k++ {
					if dsn[k] == '(' {
						// dsn[i-1] must be == ')' if an address is specified
						if dsn[i-1] != ')' {
							if strings.ContainsRune(dsn[k+1:i], ')') {
								panic("invalid DSN: did you forget to escape a param value?")
							}
							panic("invalid DSN: network address not terminated (missing closing brace)")
						}
						for h = k + 1; h < i-1; h++ {
							if dsn[h] == ':' {
								cfg.Host = dsn[k+1 : h]
								cfg.Port = dsn[h+1 : i-1]
								break
							}
						}
						break
					}
				}
			}
			for j = i + 1; j < len(dsn); j++ {
				if dsn[j] == '?' {
					cfg.Name = dsn[i+1 : j]
					break
				} else {
					cfg.Name = dsn[i+1:]
				}
			}
			break
		}
	}
	if !foundSlash && len(dsn) > 0 {
		panic("invalid DSN: missing the slash separating the database name")
	}
	return
}

// 获取附件真实路径
func GetRealFilesUrl(r *ghttp.Request, path string) (realPath string, err error) {
	if gstr.ContainsI(path, "http") {
		realPath = path
		return
	}
	realPath, err = GetDomain(r)
	if err != nil {
		return
	}
	realPath = realPath + path
	return
}

// 获取附件相对路径
func GetFilesPath(fileUrl string) (path string, err error) {
	upType := gstr.ToLower(g.Cfg().GetString("upload.type"))
	upPath := gstr.Trim(g.Cfg().GetString("upload.local.UpPath"), "/")
	if upType != "local" || (upType == "local" && !gstr.ContainsI(fileUrl, upPath)) {
		path = fileUrl
		return
	}
	pathInfo, err := gurl.ParseURL(fileUrl, 32)
	if err != nil {
		g.Log().Error(err)
		err = gerror.New("解析附件路径失败")
		return
	}
	pos := gstr.PosI(pathInfo["path"], upPath)
	if pos >= 0 {
		path = gstr.SubStr(pathInfo["path"], pos)
	}
	return
}

// 货币转化为分
func CurrencyLong(currency interface{}) int64 {
	strArr := gstr.Split(gconv.String(currency), ".")
	switch len(strArr) {
	case 1:
		return gconv.Int64(strArr[0]) * 100
	case 2:
		if len(strArr[1]) == 1 {
			strArr[1] += "0"
		} else if len(strArr[1]) > 2 {
			strArr[1] = gstr.SubStr(strArr[1], 0, 2)
		}
		return gconv.Int64(strArr[0])*100 + gconv.Int64(strArr[1])
	}
	return 0
}

func GetExcPath() string {
	file, _ := exec.LookPath(os.Args[0])
	// 获取包含可执行文件名称的路径
	path, _ := filepath.Abs(file)
	// 获取可执行文件所在目录
	index := strings.LastIndex(path, string(os.PathSeparator))
	ret := path[:index]
	return strings.Replace(ret, "\\", "/", -1)
}

func RandomNumberInRange(min, max int) int {
	if min >= max {
		return min // 防止非法范围
	}
	rand.Seed(time.Now().UnixNano())
	return rand.Intn(max-min+1) + min
}

var locks = make(map[string]*sync.RWMutex) // 这里修改成存储 *sync.Mutex
var lock sync.RWMutex

func GetKeyLock(key string, a ...interface{}) *sync.RWMutex { // 返回 *sync.Mutex
	if a != nil {
		for _, v := range a {
			key += fmt.Sprintf(":%v", v)
		}
	}

	getKeyLock := func(key string) (mutex *sync.RWMutex, ok bool) { // 返回 *sync.Mutex
		lock.RLock()
		defer lock.RUnlock()
		mutex, ok = locks[key]
		return
	}

	addKeyLock := func(key string) *sync.RWMutex { // 返回 *sync.Mutex
		lock.Lock()
		defer lock.Unlock()
		mutex := &sync.RWMutex{} // 创建一个 *sync.Mutex
		locks[key] = mutex
		return mutex
	}

	mutex, ok := getKeyLock(key)
	if !ok {
		mutex = addKeyLock(key)
	}
	return mutex
}

// 范围随机数字
func RandomBetweenWithExclusion(min, max int, exclusions []int) int {
	src := rand.NewSource(time.Now().UnixNano())
	exclusionMap := make(map[int]struct{})
	for _, e := range exclusions {
		exclusionMap[e] = struct{}{}
	}

	var numbers []int
	for i := min; i <= max; i++ {
		if _, excluded := exclusionMap[i]; !excluded {
			numbers = append(numbers, i)
		}
	}

	if len(numbers) == 0 {
		return 0
	}

	r := rand.New(src)
	return numbers[r.Intn(len(numbers))]
}

func CalculateDaysAfterMonths(months int) int {
	// 获取当前时间
	now := time.Now()

	// 计算months个月后的日期
	afterMonths := now.AddDate(0, months, 0)

	// 计算并返回两个日期之间的天数差
	// 这里使用afterMonths.Sub(now)来获取时间差，然后转换为天数
	days := afterMonths.Sub(now).Hours() / 24

	// 因为返回类型是int，所以对结果进行取整
	return int(days)
}

func Md5Sting(s ...interface{}) string {
	Md5 := md5.New()
	sv := ""
	for _, v := range s {
		sv += fmt.Sprint(v)
	}
	io.WriteString(Md5, sv)
	rst := fmt.Sprintf("%x", Md5.Sum(nil))
	return fmt.Sprintf(rst)
}

func SetCloudflareDns(apiKey, email, zoneName, domainName, recordContent string, proxied bool) (err error) {

	api, err := cloudflare.New(apiKey, email)
	if err != nil {
		return
	}

	zoneID, err := api.ZoneIDByName(zoneName)
	if err != nil {
		return
	}
	rc := &cloudflare.ResourceContainer{
		Level:      cloudflare.ZoneRouteLevel, // 使用 Zone 路由级别
		Identifier: zoneID,                    // 使用 Zone ID 作为标识符
		Type:       cloudflare.ZoneType,       // 资源类型为 Zone
	}

	records, _, err := api.ListDNSRecords(context.Background(), rc, cloudflare.ListDNSRecordsParams{
		Type: "A",
		Name: domainName,
	})
	if err != nil {
		return
	}

	if len(records) > 0 {

		for _, v := range records {
			params := cloudflare.UpdateDNSRecordParams{
				ID:      v.ID,
				Type:    v.Type,
				Name:    v.Name,
				Content: recordContent,
				TTL:     120,      // 时间生存期
				Proxied: &proxied, //开启代理
			}

			_, err = api.UpdateDNSRecord(context.Background(), rc, params)
			if err != nil {
				return
			}
		}
	} else {
		// 设置 DNS 记录的参数
		params := cloudflare.CreateDNSRecordParams{
			Type:      "A",
			Name:      domainName,
			Content:   recordContent,
			TTL:       120, // 时间生存期
			ZoneID:    zoneID,
			Proxied:   &proxied, //开启代理
			Proxiable: true,
		}
		// 添加 DNS 记录
		_, err = api.CreateDNSRecord(context.Background(), rc, params)
		if err != nil {
			return
		}
	}
	return
}

func DelCloudflareDns(apiKey, email, zoneName, domainName string) (err error) {
	api, err := cloudflare.New(apiKey, email)
	if err != nil {
		return
	}

	zoneID, err := api.ZoneIDByName(zoneName)
	if err != nil {
		return
	}
	rc := &cloudflare.ResourceContainer{
		Level:      cloudflare.ZoneRouteLevel, // 使用 Zone 路由级别
		Identifier: zoneID,                    // 使用 Zone ID 作为标识符
		Type:       cloudflare.ZoneType,       // 资源类型为 Zone
	}

	records, _, err := api.ListDNSRecords(context.Background(), rc, cloudflare.ListDNSRecordsParams{
		Type: "A",
		Name: domainName,
	})
	if err != nil {
		return
	}

	if len(records) > 0 {
		for _, v := range records {
			err = api.DeleteDNSRecord(context.Background(), rc, v.ID)
			if err != nil {
				return
			}
		}
	}
	return
}

func SubSeconds(t1, t2 *gtime.Time, n int) bool {
	if t1 == nil || t2 == nil {
		return true // Handle nil pointers gracefully.
	}
	duration := t2.Sub(t1)

	return duration.Seconds() >= float64(n)
}

func UrlAddQueryParams(baseURL string, params map[string]interface{}) (string, error) {
	// 解析URL
	u, err := url.Parse(baseURL)
	if err != nil {
		return "", err
	}

	// 获取现有的查询参数
	q := u.Query()

	// 添加新的参数
	for key, value := range params {
		q.Set(key, fmt.Sprint(value))
	}

	// 将查询参数编码回URL
	u.RawQuery = q.Encode()

	return u.String(), nil
}

func GetNextMonthFirst() time.Time {
	now := time.Now()

	// 获取当前的年份和月份
	year, month, _ := now.Date()

	// 计算下个月的年份和月份
	nextMonth := month + 1
	if nextMonth > 12 {
		nextMonth = 1
		year++
	}

	// 创建下个月1号的时间对象
	firstOfNextMonth := time.Date(year, nextMonth, 1, 0, 0, 0, 0, time.Local)
	return firstOfNextMonth
}

func MapValuesToList[K int | string, V any](m map[K]V) []V {
	// 提取所有的 keys
	keys := make([]K, 0, len(m))
	for k := range m {
		keys = append(keys, k)
	}

	// 对 keys 进行降序排序
	sort.Slice(keys, func(i, j int) bool {
		return keys[i] > keys[j] // 降序排列
	})

	// 按排序后的 keys 顺序提取 values
	values := make([]V, 0, len(m))
	for _, k := range keys {
		values = append(values, m[k])
	}

	return values
}

func IsIPv6(ipStr string) bool {
	ipStr = strings.TrimSpace(ipStr)
	if strings.HasPrefix(ipStr, "[") && strings.HasSuffix(ipStr, "]") {
		ipStr = ipStr[1 : len(ipStr)-1]
	}
	ip := net.ParseIP(ipStr)
	if ip == nil {
		return false // 无效 IP
	}
	return ip.To4() == nil // IPv4 返回非 nil，IPv6 返回 nil
}

func TrimSpaceIpv6(ip string) string {
	ip = strings.TrimSpace(ip)
	if !(strings.HasPrefix(ip, "[") && strings.HasSuffix(ip, "]")) {
		ip = fmt.Sprintf("[%s]", ip)
	}
	return ip
}
