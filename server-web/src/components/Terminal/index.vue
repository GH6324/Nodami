<template>
  <div class="fullscreenElement" ref="fullscreenElement">
    <div class="ssh-controls-container">
      <div class="controls-wrapper">
        <button v-if="isDisconnected" class="control-btn" title="重连" @click="reconnect()">
          <i class="fas fa-redo-alt"></i>
          <span class="btn-text">重连</span>
        </button>
        <!-- 全屏按钮 -->
        <button v-if="!isDisconnected" class="control-btn" title="全屏" @click="toggleFullScreen()">
          <i class="fas fa-expand"></i>
          <span class="btn-text">全屏</span>
        </button>


        <button v-if="!isDisconnected" class="control-btn" title="常用命令" @click="toggleCommandPanel()">
          <i class="fas fa-terminal"></i>
          <span class="btn-text">常用命令</span>
        </button>

        <!-- 文件管理按钮 -->
<!--        <button v-if="!isDisconnected" class="control-btn" title="文件管理" @click="setFileListVisible()">-->
<!--          <i class="fas fa-folder"></i>-->
<!--          <span class="btn-text">文件管理</span>-->
<!--        </button>-->
      </div>
    </div>

    <div ref="termContainer" class="termContainer"></div>
    <command-panel v-if="commandPanelVisible" :visible.sync="commandPanelVisible" :sendCommand="sendCommand"/>
    <file-list v-if="fileListVisible" :serverId="serverId" :dialogVisible.sync="fileListVisible"/>
  </div>
</template>
<style scoped>
.fullscreenElement {
  position: relative;
  border-radius: 5px;
  display: flex;
  flex: 1;
  height: 100%; /* ← 改为 auto */
  width: 100%;
  overflow: hidden; /* 防止 canvas 溢出 */
}

.termContainer {
  position: relative;
  border-radius: 5px;
  flex-grow: 1;
  min-height: 0; /* 🔥 重要：防止被撑开 */
  overflow: hidden; /* 防止 canvas 溢出 */
}

.ssh-controls-container {
  position: absolute;
  top: 10px;
  right: 10px;
  z-index: 1000;
}

.controls-wrapper {
  display: flex;
  align-items: center;
  border-radius: 20px;
  background: rgba(0, 0, 0, 0.5);
  padding: 4px;
  box-shadow: 0 2px 10px rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(3px);
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.control-btn {
  background: transparent;
  border: none;
  color: rgba(255, 255, 255, 1);
  padding: 5px 8px 5px 8px;
  margin: 0 2px;
  border-radius: 16px;
  cursor: pointer;
  display: flex;
  align-items: center;
  transition: all 0.2s ease;
  font-size: 11px;
}

.control-btn:hover {
  background: rgba(255, 255, 255, 0.2);
  color: #ffffff;
}

.btn-text {
  white-space: nowrap;
}

::v-deep .xterm .xterm-viewport {
  flex-grow: 1; /* 让 terminal 填充剩余空间 */
  border-radius: 5px !important;
}

::v-deep .xterm .xterm-screen canvas {
  flex-grow: 1; /* 让 terminal 填充剩余空间 */
  border-radius: 5px !important;
}


.xterm {
  flex-grow: 1; /* 让 terminal 填充剩余空间 */
  position: relative
}

::v-deep .xterm {
  width: 100% !important;
  height: 100% !important;
  display: block;
}

::v-deep .xterm-screen canvas {
  width: 100% !important;
  height: 100% !important;
  display: block;
}


</style>
<script>
import {Terminal} from 'xterm'
import {FitAddon} from 'xterm-addon-fit'
import {AttachAddon} from 'xterm-addon-attach'
import FileList from './FileList'
import CommandPanel from './CommandPanel.vue'
import {getToken} from "@/utils/auth";

export default {
  components: {
    'file-list': FileList,
    'command-panel': CommandPanel
  },
  name: 'Terminal',
  props: {
    serverId: {
      type: Number,
      required: 0
    },
    show: {
      type: Boolean,
      required: false
    },
  },
  data() {
    return {
      term: null,
      ws: null,
      resetClose: false,
      savePass: false,
      fontSize: 15,
      fileListVisible: false,
      commandPanelVisible: false,
      isDisconnected: false,  // 新增的变量，用来判断是否断开连接
      fitAddon: new FitAddon(),
      _terminalObserver: undefined,
    }
  },
  watch: {
    show(newVal, oldVal) {
      if (newVal) {
        setTimeout(() => {
          this.fitAddon.fit();
        }, 500)
      }
    }
  },
  mounted() {
    this.createTerm()
    document.addEventListener('fullscreenchange', this.fullEventListener)
    window.addEventListener('resize', this.safeFit)
  },
  beforeDestroy() {
    this.close()
    document.removeEventListener('fullscreenchange', this.fullEventListener)
    window.removeEventListener('resize', this.safeFit)
  },
  methods: {
    fullEventListener() {
      if (!document.fullscreenElement) {
        this.$nextTick(() => {
          const sel = [
            '.xterm',
            '.xterm .xterm-viewport',
            '.xterm .xterm-viewport .xterm-scroll-area',
            '.xterm .xterm-screen',
            '.xterm .xterm-screen canvas'
          ].join(',')
          setTimeout(() => {
            this.$refs.termContainer.querySelectorAll(sel).forEach(el => {
              el.style.height = '100%';
              el.style.width = '100%';
            })
            this.safeFit(0)
          }, 500)
        })
      } else {
        this.safeFit(500)
      }
    },
    safeFit(delay = 1000) {
      this.$nextTick(() => {
        setTimeout(() => {
          if (this.term && this.fitAddon) {
            try {
              this.fitAddon.fit()
            } catch (e) {
              console.warn('fit 失败:', e)
            }
            if (this.ws !== null && this.ws.readyState === 1) {
              this.ws.send(`resize:${this.term.rows}:${this.term.cols}`)
            }
          }
        }, delay)
      })
    },

    sendCommand(command) {
      if (this.ws && this.ws.readyState === 1) {
        this.ws.send(command)
      } else {
        console.error('WebSocket 未连接！')
      }
    },

    createTerm() {
      if (this.serverId === 0) {
        return
      }
      const termWeb = this.$refs.termContainer
      this.close()
      const fitAddon = this.fitAddon
      this.term = new Terminal()
      this.term.loadAddon(fitAddon)
      this.term.open(termWeb)
      this.safeFit()
      const self = this
      const heartCheck = {
        timeout: 5000,
        intervalObj: null,
        stop: function () {
          clearInterval(this.intervalObj)
        },
        start: function () {
          this.intervalObj = setInterval(function () {
            if (self.ws !== null && self.ws.readyState === 1) {
              self.ws.send('ping')
            }
          }, this.timeout)
        }
      }
      let closeTip = '已超时关闭!'
      try {
        this.ws = new WebSocket(`${(location.protocol === 'http:' ? 'ws' : 'wss')}://${location.host}/terminal/term?serverId=${this.serverId}&rows=${this.term.rows}&cols=${this.term.cols}&closeTip=${closeTip}&token=${encodeURIComponent(getToken())}`)
      } catch (e) {
        console.error('WebSocket 初始化失败：', e)
        this.term.write('无法建立 WebSocket 连接，请检查服务状态。')
        return;
      }
      this.ws.onopen = () => {
        console.log(Date(), 'onopen')
        heartCheck.start()
      }
      this.ws.onclose = () => {
        console.log(Date(), 'onclose')
        if (!self.resetClose) {
          this.ws = null
          this.isDisconnected = true
          self.term.clear(); // 清空终端内容
          self.term.write('  \x1b[31m连接已断开 请重新连接\x1b[39m'); // 红色文字显示断开信息
        }
        heartCheck.stop()
        self.resetClose = false
      }
      this.ws.onerror = () => {
        console.log(Date(), 'onerror')
      }
      const attachAddon = new AttachAddon(this.ws)
      this.term.loadAddon(attachAddon)
      this.term.attachCustomKeyEventHandler((e) => {
        const keyArray = ['F5', 'F11', 'F12']
        if (keyArray.indexOf(e.key) > -1) {
          return false
        }
        // ctrl + v
        if (e.ctrlKey && e.key === 'v') {
          document.execCommand('copy')
          return false
        }
        // ctrl + c
        if (e.ctrlKey && e.key === 'c' && self.term.hasSelection()) {
          document.execCommand('copy')
          return false
        }
      })

      const wheelSupport = 'onwheel' in document.createElement('div') ? 'wheel' : document.onmousewheel !== undefined ? 'mousewheel' : 'DOMMouseScroll'
      termWeb.addEventListener(wheelSupport, (e) => {
        if (e.ctrlKey) {
          e.preventDefault()
          if (e.deltaY < 0) {
            self.term.setOption('fontSize', ++this.fontSize)
          } else {
            self.term.setOption('fontSize', --this.fontSize)
          }
          self.safeFit()
        }
      })
    },
    close() {
      if (this.ws !== null) {
        this.ws.close()
        this.resetClose = true
      }
      if (this.term !== null) {
        this.term.dispose()
      }
    },
    setFileListVisible() {
      this.fileListVisible = !this.fileListVisible
    },
    toggleCommandPanel() {
      this.commandPanelVisible = !this.commandPanelVisible;
    },
    toggleFullScreen() {
      const element = this.$refs.fullscreenElement; // 获取 ref 引用的元素

      if (!element) {
        this.msgError("Element not found!");
        return;
      }

      if (document.fullscreenElement) {
        this.exitFullScreen();
      } else {
        this.setScreenfull();
      }
    },
    setScreenfull() {
      const element = this.$refs.fullscreenElement; // 获取 ref 引用的元素
      if (!element) {
        this.msgError("Element not found!");
        return;
      }
      if (element.requestFullscreen) {
        element.requestFullscreen(); // 标准全屏 API
      } else if (element.mozRequestFullScreen) { // Firefox
        element.mozRequestFullScreen();
      } else if (element.webkitRequestFullscreen) { // Chrome, Safari, Opera
        element.webkitRequestFullscreen();
      } else if (element.msRequestFullscreen) { // IE/Edge
        element.msRequestFullscreen();
      } else {
        this.msgError("Fullscreen API not supported by your browser");
      }

    },
    exitFullScreen() {
      if (document.exitFullscreen) {
        document.exitFullscreen();
      } else if (document.mozCancelFullScreen) { // Firefox
        document.mozCancelFullScreen();
      } else if (document.webkitExitFullscreen) { // Chrome, Safari, Opera
        document.webkitExitFullscreen();
      } else if (document.msExitFullscreen) { // IE/Edge
        document.msExitFullscreen();
      }
    },
    reconnect() {
      if (this.ws && this.ws.readyState === 1) {
        this.msgWarning("WebSocket 已连接，无法重连")
        return
      }
      this.isDisconnected = false  // 重连时先隐藏重连按钮
      this.createTerm()  // 重新创建 WebSocket 连接
    },
  }
}
</script>
