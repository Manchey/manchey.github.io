---
title: python项目打包
categories:
  - python
tags:
  - WIP
---
{% include toc %}

python一直当脚本用，没太关注工程化的东西。最近项目里要部署个python服务，简单研究一下。

## 常用

### pyproject

[pyproject](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/)

## reference

1. https://packaging.python.org/en/latest/overview/


2. https://blog.kyomind.tw/python-poetry/

- 介绍了为什么要用poetry
- 相较于pip的好处：
  - 卸载全面：poetry卸载包时，有依赖关系，能一起卸载。pip只卸载一个
- 自带了虚拟环境的管理
