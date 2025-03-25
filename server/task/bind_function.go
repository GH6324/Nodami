/*
* @desc:定时任务配置
* @company:云南省奇讯科技有限公司
* @Author: yixiaohu
* @Date:   2021/7/16 15:45
 */

package task

import (
	"fmt"
	"gfast/app/system/api"
	"gfast/app/system/service"
	"github.com/gogf/gf/frame/g"
	"reflect"
	"runtime"
	"time"
)

func init() {

	checkUserOnlineTask := &service.TimeTask{
		FuncName: "checkUserOnline",
		Run:      api.Auth.CheckUserOnline,
	}

	//拨号服务器定时拨号
	TimerTask(60, NodeServersPppoeReStartTask)

	//服务器在线状态过期判断
	TimerTask(10, ServerOnlineTask)

	//节点延迟测试
	TimerTask(60, NodeURLTestTask)

	//节点流量统计
	TimerTask(30, GlobalTrafficsTask)

	service.TimeTaskList.AddTask(checkUserOnlineTask)
	jobs, err := service.SysJob.GetJobs()
	if err != nil {
		g.Log().Error(err)
	}
	for _, job := range jobs {
		service.SysJob.JobStart(job)
	}
}

func TimerTask(second int, cmd func()) {
	go func() {
		//ticker := time.NewTicker(time.Duration(second) * time.Second)
		for {
			func(cmd func()) {
				defer func() {
					if r := recover(); r != nil {
						funcName := GetFunctionName(cmd)
						fmt.Printf("Function Name: %s\n%v", funcName, r)
					}
				}()
				cmd()
			}(cmd)
			time.Sleep(time.Duration(second) * time.Second)
		}
	}()

}
func GetFunctionName(i interface{}) string {
	// 获取函数指针
	ptr := reflect.ValueOf(i).Pointer()
	// 获取函数对象
	funcObj := runtime.FuncForPC(ptr)
	// 获取函数名
	funcName := funcObj.Name()
	return funcName
}
