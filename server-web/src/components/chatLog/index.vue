<template>
  <div>
    <pre ref="logContent" class="log-content" v-html="getColoredLog()" />
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
      log(this.serverId,this.logLabel).then(response => {
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
      const container = this.$refs.logContent
      container.scrollTop = container.scrollHeight
      this.scrollHeight = container.scrollTop
    }
  }
}
</script>

<style scoped>
.log-content {
  background-color: rgba(0,0,0,0.9);
  border-radius: 5px;
  padding: 5px;
  color: #969799;
  border: 1px solid #ccc;
  overflow: auto;
  height: 460px; /* 或其他合适的高度 */
  /*white-space: pre-wrap;*/
  /*box-sizing: border-box;*/
}
</style>
