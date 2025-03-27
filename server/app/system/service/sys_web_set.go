/*
* @desc:站点配置
* @company:云南省奇讯科技有限公司
* @Author: yixiaohu
* @Date:   2021/7/6 15:48
 */

package service

import (
	"context"
	"encoding/json"
	"gfast/app/common/global"
	commonService "gfast/app/common/service"
	"gfast/app/system/dao"
	"gfast/app/system/model"
	"gfast/library"
	"github.com/gogf/gf/database/gdb"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/util/gconv"
)

type sysWebSet struct {
}

var SysWebSet = new(sysWebSet)

func init() {
	data, err := SysWebSet.Get(false)
	if err != nil {
		g.Log().Panic(err.Error())
	}

	err = library.SetSettings([]byte(data.WebContent))
	if err != nil {
		g.Log().Panic(err.Error())
	}

}

func (s *sysWebSet) Get(isCache bool) (data *model.SysWebSet, err error) {
	cache := commonService.Cache.New()
	if isCache {
		d := cache.Get(global.SysWebSet)
		if d != nil {
			err = gconv.Struct(d, &data)
			return
		}
	}
	err = dao.SysWebSet.Page(1, 1).Scan(&data)
	if err != nil {
		return
	}
	cache.Set(global.SysWebSet, data, 0)
	return
}

func (s *sysWebSet) UpdateSave(req *model.SysWebSetUpdateReq) (err error) {

	return dao.SysWebSet.Transaction(context.Background(), func(ctx context.Context, tx *gdb.TX) error {

		if req.WebId != 0 {
			_, err = tx.Model(dao.SysWebSet.Table).FieldsEx(dao.SysWebSet.C.WebId).WherePri(req.WebId).Update(req)
		} else {
			_, err = tx.Model(dao.SysWebSet.Table).FieldsEx(dao.SysWebSet.C.WebId).Insert(req)
		}
		if err != nil {
			return err
		}
		var jsonData []byte
		jsonData, err = json.Marshal(req.WebContent)
		if err != nil {
			return err
		}

		return library.SetSettings(jsonData)

	})

}
