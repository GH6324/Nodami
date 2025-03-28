<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="订阅ID" prop="subscriptionId">
        <el-input
          v-model="queryParams.subscriptionId"
          placeholder="请输入订阅ID"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="订阅名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入订阅名称"
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
          v-hasPermi="['vpn/vpnSubscription/add']"
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
          v-hasPermi="['vpn/vpnSubscription/delete']"
        >删除
        </el-button>
      </el-col>
    </el-row>
    <el-table v-loading="loading" :data="vpnSubscriptionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="订阅名称" align="center" prop="name" width="200"/>
      <el-table-column label="订阅地址" align="center" prop="name" >
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-copy-document"
            @click="copyToClipboard('subscription'+scope.row.subscriptionId)"
          >
          </el-button>
          <input
            type="text"
            :value="baseUrl + '/client/subscription/' + scope.row.subscriptionId"
            :id="'subscription' + scope.row.subscriptionId"
            readonly
            style="
    border: none;
    outline: none;
    background: transparent;
    cursor: text;
    min-width: 300px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  "
          >


        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="200">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['vpn/vpnSubscription/edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['vpn/vpnSubscription/delete']"
          >删除
          </el-button>
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
    <!-- 添加或修改订阅对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body :close-on-click-modal="false">
      <el-form ref="form" :model="form" :rules="rules" label-width="150px">
        <el-form-item label="订阅名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入订阅名称" style="width:200px"/>
        </el-form-item>
        <el-form-item label="绑定节点组(多选)" prop="nodeGroupIds">
          <paginationSelect v-model="form.nodeGroupIds"
                            :multiple="true"
                            :collapseTags="true"
                            size="small"
                            placeholder="请选择绑定节点组"
                            clearable
                            :pageSize="10000"
                            :labelKey='{"":"nodeGroupName"}'
                            valueKey="nodeGroupId"
                            :listFunction="listVpnNodeGroup"
                            width="200px"
          ></paginationSelect>
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
  addVpnSubscription,
  delVpnSubscription,
  getVpnSubscription,
  listVpnSubscription,
  updateVpnSubscription,
} from "@/api/vpn/vpnSubscription";
import {listVpnNodeGroup} from "@/api/vpn/vpnNodeGroup";
import {getCurrentOrigin} from "@/utils";

export default {
  components: {},
  name: "VpnSubscription",
  data() {

    return {
      baseUrl: "",
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
      // 订阅表格数据
      vpnSubscriptionList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        subscriptionId: undefined,
        name: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        name: [
          {required: true, message: "订阅名称不能为空", trigger: "blur"}
        ],
        nodeGroupIds: [
          {required: true, message: "该订阅节点组不能为空", trigger: "blur"}
        ],
      },
    };
  },
  created() {
    this.baseUrl = getCurrentOrigin();
    this.getList();
  },
  methods: {
    listVpnNodeGroup,
    copyToClipboard(id) {
      const copyText = document.getElementById(id);
      copyText.select();
      document.execCommand("copy");
      this.msgSuccess("已复制到剪贴板");
    },
    /** 查询订阅列表 */
    getList() {
      this.loading = true;
      listVpnSubscription(this.queryParams).then(response => {
        this.vpnSubscriptionList = response.data.list;
        this.total = response.data.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        subscriptionId: undefined,
        nodeGroupIds: [],
        name: undefined,
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
      this.ids = selection.map(item => item.subscriptionId)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加订阅";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const subscriptionId = row.subscriptionId || this.ids
      getVpnSubscription(subscriptionId).then(response => {
        let data = response.data;
        data.nodeGroupIds = data.nodeGroupIds ? JSON.parse(data.nodeGroupIds) : [];
        this.form = data;
        this.open = true;
        this.title = "修改订阅";
      });
    },
    /** 提交按钮 */
    submitForm: function () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // this.form.nodeGroupIds = JSON.parse(this.form.nodeGroupIds)
          if (this.form.subscriptionId != undefined) {
            updateVpnSubscription(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addVpnSubscription(this.form).then(response => {
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
      const subscriptionIds = row.subscriptionId || this.ids;
      this.$confirm('是否确认删除订阅编号为"' + subscriptionIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return delVpnSubscription(subscriptionIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      }).catch(function () {
      });
    }
  }
};
</script>
