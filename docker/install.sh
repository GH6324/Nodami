#!/bin/bash

# 常量定义
REPO_URL="https://github.com/YoyoCrafts/Nodami.git"
REPO_DIR="/root/nodami"
REPO_VERSION="v1.0.2"

# 输出带颜色的文本
echo_content() {
    local ECHO_TYPE="echo -e"

    # 检查是否支持 -e 参数
    if ! $ECHO_TYPE "\033[31mtest\033[0m" &>/dev/null; then
        ECHO_TYPE="echo"  # 如果不支持 -e，则降级为普通的 echo
    fi

    # 根据不同的颜色输出文本
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

# 安装 Docker
install_docker() {
    echo_content skyBlue "---> 正在安装 Docker..."

    if ! docker -v &>/dev/null; then
        echo_content red "Docker 未安装，正在安装..."

        # 尝试不同的安装方法
        install_docker_method
    else
        # Docker 已安装，检查并启动服务
        check_and_start_docker
    fi

    # 安装 Docker Compose
    install_docker_compose
}

# 安装 Docker 的不同方法
install_docker_method() {
    # 尝试多个安装方式
    if ! install_with_huawei_mirror && ! install_with_get_docker && ! install_with_aliyun_mirror; then
        # 如果所有方法都失败，则退出脚本
        echo_content red "Docker 安装失败，脚本终止！请尝试手动安装docker"
        exit 1
    fi
}

# 使用华为镜像源安装 Docker
install_with_huawei_mirror() {
    echo_content skyBlue "---> 使用华为镜像源安装 Docker..."
    curl -sSL https://linuxmirrors.cn/docker.sh -o /tmp/docker_install.sh
    sudo bash /tmp/docker_install.sh --source repo.huaweicloud.com/docker-ce --source-registry mirror.gcr.io --ignore-backup-tips --install-latested true --protocol http
    if docker -v &>/dev/null; then
        echo_content green "使用华为镜像源安装 Docker 成功。"
        return 0
    else
        return 1
    fi
}

# 使用 get.docker.com 安装 Docker
install_with_get_docker() {
    echo_content skyBlue "---> 使用 get.docker.com 安装 Docker..."
    curl -fsSL https://get.docker.com -o /tmp/get_docker.sh
    sudo bash /tmp/get_docker.sh
    if docker -v &>/dev/null; then
        echo_content green "使用 get.docker.com 安装 Docker 成功。"
        return 0
    else
        return 1
    fi
}

# 使用阿里云镜像源安装 Docker
install_with_aliyun_mirror() {
    echo_content skyBlue "---> 使用阿里云镜像源安装 Docker..."
    curl -fsSL https://get.docker.com -o /tmp/get_docker_aliyun.sh
    sudo bash /tmp/get_docker_aliyun.sh --mirror Aliyun
    if docker -v &>/dev/null; then
        echo_content green "使用阿里云镜像源安装 Docker 成功。"
        return 0
    else
        return 1
    fi
}

# 检查并启动 Docker 服务
check_and_start_docker() {
    if systemctl is-active --quiet docker; then
        echo_content green "Docker 已经在运行。"
    else
        echo_content yellow "Docker 未启动，正在启动..."
        sudo systemctl enable docker && sudo systemctl restart docker
    fi
    echo_content green "Docker 安装完成并已启动。"
}

# 安装 Docker Compose
install_docker_compose() {
    if ! docker compose version &>/dev/null; then
        echo_content skyBlue "---> 正在安装 Docker Compose..."

        sudo apt-get update

        # 尝试安装 Docker Compose 插件
        if sudo apt-get install -y docker-compose-plugin; then
            echo_content green "Docker Compose 插件安装成功。"
        else
            # 安装失败，尝试下载旧版二进制文件
            install_old_docker_compose
        fi
    else
        echo_content green "Docker Compose 已安装。"
    fi
}

# 安装旧版 Docker Compose
install_old_docker_compose() {
    echo_content skyBlue "---> 正在安装旧版 Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    if docker-compose --version &>/dev/null; then
        echo_content green "旧版 Docker Compose 安装成功。"
    else
        echo_content red "Docker Compose 安装失败，请检查网络或手动安装。"
        exit 1
    fi
}

# 检查 Git 是否已安装
check_git_installed() {
    if ! command -v git &>/dev/null; then
        echo_content red "Git 未安装，正在安装 Git..."
        install_git
    else
        echo_content green "Git 已安装。"
    fi
}

# 安装 Git
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

# 克隆或更新项目
clone_or_update_repo() {
    if [ ! -d "$REPO_DIR/.git" ]; then
        echo_content blue "项目不存在，正在从 GitHub 克隆..."
        git clone --depth 1 --branch "$REPO_VERSION" "$REPO_URL" "$REPO_DIR"
    else
        echo_content blue "项目已存在，正在拉取最新版本..."
        cd "$REPO_DIR" || exit
        git fetch --depth 1 origin tag "$REPO_VERSION"
        git checkout tags/"$REPO_VERSION" -B "$REPO_VERSION"
    fi
}

# 安装 Nodami 并启动
install_nodami() {
    cd "$REPO_DIR/docker/bao" || exit
    docker compose up -d

    echo_content skyBlue "正在启动 Nodami，请稍候..."

    for i in {1..120}; do
        if curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:18080/client/subscription | grep -q "200"; then
            echo_content green "\nNodami 启动成功！"
            SERVER_IP=$(curl -s ifconfig.me)
            echo_content green "后台地址：http://$SERVER_IP:18080"
            echo_content green "默认账号：admin"
            echo_content green "默认密码：123456"
            echo_content yellow "请登录后立即修改默认密码。"
            return
        else
            echo -ne "\r正在等待 Nodami 启动... ($i 秒)"
            sleep 1
        fi
    done

    echo_content red "Nodami 启动超时，请联系开发人员。"
}

# 卸载 Nodami
uninstall_nodami() {
    echo_content red "正在卸载 Nodami..."
    cd "$REPO_DIR/docker/bao" || exit
    docker compose down
    docker system prune -af
    rm -rf "$REPO_DIR"
    echo_content green "Nodami 已彻底卸载。"
}

# 重新安装 Nodami
reinstall_nodami() {
    uninstall_nodami
    echo_content yellow "正在重新安装 Nodami..."
    rm -rf "$REPO_DIR/docker/bao/mysql"
    install_nodami
}

# 主程序
main() {
    # 每次执行时都先检查依赖
    check_git_installed
    install_docker

    if [ -d "$REPO_DIR/docker/bao" ]; then
        echo_content yellow "检测到 Nodami 已安装，请选择操作："
        echo "1) 重启 Nodami"
        echo "2) 重新安装 Nodami"
        echo "3) 卸载 Nodami"
        read -rp "请选择 [1-重启, 2-重新安装, 3-卸载]: " choice
        case $choice in
            1) cd "$REPO_DIR/docker/bao" || exit && docker compose restart && echo_content green "Nodami 已重启。" ;;
            2) reinstall_nodami ;;
            3) uninstall_nodami ;;
            *) echo_content red "输入无效，脚本终止。" && exit 1 ;;
        esac
    else
        clone_or_update_repo
        install_nodami
    fi
}

# 执行主程序
main