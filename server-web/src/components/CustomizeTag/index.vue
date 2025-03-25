<template>
  <div style="display: flex;flex-direction:column;width: 100%;">
    <div class="el-input__inner" style="display: flex;flex-direction:row;flex-wrap: wrap;align-items: center;">
      <el-tag v-for="(tag,index) in tags" :key="index" size="large" style="margin-right: 5px;" closable
              @close="handleClose(tag)">
        {{ tag }}
      </el-tag>
      <el-input size="small" v-if="inputVisible" ref="inputRef" v-model="inputValue" style="width: 100px;" class="ml-1 w-20" @keyup.enter="handleInputConfirm()" @blur="handleInputConfirm()"/>
      <el-button size="small" v-else class="button-new-tag ml-1" @click="showInput" v-if="customize">
        + New Tag
      </el-button>
    </div>

    <div style="display: flex;flex-direction:row;flex-wrap: wrap;margin-top: 20px;">
      <el-tag checked v-for="(v,index) in setupTag" :key="index" style="margin-right: 5px;"
                    @click="dynamicTagsPush(v[tagValue])">
        {{ v[tagKey] }}
      </el-tag>
    </div>
  </div>
</template>
<script>
  import _ from "lodash";

  export default {
    props: {
      tagKey: {
        type: String,
        default: "key"
      },
      tagValue: {
        type: String,
        default: "value"
      },
      setupTag: {
        type: Array,
        required: []
      },
      customize:{
        type: Boolean,
        required: false
      },
      value: {
        type: String,
        default: "[]"
      }
    },
    components: {},
    data() {
      return {
        inputVisible: false,
        inputValue: "",
      }
    },
    computed: {
      tags: {
        get() {
          return JSON.parse(this.value)
        },
        set(data) {
          this.$emit('input', JSON.stringify(data));
          return data
        },
      }
    },
    mounted() {
      if (this.value) {
        this.tags = JSON.parse(this.value);
      }
    },
    methods: {
      handleClose(tag) {
        let list = [];
        this.tags.forEach(item => {
          list.push(item)
        });
        list.splice(list.indexOf(tag), 1)
        this.tags = list
      },
      handleInputConfirm() {
        if (this.inputValue) {
          this.dynamicTagsPush(this.inputValue)
        }
        this.inputVisible = false
        this.inputValue = ''
      },
      dynamicTagsPush(tag){
        let list = [];
        this.tags.forEach(item => {
          list.push(item)
        });
        list.push(tag)
        this.tags = list
      },
      showInput(){
        this.inputVisible = true
        this.$nextTick(() => {
          this.$refs.inputRef.focus();
        })
      }
    }
  }
</script>
