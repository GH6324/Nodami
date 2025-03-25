#!/bin/bash


VERSION=$1

if [ -z "$VERSION" ]; then
    echo "❌ 错误：未提供版本号。请以 ./push_and_tag.sh vX.X.X 的格式运行脚本"
    exit 1
fi

# 提交所有更改
echo "🚀 正在提交代码..."
git add .
git commit -m "Release version $VERSION"

# 推送代码到远程仓库
echo "📡 正在推送代码到远程仓库..."
git push -u Nodami nodami

# 创建并推送标签
echo "🏷️ 创建并推送标签 $VERSION..."
git tag "$VERSION"
git push Nodami "$VERSION"

echo "✅ 操作成功完成！"