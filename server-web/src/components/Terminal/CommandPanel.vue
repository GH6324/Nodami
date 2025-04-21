<template>
  <SlideDialog v-if="visibleProp" :visible.sync="visibleProp">
    <div class="command-panel">
      <h3 class="panel-title">快捷命令</h3>
      <ul class="command-list">
        <li v-for="(value, key) in commands"
            :key="key"
            class="command-item"
            @click="sendCommandProp(value)">
          <span class="command-key">{{ key }}</span>
          <span class="command-value">{{ value }}</span>
        </li>
      </ul>
    </div>
  </SlideDialog>
</template>

<script>
import SlideDialog from "./SlideDialog.vue";

export default {
  name: 'CommandPanel',
  components: { SlideDialog },
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    commands: {
      type: Object,
      default: () => ({
        'Agent日志查看': 'clear && docker logs -f --tail 1000 vlink_agent\r',
        'Agent日志清空': `clear && for cid in $(docker ps -aq); do sudo truncate -s 0 "$(docker inspect --format='{{.LogPath}}' "$cid")"; done\r`,
        'Agent重启':    'clear && cd && docker restart  vlink_agent && echo "重启完成"\r',
        'Agent卸载':    'clear && cd && docker rm -f vlink_agent && rm -rf vlink_agent && rm -rf vlink_new  && rm -f agent_sing_box.zip?* && echo "卸载完成"\r',
        '安装Docker':   'clear && curl -sSL https://linuxmirrors.cn/docker.sh -o /tmp/docker_install.sh && sudo bash /tmp/docker_install.sh --source repo.huaweicloud.com/docker-ce --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true --protocol http\r',
        '安装Nxtrace':  'clear && curl nxtrace.org/nt | bash\r',
        '去程 电信':     'clear && nexttrace 202.97.33.110\r',
        '去程 联通':     'clear && nexttrace 219.158.113.106\r',
        '去程 移动':     'clear && nexttrace 221.183.55.22\r',
        '重启服务器':    'clear && sudo reboot\r',
      })
    },
    sendCommand: {
      type: Function,
      default: function (e){

      }
    }
  },
  methods:{
    sendCommandProp(e){
      this.sendCommand('\x03')
      setTimeout(()=>{
        this.sendCommand(e)
        this.$emit('update:visible', false);
      },500)

    }
  },
  computed: {
    visibleProp: {
      get() {
        return this.visible;
      },
      set(value) {
        this.$emit('update:visible', value);
      }
    }

  },
}
</script>

<style scoped>
.command-panel {
  height: 100%;
  padding: 16px;
  overflow-y: auto;
  background-color: rgb(255,255,255,0.5);
  font-family: 'SF Pro Text', -apple-system, BlinkMacSystemFont, sans-serif;
}

.panel-title {
  color: #64748b;
  font-size: 13px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 12px;
  padding-bottom: 6px;
  border-bottom: 1px solid #e2e8f0;
}

.command-list {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

.command-item {
  display: flex;
  align-items: center;
  padding: 8px 12px;
  margin: 4px 0;
  cursor: pointer;
  background-color: white;
  border-radius: 6px;
  transition: all 0.15s ease;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.03);
  border: 1px solid #e2e8f0;
  font-size: 13px;
  min-height: 36px;
}

.command-item:hover {
  background-color: #f1f5f9;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  border-color: #cbd5e1;
}

.command-key {
  flex: 0 0 130px;
  color: #334155;
  font-weight: 500;
  padding-right: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.command-value {
  flex: 1;
  min-width: 0; /* 关键：允许内容收缩 */
  max-width: 200px; /* 设置最大宽度 */
  color: #64748b;
  font-family: 'SF Mono', Menlo, Monaco, Consolas, monospace;
  font-size: 12px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  background-color: #f1f5f9;
  padding: 2px 8px;
  border-radius: 4px;
}
</style>
