#!/bin/bash

# 常量定义
REPO_URL="https://github.com/YoyoCrafts/Nodami.git"
REPO_DIR="/root/nodami"
VERSION_CACHE_FILE="/root/.nodami_version"

# 输出带颜色的文本
echo_content() {
    local ECHO_TYPE="echo -e"
    if ! $ECHO_TYPE "\033[31mtest\033[0m" &>/dev/null; then
        ECHO_TYPE="echo"
    fi
    case $1 in
        "red")      $ECHO_TYPE "\033[31m$2\033[0m" ;;
        "green")    $ECHO_TYPE "\033[32m$2\033[0m" ;;
        "yellow")   $ECHO_TYPE "\033[33m$2\033[0m" ;;
        "blue")     $ECHO_TYPE "\033[34m$2\033[0m" ;;
        "purple")   $ECHO_TYPE "\033[35m$2\033[0m" ;;
        "skyBlue")  $ECHO_TYPE "\033[36m$2\033[0m" ;;
        "white")    $ECHO_TYPE "\033[37m$2\033[0m" ;;
        *)          $ECHO_TYPE "$2" ;;
    esac
}

get_latest_version() {
    curl -s "https://api.github.com/repos/YoyoCrafts/Nodami/tags" \
      | grep 'name' | head -n1 | cut -d '"' -f4
}

get_installed_version() {
    [[ -f "$VERSION_CACHE_FILE" ]] && cat "$VERSION_CACHE_FILE" || echo "none"
}

install_docker() {
    echo_content skyBlue "---> 正在安装 Docker..."
    if ! docker -v &>/dev/null; then
        echo_content red "Docker 未安装，正在安装..."
        install_docker_method
    else
        check_and_start_docker
    fi
    install_docker_compose
}

install_docker_method() {
    if ! install_with_huawei_mirror && ! install_with_get_docker && ! install_with_aliyun_mirror; then
        echo_content red "Docker 安装失败，脚本终止！请尝试手动安装docker"
        exit 1
    fi
}

install_with_huawei_mirror() {
    echo_content skyBlue "---> 使用华为镜像源安装 Docker..."
    curl -sSL https://linuxmirrors.cn/docker.sh -o /tmp/docker_install.sh
    sudo bash /tmp/docker_install.sh --source repo.huaweicloud.com/docker-ce --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true --protocol http
    docker -v &>/dev/null
}

install_with_get_docker() {
    echo_content skyBlue "---> 使用 get.docker.com 安装 Docker..."
    curl -fsSL https://get.docker.com -o /tmp/get_docker.sh
    sudo bash /tmp/get_docker.sh
    docker -v &>/dev/null
}

install_with_aliyun_mirror() {
    echo_content skyBlue "---> 使用阿里云镜像源安装 Docker..."
    curl -fsSL https://get.docker.com -o /tmp/get_docker_aliyun.sh
    sudo bash /tmp/get_docker_aliyun.sh --mirror Aliyun
    docker -v &>/dev/null
}

check_and_start_docker() {
    if ! systemctl is-active --quiet docker; then
        echo_content yellow "Docker 未启动，正在启动..."
        sudo systemctl enable docker && sudo systemctl restart docker
    fi
    echo_content green "Docker 安装完成并已启动。"
}

install_docker_compose() {
    if ! docker compose version &>/dev/null; then
        echo_content skyBlue "---> 正在安装 Docker Compose..."
        sudo apt-get update
        if ! sudo apt-get install -y docker-compose-plugin; then
            install_old_docker_compose
        else
            echo_content green "Docker Compose 插件安装成功。"
        fi
    else
        echo_content green "Docker Compose 已安装。"
    fi
}

install_old_docker_compose() {
    echo_content skyBlue "---> 正在安装旧版 Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version &>/dev/null
}

check_git_installed() {
    if ! command -v git &>/dev/null; then
        echo_content red "Git 未安装，正在安装 Git..."
        install_git
    else
        echo_content green "Git 已安装。"
    fi
}

install_git() {
    if [ -x "$(command -v apt)" ]; then
        sudo apt update && sudo apt install -y git
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y git
    else
        echo_content red "无法自动安装 Git，请手动安装。"
        exit 1
    fi
}

nodami_status() {
  for i in {1..120}; do
      if curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:18080/client/subscription | grep -q "200"; then
          echo_content green "\nNodami 启动成功！"
          SERVER_IP=$(curl -s ifconfig.me)
          echo_content green "后台地址：http://$SERVER_IP:18080"
          echo_content green "默认账号：admin"
          echo_content green "默认密码：123456"
          echo_content yellow "请登录后立即修改默认密码。 如已经修改请使用您设置的密码登录"
          return
      else
          echo -ne "\r正在等待 Nodami 启动... ($i 秒)"
          sleep 1
      fi
  done
  echo_content red "Nodami 启动超时，请联系开发人员。"
}

install_nodami() {
    cd "$REPO_DIR/docker/bao" || exit
    docker compose up -d
    echo_content skyBlue "正在启动 Nodami，请稍候..."
    nodami_status
}

uninstall_nodami() {
    echo_content red "正在卸载 Nodami..."
    cd "$REPO_DIR/docker/bao" || exit
    docker compose down
    docker system prune -af
    rm -rf "$REPO_DIR"
    echo_content green "Nodami 已彻底卸载。"
}

reinstall_nodami() {
    uninstall_nodami
    echo_content yellow "正在重新安装 Nodami..."
    rm -rf "$REPO_DIR/docker/bao/mysql"
    install_nodami
}

check_for_update() {
    local installed_version latest_version
    installed_version=$(get_installed_version)
    latest_version=$(get_latest_version)
    echo_content white "当前版本: $installed_version"
    echo_content white "最新版本: $latest_version"

    if [[ "$installed_version" == "none" ]]; then
       echo "$latest_version" > "v1.0.0"
    fi

    if [[ "$installed_version" != "$latest_version" ]]; then
        echo_content yellow "发现新版本，是否更新？(y/n)"
        read -r update_choice
        if [[ "$update_choice" == "y" ]]; then
            update_nodami "$latest_version"
        else
            echo_content white "已取消更新操作。"
        fi
    else
        update_nodami_this
    fi
}


update_nodami_this() {
   echo_content yellow "正在更新 Nodami 到当前版本最新代码"
   cd "$REPO_DIR" || exit
   git pull
   cd "$REPO_DIR/docker/bao" || exit
   echo_content skyBlue "更新完成 Nodami 重新启动..."
   docker compose down
   docker compose up -d
   echo_content skyBlue "等待 Nodami 启动..."
   nodami_status
}


update_nodami() {
    echo_content yellow "正在更新 Nodami 到版本 $1..."
    cd "$REPO_DIR" || exit
    git fetch --tags
    git checkout "tags/$1" -B "$1"
    cd "$REPO_DIR/docker/bao" || exit
    echo_content skyBlue "更新完成 Nodami 重新启动..."
    echo "$1" > "$VERSION_CACHE_FILE"
    docker compose down
    docker compose up -d
    echo_content skyBlue "等待 Nodami 启动..."
    nodami_status
}

clone_or_update_repo() {
    latest_version=$(get_latest_version)
    if [ ! -d "$REPO_DIR/.git" ]; then
        echo_content blue "Nodami尚未安装，开始从 GitHub 克隆..."
        git clone --depth 1 --branch "$latest_version" "$REPO_URL" "$REPO_DIR"
    fi
    echo "$latest_version" > "$VERSION_CACHE_FILE"
}

main() {
    check_git_installed
    install_docker

    if [ -d "$REPO_DIR/docker/bao" ]; then
        echo_content yellow "检测到 Nodami 已安装，请选择操作："
        echo "1) 重启 Nodami"
        echo "2) 重新安装 Nodami"
        echo "3) 卸载 Nodami"
        echo "4) 检查更新"
        read -rp "请选择 [1-重启, 2-重新安装, 3-卸载, 4-检查更新]: " choice
        case $choice in
            1) cd "$REPO_DIR/docker/bao" || exit && docker compose restart && nodami_status && echo_content green "Nodami 已重启。" ;;
            2) reinstall_nodami ;;
            3) uninstall_nodami ;;
            4) check_for_update ;;
            *) echo_content red "输入无效，脚本终止。" && exit 1 ;;
        esac
    else
        clone_or_update_repo
        install_nodami
    fi
}

main
