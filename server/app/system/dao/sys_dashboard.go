package dao

type UserTender struct {
	Date string `json:"date"`
	Num  int    `json:"num"`
}

type RechargeTender struct {
	Date   string  `json:"date"`
	Amount float64 `json:"amount"`
}

// DashboardRsp
// @name DashboardRsp
type DashboardRsp struct {

	// @description 在线服务器
	OnlineServer int `json:"onlineServer"`
	// @description 离线服务器
	OfflineServer int `json:"offlineServer"`
	// @description 节点数
	Nodes int `json:"nodes"`
}

// DashboardChartRsp
// @name DashboardChartRsp
type DashboardChartRsp struct {
	// @description

}
