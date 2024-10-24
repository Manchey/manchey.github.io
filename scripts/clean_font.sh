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

# 使用 sed 删除所有 <span> 标签及其内容
sed -i.bak 's/<span[^>]*>//g; s/<\/span>//g' "$FILENAME"
sed -i.bak 's/<details[^>]*>//g; s/<\/details>//g' "$FILENAME"
sed -i.bak 's/<summary[^>]*>//g; s/<\/summary>/\n/g' "$FILENAME"
sed -i.bak 's/<em[^>]*>//g; s/<\/em>//g' "$FILENAME"
sed -i.bak 's/<li[^>]*>//g; s/<\/li>//g' "$FILENAME"
sed -i.bak 's/<p[^>]*>//g; s/<\/p>/\n/g' "$FILENAME"
sed -i.bak 's/<a[^>]*>//g; s/<\/a>//g' "$FILENAME"
sed -i.bak 's/<h1[^>]*>//g; s/<\/h1>//g' "$FILENAME"
sed -i.bak 's/<ul[^>]*>/\n/g; s/<\/ul>//g' "$FILENAME"

echo "Cleaned $FILENAME.

