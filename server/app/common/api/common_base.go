package api

import (
	"encoding/json"
	"gfast/library"
	"github.com/gogf/gf/net/ghttp"
)

type CommonBase struct{}

// SusJson 成功的返回
func (c *CommonBase) SusJson(isExit bool, r *ghttp.Request, msg string, data ...interface{}) {
	library.SusJson(isExit, r, msg, data...)
}

// FailJson 失败的返回
func (c *CommonBase) FailJson(isExit bool, r *ghttp.Request, msg string, data ...interface{}) {
	library.FailJson(isExit, r, msg, data...)
}

// FailJsonExit 失败中断返回
func (c *CommonBase) FailJsonExit(r *ghttp.Request, msg string) {
	c.FailJson(true, r, msg)
}

// SusJsonExit 成功中断返回
func (c *CommonBase) SusJsonExit(r *ghttp.Request, data ...interface{}) {
	c.SusJson(true, r, "success", data...)
}

// JsonExit 输出json并中断
func (c *CommonBase) JsonExit(r *ghttp.Request, code int, msg string, data ...interface{}) {
	rs := &library.Response{
		Code: code,
		Msg:  msg,
		Data: data,
	}
	text, _ := json.Marshal(rs)
	r.SetCtxVar("resData", string(text))
	library.JsonExit(r, code, msg, data...)
}
