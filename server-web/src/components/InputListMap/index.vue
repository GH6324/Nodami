<template>
  <div :style="{'font-size': '12px','width':width}">

    <el-col>
      <el-row :gutter="24" style="width: 100%; text-align: left;padding: 0px;">
        <el-col :span="Math.floor((24-6) / options.length)" v-for="(item, index) in options" :key="index" style="display: flex;justify-content: center;">
          {{ item.labelName }}
        </el-col>
        <el-col :span="6" v-if="allowDeletion">
          <el-button size="mini"  type="text" icon="el-icon-plus" style="margin-left: 10px" @click="addGoodsInfo()">添加
          </el-button>
        </el-col>
      </el-row>
      <el-row :gutter="24" style="width: 100%; text-align: left;padding: 0px;" v-for="(v, i) in basePoint" :key="i">
        <el-col :span="Math.floor((24-6) / options.length)" v-for="(item, index) in options" :key="index" style="padding-left: 3px;padding-right: 3px;">
          <el-col  style="padding: 0px;">
            <template v-if="item.valueOptions && item.valueOptions.length > 0">
              <el-select :disabled="item.disabled" size="mini" v-model="v[item.labelKey]" clearable placeholder="请选择">
                <el-option v-for="option in item.valueOptions" :key="option.key" :label="option.value" :value="option.key"/>
              </el-select>
            </template>
            <template v-else>
<!--              <el-input :disabled="item.disabled" size="mini" :type="item.inputType"  v-model="v[item.labelKey]"/>-->
              <el-input
                :disabled="item.disabled"
                size="mini"
                :type="item.inputType"
                :value="v[item.labelKey]"
                @input="handleInput($event, item.inputType, v, item.labelKey)"
              />
            </template>
          </el-col>
        </el-col>
        <el-col :span="6" v-if="allowDeletion">
          <el-button size="mini" type="text" icon="el-icon-delete" style="margin-left: 10px;color: red" @click="deleteGoodsInfo(i)">删除</el-button>
        </el-col>
      </el-row>
    </el-col>
  </div>
</template>

<script>
export default {
  name: 'inputListMap',
  props: {
    width:{
      type: String,
      default: () => "100%",
    },
    value: {
      type: null,
      default: () => [],
    },
    typeofString: {
      type: Boolean, // 返回数据类型
      default: () => true,
    },
    allowDeletion: {
      type: Boolean, // 返回数据类型
      default: () => true,
    },
    allowDuplicate: {
      type: Boolean, // 控制是否允许重复元素
      default: false, // 默认为 true，允许重复元素
    },
    labels: {
      type: Array,
      default: () => [
        {
          labelName: "key",
          labelKey: "key",
          valueOptions: undefined,
          inputType: undefined
        },
        {
          labelName: "value",
          labelKey: "value",
          valueOptions: undefined,
          inputType: undefined
        }
      ],
    },
    maxLength: {
      type: Number, // 返回数据类型
      default: () => 0,
    },
  },
  data() {
    return {
      basePoint: [], // 用于存储基点数据
      options: [],
    };
  },
  mounted() {
    this.parseValue(this.value);
    this.options = this.labels;
  },
  watch: {
    value: {
      handler(newVal) {
        this.handleDuplicates();
        this.parseValue(newVal); // 转换为对象
      },
      deep: true,
    },
    labels: {
      handler(newVal) {
        this.options = newVal;
      },
      deep: true,
    },
    basePoint: {
      handler(newVal) {
        console.log(newVal)
        this.emitValue();
      },
      deep: true,
    },
  },
  methods: {
    handleInput(value, inputType, vObj, key) {
      if (inputType.toLowerCase() === 'number') {
        vObj[key] = Number(value); // 将输入转换为数字，更新传入的 v 对象
      } else {
        vObj[key] = value; // 保持字符串
      }
    },
    emitValue() {
      let v = this.basePoint
      if (this.typeofString) {
        v = JSON.stringify(this.basePoint);
      }

      this.$emit('input', v);
      this.$emit('change', v)

    },
    parseValue(value) {
      if (!value) {
        return
      }
      let basePoint = value
      try {
        basePoint = typeof value === 'string' ? JSON.parse(value) : value;
      } catch (e) {
        basePoint = value;
      }

      if (JSON.stringify(basePoint) !== JSON.stringify(this.basePoint)) {
        this.basePoint = basePoint;
      }
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
    addGoodsInfo() {
      if (this.maxLength > 0 && this.basePoint.length >= this.maxLength){
        this.$message.warning('最大只允许 '+this.maxLength+" 行数据");
      }
      let v = {}
      for (const i in this.options){
        let option = this.options[i];
        v[option.labelKey] = undefined
      }
      this.basePoint.push(v);
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
