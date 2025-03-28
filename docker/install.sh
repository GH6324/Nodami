#!/bin/bash

# 常量
REPO_URL="https://github.com/YoyoCrafts/Nodami.git"
REPO_DIR="/root/nodami"
REPO_VERSION="v1.0.2"

# 安装docker
install_docker() {
   echo "---> install_docker"



   if ! [[ $(docker -v 2>/dev/null) ]]; then
        echo "Docker 未安装，正在安装..."
        if ! [[ $(docker -v 2>/dev/null) ]]; then
             echo_content skyBlue "---> bash <(https://linuxmirrors.cn/docker.sh)  --source repo.huaweicloud.com/docker-ce  --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true"
             sudo bash <({{server.docker}})  --source repo.huaweicloud.com/docker-ce  --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true
        fi
        if ! [[ $(docker -v 2>/dev/null) ]]; then
             echo_content skyBlue "---> sh <(curl -sL https://get.docker.com)"
             sudo sh <(curl -sL https://get.docker.com)
        fi
        if ! [[ $(docker -v 2>/dev/null) ]]; then
              echo_content skyBlue "---> curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -"
              sudo curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
        fi

        if ! [[ $(docker -v 2>/dev/null) ]]; then
              echo_content skyBlue "---> curl -sSL https://get.daocloud.io/docker | sh"
              sudo curl -sSL https://get.daocloud.io/docker | sh
        fi


        if ! [[ $(docker -v 2>/dev/null) ]]; then
             echo_content skyBlue "---> Docker安装失败"
             exit 0
        fi


       timedatectl set-timezone Asia/Shanghai
       sudo systemctl enable docker
       sudo systemctl restart docker
       echo "---> Docker安装完成"
  else
    if systemctl is-active --quiet docker; then
      echo "Docker is running."
    else
      echo "Docker is not running. Enabling and starting Docker..."
      sudo systemctl enable docker && sudo systemctl restart docker
    fi
    echo "---> 你已经安装了Docker"
  fi

   if ! command -v docker-compose >/dev/null 2>&1; then
       echo "docker-compose 未安装，正在安装..."
       sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
       chmod +x /usr/local/bin/docker-compose
  fi
}

# 检查Git是否安装
check_git_installed() {
    if ! command -v git &> /dev/null; then
        echo "❌ Git 未安装，正在安装Git..."
        if [ -x "$(command -v apt)" ]; then
            sudo apt update && sudo apt install -y git
        elif [ -x "$(command -v yum)" ]; then
            sudo yum install -y git
        else
            echo "❌ 无法自动安装 Git，请手动安装。"
            exit 1
        fi
    else
        echo "✅ Git 已安装。"
    fi
}

# 克隆或更新项目
clone_or_update_repo() {
    if [ ! -d "$REPO_DIR/.git" ]; then
        echo "🚀 项目不存在，正在从 GitHub 克隆指定版本（浅克隆）..."
        git clone --depth 1 --branch "$REPO_VERSION" "$REPO_URL" "$REPO_DIR"
    else
        echo "🔄 项目已存在，正在拉取最新Tag..."
        cd "$REPO_DIR" || exit
        git fetch --depth 1 origin tag "$REPO_VERSION"
        git checkout tags/"$REPO_VERSION" -B "$REPO_VERSION"
    fi
}


# 安装 Nodami 并确认启动状态
install_nodami(){
  cd "$REPO_DIR/docker/bao" || exit
  docker-compose up -d

  echo "🚀 正在启动 Nodami，请稍候..."
  for i in {1..120}; do
      if curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:18080/client/subscription | grep -q "200"; then
          echo -e "\n✅ Nodami 启动成功！"
          SERVER_IP=$(curl -s ifconfig.me)
          echo -e "\n🌐 后台地址：http://$SERVER_IP:18080"
          echo -e "🔑 默认账号：admin"
          echo -e "🔑 默认密码：123456"
          echo -e "⚠️ 请登录后立即修改默认密码，以确保安全。"
          return
      else
          echo -ne "\r⏳ 等待 Nodami 启动中... ($i s)"
          sleep 1
      fi
  done

  echo "❌ Nodami 启动超时，请联系开发人员或在交流群中询问。"
}

# 卸载 Nodami
uninstall_nodami(){
  echo "❌ 正在卸载 Nodami..."
  cd "$REPO_DIR/docker/bao" || exit
  docker-compose down
  docker system prune -af
  rm -rf "$REPO_DIR"
  echo "✅ Nodami 已彻底卸载。"
}

reinstall_nodami(){
  echo "❌ 正在卸载 Nodami..."
  cd "$REPO_DIR/docker/bao" || exit
  docker-compose down
  rm -rf "$REPO_DIR/docker/bao/mysql"
  install_nodami
}

# 主程序
main() {
  if [ -d "$REPO_DIR/docker/bao" ]; then
      echo "⚠️ 检测到 Nodami 已经安装，请选择操作："
      echo "1) 重启 Nodami"
      echo "2) 重新安装 Nodami"
      echo "3) 卸载 Nodami"
      read -rp "请选择 [1-重启,2-重新安装,3-卸载]: " choice
      case $choice in
          1)
              cd "$REPO_DIR/docker/bao" || exit
              docker-compose restart
              echo "✅ Nodami 已重启完成。"
              ;;
          2)
              reinstall_nodami
              ;;
          3)
              uninstall_nodami
              ;;
          *)
              echo "❌ 输入无效，脚本终止。"
              exit 1
              ;;
      esac
  else
      check_git_installed
      clone_or_update_repo
      install_docker
      install_nodami
  fi
}

# 执行主程序
main