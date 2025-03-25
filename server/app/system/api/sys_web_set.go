/*
* @desc:站点设置
* @company:云南省奇讯科技有限公司
* @Author: yixiaohu
* @Date:   2021/7/6 15:41
 */

package api

import (
	"gfast/app/common/global"
	commonService "gfast/app/common/service"
	"gfast/app/system/model"
	"gfast/app/system/service"
	"gfast/library"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
	"strings"
)

type sysWebSet struct {
	SystemBase
}

var SysWebSet = new(sysWebSet)

func (c *sysWebSet) Update(r *ghttp.Request) {
	var req *model.SysWebSetUpdateReq
	err := r.Parse(&req)
	if err != nil {
		c.FailJson(true, r, err.(gvalid.Error).FirstString())
	}
	err = service.SysWebSet.UpdateSave(req)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}

	commonService.Cache.New().Remove(global.SysWebSet)

	c.SusJsonExit(r, "更新成功!")
}

func (c *sysWebSet) Get(r *ghttp.Request) {
	data, err := service.SysWebSet.Get(true)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	c.SusJsonExit(r, data)
}

func (c *sysWebSet) ConfigKey(r *ghttp.Request) {
	configKey := r.GetString("configKey")
	if configKey == "" {
		c.FailJsonExit(r, "configKey is null")
	}
	settingsMap, err := library.StructToMap(global.Settings)
	if err != nil {
		c.FailJsonExit(r, err.Error())
	}
	configKeys := strings.Split(configKey, ".")

	var configValue interface{}
	for _, v := range configKeys {
		if configValue == nil {
			value, ok := settingsMap[v]
			if ok {
				configValue = value
			}
		} else {
			configValueMap, ok := configValue.(map[string]interface{})
			if ok {
				value, yes := configValueMap[v]
				if yes {
					configValue = value
				}
			}
		}

	}

	c.SusJsonExit(r, configValue)
}
