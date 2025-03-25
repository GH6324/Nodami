package api

import (
	"gfast/app/common/service"
	"gfast/library"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
)

type captcha struct{}

var Captcha = new(captcha)

// Img 获取验证码图片信息
func (c *captcha) Img(r *ghttp.Request) {
	idKeyC, base64stringC := service.Captcha.GetVerifyImgString()
	library.SusJson(true, r, "ok", g.MapStrStr{"idKeyC": idKeyC, "base64stringC": base64stringC})
}
