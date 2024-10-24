#!/bin/bash


# 读取日期
read -p "Enter the date (leave bland for now): " current_date
# 读取标题
read -p "Enter the post title: " title
# 读取摘录
read -p "Enter the excerpt (leave blank for none): " excerpt
# 读取分类
read -p "Enter the categories (comma separated, leave blank for 'work'): " categories_input
# 读取标签
read -p "Enter the tags (comma separated, leave blank for default 'WIP'): " tags_input

# 处理日期
if [ -z "$date_input" ]; then
    # 获取当前日期
    current_date=$(date +"%Y-%m-%d")
fi

# 处理分类
if [ -z "$categories_input" ]; then
    categories="work"
fi

# 处理标签
if [ -z "$tags_input" ]; then
    tags="  - WIP"
else
    IFS=',' read -r -a tags_array <<< "$tags_input"
    tags=$(printf "  - %s\n" "${tags_array[@]}")
fi

# 构建文件名
filename="${current_date}-$(echo $title | tr ' ' '-' | tr '[:upper:]' '[:lower:]').md"

# 文件路径
posts_dir="_posts"
mkdir -p "$posts_dir"  # 确保_post文件夹存在
file_path="$posts_dir/$filename"

# 创建文件内容
{
    echo "---"
    echo "title: $title"
    echo "excerpt: $excerpt"
    echo "categories: $categories"
    echo "tags:"
    echo "$tags"
    echo "---"
} > "$file_path"

echo "Post created: $file_path"
