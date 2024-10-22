import os
from datetime import datetime

def create_post(title, excerpt="", categories=None):
    # 获取当前日期
    current_date = datetime.now().strftime("%Y-%m-%d")
    
    # 构建文件名
    filename = f"{current_date}-{title.replace(' ', '-').lower()}.md"
    
    # 文件路径
    posts_dir = "_posts"
    os.makedirs(posts_dir, exist_ok=True)  # 确保_post文件夹存在
    file_path = os.path.join(posts_dir, filename)
    
    # 处理分类
    categories_list = categories if categories else []

    # 创建文件内容
    content = f"""---
title: {title}
excerpt: {excerpt}
categories:
  - {',\n  - '.join(categories_list)}
tags:
  - WIP
---
"""
    
    # 写入文件
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(content)
    
    print(f"Post created: {file_path}")

if __name__ == "__main__":
    title = input("Enter the post title: ")
    excerpt = input("Enter the excerpt (leave blank for none): ")
    
    categories_input = input("Enter the categories (comma separated, leave blank for none): ")
    categories_list = [category.strip() for category in categories_input.split(',')] if categories_input else None
    
    create_post(title, excerpt, categories_list)
