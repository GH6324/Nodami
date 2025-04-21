<template>
  <div>
    <BasicLayout>
      <template #wrapper>
        <el-row :gutter="10" class="mb10">
          <el-col :sm="8" :xs="24">
            <el-card class="stats-card" style="height: 600px">
              <serverInfo :serverId="serverId" :showSSH="false"></serverInfo>
            </el-card>
          </el-col>
          <el-col :sm="16" :xs="24">
            <el-card class="box-card" style="height: 600px;">
              <el-row>
                <el-col :span="15">
                  <el-radio-group v-model="logLabel" size="mini">
                    <el-radio-button label="安装日志"></el-radio-button>
                    <el-radio-button label="命令终端"></el-radio-button>
                  </el-radio-group>
                </el-col>
              </el-row>
              <div style="background: rgb(0,0,0,0);height: 10px;"></div>
              <div class="terminal-container">
                <chatLog   v-show="serverId && logLabel!=='命令终端'"  :server-id="serverId" :logLabel="logLabel"/>
                <terminal  v-show="serverId && logLabel==='命令终端'"  :serverId="serverId" :show="serverId && logLabel==='命令终端'"/>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </template>
    </BasicLayout>
  </div>
</template>

<script>
import BasicLayout from '@/layout/BasicLayout'
import Cell from '@/components/Cell/index'
import chatLog from '@/components/chatLog'
import terminal from "@/components/Terminal/index.vue";
import ResourceProgress from '@/components/ResourceProgress'
import serverInfo from "@/components/serverInfo/index.vue";


export default {
  name: 'Monitor',
  components: {serverInfo, BasicLayout, Cell, chatLog, terminal, ResourceProgress},
  props: {
    serverId: {
      type: Number,
      required: 0
    },
    isPppoe: {
      type: Number,
      required: 0
    },
  },
  data() {
    return {
      logLabel: "安装日志",
    }
  },
  mounted() {
  },
  methods: {}
}
</script>

<style lang="scss" scoped>

.terminal-container {
  flex: 1;
  height: 100%; // ✅ 明确撑开
  overflow: auto;
}

// 终端日志容器优化
.box-card {
  display: flex;
  flex-direction: column;

  ::v-deep .el-card__body {
    position: relative;
    display: flex;
    flex-direction: column;
    flex: 1;
  }
}


</style>
