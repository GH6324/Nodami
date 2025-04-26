<template>
  <el-dialog
    :title="title"
    :visible.sync="visibleProp"
    width="420px"
    class="qr-dialog"
    append-to-body
    :close-on-click-modal="false"
  >
    <div class="qr-wrapper">
      <!-- ✅ 直接渲染二维码，不写 render() 了 -->
      <qrcode-vue :text="qrString" :size="200" level="H" />

      <el-input
        class="qr-text"
        :value="qrString"
        readonly size="mini"
        @focus="$event.target.select()"
      />

      <div class="qr-actions">
        <el-button size="mini" icon="el-icon-document-copy" @click="copy">复制内容</el-button>
        <el-tooltip effect="dark" content="可直接扫码导入" placement="top">
          <el-tag type="success" size="mini">扫一扫</el-tag>
        </el-tooltip>
      </div>
    </div>
  </el-dialog>
</template>

<script>
import { generateProxyQRCodeData } from '@/utils/generateProxyQRCodeData'
import QrcodeVue from 'vue-qrcode-component'

export default {
  name: 'QrCodeDialog',
  components: { QrcodeVue },        // 👈 注册组件

  props: {
    visible: { type: Boolean, required: true },
    proxie:  { type: Object,  required: false },
    title:   { type: String,  default: '节点二维码' }
  },

  data () {
    return { qrString: '----' }
  },

  computed: {
    visibleProp: {
      get () { return this.visible },
      set (v) { this.$emit('update:visible', v) }
    }
  },

  watch: {
    proxie (val) {
      if (!val) return
      try {
        this.qrString = generateProxyQRCodeData(val)
      } catch (e) {
        console.error(e)
        this.qrString = '生成失败'
      }
    }
  },

  methods: {
    copy () {
      navigator.clipboard.writeText(this.qrString).then(() => {
        this.$message.success('已复制')
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.qr-dialog >>> .el-dialog__body { padding: 24px 32px 16px; }
.qr-wrapper { display: flex; flex-direction: column; align-items: center; gap: 12px; }
.qr-text    { width: 100%; font-family: 'JetBrains Mono', monospace; }
.qr-actions { display: flex; gap: 8px; align-items: center; }
</style>
