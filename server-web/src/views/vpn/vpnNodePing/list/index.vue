<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="服务器" prop="serverId">
        <paginationSelect v-model="queryParams.serverId"
                          size="mini"
                          placeholder="请选择服务器"
                          clearable
                          :queryParams="{pageSize: 10000,orderBy: 'vpn_server.server_group_id desc,vpn_server.server_id desc'}"
                          :labelKey='{"分组":"serverGroupName","ID":"serverId","名称":"serverName"}'
                          valueKey="serverId"
                          :listFunction="listVpnServer"
                          width="140px"
        ></paginationSelect>
      </el-form-item>
      <el-form-item label="名称" prop="nationName">
        <el-input
            v-model="queryParams.nationName"
            placeholder="名称"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['vpn/vpnNodePing/add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['vpn/vpnNodePing/delete']"
        >删除</el-button>
      </el-col>
    </el-row>
    <el-table v-loading="loading" :data="vpnNodePingList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="pingId" />
      <el-table-column label="服务器ID" align="center" prop="serverId" :formatter="serverIdFormat" width="100">
        <template slot-scope="scope">
          {{ serverIdFormat(scope.row) }}
        </template>
      </el-table-column>
      <el-table-column label="名称" align="center" prop="nationName" />
      <el-table-column label="延迟测试URL" align="center" prop="pingUrl" show-overflow-tooltip/>
      <el-table-column label="测速URL" align="center" prop="speedUrl" show-overflow-tooltip/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['vpn/vpnNodePing/edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['vpn/vpnNodePing/delete']"
          >删除</el-button>
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
    <!-- 添加或修改测速配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="400px" append-to-body :close-on-click-modal="false">
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="服务器" prop="serverId">
          <paginationSelect v-model="form.serverId"
                            size="mini"
                            placeholder="请选择服务器"
                            clearable
                            :queryParams="{pageSize: 10000, orderBy: 'vpn_server.server_group_id desc,vpn_server.server_id desc'}"
                            :labelKey='{"分组":"serverGroupName","ID":"serverId","名称":"serverName"}'
                            valueKey="serverId"
                            :listFunction="listVpnServer"
                            width="140px"
          ></paginationSelect>
        </el-form-item>
      <el-form-item label="名称" prop="nationName">
           <el-input v-model="form.nationName" placeholder="请输入名称" style="width: 200px"/>
      </el-form-item>
      <el-form-item label="延迟测试URL" prop="pingUrl">
           <el-input v-model="form.pingUrl" placeholder="请输入延迟测试URL" style="width: 200px"/>
      </el-form-item>
      <el-form-item label="测速URL" prop="speedUrl">
           <el-input v-model="form.speedUrl" placeholder="请输入测速URL" style="width: 200px"/>
      </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import {
    listVpnNodePing,
    getVpnNodePing,
    delVpnNodePing,
    addVpnNodePing,
    updateVpnNodePing,
} from "@/api/vpn/vpnNodePing";
import {listVpnServer} from "@/api/vpn/vpnServer";
export default {
  components:{},
  name: "VpnNodePing",
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
      // 测速配置表格数据
      vpnNodePingList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // serverIdOptions关联表数据
      serverIdOptions: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        serverId: undefined,
        nationName: undefined,
        pingUrl: undefined,
        speedUrl: undefined,
        grpcPort: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        serverId : [
          { required: true, message: "服务器ID不能为空", trigger: "blur" }
        ],
        nationName : [
          { required: true, message: "名称不能为空", trigger: "blur" }
        ],
        pingUrl : [
          { required: true, message: "延迟测试URL不能为空", trigger: "blur" }
        ],
        speedUrl : [
          { required: true, message: "测速URL不能为空", trigger: "blur" }
        ],
        grpcPort : [
          { required: true, message: "GrpcPort不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getVpnServerItems()
    this.getList();
  },
  methods: {
    listVpnServer,
    //关联vpn_server表选项
    getVpnServerItems() {
      this.getItems(listVpnServer, {pageSize:10000}).then(res => {
        this.serverIdOptions = this.setItems(res, 'serverId', 'serverId')
      })
    },
    /** 查询测速配置列表 */
    getList() {
      this.loading = true;
      listVpnNodePing(this.queryParams).then(response => {
        this.vpnNodePingList = response.data.list;
        this.total = response.data.total;
        this.loading = false;
      });
    },
    // 服务器ID关联表翻译
    serverIdFormat(row, column) {
      return this.selectItemsLabel(this.serverIdOptions, row.serverId);
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        pingId: undefined,
        serverId: undefined,
        nationName: undefined,
        pingUrl: "http://localhost:2061/generate_204",
        speedUrl: "http://localhost:2061/speed_test?byte=5024000",
        grpcPort: undefined,
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
      this.ids = selection.map(item => item.pingId)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加测速配置";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const pingId = row.pingId || this.ids
      getVpnNodePing(pingId).then(response => {
        let data = response.data;
        data.serverId = data.serverId
        this.form = data;
        this.open = true;
        this.title = "修改测速配置";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.pingId != undefined) {
            updateVpnNodePing(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addVpnNodePing(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("新增成功");
                this.open = false;
                this.getList();
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
      const pingIds = row.pingId || this.ids;
      this.$confirm('是否确认删除测速配置编号为"' + pingIds + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delVpnNodePing(pingIds);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    }
  }
};
</script>
