<template>
  <el-row :gutter="10" class="monitor-progress">
    <el-col :span="6">{{ label }}</el-col>
    <el-col :span="18">
      <el-tooltip :content="`已用: ${sizeFormat(used)} / 总共: ${sizeFormat(total)}`">
        <el-progress
          :color="customColors"
          :text-inside="true"
          :stroke-width="24"
          :percentage="percentage"
          :format="formatProgress"
        />
      </el-tooltip>
    </el-col>
  </el-row>
</template>

<script>
import { sizeFormat } from '@/utils'

export default {
  props: {
    label: String,
    used: Number,
    total: Number,
    percentage: Number
  },
  data() {
    return {
      customColors: [
        { color: '#13ce66', percentage: 20 },
        { color: '#1890ff', percentage: 40 },
        { color: '#e6a23c', percentage: 60 },
        { color: '#1989fa', percentage: 80 },
        { color: '#F56C6C', percentage: 100 }
      ]
    }
  },
  methods: {
    formatProgress() {
      return `${this.percentage.toFixed(1)}%`
    },
    sizeFormat
  }
}
</script>
