<template>
  <div class="homepage">
    <section class="top-section">
      <div class="info-container">
        <div class="project-info">
          <h1 class="project-title">Nodami — 自建 梯子节点，从未如此简单</h1>
          <p class="project-description">Nodami是一个开源的代理服务端管理平台，支持自动部署和集中管理多服务器、多节点，兼容
            Shadowsocks / Vmess / Hysteria 协议，专为简化自建梯子节点而设计，无需复杂命令，可视化操作实现</p>

          <div class="project-links">
            <a href="https://github.com/YoyoCrafts/Nodami.git" class="github-link" target="_blank">
              <span class="icon">📦</span> GitHub 仓库
            </a>
            <a href="https://t.me/Nodami" class="tg-link" target="_blank">
              <span class="icon">💬</span> Telegram 交流群
            </a>
          </div>
        </div>
      </div>

      <div class="stats-section">
        <div class="stats-container">
          <ul class="stats-grid">
            <li v-for="key in Object.keys(serverList)" :key="key" class="stat-card"
                :style="{backgroundImage: `url(${getCardBackground(key)})`}">
              <div class="stat-content">
                <span class="stat-title">{{ serverList[key].title }}</span>
                <span class="stat-value">{{ serverList[key].value }}</span>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </section>

    <!-- 顶部数据卡片区域 -->

    <!-- 订阅卡片区域 -->
    <section class="subscription-section">
      <div class="subscription-container">

        <div class="card-grid">
          <!-- Hiddify 订阅卡片 -->
          <div class="subscription-card featured">
            <div class="recommended-badge">推荐Hiddify客户端</div>
            <div class="card-header hiddify-bg">
              <div class="card-icon">
                <img
                  src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0xMiwyQTEwLDEwIDAgMCwxIDIyLDEyQTEwLDEwIDAgMCwxIDEyLDIyQTEwLDEwIDAgMCwxIDIsMTJBMTAsMTAgMCAwLDEgMTIsMk0xMiw0QTgsOCAwIDAsMCA0LDEyQTgsOCAwIDAsMCAxMiwyMEE4LDggMCAwLDAgMjAsMTJBOCw4IDAgMCwwIDEyLDRNNiwxMkgxOFYxMUg2VjEyWiIgLz48L3N2Zz4="
                  alt="Hiddify">
              </div>
              <h2 class="card-title">ClashMeta , Hiddify ,clash-verge 订阅</h2>
            </div>

            <div class="card-body">
              <!-- 订阅URL部分 -->
              <div class="subscription-url-group">
                <label class="input-label">订阅链接</label>
                <div class="subscription-url-input">
                  <input type="text" :value="baseUrl+'/client/subscription'" id="hiddify-url" readonly>
                  <button class="copy-btn" @click="copyToClipboard('hiddify-url')">
                    <span class="copy-text">复制</span>
                    <span class="icon-copy">⎘</span>
                  </button>
                </div>
              </div>

              <!-- 下载客户端部分 -->
              <div class="download-section">
                <div class="download-client">
                  <h3 class="download-title">下载客户端Hiddify</h3>
                  <div class="platform-buttons">
                    <a href="https://github.com/hiddify/hiddify-next/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> Windows
                    </a>
                    <a href="https://github.com/hiddify/hiddify-ng/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> macOS
                    </a>
                    <a href="https://github.com/hiddify/hiddify-ng/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> Linux
                    </a>
                    <a href="https://github.com/hiddify/hiddify-ng/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> Android
                    </a>
                    <a href="https://apps.apple.com/my/app/hiddify-proxy-vpn/id6596777532" class="platform-btn"
                       target="_blank">
                      <span class="platform-icon"></span> iOS
                    </a>
                  </div>
                  <!-- 推荐理由部分 -->
                  <div class="features-section">
                    <h3 class="features-title">推荐hiddify</h3>
                    <ul class="features-list">
                      <li class="feature-item">
                        <span class="check-icon">✓</span>
                        <span>简单易用，新手友好</span>
                      </li>
                      <li class="feature-item">
                        <span class="check-icon">✓</span>
                        <span>多协议支持，兼容性强</span>
                      </li>
                      <li class="feature-item">
                        <span class="check-icon">✓</span>
                        <span>全平台支持 (iOS/Android/macOS/Windows/Linux)</span>
                      </li>
                    </ul>
                  </div>
                </div>
                <div class="download-client">
                  <h3 class="download-title">下载客户端Clash-Verge</h3>
                  <div class="platform-buttons">
                    <a href="https://github.com/clash-verge-rev/clash-verge-rev/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> Windows
                    </a>
                    <a href="https://github.com/clash-verge-rev/clash-verge-rev/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> macOS
                    </a>
                    <a href="https://github.com/clash-verge-rev/clash-verge-rev/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> Linux
                    </a>
                  </div>
                </div>
                <div class="download-client">
                  <h3 class="download-title">下载客户端ClashMeta</h3>
                  <div class="platform-buttons">
                    <a href="https://github.com/MetaCubeX/Clash.Mini/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> Windows
                    </a>
                    <a href="https://github.com/MetaCubeX/ClashX.Meta/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> macOS
                    </a>
                    <a href="https://github.com/MetaCubeX/ClashMetaForAndroid/releases" class="platform-btn" target="_blank">
                      <span class="platform-icon"></span> Android
                    </a>
                  </div>
                </div>
              </div>


            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import {getDashboardInfo} from "@/api/system/dashboard";

export default {
  name: "Server",
  data() {
    return {
      baseUrl:"",
      serverList: {
        onlineServer: {
          title: "服务器数",
          value: 0
        },
        offlineServer: {
          title: "离线服务器数",
          value: 0
        },
        nodes: {
          title: "节点数",
          value: 0
        },
      },
      runTag: null
    };
  },

  methods: {
    getCurrentOrigin() {
      const { protocol, hostname, port } = window.location;

      // 判断是否是默认端口
      const shouldShowPort = !((protocol === 'http:' && port === '80') ||
        (protocol === 'https:' && port === '443'));

      return `${protocol}//${hostname}${shouldShowPort ? `:${port}` : ''}`;
    },
    getCardBackground(key) {
      // 这里可以根据key返回不同的背景图片
      const backgrounds = {
        onlineServer: require("@/assets/home/Group3.png"),
        offlineServer: require("@/assets/home/Group4.png"),
        nodes: require("@/assets/home/Group5.png")
      };
      return backgrounds[key] || require("@/assets/home/Group6.png");
    },
    copyToClipboard(id) {
      const copyText = document.getElementById(id);
      copyText.select();
      document.execCommand("copy");

      // 显示复制成功的提示
      this.showToast("已复制到剪贴板");
    },
    showToast(message) {
      // 实现toast提示
      const toast = document.createElement("div");
      toast.className = "toast-message";
      toast.textContent = message;
      document.body.appendChild(toast);

      setTimeout(() => {
        toast.classList.add("show");
      }, 10);

      setTimeout(() => {
        toast.classList.remove("show");
        setTimeout(() => {
          document.body.removeChild(toast);
        }, 300);
      }, 3000);
    },
    getData() {
      getDashboardInfo().then(response => {
        this.serverList.onlineServer.value = response.data.onlineServer;
        this.serverList.offlineServer.value = response.data.offlineServer;
        this.serverList.nodes.value = response.data.nodes;
      });
    }
  },
  mounted() {
    this.getData();
    this.baseUrl = this.getCurrentOrigin();
  },
  created() {
    this.runTag = setInterval(this.getData, 5000);
  },
  beforeDestroy() {
    clearInterval(this.runTag);
  }
};
</script>

<style lang="scss">
/* 颜色变量 */
:root {
  --primary-color: #4A00E0;
  --secondary-color: #8E2DE2;
  --accent-color: #2c7be5;
  --text-primary: #2d3748;
  --text-secondary: #4a5568;
  --bg-light: #f8fafc;
  --border-color: #e2e8f0;
  --success-color: #10bc9d;
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
}

/* 基础样式 */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

.homepage {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
  line-height: 1.6;
  color: var(--text-primary);
  background-color: #f5f7fa;

  box-sizing: border-box;
  max-width: 1920px;
  margin: 0 auto;
  padding: 20px;
}

/* 修改顶部区域的布局 */
.top-section {
  display: flex;
  justify-content: space-between; /* 确保两部分分别靠左右 */
  align-items: flex-start; /* 顶部对齐 */
  gap: 20px;
  background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
  color: white;
  border-radius: var(--radius-lg);
  margin-bottom: 30px;
  box-shadow: var(--shadow-md);
  padding: 30px;
}


.info-container {
  flex: 1; /* 占据剩余空间 */
  min-width: 0; /* 允许缩小 */
  position: relative;

  &:after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
    z-index: -1;
  }
}

.project-info {
  max-width: 1200px;
}

.project-title {
  font-size: 2.2rem;
  font-weight: 800;
  margin-bottom: 15px;
  line-height: 1.2;
}

.project-description {
  font-size: 1.1rem;
  margin-bottom: 20px;
  opacity: 0.9;
  line-height: 1.6;
}

.project-links {
  display: flex;
  gap: 15px;
  margin-top: 25px;
}

.github-link, .tg-link {
  display: inline-flex;
  align-items: center;
  padding: 10px 20px;
  border-radius: var(--radius-md);
  font-weight: 600;
  text-decoration: none;
  transition: all 0.3s ease;

  .icon {
    margin-right: 8px;
    font-size: 1.2em;
  }
}

.github-link {
  background-color: rgba(255, 255, 255, 0.15);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.2);

  &:hover {
    background-color: rgba(255, 255, 255, 0.25);
    transform: translateY(-2px);
  }
}

.tg-link {
  background-color: #0088cc;
  color: white;

  &:hover {
    background-color: #0077b3;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 136, 204, 0.3);
  }
}

/* 统计数据卡片区域 */
.stats-section {
  flex-shrink: 0; /* 防止缩小 */
  width: auto; /* 自动宽度 */
}

.stats-container {
  width: 100%;
}

.stats-grid {
  display: flex;
  gap: 20px;
  list-style: none;
  padding: 0;
  margin: 0;
}

.stat-card {
  width: 180px; /* 固定宽度 */
  height: 90px;
  background-size: cover;
  background-position: center;
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-md);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  overflow: hidden;
  position: relative;
  display: flex;
  align-items: flex-end;

  &:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to top, rgba(0, 0, 0, 0.3) 0%, rgba(0, 0, 0, 0.1) 50%, rgba(0, 0, 0, 0) 100%);
    z-index: 1;
  }

  &:hover {
    transform: translateY(-5px);
    box-shadow: var(--shadow-lg);
  }
}

.stat-content {
  padding: 15px 20px;
  position: relative;
  z-index: 2;
  width: 100%;
  color: #2d3748; /* 更深灰蓝 */
  text-shadow: 0 1px 2px rgba(255, 255, 255, 0.5);
}

.stat-title {
  display: block;
  font-size: 14px;
  font-weight: 500;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 5px;
  color: #4a5568; /* 深灰蓝 */
  text-shadow: 0 1px 1px rgba(255, 255, 255, 0.8);
}

.stat-value {
  display: block;
  font-size: 24px;
  font-weight: 700;
  color: white;
  line-height: 1.2;
}


/* 响应式设计 */
@media (max-width: 1024px) {
  .top-section {
    flex-direction: column;
  }

  .stats-section {
    width: 100%;
  }

  .stats-grid {
    justify-content: flex-start;
    flex-wrap: wrap;
  }
}

@media (max-width: 768px) {
  .stat-card {
    width: calc(50% - 10px); /* 在小屏幕显示两列 */
  }
}


/* 订阅区域 */
.subscription-section {
  margin-top: 40px;
}

.subscription-container {
  background-color: white;
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  padding: 25px;
}

.section-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 8px;
}

.section-description {
  font-size: 16px;
  color: var(--text-secondary);
  margin-bottom: 25px;
}

.card-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 25px;
}

/* 订阅卡片 */
.subscription-card {
  background-color: white;
  border-radius: var(--radius-lg);
  overflow: hidden;
  box-shadow: var(--shadow-md);
  transition: all 0.3s ease;
  position: relative;

  &.featured {
    border: 2px solid var(--primary-color);
  }

  &:hover {
    box-shadow: var(--shadow-lg);
  }
}

.recommended-badge {
  position: absolute;
  top: 15px;
  right: 15px;
  background-color: var(--primary-color);
  color: white;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  z-index: 10;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
  100% {
    transform: scale(1);
  }
}

.card-header {
  padding: 20px;
  display: flex;
  align-items: center;
  color: white;
  position: relative;
  z-index: 1;

  &:after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(0, 0, 0, 0.1) 0%, rgba(0, 0, 0, 0.2) 100%);
    z-index: -1;
  }

  &.hiddify-bg {
    background: linear-gradient(135deg, var(--secondary-color) 0%, var(--primary-color) 100%);
  }
}

.card-icon {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: var(--radius-sm);
  margin-right: 15px;

  img {
    width: 24px;
    height: 24px;
  }
}

.card-title {
  font-size: 20px;
  font-weight: 600;
}

.card-body {
  padding: 20px;
}

/* 订阅URL输入组 */
.subscription-url-group {
  margin-bottom: 20px;
}

.input-label {
  display: block;
  font-size: 14px;
  font-weight: 500;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.subscription-url-input {
  display: flex;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow: hidden;
  transition: border-color 0.2s;

  &:focus-within {
    border-color: var(--accent-color);
    box-shadow: 0 0 0 3px rgba(44, 123, 229, 0.1);
  }

  input {
    flex: 1;
    padding: 12px 16px;
    border: none;
    background-color: var(--bg-light);
    font-size: 14px;
    color: var(--text-primary);

    &:focus {
      outline: none;
    }
  }
}

.copy-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 15px;
  background-color: var(--accent-color);
  color: white;
  border: none;
  cursor: pointer;
  transition: background-color 0.2s;

  &:hover {
    background-color: #1a68d1;
  }

  .copy-text {
    margin-right: 8px;
    font-size: 14px;
    font-weight: 500;
  }

  .icon-copy {
    font-size: 16px;
  }
}

/* 下载部分 */
.download-section {
  display: flex; /* 添加 flex 布局 */
  gap: 20px; /* 设置间距 */
  margin-bottom: 20px;
  overflow-x: auto; /* 如果内容过多可以横向滚动 */
  padding-bottom: 10px; /* 为滚动条留空间 */
}

/* 每个客户端下载区块的样式 */
.download-client {
  min-width: 250px; /* 设置最小宽度 */
  flex: 1; /* 允许伸缩 */
  padding: 15px;
  background-color: var(--bg-light);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
}


.download-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.platform-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.platform-btn {
  display: inline-flex;
  align-items: center;
  padding: 8px 16px;
  background-color: var(--bg-light);
  color: var(--accent-color);
  border-radius: var(--radius-md);
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.2s;

  &:hover {
    background-color: #e1effe;
    transform: translateY(-1px);
  }

  .platform-icon {
    margin-right: 8px;
    font-weight: bold;
  }
}

/* 特性列表 */
.features-section {
  margin-top: 20px;
}

.features-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.features-list {
  list-style: none;
}

.feature-item {
  display: flex;
  align-items: center;
  padding: 8px 0;
  font-size: 14px;
  color: var(--text-secondary);

  .check-icon {
    color: var(--success-color);
    margin-right: 8px;
    font-weight: bold;
  }
}

/* Toast消息 */
.toast-message {
  position: fixed;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 12px 25px;
  border-radius: 5px;
  z-index: 1000;
  opacity: 0;
  transition: opacity 0.3s;

  &.show {
    opacity: 1;
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .download-section {
    flex-direction: column; /* 小屏幕下改为垂直排列 */
  }

  .download-client {
    min-width: 100%;
  }
  .top-section {
    flex-direction: column;
  }

  .stats-grid {
    flex-wrap: wrap;
  }

  .stat-card {
    min-width: calc(50% - 10px); /* 在小屏幕显示两列 */
  }
}

@media (max-width: 480px) {
  .stat-card {
    min-width: 100%; /* 在超小屏幕显示单列 */
  }
}
</style>
