<template>
  <div>
    <el-transfer
      style="text-align: left; display: inline-block"
      v-model="modelValue"
      filterable
      :left-default-checked="[2, 3]"
      :right-default-checked="[1]"
      :render-content="renderFunc"
      :filter-method="filterMethod"
      :titles="['Source', 'Target']"
      :format="{
        noChecked: '${total}',
        hasChecked: '${checked}/${total}'
      }"
      @change="handleChange"
      :data="list">
      <el-pagination
        hide-on-single-page
        :pager-count="5"
        slot="left-footer"
        small
        layout="prev, pager, next,sizes"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page.sync="pagination.currentPage"
        :page-size.sync="pagination.pageSize"
        :page-sizes="pagination.pageSizes"
        :total="pagination.total">
      </el-pagination>

    </el-transfer>
  </div>
</template>

<style>
.transfer-footer {
  margin-left: 20px;
  padding: 6px 5px;
}
</style>

<script>
import {deepEqual} from "@/utils";
import {scrollTo} from "@/utils/scroll-to";

export default {
  props: {
    listFunction: {
      type: Function,
      default() {
        return function (query) {
        };
      },
      required: true,
    },
    value: {
      type: Array,
      default() {
        return [];
      },
    },
    queryParams: {
      type: Object,
      default() {
        return {}
      },
    },
    valueKey: String,
    searchKey: {
      type: String,
      default() {
        return "search"
      },
    },
    labelKey: {
      type: [Object,String],
      default() {
        return {
          name: 'name'
        }
      },
    },
  },
  data() {

    return {
      params: {},
      params2: {},
      searchValue:undefined,
      pagination: {
        total: 0,
        currentPage: 1,
        pageSize: 20,
        pageSizes: [20, 50, 100]
      },
      list: [],
      modelValue: [],
      renderFunc(h, option) {
        return <span>{ option.key } - { option.label }</span>;
      }
    };
  },
  watch: {
    value: {
      handler: function (val) {
        this.modelValue = val;
      },
      deep: true
    },
    queryParams: {
      handler:  function (val)  {
        if (!deepEqual(val,this.params2)) {
          this.params2 = val;
          this.getList()
        }
      },
      deep: true
    },
  },
  mounted() {
    this.modelValue = this.value
    this.params2 = this.queryParams
    this.getList()
  },
  methods: {

    selectClear: function () {
      this.list = []
      this.searchValue = ""
      this.pagination.currentPage = 1;
      this.total = 0;
      this.getList()
    },
    handleChange(value, direction, movedKeys) {
      this.$emit('input', value);
      console.log(value);
    },
    filterMethod(query, item) {
      if (this.searchValue == query){
        return true;
      }
      this.searchValue = query
      this.pagination.currentPage = 1
      this.getList()
      return true;
    },
    handleSizeChange(val) {
      this.getList()
      scrollTo(0, 800)
    },
    handleCurrentChange(val) {
      this.getList()
      scrollTo(0, 800)
    },
    getLabel(item) {
      let labelKey = ""
      if (typeof this.labelKey === 'string') {
        labelKey = item[this.labelKey]
      } else if (typeof this.labelKey  === 'object') {
        Object.entries(this.labelKey).forEach(([key, value]) => {
          labelKey += key + ":" + item[value] + "; "
        });
      }
      return labelKey
    },
    getList() {
      this.loading = true;
      if (this.params2) {
        Object.keys(this.params2).forEach(key => {
          console.log(key + ': ' + this.params2[key]);
          this.params[key] = this.params2[key]
        });
      }

      if (this.searchKey) {
        this.params[this.searchKey] = this.searchValue
      }
      this.params["pageNum"] = this.pagination.currentPage || 1
      this.params["pageSize"] = this.pagination.pageSize
      this.listFunction(this.params).then(response => {
        if (this.params["pageNum"] == 1 || this.params["pageNum"] == 0 || !response.data || !response.data.list) {
          this.list = []
        }
        if (response.data.list) {
          for (let item of response.data.list) {
            this.list.push({key: item[this.valueKey], label: this.getLabel(item)})
          }
        }
        this.pagination.total = response.data.total;
        this.loading = false;
      });
    }
  }
};
</script>
<style scoped>
/* 使用深度作用选择器修改子组件样式 */
>>> .el-transfer-panel {
  min-width: 300px !important;
}
>>> .el-transfer__buttons {
  width: 60px !important;
  padding:0 0 0 0 !important;
  text-align: center;
}

>>> .el-transfer__button{
  margin-bottom:10px !important;
}
>>> .el-button+.el-button{
  margin-left:0px !important;
}
</style>
