<template>
  <div :style="{'font-size': '10px','width':width}">
    <el-button
      type="primary"
      icon="el-icon-plus"
      size="mini"
      @click="addGoodsInfo"
    >添加
    </el-button>

    <div style="margin-top: 10px"></div>
    <el-col>
      <el-row :gutter="24" style="width: 100%; text-align: left;padding: 0px;" v-for="(item, index) in basePoint" :key="index">
        <!-- 判断是否为下拉框或输入框 -->
        <el-col :span="18">
          <el-row :gutter="24">
            <el-col :span="7" style="padding-left: 0px;text-align: right;padding-right: 5px">{{ labelName+(index+1) }}</el-col>
            <el-col :span="17" style="padding: 0px;">
              <template v-if="paginationFunction">
                <paginationSelect v-model="basePoint[index]"
                                  size="mini"
                                  placeholder="请选择"
                                  clearable
                                  :queryParams="paginationQueryParams"
                                  :labelKey='paginationSelectLabelKey'
                                  :valueKey="paginationValueKey"
                                  :pageSize="10000"
                                  :listFunction="paginationFunction"
                                  width="100%"
                                  @change="change"
                ></paginationSelect>
              </template>
              <template v-else-if="valueOptions.length > 0">
                <el-select size="mini" v-model="basePoint[index]" clearable placeholder="请选择">
                  <el-option v-for="option in valueOptions" :key="option.key" :label="option.value" :value="option.key"/>
                </el-select>
              </template>
              <template v-else>
                <el-input size="mini" clearable v-model="basePoint[index]" :placeholder="labelName"/>
              </template>
            </el-col>
          </el-row>
        </el-col>

        <el-col :span="6">
          <el-row :gutter="10">
            <el-col :span="1.5"><el-tag size="mini" type="danger" @click="deleteGoodsInfo(index)">删除</el-tag></el-col>
          </el-row>
        </el-col>
      </el-row>
    </el-col>
  </div>
</template>

<script>
import paginationSelect from "@/components/paginationSelect/index.vue";

export default {
  components: {paginationSelect},
  name: 'InputList',
  props: {
    value: {
      type: null, // 支持数组或字符串类型
      default: () => [],
    },
    width: {
      type: String, // 支持数组或字符串类型
      default: () => undefined,
    },
    typeofString: {
      type: Boolean, // 支持数组或字符串类型
      default: () => true,
    },
    labelName: {
      type: String, // 外部传入的 labelName
      default: 'value',
    },
    valueOptions: {
      type: Array,
      default: () => [],
    },
    paginationFunction: {
      type: Function,
      default: undefined,
    },
    paginationSelectLabelKey: {
      type: Object,
      default: undefined,
    },
    paginationValueKey: {
      type: String,
      default: undefined,
    },
    paginationQueryParams: {
      type: Object,
      default: undefined,
    },
    allowDuplicate: {
      type: Boolean, // 控制是否允许重复元素
      default: false, // 默认为 true，允许重复元素
    },

  },
  data() {
    return {
      basePoint: [], // 用于存储基点数据
    };
  },
  mounted() {
    this.parseValue(this.value);
  },
  watch: {
    value: {
      handler(newVal) {
        this.parseValue(newVal); // 转换为对象
      },
      deep: true,
    },
    basePoint: {
      handler(newVal) {
        this.handleDuplicates();
        this.emitValue();
      },
      deep: true,
    },
  },
  methods: {
    emitValue() {
      let v = this.basePoint
      if (this.typeofString) {
        v = JSON.stringify(v);
      }
      this.$emit('input', v);
    },

    parseValue(value) {
      if (!value) {
        return
      }
      let obj = value
      try {
        obj = typeof value === 'string' ? JSON.parse(value) : value;
      } catch (e) {
        obj = value;
      }

      if (JSON.stringify(obj) !== JSON.stringify(this.basePoint)) {
        this.basePoint = obj;
      }

    },

    addGoodsInfo() {
      this.basePoint.push("");
    },
    deleteGoodsInfo(index) {
      this.basePoint.splice(index, 1);
    },
    change(){

    },
    handleDuplicates() {
      if (!this.allowDuplicate) {
        const uniqueItems = [...new Set(this.basePoint)];
        if (uniqueItems.length !== this.basePoint.length) {
          this.$message.warning('检测到重复项，已移除重复值');
          this.basePoint = uniqueItems;
        }
      }
    },

    // 新增的上下移动功能
    moveUp(index) {
      if (index > 0) {
        this.swapItems(index, index - 1);
      }
    },
    moveDown(index) {
      if (index < this.basePoint.length - 1) {
        this.swapItems(index, index + 1);
      }
    },
    swapItems(index1, index2) {
      const temp = this.basePoint[index1];
      this.basePoint[index1] = this.basePoint[index2];
      this.basePoint[index2] = temp;
    }
  },
};
</script>

<style scoped>
/deep/ .el-form-item__label {
  font-size: 11px;
}
</style>
