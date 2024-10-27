---
title: 使用bazel编译rust项目
excerpt: 
categories: 
tags:
  - bazel
  - rust
---

# 编译适配

主要参考：https://www.tweag.io/blog/2023-07-27-building-rust-workspace-with-bazel/

## 1）加入rules_rust

在WORKSPACE中加入：
```python
http_archive(
    name = "rules_rust",
    sha256 = "36ab8f9facae745c9c9c1b33d225623d976e78f2cc3f729b7973d8c20934ab95",
    urls = ["https://github.com/bazelbuild/rules_rust/releases/download/0.31.0/rules_rust-v0.31.0.tar.gz"    ],
)

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
rules_rust_dependencies()
rust_register_toolchains()

# 声明使用的rust版本，最新的是2024，我选了一个次新的
rust_register_toolchains(
    edition = "2021",
)
```

## 2）设置外部依赖

添加外部依赖，在WORKSPACE中添加：

```python
load("@rules_rust//crate_universe:repositories.bzl", "crate_universe_dependencies")
crate_universe_dependencies()
load("@rules_rust//crate_universe:defs.bzl", "crates_repository")

crates_repository(
    name = "crate_index",
    cargo_lockfile = "//deep_os_tool:Cargo.lock",
    lockfile = "//:cargo-bazel-lock.json",
    manifests = [
        "//deep_os_tool:Cargo.toml",
        "//deep_os_tool/common:Cargo.toml",
        "//deep_os_tool/deep_os_monitor:Cargo.toml",
    ],
    generate_build_scripts = True,
)

load("@crate_index//:defs.bzl", "crate_repositories")
crate_repositories()
```

必须先执行一下：

```bash
touch cargo-bazel-lock.json
CARGO_BAZEL_REPIN=1 bazel sync --only=crate_index
```

执行上述命令会读取Cargo.toml和Cargo.lock，并将依赖信息写到cargo-bazel-lock.json中，通过bazel命令可以查询具体包含了哪些依赖：

```bash
bazel query @crate_index//...
```

## 3）添加target规则：

```python
package(default_visibility = ["//visibility:public"])

load("@rules_rust//rust:defs.bzl", "rust_library")

rust_library(
    name = "common",
    srcs = glob([
        "src/**/*.rs",
    ]),
    edition = "2021",
    deps = [
        "@crate_index//:chrono",
        "@crate_index//:lazy_static",
        "@crate_index//:log",
        "@crate_index//:log4rs",
        "@crate_index//:nix",
        "@crate_index//:serde",
        "@crate_index//:tokio",
        "@crate_index//:uname",
    ],
    proc_macro_deps = [
        "@crate_index//:serde_derive",
    ],
)
```

# Rust call c++编译问题

- rust调用c++代码，一般几种方式：cxx、autocxx、bindgen
  - 此前用的autocxx，相对来说是最方便使用的，不需要自己手动写大量的胶水层代码

- autocxx本身目前没有现成的bazel方案，但一些开源相关工作可以参考：
  - autocxx仓库的bazel PR：https://github.com/google/autocxx/pull/1255
  - 有一个开源库，自己做了autocxx的bazel集成：https://github.com/frc971/971-Robot-Code/blob/main/tools/build_rules/autocxx.bzl

- autocxx的原理介绍：
  - https://google.github.io/autocxx/building.html

  - 重点是通过autocxx-gen工具，生成对应的cpp/rs胶水层代码并编译。
  - 之前的build.rs脚本中autocxx提供的函数其实就是封装了这一过程。

## 生成过程

1. 先把依赖的几个proto编译一下，把头文件生成出来。

2. 然后执行autocxx-gen

```bash
autocxx-gen ./perf_analysis/deep_os_tool/deep_os_monitor/src/tracelog/cpp_to_rust_interface/cpp_interface.rs \
            --outdir ./test-output/ \
            --gen-cpp \
            --gen-rs-include \
            --inc ./ \
            --inc ./bazel-bin \
```


- 参数解释：
  - cpp_interface.rs：调用了c++的rust代码
  - --outdir：输出文件夹
  - --gen-cpp：指定生成c++胶水层代码
  - --gen-rs-include：指定生成rust胶水层代码
  - --inc：按需指定依赖的各个头文件路径
    - ./bazel-bin：church的几个protobuf生成的头文件
    - ./bazel-bin/external/common/_virtual_includes/module_event_proto/：common中的protobuf头文件

