#!/bin/bash

# 检查是否提供了文件名
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# 获取文件名
FILENAME="$1"

# 使用 sed 删除所有 <font> 标签及其内容
sed -i.bak 's/<font[^>]*>//g; s/<\/font>//g' "$FILENAME"

echo "Cleaned $FILENAME. Backup created as $FILENAME.bak"

