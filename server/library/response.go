package library

import (
	"fmt"
	"github.com/gogf/gf/encoding/gurl"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/os/gview"
)

const (
	SuccessCode int = 0
	ErrorCode   int = -1
)

type Response struct {
	// 代码
	Code int `json:"code" example:"0"`
	// 数据集
	Data interface{} `json:"data"`
	// 消息
	Msg string `json:"msg"`
}

type ErrorResponse struct {
	// 代码
	Code int `json:"code"`
	// 消息
	Msg string `json:"msg"`
}

var response = new(Response)

func TextExit(r *ghttp.Request, data string) {
	response.TextExit(r, data)
}

func HtmlExit(r *ghttp.Request, data string) {
	response.RHtml(r, data)
}

func JsonExit(r *ghttp.Request, code int, msg string, data ...interface{}) {
	response.JsonExit(r, code, msg, data...)
}

func RJson(r *ghttp.Request, code int, msg string, data ...interface{}) {
	response.RJson(r, code, msg, data...)
}

func SusJson(isExit bool, r *ghttp.Request, msg string, data ...interface{}) {
	response.SusJson(isExit, r, msg, data...)
}

func FailJson(isExit bool, r *ghttp.Request, msg string, data ...interface{}) {
	response.FailJson(isExit, r, msg, data...)
}

func WriteTpl(r *ghttp.Request, tpl string, view *gview.View, params ...gview.Params) error {
	return response.WriteTpl(r, tpl, view, params...)
}

// 返回JSON数据并退出当前HTTP执行函数。
func (res *Response) JsonExit(r *ghttp.Request, code int, msg string, data ...interface{}) {
	res.RJson(r, code, msg, data...)
	r.Exit()
}

func (res *Response) TextExit(r *ghttp.Request, data string) {
	res.RText(r, data)
	r.Exit()
}

func (res *Response) RJson(r *ghttp.Request, code int, msg string, data ...interface{}) {
	responseData := interface{}(nil)
	if len(data) > 0 {
		responseData = data[0]
	}
	rs := &Response{
		Code: code,
		Msg:  msg,
		Data: responseData,
	}
	r.SetParam("apiReturnRes", rs)

	r.Response.WriteJson(rs)
}

func (res *Response) RText(r *ghttp.Request, data string) {
	r.Response.WriteExit(data)
}

func (res *Response) RHtml(r *ghttp.Request, htmlContent string) {
	r.Response.Header().Set("Content-Type", "text/html; charset=utf-8")
	r.Response.WriteExit(htmlContent)
}

// 成功返回JSON
func (res *Response) SusJson(isExit bool, r *ghttp.Request, msg string, data ...interface{}) {
	if isExit {
		res.JsonExit(r, SuccessCode, msg, data...)
	}
	res.RJson(r, SuccessCode, msg, data...)
}

// 失败返回JSON
func (res *Response) FailJson(isExit bool, r *ghttp.Request, msg string, data ...interface{}) {
	if isExit {
		res.JsonExit(r, ErrorCode, msg, data...)
	}
	res.RJson(r, ErrorCode, msg, data...)
}

// 模板输出
func (res *Response) WriteTpl(r *ghttp.Request, tpl string, view *gview.View, params ...gview.Params) error {
	//设置全局变量
	urlInfo, _ := gurl.ParseURL(r.GetUrl(), -1)
	view.Assign("urlInfo", urlInfo)
	r.SetView(view)
	err := r.Response.WriteTpl(tpl, params...)
	if err != nil {
		fmt.Println(err.Error())
		r.Response.WriteExit(err.Error())
	}
	return nil
}

func (res *Response) Redirect(r *ghttp.Request, location string, code ...int) {
	r.Response.RedirectTo(location, code...)
}
