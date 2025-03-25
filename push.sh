#!/bin/bash

# 修复版 Git 发布脚本
# 使用方式：./push_and_tag.sh <版本号>

VERSION=$1
REMOTE="Nodami"      # 远程仓库名称
BRANCH="nodami"      # 主分支名称

# 参数检查
if [ -z "$VERSION" ]; then
    echo "❌ 错误：未提供版本号。请以 ./push_and_tag.sh vX.X.X 的格式运行脚本"
    exit 1
fi

# 版本号格式校验（增强正则表达式）
if [[ ! $VERSION =~ ^v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]]; then
    echo "❌ 版本号格式错误，请使用语义化版本格式 vX.X.X（例如 v1.2.3）"
    exit 2
fi

# 获取最新代码
echo "🔄 同步远程代码..."
git fetch $REMOTE

# 检查标签是否存在
if git show-ref --tags | grep -q "refs/tags/$VERSION"; then
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

# 提交代码（添加空提交检查）
changes=$(git status --porcelain)
if [ -z "$changes" ]; then
    echo "ℹ️ 没有需要提交的修改"
else
    echo "🚀 提交代码变更..."
    git add .
    git commit -m "🚀 Release $VERSION" --no-verify
fi

# 推送代码
echo "📡 推送代码到 $REMOTE/$BRANCH..."
git push $REMOTE $BRANCH

# 创建带注释的标签（修复核心错误）
echo "🏷️ 创建新标签 $VERSION..."
git tag -a $VERSION -m "Version $VERSION"

# 推送标签（显式指定标签名称）
echo "📤 推送标签到远程..."
git push $REMOTE $VERSION

echo "✅ 操作成功完成！当前最新标签："
git describe --tags --abbrev=0