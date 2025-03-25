<template>
  <el-input placeholder="请输入流量值" v-model="flowValue" style="width: 280px">
    <el-select v-model="flowDw" slot="append" placeholder="请选择单位" style="width: 80px">
      <el-option label="B" :value="1"></el-option>
      <el-option label="KB" :value="1024"></el-option>
      <el-option label="MB" :value="1024*1024"></el-option>
      <el-option label="GB" :value="1024*1024*1024"></el-option>
      <el-option label="TB" :value="1024*1024*1024*1024"></el-option>
    </el-select>
  </el-input>
</template>

<script>
export default {
  name: "flowInput",
  props: {
    value: {
      type: Number,
      default: function () {
        return 0
      }
    },
  },
  data(){
    return {
      flowDw:1,
    }
  },
  watch:{
    flowDw(n,o){
      this.$emit('input', this.flowValue*this.flowDw)
    }
  },
  mounted(){
    this.flowDw = 1
    if (this.value >= 1024){
      this.flowDw = 1024
    }
    if (this.value >= 1024*1024){
      this.flowDw = 1024*1024
    }
  },
  computed: {
    flowValue: {
      get() {
        return (this.value/this.flowDw)
      },
      set(val) {
        this.$emit('input', val*this.flowDw)
        return val*this.flowDw
      }
    },
  }
}
</script>

<style scoped>

</style>
