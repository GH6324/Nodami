<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="节点ID" prop="nodeId">
        <el-input
          v-model="queryParams.nodeId"
          placeholder="请输入节点ID"
          clearable
          size="mini"
          @keyup.enter.native="handleQuery"
          style="width: 140px"
        />
      </el-form-item>
      <el-form-item label="地区" prop="nationId">
        <el-select size="mini" v-model="queryParams.nationId" placeholder="机房位置" style="width: 120px" clearable>
          <el-option
            v-for="dict in nationIdOptions"
            :key="dict.key"
            :label="langShow(dict.value)"
            :value="dict.key"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="分组" prop="nodeGroupId">
        <el-select size="mini" v-model="queryParams.nodeGroupId" placeholder="分组" style="width: 120px" clearable>
          <el-option
            v-for="dict in nodeGroupOptions"
            :key="dict.key"
            :label="dict.value"
            :value="dict.key"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="服务器" prop="serverId">
        <paginationSelect v-model="queryParams.serverId"
                          size="mini"
                          placeholder="请选择服务器"
                          clearable
                          :queryParams="{pageSize: 10000,orderBy: 'vpn_server.server_group_id desc,vpn_server.server_group_id desc'}"
                          :labelKey='{"分组":"serverGroupName","ID":"serverId","名称":"serverName"}'
                          valueKey="serverId"
                          :listFunction="listVpnServer"
                          width="140px"
        ></paginationSelect>
      </el-form-item>
      <el-form-item label="协议" prop="protocol">
        <el-select v-model="queryParams.protocol" placeholder="请选择协议" clearable size="mini" style="width: 140px">
          <el-option
            v-for="dict in singBoxProtocolOptions"
            :key="dict.key"
            :label="dict.value"
            :value="dict.key"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          :disabled="!multiple"
          v-hasPermi="['vpn/vpnNode/add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['vpn/vpnNode/delete']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5" style="font-size: 12px;margin-left: 20px">
        排序:
        <el-select v-model="queryParams.orderBy" @change="handleQuery" size="mini" clearable placeholder="默认排序"
                   style="width: 100px">
          <el-option
            v-for="item in optionsOrderBy"
            :key="item.value"
            :label="item.key"
            :value="item.value">
          </el-option>
        </el-select>
      </el-col>
    </el-row>
    <el-table border v-loading="loading" :data="vpnNodeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" align="center"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" min-width="160">
        <template slot-scope="scope">
          <el-col>
            <el-row>
              <el-button
                size="mini"
                type="info" plain
                style="padding: 6px 6px 6px 6px"
                @click="openQrCode(scope.row)"
                v-hasPermi="['vpn/vpnServer/edit']"
              >二维码
              </el-button>
              <el-button
                size="mini"
                type="info" plain
                style="padding: 6px 6px 6px 6px"
                @click="monitorOprn(scope.row)"
                v-hasPermi="['vpn/vpnServer/edit']"
              >详情
              </el-button>
              <el-button
                size="mini"
                type="primary" plain
                style="padding: 6px 6px 6px 6px"
                @click="handleCopy(scope.row)"
                v-hasPermi="['vpn/vpnServer/edit']"
              >克隆
              </el-button>
            </el-row>
            <el-row style="margin-top: 10px">
              <el-button
                size="mini"
                type="warning" plain
                style="padding: 6px 6px 6px 6px"
                @click="handleUpdate(scope.row)"
                v-hasPermi="['vpn/vpnServer/edit']"
              >修改
              </el-button>
              <el-button
                size="mini"
                type="danger" plain
                style="padding: 6px 6px 6px 6px"
                @click="handleDelete(scope.row)"
                v-hasPermi="['vpn/vpnServer/delete']"
              >删除
              </el-button>
            </el-row>
          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="流量/延迟" align="center" prop="up" min-width="260">
        <template slot-scope="scope">
          <el-col style="font-size: 12px;">
            <!-- 优化流量显示 -->
            <el-row class="traffic-row">
              <div class="traffic-item">
                <span class="traffic-label">↑</span>
                <span class="traffic-value">{{ sizeFormat(scope.row.up) }}</span>
              </div>
              <div class="traffic-item">
                <span class="traffic-label">↓</span>
                <span class="traffic-value">{{ sizeFormat(scope.row.down) }}</span>
              </div>
            </el-row>

            <!-- 优化ping值显示 -->
            <el-row class="ping-container">
              <div
                v-for="(value, index) in scope.row.pings"
                :key="index"
                class="ping-item"
              >
                <span class="nation-name">{{ value.nationName }}:</span>
                <el-tag
                  @click="pingTest(scope.row.nodeId,value)"
                  class="ping-tag"
                  size="mini"
                  :type="value.ping ===0?'':(value.ping > 0 && value.ping <300)?'success':((value.ping >=300)?'warning':'danger')"
                >
                  <i v-if="value['pinging']" class="el-icon-loading"></i>
                  <i v-else>{{ value.ping > -1 ? (value.ping + " ms") : "----" }}</i>
                </el-tag>
              </div>
            </el-row>
          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="节点信息" align="center" prop="serverName" min-width="260">
        <template slot-scope="scope">
          <el-col style="font-size: 12px;">
            <el-row type="flex" align="middle">
              节点ID: {{ scope.row.nodeId }}
            </el-row>
            <el-row type="flex" align="middle">
              节点名称: {{ langShow(scope.row.nationName) + "#" + scope.row.nodeId }}
            </el-row>
            <el-row type="flex" align="middle">
              协议: {{ scope.row.protocol }}
            </el-row>
          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="节点服务器" align="center" prop="serverName" min-width="200">
        <template slot-scope="scope">
          <el-col style="font-size: 12px;">
            <el-row type="flex" align="middle">
              服务器ID: {{ scope.row.serverId }}
            </el-row>
            <el-row type="flex" align="middle"
                    style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;">
              服务器名称: {{ serverIdFormat(scope.row.serverId) }}
            </el-row>
            <el-row type="flex" align="middle">
              地区: {{ langShow(scope.row.nationName) }}
            </el-row>
          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="中转" align="center" prop="serverName" min-width="300">
        <template slot-scope="scope">
          <template>
            <template v-if="(transferList = sortedTransfers(scope.row)) && transferList.length >= 2">
              <el-col style="font-size: 12px;">
                <el-row type="flex" align="middle" style="display: flex;justify-content: center;">
                  <el-row :span="24" style="text-align: left;" v-if="scope.row.transitProtocol || scope.row.frpProtocol">
                    中转协议:
                    <el-tag size="mini" v-if="scope.row.transitProtocol ">{{ allTransitProtocolFormat(scope.row) }}</el-tag>
                    <el-tag size="mini" v-if="scope.row.frpProtocol">{{ frpProtocolOptionsFormat(scope.row) }}</el-tag>
                  </el-row>
                </el-row>

                <div class="latency-grid" style="display: flex;justify-content: center;">
                  <template v-for="(v, index) in transferList">
                    <div class="latency-connection">
                      <span class="node-id">服ID:{{ v.serverId }}</span>
                      <div class="arrow-section" v-if="(index+1) !== transferList.length">
                        <div class="arrow-head">▶</div>
                      </div>
                    </div>
                  </template>
                </div>
              </el-col>
            </template>
            <template v-else>
              <el-tag>直连</el-tag>
            </template>
          </template>
        </template>
      </el-table-column>


    </el-table>
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="title" v-if="open" :visible.sync="open" width="1100px" append-to-body
               :close-on-click-modal="false">
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-row :gutter="24">
          <el-col :span="7">
            <el-form-item label="新增方式" prop="addType" v-if="!form.nodeId">
              <el-select size="small" v-model="form.addType" placeholder="请选择" style="width: 150px">
                <el-option
                  v-for="dict in addTypeOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="服务器(单选)" prop="serverId" v-if="form.addType != 2">
              <paginationSelect v-model="form.serverId"
                                size="small"
                                placeholder="请选择服务器"
                                clearable
                                :queryParams="{status: 1,orderBy: 'vpn_server.server_group_id desc,status desc,nodes asc'}"
                                :labelKey='{"名称":"serverName","分组":"serverGroupName","ID":"serverId"}'
                                valueKey="serverId"
                                :pageSize="10000"
                                :listFunction="listVpnServer"
                                width="150px"
              ></paginationSelect>
            </el-form-item>
            <el-form-item label="服务器(多选)" prop="serverIds" v-if="form.addType == 2">
              <paginationSelect v-model="form.serverIds"
                                :multiple="true"
                                :collapseTags="true"
                                size="small"
                                placeholder="请选择服务器"
                                clearable
                                :pageSize="10000"
                                :queryParams="{status: 1,orderBy:'vpn_server.server_group_id desc,status desc,nodes asc'}"
                                :labelKey='{"名称":"serverName","分组":"serverGroupName","ID":"serverId"}'
                                valueKey="serverId"
                                :listFunction="listVpnServer"
                                width="150px"
              ></paginationSelect>
            </el-form-item>


            <el-form-item label="内网穿透" prop="frpProtocol">
              <el-select size="small" v-model="form.frpProtocol" placeholder="如果您不懂请留空" clearable
                         style="width:150px" @clear="()=>{
                         form.frpServerId = undefined
                         form.frpPort = undefined
                         }">
                <el-option
                  v-for="dict in frpProtocolOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="穿透服务器" prop="frpServerId" v-if="form.frpProtocol">
              <paginationSelect v-model="form.frpServerId"
                                size="small"
                                placeholder="请选择中转入口服务器"
                                clearable
                                :queryParams="{status: 1,orderBy:'vpn_server.server_group_id desc,status desc,nodes asc'}"
                                :labelKey='{"名称":"serverName","分组":"serverGroupName","ID":"serverId"}'
                                valueKey="serverId"
                                :pageSize="10000"
                                :listFunction="listVpnServer"
                                width="150px"
              ></paginationSelect>
            </el-form-item>
            <el-form-item label="穿透端口" prop="transitPort" v-if="!form.addType && form.frpProtocol">
              <el-input size="small" type="number" v-model="form.frpPort" placeholder="留空自动分配端口"
                        style="width:150px"/>
            </el-form-item>
            <el-form-item label="节点分组" prop="nodeGroupId">
              <el-select size="mini" v-model="form.nodeGroupId" placeholder="请选择节点分组" style="width: 150px"
                         clearable>
                <el-option
                  v-for="dict in nodeGroupOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="节点地区" prop="nationId">
              <el-select size="small" v-model="form.nationId" placeholder="地区" style="width: 150px">
                <el-option
                  v-for="dict in nationIdOptions"
                  :key="dict.key"
                  :label="langShow(dict.value)"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="7">
            <el-form-item label="出口类型" prop="otuType" v-if="!form.addType">
              <el-select size="small" v-model="form.otuType" placeholder="请选择自动出口" style="width: 150px">
                <el-option
                  v-for="dict in outputTypeOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="出口IP" prop="outIp" v-if="!form.addType && form.otuType == 2">
              <el-input size="small" v-model="form.outIp" placeholder="请输入出口IP" style="width: 150px"/>
            </el-form-item>
            <el-form-item label="出口节点" prop="outNodeId" v-if="!form.addType && form.otuType == 3">
              <paginationSelect v-model="form.outNodeId"
                                size="small"
                                placeholder="请选择节点"
                                clearable
                                :queryParams="{orderBy:'vpn_node_nation.nation_name desc,vpn_node.node_id desc'}"
                                :labelKey='{"ID":"nodeID","地区":"nation_name","注释":"other"}'
                                valueKey="node_id"
                                :pageSize="10000"
                                :listFunction="listVpnNode"
                                width="150px"
              ></paginationSelect>
            </el-form-item>
            <el-form-item label="协议" prop="protocol">
              <el-select size="small" v-model="form.protocol" placeholder="请选择协议" style="width: 150px" @clear="()=>{
                             if (form.protocol != 'vmess' && form.protocol != 'vless' && form.protocol != 'trojan') {
                                form.transportProtocol = undefined
                             }else if (!form.transportProtocol){
                               form.transportProtocol = 'grpc'
                             }

                             if (form.protocol != 'shadowsocks') {
                                form.method = undefined
                             }else if (!form.method){
                               form.method = 'chacha20-ietf-poly1305'
                             }


                         }"
                         @change="function(v){
                            if (form.protocol != 'vmess' && form.protocol != 'vless' && form.protocol != 'trojan') {
                                form.transportProtocol = undefined
                             }else if (!form.transportProtocol){
                               form.transportProtocol = 'grpc'
                             }

                             if (form.protocol != 'shadowsocks') {
                                form.method = undefined
                             }else if (!form.method){
                               form.method = 'chacha20-ietf-poly1305'
                             }

                         }">
                <el-option
                  v-for="dict in singBoxProtocolOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="加密方式" prop="method" v-if="form.protocol == 'shadowsocks'">
              <el-select size="small" style="width: 150px" v-model="form.method" placeholder="请选择加密方式">
                <el-option
                  v-for="dict in singBoxShadowsocksMethodOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="拥塞控制算法" prop="transportProtocol" v-if="form.protocol == 'tuic'">
              <el-select v-model="form.streamSettingsCongestionControl" placeholder="请选择拥塞控制算法" size="small"
                         style="width: 150px">
                <el-option
                  v-for="dict in congestionControlOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>

            <el-form-item label="伪装协议" prop="transportProtocol"
                          v-if="form.protocol == 'vmess' || form.protocol == 'vless' || form.protocol == 'trojan'">
              <el-select v-model="form.transportProtocol" placeholder="请选择伪装协议" size="small"
                         style="width: 150px">
                <el-option
                  v-for="dict in streamSettingsOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="host" prop="streamSettingsHost"
                          v-if="form.protocol == 'vmess' || form.protocol == 'vless' || form.protocol == 'trojan' || form.protocol == 'shadowtls' || form.protocol == 'tuic'">
              <el-input v-model="form.streamSettingsHost" placeholder="不能为空不然可能无法连接" size="small"
                        style="width: 150px"/>
            </el-form-item>
            <el-form-item label="path" prop="streamSettingsPath" v-if="form.transportProtocol == 'websocket'">
              <el-input v-model="form.streamSettingsPath" placeholder="如果您不清楚请保持默认" size="small"
                        style="width: 150px"/>
            </el-form-item>
            <el-form-item label="serviceName" prop="streamSettingsServiceName" v-if="form.transportProtocol == 'grpc'">
              <el-input v-model="form.streamSettingsServiceName" placeholder="如果您不清楚请保持默认" size="small"
                        style="width: 150px"/>
            </el-form-item>
            <el-form-item label="reality" prop="streamSettingsReality"
                          v-if="form.transportProtocol == 'grpc' && form.protocol != 'vmess'">
              <el-select v-model="form.streamSettingsReality" placeholder="不懂请默认" size="small"
                         style="width: 150px">
                <el-option
                  v-for='dict in [ {  key: "开启",  value: "1"  }, { key: "关闭",  value: "0" }]'
                  :key="dict.value"
                  :label="dict.key"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="服务端口" prop="vpnPort" v-if="!form.addType">
              <el-input type="number" v-model="form.vpnPort" placeholder="留空自动分配端口" size="small"
                        style="width: 150px"/>
            </el-form-item>
          </el-col>
          <el-col :span="10">
            <el-form-item label="中转协议" prop="transitProtocol">
              <el-select v-model="form.transitProtocol" placeholder="请选择中转服务协议" clearable size="small"
                         style="width: 150px"
                         @clear="()=>{
                         form.transfers = []
                         form.transitAddress = undefined
                         form.transitPort = undefined
                         }"
                         @change="function(v){}">
                <el-option
                  v-for="dict in allTransitProtocolOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="多层中转" prop="transfers" v-if="form.transitProtocol">
              <transfers
                width="350px"
                v-model="form.transfers"
                labelName=""
                :paginationFunction="listVpnServer"
              ></transfers>
            </el-form-item>
            <el-form-item label="中转端口" prop="transitPort" v-if="!form.addType && form.transitProtocol">
              <el-input type="number" v-model="form.transitPort" placeholder="留空自动分配端口" size="small"
                        style="width: 150px"/>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="诊断" v-if="open_monitor" :visible.sync="open_monitor" width="600px">
      <monitor v-if="open_monitor" :nodeInfo="form"/>
    </el-dialog>
    <!-- 你的父组件中 -->
    <qr-code-dialog :visible.sync="open_qrCode" :proxie="form.proxie" title="扫码导入节点"/>

  </div>
</template>

<style lang="scss" scoped>

.traffic-row {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-bottom: 12px;
}

.traffic-item {
  display: flex;
  align-items: center;

  .traffic-label {
    color: #909399;
    margin-right: 4px;
  }

  .traffic-value {
    color: #606266;
    font-family: 'JetBrains Mono', monospace;
  }
}

.ping-container {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  justify-content: center;
}

.ping-item {
  display: flex;
  align-items: center;
  gap: 4px;

  .nation-name {
    color: #909399;
    font-size: 11px;
  }
}

.ping-tag {
  cursor: pointer;
  transition: all 0.2s;
  font-size: 10px;

  &:hover {
    opacity: 0.8;
  }
}


/* 节点延迟面板 */
.latency-grid {
  display: flex;
  flex-wrap: wrap; // ✅ 允许换行显示
  align-items: center;
  gap: 12px;
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

.arrow-head {
  font-size: 12px;
}


</style>
<script>
import {addVpnNode, delVpnNode, getVpnNode, listVpnNode, pingTest, updateVpnNode,} from "@/api/vpn/vpnNode";
import {listVpnServer} from "@/api/vpn/vpnServer";
import {langShow, sizeFormat} from "@/utils";
import monitor from "@/views/vpn/vpnNode/monitor/index.vue";


import {parseTime} from "../../../../utils/ruoyi";
import InputList from "@/components/InputList/index.vue";
import transfers from "@/views/vpn/vpnNode/list/transfers.vue";
import {listVpnNodeNation} from "@/api/vpn/vpnNodeNation";
import {listVpnNodeGroup} from "@/api/vpn/vpnNodeGroup";
import qrCodeDialog from "@/views/vpn/vpnNode/list/qrCodeDialog.vue";
import {listVpnNodePing} from "@/api/vpn/vpnNodePing";

export default {
  components: {InputList, monitor, transfers, qrCodeDialog},
  name: "VpnNode",
  data() {
    return {
      fullScreenLoading: undefined,
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // Vpn节点配置表格数据
      vpnNodeList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      open_monitor: false,
      open_qrCode: false,
      // serverIdOptions关联表数据
      serverIdOptions: [],
      // outputTypeOptions
      outputTypeOptions: [
        {
          key: "1",
          value: "默认"
        },
        {
          key: "2",
          value: "指定IP"
        },
      ],

      addTypeOptions: [
        {
          key: undefined,
          value: "默认"
        },
        {
          key: "1",
          value: "多IP服务器 给每个IP创建一个节点"
        },
        {
          key: "2",
          value: "多个服务器 批量创建节点"
        },
      ],


      singBoxProtocolOptions: [
        {
          key: "shadowsocks",
          value: "shadowsocks"
        },
        {
          key: "shadowtls",
          value: "shadowtls"
        },
        {
          key: "vmess",
          value: "vmess"
        },
        {
          key: "vless",
          value: "vless"
        },
        {
          key: "trojan",
          value: "trojan"
        },
        {
          key: "hysteria2",
          value: "hysteria2"
        },
        {
          key: "tuic",
          value: "tuic"
        },
        {
          key: "socks",
          value: "socks"
        }
      ],

      allTransitProtocolOptions: [
        {
          key: "hysteria2",
          value: "hy2端口转发"
        },
        {
          key: "hysteria2-out",
          value: "hy2协议转发"
        },

      ],

      singBoxShadowsocksMethodOptions: [
        {
          key: "aes-128-gcm",
          value: "aes-128-gcm"
        },
        {
          key: "aes-256-gcm",
          value: "aes-256-gcm"
        },
        {
          key: "chacha20-ietf-poly1305",
          value: "chacha20-ietf-poly1305"
        },
        {
          key: "2022-blake3-aes-128-gcm",
          value: "2022-blake3-aes-128-gcm"
        },
        {
          key: "2022-blake3-aes-256-gcm",
          value: "2022-blake3-aes-256-gcm"
        },
      ],

      frpProtocolOptions: [],
      // nodeLineIdOptions关联表数据
      nodeLineIdOptions: [],

      // nationIdOptions关联表数据
      nationIdOptions: [],
      nodeGroupOptions: [],
      // isonoroffOptions
      isonoroffOptions: [],
      streamSettingsOptions: [
        {
          key: "grpc",
          value: "grpc"
        },
        {
          key: "websocket",
          value: "websocket"
        },
      ],

      congestionControlOptions: [
        {
          key: "cubic",
          value: "cubic"
        },
        {
          key: "new_reno",
          value: "new_reno"
        },
        {
          key: "bbr",
          value: "bbr"
        },
      ],
      // statusOptions字典数据
      statusOptions: [],
      optionsOrderBy: [
        {
          key: "节点",
          value: "vpn_node.node_id desc"
        },
        {
          key: "服务器",
          value: "vpn_server.server_id desc,vpn_node.node_id desc"
        },
        {
          key: "节点地区",
          value: "vpn_node.nation_id desc,vpn_node.node_id desc"
        },
      ],
      vpnNodePingOptions: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        nodeId: undefined,
        nodeType: undefined,
        serverId: undefined,
        outIp: undefined,
        protocol: undefined,
        transitProtocol: undefined,
        nodeLineId: undefined,
        nationId: undefined,
        pingtype: undefined,
        pingCnType: undefined,
        pingForeignType: undefined,
        ping: undefined,
        pingCn: undefined,
        pingForeign: undefined,
        frpProtocol: undefined,
        frpServerId: undefined,
        frpPort: undefined,
        orderBy: 'vpn_node.nation_id desc,vpn_node.node_id desc',
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        serverId: [
          {
            validator: (rule, value, callback) => {
              if ((!this.form.addType || this.form.addType == 1) && (value === '' || value == 0)) {
                callback(new Error('请选择节点服务器'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        serverIds: [
          {
            validator: (rule, value, callback) => {
              if (this.form.addType == 3 && (!value)) {
                callback(new Error('请选择节点服务器'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        protocol: [
          {required: true, message: "请选择节点协议", trigger: "blur"}
        ],
        outIp: [
          {
            validator: (rule, value, callback) => {
              if (this.form.otuType == 2 && (!value)) {
                callback(new Error('请配置指定出口IP'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        method: [
          {
            validator: (rule, value, callback) => {
              if (this.form.protocol == 'shadowsocks' && (!value)) {
                callback(new Error('请选择加密协议'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        frpProtocol: [
          {
            validator: (rule, value, callback) => {
              if (this.form.frpServerId && (!value)) {
                callback(new Error('请选择内网穿透协议'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        otuType: [
          {
            validator: (rule, value, callback) => {
              if (!this.form.addType && (!value || value == 0)) {
                callback(new Error('请选择节点出口类型'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        nationId: [
          {required: true, message: "请选择节点所属地区", trigger: "blur"},
        ],

      }
    };
  },
  created() {

    this.getDicts("isonoroff").then(response => {
      this.isonoroffOptions = response.data.values || [];
    });

    this.getDicts("method").then(response => {
      this.methodOptions = response.data.values || [];
    });
    this.getDicts("frpprotocol").then(response => {
      this.frpProtocolOptions = response.data.values || [];
    });

    this.getVpnServerItems()

    this.getDicts("vpn_status").then(response => {
      this.statusOptions = response.data.values || [];
    });
    this.listVpnNodePing()
    this.getVpnServerItems()
    this.getVpnNodeNationItems()
    this.getVpnNodeGroupItems()
    this.getList();
  },
  methods: {
    parseTime,
    langShow,
    listVpnNode,
    listVpnServer,
    sizeFormat,
    getPing(row) {
      let pingMap = {}
      for (let i in row.ping) {
        let v = row.ping[i]
        pingMap[v.pingId] = v
      }

      let list = []
      for (let i in this.vpnNodePingOptions) {
        let v = this.vpnNodePingOptions[i]
        let ping = pingMap[v.pingId];
        let m = {
          nationName:v.nationName,
          ping: -1,
          pingId: v.pingId,
          pinging: false,
        }
        if (ping) {
          m.ping = ping.ping
        }
        list.push(m)
      }
      return list
    },
    async listVpnNodePing() {
      await listVpnNodePing({pageNum: 1, pageSize: 100,}).then(response => {
        this.vpnNodePingOptions = response.data.list
        // for (let i in response.data.list) {
        //   let pingInfo = response.data.list[i]
        //   this.vpnNodePingOptions[pingInfo.pingId] = pingInfo
        // }
      });
    },
    showLoading() {
      this.fullScreenLoading = this.$loading({
        lock: true,
        text: 'Loading',
        spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.7)'
      });
    },

    stopLoading() {
      if (this.fullScreenLoading) {
        this.fullScreenLoading.close();
        this.fullScreenLoading = undefined;
      }
    },

    // 状态字典翻译
    statusFormat(row, column) {
      return this.selectDictLabel(this.statusOptions, row.status);
    },

    allTransitProtocolFormat(row, column) {
      return this.selectDictLabel(this.allTransitProtocolOptions, row.transitProtocol);
    },
    frpProtocolOptionsFormat(row, column) {
      return this.selectDictLabel(this.frpProtocolOptions, row.frpProtocol);
    },


    //关联vpn_node_nation表选项
    getVpnNodeNationItems() {
      this.getItems(listVpnNodeNation, {pageSize: 10000}).then(res => {
        this.nationIdOptions = this.setItems(res, 'nationId', 'nationName')
      })
    },
    getVpnNodeGroupItems() {
      this.getItems(listVpnNodeGroup, {pageSize: 10000}).then(res => {
        this.nodeGroupOptions = this.setItems(res, 'nodeGroupId', 'nodeGroupName')
      })
    },
    //关联vpn_server表选项
    getVpnServerItems() {
      this.getItems(listVpnServer, {pageSize: 10000}).then(res => {
        this.serverIdOptions = this.setItems(res, 'serverId', 'serverName')
      })
    },
    sortedTransfers(row) {
      const {serverId, frpServerId, transfers} = row;

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

      labelList.push({
        serverId: serverId,
        serverName: 'VPN服ID:' + serverId,
      });

      return labelList
    },
    /** 查询Vpn节点配置列表 */
    getList() {
      this.loading = true;
      listVpnNode(this.queryParams).then(response => {

        for (let i in response.data.list) {
          response.data.list[i].ping = JSON.parse(response.data.list[i].ping)
          response.data.list[i].pings = this.getPing(response.data.list[i])
        }

        this.vpnNodeList = response.data.list;


        this.total = response.data.total;
        this.loading = false;
      });
    },
    pingTest(nodeId, pingInfo) {
      pingInfo.ping = 0
      pingInfo["pinging"] = true
      pingTest(nodeId, pingInfo.pingId).then(response => {
        pingInfo.ping = response.data
        pingInfo["pinging"] = false
      }).catch((e) => {
        pingInfo.ping = -1
      })
    },


    serverIdFormat(serverId) {
      return this.selectItemsLabel(this.serverIdOptions, serverId);
    },

    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        addType: undefined,
        nodeId: undefined,
        serverId: undefined,
        serverIds: undefined,
        protocol: undefined,
        transitPort: undefined,
        transitProtocol: undefined,
        otuType: "1",
        outIp: undefined,
        outNodeId: undefined,
        vpnPort: undefined,
        nodeLineIds: undefined,
        transportProtocol: undefined,
        streamSettingsServiceName: "index",
        streamSettingsReality: "0",
        streamSettingsPath: "/index",
        streamSettingsHost: "www.cloudflare.com",
        magnification: 1,
        domainId: undefined,
        method: undefined,
        frpServerId: undefined,
        frpProtocol: undefined,
        frpPort: undefined,
        clashTransitNodeIds: undefined,
        other: undefined,
        transfers: undefined,
        streamSettingsCongestionControl: "cubic",
        proxie: undefined,
      };
      this.resetForm("form");
    },

    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.nodeId)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },

    /** 新增按钮操作 */
    handleAdd() {
      this.getVpnServerItems()
      this.getVpnNodeNationItems()
      this.reset();
      this.open = true;
      this.title = "新增节点";
    },


    handleCopy(row) {
      this.handleUpdate(row, true)
    },

    /** 修改按钮操作 */
    handleUpdate(row, copy = false) {
      this.showLoading();
      this.getVpnServerItems()
      this.getVpnNodeNationItems()
      this.reset();
      const nodeId = row.nodeId || this.ids
      getVpnNode(nodeId).then(response => {
        let data = response.data;
        data.frpServerId = (data.frpServerId || undefined)

        data.nationId = '' + (data.nationId || "")
        data.otuType = '' + data.otuType
        data.protocol = '' + data.protocol
        data.transitProtocol = '' + (data.transitProtocol || '')
        data.frpProtocol = '' + (data.frpProtocol || "")
        data.outNodeId = '' + (data.outNodeId || "")
        data.nodeGroupId = '' + (data.nodeGroupId || "")
        data.streamSettingsReality = '' + data.streamSettingsReality
        if (copy) {
          data.nodeId = undefined
          data.outIp = ""
          data.transitPort = undefined
          data.vpnPort = undefined
          data.other = undefined
          data.frpPort = undefined
        }


        this.form = data;
        this.open = true;

        this.title = copy ? "复制节点配置" : "编辑节点配置";
      }).finally(_ => {
        this.stopLoading();
      });
    },


    submitForm: function () {
      if (!this.form.transitProtocol) {
        this.form.transfers = []
      }
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.showLoading();
          if (this.form.nodeId !== undefined) {
            updateVpnNode(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            }).finally(_ => {
              this.stopLoading();
            });
          } else {
            addVpnNode(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess(response.data);
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            }).finally(_ => {
              this.stopLoading();
            });
          }
        }
      });
    },

    /** 删除按钮操作 */
    handleDelete(row) {
      const nodeIds = row.nodeId || this.ids;
      this.$confirm('确认删除Vpn节点 ID:"' + nodeIds + '"的数据?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.showLoading();
        return delVpnNode(nodeIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      }).finally(_ => {
        this.stopLoading();
      });
    },
    openQrCode(row) {
      this.reset();
      const nodeId = row.nodeId
      getVpnNode(nodeId).then(response => {
        let data = response.data;
        this.form = data;
        this.open_qrCode = true;
        console.log(this.form)
      });
    },
    monitorOprn(row) {
      this.reset();
      const nodeId = row.nodeId
      getVpnNode(nodeId).then(response => {
        let data = response.data;
        data.serverId = data.serverId
        this.form = data;
        this.open_monitor = true;
        this.title = "详情";
      });
    },
  },

};
</script>
