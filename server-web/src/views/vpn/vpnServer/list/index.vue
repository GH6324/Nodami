<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="ID" prop="serverId">
        <el-input
          v-model="queryParams.serverId"
          placeholder="请输入id"
          clearable
          size="mini"
          @keyup.enter.native="handleQuery"
          style="width: 120px"
        />
      </el-form-item>
      <el-form-item label="名称" prop="serverName">
        <el-input
          v-model="queryParams.serverName"
          placeholder="请输入服务器名称"
          clearable
          size="mini"
          @keyup.enter.native="handleQuery"
          style="width: 120px"
        />
      </el-form-item>
      <el-form-item label="IP" prop="serverIp">
        <el-input
          v-model="queryParams.serverIp"
          placeholder="请输入服务器IP"
          clearable
          size="mini"
          @keyup.enter.native="handleQuery"
          style="width: 120px"
        />
      </el-form-item>
      <el-form-item label="分组" prop="serverGroupId">
        <el-select size="mini" v-model="queryParams.serverGroupId" placeholder="分组" clearable style="width: 120px">
          <el-option
            v-for="dict in serverGroupOptions"
            :key="dict.key"
            :label="dict.value"
            :value="dict.key"
            style="width: 120px"
          ></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="状态" prop="status">
        <el-select size="mini" v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 120px">
          <el-option
            v-for="dict in statusOptions"
            :key="dict.key"
            :label="dict.value"
            :value="dict.key"
          />
        </el-select>
      </el-form-item>

      <el-form-item label="异常负载" prop="abnormalLoad">
        <el-select size="mini" v-model="queryParams.abnormalLoad" clearable placeholder="请选择" style="width: 120px">
          <el-option
            v-for="item in [{value:true,label:'异常'}]"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
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
          v-hasPermi="['vpn/vpnServer/add']"
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
          v-hasPermi="['vpn/vpnServer/delete']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info" plain
          size="mini"
          :disabled="multiple"
          @click="reStartServer"
          v-hasPermi="['vpn/vpnServer/delete']"
        >重启服务器
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning" plain
          size="mini"
          :disabled="multiple"
          @click="reStartXray"
          v-hasPermi="['vpn/vpnServer/delete']"
        >重启VPN服务
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
    <el-table :row-key='getrowkey' border ref="multipleTable" v-loading="loading" :data="vpnServerList"
              @selection-change="handleSelectionChange" @cell-mouse-enter="cellMouseEnter">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="160">
        <template slot-scope="scope">
          <div style="display: flex; flex-wrap: wrap;">
            <el-button
              size="mini"
              plain
              style="padding: 6px 6px 6px 6px;margin: 5px 5px 5px 5px;"
              @click="monitorOprn(scope.row)"
              v-hasPermi="['vpn/vpnServer/edit']"
            >详情
            </el-button>
            <el-button
              size="mini"
              type="success"
              plain
              style="padding: 6px 6px 6px 6px;margin: 5px 5px 5px 5px;"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['vpn/vpnServer/edit']"
            >修改
            </el-button>
            <el-button
              size="mini"
              type="danger" plain
              style="padding: 6px 6px 6px 6px;margin: 5px 5px 5px 5px;"
              @click="handleDelete(scope.row)"
              v-hasPermi="['vpn/vpnServer/delete']"
            >删除
            </el-button>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="服务器" align="center" prop="serverName" width="215" show-overflow-tooltip>
        <template slot-scope="scope">
          <el-col style="font-size: 12px;">
            <el-row type="flex" align="middle">
              服务器ID: {{ scope.row.serverId }}
            </el-row>
            <el-row type="flex" align="middle"
                    style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;">
              服务器名称: {{ scope.row.serverName }}
            </el-row>
            <el-row type="flex" align="middle">
              注释:{{ scope.row.other }}
            </el-row>
          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="监控" width="315">
        <template slot-scope="scope">

          <el-col style="font-size: 12px;">
            <el-row type="flex" justify="center" align="middle">
              <el-col :span="6">cpu:</el-col>
              <el-col :span="19">
                <el-progress :percentage="scope.row.realCpu"
                             :status="scope.row.realCpu>90?'exception':(scope.row.realCpu>60?'warning':'success')"></el-progress>
              </el-col>
            </el-row>
            <el-row type="flex" justify="center" align="middle">
              <el-col :span="6">内存:</el-col>
              <el-col :span="19">
                <el-progress :percentage="scope.row.realMem"
                             :status="scope.row.realMem>90?'exception':(scope.row.realMem>60?'warning':'success')"></el-progress>
              </el-col>
            </el-row>
            <el-row type="flex" justify="center" align="middle">
              <el-col :span="6">硬盘:</el-col>
              <el-col :span="19">
                <el-progress :percentage="scope.row.realDisk"
                             :status="scope.row.realDisk>90?'exception':(scope.row.realDisk>60?'warning':'success')"></el-progress>
              </el-col>
            </el-row>
            <el-row type="flex" justify="center" align="middle">
              <el-col :span="6">实时:</el-col>
              <el-col :span="19">
                <el-tag size="small" type="success">
                  {{ `${sizeFormat(scope.row.realUp)}/${sizeFormat(scope.row.realDown)}` }}
                </el-tag>
              </el-col>
            </el-row>
          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" width="330">
        <template slot-scope="scope">
          <el-col>
            <el-tag :type="scope.row.status == 1?'success':'danger'">
              <el-row :gutter="24" style="width: 215px">
                <el-col :span="6" style="padding-left: 0;padding-right: 5px;text-align: right;">状态:</el-col>
                <el-col :span="6" style="padding-left: 0;text-align: left;">
                  {{ statusFormat(scope.row) }}
                </el-col>
              </el-row>
            </el-tag>


            <el-tag>
              <el-row :gutter="24" style="width: 215px">
                <el-col :span="6" style="padding-left: 0;padding-right: 5px;text-align: right;">流量:</el-col>
                <el-col :span="6" style="padding-left: 0;text-align: left;">
                  {{ `↑${sizeFormat(scope.row.up)} ↓${sizeFormat(scope.row.down)}` }}
                </el-col>
              </el-row>
            </el-tag>


          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="其他信息" align="center" prop="serverName" width="230">
        <template slot-scope="scope">
          <el-col style="font-size: 12px;">

            <el-row :gutter="24" style="width: 240px;">
              <el-col :span="5" style="padding-left: 10px;padding-right: 0;text-align: left;">IP:</el-col>
              <el-col :span="18" style="padding-left: 0;text-align: left;">
                {{ scope.row.serverIp }}
              </el-col>
            </el-row>

            <el-row :gutter="24" style="width: 240px">
              <el-col :span="5" style="padding-left: 10px;padding-right: 0;text-align: left;">分组:</el-col>
              <el-col :span="18" style="padding-left: 0;text-align: left;">
                {{ serverGroupIdFormat(scope.row) }}
              </el-col>
            </el-row>


            <el-row :gutter="24" style="width: 240px">
              <el-col :span="5" style="padding-left: 10px;padding-right: 0;text-align: left;">ADSL:</el-col>
              <el-col :span="6" style="padding-left: 0;text-align: left;">
                {{ scope.row.isPppoe == -1 ? "不是" : "是" }}
              </el-col>
              <el-col :span="5" style="padding-left: 0px;padding-right: 0;text-align: left;">节点数:</el-col>
              <el-col :span="6" style="padding-left: 0;text-align: left;">
                {{ scope.row.nodes }}
              </el-col>
            </el-row>

          </el-col>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createdAt">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{m}-{d}') }}</span>
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
    <!-- 添加或修改Vpn服务器对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="1050px" append-to-body :close-on-click-modal="false">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="24">
          <el-col :span="8">
            <el-form-item label="IP" prop="serverIp">
              <el-input v-model="form.serverIp" placeholder="请输入服务器IP" style="width: 95%"/>
            </el-form-item>
            <el-form-item label="SSH端口" prop="serverSshProt">
              <el-input-number v-model="form.serverSshProt" :min="22" :max="65500" style="width: 150px"/>
            </el-form-item>
            <el-form-item label="SSH用户名" prop="serverSshUser">
              <el-input v-model="form.serverSshUser" placeholder="请输入SSH用户名" style="width: 150px"/>
            </el-form-item>
            <el-form-item label="SSH验证" prop="serverSshLoginType">
              <el-select v-model="form.serverSshLoginType" placeholder="请选择SSH验证方式" style="width: 150px">
                <el-option
                  v-for="dict in serverSshLoginTypeOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="SSH密码" prop="serverSshPasswrod" v-if="form.serverSshLoginType == 'password'">
              <el-input v-model="form.serverSshPasswrod" placeholder="请输入服务器ssh密码" style="width: 200px"/>
            </el-form-item>
            <el-form-item label="SSH秘钥" prop="serverSshPublicKey" v-if="form.serverSshLoginType == 'public_key'">
              <el-input type="textarea" v-model="form.serverSshPublicKey" placeholder="请输入服务器ssh秘钥"
                        style="width: 200px"/>
            </el-form-item>
            <el-form-item label="SSH代理" prop="proxyAddr">
              <el-input v-model="form.proxyAddr" placeholder="socks5://u:p@ip:port"
                        style="width: 95%"/>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="名称" prop="serverName">
              <el-input v-model="form.serverName" placeholder="请输入服务器名称" style="width: 95%"/>
            </el-form-item>
            <el-form-item label="分组" prop="serverGroupId">
              <el-select v-model="form.serverGroupId" placeholder="分组" clearable style="width: 150px">
                <el-option
                  v-for="dict in serverGroupOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="注释" prop="other">
              <el-input v-model="form.other" type="textarea" placeholder="请输入注释" style="width: 95%"/>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="拨号服务器" prop="isPppoe">
              <el-select v-model="form.isPppoe" placeholder="请选择是否是拨号服务器" style="width: 150px">
                <el-option
                  v-for="dict in isokronoOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="定时重拨" prop="pppoeRestart" v-if="form.isPppoe == 1">
              <el-select v-model="form.pppoeRestart" placeholder="请选择是否定时重拨" style="width: 150px">
                <el-option
                  v-for="dict in isokronoOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="重拨时间(时)" prop="pppoeHour" v-if="form.isPppoe == 1 && form.pppoeRestart == 1">
              <el-input-number v-model="form.pppoeHour" :min="0" :max="23" style="width: 150px"/>
            </el-form-item>
            <el-form-item label="重拨周期(天)" prop="pppoeCycle" v-if="form.isPppoe == 1 && form.pppoeRestart == 1">
              <el-input-number v-model="form.pppoeCycle" :min="1" :max="30" style="width: 150px"/>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm('form')">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>


    <el-dialog title="诊断" :visible.sync="open_monitor" width="90%">
      <monitor v-if="open_monitor" :serverInfo="form"/>
    </el-dialog>
  </div>
</template>
<script>
import {
  addVpnServer,
  delVpnServer,
  getVpnServer,
  listVpnNodeNation,
  listVpnServer,
  pppoeReStart,
  reStartServer,
  reStartXray,
  updateVpnServer,
  updateVpnServers,
} from "@/api/vpn/vpnServer";
import {langShow, sizeFormat} from "@/utils";
import CustomizeTag from "@/components/CustomizeTag/index.vue";
import cityCascader from "@/components/cityCascader/index.vue";
import monitor from "@/views/vpn/vpnServer/monitor/index.vue";
import encodingJapanese from "encoding-japanese";
import {listVpnServerGroup} from "@/api/vpn/vpnServerGroup";


export default {
  components: {monitor, CustomizeTag, cityCascader},
  name: "VpnServer",
  data() {
    return {
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
      // Vpn服务器表格数据
      vpnServerList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      open_monitor: false,
      serverSshLoginTypeOptions: [],

      serverGroupOptions: [],

      isokronoOptions: [],
      zhichiOptions: [],
      // statusOptions字典数据
      statusOptions: [],
      optionsOrderBy: [
        {
          key: "ID",
          value: "vpn_server.server_id desc"
        },
        {
          key: "日期",
          value: "DATE_FORMAT(vpn_server.created_at, '%m-%d') desc,vpn_server.server_id desc"
        },
      ],
      timer: null,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        serverId: undefined,
        serverName: undefined,
        serverIp: undefined,
        serverSshProt: undefined,
        serverSshUser: undefined,
        serverSshPasswrod: undefined,
        serverSshPublicKey: undefined,
        serverSshLoginType: undefined,
        status: undefined,
        bandwidth: undefined,
        other: undefined,
        abnormalLoad: undefined,
        serverGroupId: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        serverName: [
          {required: true, message: "服务器名称不能为空", trigger: "blur"}
        ],
        serverIp: [
          {required: true, message: "服务器IP不能为空", trigger: "blur"}
        ],
        serverSshProt: [
          {required: true, message: "服务器ssh端口不能为空", trigger: "blur"}
        ],

        isPppoe: [
          {required: true, message: "请选择是否拨号服务器", trigger: "blur"}
        ],
        serverSshUser: [
          {required: true, message: "用户名不能为空", trigger: "blur"}
        ],
        serverSshPasswrod: [
          {
            validator: (rule, value, callback) => {
              if (!this.form.serverSshPublicKey && (value === '' || value == 0)) {
                callback(new Error('SHH验证密码不能是空的'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        serverSshPublicKey: [
          {
            validator: (rule, value, callback) => {
              if (!this.form.serverSshPasswrod && (value === '' || value == 0)) {
                callback(new Error('SHH验证秘钥不能是空的'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        serverSshLoginType: [
          {required: true, message: "登录方式不能为空", trigger: "blur"}
        ],
        serverGroupId: [
          {required: true, message: "是否可中转不能为空", trigger: "blur"}
        ],
      },

    };
  },
  created() {
    this.getDicts("sshLoginType").then(response => {
      this.serverSshLoginTypeOptions = response.data.values || [];
    });
    this.getVpnServerGroupItems()

    this.getDicts("shifouzhici").then(response => {
      this.zhichiOptions = response.data.values || [];
    });
    this.getDicts("isokrono").then(response => {
      this.isokronoOptions = response.data.values || [];
    });


    this.getDicts("vpn_status").then(response => {
      this.statusOptions = response.data.values || [];
    });
    this.getList();
  },
  methods: {
    langShow,
    listVpnNodeNation,
    sizeFormat,

    getVpnServerGroupItems() {
      this.getItems(listVpnServerGroup, {pageSize: 10000}).then(res => {
        this.serverGroupOptions = this.setItems(res, 'serverGroupId', 'serverGroupName')
      })
    },

    getList() {
      this.loading = true;
      listVpnServer(this.queryParams).then(response => {
        this.vpnServerList = response.data.list;
        this.total = response.data.total;
        this.loading = false;
      });
    },

    serverSshLoginTypeFormat(row, column) {
      return this.selectDictLabel(this.serverSshLoginTypeOptions, row.serverSshLoginType);
    },

    serverGroupIdFormat(row, column) {
      return this.selectItemsLabel(this.serverGroupOptions, row.serverGroupId)
    },

    statusFormat(row, column) {
      return this.selectDictLabel(this.statusOptions, row.status);
    },

    cancel() {
      this.open = false;
      this.reset();
    }
    ,
    // 表单重置
    reset() {
      this.form = {
        serverAdds: undefined,
        serverIds: undefined,
        serverId: undefined,
        serverName: undefined,
        serverIp: undefined,
        serverSshProt: undefined,
        serverSshUser: undefined,
        serverSshPasswrod: undefined,
        serverSshPublicKey: undefined,
        serverSshLoginType: undefined,
        up: undefined,
        down: undefined,
        other: undefined,
        createdAt: undefined,
        updatedAt: undefined,
        isPppoe: "-1",
        pppoeRestart: "-1",
        pppoeHour: undefined,
        pppoeCycle: undefined,
        proxyAddr: undefined,
      };
      this.resetForm("form");
    }
    ,
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    }
    ,
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    }
    ,
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.serverId)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },

    cellMouseEnter(row, column, cell, event) {
      console.log("cellMouseEnter")
    },

    getrowkey(row) {
      return row.id
    },

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.form.serverId = undefined
      this.open = true;
      this.title = "添加服务器";
    },

    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const serverId = row.serverId || this.ids
      getVpnServer(serverId).then(response => {
        let data = response.data;
        data.serverSshLoginType = '' + data.serverSshLoginType
        data.nationId = '' + data.nationId
        data.isPppoe = '' + (data.isPppoe || -1)
        data.pppoeRestart = '' + data.pppoeRestart
        data.serverGroupId = '' + data.serverGroupId
        data.status = '' + data.status
        this.form = data;
        this.open = true;
        this.title = "修改服务器";
      });
    },

    /** 修改按钮操作 */
    handleUpdates() {
      this.reset();
      const serverId = this.ids
      if (serverId) {
        this.title = "批量修改服务器";
      }

    },
    /** 提交按钮 */
    submitForm: function (ref) {
      if (this.form.serverIp) {
        this.form.serverIp = this.form.serverIp.replace(/\s+/g, '');
      }
      this.$refs[ref].validate(valid => {
        if (valid) {
          if (this.form.serverId != undefined) {
            updateVpnServer(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
                this.form['servertxCSVOption'] = undefined
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addVpnServer(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess(response.data);
                this.open = false;
                this.getList();
                this.form['servertxCSVOption'] = undefined
              } else {
                this.msgError(response.msg);
              }
            });
          }
        }
      });
    },

    /** 删除按钮操作 */
    handleDelete(row) {
      const serverIds = row.serverId || this.ids;
      this.$confirm('是否确认删除Vpn服务器编号为"' + serverIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return delVpnServer(serverIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      }).catch(function () {
      });
    },
    monitorOprn(row) {
      this.reset();
      const serverId = row.serverId || this.ids
      getVpnServer(serverId).then(response => {
        let data = response.data;
        data.serverSshLoginType = '' + data.serverSshLoginType
        data.serverGroupId = '' + data.serverGroupId
        data.status = '' + data.status
        this.form = data;
        console.log(this.form)
        this.open_monitor = true;
        this.title = "详情";
      });
    },
    reStartServer(row) {
      const serverIds = row.serverId || this.ids;
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
    reStartXray(row) {
      const serverIds = row.serverId || this.ids;
      this.$confirm('你确定要重启选中服务器的xray?', "警告", {
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
    pppoeReStart(row) {
      const serverIds = row.serverId || this.ids;
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
    },
  }
}
;
</script>
