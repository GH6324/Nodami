<template>
  <el-select
    :multiple="multiple"
    :multipleLimit="multipleLimit"
    v-model="copyValue"
    :disabled="disabled"
    filterable
    :collapse-tags="collapseTags"
    :size="size"
    :clearable="clearable"
    @clear="selectClear"
    :placeholder="placeholder"
    @change="updateValue"
    :filter-method="filterMethod"
    remote
    :remote-method="remoteMethod"
    @focus="focusMethod"
    :style="{width: width}"
  >
    <el-option
      v-for="item in list"
      :key="item[valueKey]"
      :label="getLabel(item)"
      :value="item[valueKey]"
    >
    </el-option>
    <div style="float: right;margin-right:10px;padding-bottom: 10px">
      <el-pagination
        v-show="total>0"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page.sync="pageInfo.pageNum"
        :page-size.sync="pageInfo.pageSize"
        :pager-count="5"
        layout=" prev, pager, next,total"
        :total="total">
      </el-pagination>
    </div>
  </el-select>
</template>

<script>


import {scrollTo} from "@/utils/scroll-to";
import {deepEqual, langShow} from "@/utils";

export default {
  name: "paginationSelect",
  props: {
    //绑定值
    width: {
      type: String,
      default() {
        return "200px";
      },
    },
    multipleLimit: Number,
    collapseTags: Boolean,
    value: {
      type: [Array, Object, String, Number],
      default() {
        return "";
      },
    },
    placeholder: String,
    size: {
      type: String,
      default() {
        return "small";
      },
    },
    multiple: {
      type: Boolean,
      default() {
        return false
      },
    },
    clearable: Boolean,
    //下拉列表
    queryParams: {
      type: Object,
      default() {
        return {}
      },
    },
    searchKey: {
      type: String,
      default() {
        return "search"
      },
    },
    //option的label在列表中对应的key
    labelKey: {
      type: Object,
      default() {
        return {
          name: 'name'
        }
      },
    },
    pageSize: {
      type: Number,
      default() {
        return 10
      },
    },
    //option的value在列表中对应的key
    valueKey: String,
    disabled: false,
    defaultList: {
      type: Array,
      default() {
        return [];
      },
    },
    listFunction: {
      type: Function,
      default() {
        return function (query) {
        };
      },
      required: true,
    },
    value2: {
      type: [String, Number],
      default: ""
    },
    value2Key: {
      type: [String],
      default: ""
    },
  },
  watch: {
    value: {
      handler: function (val) {
        if (this.copyValue != val) {
          this.copyValue = val;
        }

        if (typeof val !== 'object' && typeof val !== "array" && this.searchKey && !this.searchValue) {
          if (val && this.containsElement(this.list,val)){
            this.searchValue = value;
            this.getList(true)
          }

        } else if (typeof val !== "array") {
          for (let index in val) {
            let v = val[index]
            if (v && this.containsElement(this.list,v)){
              this.searchValue = value;
              this.getList(true)
            }
          }
        }
      },
      deep: true
    },
    queryParams: {
      handler: function (val) {
        if (!deepEqual(this.params2, val)) {
          this.params2 = val;
          this.selectClear()
        }
      },
      deep: true
    },
  },
  mounted() {
    this.copyValue = this.value;
    this.params2 = this.queryParams
    this.default2List = this.defaultList
    this.getList()
  },

  methods: {
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
      Object.entries(this.labelKey).forEach(([key, index]) => {
        let v = item[index]
        labelKey += key + ":" + langShow(v) + "; "
      });
      return labelKey
    },
    updateValue(val) {
      this.$emit('input', val);
      this.$emit('change', val)
      this.searchValue = ""
      if (this.value2Key) {
        for (let index in this.list) {
          let d = this.list[index]
          if (d[this.valueKey] == val) {
            this.$emit('update:value2', d[this.value2Key])
            break
          }
        }
      }
    },
    filterMethod: function (query) {
      this.copyValue = query;
      this.getList()
    },
    remoteMethod: function (query) {
      if ((this.searchKey && !query) || query) {
        this.searchValue = query
        this.pageInfo.pageNum = 1;
        this.getList()
      }
    },
    focusMethod: function () {
      if (!this.list || (this.list && this.list.length == 0)) {
        this.filterMethod();
      }
    },
    selectClear: function () {
      this.list = []
      this.searchValue = ""
      this.pageInfo.pageNum = 1;
      this.pageInfo.pageSize = this.pageSize;
      this.total = 0;
      this.copyValue = ""
      this.params = {}
      this.$emit('selectClear');
      this.getList()
    },
    uniqueArray: function (arr) {
      const seen = new Map();
      return arr.filter((item) => {
        let key = typeof item + JSON.stringify(item);
        if (!seen.has(key)) {
          seen.set(key, true);
          return true;
        }
        return false;
      });
    },
    containsElement: function (arr, element) {
      const elementAsString = JSON.stringify(element);
      return arr.some(item => JSON.stringify(item) === elementAsString);
    },
    getList(isDefault = false) {
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
      this.params["pageNum"] = this.pageInfo.pageNum || 1
      this.params["pageSize"] = this.pageInfo.pageSize
      this.listFunction(this.params).then(response => {
        if (isDefault) {
          this.default2List = this.uniqueArray(this.default2List.concat(response.data.list || []));
          this.list = this.uniqueArray(this.default2List.concat(this.list || []));
          this.searchValue = ""
        } else {
          this.list = response.data.list;
          if (this.params["pageNum"] == 1 || this.params["pageNum"] == 0) {
            this.list = this.uniqueArray(this.default2List.concat(response.data.list || []));
          }
        }


        this.total = response.data.total;
        this.loading = false;
      });
    }
  },
  data() {
    return {
      default2List: [],
      copyValue: this.value,
      list: [],
      total: 0,
      params: {},
      params2: {},
      searchValue: "",
      pageInfo: {
        pageNum: 1,
        pageSize: this.pageSize,
      }
    };
  }
};
</script>

<style scoped>
.elPaginationSelect {
  width: 100%;
  border: none !important;
}

.elPaginationSelect .el-input input {
  border: none !important;
  width: 100%;
}
</style>
