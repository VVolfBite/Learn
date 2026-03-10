# MongoDB

## 工具介绍

MongoDB 是文档型数据库，数据以类似 JSON 的 BSON 文档方式存储。菜鸟教程在开篇里把它定位为面向 Web 应用的、可扩展的高性能文档数据库，同时强调它处在关系型数据库和非关系型数据库之间：不是表和行，而是数据库、集合和文档。这个介绍很适合做入门抓手。citeturn2search0turn2search3

如果业务数据结构变化快、字段不完全固定，或者你希望对象结构能更自然地落库，MongoDB 会比传统关系型数据库更顺手一些。

## 核心机制

### 数据模型

MongoDB 最先要搞清楚的是三层关系：
- Database
- Collection
- Document

菜鸟教程在简介页里明确给出了这组对应关系，并强调文档可以包含嵌套对象和数组。citeturn2search3

### 文档与 BSON

MongoDB 对外看起来像 JSON，但底层存储是 BSON。你可以把它先理解成“更适合机器存储和传输的 JSON 形式”。

### 副本集与分片

MongoDB 既支持副本集做高可用，也支持分片做水平扩展。对入门来说，先知道它为什么适合扩展就够了，没必要一开始就钻进复杂集群细节。菜鸟教程也把高可用和水平扩展列成它的关键特点。citeturn2search0

## 基本使用

### 进入 Shell

菜鸟教程里有 MongoDB Shell 的介绍。现在常见的是 `mongosh`，它是和数据库交互的命令行工具。citeturn2search2

### 选择数据库

菜鸟教程明确提到：使用 `use` 切换数据库时，如果数据库不存在，后续插入数据后它会被创建。citeturn2search1

```javascript
use demo
show dbs
```

### 创建集合与插入文档

```javascript
db.users.insertOne({ name: "alice", age: 20 })
db.users.find()
```

### 查询、更新、删除

```javascript
db.users.find({ age: { $gt: 18 } })
db.users.updateOne({ name: "alice" }, { $set: { age: 21 } })
db.users.deleteOne({ name: "alice" })
```

## 项目工程中的使用

### 半结构化数据

如果对象字段经常变化，或者嵌套结构明显，MongoDB 的文档模型会比较自然。

### 内容与日志类数据

某些内容型数据、配置型数据、事件型数据，也常会考虑 MongoDB。

### 读写模型灵活的场景

当你更想围绕文档整体读写，而不是围绕复杂表连接做设计时，MongoDB 会更顺手。

## 常见问题与注意点

第一，MongoDB 灵活，不代表可以不要建模。集合怎么拆、字段怎么设计、索引怎么建，仍然会影响查询性能和后续维护。

第二，`use` 只是切换数据库上下文，不等于真的已经有数据了。菜鸟教程特别提醒了：只有插入集合和文档后，数据库才会在 `show dbs` 里显出来。citeturn2search1

第三，MongoDB 不是“万能替代 MySQL”，两者适合的数据模型和查询风格并不一样。
