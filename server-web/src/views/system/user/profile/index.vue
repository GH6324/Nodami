<template>
  <div class="app-container">
    <el-col :span="12" :xs="24">
      <el-card>
        <resetPwd :user="user" />
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
      activeTab: "resetPwd"
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
