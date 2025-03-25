<template>
  <el-input
    v-model="inputValue"
    type="textarea"
    :rows="rows"
    :textarea="true"
    placeholder="导入外部节点一行一个 格式:ip 端口 账号 密码"
    @input="handleInput">
  </el-input>
</template>

<script>
export default {
  props: {
    value: {
      type: Array,
      default: () => []
    },
    rows: {
      type: Number,
      default: 10
    }
  },
  data() {
    return {
      inputValue: this.value.join('\n')
    };
  },
  methods: {
    handleInput() {
      // 将输入的多行文本按行分割成数组，并过滤掉空行
      const lines = this.inputValue.split('\n').filter(line => line.trim() !== '');
      // 仅当输入框的值真正改变时触发 input 事件
      if (lines.join('\n') !== this.value.join('\n')) {
        // 更新父组件的 v-model 值
        this.$emit('input', lines);
      }
    }
  },
  watch: {
    value(newVal) {
      // 当父组件的 v-model 值变化时更新输入框的内容
      this.inputValue = newVal.join('\n');
    }
  }
};
</script>
