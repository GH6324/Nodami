#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
set -euo pipefail
IFS=$'\n\t'

### ========= 常量 ========= ###
AGENT_DIR="$PWD/vlink_new"
CONFIG_DIR="$AGENT_DIR/config"
CONFIG_FILE="$CONFIG_DIR/settings.yml"
TEMP_DIR="$AGENT_DIR/temp"

ZIP_NAME="agent_sing_box.zip?v1.0.4"
ZIP_PATH="$PWD/$ZIP_NAME"

IMAGE_NAME="vlink_agent"
IMAGE_TAG="latest"
CONTAINER="$IMAGE_NAME"            # 容器同名

DOWNLOAD_ROOT="{{agent_api}}/down"   # ← 模板占位
DOWNLOAD_URL="$DOWNLOAD_ROOT/$ZIP_NAME"

PKG_LIST=(curl wget tar lsof systemd)
DNS_ARRAY=( {{dnsServers}} )         # ← 模板占位，空也没问题


PKG_MGR=""
if command -v apt-get &>/dev/null; then
  PKG_MGR="apt-get"
elif command -v yum &>/dev/null; then
  PKG_MGR="yum"
elif command -v dnf &>/dev/null; then
  PKG_MGR="dnf"
else
  echo -e "\e[31m无法识别系统包管理器，脚本终止。\e[0m"
  exit 1
fi


### ========= 彩色输出 ========= ###
cecho() {
  local color=$1; shift
  local msg=$*
  local code
  case $color in
    red) code=31 ;; green) code=32 ;; yellow) code=33 ;;
    blue) code=34 ;; purple) code=35 ;; skyBlue) code=36 ;; white) code=37 ;;
    *) code=0 ;;
  esac
  echo -e "\e[${code}m${msg}\e[0m"
}

### ========= 基础工具 ========= ###
need_root() { [ "$(id -u)" -eq 0 ] || { cecho red "请用 root 运行脚本"; exit 1; }; }



install_pkgs() {
  # ---------- 装缺失工具 ----------
  for p in "${PKG_LIST[@]}"; do
    command -v "$p" &>/dev/null && continue
    cecho skyBlue "安装 $p"
    $PKG_MGR install -y "$p"
  done
}



### ========= 中国网络判定 ========= ###
is_in_china() {
  curl -fsSL https://ipinfo.io/country 2>/dev/null | grep -q '^CN' && return 0
  curl -m5 -s https://www.google.com &>/dev/null && return 1 || return 0
}

### ========= mirrors 占位（可自行实现替换源） ========= ###
apply_mirrors_once() {
  # 如需换镜像源，在此实现；默认不做任何事，防止脚本报未定义
  return 0
}

### ========= 快速更新 ========= ###
quick_update() {
  cecho green "检测到 $CONTAINER 已存在，执行快速更新..."
  download_agent_zip
  write_agent_config
  run_container
  cecho green "配置已刷新并重启完成"
  exit 0
}

### ========= 下载 & 解压 ========= ###
download_agent_zip() {
  command -v unzip &>/dev/null || {
    cecho skyBlue "安装 unzip"
    $PKG_MGR install -y unzip
  }

  # -- ① 如果已存在同名 zip 且解压目录有效，直接返回 --------------------------
  if [[ -f $ZIP_PATH && -x $AGENT_DIR/agent ]]; then
      # 简单完整性校验：文件 ≥ 1M 并且 unzip -tq 正常
      if [[ $(stat -c%s "$ZIP_PATH") -ge 1048576 ]] && unzip -tq "$ZIP_PATH" &>/dev/null; then
          cecho skyBlue "已存在当前版本，且 zip 校验通过，跳过下载"
          return
      else
          cecho yellow "检测到 zip 不完整或损坏，重新下载..."
          rm -f "$ZIP_PATH"
      fi
  fi

  # -- ② 清理旧 zip ----------------------------------------------------------
  find "$PWD" -maxdepth 1 -type f -name 'agent_sing_box.zip?*' \
       ! -name "$(basename "$ZIP_PATH")" -delete

  # -- ③ 下载到临时文件 ------------------------------------------------------
  tmp="${ZIP_PATH}.tmp"
  rm -f "$tmp"

  cecho skyBlue "开始下载 $ZIP_NAME ..."
  # 你也可以换成 curl -C - ；这里用 wget 带断点续传
  if ! wget -c --timeout=60 --tries=10 -O "$tmp" "$DOWNLOAD_URL"; then
      cecho red "下载失败"
      rm -f "$tmp"
      exit 1
  fi

  # -- ④ 校验临时文件 --------------------------------------------------------
  if [[ $(stat -c%s "$tmp") -lt 1048576 ]] || ! unzip -tq "$tmp" &>/dev/null; then
      cecho red "下载文件损坏，请重试"
      rm -f "$tmp"
      exit 1
  fi

  mv -f "$tmp" "$ZIP_PATH"
  cecho green "下载完成"

  # -- ⑤ 解压 ---------------------------------------------------------------
  cecho skyBlue "解压到 $AGENT_DIR ..."
  unzip -qo "$ZIP_PATH" -d "$PWD"
  chmod +x "$AGENT_DIR/agent"
}



### ========= 写配置 ========= ###
write_agent_config() {
  mkdir -p "$CONFIG_DIR" "$TEMP_DIR"
cat > "$CONFIG_FILE" <<'EOF'
settings:
  logLevel: info
  serverId: {{settings.serverId}}
  serverApiUrl: {{settings.serverApiUrl}}
  mqttServer: {{settings.mqttServer}}
  mqttUser: {{settings.mqttUser}}
  mqttPass: {{settings.mqttPass}}
  mqttPort: {{settings.mqttPort}}
#  agentLogFile: ./temp/agent.log
  authorizedCode: b97c8f99-480f-4651-b706-5db648c10a53
  logShield: wifi.vivo.com.cn,www.gstatic.cn
  commonUuid: {{xrayCommon.commonUuid}}
  generatePort: 2061
  grpcPort: 1703

hysteriaCommon:
  serverPort: 2062
  proxyUrl: https://www.baidu.com
  hysteriaCore: false

singBoxCommon:
#  logFile: ./temp/singBox.log
  logLevel: info
  hysteria2CommonPort: 2063
  apiPort: 2703

frpCommon:
  startFrps: {{frpCommon.startFrps}}
#  frpcLogFile: ./temp/frpc.log
#  frpsLogFile: ./temp/frps.log
  tcpMux: true
  logLevel: info
  frpToken: 1wwewxz
  frpTls: false
  bindPort: 2700
  kcpBindPort: 2701
  quicBindPort: 2702
  useEncryption: true
  maxIncomingStreams: 10240000
  udpPacketSize: 10240000

peality:
  shortIds: {{peality.shortIds}}
  private: {{peality.private}}
  public: {{peality.public}}
EOF
}


# 使用华为镜像源安装 Docker
install_with_huawei_mirror() {
    cecho skyBlue " curl -sSL https://linuxmirrors.cn/docker.sh -o /tmp/docker_install.sh"
    curl -sSL https://linuxmirrors.cn/docker.sh -o /tmp/docker_install.sh
    cecho skyBlue "sudo bash /tmp/docker_install.sh --source repo.huaweicloud.com/docker-ce --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true --protocol http"
    sudo bash /tmp/docker_install.sh --source repo.huaweicloud.com/docker-ce --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true --protocol http
    if docker -v &>/dev/null; then
        return 0
    else
        return 1
    fi
}

install_with_huawei_mirror2() {
    cecho skyBlue " curl -sSL {{server.docker}} -o /tmp/docker_install.sh"
    curl -sSL {{server.docker}} -o /tmp/docker_install.sh
    cecho skyBlue "sudo bash /tmp/docker_install.sh --source repo.huaweicloud.com/docker-ce --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true --protocol http"
    sudo bash /tmp/docker_install.sh --source repo.huaweicloud.com/docker-ce --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true --protocol http
    if docker -v &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# 使用 get.docker.com 安装 Docker
install_with_get_docker() {
    cecho skyBlue "curl -fsSL https://get.docker.com -o /tmp/get_docker.sh"
    curl -fsSL https://get.docker.com -o /tmp/get_docker.sh
    sudo bash /tmp/get_docker.sh
    if docker -v &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# 使用阿里云镜像源安装 Docker
install_with_aliyun_mirror() {
    cecho skyBlue "curl -fsSL https://get.docker.com -o /tmp/get_docker_aliyun.sh"
    curl -fsSL https://get.docker.com -o /tmp/get_docker_aliyun.sh
    sudo bash /tmp/get_docker_aliyun.sh --mirror Aliyun
    if docker -v &>/dev/null; then
        return 0
    else
        return 1
    fi
}

install_ipv6_mirror() {
    cecho skyBlue "curl -6 -fsSL https://get.docker.com | sh"
    curl -6 -fsSL https://get.docker.com | sh
    if docker -v &>/dev/null; then
        return 0
    else
        return 1
    fi
}



install_docker() {
      # 尝试多个安装方式
      if ! install_with_huawei_mirror && ! install_with_huawei_mirror2 && ! install_with_get_docker && ! install_with_aliyun_mirror && ! install_ipv6_mirror; then
          # 如果所有方法都失败，则退出脚本
          cecho red "Docker 安装失败，脚本终止！请尝试手动安装docker"
          exit 1
      fi
}

ensure_docker() {
  command -v docker &>/dev/null && {
    systemctl is-active --quiet docker || { systemctl enable docker; systemctl restart docker; }
    return
  }

  cecho green "安装 Docker..."
  systemctl stop firewalld.service &>/dev/null || true
  systemctl disable firewalld.service &>/dev/null || true

  command -v docker &>/dev/null || install_docker

  command -v docker &>/dev/null || { cecho red "Docker 安装失败"; exit 1; }

  iptables -A INPUT -p tcp --dport 10000:60000 -j ACCEPT
  iptables -A INPUT -p udp --dport 10000:60000 -j ACCEPT
  timedatectl set-timezone Asia/Shanghai
  systemctl enable docker
  systemctl restart docker
}

### ========= 构建 / 运行容器 ========= ###
build_image() {
  cd "$AGENT_DIR"
  docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^${IMAGE_NAME}:${IMAGE_TAG}$" && return
  docker load -i ./alpine_latest.tar
  docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .
}

run_container() {
  docker stop "$CONTAINER" &>/dev/null || true
  docker rm   "$CONTAINER" &>/dev/null || true

  docker run -d --name "$CONTAINER" \
    -e TZ=Asia/Shanghai \
    --restart always \
    --network host \
    -v "$AGENT_DIR":/app \
    --log-driver json-file \
    --log-opt max-size=5m \
    --log-opt max-file=3 \
    "${IMAGE_NAME}:${IMAGE_TAG}"
}

### ========= 系统调优 ========= ###
enable_bbr() {
  local need=5.5 cur
  cur=$(uname -r | cut -d- -f1)
  [[ "$(printf '%s\n' "$need" "$cur" | sort -V | head -n1)" != "$need" ]] && return
  lsmod | grep -q bbr && return
  cecho skyBlue "启用 BBR"
  echo -e "net.core.default_qdisc=fq\nnet.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
  sysctl -p
}



ensure_swap() {
  [[ $(free | awk '/Swap/{print $2}') -gt 0 ]] && return
  cecho skyBlue "创建 1G swap"
  fallocate -l 1G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap sw 0 0' >> /etc/fstab
  sysctl vm.swappiness=80
}

### ========= main ========= ###
main() {
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

  # ------------ 快速路径 ------------
  if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER}$" &&
     docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^${IMAGE_NAME}:${IMAGE_TAG}$"; then
    quick_update
  fi

  # ------------ 全量安装 ------------
  install_pkgs
  is_in_china && apply_mirrors_once
  enable_bbr
  ensure_docker
  ensure_swap
  download_agent_zip
  write_agent_config
  build_image
  run_container
  cecho green "agent安装完成。"
}

main "$@"
