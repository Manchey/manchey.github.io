#!/bin/bash

# 读取日期
read -p "Enter the date (leave blank for now): " date_input
# 读取标题
read -p "Enter the post title: " title
# 读取摘录
read -p "Enter the excerpt (leave blank for none): " excerpt
# 读取分类
read -p "Enter the categories (comma separated, leave blank for 'work'): " categories_input
# 读取标签
read -p "Enter the tags (comma separated, leave blank for none): " tags_input

# 处理日期
if [ -z "$date_input" ]; then
    date_input=$(date +"%Y-%m-%d")
fi

# 处理分类
if [ -z "$categories_input" ]; then
    categories="work"
else
    IFS=',' read -r -a categories_array <<< "$categories_input"
    categories=$(IFS=','; echo "${categories_array[*]}")
fi

# 处理标签
tags=""
if [ -n "$tags_input" ]; then
    IFS=',' read -r -a tags_array <<< "$tags_input"
    tags=$(printf "  - %s\n" "${tags_array[@]}")
fi

# 构建文件名
filename="${date_input}-$(echo $title | tr ' ' '-' | tr '[:upper:]' '[:lower:]').md"

# 文件路径
posts_dir="_posts"
mkdir -p "$posts_dir"
file_path="$posts_dir/$filename"

# 创建文件内容
{
    echo "---"
    echo "title: $title"
    [ -n "$excerpt" ] && echo "excerpt: $excerpt"
    echo "categories: $categories"
    [ -n "$tags" ] && echo "tags:" && echo "$tags"
    echo "---"
} > "$file_path"

echo "Post created: $file_path"