<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="地区名称" prop="nationName">
        <el-input
          v-model="queryParams.nationName"
          placeholder="请输入地区名称"
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
          v-hasPermi="['vpn/vpnNodeNation/add']"
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
          v-hasPermi="['vpn/vpnNodeNation/delete']"
        >删除
        </el-button>
      </el-col>
    </el-row>
    <el-table v-loading="loading" :data="vpnNodeNationList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="id" align="center" prop="nationId"/>
      <el-table-column label="地区名称" align="center" prop="nationName">
      </el-table-column>
      <el-table-column label="Icon" align="center" prop="nationImg">
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['vpn/vpnNodeNation/edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['vpn/vpnNodeNation/delete']"
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
    <!-- 添加或修改vpn ip 地区对话框 -->
    <el-dialog :title="title" :visible.sync="open"  v-if="open" width="600px" append-to-body :close-on-click-modal="false">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="地区名称" prop="name">
          <el-input
            v-model="form.nationName"
            placeholder="请输入地区名称"
            clearable
            size="small"
          />
        </el-form-item>
        <el-form-item label="Emoji" prop="name">
          <el-input
            v-model="form.nationImg"
            placeholder="Emoji"
            clearable
            size="small"
          />
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
  addVpnNodeNation,
  delVpnNodeNation,
  getVpnNodeNation,
  listVpnNodeNation,
  updateVpnNodeNation,
} from "@/api/vpn/vpnNodeNation";
import upfile from "@/components/upfile/index.vue";
import MultiLangInput from "@/components/multiLangInput/index.vue";
import {langShow} from "../../../../utils";
import {getUpFileUrl} from "@/utils/ruoyi";
import uploadImg from "@/components/uploadImg/index.vue";

export default {
  components: {uploadImg, MultiLangInput, upfile},
  name: "VpnNodeNation",
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
      // vpn ip 地区表格数据
      vpnNodeNationList: [],
      // 弹出层标题
      title: "",
      apiUrl: this.apiUrl,
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        nationId: undefined,
        nationName: undefined,
        nationImg: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        nationName: [
          {required: true, message: "地区名称不能为空", trigger: "blur"}
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    getUpFileUrl,
    langShow,
    /** 查询vpn ip 地区列表 */
    getList() {
      this.loading = true;
      listVpnNodeNation(this.queryParams).then(response => {
        this.vpnNodeNationList = response.data.list;
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
        nationId: undefined,
        nationName: undefined,
        nationImg: undefined,
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
      this.ids = selection.map(item => item.nationId)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加地区";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const nationId = row.nationId || this.ids
      getVpnNodeNation(nationId).then(response => {
        let data = response.data;
        this.form = data;
        this.open = true;
        this.title = "修改地区";
      });
    },
    /** 提交按钮 */
    submitForm: function () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.nationId != undefined) {
            updateVpnNodeNation(this.form).then(response => {
              if (response.code === 0) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addVpnNodeNation(this.form).then(response => {
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
      const nationIds = row.nationId || this.ids;
      this.$confirm('是否确认删除vpn ip 地区编号为"' + nationIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return delVpnNodeNation(nationIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      }).catch(function () {
      });
    }
  }
};
</script>
