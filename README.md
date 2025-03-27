# 🚀 Nodami - 自建VPN翻墙梯子节点，从未如此简单

**Nodami** 是一款开源代理服务端管理平台。它可以轻松实现自动部署、集中管理多个服务器节点，完美兼容 Shadowsocks / Vmess / Vless / Trojan / Hysteria  多种协议，专为简化自建梯子节点而设计，无需复杂命令，可视化操作实现，全程web后台操作即可自动完成节点部署、配置、伪装，彻底告别复杂脚本、被墙困扰。它适合所有人
---

## 💡 主要适用人群

- ✅ 想自建节点但完全不懂技术、不会写配置的小白用户
- ✅ 想管理多个节点，受不了每次都重复搭建配置的用户
- ✅ 觉得各种面板太复杂、太重、不想学太多的懒人用户
- ✅ 不想研究 Xray / Hysteria / TLS / Reality 参数的省心党
- ✅ 因为配置不当导致节点一直被墙、不知道问题出在哪的受害者
- ......
---
## 🌟 项目特性

- **全自动部署，无需动手**: 无需敲命令、无需懂代码，只需填写服务器信息，系统自动完成部署配置，真正实现一键搭建。
- **多协议支持，场景全覆盖**: 完美支持 Shadowsocks、Vmess、Vless、Trojan 和 Hysteria，主流协议一网打尽，满足各种使用场景。
- **支持 配置中转降低延迟**: 支持自动配置中转链路（如入口中转 → 出口节点），降低延迟同时提升抗封锁能力，轻松告别被墙烦恼。
- **支持 拨号服务器**: 可自动配置内网穿透接入拨号主机（如光猫拨号、移动宽带等），让节点具备动态ip的效果。
- **多服务器集中管理**: 支持添加多个服务器，统一后台管理，节点状态一目了然，适合多机房运营与日常维护。
- **全程后台操作，极简体验**:  所有操作都在 Web 后台完成，无需上传配置或手动连接终端，真正为用户减负。

---

## 🛠️ 安装教程

### 环境准备
- Linux 服务器（推荐 Ubuntu）
- 确保放行端口 （18080和1883）

### 快速安装 一键安装
```bash
curl -fsSL https://raw.githubusercontent.com/YoyoCrafts/Nodami/refs/heads/nodami/docker/install.sh -o install.sh && sudo bash install.sh
```

---

## 🎯 在线演示后台

体验 Nodami 强大的节点管理能力：[演示地址](http://154.12.52.156:18080/)

- **测试账号**: `admin`
- **测试密码**: `123456`

---

## 📸 项目截图

| 节点仪表盘 | 服务器管理页                                  | 节点管理页                                    |
|------------|-----------------------------------------|------------------------------------------|
| ![Dashboard](./screenshot/01.png) | ![Node Management](./screenshot/02.png) | ![Status Monitoring](./screenshot/03.png) |

| 节点配置                                     | 节点日志                                   |
|------------------------------------------|----------------------------------------|
| ![Quick Deployment](./screenshot/04.png) | ![Log Management](./screenshot/05.png) |

---

## 📣 参与贡献

欢迎提交 Issue 和 Pull Request，帮助我们改进 Nodami 项目，让更多用户能够轻松搭建高质量的代理服务。

---

## 💬 交流群

加入 [Telegram 交流群 @nodami_ui](https://t.me/nodami_ui)，获取实时帮助并与社区交流。

---

## ❤️ 特别感谢

感谢以下开源项目为 Nodami 提供了技术支持和灵感：

- [MetaCubeX](https://github.com/MetaCubeX/mihomo)
- [SagerNet](https://github.com/SagerNet/sing-box)
- [g-fast](https://gitee.com/tiger1103/gfast)

---

感谢使用 Nodami！🎉

如有疑问或建议，请随时联系开发团队。
