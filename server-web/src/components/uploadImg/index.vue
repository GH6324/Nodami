<template>
  <div class="image-upload">
    <input
      type="file"
      ref="fileInput"
      accept="image/*"
      @change="handleFileChange"
      style="display: none"
    />
    <div class="el-badge item" v-if="!imagePath">
      <el-button size="mini" type="primary" @click="triggerUpload">上传<i class="el-icon-upload el-icon--right"></i></el-button>
      <sup v-if="size"
           class="el-badge__content el-badge__content--warning is-fixed"
           style="padding: 0px 6px 0px 6px;border-radius:5px 3px 5px 0px;height: auto;font-size:10px;right: 1px;top:-7px"
      >{{'图片限制大小比例 `'+size+'`'}}</sup>
    </div>

    <div v-if="imageUrl" class="image-preview">
      <img :src="imageUrl" :style="imageStyle" alt="Uploaded Image"/>
      <i class="el-icon-close image-close-icon" @click="triggerDelete"></i>
    </div>
  </div>
</template>

<script>
import { getToken } from "@/utils/auth";

export default {
  name: "uploadImg",
  props: {
    buttonText: {
      type: String,
      default: "点击上传图片",
    },
    size: {
      type: String,
      default: null, // 格式为 '100*160' 的字符串
    },
    value: {
      type: String,
      default: "",
    },
    imageStyle: {
      type: [Object, String],
      default: () => {
        return {
          "max-width": "300px",
          "max-height": "600px",
          "border-radius": "5px",
        };
      },
    },
  },
  data() {
    return {
      imageUrl: null, // 存储图片的本地预览URL
      imagePath: null, // 存储图片的本地预览URL
    };
  },
  watch: {
    value: {
      handler: function (val) {
        this.imagePath = val;
        this.setImageUrl();
      },
      deep: true,
    },
    imagePath: {
      handler: function (val) {
        this.setImageUrl();
        this.$emit("input", val);
      },
      deep: true,
    },
  },
  mounted() {
    this.imagePath = this.value;
    this.setImageUrl();
  },
  computed: {
    finalAspectRatio() {
      if (this.size) {
        const [width, height] = this.size.split("*").map(Number);
        if (width && height) {
          return width / height;
        }
        const [width2, height2] = this.size.split("x").map(Number);
        if (width2 && height2) {
          return width2 / height2;
        }
      }

      return null;
    },
  },
  methods: {
    setImageUrl() {
      if (this.imagePath) {
        this.imageUrl = this.apiUrl.replace(/\/$/, "") + "/" + this.imagePath.replace(/^\//, "");
      } else {
        this.imageUrl = undefined;
      }
    },
    triggerUpload() {
      this.$refs.fileInput.click();
    },
    handleFileChange(event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();

        reader.onload = (e) => {
          const img = new Image();
          img.onload = () => {
            const imgRatio = img.width / img.height;

            // 检查图片宽高比
            if (this.finalAspectRatio && imgRatio !== this.finalAspectRatio) {
              this.$message.error(`图片比例不符合要求，要求大小比例 ${this.size}`);
              return;
            }
            this.uploadImage(file);
          };
          img.src = e.target.result;
        };

        reader.readAsDataURL(file); // 读取图片并生成预览
      }
    },
    triggerDelete() {
      this.imageUrl = undefined;
      this.imagePath = undefined;
    },
    async uploadImage(file) {
      const formData = new FormData();
      formData.append("file", file); // 将文件添加到FormData中

      try {
        const response = await fetch(this.apiUrl + "/system/upload/upFile", {
          method: "POST",
          headers: {
            Authorization: `Bearer ${getToken()}`, // 添加 token 到请求头
          },
          body: formData,
        });

        const result = await response.json();

        if (result.code === 0) {
          this.imagePath = "/" + result.data.fileInfo.fileUrl;
        } else {
          this.$message.error(`上传失败 ${result.msg}`);
        }
      } catch (error) {
        this.$message.error(`未知错误 ${error.message}`);
      }
    },
  },
};
</script>

<style>
.image-upload{
  line-height: 0 ;
}
.image-preview {
  position: relative;
  display: inline-block;
  padding: 0;
  margin: 0;
  line-height: 0 ;
}
.image-close-icon {
  position: absolute;
  top: 50%; /* 垂直居中 */
  right: -25px; /* 向右偏移15px */
  transform: translate(0, -50%); /* 垂直平移，确保居中 */
  cursor: pointer;
  font-size: 11px;
  color: white; /* 图标颜色 */
  background: rgba(0, 0, 0, 0.3); /* 半透明黑色背景 */
  border-radius: 50%; /* 圆形背景 */
  padding: 3px;
  box-shadow: 0 0 3px rgba(0, 0, 0, 0.5); /* 增加阴影 */
}

.image-close-icon:hover {
  background: rgba(0, 0, 0, 0.5); /* 鼠标悬停时背景变深 */
}
</style>
