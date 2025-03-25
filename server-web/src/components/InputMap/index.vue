<template>
  <div :style="{'font-size': '10px','width':width}">
    <el-col>
      <el-row :gutter="24" style="width: 100%; text-align: left;padding: 0px;">
        <el-col :span="Math.floor((24-6) / 2)" style="display: flex;justify-content: center;">
          {{ labelKey }}
        </el-col>
        <el-col :span="Math.floor((24-6) / 2)" style="display: flex;justify-content: center;">
          {{ labelValue }}
        </el-col>
        <el-col :span="6">
          <el-button size="mini" type="text" icon="el-icon-plus" style="margin-left: 10px" @click="addGoodsInfo()">添加
          </el-button>
        </el-col>
      </el-row>
      <el-row :gutter="24" style="width: 100%; text-align: left;padding: 0px;" v-for="(item, i) in basePoint" :key="i">
        <el-col :span="9">
          <el-col style="padding: 0px;">
            <template v-if="keyOptions.length > 0">
              <el-select size="mini" v-model="item['key']" clearable placeholder="请选择">
                <el-option v-for="option in keyOptions" :key="option.key" :label="option.value" :value="option.key"/>
              </el-select>
            </template>
            <template v-else>
              <el-input size="mini" clearable v-model="item['key']" :placeholder="labelKey"/>
            </template>
          </el-col>
        </el-col>
        <el-col :span="9">
          <el-col style="padding: 0px;">
            <template v-if="valueOptions.length > 0">
              <el-select size="mini" v-model="item['value']" clearable placeholder="请选择">
                <el-option v-for="option in valueOptions" :key="option.key" :label="option.value" :value="option.key"/>
              </el-select>
            </template>
            <template v-else>
              <el-input size="mini" clearable v-model="item['value']" :placeholder="labelValue"/>
            </template>
          </el-col>
        </el-col>
        <el-col :span="6">
          <el-button size="mini" type="text" icon="el-icon-delete" style="margin-left: 10px;color: red" @click="deleteGoodsInfo(i)">删除
          </el-button>
        </el-col>
      </el-row>
    </el-col>
  </div>
</template>

<script>
export default {
  name: 'inputMap',
  props: {
    width: {
      type: String,
      default: () => "100%",
    },
    value: {
      type: null, // 支持数组或字符串类型
      default: () => [],
    },
    typeofString: {
      type: Boolean, // 支持数组或字符串类型
      default: () => true,
    },
    labelKey: {
      type: String, // 外部传入的 labelKey
      default: 'key',
    },
    labelValue: {
      type: String, // 外部传入的 labelValue
      default: 'value',
    },
    keyOptions: {
      type: Array, // 基点key的下拉选项数组
      default: () => [], // 默认不使用下拉选择器
    },
    valueOptions: {
      type: Array, // 基点名的下拉选项数组
      default: () => [], // 默认不使用下拉选择器
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
        this.emitValue();
      },
      deep: true,
    },
  },
  methods: {
    emitValue() {
      let obj = {}
      for (const index in this.basePoint) {
        if (obj.hasOwnProperty(this.basePoint[index].key)) {
          continue
        }
        obj[this.basePoint[index].key] = this.basePoint[index].value
      }
      let v = obj
      if (this.typeofString) {
        v = JSON.stringify(obj);
      }

      this.$emit('input', v);

    },
    parseValue(value) {

      if (!value) {
        return
      }
      let obj = value || {}
      try {
        obj = typeof value === 'string' ? JSON.parse(value) : value;
      } catch (e) {
        obj = value || {}
      }

      let basePointMap = {}
      for (const i in this.basePoint) {
        let v = this.basePoint[i]
        basePointMap[v.key] = v.value
      }

      if (JSON.stringify(basePointMap) === JSON.stringify(obj)) {
        return;
      }


      let basePoint = []
      for (const key in obj) {
        basePoint.push({
          key: key,
          value: obj[key]
        })
      }
      this.basePoint = basePoint;

    },

    addGoodsInfo() {
      this.basePoint.push({value: "", key: ""});
    },
    deleteGoodsInfo(index) {
      this.basePoint.splice(index, 1);
    },
  },
};
</script>

<style scoped>
/deep/ .el-form-item__label {
  font-size: 11px;
}
</style>
