<template>
  <div>
    <div v-for="(value, index) in langsOptions" :key="index">
      <el-form-item :label="value.language" :label-width="labelWidth">
        <!-- 判断是否是富文本 -->
        <el-input
          v-if="inputType !== 'richText'"
          :type="inputType"
          v-model="localizedForm[value.mark]"
          size="mini"
          :style="{ width: inputWidth }"
        />
        <quill-editor
          v-else
          v-model="localizedForm[value.mark]"
          :style="{ width: inputWidth, minHeight: '100px' }"
        />
      </el-form-item>
    </div>
  </div>
</template>

<script>
import { getInfo } from "@/api/system/config/webSet";



export default {
  components: {},
  props: {
    labelWidth: {
      type: String,
      default: () => "60px",
    },
    inputWidth: {
      type: String,
      default: () => "200px",
    },
    value: {
      type: undefined,
      default: "",
    },
    valueObject: {
      type: Boolean,
      default: false,
    },
    inputType: {
      type: String,
      default: () => undefined,
    },
  },
  data() {
    return {
      localizedForm: {},
      langsOptions: undefined,
    };
  },
  mounted() {
    getInfo().then((response) => {
      let res = response.data;
      if (res) {
        let data = JSON.parse(res.webContent);
        this.langsOptions = data.client.language;
        console.log(data);
        this.initializeForm(this.value);
      }
    });
  },
  methods: {
    initializeForm(value) {
      let localizedForm = {}
      this.langsOptions.forEach((lang) => {
        localizedForm[lang.mark] = value;
      });

      if (value) {
        if (typeof value === 'string') {
          try {
            let v =   JSON.parse(value)
            if (v){
              localizedForm = v
            }
          } catch {  }
        }else{
          localizedForm = value;
        }
      }
      if (JSON.stringify(localizedForm) == JSON.stringify(this.localizedForm)){
        return;
      }
      this.localizedForm = localizedForm;
    },
  },
  watch: {
    value: {
      handler(value) {
        this.initializeForm(value);
      },
      deep: true,
    },
    localizedForm: {
      handler(newVal) {
        if (this.valueObject) {
          this.$emit("input", this.localizedForm);
        }else{
          this.$emit("input", JSON.stringify(this.localizedForm));
        }
      },
      deep: true,
    },
  },
};
</script>

<style scoped lang="less">
/deep/ .el-form-item__label {
  font-size: 11px;
}
</style>
