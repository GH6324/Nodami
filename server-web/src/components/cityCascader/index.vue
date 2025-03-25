<template>
  <el-cascader v-model="cityValue" :props="cityProps" clearable></el-cascader>
</template>

<script>



export default {
  props: {
    cityId: {
      type: [String, Number],
      default: ""
    },
    nationId: {
      type: [String, Number],
      default: ""
    },
  },
  components: {},
  name: "cityCascader",

  data() {
    return {

      formCityValue: [],
      loading: [],
      cityProps: {
        checkStrictly: true,
        lazy: true,
        loading: {},
        lazyLoad(node, resolve) {
          const {label} = node;
          const {level} = node;
          const {value} = node;
          let query = {pageSize: 10000}
          let fun = listVpnNodeNation
          if (level == 1) {
            query["nationId"] = value
            fun = listVpnCustomizeCity
          }
          fun(query).then(res => {
            let nodes = []
            res.data.list.forEach(e => {
              let label = e["nationName"]
              let value = e["nationId"]+""
              if (level == 1) {
                label = e["cityName"]
                value = e["cityId"]+""
              }
              nodes.push({
                label: label,
                value: value,
                leaf: level >= 1,
              })
            })
            resolve(nodes);
          })
        }

      }
    }
  }
  ,
  computed: {
    cityValue: {
      get() {
        let v = []
        if (this.nationId) {
          v.push(this.nationId)
        }
        if (this.cityId) {
          v.push(this.cityId)
        }
        console.log(this.cityId)
        return v
      }
      ,
      set(data) {
        let nationId = data[0]
        let cityId = data[1]


        this.$emit('update:cityId', cityId)
        this.$emit('update:nationId', nationId)

      }
      ,
    }
  }
  ,
  methods: {}
}
</script>
 z
<style scoped>

</style>
