<template>
  <SlideDialog v-if="dialogVisibleProp" :visible.sync="dialogVisibleProp" >
    <div class="MainContainer" ref="MainContainer" >
      <el-row>
        <el-col :span="24">
          <el-button-group>
            <el-button type="primary" size="mini" icon="el-icon-arrow-up" @click="upDirectory()"></el-button>
            <el-button type="primary" size="mini" icon="el-icon-refresh" @click="getFileList()"></el-button>
            <el-dropdown @click="openUploadDialog()" @command="handleUploadCommand">
              <el-button type="primary" size="mini" icon="el-icon-upload"></el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="file">上传文件</el-dropdown-item>
                <el-dropdown-item command="folder">上传文件夹</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </el-button-group>
          <el-dialog custom-class="uploadContainer" :title="this.titleTip" :visible.sync="uploadVisible" append-to-body :width="uploadWidth">
            <el-upload ref="upload" multiple drag :action="uploadUrl" :data="uploadData"
                       :before-upload="beforeUpload" :on-progress="uploadProgress"
                       :on-success="uploadSuccess">
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">{{ this.selectTip }}</div>
              <div class="el-upload__tip" slot="tip">{{ this.uploadTip }}</div>
            </el-upload>
          </el-dialog>
        </el-col>
      </el-row>
      <el-table v-if="show" :data="fileList" :height="clientHeight" @row-click="rowClick" class="custom-table">
        <el-table-column label="名字" :width="nameWidth" sortable :sort-method="nameSort" show-overflow-tooltip>
          <template slot-scope="scope">
            <p v-if="scope.row.IsDir === true" style="color:#0c60b5;cursor:pointer;" class="el-icon-folder"> {{ scope.row.Name }}</p>
            <p v-else-if="scope.row.IsDir === false" style="cursor: pointer" class="el-icon-document">{{ scope.row.Name }}</p>
          </template>
        </el-table-column>
        <el-table-column label="大小" prop="Size" sortable show-overflow-tooltip></el-table-column>
        <el-table-column label="修改" prop="ModifyTime" sortable show-overflow-tooltip></el-table-column>
      </el-table>
    </div>
  </SlideDialog>
</template>

<script>

import SlideDialog from "./SlideDialog.vue";
import request from "./common";

export default {
  name: 'FileList',
  components: {SlideDialog},
  props: {
    serverId: {
      type: Number,
      required: 0
    },
    dialogVisible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      uploadVisible: false,
      fileList: [],
      downloadFilePath: '',
      currentPath: '',
      pathSpan: 18,
      clientHeight: "50px",
      selectTip: '点击选择文件',
      titleTip: '上传文件',
      uploadTip: '',
      uploadWidth: '350px',
      nameWidth: 260,
      progressPercent: 0,
      show: true
    }
  },
  created() {
  },
  mounted() {
    this.resizeDialog()
    this.getFileList()
    window.addEventListener('resize', this.resizeDialog)
  },
  beforeDestroy() {
    console.log("beforeDestroy")
    window.removeEventListener('resize', this.resizeDialog)
  },
  computed: {
    dialogVisibleProp: {
      get() {
        return this.dialogVisible
      },
      set(value) {
        this.$emit('update:dialogVisible', value)
      }
    },
    uploadUrl: () => {
      return `/terminal/file/upload`
    },
    uploadData: function () {
      return {
        serverId: this.serverId,
        path: this.currentPath
      }
    }
  },

  watch: {
    currentTab: function () {
      this.fileList = []
      this.currentPath = this.currentTab && this.currentTab.path
    }
  },
  methods: {
    resizeDialog() {
      this.show = false;
      this.clientHeight = this.$refs.MainContainer.clientHeight - 30
      const clientWidth =  this.$refs.MainContainer.clientWidth
      this.pathSpan = 18
      if (clientWidth < 600) {
        this.nameWidth = 120
        this.pathSpan = 16
      } else if (clientWidth >= 600 && clientWidth < 1000) {
        this.nameWidth = 220
      } else {
        this.nameWidth = 260
      }
      this.uploadWidth = clientWidth+ "px"
      this.clientHeight = this.clientHeight + "px"
      console.log(this.clientHeight)
      this.$nextTick(()=>{
        this.show = true;
      })


    },
    openUploadDialog() {
      this.uploadTip = `当前上传目录: ${this.currentPath}`
      this.uploadVisible = true
    },
    handleUploadCommand(cmd) {
      if (cmd === 'folder') {
        this.selectTip = '点击选择文件夹'
        this.titleTip = '上传文件夹'
      } else {
        this.selectTip = '点击选择文件'
        this.titleTip = '上传文件'
      }
      this.openUploadDialog();
      const isFolder = 'folder' === cmd,
        supported = this.webkitdirectorySupported();
      if (!supported) {
        isFolder && this.$message.warning('当前浏览器不支持');
        return;
      }
      // 添加文件夹
      this.$nextTick(() => {
        const input = document.getElementsByClassName('el-upload__input')[0];
        if (input) input.webkitdirectory = isFolder;
      })
    },
    webkitdirectorySupported() {
      return 'webkitdirectory' in document.createElement('input')
    },
    beforeUpload(file) {
      this.uploadTip = `正在上传 ${file.name} 到 ${this.currentPath}, 请勿关闭窗口..`
      this.uploadData.id = file.uid
      // 是否有文件夹
      const dirPath = file.webkitRelativePath;
      this.uploadData.dir = dirPath ? dirPath.substring(0, dirPath.lastIndexOf('/')) : '';
      return true
    },
    uploadSuccess(r, file) {
      this.uploadTip = `${file.name}上传完成!`
    },
    uploadProgress(e, f) {
      e.percent = e.percent / 2
      f.percentage = f.percentage / 2
      if (e.percent === 50) {
        const ws = new WebSocket(`${(location.protocol === 'http:' ? 'ws' : 'wss')}://${location.host}/terminal/file/progress?id=${f.uid}`)
        ws.onmessage = e1 => {
          f.percentage = (f.size + Number(e1.data)) / (f.size * 2) * 100
        }
        ws.onclose = () => {
          console.log(Date(), 'onclose')
        }
        ws.onerror = () => {
          console.log(Date(), 'onerror')
        }
      }
    },
    nameSort(a, b) {
      return a.Name > b.Name
    },
    rowClick(row) {
      if (row.IsDir) {
        // 文件夹处理
        this.currentPath = this.currentPath.charAt(this.currentPath.length - 1) === '/' ? this.currentPath + row.Name : this.currentPath + '/' + row.Name
        this.getFileList()
      } else {
        // 文件处理
        this.downloadFilePath = this.currentPath.charAt(this.currentPath.length - 1) === '/' ? this.currentPath + row.Name : this.currentPath + '/' + row.Name
        this.downloadFile()
      }
    },
    async getFileList() {
      this.currentPath = this.currentPath.replace(/\/+/g, '/')
      if (this.currentPath === '') {
        this.currentPath = '/'
      }
      const result = await request.get(`/terminal/file/list?path=${this.currentPath}&serverId=${this.serverId}`)
      if (result.msg === 'success') {
        if (result.data.list === null) {
          this.fileList = []
        } else {
          this.fileList = result.data.list
        }

      } else {
        this.fileList = []
        this.$message.error(result.msg)

      }
    },
    upDirectory() {
      if (this.currentPath === '/') {
        return
      }
      let pathList = this.currentPath.split('/')
      if (pathList[pathList.length - 1] === '') {
        pathList = pathList.slice(0, pathList.length - 2)
      } else {
        pathList = pathList.slice(0, pathList.length - 1)
      }
      this.currentPath = pathList.length === 1 ? '/' : pathList.join('/')
      this.getFileList()
    },
    downloadFile() {
      const downloadUrl = `/terminal/file/download?path=${this.downloadFilePath}&serverId=${this.serverId}`
      window.open(downloadUrl)
    },
  }
}
</script>

<style lang="scss">
.MainContainer {
  position: relative;
  height: 100%;
  min-width:  400px;
  .el-dialog__wrapper {
    overflow: hidden;
  }

  .el-input__inner {
    border: 0 none;
    border-bottom: 1px solid #ccc;
    border-radius: 0px;
    width: 80%;
  }

  .el-table--border tr, td {
    border: none !important;
  }

  .el-table::before {
    height: 0;
  }

  .el-table td, .el-table th {
    padding: 2px 0;
  }

  .el-dropdown {
    display: flex;
  }
}

.uploadContainer {
  .el-upload {
    display: flex;
  }

  .el-upload-dragger {
    width: 95%;
  }
}

.custom-table .el-table__row {
  height: 1px;
  line-height: 1px;
}

.custom-table .el-table__cell {
  padding: 1px;
}
</style>
