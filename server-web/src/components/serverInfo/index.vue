<template>
  <div class="monitor-content">
    <!-- 第一行：系统基础信息 -->
    <el-row :gutter="8" class="info-row">
      <el-col :span="12">
        <div class="info-item">
          <span class="label"><i class="el-icon-monitor"></i> 公网IP</span>
          <div class="value-group">
            <div class="value ipv4">IPV4: {{ serverInfo.publicIPv4 || "--------" }}</div>
            <div class="value ipv6">IPV6: {{ serverInfo.publicIPv6 || '--------' }}</div>
          </div>
        </div>
      </el-col>

      <el-col :span="12">
        <div class="info-item">
          <span class="label"><i class="el-icon-connection"></i> 连接数</span>
          <div class="value-group connections">
            <div class="connection-badge tcp">
              <el-tag size="mini" effect="dark">TCP</el-tag>
              <span class="count">{{ serverInfo.tcpConnections || 0 }}</span>
            </div>
            <div class="connection-badge udp">
              <el-tag size="mini" effect="dark" type="success">UDP</el-tag>
              <span class="count">{{ serverInfo.udpConnections || 0 }}</span>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 第二行：网络流量 -->
    <div class="section compact-section">
      <div class="section-header">
        <span class="title"><i class="el-icon-data-line"></i> 网络流量</span>
        <el-select
          v-model="activeNetwork"
          size="mini"
          style="width: 120px">
          <el-option
            v-for="(net, index) in serverInfo.networkBytes" :key="index"
            :label="net.ifaceName || `接口${index+1}`" :value="index"
          />
        </el-select>
      </div>
      <el-row :gutter="8" class="traffic-row">
        <el-col :span="12">
          <div class="traffic-item upload">
            <div class="direction"><i class="el-icon-top"></i> 上行</div>
            <div class="speed">{{
                serverInfo.networkBytes && activeNetwork !== undefined ? sizeFormat(serverInfo.networkBytes[activeNetwork].upSpeed) : 0
              }}/s
            </div>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="traffic-item download">
            <div class="direction"><i class="el-icon-bottom"></i> 下行</div>
            <div class="speed">{{
                serverInfo.networkBytes && activeNetwork !== undefined ? sizeFormat(serverInfo.networkBytes[activeNetwork].domSpeed) : 0
              }}/s
            </div>
          </div>
        </el-col>
      </el-row>
    </div>

    <!-- 第三行：资源监控 -->
    <div class="section compact-section">
      <div class="section-header">
        <span class="title"><i class="el-icon-odometer"></i> 资源状态</span>
      </div>
      <el-row :gutter="8" class="resource-row">
        <!-- CPU -->
        <div class="resource-donut">
          <el-progress
            type="dashboard"
            :width="100"
            :percentage="serverInfo.cpuUsage"
            :color="customColors"
            :format="() => ''"
          />
          <div class="donut-label">
            <div class="title">CPU</div>
            <div class="value">{{ serverInfo.cpuUsage }}%</div>
            <div class="sub">{{ serverInfo.cpuCores }}核</div>
          </div>
        </div>

        <!-- 物理内存 -->
        <div class="resource-donut">
          <el-progress
            type="dashboard"
            :width="100"
            :percentage="serverInfo.mem.freePercent"
            :color="customColors"
            :format="() => ''"
          />
          <div class="donut-label">
            <div class="title">内存</div>
            <div class="value">{{ serverInfo.mem.freePercent.toFixed(1) }}%</div>
            <div class="sub">{{ sizeFormat(serverInfo.mem.total) }}</div>
          </div>
        </div>

        <!-- 虚拟内存 -->
        <div class="resource-donut" v-if="serverInfo.swap.total>0">
          <el-progress
            type="dashboard"
            :width="100"
            :percentage="serverInfo.swap.freePercent"
            :color="customColors"
            :format="() => ''"
          />
          <div class="donut-label">
            <div class="title">swap</div>
            <div class="value">{{ serverInfo.swap.freePercent.toFixed(1) }}%</div>
            <div class="sub">{{ sizeFormat(serverInfo.swap.total) }}</div>
          </div>
        </div>

        <!-- 磁盘存储 -->
        <div class="resource-donut">
          <el-progress
            type="dashboard"
            :width="100"
            :percentage="serverInfo.disk.freePercent"
            :color="customColors"
            :format="() => ''"
          />
          <div class="donut-label">
            <div class="title">磁盘</div>
            <div class="value">{{ serverInfo.disk.freePercent.toFixed(1) }}%</div>
            <div class="sub">{{ sizeFormat(serverInfo.disk.total) }}</div>
          </div>
        </div>
      </el-row>
    </div>

    <!-- 新增操作按钮区域 -->
    <el-row class="button-group" :gutter="8">
      <el-col :span="24">
        <div style="margin-bottom: 12px; display: flex; gap: 4px; flex-wrap: wrap;">
          <el-button
            v-if="isDisconnected"
            size="mini"
            type="danger" plain
            @click="initWebSocket()"
          >重新连接
          </el-button>
          <el-button
            size="mini"
            type="success" plain
            @click="reVpnServer()"
          >重载VPN服务
          </el-button>
          <el-button
            size="mini"
            type="warning" plain
            @click="reServer()"
          >重启服务器
          </el-button>
          <el-button v-if="showSSH"
            size="mini" plain
            @click="()=>{
              open_ssh = !open_ssh
            }"
          >打开终端
          </el-button>
        </div>
      </el-col>
    </el-row>
    <el-dialog title="终端" :visible.sync="open_ssh" width="60%" append-to-body>
      <terminal :serverId="serverId" style="flex-grow: 1;position: relative;height: 600px"></terminal>
    </el-dialog>
  </div>
</template>

<script>
import BasicLayout from '@/layout/BasicLayout'
import Cell from '@/components/Cell/index'


import {sizeFormat} from '@/utils'
import ResourceProgress from '@/components/ResourceProgress'
import terminal from "@/components/Terminal/index.vue";
import {reStartServer, reStartVpnServer} from "@/api/vpn/vpnServer";
import {getToken} from "@/utils/auth";


export default {
  components: {terminal, BasicLayout, Cell, ResourceProgress},
  props: {
    serverId: {
      type: Number,
      required: true
    },
    showSSH: {
      type: Boolean,
      required: false
    }
  },
  data() {
    return {
      open_ssh: false,
      activeNetwork: undefined,
      ws: undefined,
      isDisconnected: false,
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
    this.initWebSocket()
  },
  beforeDestroy() {
    this.close()
  },
  methods: {
    close() {
      if (this.ws !== null) {
        this.ws.close()
      }
    },
    initWebSocket() {
      this.isDisconnected = false
      if (this.ws) {
        this.ws.close();
        this.ws = null
      }
      try {
        let wsUrl = `${(location.protocol === 'http:' ? 'ws' : 'wss')}://${location.host}/terminal/info?serverId=${this.serverId}&token=${encodeURIComponent(getToken())}`
        this.ws = new WebSocket(wsUrl)
        this.ws.onmessage = ({ data }) => {
          this.isDisconnected = false;
          // ① 判空
          if (!data) return;

          // ② 尝试解析：仅当以 { 或 [ 开头时才当作 JSON
          const firstChar = typeof data === 'string' ? data.trim()[0] : '';
          if (firstChar === '{' || firstChar === '[') {
            try {
              const info = JSON.parse(data);
              if (info["common"]){
                this.serverInfo.publicIPv4 = info["common"].publicIPv4
                this.serverInfo.publicIPv6 = info["common"].publicIPv6
                this.serverInfo.cpuCores = info["common"].cpuCores
              }
              if (info["networkBytes"]){
                this.serverInfo.networkBytes = info["networkBytes"]
                this.$nextTick(() => {
                  if (this.activeNetwork === undefined && info.networkBytes) {
                    this.activeNetwork = 0;
                  }
                });
              }

              if (info["connections"]){
                this.serverInfo.tcpConnections = info["connections"].tcpConnections
                this.serverInfo.udpConnections = info["connections"].udpConnections
              }

              if (info["usage"]){
                this.serverInfo.cpuUsage = info["usage"]
              }

              if (info["memory"]){
                this.serverInfo.mem = info["memory"].mem
                this.serverInfo.swap = info["memory"].swap
              }
              if (info["disk"]){
                this.serverInfo.disk = info["disk"]
              }
            } catch (e) {
              // 解析失败 fall through，继续走到“非 JSON”分支
              console.warn('WS JSON 解析失败：', e, data);
            }
          }

          // ③ 非 JSON 消息：可按需做提示 / 上屏
          console.warn('WS 非 JSON 消息：', data);
          // 也可以把这类文本塞进一个 toast 或 log 面板：
          // this.$message.error(data);
        }
        this.ws.onclose = () => {
          this.isDisconnected = true
        }
        this.ws.onerror = () => {
        }
      }catch (e) {
        this.isDisconnected = true
      }

    },
    sizeFormat(d) {
      return sizeFormat(d)
    },
    reVpnServer() {
      this.$confirm(`你确定要重启选中服务器${this.serverId}的代理服务?`, "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then( () =>{
        return reStartVpnServer([this.serverId]);
      }).then(() => {
        this.msgSuccess("提交成功");
      }).catch(function () {
      });
    },
    reServer() {
      this.$confirm(`你确定要重启选中服务器:${this.serverId}?`, "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        return reStartServer([this.serverId]);
      }).then(() => {
        this.msgSuccess("提交成功");
      }).catch(function () {
      });
    },
  }
}
</script>
<style lang="scss" scoped>

/* 新增按钮组样式 */
.button-group {

  margin-top: 22px;


  .el-button {
    flex: 1; /* 等宽按钮 */
    min-width: 80px; /* 最小宽度 */
    margin: 2px !important;
    padding: 6px 8px;

    + .el-button {
      margin-left: 0;
    }
  }
}


// 信息卡片行样式
.info-row {
  margin-bottom: 12px;

  .info-item {
    background: #f8f9fa;
    border-radius: 4px;
    padding: 8px 12px;
    margin-bottom: 8px;

    .label {
      display: flex;
      align-items: center;
      font-size: 12px;
      color: #606266;
      margin-bottom: 4px;

      i {
        margin-right: 4px;
      }
    }

    .value-group {
      min-height: 40px;

      .value {
        font-size: 12px;
        line-height: 1.4;

        &.ipv4 {
          color: #1890ff;
          font-weight: 500;
        }

        &.ipv6 {
          color: #67c23a;
          font-weight: 500;
        }
      }

      &.connections {
        display: flex;
        gap: 8px;

        .connection-badge {
          display: flex;
          align-items: center;
          gap: 4px;

          .count {
            font-size: 14px;
            font-weight: 500;
          }
        }
      }
    }
  }
}

// 网络流量与资源监控公共节样式
.section.compact-section {
  margin: 16px 0;

  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;

    .title {
      font-size: 13px;
      font-weight: 500;
      color: #303133;

      i {
        margin-right: 4px;
      }
    }
  }
}

// 网络流量样式
.traffic-row {
  .traffic-item {
    background: #f8f9fa;
    border-radius: 4px;
    padding: 12px;
    text-align: center;

    .direction {
      font-size: 12px;
      color: #909399;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 4px;
    }

    .speed {
      font-size: 15px;
      font-weight: 500;
      margin: 6px 0;
    }

    &.upload {
      border-left: 3px solid #e6a23c;
    }

    &.download {
      border-left: 3px solid #67c23a;
    }
  }
}

// 资源监控流式布局
.resource-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start; // 或者 space-between
}

.resource-donut {
  width: 100px;
  height: 100px;
  position: relative;
  text-align: center;

  ::v-deep .el-progress-circle {
    transform: scale(0.9);

    path:first-child {
      stroke: #f0f2f5;
    }
  }

  .donut-label {
    position: absolute;
    top: 70%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    width: 100%;

    .title {
      font-size: 13px;
      color: #606266;
      margin-bottom: 2px;
    }

    .value {
      font-size: 12px;
      color: #303133;
      line-height: 1.2;
      margin-top: 10px;
    }

    .sub {
      font-size: 12px;
      color: #909399;
      margin-top: 20px;
    }
  }
}





</style>
