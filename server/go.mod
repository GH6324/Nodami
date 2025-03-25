module gfast

require (
	common v0.0.0-00010101000000-000000000000
	github.com/casbin/casbin/v2 v2.31.9
	github.com/cloudflare/cloudflare-go v0.93.0
	github.com/eclipse/paho.mqtt.golang v1.4.3
	github.com/go-telegram-bot-api/telegram-bot-api v4.6.4+incompatible
	github.com/goflyfox/gtoken v1.4.5
	github.com/gogf/gcache-adapter v0.1.2
	github.com/gogf/gf v1.16.9
	github.com/gogf/swagger v1.3.0
	github.com/google/uuid v1.6.0
	github.com/mojocn/base64Captcha v1.3.1
	github.com/mssola/user_agent v0.5.1
	github.com/oschwald/geoip2-golang v1.11.0
	github.com/shirou/gopsutil v3.21.6+incompatible
	github.com/sirupsen/logrus v1.9.3
	github.com/spf13/cast v1.5.1
	golang.org/x/crypto v0.32.0
	golang.org/x/net v0.26.0
	gopkg.in/yaml.v3 v3.0.1
)

require (
	github.com/golang/protobuf v1.5.3 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20231002182017-d307bd883b97 // indirect
)

require (
	github.com/BurntSushi/toml v1.3.2 // indirect
	github.com/Knetic/govaluate v3.0.1-0.20171022003610-9aa49832a739+incompatible // indirect
	github.com/StackExchange/wmi v1.2.0 // indirect
	github.com/clbanning/mxj v1.8.5-0.20200714211355-ff02cfb8ea28 // indirect
	github.com/fatih/color v1.16.0 // indirect
	github.com/frankban/quicktest v1.14.5 // indirect
	github.com/fsnotify/fsnotify v1.7.0 // indirect
	github.com/go-logr/logr v1.2.4 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-ole/go-ole v1.3.0 // indirect
	github.com/go-sql-driver/mysql v1.7.0 // indirect
	github.com/goccy/go-json v0.10.2 // indirect
	github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0 // indirect
	github.com/golang/mock v1.7.0-rc.1 // indirect
	github.com/gomodule/redigo v2.0.0+incompatible // indirect
	github.com/google/go-querystring v1.1.0 // indirect
	github.com/gorilla/websocket v1.5.0 // indirect
	github.com/grokify/html-strip-tags-go v0.0.1 // indirect
	github.com/hashicorp/go-cleanhttp v0.5.2 // indirect
	github.com/hashicorp/go-retryablehttp v0.7.5 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.20 // indirect
	github.com/mattn/go-runewidth v0.0.15 // indirect
	github.com/olekukonko/tablewriter v0.0.5 // indirect
	github.com/oschwald/maxminddb-golang v1.13.0 // indirect
	github.com/rivo/uniseg v0.4.4 // indirect
	github.com/technoweenie/multipartstreamer v1.0.1 // indirect
	github.com/tklauser/go-sysconf v0.3.12 // indirect
	github.com/tklauser/numcpus v0.6.1 // indirect
	go.opentelemetry.io/otel v1.14.0 // indirect
	go.opentelemetry.io/otel/trace v1.14.0 // indirect
	golang.org/x/image v0.0.0-20210220032944-ac19c3e999fb // indirect
	golang.org/x/sync v0.10.0 // indirect
	golang.org/x/sys v0.29.0 // indirect
	golang.org/x/text v0.21.0 // indirect
	golang.org/x/time v0.5.0 // indirect
	google.golang.org/grpc v1.60.1 // indirect
	google.golang.org/protobuf v1.34.1 // indirect
)

replace github.com/goflyfox/gtoken v1.4.5 => github.com/tiger1103/gtoken v1.4.8

replace common => ../common

go 1.22.4
