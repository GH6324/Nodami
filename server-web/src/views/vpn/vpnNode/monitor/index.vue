<template>
  <div>
    <BasicLayout>
      <template #wrapper>
        <el-row :gutter="10" class="mb10">
          <el-card class="stats-card" style="height: 530px">
            <el-col>
              <el-col style="display: flex;justify-content: center">
                <el-col class="scrollable-radio-group">
                  <el-radio-group v-model="statusLabel" size="mini">
                    <el-radio-button label="延迟测速"></el-radio-button>
                    <template v-for="(value, key) in serverLabelList">
                      <el-radio-button :label="value.serverName"></el-radio-button>
                    </template>
                  </el-radio-group>
                </el-col>
              </el-col>
              <div class="compact-layout" v-if="statusLabel === '延迟测速'">
                <div class="enhanced-dashboard">

                  <!-- 节点延迟模块 -->
                  <el-card class="elegant-card latency-panel" shadow="never" v-if="serverPingList.length>0">
                    <div class="panel-header">
                      <div class="title-group">
                        <i class="el-icon-cpu header-icon"></i>
                        <span class="panel-title">服务器连通测试</span>
                      </div>
                      <el-button
                        size="mini"
                        type="text"
                        :loading="serverPinging"
                        @click="setServerPinging"
                        class="refresh-icon">
                        <i class="el-icon-refresh-right"></i>
                      </el-button>
                    </div>
                    <div class="latency-grid">
                      <template v-for="(v, index) in serverPingList">
                        <div class="latency-connection">
                          <span class="node-id">服ID:{{v.inServerId}}</span>
                          <div class="arrow-section" :class="getLatencyType(v.ping)">
                            <span class="latency-value">
                              <i v-if="v.pinging" class="el-icon-loading" style="margin-right: 4px;"></i>
                              {{ formatLatency(v.ping) }}
                            </span>
                            <div class="arrow-line"></div>
                            <div class="arrow-head">▶</div>
                          </div>
                          <span class="node-id" v-if="(index+1) === serverPingList.length">服ID:{{ v.toServerId }}</span>
                        </div>
                      </template>
                    </div>
                  </el-card>

                  <!-- 全球测试模块 -->
                  <el-card class="elegant-card global-panel " shadow="never" style="position: relative">
                    <div class="tabs-with-refresh" >
                      <el-tabs v-model="activeTestType" class="modern-tabs">
                        <el-tab-pane name="ping">
                          <template #label>
                          <span class="tab-label">
                            <i class="el-icon-timer"></i>
                            节点延迟
                          </span>
                          </template>
                          <div class="metric-grid" :style="{'max-height': serverPingList && serverPingList.length>0?'210px':'370px'}">
                            <div v-for="(v,i) in vpnNodePingTests" :key="'p'+i" class="metric-card" :class="getLatencyType(v.ping)">
                              <div class="metric-header">
                                <span class="nation-name">{{ v.nationName }}</span>
                                <div class="metric">
                                  <span class="metric-value" @click="pingTest(v)">
                                    <i v-if="v.pinging" class="el-icon-loading" style="margin-right: 4px;"></i>
                                    {{ formatLatency(v.ping) }}
                                  </span>
                                  <div class="status-indicator"></div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </el-tab-pane>

                        <el-tab-pane name="speed">
                          <template #label>
                          <span class="tab-label">
                            <i class="el-icon-data-line"></i>
                            节点测速
                          </span>
                          </template>
                          <div class="metric-grid" :style="{'max-height': serverPingList && serverPingList.length>0?'210px':'370px'}">
                            <div v-for="(v,i) in vpnNodeSpeedTests" :key="'s'+i" class="metric-card" :class="getSpeedType(v.speed)">
                              <div class="metric-header">
                                <span class="nation-name">{{ v.nationName }}</span>
                                <div class="metric">
                                  <span class="metric-value" @click="speedTest(v)">
                                    <i v-if="v.speeding" class="el-icon-loading" style="margin-right: 4px;"></i>
                                    {{ formatSpeed(v.speed) }}
                                  </span>
                                  <div class="status-indicator"></div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </el-tab-pane>
                      </el-tabs>
                      <el-button
                        size="mini"
                        type="text"
                        :loading="globalTesting"
                        class="refresh-icon refresh-btn-absolute"
                        @click="refreshGlobalTest"
                        title="刷新当前测试数据">
                        <i class="el-icon-refresh-right"></i>
                      </el-button>
                    </div>
                  </el-card>
                </div>
              </div>


              <template v-for="(value, key) in serverLabelList">
                <div class="compact-layout" v-show="statusLabel === value.serverName">
                  <serverInfo :serverId="value.serverId" :showSSH="true"></serverInfo>
                </div>
              </template>
            </el-col>
          </el-card>
        </el-row>
      </template>
    </BasicLayout>
  </div>
</template>

<script>
import BasicLayout from '@/layout/BasicLayout'
import Cell from '@/components/Cell/index'
import {pingServer} from "@/api/vpn/vpnServer";
import ResourceProgress from '@/components/ResourceProgress'
import {pingTest, speedTest} from "@/api/vpn/vpnNode";
import {listVpnNodePing} from "@/api/vpn/vpnNodePing";
import serverInfo from '@/components/serverInfo'


export default {
  name: 'Monitor',
  components: {serverInfo, BasicLayout, Cell, ResourceProgress},
  props: {
    nodeInfo: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      logLabel: "命令终端",
      statusLabel: "延迟测速",
      serverLabelList: [],
      activeTestType: "ping",
      serverLabel: this.nodeInfo.serverId,
      activeNetwork: undefined,
      globalTesting: false,
      serverInfo: {
        publicIPv4: undefined,
        publicIPv6: undefined,
        networkBytes: undefined,
        tcpConnections: undefined,
        udpConnections: undefined,
        cpuCores: undefined,
        cpuUsage: undefined,
        mem: {
          totalSpace: 0,
          usedSpace: 0,
          freeSpace: 0,
          freePercent: 0
        },
        swap: {
          totalSpace: 0,
          usedSpace: 0,
          freeSpace: 0,
          freePercent: 0
        },
        disk: {
          totalSpace: 0,
          usedSpace: 0,
          freeSpace: 0,
          freePercent: 0
        }
      },
      vpnNodeSpeedTests: [],
      vpnNodePingTests: [],
      serverPingList: [],
      serverPinging: false,
      customColors: [
        {color: '#13ce66', percentage: 20},
        {color: '#1890ff', percentage: 40},
        {color: '#e6a23c', percentage: 60},
        {color: '#1989fa', percentage: 80},
        {color: '#F56C6C', percentage: 100}
      ]
    }
  },
  mounted() {
    this.sortedServerLabelList()
    this.setServerPinging()
    this.listVpnNodePing()
  },
  beforeDestroy() {

  },
  methods: {
    sortedServerLabelList() {
      const {serverId, frpServerId, transfers} = this.nodeInfo;

      const labelList = [];

      const forwardMap = new Map();
      const reverseMap = new Map();

      transfers.forEach(item => {
        forwardMap.set(item.entranceServerId, item.exitServerId);
        reverseMap.set(item.exitServerId, item.entranceServerId);
      });

      // 找到起点
      let start = null;
      for (let [entrance] of forwardMap) {
        if (!reverseMap.has(entrance)) {
          start = entrance;
          break;
        }
      }

      const visited = new Set();
      const orderedIds = [];

      let current = start;
      while (current && !visited.has(current)) {
        orderedIds.push(current);
        visited.add(current);
        current = forwardMap.get(current);
      }

      // 处理 orderedIds
      orderedIds.forEach(id => {
        if (id !== serverId) {
          labelList.push({
            serverId: id,
            serverName: '中转服ID:' + id,
          });
        }
      });

      // FRP 服
      if (frpServerId) {
        labelList.push({
          serverId: frpServerId,
          serverName: 'FRP服ID:' + frpServerId,
        });
      }

      // 最后是 VPN 本身
      labelList.push({
        serverId: serverId,
        serverName: 'VPN服ID:' + serverId,
      });

      this.serverLabelList = labelList;

      for (let i = 1; i < this.serverLabelList.length; i++) {
        this.serverPingList.push({
          inServerId: this.serverLabelList[i - 1].serverId,
          toServerId: this.serverLabelList[i].serverId,
          ping: 0,
          pinging: false
        })
      }
      console.log(this.serverPingList)
    },
    pingTest(item){
      item.pinging = true;
      item.ping = 0;
      return pingTest(this.nodeInfo.nodeId, item.pingId)
        .then(ret => {
          item.ping = ret.data;
        })
        .catch(() => {
          item.ping = -1;
        })
        .finally(() => {
          item.pinging = false;
        });
    },
    speedTest(item){
      item.speeding = true;
      item.speed = 0;
      return speedTest(this.nodeInfo.nodeId, item.speedId)
        .then(ret => {
          item.speed = ret.data * 1000;
        })
        .catch(() => {
          item.speed = -1;
        })
        .finally(() => {
          item.speeding = false;
        });
    },
    async refreshGlobalTest(all = false) {
      console.log("refreshGlobalTest")
      this.globalTesting = true;
      if (this.activeTestType === 'ping' || all) {
        const promises = this.vpnNodePingTests.map((item, index) => {
          return this.pingTest(item)
        });
        await Promise.all(promises);
      }

      if (this.activeTestType === 'speed' || all) {
        const promises = this.vpnNodeSpeedTests.map((item, index) => {
          return this.speedTest(item)
        });
        await Promise.all(promises);
      }

      this.globalTesting = false;
    },
    async setServerPinging() {
      this.serverPinging = true;
      const promises = this.serverPingList.map((item, index) => {
        item.pinging = true;
        item.ping = 0;
        return pingServer(item.inServerId, item.toServerId)
          .then(ret => {
            item.ping = ret.data.value;
          })
          .catch(() => {
            item.ping = -1;
          })
          .finally(() => {
            item.pinging = false;
          });
      });
      await Promise.all(promises);
      this.serverPinging = false;
    },
    async  listVpnNodePing() {
      await listVpnNodePing({pageNum: 1, pageSize: 100,}).then(response => {
        for (let i in response.data.list) {
          let pingInfo = response.data.list[i]
          this.vpnNodePingTests.push({
            nationName: pingInfo.nationName,
            ping: 0,
            pingId: pingInfo.pingId,
            pinging: false,
          })
          this.vpnNodeSpeedTests.push({
            nationName: pingInfo.nationName,
            speed: 0,
            speedId: pingInfo.pingId,
            speeding: false,
          })
        }
      });
      this.refreshGlobalTest(true)
    },
    getLatencyType(value) {
      if (value < 0) return 'danger'
      if (value === 0) return 'info'
      if (value < 100) return 'success'
      if (value < 1000) return 'warning'
      if (value > 1000) return 'danger'
      return 'danger'
    },
    formatSpeed(speed) {
      if (speed < 0) return '超时'
      if (speed === 0) return '-- MB/s'
      return `${(speed / 1024 / 1024).toFixed(1)} MB/s`
    },
    getSpeedType(speed) {
      let value = speed / 1024 / 1024
      if (value < 0) return 'danger'
      if (value === 0) return 'info'
      if (value < 3) return 'warning'
      if (value > 3) return 'success'
      return 'danger'
    },
    formatLatency(value) {
      if (value === -1) {
        return "超时"
      }
      return value > 0 ? `${value} ms` : '-- ms'
    },
  }
}
</script>

<style lang="scss" scoped>


/* 调整信息区域高度 */
.compact-layout {
  height: 100%;
  display: flex;
  flex-direction: column;

  .info-row {
    flex: none;
  }

  .section.compact-section {
    flex: 1;
    min-height: 0; /* 允许内容收缩 */

    &.resource-section {
      flex: 2; /* 资源监控区域分配更多空间 */
    }
  }
}


// 全局卡片样式
.stats-card {
  .compact-layout {
    padding: 12px;
    height: 100%;
    display: flex;
    flex-direction: column;
  }
}


.enhanced-dashboard {
  height: 430px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  --primary-color: #409EFF;
  --success-color: #67C23A;
  --warning-color: #E6A23C;
  --danger-color: #F56C6C;
  --bg-color: #f8fafc;
}

/* 通用卡片样式 */
.elegant-card {
  border: 1px solid #ebeef5;
  border-radius: 8px;
  transition: box-shadow 0.3s;

  &:hover {
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.08);
  }
}

/* 节点延迟面板 */
.latency-grid {
  display: flex;
  flex-direction: row;
  overflow-x: auto;
  align-items: center;
  padding: 16px;
}

.latency-connection {
  display: flex;
  align-items: center;
  flex-shrink: 0;
  font-family: 'JetBrains Mono', monospace;
  color: #606266;
  font-size: 13px;
}

.node-id {
  white-space: nowrap;
}

.arrow-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 0 8px;
  font-size: 12px;
  color: #909399;
}

.latency-value {
  margin-bottom: 2px;
}

.arrow-line {
  width: 60px;
  height: 1px;
  background: currentColor;
  position: relative;
}

.arrow-head {
  margin-top: 2px;
  font-size: 12px;
}


/* 全球测试面板 */
.global-panel {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;

  .el-tabs__content {
    flex: 1;
    min-height: 0;
    display: flex;
    flex-direction: column;
  }

  .metric-grid {
    overflow-y: auto;
    flex: 1;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    gap: 12px;
    padding: 16px;
  }

  .metric-card {
    background: white;
    border-radius: 6px;
    padding: 10px;
    transition: all 0.3s;
    border-left: 3px solid;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);


    &:hover {
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .metric-header {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .nation-name {
        font-size: 10px;
        color: #303133;
        max-width: 80px;
        white-space: nowrap; // 不换行
        overflow: hidden; // 超出隐藏
        text-overflow: ellipsis; // 超出显示省略号
      }

      .metric {
        display: flex;
        align-items: center;

        .metric-value {
          font-family: 'JetBrains Mono', monospace;
          font-size: 12px;
        }

        .status-indicator {
          margin-left: 5px;
          display: flex;
          align-items: center;
          width: 8px;
          height: 8px;
          border-radius: 50%;
          background: currentColor;
        }
      }
    }
  }


}


.success {
  border-color: var(--success-color);
  color: var(--success-color); // ✅ 设置 color
}

.warning {
  border-color: var(--warning-color);
  color: var(--warning-color);
}

.danger {
  border-color: var(--danger-color);
  color: var(--danger-color);
}

.info {
  border-color: #909399;
  color: #909399;
}


.refresh-icon {
  padding: 4px;
  color: #909399;
  transition: transform 0.3s;

  &:hover {
    color: var(--primary-color);
    transform: rotate(180deg);
  }
}

.panel-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  border-bottom: 2px solid #ebeef5;

  .title-group {
    display: flex;
    align-items: center;
    gap: 8px;

    .header-icon {
      font-size: 16px;
      color: var(--primary-color);
    }

    .panel-title {
      font-size: 14px;
      font-weight: 500;
      color: #303133;
    }
  }

}

.tabs-with-refresh {
  position: relative;
}

.refresh-btn-absolute {
  position: absolute;
  top: 6px;
  right: 8px;
  z-index: 2;
  color: #909399;
  transition: transform 0.3s;

  &:hover {
    color: var(--primary-color);
    transform: rotate(180deg);
  }
}

.scrollable-radio-group {
  overflow-x: auto;
  white-space: nowrap;
  padding: 4px 0;


  ::v-deep .el-radio-group {
    display: inline-flex;
    flex-wrap: nowrap;
    border-radius: 5px;
  }

  ::v-deep .el-radio-button__inner {
    margin-right: -1px;
    padding-left: 10px;
    padding-right: 10px;
    border: 0.1px solid #dcdfe6;
  }

  &::-webkit-scrollbar {
    height: 0;
  }
}


</style>
