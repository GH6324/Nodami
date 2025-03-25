<template>
  <div>
    <BasicLayout>
      <template #wrapper>
        <el-row :gutter="10" class="mb10">
          <el-col :sm="8" :xs="24">
            <el-card class="box-card" style="height: 550px">
              <div style="height: 500px;padding: 5px;">
                <div class="monitor" style="padding-top:0px;">
                  <div class="monitor-content">
                    <el-row :gutter="10">
                      <el-col>
                        <Cell label="主IP" :value="info.mainIp" border/>
                        <Cell
                          label="总(↑|↓)"
                          :value="`${sizeFormat(info.netTraffic.recv)}/${sizeFormat(info.netTraffic.sent)}`"
                          border
                        />
                        <Cell
                          label="时(↑|↓)"
                          :value="`${sizeFormat(info.netIO.up)}/${sizeFormat(info.netIO.down)}`"
                          border
                        />
                        <Cell
                          label="udp|tcp"
                          :value="`${info.udpCount}|${info.tcpCount}`"
                          border
                        />
                        <Cell
                          label="内存"
                          :value="`${sizeFormat(info.mem.current)}/${sizeFormat(info.mem.total)}`"
                          border
                        />
                        <Cell
                          label="硬盘"
                          :value="`${sizeFormat(info.disk.current)}/${sizeFormat(info.disk.total)}`"
                          border
                        />
                        <el-row :gutter="10" class="monitor-progress">
                          <el-col :sm="24" :md="6">
                            CPU
                          </el-col>
                          <el-col :sm="24" :md="18">
                            <el-progress
                              :color="customColors"
                              :text-inside="true"
                              :stroke-width="24"
                              :percentage="parseFloat(parseFloat(info.cpu).toFixed(2))"
                            />
                          </el-col>
                        </el-row>
                        <el-row :gutter="10" class="monitor-progress">
                          <el-col :sm="24" :md="6">
                            RAM
                          </el-col>
                          <el-col :sm="24" :md="18">
                            <el-progress
                              :color="customColors"
                              :text-inside="true"
                              :stroke-width="24"
                              :percentage="parseFloat((parseFloat(info.mem.current)/parseFloat(info.mem.total)*100).toFixed(2)) || 0"
                            />
                          </el-col>
                        </el-row>
                        <el-row :gutter="10" class="monitor-progress">
                          <el-col :sm="24" :md="6">
                            硬盘
                          </el-col>
                          <el-col :sm="24" :md="18">
                            <el-progress
                              :color="customColors"
                              :text-inside="true"
                              :stroke-width="24"
                              :percentage="parseFloat((parseFloat(info.disk.current)/parseFloat(info.disk.total)*100).toFixed(2)) || 0"
                            />
                          </el-col>
                        </el-row>
                      </el-col>
                    </el-row>
                  </div>
                </div>
              </div>

            </el-card>
          </el-col>
          <el-col :sm="16" :xs="24">
            <el-card class="box-card" style="height: 550px">
              <el-col>
                <el-row :gutter="24">
                  <el-col :span="15">
                    <el-radio-group v-model="logLabel" size="mini">
                      <el-radio-button label="ssh"></el-radio-button>
                      <el-radio-button label="agent"></el-radio-button>
                      <el-radio-button label="singBox"></el-radio-button>
                      <el-radio-button label="frp"></el-radio-button>
                    </el-radio-group>
                  </el-col>
                  <el-col :span="9">
                    <el-row style="text-align: right;">
                      <el-button
                        size="mini"
                        type="primary" plain
                        style="padding: 6px 6px 6px 6px;margin: 0px"
                        @click="reStartServer()"
                      >重启服务器
                      </el-button>
                      <el-button
                        size="mini"
                        type="success" plain
                        style="padding: 6px 6px 6px 6px;margin: 0px"
                        @click="reStartSingBox()"
                      >重启VPN服务
                      </el-button>
                      <el-button
                        v-if="serverInfo.isPppoe == 1"
                        size="mini"
                        type="warning" plain
                        @click="pppoeReStart()"
                        style="padding: 6px 6px 6px 6px;margin: 0px"
                      >重新拨号
                      </el-button>
                    </el-row>
                  </el-col>
                </el-row>
                <chatLog v-if="serverInfo" :logLabel="logLabel" :server-id="serverInfo.serverId"/>
              </el-col>
            </el-card>
          </el-col>
        </el-row>
      </template>
    </BasicLayout>
  </div>
</template>

<script>
import BasicLayout from '@/layout/BasicLayout'
import Cell from '@/components/Cell/index'
import chatLog from '@/components/chatLog'

import {sizeFormat} from '@/utils'
import {info, pppoeReStart, reStartServer, reStartXray} from "@/api/vpn/vpnServer";

export default {
  name: 'Monitor',
  components: {BasicLayout, Cell, chatLog},
  props: {
    serverInfo: {
      type: Object,
      required: false
    }
  },
  data() {
    return {
      logLabel: "ssh",
      timer: null,
      info: {
        cpu: 0.0, // float64
        mem: {
          current: 0, // uint64
          total: 0 // uint64
        },
        swap: {
          current: 0, // uint64
          total: 0 // uint64
        },
        disk: {
          current: 0, // uint64
          total: 0 // uint64
        },
        xray: {
          state: '', // string
          errorMsg: '', // string
          version: '' // string
        },
        uptime: 0, // uint64
        loads: [0.0, 0.0, 0.0], // array of float64
        tcpCount: 0, // int32
        udpCount: 0, // int32
        netTraffic: {
          sent: 0, // uint64
          recv: 0 // uint64
        },
        netIO: {
          up: 0,
          down: 0
        },
        mainIp: ''
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
  // watch: {
  //   serverId(n, o) {
  //     if (o !== n && n && n.id > 0) {
  //       this.getServerInfo()
  //     }
  //   }
  // },
  beforeDestroy() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  },
  mounted() {
    this.getServerInfo()
    this.timer = setInterval(() => {
      this.getServerInfo()
    }, 5000)
  },
  methods: {
    getServerInfo() {
      info(this.serverInfo.serverId).then(ret => {
        this.info = ret.data
      })
    },
    sizeFormat(d) {
      return sizeFormat(d)
    },
    reStartServer() {
      const serverIds = this.serverInfo.serverId;
      this.$confirm('你确定要重启选中服务器?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return reStartServer(serverIds);
      }).then(() => {
        this.msgSuccess("提交成功");
      }).catch(function () {
      });
    },
    reStartSingBox() {
      const serverIds = this.serverInfo.serverId;
      this.$confirm('你确定要重启选中服务器的代理服务?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return reStartXray(serverIds);
      }).then(() => {
        this.msgSuccess("提交成功");
      }).catch(function () {
      });
    },
    pppoeReStart() {
      const serverIds = this.serverInfo.serverId;
      this.$confirm('你确定要重新拨号选中服务器 如非拨号服务器将是无效操作', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return pppoeReStart(serverIds);
      }).then(() => {
        this.msgSuccess("提交成功");
      }).catch(function () {
      });
    }
  }
}
</script>

<style lang="scss" scoped>

.monitor {

  .monitor-progress {
    padding-top: 15px;
  }

}

</style>
