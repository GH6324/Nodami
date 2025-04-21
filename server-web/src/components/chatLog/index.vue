<template>
  <div class="wrapper">
    <pre ref="logContent" class="log-content" v-html="getColoredLog()"></pre>
  </div>
</template>

<script>
import AnsiToHtml from 'ansi-to-html'
import {log} from "@/api/vpn/vpnServer";

export default {
  props: {
    serverId: {
      type: Number,
      required: false
    },
    logLabel: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      timer: null,
      coloredLog: '',
      scrollHeight: 0,
    }
  },
  watch: {
    logLabel(n, o) {
      this.setLog()
    }
  },
  beforeDestroy() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  },
  mounted() {
    this.setLog()
    this.timer = setInterval(() => {
      this.setLog()
    }, 5000)
  },
  methods: {
    getColoredLog() {
      const lines = this.coloredLog.split('\n');
      let coloredLog = '';

      lines.forEach((line) => {
        let coloredLine = line;

        if (line.toLowerCase().includes('info')) {
          coloredLine = `<span style="color: green;">${line}</span>`;
        } else if (line.toLowerCase().includes('error')) {
          coloredLine = `<span style="color: red;">${line}</span>`;
        } else if (line.toLowerCase().includes('debug')) {
          coloredLine = `<span style="color: blue;">${line}</span>`;
        }

        coloredLog += coloredLine + '<br>';
      });

      return coloredLog;
    },
    setLog() {
      // this.coloredLog = ""
      log(this.serverId, this.logLabel).then(response => {
        this.setColoredLog(response.data)
        this.$nextTick(() => {
          const container = this.$refs.logContent
          if (this.scrollHeight === container.scrollTop) {
            this.scrollToEnd()
          }
        })
      })
    },
    setColoredLog(text) {

      const converter = new AnsiToHtml()
      this.coloredLog = converter.toHtml(text)
    },
    scrollToEnd() {
      const el = this.$refs.logContent
      this.$nextTick(() => {
        el.scrollTop = el.scrollHeight
      })
    }
  }
}
</script>

<style scoped>
.wrapper {
  display: flex;
  flex-direction: column;
  height: 100%;
  min-height: 0; /* 关键：允许子弹性盒收缩 */
}

.log-content {
  flex: 1 1 auto;               /* 相当于 flex-grow:1; flex-shrink:1; flex-basis:auto */
  min-height: 0;                /* 防止内容撑破父级 */
  max-height: 540px;
  overflow: auto;

  background: #000;
  color: #969799;
  border: 1px solid #444;
  border-radius: 4px;
  padding: 8px 12px;

  white-space: pre-wrap;        /* 保留换行并自动折行 */
  margin: 0;
}

</style>
