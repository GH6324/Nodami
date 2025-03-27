<template>
  <div>
    <BasicLayout>
      <template #wrapper>
        <el-row :gutter="10" class="mb10">
          <el-col :sm="8" :xs="24">
            <el-card class="box-card" >
              <el-col>
                <el-col style="display: flex;justify-content: center">
                  <el-radio-group v-model="statusLabel" size="mini">
                    <el-radio-button label="状态显示"></el-radio-button>
                    <el-radio-button label="延迟测速"></el-radio-button>
                  </el-radio-group>
                </el-col>
                <el-col>
                  <div style="padding: 5px;">
                    <div class="monitor" style="padding-top: 0px;" v-if="statusLabel=='状态显示'">
                      <div class="monitor-content">
                        <el-row :gutter="10">
                          <el-col>
                            <Cell label="主IP" :value="info.mainIp" border/>
                            <Cell label="地区" :value="langShow(serverIdNodeNationFormat(serverLabel))" border/>
                            <Cell label="总(↑|↓)"
                                  :value="`${sizeFormat(info.netTraffic.recv)}/${sizeFormat(info.netTraffic.sent)}`"
                                  border/>
                            <Cell label="时(↑|↓)" :value="`${sizeFormat(info.netIO.up)}/${sizeFormat(info.netIO.down)}`"
                                  border/>
                            <Cell label="udp|tcp" :value="`${info.udpCount}|${info.tcpCount}`" border/>
                            <Cell label="内存" :value="`${sizeFormat(info.mem.current)}/${sizeFormat(info.mem.total)}`"
                                  border/>
                            <Cell label="硬盘"
                                  :value="`${sizeFormat(info.disk.current)}/${sizeFormat(info.disk.total)}`" border/>
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

                            <el-row :gutter="10" class="monitor-progress" v-if="nodeInfo.transitProtocol">
                              <el-col :sm="24" :md="6">中转诊断</el-col>
                              <el-col :sm="24" :md="16" v-if="!zduan">
                                <el-col v-for="v in ping">
                                  <el-row>服务器ID:{{ v.inServerId }} -> 服务器ID:{{ v.toServerId }}
                                    <el-tag  style="font-size: 10px;" size="mini" :type="(v.value >= 0 && v.value <1000)?'success':((v.value > 0 && v.value >=1000)?'warning':'danger')">
                                      {{ v.value > -1 ? (v.value + " ms") : "---- sm" }}
                                    </el-tag>
                                  </el-row>
                                </el-col>
                              </el-col>
                              <el-col :sm="24" :md="16" v-if="zduan == 1">
                                <i class="el-icon-loading"></i>
                              </el-col>
                              <el-col :sm="24" :md="2">
                                <el-button
                                  size="mini"
                                  type="primary" plain
                                  @click="pingIp()"
                                  style="padding: 6px 6px 6px 6px;margin-left: 20px;"
                                >刷新
                                </el-button>
                              </el-col>
                            </el-row>
                            <el-row :gutter="10" class="monitor-progress" v-if="nodeInfo.frpServerId > 0">
                              <el-col :sm="24" :md="6">
                                FRP诊断
                              </el-col>
                              <el-col :sm="24" :md="18" v-if="!zduan">
                            <span style="font-size: 12px;">客户端->服务端
                              <span style="color:royalblue;" v-if="toFrp>0">{{ toFrp }} sm</span><span
                                style="color:red;" v-if="toFrp==0">超时</span>   </span>
                                <el-button
                                  size="mini"
                                  type="primary" plain
                                  @click="pingIp()"
                                  style="padding: 6px 6px 6px 6px;margin-left: 20px;"
                                >刷新
                                </el-button>
                              </el-col>
                              <el-col :sm="24" :md="18" v-if="zduan == 1">
                                <i class="el-icon-loading"></i>
                              </el-col>
                            </el-row>
                          </el-col>
                        </el-row>
                      </div>
                    </div>
                    <div class="monitor" style="padding-top: 0px;" v-if="statusLabel === '延迟测速'">
                      <div class="monitor-content">
                        <el-table :data="[{}]" style="width: 100%" :border="false">
                          <el-table-column label="延迟" align="center">
                            <template slot-scope="scope">
                              <el-col style="height: 450px">
                                <el-row :gutter="24" v-for="(value, index) in vpnNodePingTests" :key="index">
                                  <el-col :span="10" style="text-align: right;padding:0px">{{ value.nationName }}:
                                  </el-col>
                                  <el-col :span="14">
                                    <el-tag @click="pingTest(value,nodeInfo.nodeId)" v-if="value.ping != -2" style="width: 85px;font-size: 10px;" size="mini" :type="(value.ping >= 0 && value.ping <1000)?'success':((value.ping > 0 && value.ping >=1000)?'warning':'danger')">
                                      {{ value.ping > -1 ? (value.ping + " ms") : "---- sm" }}
                                    </el-tag>
                                    <el-tag v-if="value.ping == -2" style="width: 55px;font-size: 10px;" size="mini"><i
                                      class="el-icon-loading"></i></el-tag>
                                  </el-col>
                                </el-row>
                              </el-col>
                            </template>
                          </el-table-column>

                          <el-table-column label="测速" align="center">
                            <template slot-scope="scope">
                              <el-col style="height: 450px">
                                <el-row :gutter="24" v-for="(value, index) in vpnNodeSpeedTests" :key="index">
                                  <el-col :span="10" style="text-align: right;padding:0px">{{ value.nationName }}:
                                  </el-col>
                                  <el-col :span="14">
                                    <el-tag @click="speedTest(value,nodeInfo.nodeId)" v-if="value.speedFlow >= 0"
                                            style="width: 85px;font-size: 10px;" size="mini"
                                            :type="(value.speedFlow > 1024*1024 )?'success':((value.speedFlow > 100*1024 && value.speedFlow <= 1024*1024)?'warning':'danger')">
                                      {{ value.speedFlow > 0 ? (value.speed) : "---- M/s" }}
                                    </el-tag>
                                    <el-tag v-if="value.speedFlow < 0" style="width: 55px;font-size: 10px;" size="mini">
                                      <i
                                        class="el-icon-loading"></i></el-tag>
                                  </el-col>
                                </el-row>
                              </el-col>
                            </template>
                          </el-table-column>
                        </el-table>
                      </div>
                    </div>
                  </div>
                </el-col>
              </el-col>
            </el-card>
          </el-col>
          <el-col :sm="16" :xs="24">
            <el-card class="box-card" style="">
              <el-col>
                <el-row>
                  <el-col :sm="18" :xs="24">
                    <el-radio-group v-model="serverLabel" size="mini" @input="getServerInfo()">

                      <el-radio-button v-if="nodeInfo.frpServerId" :label="nodeInfo.frpServerId">
                        {{ 'FRP服务器 ID:' + nodeInfo.frpServerId }}
                      </el-radio-button>

                      <el-radio-button :label="nodeInfo.serverId">{{
                          'VPN服务器 ID:' + nodeInfo.serverId
                        }}
                      </el-radio-button>
                      <template v-for="(value, key) in nodeInfo.transfers">
                        <el-radio-button :label="value.entranceServerId">
                          {{ '中转服务器ID:' + value.entranceServerId }}
                        </el-radio-button>
                        <el-radio-button :label="value.exitServerId" v-if="value.exitServerId != nodeInfo.serverId &&  (!nodeInfo.transfers[key+1] || nodeInfo.transfers[key+1].entranceServerId != value.exitServerId)">
                          {{ '中转服务器ID:' + value.exitServerId }}
                        </el-radio-button>
                      </template>




                    </el-radio-group>
                  </el-col>
                  <el-col :sm="6" :xs="24">
                    <el-row>
                      <el-button
                        size="mini"
                        type="primary" plain
                        @click="reStartServer()"
                        style="padding: 6px 6px 6px 6px"
                      >重启服务器
                      </el-button>
                      <el-button
                        size="mini"
                        type="success" plain
                        @click="reStartSingBox()"
                        style="padding: 6px 6px 6px 6px"
                      >重启VPN服务
                      </el-button>
                    </el-row>
                  </el-col>
                </el-row>
                <el-row style="margin-top: 10px">
                  <el-radio-group v-model="logLabel" size="mini" @input="getServerInfo()">
                    <el-radio-button label="ssh"></el-radio-button>
                    <el-radio-button label="agent"></el-radio-button>
                    <el-radio-button label="singBox"></el-radio-button>
                    <el-radio-button label="frp"></el-radio-button>
                    <el-radio-button label="access"></el-radio-button>
                  </el-radio-group>

                </el-row>
                <el-row>
                  <chatLog v-if="serverLabel" :logLabel="logLabel" :server-id="serverLabel"/>
                </el-row>
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

import {langShow, sizeFormat} from '@/utils'
import {info, listVpnServer, pingIp, reStartServer, reStartXray} from "@/api/vpn/vpnServer";
import {pingTest, speedTest} from "@/api/vpn/vpnNode";
import {listVpnNodePing} from "@/api/vpn/vpnNodePing";

export default {
  name: 'Monitor',
  components: {BasicLayout, Cell, chatLog},
  props: {
    nodeInfo: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      logLabel: "ssh",
      statusLabel: "状态显示",
      serverLabel: this.nodeInfo.serverId,
      serverIdNodeNationOptions: [],
      toChu: undefined,
      toVpn: undefined,
      toFrp: undefined,
      zduan: 0,
      ping: 0,
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
      vpnNodeSpeedTests: [],
      vpnNodePingTests: [],
      customColors: [
        {color: '#13ce66', percentage: 20},
        {color: '#1890ff', percentage: 40},
        {color: '#e6a23c', percentage: 60},
        {color: '#1989fa', percentage: 80},
        {color: '#F56C6C', percentage: 100}
      ]
    }
  },
  beforeDestroy() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  },
  mounted() {
    this.getServerInfo()
    this.pingIp()
    this.listVpnNodePing()
    this.getVpnServerNodeNationItems()

    this.timer = setInterval(() => {
      this.getServerInfo()
    }, 3000)
  },
  methods: {
    langShow,
    speedTest(pingInfo, nodeId) {
      pingInfo.speedFlow = -1
      speedTest(nodeId, pingInfo.pingId).then(response => {
        pingInfo.speed = sizeFormat(response.data * 1000) + "/s"
        pingInfo.speedFlow = response.data
      }).catch(e=>{
        pingInfo.speed = 0
        pingInfo.speedFlow = 0
      })
    },

    pingTest(pingInfo, nodeId) {
      pingInfo.ping = -2
      pingTest(nodeId, pingInfo.pingId).then(response => {
        pingInfo.ping = response.data
      })
    },
    getVpnServerNodeNationItems() {
      this.getItems(listVpnServer, {pageSize: 10000}).then(res => {
        this.serverIdNodeNationOptions = this.setItems(res, 'serverId', 'nationName')
      })
    },
    serverIdNodeNationFormat(serverId) {
      return this.selectItemsLabel(this.serverIdNodeNationOptions, serverId);
    },

    listVpnNodePing() {
      listVpnNodePing({pageNum: 1, pageSize: 100,}).then(response => {
        for (let i in response.data.list) {
          let pingInfo = response.data.list[i]
          this.vpnNodePingTests.push({
            nationName: pingInfo.nationName,
            ping: 0,
            pingId: pingInfo.pingId,
          })
          this.vpnNodeSpeedTests.push({
            nationName: pingInfo.nationName,
            speed: "-- M/s",
            speedFlow: 0,
            pingId: pingInfo.pingId,
          })
        }


      });
    },

    pingIp() {
      this.zduan = 1
      pingIp(this.nodeInfo.nodeId).then(ret => {
        this.ping = ret.data
        console.log(ret)
        console.log(this.ping)
        this.zduan = 0
      }).catch((e) => {
        this.zduan = 0
      })
    },

    getServerInfo() {
      info(this.serverLabel).then(ret => {
        this.info = ret.data
      })
    },

    sizeFormat(d) {
      return sizeFormat(d)
    },

    reStartServer() {
      const serverIds = this.serverLabel
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
      const serverIds = this.serverLabel
      this.$confirm('你确定要重启选中服务器的singBox?', "警告", {
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
