---
title: mac调用docker中的GUI界面
excerpt: 
categories: work
---

## mac上，使用docker中的gui程序

1. 安装XQuartz，通过XQuartz打开terminal，启动docker
2. docker里设置环境变量：`export DISPLAY=<IP>:0`
3. 主机： `xhost + <IP>`

- Reference：
  - https://shaoguangleo.github.io/2018/01/21/docker-run-gui-on-macosx/
  - https://zhuanlan.zhihu.com/p/652143343
