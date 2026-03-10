# Redis

## 工具介绍

Redis 是一个基于内存的键值数据库，常被拿来做缓存、计数器、排行榜、分布式锁和轻量消息队列。菜鸟教程把它放在“数据结构服务器”的位置来介绍，这个抓手是对的：Redis 不只是把值存进去再取出来，它的 value 本身就可以是字符串、哈希、列表、集合和有序集合，所以它经常既像缓存，也像一个提供数据结构能力的服务。citeturn0search4turn0search5

在项目里，Redis 最常见的价值有三类。第一类是快，用内存换响应时间和吞吐。第二类是抗压，把热点读流量从数据库前面拦下来。第三类是做一些数据库不适合直接做的事情，比如短期状态、过期控制、排行榜和分布式协调。

但 Redis 也不是“快就完事”。一旦放进项目，就会碰到过期、淘汰、持久化、一致性和误删等问题，所以笔记里不能只讲原理，不讲基本操作。

## 核心机制

### 通信模型

Redis 服务器默认监听 `6379` 端口，客户端通过 TCP 与它通信，最常见的命令行工具是 `redis-cli`。从菜鸟教程的示例也能看到，平时查看实例状态、执行命令、看内存和客户端连接，都是通过 `redis-cli` 连上服务后完成的。citeturn0search5

很多人会把 Redis 直接理解成“单线程”，这说法不完整。更准确的理解是：Redis 的命令执行路径长期以单线程为主，这让它避免了复杂的锁竞争；同时它用 I/O 多路复用处理大量连接，让单个进程也能扛住很多网络请求。这个机制解释了两个现象：一是 Redis 在大量小请求场景里很快，二是某个慢命令会拖住别的请求，所以线上特别怕 `KEYS *` 这类重操作。

### 数据类型

Redis 最常用的数据类型有五个：

#### String

最常用，适合缓存对象序列化结果、验证码、计数值、分布式锁标记。常用命令：

```bash
SET user:1 "tom"
GET user:1
INCR page:view
SET login:code:13800000000 123456 EX 300
```

#### Hash

适合放对象的部分字段，比如用户信息、商品摘要。常用命令：

```bash
HSET user:1001 name alice age 20
HGET user:1001 name
HGETALL user:1001
```

#### List

适合简单队列、消息缓冲、时间线。常用命令：

```bash
LPUSH queue:order 1001
RPUSH queue:order 1002
LPOP queue:order
LRANGE queue:order 0 -1
```

#### Set

适合去重、标签集合、共同关注。常用命令：

```bash
SADD tag:java user1 user2 user3
SMEMBERS tag:java
SISMEMBER tag:java user1
```

#### Sorted Set

适合排行榜、延迟任务、按分值排序的集合。常用命令：

```bash
ZADD rank:game 100 alice 90 bob
ZRANGE rank:game 0 -1 WITHSCORES
ZREVRANGE rank:game 0 9 WITHSCORES
```

菜鸟教程把这些类型作为 Redis 入门前置知识来讲，这是非常合理的，因为 Redis 的“怎么用”很大程度取决于你是否选对了数据类型。citeturn0search4

### 过期与淘汰

Redis 很适合保存“会失效”的数据，比如验证码、登录状态、短期缓存。常用命令有：

```bash
EXPIRE session:abc 1800
TTL session:abc
SET cache:product:1 "..." EX 600
DEL cache:product:1
```

过期解决的是“这条数据什么时候自动失效”，淘汰解决的是“内存不够时先扔谁”。项目里这两件事要分开理解。你给 key 设置了过期时间，不代表内存永远安全；你开了淘汰策略，也不代表缓存一致性自然就有了。

### 持久化

Redis 可以只当纯缓存，也可以开启持久化减少故障后的数据损失。最常见的是 RDB 和 AOF：

- RDB：按快照落盘，恢复快，但可能丢一段时间的数据。
- AOF：按命令追加日志，数据更完整，但文件会更大。

如果项目里 Redis 只放缓存，通常更关心“挂了能不能快速恢复”；如果 Redis 里放了不能轻易丢的状态，就要认真考虑持久化和主从复制。

## 基本使用

### 连接

```bash
redis-cli
redis-cli -h 127.0.0.1 -p 6379
redis-cli -a yourpassword
```

连进去后最常用的不是花哨命令，而是这几个：

```bash
PING
INFO
DBSIZE
SELECT 0
```

`INFO` 很重要，菜鸟教程的 Redis 服务器页就是通过 `INFO` 来看版本、内存、客户端数量等信息的。线上遇到“Redis 卡了没有”“内存打满没有”“连接是不是很多”，最先看它。citeturn0search5

### 查看与读取数据

```bash
GET key
TYPE key
EXISTS key
TTL key
HGETALL key
LRANGE key 0 -1
SMEMBERS key
ZRANGE key 0 -1 WITHSCORES
```

如果领导让你“去 Redis 看一下这个数据在不在”，基本就是这套路径：
1. 先连上实例。
2. 先确认库号和 key 前缀。
3. 先用 `TYPE` 看类型。
4. 再用对应命令取值。

### 查找 key

开发环境可以偶尔用：

```bash
KEYS user:*
```

但线上不建议这样扫。更稳的是：

```bash
SCAN 0 MATCH user:* COUNT 100
```

这件事特别重要，因为很多人一开始只会 `KEYS *`，结果把实例扫卡了。

### 删除与修改

```bash
DEL key
UNLINK key
SET key value
MGET key1 key2 key3
MSET key1 v1 key2 v2
```

删除前先看环境、实例和 key 前缀。线上最怕的不是不会删，是删错。

## 项目工程中的使用

### 缓存

这是最常见的用法。比如商品详情、用户信息摘要、首页热点数据，先查 Redis，没命中再查数据库，然后回填缓存。这里通常会配合过期时间和删除缓存策略使用。

### 分布式会话与短期状态

登录状态、验证码、限流窗口、短信发送频率、接口防重复提交，都很适合放 Redis，因为它天然支持过期。

### 计数器与排行榜

访问量、点赞数、在线人数、游戏榜单，经常直接落到 `INCR` 或 `ZSET` 上。

### 分布式协调

像简单分布式锁、幂等标记、任务抢占，也经常会先想到 Redis。但这种用法就不能只会命令了，还要知道超时、续期和误删问题。

## 常见问题与注意点

第一，Redis 快，不代表什么都该放进去。大对象、冷数据、强一致数据都不适合随便塞。

第二，先看类型再读值。很多人看到一个 key 就直接 `GET`，结果报错，因为它可能是 hash 或 zset。

第三，线上查 key 尽量用 `SCAN`，不要动不动 `KEYS *`。

第四，缓存更新要想清楚路径。数据库改了、Redis 没删，读到旧值是最常见的问题。

第五，别把 Redis 当数据库原理的替代品。它很强，但很多业务主数据仍然应该放在关系型数据库里。
