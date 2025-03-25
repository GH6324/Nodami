<template>
  <div>
  <span v-for="(v,index) in currencyOptions" :key="index" style="padding-right: 5px">
    {{ v.symbol + "" +(v.exchangeRate * price).toFixed(2).toString()}}
  </span>
  </div>
</template>

<script>
import {getInfo} from "@/api/system/config/webSet";


export async function getString(value) {
  let response = await getInfo();
  let res = response.data;
  if (res) {
    let v = []
    let data = JSON.parse(res.webContent)
    for (let i in data.client.currency) {
      let s = data.client.currency[i].symbol + (data.client.currency[i].exchangeRate * value).toFixed(2).toString()
      v.push(s)
    }
    return v.join(' ');
  }
  return "";
}

export default {
  props: {
    value: {
      type: undefined,
      default: 0
    }
  },
  data() {
    return {
      currencyOptions: [],
      price:undefined
    };
  },
  mounted() {
    this.price = Number(this.value)
    getInfo().then((response) => {
      let res = response.data;
      if (res) {
        let data = JSON.parse(res.webContent)
        this.currencyOptions = data.client.currency
      }
    });
  },
  methods: {},
  watch: {
    value: {
      handler(value) {
        this.price = Number(value)
      },
      deep: true
    },
  }
};
</script>

<style scoped lang="less">

//给当前页面所以的lable都字体发生改变

/deep/ .el-form-item__label {
  font-size: 11px;
}


</style>
