package model

import "context"

const PageSize = 10

type PageReq struct {
	BeginTime string `p:"beginTime"` //开始时间
	EndTime   string `p:"endTime"`   //结束时间
	// @description 当前页码
	PageNum int `p:"pageNum"` //当前页码
	// @description 每页数
	PageSize int             `p:"pageSize"` //每页数
	Ctx      context.Context `swaggerignore:"true"`
	// @description 排序方式
	OrderBy string `p:"orderBy"`
	Search  string `p:"search"`
}

type UpFile struct {
	Name string `json:"name"`
	Url  string `json:"url"`
	Uid  uint64 `json:"uid"`
}
