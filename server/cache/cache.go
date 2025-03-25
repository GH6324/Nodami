// Package cache 缓存工具类，可以缓存各种类型包括 struct 对象
package cache

import (
	"encoding/json"
	"fmt"
	"gfast/app/common/service"
	"github.com/gogf/gf/frame/g"
	"strings"
	"time"

	"github.com/spf13/cast"
)

type Value struct {
	V interface{} `json:"v"`
}

func Set(key string, obj interface{}, expireTime int) {
	value := Value{
		V: obj,
	}
	b, _ := json.Marshal(&value)

	set(key, string(b), expireTime)
}

func Get(key string) interface{} {
	value := &Value{}
	stringValue := get(key)
	if len(stringValue) == 0 || strings.Contains(stringValue, "<nil>") {
		return ""
	}

	err := json.Unmarshal([]byte(stringValue), &value)
	if err != nil {
		g.Log().Error(err)
		return ""
	}
	return value.V
}

func GetToType(key string, v interface{}) error {
	value := &Value{
		V: v,
	}
	stringValue := get(key)
	if len(stringValue) == 0 || strings.Contains(stringValue, "<nil>") {
		err := fmt.Errorf("key not found in cache   key:%s", v)
		return err
	}

	err := json.Unmarshal([]byte(stringValue), value)
	if err != nil {
		return err
	}
	v = value.V

	return nil
}

func GetBool(key string) bool {
	return cast.ToBool(Get(key))
}

func GetString(key string) string {
	return cast.ToString(Get(key))
}

func GetInt(key string) int {
	return cast.ToInt(Get(key))
}

func GetInt32(key string) int32 {
	return cast.ToInt32(Get(key))
}

func GetInt64(key string) int64 {
	return cast.ToInt64(Get(key))
}

func GetUint(key string) uint {
	return cast.ToUint(Get(key))
}

func GetUint32(key string) uint32 {
	return cast.ToUint32(Get(key))
}

func GetUint64(key string) uint64 {
	return cast.ToUint64(Get(key))
}

func GetFloat64(key string) float64 {
	return cast.ToFloat64(Get(key))
}

func GetTime(key string) time.Time {
	return cast.ToTime(Get(key))
}

func GetDuration(key string) time.Duration {
	return cast.ToDuration(Get(key))
}

func GetIntSlice(key string) []int {
	return cast.ToIntSlice(Get(key))
}

func GetStringSlice(key string) []string {
	return cast.ToStringSlice(Get(key))
}

func GetStringMap(key string) map[string]interface{} {
	return cast.ToStringMap(Get(key))
}

func GetStringMapString(key string) map[string]string {
	return cast.ToStringMapString(Get(key))
}

func GetStringMapStringSlice(key string) map[string][]string {
	return cast.ToStringMapStringSlice(Get(key))
}

func set(key string, value string, expireTime int) {

	cache := service.Cache.New()
	if expireTime == 0 {
		cache.Set(key, value, 0)
	} else {
		cache.Set(key, value, time.Duration(expireTime)*time.Second)
	}

}

func get(key string) string {
	cache := service.Cache.New()
	v := cache.Get(key)
	return fmt.Sprint(v)
}

func Del(key string) bool {
	cache := service.Cache.New()
	cache.Remove(key)
	return true
}

func Exists(key string) bool {
	cache := service.Cache.New()
	return cache.Contains(key)
}
