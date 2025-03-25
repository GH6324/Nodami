#!/bin/bash

# 增强版 Git 发布脚本
# 使用方式：./push_and_tag.sh <版本号>

VERSION=$1
REMOTE="Nodami"      # 远程仓库名称
BRANCH="nodami"      # 主分支名称

# 错误处理函数
handle_error() {
    echo "❌ 错误发生在第 $1 行，退出代码 $2"
    exit $2
}

trap 'handle_error $LINENO $?' ERR

# 参数检查
if [ -z "$VERSION" ]; then
    echo "❌ 错误：未提供版本号。请以 ./push_and_tag.sh vX.X.X 的格式运行脚本"
    exit 1
fi

# 版本号格式校验
if [[ ! $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ 版本号格式错误，请使用 vX.X.X 格式（例如 v1.2.3）"
    exit 2
fi

# 获取最新代码
echo "🔄 同步远程代码..."
git fetch $REMOTE

# 检查标签是否存在
if git rev-parse $VERSION >/dev/null 2>&1; then
    echo "⚠️ 警告：版本 $VERSION 已存在！"
    read -p "是否要覆盖此版本？(y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "⏹ 操作已取消"
        exit 3
    fi

    # 删除现有标签
    echo "🗑️ 删除本地标签..."
    git tag -d $VERSION
    echo "🗑️ 删除远程标签..."
    git push $REMOTE :refs/tags/$VERSION
fi

# 提交代码
echo "🚀 提交代码变更..."
git add .
git commit -m "🚀 Release $VERSION" --no-verify  # 跳过 pre-commit 检查

# 推送代码
echo "📡 推送代码到 $REMOTE/$BRANCH..."
git push $REMOTE $BRANCH

# 创建新标签
echo "🏷️ 创建新标签 $VERSION..."
git tag -a