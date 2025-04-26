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
      <canvas ref="qrCanvas" class="qrcode-box"></canvas>

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
import QRCode from 'qrcode'
import logo from '@/assets/logo/logo3.png'
import { generateProxyQRCodeData } from '@/utils/generateProxyQRCodeData'

export default {
  name: 'QrCodeDialog',

  props: {
    visible: { type: Boolean, required: true },
    proxie:  { type: Object,  required: false },
    title:   { type: String,  default: '节点二维码' }
  },

  data () {
    return {
      qrString: '----',
      logo,
      logoSize: 45, // 调整后的合理尺寸
      logoBackgroundColor: "rgba(245,245,245,0.95)",
      logoBorder: {
        width: 2,
        color: 'rgba(0,0,0,0.08)'
      },
      logoShadow: 'rgba(0,0,0,0.12)'
    }
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
        this.$nextTick(() => {
          this.renderQrCode()
        })
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
    },
    async renderQrCode () {
      const canvas = this.$refs.qrCanvas
      const ctx = canvas.getContext('2d')
      const size = 200
      canvas.width = size
      canvas.height = size

      // 生成二维码数据
      const qrData = await QRCode.create(this.qrString, {
        errorCorrectionLevel: 'H'
      })

      const cells = qrData.modules
      const cellSize = size / cells.size
      const margin = 0

      const logoSize = this.logoSize
      const logoArea = {
        x: (size - logoSize) / 2,
        y: (size - logoSize) / 2,
        size: logoSize
      }

      // 清空画布
      ctx.fillStyle = '#ffffff'
      ctx.fillRect(0, 0, size, size)

      ctx.fillStyle = '#000000'
      // 遍历每个点
      for (let r = 0; r < cells.size; r++) {
        for (let c = 0; c < cells.size; c++) {
          if (cells.get(c, r)) {
            const x = c * cellSize
            const y = r * cellSize

            // 判断是否在logo区域
            if (
              x + cellSize > logoArea.x &&
              x < logoArea.x + logoArea.size &&
              y + cellSize > logoArea.y &&
              y < logoArea.y + logoArea.size
            ) {
              continue
            }

            ctx.fillRect(
              Math.round(x + margin),
              Math.round(y + margin),
              Math.ceil(cellSize),
              Math.ceil(cellSize)
            )
          }
        }
      }

      // 抗锯齿处理
      ctx.imageSmoothingEnabled = true
      ctx.imageSmoothingQuality = 'high'

      // 画logo背景（带阴影）
      if (this.logoBackgroundColor !== 'transparent') {
        const radius = 5
        ctx.shadowColor = this.logoShadow
        ctx.shadowBlur = 6
        ctx.shadowOffsetY = 2
        ctx.globalAlpha = 0.9
        ctx.fillStyle = this.logoBackgroundColor
        this.drawRoundRect(ctx, logoArea.x - 4, logoArea.y - 4, logoArea.size + 8, logoArea.size + 8, radius)
        ctx.globalAlpha = 1.0
        ctx.shadowColor = 'transparent'
      }

      // 画logo边框
      ctx.strokeStyle = this.logoBorder.color
      ctx.lineWidth = this.logoBorder.width
      this.drawRoundRect(ctx, logoArea.x - 2, logoArea.y - 2, logoArea.size + 4, logoArea.size + 4, 6)
      ctx.stroke()

      // 画logo（带内边距和圆角）
      const padding = 4
      const logoImg = new Image()
      logoImg.src = this.logo
      logoImg.onload = () => {
        ctx.save()
        ctx.beginPath()
        const imgRadius = 0
        this.drawRoundRect(ctx,
          logoArea.x + padding,
          logoArea.y + padding,
          logoArea.size - padding*2,
          logoArea.size - padding*2,
          imgRadius
        )
        ctx.clip()
        ctx.drawImage(
          logoImg,
          logoArea.x + padding,
          logoArea.y + padding,
          logoArea.size - padding*2,
          logoArea.size - padding*2
        )
        ctx.restore()
      }
    },
    drawRoundRect(ctx, x, y, w, h, r) {
      ctx.beginPath()
      ctx.moveTo(x + r, y)
      ctx.lineTo(x + w - r, y)
      ctx.quadraticCurveTo(x + w, y, x + w, y + r)
      ctx.lineTo(x + w, y + h - r)
      ctx.quadraticCurveTo(x + w, y + h, x + w - r, y + h)
      ctx.lineTo(x + r, y + h)
      ctx.quadraticCurveTo(x, y + h, x, y + h - r)
      ctx.lineTo(x, y + r)
      ctx.quadraticCurveTo(x, y, x + r, y)
      ctx.closePath()
      ctx.fill()
    }
  }
}
</script>

<style lang="scss" scoped>
.qr-dialog >>> .el-dialog__body { padding: 24px 32px 16px; }
.qr-wrapper { display: flex; flex-direction: column; align-items: center; gap: 12px; }
.qr-text    { width: 100%; font-family: 'JetBrains Mono', monospace; }
.qr-actions { display: flex; gap: 8px; align-items: center; }

.qrcode-box {
  width: 200px;
  height: 200px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  border-radius: 5px;
  overflow: hidden;
}
</style>
