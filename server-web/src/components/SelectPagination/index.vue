<template>
  <el-select
    popper-class="t_pagination_select"
    v-model="childSelectedValue"
    filterable
    :multiple="multiple"
    :multiple-limit="multipleLimit"
    :filter-method="filterMethod"
    v-bind="attrs"
    v-on="$listeners"
  >
    <el-option
      v-for="item in optionSource"
      :key="item['key']"
      :label="item['key']"
      :value="item['value']"
    ></el-option>
    <el-pagination
      :layout="optionPage.layout || 'total,prev, pager, next'"
      :page-size="optionPage.pageSize"
      :current-page="optionPage.pageNum"
      :pager-count="optionPage.pagerCount"
      :total="optionPage.total"
      v-bind="{
            small: true,
            'hide-on-single-page':true,
            background: true,
            ...$attrs,
            ...optionPage.bind,
          }"
      v-on="$listeners"
    />
  </el-select>
</template>

<script>


export default {
  name: 'TPaginationSelect',
  props: {
    searchFun: {
      type: Function,
      default: function () {

      }
    },
    params: {
      type: Object,
      default: function () {
        return {}
      }
    },
    multiple: {
      type: Boolean,
      default: function () {
        return false
      }
    },
    multipleLimit: {
      type: Number,
      default: function () {
        return 0
      }
    },
    searchKey: {
      type: String,
      default: ''
    },
    value: {
      type: [String, Number, Array]
    },
    // 传入的option数组中，要作为最终选择项的键值名称
    valueKey: {
      type: String,
      default: 'key'
    },
    // 传入的option数组中，要作为显示项的键值名称
    labelKey: {
      type: Array,
      default: ['label']
    },
    // 每页显示条数
    pageSize: {
      type: Number,
      default: () => {
        return 10
      }
    }
  },
  data() {
    return {
      optionSource: [],
      optionPage: {
        pageNum: 1,
        pageSize: this.pageSize,
        pagerCount: 5,
        total: 0
      },
      loading: false,
      searchValue: "",
    }
  },
  computed: {
    childSelectedValue: {
      get() {
        return this.value
      },
      set(val) {
        console.log(val)
        this.$emit('input', val)
      }
    },
    attrs() {
      return {
        clearable: true,
        filterable: true,
        ...this.$attrs
      }
    }
  },
  mounted() {
    this.optionPage.pageNum = 1
    this.list()
  },
  methods: {
    filterMethod(searchValue) {
      this.searchValue = searchValue
      this.optionPage.pageNum = 1
      this.list()
    },
    list() {
      let params = {
        pageNum: this.optionPage.pageNum,// 当前页
        pageSize: this.optionPage.pageSize,// 每页显示条数
      }
      if (this.searchKey && this.searchValue) {
        params[this.searchKey] = this.searchValue
      }
      for (const key in this.params) {
        params[key] = this.params[key]
      }


      this.loading = true;
      this.searchFun(params).then(response => {
        console.log(this.labelKey)
        console.log(this.valueKey)
        this.loading = false;
        // this.optionSource = response.data.list
        response.data.list.forEach((item, index) => {
          let key = ""
          for (const v of this.labelKey) {
            key += v + ":" + item[v] + " "
          }
          let value = item[this.valueKey]
          this.optionSource.push({
            key: key,
            value: value
          })
        });
        this.optionPage.total = response.data.total;
      });
    }
  }
}
</script>
<style lang="scss">
.t_pagination_select {

.el-pagination {
  display: flex;
  background-color: #fff;
  align-items: center;

.el-pagination__total,
.el-pager,
button {
  display: flex;
  align-items: center;
}

}
}
</style>
