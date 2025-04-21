<template>
  <div class="slide-dialog-overlay" @click.self="closeDialog">
    <div class="slide-dialog-wrapper">
      <div class="slide-dialog-close" @click="closeDialog">
        <span class="close-icon">》</span> <!-- 使用 Emoji 作为关闭按钮 -->
      </div>
      <div class="slide-dialog-content">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SlideDialog',
  props: {
    visible: {
      type: Boolean,
      default: true,  // 默认显示
    }
  },
  methods: {
    closeDialog() {
      this.$emit('update:visible', false);  // 关闭按钮
    }
  }
}
</script>

<style scoped>
.slide-dialog-overlay {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background: rgb(0,0,0,0.5);
  display: flex;
  justify-content: flex-end;
  align-items: center;
  z-index: 1000;
}

.slide-dialog-wrapper {
  position: relative;
  height: 100%;
  background: rgb(255,255,255,1);
  box-shadow: -2px 0 10px rgba(0, 0, 0, 0.2);
  transform: translateX(0); /* 保持固定显示 */
  transition: transform 0.3s ease-in-out;
  display: flex;
}

.slide-dialog-content {
  padding: 20px;
  overflow-y: auto;
  height: 100%;
}

.slide-dialog-close {
  width: 20px;
  display: flex;
  align-items: center;
  padding-left: 5px;
}

/* 鼠标悬浮时按钮稍微放大并保持居中 */
.slide-dialog-close:hover {
  transform: scale(1.1); /* 放大按钮 */
  transform-origin: center; /* 放大基准点设为居中 */
}

.close-icon {
  font-size: 25px; /* 设置合适的大小 */
  color: #333; /* 设置颜色 */
}
</style>
