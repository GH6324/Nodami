package task

import (
	"fmt"
	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api"
	"github.com/gogf/gf/frame/g"
	"strings"
	"time"
)

var Robot *ReportServerInfoRobot

type ReportServerInfoRobot struct {
	bot     *tgbotapi.BotAPI
	updates tgbotapi.UpdatesChannel
	token   string
	chatId  int64
}

func (r *ReportServerInfoRobot) SendServerInfo(text string) error {
	if Robot == nil || r.bot == nil {
		return fmt.Errorf("机器人未初始化")
	}
	//todo 初始化机器人响应消息体
	msg := tgbotapi.NewMessage(r.chatId, text)
	_, err := Robot.bot.Send(msg)
	if err != nil {
		return err
	}
	return nil
}

func (r *ReportServerInfoRobot) handle() {
	err := r.loadBot()
	if err != nil {
		g.Log().Error(err)
		return
	}

	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	//todo 启动定时器
	configTicker := time.NewTicker(22 * time.Second)

	for {
		select {
		case update := <-r.updates:
			//todo 检查消息有效性
			if update.Message == nil {
				continue
			}
			if !update.Message.IsCommand() {
				continue
			}

			//todo 获取和解析命令
			command := update.Message.Command()
			commandWithParams := strings.Split(command, " ")
			commandMain := commandWithParams[0]
			g.Log().Info(fmt.Sprintf("command:%s", command))

			//todo 初始化机器人响应消息体
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "")

			//todo 监听命令，执行具体逻辑
			switch commandMain {
			case "set_chat_id":
				msg.Text = fmt.Sprintf("%d", msg.ChatID)
				r.chatId = msg.ChatID
				break
			case "start":
				msg.Text = `
		<b color="red">粗体文本</b>
		<i>斜体文本</i>
		<u>带下划线文本</u>
		<a href="https://www.example.com">链接文本</a>
	`
				msg.ParseMode = tgbotapi.ModeHTML
				break
			case "list":
				replyKeyboard := tgbotapi.NewReplyKeyboard(
					tgbotapi.NewKeyboardButtonRow(
						tgbotapi.NewKeyboardButton("Button 1"),
						tgbotapi.NewKeyboardButton("Button 2"),
						tgbotapi.NewKeyboardButton("Button 3"),
					),
					tgbotapi.NewKeyboardButtonRow(
						tgbotapi.NewKeyboardButton("Button 3"),
						tgbotapi.NewKeyboardButton("Button 4"),
					),
					tgbotapi.NewKeyboardButtonRow(
						tgbotapi.NewKeyboardButton("Button 1"),
						tgbotapi.NewKeyboardButton("Button 2"),
						tgbotapi.NewKeyboardButton("Button 3"),
					),
					tgbotapi.NewKeyboardButtonRow(
						tgbotapi.NewKeyboardButton("Button 3"),
						tgbotapi.NewKeyboardButton("Button 4"),
					),
				)
				msg.ReplyMarkup = replyKeyboard
				msg.Text = "选择一个按钮："
				break
			default:
				msg.Text = "不支持的命令"
			}

			//todo 发送
			_, err := r.bot.Send(msg)
			if err != nil {
				g.Log().Error("发送消息失败", err)
				continue
			}

			break
		case <-configTicker.C:
			//定时读取最新配置
			//if err := r.loadConfig(); err != nil {
			//	g.Log().Error(fmt.Sprintf("%s>> 读取 tgBot 配置失败, err=%+v", r.name(), err))
			//}
			break
		}
	}
}

func (r *ReportServerInfoRobot) name() string {
	return "汇率机器人:虚拟货币"
}

func (r *ReportServerInfoRobot) loadConfig() error {
	token := g.Cfg().GetString("robot.token")

	//todo 检查token是否为空
	if token == "" {
		return fmt.Errorf("%s>> token为空", r.name())
	}

	//todo 新旧配置一样，没有变化，不用后续处理
	if r.token == token {
		return nil
	}

	r.chatId = int64(g.Cfg().GetInt("robot.chat_id"))
	err := r.loadBot()
	if err != nil {
		return err
	}

	return nil
}

// 机器人实例化
func (r *ReportServerInfoRobot) loadBot() error {
	//todo 关闭机器人
	r.closeBot()

	//todo 实例化机器人对象
	bot, err := tgbotapi.NewBotAPI(g.Cfg().GetString("robot.token"))
	if err != nil {
		return err
	}

	//todo 获取机器人自身信息
	botInfo, err := bot.GetMe()
	if err != nil {
		return err
	}
	g.Log().Info(fmt.Sprintf("%s>> 当前机器人信息：", r.name()), botInfo.UserName, botInfo.FirstName, botInfo.LastName)
	r.bot = bot

	//todo 获取最新的更新通道
	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60
	updates, err := r.bot.GetUpdatesChan(u)
	if err != nil {
		return err
	}
	r.updates = updates

	return nil
}

// 关闭机器人
func (r *ReportServerInfoRobot) closeBot() {
	if r.bot != nil {
		r.bot.StopReceivingUpdates()
		r.bot = nil
	}
}
