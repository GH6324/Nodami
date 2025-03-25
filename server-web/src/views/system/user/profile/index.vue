<template>
  <div class="app-container">
    <el-col :span="12" :xs="24">
      <el-card>
        <div slot="header" class="clearfix">
          <span>基本资料</span>
        </div>
        <el-tabs v-model="activeTab">
          <el-tab-pane label="基本资料" name="userinfo">
            <userInfo :user="user" />
          </el-tab-pane>
          <el-tab-pane label="修改密码" name="resetPwd">
            <resetPwd :user="user" />
          </el-tab-pane>
        </el-tabs>
      </el-card>
    </el-col>
  </div>
</template>

<script>
import userAvatar from "./userAvatar";
import userInfo from "./userInfo";
import resetPwd from "./resetPwd";
import { getUserProfile } from "@/api/system/user";

export default {
  name: "Profile",
  components: { userAvatar, userInfo, resetPwd },
  data() {
    return {
      user: {},
      activeTab: "userinfo"
    };
  },
  created() {
    this.getUser();
  },

  computed:{
    postGroup(){
      if(Array.isArray(this.user.post)){
        return this.user.post.reduce(function(total, currentValue, currentIndex, arr){
          return total + currentValue.postName + " "
        }, "")
      }
      return ""
    },
    roleGroup(){
      if(Array.isArray(this.user.roleInfo)){
        return this.user.roleInfo.reduce(function(total, currentValue, currentIndex, arr){
          return total + currentValue.name + " "
        }, "")
      }
      return ""
    }
  },
  methods: {
    getUser() {
      getUserProfile().then(response => {
        this.user = response.data;
      });
    }
  }
};
</script>
