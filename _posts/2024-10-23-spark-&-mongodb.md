---
title: spark & mongodb
excerpt: 
categories:
  -
tags:
  - spark
  - mongodb
---

# spark
[https://spark.apache.org/docs/latest/api/python/index.html#index-page-spark-sql-and-dataframes](https://spark.apache.org/docs/latest/api/python/index.html#index-page-spark-sql-and-dataframes)  




+ Spark SQL & DataFrames
    - spark.createDataFrame
        * df.show()
        * df.columns
        * df.printSchema()
+ Pandas API on Spark
+ Structured Streaming
+ Machine Learning



# mongodb
## 安装
[https://www.mongodb.com/zh-cn/docs/v6.0/tutorial/install-mongodb-on-os-x/](https://www.mongodb.com/zh-cn/docs/v6.0/tutorial/install-mongodb-on-os-x/)

### 启停服务
```plain
 T
```

```plain
brew services stop mongodb-community@7.0
```

#### 配置文件
[https://www.mongodb.com/zh-cn/docs/v6.0/reference/configuration-options/](https://www.mongodb.com/zh-cn/docs/v6.0/reference/configuration-options/)

#### debug
要验证 MongoDB 是否正在运行，请执行以下操作之一：

+ 如果将 MongoDB **作为 macOS 服务**启动：

```plain
brew services list
```

应该会看到服务 `mongodb-community` 列为 `started`。

+ 如果将 **MongoDB 作为后台进程手动**启动：

```plain
ps aux | grep -v grep | grep mongod
```

应该在输出中看到 `mongod` 进程。

还可以查看日志文件，看到 `mongod` 进程的当前状态：`/usr/local/var/log/mongodb/mongo.log`。

