#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

AgentPath="$PWD/vlink_new"


echo_content() {

  ECHO_TYPE="echo -e"
  case $1 in
  "red")
    ${ECHO_TYPE} "\033[31m$2\033[0m"
    ;;
  "green")
    ${ECHO_TYPE} "\033[32m$2\033[0m"
    ;;
  "yellow")
    ${ECHO_TYPE} "\033[33m$2\033[0m"
    ;;
  "blue")
    ${ECHO_TYPE} "\033[34m$2\033[0m"
    ;;
  "purple")
    ${ECHO_TYPE} "\033[35m$2\033[0m"
    ;;
  "skyBlue")
    ${ECHO_TYPE} "\033[36m$2\033[0m"
    ;;
  "white")
    ${ECHO_TYPE} "\033[37m$2\033[0m"
    ;;
  esac
}

setDNS(){
  # 定义 DNS 服务器数组，可以根据需要添加更多的 DNS 服务器
  echo "旧的的 DNS 设置为："
  cat /etc/resolv.conf


  dnsServers=({{dnsServers}})
  # 检查是否有写入 /etc/resolv.conf 的权限
  if [ "$(id -u)" -ne 0 ]; then
    echo "请使用 root 用户或使用 sudo 运行此脚本"
    exit 1
  fi

  if [ ${#dnsServers[@]} -eq 0 ]; then
    echo "DNS 服务器数组为空，跳过 DNS 配置更新。"
  else
    # 备份当前的 /etc/resolv.conf 文件
    cp /etc/resolv.conf /etc/resolv.conf.backup

    # 清空 /etc/resolv.conf 文件
    > /etc/resolv.conf

    # 写入新的 DNS 配置到 /etc/resolv.conf
    for dns in "${dnsServers[@]}"; do
      echo "nameserver $dns" >> /etc/resolv.conf
    done

    # 确保 /etc/resolv.conf 文件是可写的，以防止网络管理工具覆盖
    # chattr +i /etc/resolv.conf

    # 提示用户操作成功
    #echo "DNS 配置已更新，并已锁定 /etc/resolv.conf 防止覆盖。"
    echo "新的 DNS 设置为："
    cat /etc/resolv.conf
  fi
}

downAgent() {
  AGETN_NAME="agent_sing_box.zip?v1.0.1.1"
  ZIP_FILE="$PWD/$AGETN_NAME"
  ZIP_FILE_BASE=$(basename "$ZIP_FILE")
  find "$PWD" -maxdepth 1 -type f \( -name "*.zip*" -o -name "*.zip?*" \) ! -name "$ZIP_FILE_BASE" -exec rm -f {} \;

  DOWNLOAD_URL="{{agent_api}}/down/$AGETN_NAME"

  # 检查是否已安装 zip
  if command -v unzip &> /dev/null; then
      echo_content skyBlue "unzip is installed."
  else
      # 如果未安装 zip，则尝试安装
      echo_content skyBlue "unzip is not installed. Installing..."
      $isSudo ${package_manager} update
      $isSudo ${package_manager} install -y unzip
      if [ $? -eq 0 ]; then
          echo_content skyBlue "unzip installed successfully."
      else
          echo_content red "Failed to install unzip. Exiting."
          exit 1
      fi
  fi



  # 判断 unzip 文件是否存在
  if [ ! -f "$ZIP_FILE" ]; then
      # 如果不存在则下载
      wget --timeout=60 --tries=10 "$DOWNLOAD_URL" -O "$PWD/agent.zip.temp"

      # 检查下载是否成功
      if [ $? -eq 0 ]; then
          mv "$PWD/agent.zip.temp" "$ZIP_FILE"

          echo_content skyBlue "Download successful."
          rm -rf "$AgentPath"
          # 解压覆盖
          unzip -o "$ZIP_FILE" -d "$PWD"
          chmod +x "$AgentPath/agent"
          echo_content skyBlue "Unzip and overwrite successful."
      else
          rm -rf $ZIP_FILE
          echo_content red "Download failed. $DOWNLOAD_URL"
          exit 1
      fi
  else
      echo_content skyBlue "Zip file already exists. No need to download."
      rm -rf "$AgentPath"
      if [ ! -f "$AgentPath/agent" ]; then
          unzip -o "$ZIP_FILE" -d "$PWD"
          chmod +x "$AgentPath/agent"
      fi
  fi


}

isInChina() {
    # 获取公网 IP 地址
    ip=$(curl -s https://ipinfo.io/ip)

    if [ -z "$ip" ]; then
        echo_content red "无法获取公网 IP 地址，尝试其他方法判断。"
    else
        # 查询 IP 地址信息
        country=$(curl -s https://ipinfo.io/$ip/country)

        if [ -z "$country" ]; then
            echo_content red "无法获取 IP 地址所在国家，尝试其他方法判断。"
        else
            # 判断是否是中国 IP 地址
            if [ "$country" = "CN" ]; then
                echo_content skyBlue "在中国境内。"
                return 0    # 返回 0 表示成功，即在中国境内
            else
                echo_content skyBlue "不在中国境内。"
                return 1    # 返回非 0 表示失败，即不在中国境内
            fi
        fi
    fi

    # 如果 IP 地址获取或查询失败，尝试访问 Google 来判断
    if curl -s --connect-timeout 5 https://www.google.com > /dev/null; then
        echo_content skyBlue "能够访问 Google，不在中国境内。"
        return 1    # 返回非 0 表示失败，即不在中国境内
    else
        echo_content skyBlue "无法访问 Google，可能在中国境内。"
        return 0    # 返回 0 表示成功，即在中国境内
    fi
}

install_docker_china(){

  echo_content skyBlue "---> bash <({{server.docker}})  --source mirrors.aliyun.com/docker-ce  --source-registry registry.cn-hangzhou.aliyuncs.com --ignore-backup-tips --install-latested true"
  $isSudo bash <({{server.docker}})  --source mirrors.aliyun.com/docker-ce  --source-registry registry.cn-hangzhou.aliyuncs.com --ignore-backup-tips --install-latested true

  if ! [[ $(docker -v 2>/dev/null) ]]; then
    export DOWNLOAD_URL="https://mirrors.tuna.tsinghua.edu.cn/docker-ce"
    echo_content skyBlue "---> sh <(curl -fsSL https://get.docker.com/ | sudo -E sh)"
    $isSudo sh <(curl -fsSL https://get.docker.com/ | sudo -E sh)
  fi
}

install_docker_common(){
    echo_content skyBlue "---> sh <(curl -sL https://get.docker.com)"
    $isSudo sh <(curl -sL https://get.docker.com)

    if ! [[ $(docker -v 2>/dev/null) ]]; then
           echo_content skyBlue "---> curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -"
           $isSudo curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
    fi

    if ! [[ $(docker -v 2>/dev/null) ]]; then
           echo_content skyBlue "---> curl -sSL https://get.daocloud.io/docker | sh"
           $isSudo curl -sSL https://get.daocloud.io/docker | sh
    fi

    if ! [[ $(docker -v 2>/dev/null) ]]; then
      echo_content skyBlue "---> bash <({{server.docker}})  --source repo.huaweicloud.com/docker-ce  --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true"
      $isSudo bash <({{server.docker}})  --source repo.huaweicloud.com/docker-ce  --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true
    fi
}

install_docker() {
  downAgent
  echo_content skyBlue "---> install_docker"

  if [[ ! $(docker -v 2>/dev/null) ]]; then
    echo_content green "---> 安装Docker"
    # 关闭防火墙
    if [[ "$(firewall-cmd --state 2>/dev/null)" == "running" ]]; then
      $isSudo systemctl stop firewalld.service && $isSudo systemctl disable firewalld.service
    fi

    if [ $inChina -eq 0 ]; then
       install_docker_china
    fi
    if ! [[ $(docker -v 2>/dev/null) ]]; then
       install_docker_common
    fi


    if ! [[ $(docker -v 2>/dev/null) ]]; then
        echo_content skyBlue "---> Docker安装失败"
        exit 0
    fi

    echo_content skyBlue "---> Docker安装完成"

    $isSudo iptables -A INPUT -p tcp --dport 10000:60000 -j ACCEPT
    $isSudo iptables -A INPUT -p udp --dport 10000:60000 -j ACCEPT
    timedatectl set-timezone Asia/Shanghai
    $isSudo systemctl enable docker
    $isSudo systemctl restart docker

  else

    # 检查Docker服务状态
    if systemctl is-active --quiet docker; then
      echo "Docker is running."
    else
      echo "Docker is not running. Enabling and starting Docker..."
      $isSudo systemctl enable docker && $isSudo systemctl restart docker
    fi
    echo_content skyBlue "---> 你已经安装了Docker"
  fi

}

install_agent() {

  # 定义配置文件路径
  directory="$AgentPath/config"
  directory_conf="$directory/settings.yml"
  directory_temp="$AgentPath/temp"

  # 创建配置目录
  echo_content skyBlue "---> 创建配置目录"
  rm -rf "$directory" "$directory_temp"
  $isSudo mkdir -p "$directory"

  # 写入配置文件
  echo_content skyBlue "---> 写入配置文件"
  cat >"$directory_conf" <<EOF
settings:
  logLevel: error
  serverId: {{settings.serverId}}
  serverApiUrl: {{settings.serverApiUrl}}
  mqttServer: {{settings.mqttServer}}
  mqttUser: {{settings.mqttUser}}
  mqttPass: {{settings.mqttPass}}
  mqttPort: {{settings.mqttPort}}
  agentLogFile: ./temp/agent.log
  authorizedCode: b97c8f99-480f-4651-b706-5db648c10a53
  logShield: wifi.vivo.com.cn,www.gstatic.cn
  commonUuid: {{xrayCommon.commonUuid}}
  generatePort: 2061
  grpcPort:     1703

hysteriaCommon:
  serverPort: 2062
  proxyUrl: https://www.baidu.com
  hysteriaCore: false

singBoxCommon:
  logFile: ./temp/singBox.log
  logLevel: error
  hysteria2CommonPort: 2063
  apiPort: 2703

frpCommon:
  startFrps: {{frpCommon.startFrps}}
  frpcLogFile: ./temp/frpc.log
  frpsLogFile: ./temp/frps.log
  tcpMux: true
  logLevel: error
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

  # 设置镜像和标签
  IMAGE="vlink_agent"
  TAG="latest"


  # 检查镜像是否存在
  echo_content skyBlue "---> 检查镜像是否存在"
  if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "^$IMAGE:$TAG$"; then
      echo_content skyBlue "镜像 $IMAGE:$TAG 已存在，无需重新编译"
  else
      echo_content skyBlue "镜像 $IMAGE:$TAG 不存在，开始编译"
      cd "$AgentPath"
      docker load -i ./alpine_latest.tar
      docker build -t $IMAGE:$TAG .
  fi

  # 停止并删除旧容器
  echo_content skyBlue "---> 停止并删除旧容器"
  $isSudo docker stop $IMAGE >/dev/null 2>&1
  $isSudo docker rm $IMAGE >/dev/null 2>&1

  # 运行或重启容器
  if [[ -z $($isSudo docker ps -a -q -f "name=^${IMAGE}$") ]]; then
    echo_content skyBlue "---> 启动容器"
    $isSudo docker run -d --name $IMAGE   -e TZ=Asia/Shanghai   --restart always   --network=host  -v "$AgentPath":/app  $IMAGE
    #docker run -d --name vlink_agent   -e TZ=Asia/Shanghai   --restart always   --network=host   -v /root/vlink_new:/app  vlink_agent
  else
     echo_content skyBlue "---> 重启容器"
    $isSudo docker restart $IMAGE
  fi

#  OLD_IMAGE="fendou_agent"
#  if [[ -z $($isSudo docker ps -a -q -f "name=^${OLD_IMAGE}$") ]]; then
#    echo_content skyBlue "---> RM fendou_agent"
#    $isSudo docker stop fendou_agent
#    $isSudo docker rm fendou_agent
#  fi

  # 检查容器是否正常运行
  if [[ -n $($isSudo docker ps -q -f "name=^${IMAGE}$" -f "status=running") ]]; then
    echo_content skyBlue "---> agent安装完成"
  else
    $isSudo docker ps
    echo_content red "---> agent安装失败或运行异常,请尝试修复或卸载重装"
    exit 0
  fi
}

systemctl_enable() {

# 获取当前脚本的绝对路径
SCRIPT=$(realpath $0)
SERVICE_NAME=$(basename $SCRIPT .sh)
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

# 检查服务是否已经存在
if systemctl is-enabled --quiet "$SERVICE_NAME"; then
    echo_content skyBlue "开机启动已经设置."
    return
fi

# 创建 Systemd 服务文件
cat <<EOF > $SERVICE_FILE
[Unit]
Description=自动添加到开机启动的脚本

[Service]
ExecStart=$SCRIPT

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 Systemd 管理器配置
systemctl daemon-reload
# 启用服务
systemctl enable "${SERVICE_NAME}.service"
echo_content skyBlue "脚本已添加到开机启动."
}

install_bbr() {
 # 获取内核版本
 kernel_version=$(uname -r | cut -d- -f1)
 required_version="5.5"

 # 比较内核版本
 if [ "$(printf '%s\n' "$required_version" "$kernel_version" | sort -V | head -n1)" = "$required_version" ]; then
     echo_content skyBlue "内核版本大于或等于5.5"
     # 检查是否已加载BBR
     if ! lsmod | grep -q 'bbr'; then
         echo_content skyBlue "BBR未启用，正在启用..."
         # 启用BBR
         echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
         echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
         sysctl -p
     else
         echo_content skyBlue "BBR已启用"
     fi
 else
     echo_content skyBlue "内核版本小于5.5，不进行操作"
 fi
}

install() {
  echo_content skyBlue "---> install"

  cd "$HOME" || exit 0

  echo_content skyBlue "---> install ing"

  if [[ $(command -v yum) ]]; then
    package_manager='yum'
  elif [[ $(command -v dnf) ]]; then
    package_manager='dnf'
  elif [[ $(command -v apt) ]]; then
    package_manager='apt'
  elif [[ $(command -v apt-get) ]]; then
    package_manager='apt-get'
  fi

  if [[ "${package_manager}" != 'yum' && "${package_manager}" != 'dnf' ]]; then
    $isSudo ${package_manager} update -y
  fi

  packages=(curl wget tar lsof systemd)
  # 遍历程序列表并检查是否安装
  for pkg in "${packages[@]}"; do
      if ! $isSudo ${package_manager} $pkg &>/dev/null; then
          echo "$pkg is not installed. Installing..."
          $isSudo ${package_manager} install -y $pkg
      else
          echo "$pkg is already installed."
      fi
  done
}

check_and_set_kernel_param() {
    local param_name="$1"
    local desired_value="$2"

    # 检查是否存在参数设置
    if grep -qE "^$param_name=" /etc/sysctl.conf; then
        # 提取当前值
        current_value=$(grep -E "^$param_name=" /etc/sysctl.conf | awk -F'=' '{print $2}')

        # 检查当前值是否与所需值匹配
        if [ "$current_value" = "$desired_value" ]; then
            echo_content skyBlue "$param_name 已设置为所需值，跳过。"
        else
            echo_content skyBlue "$param_name 已设置为不同的值，正在修改为 $desired_value。"
            sed -i "s/^$param_name=.*/$param_name=$desired_value/" /etc/sysctl.conf
            sysctl -p
            echo_content skyBlue "已修改 $param_name 为 $desired_value。"
        fi
    else
        # 如果参数未在文件中找到，则添加它
        echo "$param_name=$desired_value" >> /etc/sysctl.conf
        sysctl -p
        echo_content skyBlue "已添加 $param_name 并设置为 $desired_value。"
    fi



    ulimit -n 1000000
    echo "12553500" > /proc/sys/fs/file-max
    # 需要设置的配置项和值
    declare -A configs
    configs=(
        ["net.ipv4.tcp_tw_reuse"]=1
        ["net.ipv4.tcp_tw_recycle"]=0
        ["net.ipv4.ip_local_port_range"]="1024 65000"
        ["net.ipv4.tcp_mem"]="786432 2097152 3145728"
        ["net.ipv4.tcp_rmem"]="4096 4096 16777216"
        ["net.ipv4.tcp_wmem"]="4096 4096 16777216"
        ["net.core.rmem_max"]=16777216
        ["net.core.wmem_max"]=16777216
    )

    # 临时文件
    temp_file=$(mktemp)

    # 读取现有配置文件
    if [ -f /etc/sysctl.conf ]; then
        cat /etc/sysctl.conf > "$temp_file"
    fi

    # 更新或添加配置项
    for key in "${!configs[@]}"; do
        if grep -qE "^$key\s*=" "$temp_file"; then
            # 配置项存在，检查值是否相同
            value=$(grep -oP "$key\s*=\s*\K.*" "$temp_file")
            if [ "$value" != "${configs[$key]}" ]; then
                # 值不相同，更新值
                sed -i -E "s/^($key\s*=).*/\1${configs[$key]}/" "$temp_file"
                echo "更新 $key = ${configs[$key]}"
            else
                # 值相同，跳过
                echo "跳过 $key = ${configs[$key]}"
            fi
        else
            # 配置项不存在，添加配置项和值
            echo "$key = ${configs[$key]}" >> "$temp_file"
            echo "添加 $key = ${configs[$key]}"
        fi
    done

    # 覆盖原有配置文件
    mv -f "$temp_file" /etc/sysctl.conf

    # 重新加载 sysctl 配置
    sysctl -p

    # 删除临时文件（可选，因为已经被覆盖）
    rm -f "$temp_file"

}

install_swap() {
# 检查当前的交换空间大小
swap_size=$(free | grep -i swap | awk '{print $2}')

if [ $swap_size -eq 0 ]; then
    echo_content skyBlue "没有检测到交换空间，正在创建1GB的交换文件..."
    # 创建一个1GB的交换文件
    $isSudo fallocate -l 1G /swapfile
    $isSudo chmod 600 /swapfile
    $isSudo mkswap /swapfile
    $isSudo swapon /swapfile

    # 使交换文件永久化
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    echo_content skyBlue "交换文件创建成功。"
    $isSudo sysctl vm.swappiness=80
else
    echo_content skyBlue "已存在交换空间。"
fi

}

main() {
  isSudo=""
  if [[ $(whoami) != "root" ]]; then
     isSudo="sudo "
  fi
  setDNS

  CACHE_FILE="/tmp/mirrors"
  # 检查缓存文件是否存在
  if [ -f "$CACHE_FILE" ]; then
      echo_content skyBlue "已经更换了源..."
  else
      # 执行命令
      if [ $inChina -eq 0 ]; then
          echo_content skyBlue "开始更换源..."
          bash <({{server.mirrors}}) \
          --edu \
          --source repo.huaweicloud.com \
          --protocol http \
          --intranet false \
          --install-epel false \
          --close-firewall true \
          --backup true \
          --upgrade-software false \
          --clean-cache false \
          --ignore-backup-tips


          # 检查命令是否成功执行
          if [ $? -eq 0 ]; then
              echo_content skyBlue "更换源成功..."
              touch "$CACHE_FILE"
          else
              echo_content red "更换源失败..."
          fi
      fi
  fi




  $isSudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
  check_and_set_kernel_param "kern.ipc.maxsockbuf" "3014656"
  install
  export QUIC_GO_DISABLE_ECN=true
#  systemctl_enable
  install_bbr
  install_docker
  install_swap
  install_agent


  $isSudo iptables -A INPUT -p tcp --dport 1443 -j ACCEPT
  $isSudo iptables -A INPUT -p udp --dport 1443 -j ACCEPT
  $isSudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
  $isSudo iptables -A INPUT -p udp --dport 80 -j ACCEPT
  $isSudo iptables -A INPUT -p tcp --dport 1700:1702 -j ACCEPT
  $isSudo iptables -A INPUT -p udp --dport 1700:1702 -j ACCEPT
  $isSudo iptables -A INPUT -p tcp --dport 10000:60000 -j ACCEPT
  $isSudo iptables -A INPUT -p udp --dport 10000:60000 -j ACCEPT
  $isSudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
  $isSudo iptables -A INPUT -p udp --dport 8080 -j ACCEPT
  $isSudo iptables -A INPUT -p udp --dport 6060 -j ACCEPT
}

isInChina
inChina=$?


main




