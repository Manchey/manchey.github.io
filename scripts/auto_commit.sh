#!/bin/bash

# 检查是否在 git 仓库中
if [ ! -d .git ]; then
  echo "当前目录不是一个 Git 仓库。"
  exit 1
fi

# 替换markdown中图片的路径
find _posts -name "*.md" -exec sed -i '' 's/(image/(https:\/\/manchey.github.io\/assets\/image/g' {} +

# 添加所有修改的文件
git add .

# 检查是否有修改
if [ -z "$(git status --porcelain)" ]; then
  echo "没有要提交的更改。"
  exit 0
fi

# 生成 commit message
commit_message=$(git log -1 --pretty=%B | head -n 1)
if [ -z "$commit_message" ]; then
  commit_message="Update changes"
fi

# 获取修改文件的摘要
modified_files=$(git diff --cached --name-only)

# 生成具体的 commit message
commit_message="Update: $(echo "$modified_files" | tr '\n' ', ' | sed 's/,$//')"

# 提交更改
git commit -m "$commit_message" -s

# 推送到远程 master 分支
git push origin master

echo "提交成功，推送到远程 master 分支。"
