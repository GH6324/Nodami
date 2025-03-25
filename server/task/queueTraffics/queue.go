package queueTraffics

type GlobalQueueInfo struct {
	ServerId int
	NodeId   int
	Up       int64
	Down     int64
}

var globalQueueInstance = NewQueue[*GlobalQueueInfo](
	func(a, b *GlobalQueueInfo) bool {
		return a.NodeId == b.NodeId
	},
	func(dst, src *GlobalQueueInfo) *GlobalQueueInfo {
		dst.Up += src.Up
		dst.Down += src.Down
		return dst
	},
)

func GetGlobalQueue() *Queue[*GlobalQueueInfo] {
	return globalQueueInstance
}

type EmailQueueInfo struct {
	Email string
	Up    int64
	Down  int64
}

var emailQueueInstance = NewQueue[*EmailQueueInfo](
	func(a, b *EmailQueueInfo) bool {
		return a.Email == b.Email
	},
	func(dst, src *EmailQueueInfo) *EmailQueueInfo {
		dst.Up += src.Up
		dst.Down += src.Down
		return dst
	},
)

func GetEmailQueue() *Queue[*EmailQueueInfo] {
	return emailQueueInstance
}
