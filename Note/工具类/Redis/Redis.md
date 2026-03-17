# Redis

REmote DIctionary Server(Redis) 是一个由 Salvatore Sanfilippo 写的 key-value 存储系统，是跨平台的非关系型数据库。Redis 是一个开源的使用 ANSI C 语言编写、遵守 BSD 协议、支持网络、可基于内存、分布式、可选持久性的键值对(Key-Value)存储数据库，并提供多种语言的 API。Redis 通常被称为数据结构服务器，因为值（value）可以是字符串(String)、哈希(Hash)、列表(list)、集合(sets)和有序集合(sorted sets)等类型。

## 核心机制



## Redis 数据类型

------

### String

string 是 redis 最基本的类型，你可以理解成与 Memcached 一模一样的类型，一个 key 对应一个 value。string 类型是二进制安全的。意思是 redis 的 string 可以包含任何数据，比如jpg图片或者序列化的对象。string 类型是 Redis 最基本的数据类型，string 类型的值最大能存储 512MB。

**常用命令**：

- `SET key value`：设置键的值。
- `GET key`：获取键的值。
- `INCR key`：将键的值加 1。
- `DECR key`：将键的值减 1。
- `APPEND key value`：将值追加到键的值之后。

```shell
SET runoob "菜鸟教程"
OK
GET runoob
"菜鸟教程"
```

在以上实例中我们使用了 Redis 的 **SET** 和 **GET** 命令。键为 runoob，对应的值为 **菜鸟教程**。

**注意：**一个键最大能存储 512MB。

### Hash

Redis hash 是一个键值(key=>value)对集合，类似于一个小型的 NoSQL 数据库。Redis hash 是一个 string 类型的 field 和 value 的映射表，hash 特别适合用于存储对象。每个哈希最多可以存储 2^32 - 1 个键值对。

**常用命令**：

- `HSET key field value`：设置哈希表中字段的值。
- `HGET key field`：获取哈希表中字段的值。
- `HGETALL key`：获取哈希表中所有字段和值。
- `HDEL key field`：删除哈希表中的一个或多个字段。

```shell
HMSET runoob field1 "Hello" field2 "World"
"OK"
HGET runoob field1
"Hello"
HGET runoob field2
"World"
```

实例中我们使用了 Redis **HMSET, HGET** 命令，**HMSET** 设置了两个 **field=>value** 对, HGET 获取对应 **field** 对应的 **value**。

### List

Redis 列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素到列表的头部（左边）或者尾部（右边）。列表最多可以存储 2^32 - 1 个元素。

**常用命令**：

- `LPUSH key value`：将值插入到列表头部。
- `RPUSH key value`：将值插入到列表尾部。
- `LPOP key`：移出并获取列表的第一个元素。
- `RPOP key`：移出并获取列表的最后一个元素。
- `LRANGE key start stop`：获取列表在指定范围内的元素。

```shell
lpush runoob redis
(integer) 1
lpush runoob mongodb
(integer) 2
lpush runoob rabbitmq
(integer) 3
lrange runoob 0 10
1) "rabbitmq"
2) "mongodb"
3) "redis"
```

------

### Set

Redis 的 Set 是 string 类型的无序集合。集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是 O(1)。

**常用命令**：

- `SADD key value`：向集合添加一个或多个成员。
- `SREM key value`：移除集合中的一个或多个成员。
- `SMEMBERS key`：返回集合中的所有成员。
- `SISMEMBER key value`：判断值是否是集合的成员。



```
sadd runoob redis
(integer) 1
sadd runoob mongodb
(integer) 1
sadd runoob rabbitmq
(integer) 1
sadd runoob rabbitmq
(integer) 0
smembers runoob
1) "redis"
2) "rabbitmq"
3) "mongodb"
```

**注意：**以上实例中 rabbitmq 添加了两次，但根据集合内元素的唯一性，第二次插入的元素将被忽略。集合中最大的成员数为 232 - 1(4294967295, 每个集合可存储40多亿个成员)。

### zset

Redis zset 和 set 一样也是string类型元素的集合,且不允许重复的成员。不同的是每个元素都会关联一个double类型的分数。redis正是通过分数来为集合中的成员进行从小到大的排序。zset的成员是唯一的,但分数(score)却可以重复。

**常用命令**：

- `ZADD key score value`：向有序集合添加一个或多个成员，或更新已存在成员的分数。
- `ZRANGE key start stop [WITHSCORES]`：返回指定范围内的成员。
- `ZREM key value`：移除有序集合中的一个或多个成员。
- `ZSCORE key value`：返回有序集合中，成员的分数值。

```
zadd runoob 0 redis
(integer) 1
zadd runoob 0 mongodb
(integer) 1
zadd runoob 0 rabbitmq
(integer) 1
zadd runoob 0 rabbitmq
(integer) 0
redis 127.0.0.1:6379> ZRANGEBYSCORE runoob 0 1000
1) "mongodb"
2) "rabbitmq"
3) "redis"
```
**总结如下：**

| 类型                 | 简介                                                   | 特性                                                         | 场景                                                         |
| :------------------- | :----------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| String(字符串)       | 二进制安全                                             | 可以包含任何数据,比如jpg图片或者序列化的对象,一个键最大能存储512M | ---                                                          |
| Hash(字典)           | 键值对集合,即编程语言中的Map类型                       | 适合存储对象,并且可以像数据库中update一个属性一样只修改某一项属性值(Memcached中需要取出整个字符串反序列化成对象修改完再序列化存回去) | 存储、读取、修改用户属性                                     |
| List(列表)           | 链表(双向链表)                                         | 增删快,提供了操作某一段元素的API                             | 1,最新消息排行等功能(比如朋友圈的时间线) 2,消息队列          |
| Set(集合)            | 哈希表实现,元素不重复                                  | 1、添加、删除,查找的复杂度都是O(1) 2、为集合提供了求交集、并集、差集等操作 | 1、共同好友 2、利用唯一性,统计访问网站的所有独立ip 3、好友推荐时,根据tag求交集,大于某个阈值就可以推荐 |
| Sorted Set(有序集合) | 将Set中的元素增加一个权重参数score,元素按score有序排列 | 数据插入集合时,已经进行天然排序                              | 1、排行榜 2、带权重的消息队列                                |



### 其他高级数据类似

#### HyperLogLog

- 用于基数估计算法的数据结构。
- 常用于统计唯一值的近似值。

#### Bitmaps

- 位数组，可以对字符串进行位操作。
- 常用于实现布隆过滤器等位操作。

#### Geospatial Indexes

- 处理地理空间数据，支持地理空间索引和半径查询。
  - Streams
  - 日志数据类型，支持时间序列数据。用于消息队列和实时数据处理。

## Redis 命令

### 配置命令 

Redis 的配置文件位于 Redis 安装目录下，文件名为 **redis.conf**(Windows 名为 redis.windows.conf)。你可以通过 **CONFIG** 命令查看或设置配置项。Redis CONFIG 命令格式如下：

```sql
CONFIG GET CONFIG_SETTING_NAME
```

| 配置项                            | 说明                                                         |
| :-------------------------------- | :----------------------------------------------------------- |
| daemonize no                      | Redis 默认不是以守护进程方式运行，可通过设置为 yes 启用守护进程；Windows 不支持，通常为 no。 |
| pidfile /var/run/redis.pid        | 当 Redis 以守护进程方式运行时，用于指定保存进程 ID 的文件路径。 |
| port 6379                         | 指定 Redis 监听端口，默认端口为 6379。                       |
| bind 127.0.0.1                    | 指定 Redis 绑定的主机地址。                                  |
| timeout 300                       | 指定客户端空闲多少秒后关闭连接；设置为 0 表示禁用该功能。    |
| loglevel notice                   | 指定日志级别，可选 debug、verbose、notice、warning，默认是 notice。 |
| logfile stdout                    | 指定日志输出方式，默认输出到标准输出。                       |
| databases 16                      | 设置数据库数量，默认可用 16 个数据库，默认使用 0 号库。      |
| save \<seconds> \<changes>        | 指定在一定时间内发生多少次更新操作后，将数据同步到数据文件，可配置多个条件。 |
| rdbcompression yes                | 指定本地持久化时是否压缩数据，默认开启。                     |
| dbfilename dump.rdb               | 指定本地数据库文件名，默认是 dump.rdb。                      |
| dir ./                            | 指定本地数据库文件存放目录。                                 |
| slaveof \<masterip> \<masterport> | 设置当前实例作为从节点时对应主节点的 IP 和端口，启动时自动同步数据。 |
| masterauth \<master-password>     | 当主节点设置了密码时，从节点连接主节点所需的认证密码。       |
| requirepass foobared              | 设置 Redis 访问密码，客户端连接后需使用 AUTH 命令认证。      |
| maxclients 128                    | 设置同一时间允许的最大客户端连接数。                         |
| maxmemory \<bytes>                | 指定 Redis 可使用的最大内存，达到上限后会按策略清理数据或拒绝写入。 |
| appendonly no                     | 指定是否开启 AOF 持久化，默认关闭。                          |
| appendfilename appendonly.aof     | 指定 AOF 持久化文件名。                                      |
| appendfsync everysec              | 指定 AOF 刷盘策略，可选 no、always、everysec。               |
| vm-enabled no                     | 指定是否启用虚拟内存机制，默认关闭。                         |
| vm-swap-file /tmp/redis.swap      | 指定虚拟内存交换文件路径。                                   |
| vm-max-memory 0                   | 指定超过多少内存的数据写入虚拟内存；为 0 时表示 value 可全部写入磁盘。 |
| vm-page-size 32                   | 设置 swap 文件中每个 page 的大小。                           |
| vm-pages 134217728                | 设置 swap 文件中的 page 数量。                               |
| vm-max-threads 4                  | 设置访问 swap 文件的线程数。                                 |
| glueoutputbuf yes                 | 指定是否将较小的响应包合并后再发送给客户端，默认开启。       |
| hash-max-zipmap-entries 64        | 指定哈希对象在满足一定条件时使用特殊压缩存储结构的阈值。     |
| hash-max-zipmap-value 512         | 指定哈希对象中单个元素值大小的阈值，超过后不再使用特殊压缩存储结构。 |
| activerehashing yes               | 指定是否开启主动重哈希，默认开启。                           |
| include /path/to/local.conf       | 指定包含其他配置文件，便于多个 Redis 实例复用公共配置。      |

### 连接命令

Redis 命令用于在 redis 服务上执行操作。要在 redis 服务上执行命令需要一个 redis 客户端。Redis 客户端在我们之前下载的的 redis 的安装包中。启动 redis 服务器，打开终端并输入命令 **redis-cli**，该命令会连接本地/远程的 redis 服务：

```shell
redis-cli [ -h host -p port -a password ] 
```

| 命令                                      | 效果                   |
| :---------------------------------------- | :--------------------- |
| AUTH password                             | 验证密码是否正确。     |
| ECHO message                              | 返回并打印给定字符串。 |
| PING                                      | 检查服务是否正常运行。 |
| QUIT                                      | 关闭当前连接。         |
| SELECT index                              | 切换到指定的数据库。   |
| redis-cli [ -h host -p port -a password ] | 连接服务器             |

### 数据操作命令

#### 键命令

Redis 键命令用于管理 redis 的键。

下表给出了与 Redis 键相关的基本命令：
| 命令 | 效果 |
| :--- | :--- |
| DEL key | 在 key 存在时删除 key。 |
| DUMP key | 序列化给定 key，并返回被序列化的值。 |
| EXISTS key | 检查给定 key 是否存在。 |
| EXPIRE key seconds | 为给定 key 设置过期时间，以秒计。 |
| EXPIREAT key timestamp | 为 key 设置过期时间，参数为 UNIX 时间戳。 |
| PEXPIRE key milliseconds | 设置 key 的过期时间，以毫秒计。 |
| PEXPIREAT key milliseconds-timestamp | 设置 key 过期时间的时间戳，以毫秒计。 |
| KEYS pattern | 查找所有符合给定模式（pattern）的 key。 |
| MOVE key db | 将当前数据库的 key 移动到给定的数据库 db 中。 |
| PERSIST key | 移除 key 的过期时间，key 将持久保持。 |
| PTTL key | 以毫秒为单位返回 key 的剩余过期时间。 |
| TTL key | 以秒为单位返回给定 key 的剩余生存时间。 |
| RANDOMKEY | 从当前数据库中随机返回一个 key。 |
| RENAME key newkey | 修改 key 的名称。 |
| RENAMENX key newkey | 仅当 newkey 不存在时，将 key 改名为 newkey。 |
| SCAN cursor [MATCH pattern] [COUNT count] | 迭代数据库中的键。 |
| TYPE key | 返回 key 所存储值的类型。 |

#### 字符串命令

Redis 字符串数据类型的相关命令用于管理 redis 字符串值，基本语法如下：

| 命令                             | 效果                                                         |
| :------------------------------- | :----------------------------------------------------------- |
| SET key value                    | 设置指定 key 的值。                                          |
| GET key                          | 获取指定 key 的值。                                          |
| GETRANGE key start end           | 返回 key 中字符串值的子字符串。                              |
| GETSET key value                 | 将给定 key 的值设为 value，并返回 key 的旧值。               |
| GETBIT key offset                | 获取 key 所存储字符串值中指定偏移量上的位。                  |
| MGET key1 [key2..]               | 获取一个或多个给定 key 的值。                                |
| SETBIT key offset value          | 对 key 所存储的字符串值设置或清除指定偏移量上的位。          |
| SETEX key seconds value          | 将值 value 关联到 key，并将 key 的过期时间设为 seconds（秒）。 |
| SETNX key value                  | 仅在 key 不存在时设置 key 的值。                             |
| SETRANGE key offset value        | 用 value 覆写给定 key 所存储的字符串值，从偏移量 offset 开始。 |
| STRLEN key                       | 返回 key 所存储字符串值的长度。                              |
| MSET key value [key value ...]   | 同时设置一个或多个 key-value 对。                            |
| MSETNX key value [key value ...] | 同时设置一个或多个 key-value 对，但仅当所有给定 key 都不存在时才设置。 |
| PSETEX key milliseconds value    | 将值 value 关联到 key，并将 key 的过期时间设为 milliseconds（毫秒）。 |
| INCR key                         | 将 key 中存储的数字值加一。                                  |
| INCRBY key increment             | 将 key 所存储的值加上给定的增量值。                          |
| INCRBYFLOAT key increment        | 将 key 所存储的值加上给定的浮点增量值。                      |
| DECR key                         | 将 key 中存储的数字值减一。                                  |
| DECRBY key decrement             | 将 key 所存储的值减去给定的减量值。                          |
| APPEND key value                 | 如果 key 已存在且是字符串，则将指定的 value 追加到原值末尾。 |

#### 哈希命令

Redis hash 是一个 string 类型的 field（字段） 和 value（值） 的映射表，hash 特别适合用于存储对象。Redis 中每个 hash 可以存储 232 - 1 键值对（40多亿）。

| 命令                                           | 效果                                                  |
| :--------------------------------------------- | :---------------------------------------------------- |
| HDEL key field1 [field2]                       | 删除一个或多个哈希表字段。                            |
| HEXISTS key field                              | 查看哈希表 key 中指定字段是否存在。                   |
| HGET key field                                 | 获取哈希表中指定字段的值。                            |
| HGETALL key                                    | 获取哈希表 key 中的所有字段和值。                     |
| HINCRBY key field increment                    | 为哈希表 key 中指定字段的整数值加上增量 increment。   |
| HINCRBYFLOAT key field increment               | 为哈希表 key 中指定字段的浮点数值加上增量 increment。 |
| HKEYS key                                      | 获取哈希表中的所有字段。                              |
| HLEN key                                       | 获取哈希表中字段的数量。                              |
| HMGET key field1 [field2]                      | 获取一个或多个给定字段的值。                          |
| HMSET key field1 value1 [field2 value2]        | 同时将多个 field-value 对设置到哈希表 key 中。        |
| HSET key field value                           | 将哈希表 key 中字段 field 的值设为 value。            |
| HSETNX key field value                         | 只有在字段 field 不存在时，设置哈希表字段的值。       |
| HVALS key                                      | 获取哈希表中的所有值。                                |
| HSCAN key cursor [MATCH pattern] [COUNT count] | 迭代哈希表中的键值对。                                |

#### 列表命令

Redis列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素到列表的头部（左边）或者尾部（右边）

一个列表最多可以包含 232 - 1 个元素 (4294967295, 每个列表超过40亿个元素)。

| 命令                                  | 效果                                                         |
| :------------------------------------ | :----------------------------------------------------------- |
| BLPOP key1 [key2] timeout             | 移出并获取列表的第一个元素；如果列表没有元素，则会阻塞直到超时或发现可弹出元素。 |
| BRPOP key1 [key2] timeout             | 移出并获取列表的最后一个元素；如果列表没有元素，则会阻塞直到超时或发现可弹出元素。 |
| BRPOPLPUSH source destination timeout | 从列表中弹出一个值，将其插入到另一个列表中并返回；如果列表没有元素，则会阻塞直到超时或发现可弹出元素。 |
| LINDEX key index                      | 通过索引获取列表中的元素。                                   |
| LINSERT key BEFORE\|AFTER pivot value | 在列表的指定元素前或后插入元素。                             |
| LLEN key                              | 获取列表长度。                                               |
| LPOP key                              | 移出并获取列表的第一个元素。                                 |
| LPUSH key value1 [value2]             | 将一个或多个值插入到列表头部。                               |
| LPUSHX key value                      | 将一个值插入到已存在的列表头部。                             |
| LRANGE key start stop                 | 获取列表指定范围内的元素。                                   |
| LREM key count value                  | 移除列表中的元素。                                           |
| LSET key index value                  | 通过索引设置列表元素的值。                                   |
| LTRIM key start stop                  | 修剪列表，只保留指定区间内的元素，删除区间之外的元素。       |
| RPOP key                              | 移除列表的最后一个元素，并返回该元素。                       |
| RPOPLPUSH source destination          | 移除列表的最后一个元素，并将其添加到另一个列表中后返回。     |
| RPUSH key value1 [value2]             | 在列表尾部添加一个或多个值。                                 |
| RPUSHX key value                      | 为已存在的列表添加值。                                       |

#### 集合命令

Redis 的 Set 是 String 类型的无序集合。集合成员是唯一的，这就意味着集合中不能出现重复的数据。集合对象的编码可以是 intset 或者 hashtable。Redis 中集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是 O(1)。集合中最大的成员数为 2^32 - 1 (4294967295, 每个集合可存储40多亿个成员)。

| 命令                                           | 效果                                                        |
| :--------------------------------------------- | :---------------------------------------------------------- |
| SADD key member1 [member2]                     | 向集合添加一个或多个成员。                                  |
| SCARD key                                      | 获取集合中的成员数量。                                      |
| SDIFF key1 [key2]                              | 返回第一个集合与其他集合之间的差集。                        |
| SDIFFSTORE destination key1 [key2]             | 计算给定集合的差集，并将结果存储在 destination 中。         |
| SINTER key1 [key2]                             | 返回给定所有集合的交集。                                    |
| SINTERSTORE destination key1 [key2]            | 计算给定所有集合的交集，并将结果存储在 destination 中。     |
| SISMEMBER key member                           | 判断 member 是否为集合 key 的成员。                         |
| SMEMBERS key                                   | 返回集合中的所有成员。                                      |
| SMOVE source destination member                | 将 member 从 source 集合移动到 destination 集合。           |
| SPOP key                                       | 移除并返回集合中的一个随机元素。                            |
| SRANDMEMBER key [count]                        | 返回集合中的一个或多个随机成员。                            |
| SREM key member1 [member2]                     | 移除集合中的一个或多个成员。                                |
| SUNION key1 [key2]                             | 返回给定所有集合的并集。                                    |
| SUNIONSTORE destination key1 [key2]            | 计算所有给定集合的并集，并将结果存储在 destination 集合中。 |
| SSCAN key cursor [MATCH pattern] [COUNT count] | 迭代集合中的元素。                                          |

#### 有序集合命令

Redis 有序集合和集合一样也是 string 类型元素的集合,且不允许重复的成员。不同的是每个元素都会关联一个 double 类型的分数。redis 正是通过分数来为集合中的成员进行从小到大的排序。有序集合的成员是唯一的,但分数(score)却可以重复。集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是 O(1)。 集合中最大的成员数为 232 - 1 (4294967295, 每个集合可存储40多亿个成员)。

| 命令                                                        | 效果                                                         |
| :---------------------------------------------------------- | :----------------------------------------------------------- |
| ZADD key score1 member1 [score2 member2]                    | 向有序集合添加一个或多个成员，或更新已存在成员的分数。       |
| ZCARD key                                                   | 获取有序集合的成员数量。                                     |
| ZCOUNT key min max                                          | 计算有序集合中指定分数区间内的成员数量。                     |
| ZINCRBY key increment member                                | 为有序集合中指定成员的分数增加给定增量。                     |
| ZINTERSTORE destination numkeys key [key ...]               | 计算一个或多个有序集合的交集，并将结果存储到新的有序集合 destination 中。 |
| ZLEXCOUNT key min max                                       | 计算有序集合中指定字典区间内的成员数量。                     |
| ZRANGE key start stop [WITHSCORES]                          | 按索引区间返回有序集合中的成员。                             |
| ZRANGEBYLEX key min max [LIMIT offset count]                | 按字典区间返回有序集合中的成员。                             |
| ZRANGEBYSCORE key min max [WITHSCORES] [LIMIT offset count] | 按分数区间返回有序集合中的成员。                             |
| ZRANK key member                                            | 返回有序集合中指定成员的排名（按分数从小到大）。             |
| ZREM key member [member ...]                                | 移除有序集合中的一个或多个成员。                             |
| ZREMRANGEBYLEX key min max                                  | 移除有序集合中指定字典区间内的所有成员。                     |
| ZREMRANGEBYRANK key start stop                              | 移除有序集合中指定排名区间内的所有成员。                     |
| ZREMRANGEBYSCORE key min max                                | 移除有序集合中指定分数区间内的所有成员。                     |
| ZREVRANGE key start stop [WITHSCORES]                       | 按索引区间返回有序集合中的成员，分数从高到低排序。           |
| ZREVRANGEBYSCORE key max min [WITHSCORES]                   | 按分数区间返回有序集合中的成员，分数从高到低排序。           |
| ZREVRANK key member                                         | 返回有序集合中指定成员的排名（按分数从高到低）。             |
| ZSCORE key member                                           | 返回有序集合中指定成员的分数。                               |
| ZUNIONSTORE destination numkeys key [key ...]               | 计算一个或多个有序集合的并集，并将结果存储到新的 key 中。    |
| ZSCAN key cursor [MATCH pattern] [COUNT count]              | 迭代有序集合中的元素，包括成员和分数。                       |

#### HyperLogLog

Redis 在 2.8.9 版本添加了 HyperLogLog 结构。Redis HyperLogLog 是用来做基数统计的算法，HyperLogLog 的优点是，在输入元素的数量或者体积非常非常大时，计算基数所需的空间总是固定 的、并且是很小的。

在 Redis 里面，每个 HyperLogLog 键只需要花费 12 KB 内存，就可以计算接近 2^64 个不同元素的基 数。这和计算基数时，元素越多耗费内存就越多的集合形成鲜明对比。但是，因为 HyperLogLog 只会根据输入元素来计算基数，而不会储存输入元素本身，所以 HyperLogLog 不能像集合那样，返回输入的各个元素。

**基数**：比如数据集 {1, 3, 5, 7, 5, 7, 8}， 那么这个数据集的基数集为 {1, 3, 5 ,7, 8}, 基数(不重复元素)为5。 基数估计就是在误差可接受的范围内，快速计算基数。

| 命令                                      | 效果                                        |
| :---------------------------------------- | :------------------------------------------ |
| PFADD key element [element ...]           | 向 HyperLogLog 中添加一个或多个元素。       |
| PFCOUNT key [key ...]                     | 返回一个或多个 HyperLogLog 的基数估算值。   |
| PFMERGE destkey sourcekey [sourcekey ...] | 将多个 HyperLogLog 合并为一个 HyperLogLog。 |

### 发布订阅命令

Redis 发布订阅 (pub/sub) 是一种消息通信模式：发送者 (pub) 发送消息，订阅者 (sub) 接收消息。

Redis 客户端可以订阅任意数量的频道。

下图展示了频道 channel1 ， 以及订阅这个频道的三个客户端 —— client2 、 client5 和 client1 之间的关系：

![img](https://www.runoob.com/wp-content/uploads/2014/11/pubsub1.png)

当有新消息通过 PUBLISH 命令发送给频道 channel1 时， 这个消息就会被发送给订阅它的三个客户端：

![img](https://www.runoob.com/wp-content/uploads/2014/11/pubsub2.png)

| 命令                                        | 效果                               |
| :------------------------------------------ | :--------------------------------- |
| PSUBSCRIBE pattern [pattern ...]            | 订阅一个或多个符合给定模式的频道。 |
| PUBSUB subcommand [argument [argument ...]] | 查看发布与订阅系统的状态。         |
| PUBLISH channel message                     | 将消息发送到指定频道。             |
| PUNSUBSCRIBE [pattern [pattern ...]]        | 退订一个或多个给定模式的频道。     |
| SUBSCRIBE channel [channel ...]             | 订阅一个或多个指定频道的信息。     |
| UNSUBSCRIBE [channel [channel ...]]         | 退订一个或多个给定频道。           |

### 事务命令

单个 Redis 命令的执行是原子性的，但 Redis 没有在事务上增加任何维持原子性的机制，所以 Redis 事务的执行并不是原子性的。事务可以理解为一个打包的批量执行脚本，但批量指令并非原子化的操作，中间某条指令的失败不会导致前面已做指令的回滚，也不会造成后续的指令不做。Redis 事务可以一次执行多个命令， 并且带有以下三个重要的保证：

- 批量操作在发送 EXEC 命令前被放入队列缓存。
- 收到 EXEC 命令后进入事务执行，事务中任意命令执行失败，其余的命令依然被执行。
- 在事务执行过程，其他客户端提交的命令请求不会插入到事务执行命令序列中。

一个事务从开始到执行会经历以下三个阶段：开始事务、命令入队、执行事务。

| 命令                | 效果                                                         |
| :------------------ | :----------------------------------------------------------- |
| DISCARD             | 取消事务，放弃执行事务块内的所有命令。                       |
| EXEC                | 执行事务块内的所有命令。                                     |
| MULTI               | 标记一个事务块的开始。                                       |
| UNWATCH             | 取消 WATCH 命令对所有 key 的监视。                           |
| WATCH key [key ...] | 监视一个或多个 key；如果这些 key 在事务执行前被其他命令改动，事务将被打断。 |

### 脚本命令

Redis 脚本使用 Lua 解释器来执行脚本。 Redis 2.6 版本通过内嵌支持 Lua 环境。执行脚本的常用命令为 **EVAL**。

| 命令                                             | 效果                                      |
| :----------------------------------------------- | :---------------------------------------- |
| EVAL script numkeys key [key ...] arg [arg ...]  | 执行 Lua 脚本。                           |
| EVALSHA sha1 numkeys key [key ...] arg [arg ...] | 根据脚本的 SHA1 值执行已缓存的 Lua 脚本。 |
| SCRIPT EXISTS script [script ...]                | 查看指定脚本是否已存在于脚本缓存中。      |
| SCRIPT FLUSH                                     | 清空脚本缓存中的所有脚本。                |
| SCRIPT KILL                                      | 杀死当前正在运行的 Lua 脚本。             |
| SCRIPT LOAD script                               | 将脚本加载到缓存中，但不立即执行。        |

### 服务器命令

Redis 服务器命令主要是用于管理 redis 服务。

| 命令                                         | 效果                                            |
| :------------------------------------------- | :---------------------------------------------- |
| BGREWRITEAOF                                 | 异步执行 AOF（Append Only File）重写操作。      |
| BGSAVE                                       | 在后台异步将当前数据库的数据保存到磁盘。        |
| CLIENT KILL [ip:port] [ID client-id]         | 关闭指定的客户端连接。                          |
| CLIENT LIST                                  | 获取连接到服务器的客户端连接列表。              |
| CLIENT GETNAME                               | 获取当前连接的名称。                            |
| CLIENT PAUSE timeout                         | 在指定时间内暂停处理来自客户端的命令。          |
| CLIENT SETNAME connection-name               | 设置当前连接的名称。                            |
| CLUSTER SLOTS                                | 获取集群节点的槽位映射数组。                    |
| COMMAND                                      | 获取 Redis 命令详情数组。                       |
| COMMAND COUNT                                | 获取 Redis 命令总数。                           |
| COMMAND GETKEYS                              | 获取给定命令中的所有键。                        |
| TIME                                         | 返回当前服务器时间。                            |
| COMMAND INFO command-name [command-name ...] | 获取指定 Redis 命令的描述信息。                 |
| CONFIG GET parameter                         | 获取指定配置参数的值。                          |
| CONFIG REWRITE                               | 改写 Redis 启动时指定的 redis.conf 配置文件。   |
| CONFIG SET parameter value                   | 修改 Redis 配置参数，无需重启服务。             |
| CONFIG RESETSTAT                             | 重置 INFO 命令中的部分统计数据。                |
| DBSIZE                                       | 返回当前数据库中 key 的数量。                   |
| DEBUG OBJECT key                             | 获取指定 key 的调试信息。                       |
| DEBUG SEGFAULT                               | 使 Redis 服务发生崩溃，仅用于调试。             |
| FLUSHALL                                     | 删除所有数据库中的所有 key。                    |
| FLUSHDB                                      | 删除当前数据库中的所有 key。                    |
| INFO [section]                               | 获取 Redis 服务器的各种信息和统计数据。         |
| LASTSAVE                                     | 返回最近一次成功将数据保存到磁盘的时间戳。      |
| MONITOR                                      | 实时打印 Redis 服务器接收到的命令，常用于调试。 |
| ROLE                                         | 返回当前实例在主从复制中的角色。                |
| SAVE                                         | 同步将数据保存到硬盘。                          |
| SHUTDOWN [NOSAVE] [SAVE]                     | 关闭服务器，并可选择是否保存数据。              |
| SLAVEOF host port                            | 将当前服务器设置为指定主服务器的从服务器。      |
| SLOWLOG subcommand [argument]                | 管理 Redis 慢日志。                             |
| SYNC                                         | 用于复制功能的内部命令。                        |

### 地理命令 GEO

Redis GEO 主要用于存储地理位置信息，并对存储的信息进行操作，该功能在 Redis 3.2 版本新增。Redis GEO 操作方法有：

- geoadd：添加地理位置的坐标。
- geopos：获取地理位置的坐标。
- geodist：计算两个位置之间的距离。
- georadius：根据用户给定的经纬度坐标来获取指定范围内的地理位置集合。
- georadiusbymember：根据储存在位置集合里面的某个地点获取指定范围内的地理位置集合。
- geohash：返回一个或多个位置对象的 geohash 值。

#### geoadd

geoadd 用于存储指定的地理空间位置，可以将一个或多个经度(longitude)、纬度(latitude)、位置名称(member)添加到指定的 key 中。

geoadd 语法格式如下：

```
GEOADD key longitude latitude member [longitude latitude member ...]
```

#### geopos

geopos 用于从给定的 key 里返回所有指定名称(member)的位置（经度和纬度），不存在的返回 nil。

geopos 语法格式如下：

```
GEOPOS key member [member ...]
```

#### geodist

geodist 用于返回两个给定位置之间的距离。geodist 语法格式如下：

```
GEODIST key member1 member2 [m|km|ft|mi]
```

member1 member2 为两个地理位置。

最后一个距离单位参数说明：

- m ：米，默认单位。
- km ：千米。
- mi ：英里。
- ft ：英尺。

#### georadius、georadiusbymember

georadius 以给定的经纬度为中心， 返回键包含的位置元素当中， 与中心的距离不超过给定最大距离的所有位置元素。

georadiusbymember 和 GEORADIUS 命令一样， 都可以找出位于指定范围内的元素， 但是 georadiusbymember 的中心点是由给定的位置元素决定的， 而不是使用经度和纬度来决定中心点。

georadius 与 georadiusbymember 语法格式如下：

```sql
GEORADIUS key longitude latitude radius m|km|ft|mi [WITHCOORD] [WITHDIST] [WITHHASH] [COUNT count] [ASC|DESC] [STORE key] [STOREDIST key] 
GEORADIUSBYMEMBER key member radius m|km|ft|mi [WITHCOORD] [WITHDIST] [WITHHASH] [COUNT count] [ASC|DESC] [STORE key] [STOREDIST key]


```

参数说明：

- m ：米，默认单位。
- km ：千米。
- mi ：英里。
- ft ：英尺。
- WITHDIST: 在返回位置元素的同时， 将位置元素与中心之间的距离也一并返回。
- WITHCOORD: 将位置元素的经度和纬度也一并返回。
- WITHHASH: 以 52 位有符号整数的形式， 返回位置元素经过原始 geohash 编码的有序集合分值。 这个选项主要用于底层应用或者调试， 实际中的作用并不大。
- COUNT 限定返回的记录数。
- ASC: 查找结果根据距离从近到远排序。
- DESC: 查找结果根据从远到近排序。

#### geohash

Redis GEO 使用 geohash 来保存地理位置的坐标。geohash 用于获取一个或多个位置元素的 geohash 值。geohash 语法格式如下：

```sql
GEOHASH key member [member ...]
```

### 流命令 Stream

Redis Stream 是 Redis 5.0 版本新增加的数据结构。Redis Stream 主要用于消息队列（MQ，Message Queue），Redis 本身是有一个 Redis 发布订阅 (pub/sub) 来实现消息队列的功能，但它有个缺点就是消息无法持久化，如果出现网络断开、Redis 宕机等，消息就会被丢弃。简单来说发布订阅 (pub/sub) 可以分发消息，但无法记录历史消息。

而 Redis Stream 提供了消息的持久化和主备复制功能，可以让任何客户端访问任何时刻的数据，并且能记住每一个客户端的访问位置，还能保证消息不丢失。Redis Stream 的结构如下所示，它有一个消息链表，将所有加入的消息都串起来，每个消息都有一个唯一的 ID 和对应的内容：

![img](https://www.runoob.com/wp-content/uploads/2020/09/en-us_image_0167982791.png)

每个 Stream 都有唯一的名称，它就是 Redis 的 key，在我们首次使用 xadd 指令追加消息时自动创建。

上图解析：

- **Consumer Group** ：消费组，使用 XGROUP CREATE 命令创建，一个消费组有多个消费者(Consumer)。
- **last_delivered_id** ：游标，每个消费组会有个游标 last_delivered_id，任意一个消费者读取了消息都会使游标 last_delivered_id 往前移动。
- **pending_ids** ：消费者(Consumer)的状态变量，作用是维护消费者的未确认的 id。 pending_ids 记录了当前已经被客户端读取的消息，但是还没有 ack (Acknowledge character：确认字符）。

**消息队列相关命令：**

- **XADD** - 添加消息到末尾
- **XTRIM** - 对流进行修剪，限制长度
- **XDEL** - 删除消息
- **XLEN** - 获取流包含的元素数量，即消息长度
- **XRANGE** - 获取消息列表，会自动过滤已经删除的消息
- **XREVRANGE** - 反向获取消息列表，ID 从大到小
- **XREAD** - 以阻塞或非阻塞方式获取消息列表

**消费者组相关命令：**

- **XGROUP CREATE** - 创建消费者组
- **XREADGROUP GROUP** - 读取消费者组中的消息
- **XACK** - 将消息标记为"已处理"
- **XGROUP SETID** - 为消费者组设置新的最后递送消息ID
- **XGROUP DELCONSUMER** - 删除消费者
- **XGROUP DESTROY** - 删除消费者组
- **XPENDING** - 显示待处理消息的相关信息
- **XCLAIM** - 转移消息的归属权
- **XINFO** - 查看流和消费者组的相关信息；
- **XINFO GROUPS** - 打印消费者组的信息；
- **XINFO STREAM** - 打印流信息

#### XADD

使用 XADD 向队列添加消息，如果指定的队列不存在，则创建一个队列，XADD 语法格式：

```
XADD key ID field value [field value ...]
```

- **key** ：队列名称，如果不存在就创建
- **ID** ：消息 id，我们使用 * 表示由 redis 生成，可以自定义，但是要自己保证递增性。
- **field value** ： 记录。

#### XTRIM

使用 XTRIM 对流进行修剪，限制长度， 语法格式：

```
XTRIM key MAXLEN [~] count
```

- **key** ：队列名称
- **MAXLEN** ：长度
- **count** ：数量

#### XDEL

使用 XDEL 删除消息，语法格式：

```
XDEL key ID [ID ...]
```

- **key**：队列名称
- **ID** ：消息 ID

#### XLEN

使用 XLEN 获取流包含的元素数量，即消息长度，语法格式：

```
XLEN key
```

- **key**：队列名称

#### XRANGE

使用 XRANGE 获取消息列表，会自动过滤已经删除的消息 ，语法格式：

```
XRANGE key start end [COUNT count]
```

- **key** ：队列名
- **start** ：开始值， **-** 表示最小值
- **end** ：结束值， **+** 表示最大值
- **count** ：数量

#### XREVRANGE

使用 XREVRANGE 获取消息列表，会自动过滤已经删除的消息 ，语法格式：

```
XREVRANGE key end start [COUNT count]
```

- **key** ：队列名
- **end** ：结束值， **+** 表示最大值
- **start** ：开始值， **-** 表示最小值
- **count** ：数量

#### XREAD

使用 XREAD 以阻塞或非阻塞方式获取消息列表 ，语法格式：

```
XREAD [COUNT count] [BLOCK milliseconds] STREAMS key [key ...] id [id ...]
```

- **count** ：数量
- **milliseconds** ：可选，阻塞毫秒数，没有设置就是非阻塞模式
- **key** ：队列名
- **id** ：消息 ID

#### XGROUP CREATE

使用 XGROUP CREATE 创建消费者组，语法格式：

```
XGROUP [CREATE key groupname id-or-$] [SETID key groupname id-or-$] [DESTROY key groupname] [DELCONSUMER key groupname consumername]
```

- **key** ：队列名称，如果不存在就创建
- **groupname** ：组名。
- **$** ： 表示从尾部开始消费，只接受新消息，当前 Stream 消息会全部忽略。

从头开始消费:

```
XGROUP CREATE mystream consumer-group-name 0-0  
```

从尾部开始消费:

```
XGROUP CREATE mystream consumer-group-name $
```

#### XREADGROUP GROUP

使用 XREADGROUP GROUP 读取消费组中的消息，语法格式：

```
XREADGROUP GROUP group consumer [COUNT count] [BLOCK milliseconds] [NOACK] STREAMS key [key ...] ID [ID ...]
```

- **group** ：消费组名
- **consumer** ：消费者名。
- **count** ： 读取数量。
- **milliseconds** ： 阻塞毫秒数。
- **key** ： 队列名。
- **ID** ： 消息 ID。

```
XREADGROUP GROUP consumer-group-name consumer-name COUNT 1 STREAMS mystream >
```

### 数据备份

Redis **SAVE** 命令用于创建当前数据库的备份。

redis Save 命令基本语法如下：

```
SAVE 
```

如果需要恢复数据，只需将备份文件 (dump.rdb) 移动到 redis 安装目录并启动服务即可。获取 redis 目录可以使用 **CONFIG** 命令，如下所示：

```
CONFIG GET dir
1) "dir"
2) "/usr/local/redis/bin"
```

### 性能测试

Redis 性能测试是通过同时执行多个命令实现的。redis 性能测试的基本命令如下：

```
redis-benchmark [option] [option value]
```

| 选项  | 描述                                         | 默认值    |
| :---- | :------------------------------------------- | :-------- |
| -h    | 指定服务器主机名。                           | 127.0.0.1 |
| -p    | 指定服务器端口。                             | 6379      |
| -s    | 指定服务器 socket。                          |           |
| -c    | 指定并发连接数。                             | 50        |
| -n    | 指定请求数。                                 | 10000     |
| -d    | 以字节形式指定 SET/GET 值的数据大小。        | 2         |
| -k    | 1 表示 keep alive，0 表示 reconnect。        | 1         |
| -r    | SET/GET/INCR 使用随机 key，SADD 使用随机值。 |           |
| -P    | 通过管道传输 `<numreq>` 请求。               | 1         |
| -q    | 强制退出 redis，仅显示 query/sec 值。        |           |
| --csv | 以 CSV 格式输出。                            |           |
| -l    | 生成循环，永久执行测试。                     |           |
| -t    | 仅运行以逗号分隔的测试命令列表。             |           |
| -I    | Idle 模式，仅打开 N 个空闲连接并等待。       |           |

### 客户端连接

Redis 通过监听一个 TCP 端口或者 Unix socket 的方式来接收来自客户端的连接，当一个连接建立后，Redis 内部会进行以下一些操作：

- 首先，客户端 socket 会被设置为非阻塞模式，因为 Redis 在网络事件处理上采用的是非阻塞多路复用模型。
- 然后为这个 socket 设置 TCP_NODELAY 属性，禁用 Nagle 算法
- 然后创建一个可读的文件事件用于监听这个客户端 socket 的数据发送

#### 最大连接数

在 Redis2.4 中，最大连接数是被直接硬编码在代码里面的，而在2.6版本中这个值变成可配置的。

maxclients 的默认值是 10000，你也可以在 redis.conf 中对这个值进行修改。

```
config get maxclients

1) "maxclients"
2) "10000"
```

| 命令           | 效果                                       |
| :------------- | :----------------------------------------- |
| CLIENT LIST    | 返回连接到 Redis 服务的客户端列表。        |
| CLIENT SETNAME | 设置当前连接的名称。                       |
| CLIENT GETNAME | 获取通过 CLIENT SETNAME 设置的连接名称。   |
| CLIENT PAUSE   | 挂起客户端连接，指定挂起时间，单位为毫秒。 |
| CLIENT KILL    | 关闭客户端连接。                           |

### 管道技术

Redis是一种基于客户端-服务端模型以及请求/响应协议的TCP服务。这意味着通常情况下一个请求会遵循以下步骤：

- 客户端向服务端发送一个查询请求，并监听Socket返回，通常是以阻塞模式，等待服务端响应。
- 服务端处理命令，并将结果返回给客户端。

Redis 管道技术可以在服务端未响应时，客户端可以继续向服务端发送请求，并最终一次性读取所有服务端的响应。

分区是分割数据到多个Redis实例的处理过程，因此每个实例只保存key的一个子集。

### 分区

​	通过利用多台计算机内存的和值，允许我们构造更大的数据库。通过多核和多台计算机，允许我们扩展计算能力；通过多台计算机和网络适配器，允许我们扩展网络带宽。

​	但Redis的一些特性在分区方面表现的不是很好：涉及多个key的操作通常是不被支持的。举例来说，当两个set映射到不同的redis实例上时，你就不能对这两个set执行交集操作；涉及多个key的redis事务不能使用；当使用分区时，数据处理较为复杂，比如你需要处理多个rdb/aof文件，并且从多个实例和主机备份持久化文件；增加或删除容量也比较复杂。redis集群大多数支持在运行时增加、删除节点的透明数据平衡的能力，但是类似于客户端分区、代理等其他系统则不支持这项特性。然而，一种叫做presharding的技术对此是有帮助的。

#### 分区类型

##### 范围分区

最简单的分区方式是按范围分区，就是映射一定范围的对象到特定的Redis实例。比如，ID从0到10000的用户会保存到实例R0，ID从10001到 20000的用户会保存到R1，以此类推。这种方式是可行的，并且在实际中使用，不足就是要有一个区间范围到实例的映射表。这个表要被管理，同时还需要各 种对象的映射表，通常对Redis来说并非是好的方法。

##### 哈希分区

另外一种分区方法是hash分区。这对任何key都适用，也无需是object_name:这种形式，像下面描述的一样简单：

- 用一个hash函数将key转换为一个数字，比如使用crc32 hash函数。对key foobar执行crc32(foobar)会输出类似93024922的整数。
- 对这个整数取模，将其转化为0-3之间的数字，就可以将这个整数映射到4个Redis实例中的一个了。93024922 % 4 = 2，就是说key foobar应该被存到R2实例中。注意：取模操作是取除的余数，通常在多种编程语言中用%操作符实现。
