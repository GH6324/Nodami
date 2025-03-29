# 🚀 Nodami - 自建VPN节点，从未如此简单

**Nodami** 是一款开源的代理服务端管理面板，专注于帮助用户轻松部署和集中管理多个服务器节点。平台支持 Shadowsocks、ShadowTls、Vmess、Vless、Trojan、Hysteria 和 Tuic 等主流代理协议，通过直观的 Web 界面一键完成节点的自动部署、配置及管理，简化技术门槛，快速构建稳定、安全的代理服务。

> ⚠️ **免责声明**：本项目仅供个人技术研究、合法合规场景使用和学习交流。严禁用于任何违反法律法规的用途，使用者自行承担相关法律责任。

---

## 💡 适合哪些用户？

- ✅ 希望提升跨境电商运营效率，但缺乏技术经验的商家
- ✅ 需要集中管理多个内部网络节点的企业运维人员
- ✅ 想简化服务器维护过程的系统管理员与技术支持人员
- ✅ 合规访问国际学术资源、协作工具或外部服务的教育与科研人员

---

## 🌟 项目特性

- **全自动部署，真正一键式**：无需复杂命令，只需填写服务器信息即可完成自动化部署。
- **全面支持主流协议**：兼容 Shadowsocks、Vmess、Vless、Trojan、Hysteria 等多种协议。
- **智能中转链路配置**：自动配置节点中转链路，提升访问速度和可靠性。
- **动态拨号服务器支持**：支持拨号主机接入，轻松实现动态IP服务。
- **集中式服务器管理**：Web 界面统一管理所有节点状态，维护一目了然。
- **极简操作体验**：全程通过后台图形界面完成操作，避免复杂的终端命令。

---

## 🛠️ 快速安装

### 环境要求
- Linux 服务器（推荐 Ubuntu）
- 确保开放端口：`18080` 和 `1883`

### 一键安装

执行以下命令快速安装 Nodami：
```bash
curl -fsSL "https://raw.githubusercontent.com/YoyoCrafts/Nodami/refs/heads/nodami/docker/install.sh?t=$(date +%s)" -o install.sh && sudo bash install.sh
```

---

## 🎯 在线演示

你可以通过以下链接体验 Nodami 管理平台的简洁与强大：[在线演示](http://154.12.52.156:18080/)

- **测试账号**：`admin`
- **测试密码**：`123456`

---

## 📸 项目截图

| 节点仪表盘 | 服务器管理页 | 节点管理页 |
|------------|--------------|------------|
| ![Dashboard](./screenshot/01.png) | ![Server Management](./screenshot/02.png) | ![Node Management](./screenshot/03.png) |

| 节点配置页 | 节点日志页 |
|------------|------------|
| ![Node Configuration](./screenshot/04.png) | ![Log Management](./screenshot/05.png) |

---

## 📣 如何参与

欢迎提交 Issue 或 Pull Request，共同完善 Nodami 项目，让更多人享受简单高效的服务器管理体验。

---

## 💬 社区交流

欢迎加入 [Telegram 交流群 @nodami_ui](https://t.me/nodami_ui)，获取实时帮助、交流经验与技巧。

---

## ❤️ 特别鸣谢

感谢以下开源项目提供的技术支持与灵感：

- [MetaCubeX](https://github.com/MetaCubeX/mihomo)
- [SagerNet](https://github.com/SagerNet/sing-box)
- [g-fast](https://gitee.com/tiger1103/gfast)

---

🎉 感谢你使用 Nodami！如有任何疑问或建议，欢迎联系我们的开发团队。

