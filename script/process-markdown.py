import os
import re
import yaml
from datetime import datetime


def process_markdown_files(directory):
    # 匹配文件名模式：YYYY-MM-DD--title.md
    pattern = r"(\d{4}-\d{2}-\d{2})-(.+)\.md"

    # 遍历目录中的所有.md文件
    for root, _, files in os.walk(directory):
        for file in files:
            if not file.endswith(".md"):
                continue

            match = re.match(pattern, file)
            if not match:
                continue

            date_str, title = match.groups()
            # 将破折号替换为空格，并去除可能的.md后缀
            title = title.replace(".md", "")

            file_path = os.path.join(root, file)

            # 读取原文件内容
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()

            if content.startswith("---"):
                # 提取现有的front matter
                front_matter_match = re.match(r"---(.*?)---", content, re.DOTALL)
                if front_matter_match:
                    # 解析现有的front matter
                    try:
                        front_matter = yaml.safe_load(front_matter_match.group(1))
                        # 更新date和title
                        front_matter["date"] = f"{date_str} 00:00:00"
                        front_matter["title"] = title

                        # 转换回yaml格式
                        new_front_matter = yaml.dump(
                            front_matter, allow_unicode=True, sort_keys=False
                        )

                        # 获取front matter之后的内容
                        remaining_content = content[front_matter_match.end() :].strip()

                        # 检查内容是否已经以H1标题开始
                        if not remaining_content.startswith("# "):
                            remaining_content = f"# {title}\n\n{remaining_content}"

                        # 替换原有的front matter
                        new_content = f"---\n{new_front_matter}---\n\n{remaining_content}"

                        with open(file_path, "w", encoding="utf-8") as f:
                            f.write(new_content)

                        print(f"Updated front matter and title for {file}")
                    except yaml.YAMLError as e:
                        print(f"Error parsing front matter in {file}: {e}")
                continue

            # 如果没有front matter，创建新的
            content_with_title = (
                f"# {title}\n\n{content}" if not content.startswith("# ") else content
            )
            front_matter = f"""---
date: {date_str} 00:00:00
title: {title}
type: post
---

{content_with_title}"""

            # 写回文件
            with open(file_path, "w", encoding="utf-8") as f:
                f.write(front_matter)

            print(f"Added new front matter and title to {file}")


if __name__ == "__main__":
    # 指定要处理的目录路径
    directory = "content/post/2024"  # 根据实际情况修改路径
    process_markdown_files(directory)
