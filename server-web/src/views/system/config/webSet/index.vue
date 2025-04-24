<template>
  <div class="app-container">

    <el-card class="box-card">
      <el-tabs tab-position="left" style="height: 100%;">
        <el-form :model="ruleForm" :rules="rules" ref="agentForm" label-width="100px">
          <el-form-item label="服务器IPV4:" prop="agent.serverIpV4">
            <el-input v-model="ruleForm.agent.serverIpV4" style="width:250px"></el-input>
          </el-form-item>
          <el-form-item label="服务器IPV6:" prop="agent.serverIpV6">
            <el-input v-model="ruleForm.agent.serverIpV6" style="width:250px"></el-input>
          </el-form-item>
          <el-form-item label="通用秘钥:" prop="agent.commonUUID">
            <el-input
              disabled
              v-model="ruleForm.agent.commonUUID"
              maxlength="36"
              show-word-limit
              style="width:330px;"
            >
              <el-button
                size="mini"
                slot="suffix"
                style="background-color:#0d99a5;border-radius:5px;color:#e5e5e5;height: auto;padding: 5px"
                type="text"
                @click="randomUUID"
              >随机
              </el-button>
            </el-input>
          </el-form-item>
          <el-form-item style="display: flex;justify-content: flex-start;margin-top: 30px">
            <el-button type="primary" @click="submitForm('agentForm')">提交保存</el-button>
          </el-form-item>
        </el-form>
      </el-tabs>


    </el-card>
  </div>
</template>

<script>
import {getInfo, updateInfo} from "@/api/system/config/webSet";


export default {
  components: {},
  data() {
    return {
      // 上传加载
      upLoading: false,
      // 表单参数
      ruleForm: {
        client: {},
        agent: {},
        other: {},
        smtp: {},
      },
      // 表单验证
      rules: {
        "agent.serverIpV4": [
          {required: true, message: "请配置服务器IP", trigger: "blur"},
        ],
        "agent.serverIpV6": [
          {required: true, message: "请配置服务器IP", trigger: "blur"},
        ],
        "agent.commonUUID": [
          {required: true, message: "请配置通用秘钥", trigger: "blur"},
        ],
      },
    };
  },
  created() {
    this.getWeb();
  },
  methods: {

    randomUUID() {
      let uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
      });
      this.ruleForm.agent.commonUUID = uuid
    },
    getWeb() {
      getInfo().then((response) => {
        let res = response.data;
        if (res) {
          let data = JSON.parse(res.webContent)
          console.log(data)
          data.client = data.client || {}
          data.agent = data.agent || {}
          data.other = data.other || {}
          data.smtp = data.smtp || {}
          data.webId = res.webId

          data.client.language = data.client.language || []
          data.client.currency = data.client.currency || [
            {
              "symbol": "¥",
              "currency": "rmb",
              "exchangeRate": 0.00
            },
            {
              "symbol": "$",
              "currency": "usd",
              "exchangeRate": 0.00
            },
            {
              "currency": "eur",
              "symbol": "€",
              "exchangeRate": 0.00
            }
          ]

          this.ruleForm = data

        }
      });
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          updateInfo(this.ruleForm).then((response) => {
            if (response.code === 0) {
              this.msgSuccess("修改保存成功!");
            } else {
              this.msgError(response.msg);
            }
          });
        }
      });
    },
  },
};
</script>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
