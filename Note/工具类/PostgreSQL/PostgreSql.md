## PostgreSql

PostgreSQL是以加州大学伯克利分校计算机系开发的[POSTGRES， 版本 4.2](https://dsf.berkeley.edu/postgres.html)为基础的对象关系型数据库管理系统（ORDBMS）。POSTGRES 领先的许多概念在很久以后才出现在一些商业数据库系统中。

PostgreSQL是最初的伯克利代码的开源继承者。它支持大部分 SQL 标准并且提供了许多现代特性：复杂查询、外键、触发器、可更新视图、事务完整性、多版本并发控制。同样，PostgreSQL可以用许多方法扩展，比如， 通过增加新的：数据类型、函数、操作符、聚集函数、索引方法、过程语言

并且，因为自由宽松的许可证，任何人都可以以任何目的免费使用、修改和分发PostgreSQL， 不管是私用、商用还是学术研究目的。

### PostgreSQL 核心机制

#### MVCC：并发控制的基础机制

MVCC（Multi-Version Concurrency Control，多版本并发控制）是 PostgreSQL 最核心的事务并发机制。其基本思想不是让所有事务围绕同一份“当前值”竞争访问权，而是通过维护多个版本，使不同事务能够基于各自的可见性规则读取一致的数据快照。在 PostgreSQL 中，事务读取数据时，并不简单地以“当前磁盘上的最新值”为准，而是根据事务快照判断某个版本对当前事务是否可见。这样做的直接意义在于：读操作通常不必因为写操作而阻塞，写操作也不必因为一般性的读操作而停顿，从而显著改善高并发环境下的吞吐与隔离表现。

PostgreSQL 的 MVCC 机制与其元组可见性设计紧密相关。每一行记录都附带事务可见性相关信息，系统据此判断该版本是否应当被当前事务看到。因此，PostgreSQL 的并发控制并不是单纯依赖锁，而是建立在“多版本 + 可见性判断”的基础之上。锁仍然存在，但更多用于保护修改语义，而不是作为一般读写并发的唯一手段。

#### VACUUM：多版本机制清理体系

MVCC 带来的优势是显著的，但它并不是没有代价。由于更新和删除不会简单地把旧版本立即物理清除，数据库内部会持续积累已经失效、但在某个时间点之前仍可能对旧事务有意义的历史版本。因此，PostgreSQL 必须有一套专门的清理和回收机制，这就是 VACUUM。

VACUUM 的职责并不仅仅是“释放空间”。更准确地说，它承担了以下几类任务：

- 清除已经不再对任何活动事务可见的旧版本元组；
- 回收可复用空间，缓解表和索引膨胀；
- 维护统计信息，为优化器提供更准确的基数估计；
- 参与事务 ID 生命周期管理，避免事务编号长期累积导致的可见性风险。

因此，VACUUM 在 PostgreSQL 中不是一个可有可无的附属功能，而是 MVCC 成立所必需的配套机制。没有 VACUUM，MVCC 带来的多版本优势会逐渐转化为膨胀、扫描成本上升、统计信息失真以及事务冻结风险等问题。从实现风格上看，PostgreSQL 的 UPDATE 更接近“写入新版本并使旧版本等待回收”，而不是很多人直觉中的“在原位置直接修改”。这也是为什么 PostgreSQL 在运维和性能层面总会反复提到表膨胀、Autovacuum、Freeze 等概念。它们并不是零散的知识点，而是同一套版本管理逻辑的自然延伸。

#### WAL：持久化、恢复与复制

WAL（Write-Ahead Logging，预写式日志）是 PostgreSQL 可靠性设计的核心之一。其原则是：**对数据文件的修改，不应先于对应日志记录的持久化**。也就是说，在事务修改真正写入数据页之前，相关的变更信息必须先安全记录到 WAL 中。这套机制解决的是数据库系统最根本的问题之一：如果数据页尚未完整刷新到磁盘，系统便发生宕机，那么数据库如何恢复到一个一致状态？WAL 给出的答案是：只要日志完整，数据库就可以基于日志重做（redo）尚未完全落盘的修改，从而恢复到崩溃前应有的一致状态。

因此，WAL 的价值不仅体现在“事务提交更安全”这一点上，更体现在整个 PostgreSQL 的可靠性架构中。它至少支撑了三个关键方向：

- **持久化**：已提交事务的修改可以在崩溃后通过日志恢复；
- **崩溃恢复**：数据库重启时可以基于 WAL 修复未完成的数据页状态；
- **复制**：WAL 记录本身也是主从同步与备库重放的基础载体。

从系统视角看，WAL 相当于 PostgreSQL 的统一变更序列。数据文件反映的是某个时刻的页状态，而 WAL 记录的是这些状态如何一步步演化而来。正因为有这一层抽象，PostgreSQL 才能把恢复、高可用和备份等能力建立在一套统一的变更基础之上。

#### 丰富索引体系：可扩展访问方法集合

如果只从一般业务开发经验出发，很多人会把“索引”理解为某列上的普通 B-Tree 索引。但 PostgreSQL 的一个显著特征，是其索引体系并非单一实现，而是建立在“多种索引访问方法”之上的可扩展框架。

B-Tree 当然仍然是最常用的索引类型，适用于大多数等值查询、范围查询和排序场景。但 PostgreSQL 并没有把所有查询模式都压缩到 B-Tree 上，而是提供了多种针对不同数据结构和查询语义的索引访问方法。例如：

- **GIN**：适合多值包含关系，如全文检索、数组、JSONB；
- **GiST**：适合范围、几何、相似性以及某些通用搜索结构；
- **BRIN**：适合超大表、数据与物理存储顺序高度相关的场景；
- **SP-GiST**：适合某些可空间划分或稀疏分布的数据结构；
- **Hash**：用于特定等值匹配场景。

这意味着 PostgreSQL 的索引体系更像一个“查询访问方法平台”，而不是单纯的“是否建普通索引”的二元选择。对于 PostgreSQL 而言，索引与数据类型、操作符类、查询语义之间有更紧密的结合关系。这也是为什么它在 JSONB、全文检索、范围类型、复杂约束和相似性检索等场景中通常更有表达力。

#### 架构清晰：共享内存、后台进程与数据文件的协作体系

从系统结构看，PostgreSQL 是典型的客户端/服务器架构数据库，但它的内部组织方式也有鲜明特征。面试中如果被问到“你对 PostgreSQL 的架构了解多少”，通常不需要展开到源码细节，但至少应当能说明其主要组成。

可以把 PostgreSQL 的系统结构概括为三层协作关系：

- **共享内存**：承担缓冲、锁、WAL 相关状态与其他关键共享状态管理；
- **后台进程体系**：负责检查点、WAL 写入、自动清理、归档、复制等持续性维护任务；
- **数据文件与 WAL 文件**：承担物理存储与持久化记录。

在前台层面，PostgreSQL 为客户端连接提供服务端进程来处理会话请求；在后台层面，则通过一系列长期运行的辅助进程维护数据库整体状态。例如 checkpointer 负责检查点推进，background writer 负责平滑写脏页，wal writer 负责 WAL 刷写，autovacuum 相关进程负责自动清理与冻结维护，archiver 负责归档日志。

这套架构的优点在于职责边界较清晰：会话处理、缓存管理、写入控制、日志管理、后台维护被拆分到不同层次，从而有利于理解数据库的运行机制。也正因为这种结构较为清晰，PostgreSQL 常被拿来作为学习数据库内部原理的典型对象。

#### 复制能力：以 WAL 为基础的流复制与面向逻辑变更的逻辑复制

PostgreSQL 的复制能力同样具有较清晰的层次。面试中如果谈到高可用、读写分离、异地容灾或数据同步，通常需要区分两个方向：**Streaming Replication（流复制）** 与 **Logical Replication（逻辑复制）**。

流复制本质上建立在 WAL 之上。主库不断生成 WAL，备库接收并重放这些变更记录，以使自身状态逼近主库。由于它复制的是底层变更序列，因此通常适合构建只读副本、热备节点和高可用体系。它强调的是数据库状态层面的同步一致。

逻辑复制则不同。它关注的是表级别的逻辑变更，而不是底层页面或 WAL 重放后的物理状态趋同。逻辑复制更强调发布与订阅关系，可以只同步特定表，适合数据分发、局部同步、在线迁移以及跨系统集成等场景。

二者的根本区别可以概括为：

- 流复制更接近底层数据库状态同步；
- 逻辑复制更接近业务对象层面的变更传播。

因此，PostgreSQL 的复制能力并不只是“有没有主从”这么简单，而是提供了不同层次、不同目标的同步机制。对于面试而言，能够区分这两种复制方式，通常已经说明对 PostgreSQL 的工程能力有较清晰的认识。

#### 与 InnoDB 的差异：都叫 MVCC，但实现路径与锁行为并不相同

在 PostgreSQL 中，多版本通常表现为表中显式存在的新旧版本元组，系统基于事务可见性规则判断哪些版本对当前事务可见；随之而来的版本清理，则由 VACUUM 体系承担。这意味着 PostgreSQL 的多版本、膨胀、清理、冻结等概念之间是强关联的。而 InnoDB 的 MVCC 更依赖 undo log 等机制来构造历史视图。两者都实现了“事务读取一致快照”的能力，但历史版本的形成方式、存储位置以及清理路径并不相同。因此，虽然都可以被称为 MVCC，工程上的行为特征却有明显差异。

其次，锁行为与并发冲突表现也不同。PostgreSQL 的并发讨论中，更常见的是：

- 快照可见性；
- 行级锁与表级锁模式；
- 可串行化事务下的冲突检测与重试；
- 谓词锁等与串行化实现相关的概念。

而 InnoDB 体系中，更常被提及的是：

- 记录锁；
- 间隙锁（gap lock）；
- next-key lock；
- 范围查询对插入行为的影响。

这意味着，在面对相似的并发业务场景时，PostgreSQL 与 InnoDB 虽然都能保证事务正确性，但阻塞形态、冲突点以及调优思路往往不同。InnoDB 中常见的问题是“为什么范围锁影响了插入”；PostgreSQL 中更常见的问题则是“为什么该事务发生了可串行化失败或需要重试”。

再进一步说，PostgreSQL 与 InnoDB 的差异并不只体现在并发控制上。PostgreSQL 通常还体现出以下技术风格：

- 更丰富的数据类型体系；
- 更可扩展的索引与操作符体系；
- 更强的复杂约束表达能力；
- 更适合复杂查询与复杂数据模型。

PostgreSQL 的核心不是 SQL 语法，而是一整套比较完整的数据库实现机制。它用 MVCC 做并发控制，使事务基于快照读取一致数据；因为多版本存在，所以需要 VACUUM 持续清理旧版本并控制膨胀；它又通过 WAL 保证持久化，并把恢复和复制建立在同一套日志基础之上。与此同时，PostgreSQL 的索引体系和类型体系都比较丰富，不局限于传统 B-Tree 和简单标量数据，因此在复杂查询、复杂约束和复杂数据模型上通常更有优势。和 InnoDB 相比，二者虽然都支持 MVCC，但版本管理、清理机制和锁行为并不相同，这也是它们在并发处理上呈现不同风格的根本原因。

#### 总结

PostgreSQL 的核心不是 SQL 语法，而是一整套比较完整的数据库实现机制。它用 MVCC 做并发控制，使事务基于快照读取一致数据；因为多版本存在，所以需要 VACUUM 持续清理旧版本并控制膨胀；它又通过 WAL 保证持久化，并把恢复和复制建立在同一套日志基础之上。与此同时，PostgreSQL 的索引体系和类型体系都比较丰富，不局限于传统 B-Tree 和简单标量数据，因此在复杂查询、复杂约束和复杂数据模型上通常更有优势。和 InnoDB 相比，二者虽然都支持 MVCC，但版本管理、清理机制和锁行为并不相同，这也是它们在并发处理上呈现不同风格的根本原因。

### PostgreSQL 数据类型

数据类型是我们在创建表的时候为每个字段设置的。PostgreSQL提 供了丰富的数据类型。用户可以使用 CREATE TYPE 命令在数据库中创建新的数据类型。

#### 数值类型

数值类型由 2 字节、4 字节或 8 字节的整数以及 4 字节或 8 字节的浮点数和可选精度的十进制数组成。下表列出了可用的数值类型。

| 名字             | 存储长度 | 描述                 | 范围                                         |
| :--------------- | :------- | :------------------- | :------------------------------------------- |
| smallint         | 2 字节   | 小范围整数           | -32768 到 +32767                             |
| integer          | 4 字节   | 常用的整数           | -2147483648 到 +2147483647                   |
| bigint           | 8 字节   | 大范围整数           | -9223372036854775808 到 +9223372036854775807 |
| decimal          | 可变长   | 用户指定的精度，精确 | 小数点前 131072 位；小数点后 16383 位        |
| numeric          | 可变长   | 用户指定的精度，精确 | 小数点前 131072 位；小数点后 16383 位        |
| real             | 4 字节   | 可变精度，不精确     | 6 位十进制数字精度                           |
| double precision | 8 字节   | 可变精度，不精确     | 15 位十进制数字精度                          |
| smallserial      | 2 字节   | 自增的小范围整数     | 1 到 32767                                   |
| serial           | 4 字节   | 自增整数             | 1 到 2147483647                              |
| bigserial        | 8 字节   | 自增的大范围整数     | 1 到 9223372036854775807                     |

#### 字符类型

| 序号 |                     名字 & 描述                      |
| :--- | :--------------------------------------------------: |
| 1    | **character varying(n), varchar(n)**变长，有长度限制 |
| 2    |      **character(n), char(n)** 定长,不足补空白       |
| 3    |              **text** 变长，无长度限制               |

#### 日期/时间类型

| 名字                                      | 存储空间 | 描述                     | 最低值        | 最高值        | 分辨率         |
| :---------------------------------------- | :------- | :----------------------- | :------------ | :------------ | :------------- |
| timestamp [ (*p*) ] [ without time zone ] | 8 字节   | 日期和时间(无时区)       | 4713 BC       | 294276 AD     | 1 毫秒 / 14 位 |
| timestamp [ (*p*) ] with time zone        | 8 字节   | 日期和时间，有时区       | 4713 BC       | 294276 AD     | 1 毫秒 / 14 位 |
| date                                      | 4 字节   | 只用于日期               | 4713 BC       | 5874897 AD    | 1 天           |
| time [ (*p*) ] [ without time zone ]      | 8 字节   | 只用于一日内时间         | 00:00:00      | 24:00:00      | 1 毫秒 / 14 位 |
| time [ (*p*) ] with time zone             | 12 字节  | 只用于一日内时间，带时区 | 00:00:00+1459 | 24:00:00-1459 | 1 毫秒 / 14 位 |
| interval [ *fields* ] [ (*p*) ]           | 12 字节  | 时间间隔                 | -178000000 年 | 178000000 年  | 1 毫秒 / 14 位 |

#### 布尔类型

PostgreSQL 支持标准的 boolean 数据类型。

boolean 有"true"(真)或"false"(假)两个状态， 第三种"unknown"(未知)状态，用 NULL 表示。

| 名称    | 存储格式 | 描述       |
| :------ | :------- | :--------- |
| boolean | 1 字节   | true/false |

#### 枚举类型

枚举类型是一个包含静态和值的有序集合的数据类型。PostgreSQL 中的枚举类型类似于 C 语言中的 enum 类型。与其他类型不同的是枚举类型需要使用 CREATE TYPE 命令创建。

就像其他类型一样，一旦创建，枚举类型可以用于表和函数定义。

```sql
CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');
CREATE TABLE person (
    name text,
    current_mood mood
);
INSERT INTO person VALUES ('Moe', 'happy');
SELECT * FROM person WHERE current_mood = 'happy';
 name | current_mood 
------+--------------
 Moe  | happy
(1 row)
```

#### 数组类型

PostgreSQL 允许将字段定义成变长的多维数组。

数组类型可以是任何基本类型或用户定义类型，枚举类型或复合类型。

##### 声明数组

创建表的时候，我们可以用`[]`声明数组。我们也可以使用 "ARRAY" 关键字，如下所示：

```sql
CREATE TABLE sal_emp (
   name text,
   pay_by_quarter integer ARRAY[4],
   schedule text[][]
);
```

##### 插入值

插入值使用花括号 {}，元素在 {} 使用逗号隔开：

```sql
INSERT INTO sal_emp
    VALUES ('Bill',
    '{10000, 10000, 10000, 10000}',
    '{{"meeting", "lunch"}, {"training", "presentation"}}');

INSERT INTO sal_emp
    VALUES ('Carol',
    '{20000, 25000, 25000, 25000}',
    '{{"breakfast", "consulting"}, {"meeting", "lunch"}}');
```

##### 访问数组

现在我们可以在这个表上运行一些查询。首先，我们演示如何访问数组的一个元素。 这个查询检索在第二季度薪水变化的雇员名：

```sql
SELECT name FROM sal_emp WHERE pay_by_quarter[1] <> pay_by_quarter[2];

 name
-------
 Carol
(1 row)
```

数组的下标数字是写在方括弧内的。

##### 修改数组

我们可以对数组的值进行修改：

```sql
UPDATE sal_emp SET pay_by_quarter = '{25000,25000,27000,27000}'
    WHERE name = 'Carol';
```

或者使用 ARRAY 构造器语法：

```sql
UPDATE sal_emp SET pay_by_quarter = ARRAY[25000,25000,27000,27000]
    WHERE name = 'Carol';
```

##### 数组中检索

要搜索一个数组中的数值，你必须检查该数组的每一个值。比如：

```sql
SELECT * FROM sal_emp WHERE pay_by_quarter[1] = 10000 OR
                            pay_by_quarter[2] = 10000 OR
                            pay_by_quarter[3] = 10000 OR
                            pay_by_quarter[4] = 10000;
```

另外，你可以用下面的语句找出数组中所有元素值都等于 10000 的行：

```sql
SELECT * FROM sal_emp WHERE 10000 = ALL (pay_by_quarter);
```

或者，可以使用 generate_subscripts 函数。例如：

```sql
SELECT * FROM
   (SELECT pay_by_quarter,
           generate_subscripts(pay_by_quarter, 1) AS s
      FROM sal_emp) AS foo
 WHERE pay_by_quarter[s] = 10000;
```

------

#### 复合类型

复合类型表示一行或者一条记录的结构； 它实际上只是一个字段名和它们的数据类型的列表。PostgreSQL 允许像简单数据类型那样使用复合类型。比如，一个表的某个字段可以声明为一个复合类型。

##### 声明复合类型

下面是两个定义复合类型的简单例子：

```sql
CREATE TYPE complex AS (
    r       double precision,
    i       double precision
);

CREATE TYPE inventory_item AS (
    name            text,
    supplier_id     integer,
    price           numeric
);
```

语法类似于 CREATE TABLE，只是这里只可以声明字段名字和类型。定义了类型，我们就可以用它创建表：

```sql
CREATE TABLE on_hand (
    item      inventory_item,
    count     integer
);

INSERT INTO on_hand VALUES (ROW('fuzzy dice', 42, 1.99), 1000);
```

##### 复合类型值输入

要以文本常量书写复合类型值，在圆括弧里包围字段值并且用逗号分隔他们。 你可以在任何字段值周围放上双引号，如果值本身包含逗号或者圆括弧， 你必须用双引号括起。

复合类型常量的一般格式如下：

```sql
'( val1 , val2 , ... )'
```

一个例子是:

```sql
'("fuzzy dice",42,1.99)'
```

##### 访问复合类型

要访问复合类型字段的一个域，我们写出一个点以及域的名字， 非常类似从一个表名字里选出一个字段。实际上，因为实在太像从表名字中选取字段， 所以我们经常需要用圆括弧来避免分析器混淆。比如，你可能需要从on_hand 例子表中选取一些子域，像下面这样：

```sql
SELECT item.name FROM on_hand WHERE item.price > 9.99;
```

这样将不能工作，因为根据 SQL 语法，item是从一个表名字选取的， 而不是一个字段名字。你必须像下面这样写：

```sql
SELECT (item).name FROM on_hand WHERE (item).price > 9.99;
```

或者如果你也需要使用表名字(比如，在一个多表查询里)，那么这么写：

```sql
SELECT (on_hand.item).name FROM on_hand WHERE (on_hand.item).price > 9.99;
```

现在圆括弧对象正确地解析为一个指向item字段的引用，然后就可以从中选取子域。

#### 范围类型

范围数据类型代表着某一元素类型在一定范围内的值。例如，timestamp 范围可能被用于代表一间会议室被预定的时间范围。PostgreSQL 内置的范围类型有：

- int4range — integer的范围
- int8range —bigint的范围
- numrange —numeric的范围
- tsrange —timestamp without time zone的范围
- tstzrange —timestamp with time zone的范围
- daterange —date的范围

此外，你可以定义你自己的范围类型。

```sql
CREATE TABLE reservation (room int, during tsrange);
INSERT INTO reservation VALUES
    (1108, '[2010-01-01 14:30, 2010-01-01 15:30)');

-- 包含
SELECT int4range(10, 20) @> 3;

-- 重叠
SELECT numrange(11.1, 22.2) && numrange(20.0, 30.0);

-- 提取上边界
SELECT upper(int8range(15, 25));

-- 计算交叉
SELECT int4range(10, 20) * int4range(15, 25);

-- 范围是否为空
SELECT isempty(numrange(1, 5));
```

范围值的输入必须遵循下面的格式：

```sql
(下边界,上边界)
(下边界,上边界]
[下边界,上边界)
[下边界,上边界]
空
```

圆括号或者方括号显示下边界和上边界是不包含的还是包含的。注意最后的格式是 空，代表着一个空的范围（一个不含有值的范围）。

```sql
-- 包括3，不包括7，并且包括二者之间的所有点
SELECT '[3,7)'::int4range;

-- 不包括3和7，但是包括二者之间所有点
SELECT '(3,7)'::int4range;

-- 只包括单一值4
SELECT '[4,4]'::int4range;

-- 不包括点（被标准化为‘空’）
SELECT '[4,4)'::int4range;
```

#### 其他类型

##### 货币类型

money 类型存储带有固定小数精度的货币金额。numeric、int 和 bigint 类型的值可以转换为 money，不建议使用浮点数来处理处理货币类型，因为存在舍入错误的可能性。

| 名字  | 存储容量 | 描述     | 范围                                           |
| :---- | :------- | :------- | :--------------------------------------------- |
| money | 8 字节   | 货币金额 | -92233720368547758.08 到 +92233720368547758.07 |

##### 几何类型

几何数据类型表示二维的平面物体。下表列出了 PostgreSQL 支持的几何类型。最基本的类型：点。它是其它类型的基础。

| 名字    | 存储空间    | 说明                   | 表现形式               |
| :------ | :---------- | :--------------------- | :--------------------- |
| point   | 16 字节     | 平面中的点             | (x,y)                  |
| line    | 32 字节     | (无穷)直线(未完全实现) | ((x1,y1),(x2,y2))      |
| lseg    | 32 字节     | (有限)线段             | ((x1,y1),(x2,y2))      |
| box     | 32 字节     | 矩形                   | ((x1,y1),(x2,y2))      |
| path    | 16+16n 字节 | 闭合路径(与多边形类似) | ((x1,y1),...)          |
| path    | 16+16n 字节 | 开放路径               | [(x1,y1),...]          |
| polygon | 40+16n 字节 | 多边形(与闭合路径相似) | ((x1,y1),...)          |
| circle  | 24 字节     | 圆                     | <(x,y),r> (圆心和半径) |

##### 网络地址类型

PostgreSQL 提供用于存储 IPv4 、IPv6 、MAC 地址的数据类型。用这些数据类型存储网络地址比用纯文本类型好， 因为这些类型提供输入错误检查和特殊的操作和功能。

| 名字    | 存储空间     | 描述                    |
| :------ | :----------- | :---------------------- |
| cidr    | 7 或 19 字节 | IPv4 或 IPv6 网络       |
| inet    | 7 或 19 字节 | IPv4 或 IPv6 主机和网络 |
| macaddr | 6 字节       | MAC 地址                |

在对 inet 或 cidr 数据类型进行排序的时候， IPv4 地址总是排在 IPv6 地址前面，包括那些封装或者是映射在 IPv6 地址里的 IPv4 地址， 比如 ::10.2.3.4 或 ::ffff:10.4.3.2。

##### 位串类型

位串就是一串 1 和 0 的字符串。它们可以用于存储和直观化位掩码。 我们有两种 SQL 位类型：bit(n) 和bit varying(n)， 这里的n是一个正整数。bit 类型的数据必须准确匹配长度 n， 试图存储短些或者长一些的数据都是错误的。bit varying 类型数据是最长 n 的变长类型；更长的串会被拒绝。 写一个没有长度的bit 等效于 bit(1)， 没有长度的 bit varying 意思是没有长度限制。

##### 文本搜索类型

全文检索即通过自然语言文档的集合来找到那些匹配一个查询的检索。PostgreSQL 提供了两种数据类型用于支持全文检索：

| 序号 |                         名字 & 描述                          |
| :--- | :----------------------------------------------------------: |
| 1    | **tsvector** tsvector 的值是一个无重复值的 lexemes 排序列表， 即一些同一个词的不同变种的标准化。 |
| 2    | **tsquery** tsquery 存储用于检索的词汇，并且使用布尔操作符 &(AND)，\|(OR)和!(NOT) 来组合它们，括号用来强调操作符的分组。 |

##### UUID 类型

Uuid 数据类型用来存储 RFC 4122，ISO/IEF 9834-8:2005 以及相关标准定义的通用唯一标识符（UUID）。 （一些系统认为这个数据类型为全球唯一标识符，或GUID。） 这个标识符是一个由算法产生的 128 位标识符，使它不可能在已知使用相同算法的模块中和其他方式产生的标识符相同。 因此，对分布式系统而言，这种标识符比序列能更好的提供唯一性保证，因为序列只能在单一数据库中保证唯一。UUID 被写成一个小写十六进制数字的序列，由分字符分成几组， 特别是一组8位数字+3组4位数字+一组12位数字，总共 32 个数字代表 128 位， 一个这种标准的 UUID 例子如下：

```
a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11
```

------

##### XML 类型

xml 数据类型可以用于存储XML数据。 将 XML 数据存到 text 类型中的优势在于它能够为结构良好性来检查输入值， 并且还支持函数对其进行类型安全性检查。 要使用这个数据类型，编译时必须使用 **configure --with-libxml**。xml 可以存储由XML标准定义的格式良好的"文档"， 以及由 XML 标准中的 **XMLDecl? content** 定义的"内容"片段， 大致上，这意味着内容片段可以有多个顶级元素或字符节点。 xmlvalue IS DOCUMENT 表达式可以用来判断一个特定的 xml 值是一个完整的文件还是内容片段。

###### 创建XML值

使用函数 xmlparse: 来从字符数据产生 xml 类型的值：

```
XMLPARSE (DOCUMENT '<?xml version="1.0"?><book><title>Manual</title><chapter>...</chapter></book>')
XMLPARSE (CONTENT 'abc<foo>bar</foo><bar>foo</bar>')
```

##### JSON 类型

json 数据类型可以用来存储 JSON（JavaScript Object Notation）数据， 这样的数据也可以存储为 text，但是 json 数据类型更有利于检查每个存储的数值是可用的 JSON 值。此外还有相关的函数来处理 json 数据：

|                   实例                   |      实例结果       |
| :--------------------------------------: | :-----------------: |
| array_to_json('{{1,5},{99,100}}'::int[]) |  [[1,5],[99,100]]   |
|        row_to_json(row(1,'foo'))         | {"f1":1,"f2":"foo"} |

##### 对象标识符类型

PostgreSQL 在内部使用对象标识符(OID)作为各种系统表的主键。

同时，系统不会给用户创建的表增加一个 OID 系统字段(除非在建表时声明了WITH OIDS 或者配置参数default_with_oids设置为开启)。oid 类型代表一个对象标识符。除此以外 oid 还有几个别名：regproc, regprocedure, regoper, regoperator, regclass, regtype, regconfig, 和regdictionary。

| 名字          | 引用         | 描述               | 数值例子                              |
| :------------ | :----------- | :----------------- | :------------------------------------ |
| oid           | 任意         | 数字化的对象标识符 | 564182                                |
| regproc       | pg_proc      | 函数名字           | sum                                   |
| regprocedure  | pg_proc      | 带参数类型的函数   | sum(int4)                             |
| regoper       | pg_operator  | 操作符名           | +                                     |
| regoperator   | pg_operator  | 带参数类型的操作符 | *(integer,integer) 或 -(NONE,integer) |
| regclass      | pg_class     | 关系名             | pg_type                               |
| regtype       | pg_type      | 数据类型名         | integer                               |
| regconfig     | pg_ts_config | 文本搜索配置       | english                               |
| regdictionary | pg_ts_dict   | 文本搜索字典       | simple                                |

##### 伪类型

PostgreSQL类型系统包含一系列特殊用途的条目， 它们按照类别来说叫做伪类型。伪类型不能作为字段的数据类型， 但是它可以用于声明一个函数的参数或者结果类型。 伪类型在一个函数不只是简单地接受并返回某种SQL 数据类型的情况下很有用。

下表列出了所有的伪类型：

| 名字             | 描述                                               |
| :--------------- | :------------------------------------------------- |
| any              | 表示一个函数接受任何输入数据类型。                 |
| anyelement       | 表示一个函数接受任何数据类型。                     |
| anyarray         | 表示一个函数接受任意数组数据类型。                 |
| anynonarray      | 表示一个函数接受任意非数组数据类型。               |
| anyenum          | 表示一个函数接受任意枚举数据类型。                 |
| anyrange         | 表示一个函数接受任意范围数据类型。                 |
| cstring          | 表示一个函数接受或者返回一个空结尾的 C 字符串。    |
| internal         | 表示一个函数接受或者返回一种服务器内部的数据类型。 |
| language_handler | 一个过程语言调用处理器声明为返回language_handler。 |
| fdw_handler      | 一个外部数据封装器声明为返回fdw_handler。          |
| record           | 标识一个函数返回一个未声明的行类型。               |
| trigger          | 一个触发器函数声明为返回trigger。                  |
| void             | 表示一个函数不返回数值。                           |
| opaque           | 一个已经过时的类型，以前用于所有上面这些用途。     |

#### 运算符符与表达式

##### 运算符

运算符是一种告诉编译器执行特定的数学或逻辑操作的符号。PostgreSQL 运算符是一个保留关键字或字符，一般用在 WHERE 语句中，作为过滤条件。

###### 算术运算符

假设变量 a 为 2，变量 b 为 3，则：

| 运算符 |        描述        |        实例         |
| :----: | :----------------: | :-----------------: |
|   +    |         加         |   a + b 结果为 5    |
|   -    |         减         |   a - b 结果为 -1   |
|   *    |         乘         |   a * b 结果为 6    |
|   /    |         除         |   b / a 结果为 1    |
|   %    |     模（取余）     |   b % a 结果为 1    |
|   ^    |        指数        |   a ^ b 结果为 8    |
|  \|/   |       平方根       |  \|/ 25.0 结果为 5  |
| \|\|/  |       立方根       | \|\|/ 27.0 结果为 3 |
|   !    |        阶乘        |   5 ! 结果为 120    |
|   !!   | 阶乘（前缀操作符） |   !! 5 结果为 120   |

###### 比较运算符

假设变量 a 为 10，变量 b 为 20，则：

| 运算符 |   描述   |        实例         |
| :----: | :------: | :-----------------: |
|   =    |   等于   | (a = b) 为 false。  |
|   !=   |  不等于  | (a != b) 为 true。  |
|   <>   |  不等于  | (a <> b) 为 true。  |
|   >    |   大于   | (a > b) 为 false。  |
|   <    |   小于   |  (a < b) 为 true。  |
|   >=   | 大于等于 | (a >= b) 为 false。 |
|   <=   | 小于等于 | (a <= b) 为 true。  |

###### 逻辑运算符

PostgreSQL 逻辑运算符有以下几种：

| 序号 |                        运算符 & 描述                         |
| :--- | :----------------------------------------------------------: |
| 1    | **AND**逻辑与运算符。如果两个操作数都非零，则条件为真。PostgresSQL 中的 WHERE 语句可以用 AND 包含多个过滤条件。 |
|      |                                                              |
| 2    | **NOT**逻辑非运算符。用来逆转操作数的逻辑状态。如果条件为真则逻辑非运算符将使其为假。PostgresSQL 有 NOT EXISTS, NOT BETWEEN, NOT IN 等运算符。 |
| 3    | **OR**逻辑或运算符。如果两个操作数中有任意一个非零，则条件为真。PostgresSQL 中的 WHERE 语句可以用 OR 包含多个过滤条件。 |

SQL 使用三值的逻辑系统，包括 true、false 和 null，null 表示"未知"。

| *`a`* | *`b`* | *`a`* AND *`b`* | *`a`* OR *`b`* |
| :---- | :---- | :-------------- | :------------- |
| TRUE  | TRUE  | TRUE            | TRUE           |
| TRUE  | FALSE | FALSE           | TRUE           |
| TRUE  | NULL  | NULL            | TRUE           |
| FALSE | FALSE | FALSE           | FALSE          |
| FALSE | NULL  | FALSE           | NULL           |
| NULL  | NULL  | NULL            | NULL           |

| *`a`* | NOT *`a`* |
| :---- | :-------- |
| TRUE  | FALSE     |
| FALSE | TRUE      |
| NULL  | NULL      |

###### 位运算符

位运算符作用于位，并逐位执行操作。&、 | 和 ^ 的真值表如下所示：

| p    | q    | p & q | p \| q |
| :--- | :--- | :---- | :----- |
| 0    | 0    | 0     | 0      |
| 0    | 1    | 0     | 1      |
| 1    | 1    | 1     | 1      |
| 1    | 0    | 0     | 1      |

下表显示了 PostgreSQL 支持的位运算符。假设变量 **A** 的值为 60，变量 **B** 的值为 13，则：

| 运算符 | 描述                                                         | 实例                                                         |
| :----- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| &      | 按位与操作，按二进制位进行"与"运算。运算规则：`0&0=0;    0&1=0;     1&0=0;      1&1=1;` | (A & B) 将得到 12，即为 0000 1100                            |
| \|     | 按位或运算符，按二进制位进行"或"运算。运算规则：`0|0=0;    0|1=1;    1|0=1;     1|1=1;` | (A \| B) 将得到 61，即为 0011 1101                           |
| #      | 异或运算符，按二进制位进行"异或"运算。运算规则：`0#0=0;    0#1=1;    1#0=1;   1#1=0;` | (A # B) 将得到 49，即为 0011 0001                            |
| ~      | 取反运算符，按二进制位进行"取反"运算。运算规则：`~1=0;    ~0=1;` | (~A ) 将得到 -61，即为 1100 0011，一个有符号二进制数的补码形式。 |
| <<     | 二进制左移运算符。将一个运算对象的各二进制位全部左移若干位（左边的二进制位丢弃，右边补0）。 | A << 2 将得到 240，即为 1111 0000                            |
| >>     | 二进制右移运算符。将一个数的各二进制位全部右移若干位，正数左补0，负数左补1，右边丢弃。 | A >> 2 将得到 15，即为 0000 1111                             |

##### 表达式

表达式是由一个或多个的值、运算符、PostgresSQL 函数组成的。PostgreSQL 表达式类似一个公式，我们可以将其应用在查询语句中，用来查找数据库中指定条件的结果集。

###### 布尔表达式

布尔表达式是根据一个指定条件来读取数据：

```sql
SELECT column1, column2, columnN
FROM table_name
WHERE SINGLE VALUE MATCHTING EXPRESSION;
```

###### 数字表达式

数字表达式常用于查询语句中的数学运算：

```sql
SELECT numerical_expression as  OPERATION_NAME
[FROM table_name WHERE CONDITION] ;
```

此外 PostgreSQL 还内置了一些数学函数，如：

- avg() ： 返回一个表达式的平均值
- sum() ： 返回指定字段的总和
- count() ： 返回查询的记录总数

###### 日期表达式

日期表达式返回当前系统的日期和时间，可用于各种数据操作，以下实例查询当前时间：

```sql
runoobdb=# SELECT CURRENT_TIMESTAMP;
       current_timestamp       
-------------------------------
 2019-06-13 10:49:06.419243+08
(1 row)
```

#### 函数

PostgreSQL 内置函数也称为聚合函数，用于对字符串或数字数据执行处理。下面是所有通用 PostgreSQL 内置函数的列表：

- COUNT 函数：用于计算数据库表中的行数。
- MAX 函数：用于查询某一特定列中最大值。
- MIN 函数：用于查询某一特定列中最小值。
- AVG 函数：用于计算某一特定列中平均值。
- SUM 函数：用于计算数字列所有值的总和。
- ARRAY 函数：用于输入值(包括null)添加到数组中。
- Numeric 函数：完整列出一个 SQL 中所需的操作数的函数。
- String 函数：完整列出一个 SQL 中所需的操作字符的函数。

##### 数学函数

下面是PostgreSQL中提供的数学函数列表，需要说明的是，这些函数中有许多都存在多种形式，区别只是参数类型不同。除非特别指明，任何特定形式的函数都返回和它的参数相同的数据类型。

| 函数                        | 返回类型 | 描述                   | 例子            | 结果              |
| :-------------------------- | :------- | :--------------------- | :-------------- | :---------------- |
| abs(x)                      |          | 绝对值                 | abs(-17.4)      | 17.4              |
| cbrt(double)                |          | 立方根                 | cbrt(27.0)      | 3                 |
| ceil(double/numeric)        |          | 不小于参数的最小的整数 | ceil(-42.8)     | -42               |
| degrees(double)             |          | 把弧度转为角度         | degrees(0.5)    | 28.6478897565412  |
| exp(double/numeric)         |          | 自然指数               | exp(1.0)        | 2.71828182845905  |
| floor(double/numeric)       |          | 不大于参数的最大整数   | floor(-42.8)    | -43               |
| ln(double/numeric)          |          | 自然对数               | ln(2.0)         | 0.693147180559945 |
| log(double/numeric)         |          | 10为底的对数           | log(100.0)      | 2                 |
| log(b numeric,x numeric)    | numeric  | 指定底数的对数         | log(2.0, 64.0)  | 6.0000000000      |
| mod(y, x)                   |          | 取余数                 | mod(9,4)        | 1                 |
| pi()                        | double   | "π"常量                | pi()            | 3.14159265358979  |
| power(a double, b double)   | double   | 求a的b次幂             | power(9.0, 3.0) | 729               |
| power(a numeric, b numeric) | numeric  | 求a的b次幂             | power(9.0, 3.0) | 729               |
| radians(double)             | double   | 把角度转为弧度         | radians(45.0)   | 0.785398163397448 |
| random()                    | double   | 0.0到1.0之间的随机数值 | random()        |                   |
| round(double/numeric)       |          | 圆整为最接近的整数     | round(42.4)     | 42                |
| round(v numeric, s int)     | numeric  | 圆整为s位小数数字      | round(42.438,2) | 42.44             |
| sign(double/numeric)        |          | 参数的符号(-1,0,+1)    | sign(-8.4)      | -1                |
| sqrt(double/numeric)        |          | 平方根                 | sqrt(2.0)       | 1.4142135623731   |
| trunc(double/numeric)       |          | 截断(向零靠近)         | trunc(42.8)     | 42                |
| trunc(v numeric, s int)     | numeric  | 截断为s小数位置的数字  | trunc(42.438,2) | 42.43             |

##### 三角函数列表

| 函数        | 描述              |
| :---------- | :---------------- |
| acos(x)     | 反余弦            |
| asin(x)     | 反正弦            |
| atan(x)     | 反正切            |
| atan2(x, y) | 正切 y/x 的反函数 |
| cos(x)      | 余弦              |
| cot(x)      | 余切              |
| sin(x)      | 正弦              |
| tan(x)      | 正切              |

##### 字符串函数和操作符

下面是 PostgreSQL 中提供的字符串操作符列表：

| 函数                                                         | 返回类型 | 描述                                                         | 例子                                           | 结果                               |
| :----------------------------------------------------------- | :------- | :----------------------------------------------------------- | :--------------------------------------------- | :--------------------------------- |
| string \|\| string                                           | text     | 字串连接                                                     | 'Post' 丨丨 'greSQL'                           | PostgreSQL                         |
| bit_length(string)                                           | int      | 字串里二进制位的个数                                         | bit_length('jose')                             | 32                                 |
| char_length(string)                                          | int      | 字串中的字符个数                                             | char_length('jose')                            | 4                                  |
| convert(string using conversion_name)                        | text     | 使用指定的转换名字改变编码。                                 | convert('PostgreSQL' using iso_8859_1_to_utf8) | 'PostgreSQL'                       |
| lower(string)                                                | text     | 把字串转化为小写                                             | lower('TOM')                                   | tom                                |
| octet_length(string)                                         | int      | 字串中的字节数                                               | octet_length('jose')                           | 4                                  |
| overlay(string placing string from int [for int])            | text     | 替换子字串                                                   | overlay('Txxxxas' placing 'hom' from 2 for 4)  | Thomas                             |
| position(substring in string)                                | int      | 指定的子字串的位置                                           | position('om' in 'Thomas')                     | 3                                  |
| substring(string [from int] [for int])                       | text     | 抽取子字串                                                   | substring('Thomas' from 2 for 3)               | hom                                |
| substring(string from pattern)                               | text     | 抽取匹配 POSIX 正则表达式的子字串                            | substring('Thomas' from '…$')                  | mas                                |
| substring(string from pattern for escape)                    | text     | 抽取匹配SQL正则表达式的子字串                                | substring('Thomas' from '%#"o_a#"_' for '#')   | oma                                |
| trim([leading丨trailing 丨 both] [characters] from string)   | text     | 从字串string的开头/结尾/两边/ 删除只包含characters(默认是一个空白)的最长的字串 | trim(both 'x' from 'xTomxx')                   | Tom                                |
| upper(string)                                                | text     | 把字串转化为大写。                                           | upper('tom')                                   | TOM                                |
| ascii(text)                                                  | int      | 参数第一个字符的ASCII码                                      | ascii('x')                                     | 120                                |
| btrim(string text [, characters text])                       | text     | 从string开头和结尾删除只包含在characters里(默认是空白)的字符的最长字串 | btrim('xyxtrimyyx','xy')                       | trim                               |
| chr(int)                                                     | text     | 给出ASCII码的字符                                            | chr(65)                                        | A                                  |
| convert(string text, [src_encoding name,] dest_encoding name) | text     | 把字串转换为dest_encoding                                    | convert( 'text_in_utf8', 'UTF8', 'LATIN1')     | 以ISO 8859-1编码表示的text_in_utf8 |
| initcap(text)                                                | text     | 把每个单词的第一个子母转为大写，其它的保留小写。单词是一系列字母数字组成的字符，用非字母数字分隔。 | initcap('hi thomas')                           | Hi Thomas                          |
| length(string text)                                          | int      | string中字符的数目                                           | length('jose')                                 | 4                                  |
| lpad(string text, length int [, fill text])                  | text     | 通过填充字符fill(默认为空白)，把string填充为长度length。 如果string已经比length长则将其截断(在右边)。 | lpad('hi', 5, 'xy')                            | xyxhi                              |
| ltrim(string text [, characters text])                       | text     | 从字串string的开头删除只包含characters(默认是一个空白)的最长的字串。 | ltrim('zzzytrim','xyz')                        | trim                               |
| md5(string text)                                             | text     | 计算给出string的MD5散列，以十六进制返回结果。                | md5('abc')                                     |                                    |
| repeat(string text, number int)                              | text     | 重复string number次。                                        | repeat('Pg', 4)                                | PgPgPgPg                           |
| replace(string text, from text, to text)                     | text     | 把字串string里出现地所有子字串from替换成子字串to。           | replace('abcdefabcdef', 'cd', 'XX')            | abXXefabXXef                       |
| rpad(string text, length int [, fill text])                  | text     | 通过填充字符fill(默认为空白)，把string填充为长度length。如果string已经比length长则将其截断。 | rpad('hi', 5, 'xy')                            | hixyx                              |
| rtrim(string text [, character text])                        | text     | 从字串string的结尾删除只包含character(默认是个空白)的最长的字 | rtrim('trimxxxx','x')                          | trim                               |
| split_part(string text, delimiter text, field int)           | text     | 根据delimiter分隔string返回生成的第field个子字串(1 Base)。   | split_part('abc~@~def~@~ghi', '~@~', 2)        | def                                |
| strpos(string, substring)                                    | text     | 声明的子字串的位置。                                         | strpos('high','ig')                            | 2                                  |
| substr(string, from [, count])                               | text     | 抽取子字串。                                                 | substr('alphabet', 3, 2)                       | ph                                 |
| to_ascii(text [, encoding])                                  | text     | 把text从其它编码转换为ASCII。                                | to_ascii('Karel')                              | Karel                              |
| to_hex(number int/bigint)                                    | text     | 把number转换成其对应地十六进制表现形式。                     | to_hex(9223372036854775807)                    | 7fffffffffffffff                   |
| translate(string text, from text, to text)                   | text     | 把在string中包含的任何匹配from中的字符的字符转化为对应的在to中的字符。 | translate('12345', '14', 'ax')                 | a23x5                              |

##### 类型转换相关函数

| 函数                            | 返回类型  | 描述                                                        | 实例                                         |
| :------------------------------ | :-------- | :---------------------------------------------------------- | :------------------------------------------- |
| to_char(timestamp, text)        | text      | 将时间戳转换为字符串                                        | to_char(current_timestamp, 'HH12:MI:SS')     |
| to_char(interval, text)         | text      | 将时间间隔转换为字符串                                      | to_char(interval '15h 2m 12s', 'HH24:MI:SS') |
| to_char(int, text)              | text      | 整型转换为字符串                                            | to_char(125, '999')                          |
| to_char(double precision, text) | text      | 双精度转换为字符串                                          | to_char(125.8::real, '999D9')                |
| to_char(numeric, text)          | text      | 数字转换为字符串                                            | to_char(-125.8, '999D99S')                   |
| to_date(text, text)             | date      | 字符串转换为日期                                            | to_date('05 Dec 2000', 'DD Mon YYYY')        |
| to_number(text, text)           | numeric   | 转换字符串为数字                                            | to_number('12,454.8-', '99G999D9S')          |
| to_timestamp(text, text)        | timestamp | 转换为指定的时间格式 time zone convert string to time stamp | to_timestamp('05 Dec 2000', 'DD Mon YYYY')   |
| to_timestamp(double precision)  | timestamp | 把UNIX纪元转换成时间戳                                      | to_timestamp(1284352323)                     |

### PostgreSQL 操作

#### 权限操作

无论何时创建数据库对象，都会为其分配一个所有者，所有者通常是执行 create 语句的人。对于大多数类型的对象，初始状态是只有所有者(或超级用户)才能修改或删除对象。要允许其他角色或用户使用它，必须为该用户设置权限。在 PostgreSQL 中，权限分为以下几种：SELECT、INSERT、UPDATE、DELETE、TRUNCATE、REFERENCES、TRIGGER、CREATE、CONNECT、TEMPORARY、EXECUTE、USAGE

根据对象的类型(表、函数等)，将指定权限应用于该对象。要向用户分配权限，可以使用 GRANT 命令。

##### 授权

GRANT 命令的基本语法如下：

```sql
GRANT privilege [, ...]
ON object [, ...]
TO { PUBLIC | GROUP group | username }
```

- privilege − 值可以为：SELECT，INSERT，UPDATE，DELETE， RULE，ALL。
- object − 要授予访问权限的对象名称。可能的对象有： table， view，sequence。
- PUBLIC − 表示所有用户。
- GROUP group − 为用户组授予权限。
- username − 要授予权限的用户名。PUBLIC 是代表所有用户的简短形式。

##### 撤权

另外，我们可以使用 REVOKE 命令取消权限，REVOKE 语法：

```sql
REVOKE privilege [, ...]
ON object [, ...]
FROM { PUBLIC | GROUP groupname | username }
```

#### 数据库操作

##### 创建数据库

PostgreSQL 创建数据库可以用以下三种方式：

- 使用 **CREATE DATABASE** SQL 语句来创建。

```sql
CREATE DATABASE dbname;
```

- 使用 **createdb** 命令来创建。createdb 是一个 SQL 命令 CREATE DATABASE 的封装。

```sql
createdb [option...] [dbname [description]]
```

**dbname**：要创建的数据库名。

**description**：关于新创建的数据库相关的说明。

**options**：参数可选项，可以是以下值：

| 序号 |                     选项 & 描述                     |
| :--- | :-------------------------------------------------: |
| 1    |       **-D tablespace**指定数据库默认表空间。       |
| 2    |     **-e**将 createdb 生成的命令发送到服务端。      |
| 3    |          **-E encoding**指定数据库的编码。          |
| 4    |         **-l locale**指定数据库的语言环境。         |
| 5    |       **-T template**指定创建此数据库的模板。       |
| 6    |      **--help**显示 createdb 命令的帮助信息。       |
| 7    |           **-h host**指定服务器的主机名。           |
| 8    | **-p port**指定服务器监听的端口，或者 socket 文件。 |
| 9    |         **-U username**连接数据库的用户名。         |
| 10   |                **-w**忽略输入密码。                 |
| 11   |           **-W**连接时强制要求输入密码。            |

```
$ cd /Library/PostgreSQL/11/bin/
$ createdb -h localhost -p 5432 -U postgres runoobdb
password ******
```

以上命令我们使用了超级用户 postgres 登录到主机地址为 localhost，端口号为 5432 的 PostgreSQL 数据库中并创建 runoobdb 数据库。

##### 选择数据库

使用 **\l** 用于查看已经存在的数据库：

```
postgres=# \l
                             List of databases
   Name    |  Owner   | Encoding | Collate | Ctype |   Access privileges   
-----------+----------+----------+---------+-------+-----------------------
 postgres  | postgres | UTF8     | C       | C     | 
 runoobdb  | postgres | UTF8     | C       | C     | 
 template0 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
 template1 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
(4 rows)
```

接下来我们可以使用 **\c + 数据库名** 来进入数据库：

```
postgres=# \c runoobdb
You are now connected to database "runoobdb" as user "postgres".
runoobdb=# 
```

##### 删除数据库

PostgreSQL 删除数据库可以用以下三种方式：

- 使用 **DROP DATABASE** SQL 语句来删除。

DROP DATABASE 命令需要在 PostgreSQL 命令窗口来执行，语法格式如下：

```sql
DROP DATABASE [ IF EXISTS ] name
# **参数说明：**

# - **IF EXISTS**：如果数据库不存在则发出提示信息，而不是错误信息。
# - **name**：要删除的数据库的名称。
```

- 使用 **dropdb** 命令来删除。

dropdb 是 DROP DATABASE 的包装器。dropdb 用于删除 PostgreSQL 数据库。dropdb 命令只能由超级管理员或数据库拥有者执行。

```
dropdb [connection-option...] [option...] dbname
```

**参数说明：**

**dbname**：要删除的数据库名。

**options**：参数可选项，可以是以下值：

| 序号 |                         选项 & 描述                          |
| :--- | :----------------------------------------------------------: |
| 1    |      **-e**显示 dropdb 生成的命令并发送到数据库服务器。      |
| 2    |          **-i**在做删除的工作之前发出一个验证提示。          |
| 3    |                **-V**打印 dropdb 版本并退出。                |
| 4    | **--if-exists**如果数据库不存在则发出提示信息，而不是错误信息。 |
| 5    |          **--help**显示有关 dropdb 命令的帮助信息。          |
| 6    |             **-h host**指定运行服务器的主机名。              |
| 7    |     **-p port**指定服务器监听的端口，或者 socket 文件。      |
| 8    |             **-U username**连接数据库的用户名。              |
| 9    |                  **-w**连接时忽略输入密码。                  |
| 10   |                **-W**连接时强制要求输入密码。                |
| 11   | **--maintenance-db=dbname**删除数据库时指定连接的数据库，默认为 postgres，如果它不存在则使用 template1。 |

```
$ cd /Library/PostgreSQL/11/bin/
$ dropdb -h localhost -p 5432 -U postgres runoobdb
password ******
```

以上命令我们使用了超级用户 postgres 登录到主机地址为 localhost，端口号为 5432 的 PostgreSQL 数据库中并删除 runoobdb 数据库。

#### 表格操作

##### 创建模式

我们可以使用 **CREATE SCHEMA** 语句来创建模式，语法格式如下：

```sql
CREATE SCHEMA myschema (
...
);
```

上述语句将创建一个名为 myschema 的模式。模式通常用于组织和隔离数据库对象，防止对象名称冲突。

创建表（Table）使用 CREATE TABLE 语句:

```sql
CREATE TABLE myschema.mytable (
    column1 datatype1,
    column2 datatype2,
    ...
);
```

上述语句将在 myschema 模式下创建一个名为 mytable 的表，并定义了一系列的列及其数据类型。

##### 删除模式

删除一个为空的模式（其中的所有对象已经被删除）：

```
DROP SCHEMA myschema;
```

删除一个模式以及其中包含的所有对象：

```
DROP SCHEMA myschema CASCADE;
```

#### 表格操作

##### 创建表格

PostgreSQL 使用 CREATE TABLE 语句来创建数据库表格。**CREATE TABLE** 语法格式如下：

```sql
CREATE TABLE table_name(
   column1 datatype,
   column2 datatype,
   column3 datatype,
   .....
   columnN datatype,
   PRIMARY KEY( 一个或多个列 )
);
```

**CREATE TABLE** 是一个关键词，用于告诉数据库系统将创建一个数据表。表名字必需在同一模式中的其它表、 序列、索引、视图或外部表名字中唯一。**CREATE TABLE** 在当前数据库创建一个新的空白表，该表将由发出此命令的用户所拥有。

表格中的每个字段都会定义数据类型，如下创建了一个表，表名为 **COMPANY** 表格，主键为 **ID**，**NOT NULL** 表示字段不允许包含 **NULL** 值：

```sql
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

CREATE TABLE DEPARTMENT(
   ID INT PRIMARY KEY      NOT NULL,
   DEPT           CHAR(50) NOT NULL,
   EMP_ID         INT      NOT NULL
);
```

我们可以使用 **\d** 命令来查看表格是否创建成功：

```sql
runoobdb=# \d
           List of relations
 Schema |    Name    | Type  |  Owner   
--------+------------+-------+----------
 public | company    | table | postgres
 public | department | table | postgres
(2 rows)
```

**\d tablename** 查看表格信息：

```sql
runoobdb=# \d company
                  Table "public.company"
 Column  |     Type      | Collation | Nullable | Default 
---------+---------------+-----------+----------+---------
 id      | integer       |           | not null | 
 name    | text          |           | not null | 
 age     | integer       |           | not null | 
 address | character(50) |           |          | 
 salary  | real          |           |          | 
Indexes:
    "company_pkey" PRIMARY KEY, btree (id)
```

##### 修改表格

在 PostgreSQL 中，**ALTER TABLE** 命令用于添加，修改，删除一张已经存在表的列。另外你也可以用 **ALTER TABLE** 命令添加和删除约束。

用 ALTER TABLE 在一张已存在的表上添加列的语法如下：

```sql
ALTER TABLE table_name ADD column_name datatype;
```

在一张已存在的表上 DROP COLUMN（删除列），语法如下：

```sql
ALTER TABLE table_name DROP COLUMN column_name;
```

修改表中某列的 DATA TYPE（数据类型），语法如下：

```sql
ALTER TABLE table_name ALTER COLUMN column_name TYPE datatype;
```

给表中某列添加 NOT NULL 约束，语法如下：

```sql
ALTER TABLE table_name ALTER column_name datatype NOT NULL;
```

给表中某列 ADD UNIQUE CONSTRAINT（ 添加 UNIQUE 约束），语法如下：

```sql
ALTER TABLE table_name
ADD CONSTRAINT MyUniqueConstraint UNIQUE(column1, column2...);
```

给表中 ADD CHECK CONSTRAINT（添加 CHECK 约束），语法如下：

```sql
ALTER TABLE table_name
ADD CONSTRAINT MyUniqueConstraint CHECK (CONDITION);
```

给表 ADD PRIMARY KEY（添加主键），语法如下：

```sql
ALTER TABLE table_name
ADD CONSTRAINT MyPrimaryKey PRIMARY KEY (column1, column2...);
```

DROP CONSTRAINT （删除约束），语法如下：

```sql
ALTER TABLE table_name
DROP CONSTRAINT MyUniqueConstraint;
```

如果是 MYSQL ，代码是这样：

```sql
ALTER TABLE table_name
DROP INDEX MyUniqueConstraint;
```

DROP PRIMARY KEY （删除主键），语法如下：

```sql
ALTER TABLE table_name
DROP CONSTRAINT MyPrimaryKey;
```

如果是 MYSQL ，代码是这样：

```sql
ALTER TABLE table_name
DROP PRIMARY KEY;
```

##### 约束表格

PostgreSQL 约束用于规定表中的数据规则。如果存在违反约束的数据行为，行为会被约束终止。约束可以在创建表时规定（通过 CREATE TABLE 语句），或者在表创建之后规定（通过 ALTER TABLE 语句）。约束确保了数据库中数据的准确性和可靠性。约束可以是列级或表级。列级约束仅适用于列，表级约束被应用到整个表。

###### NOT NULL 约束

默认情况下，列可以保存为 NULL 值。如果您不想某列有 NULL 值，那么需要在该列上定义此约束，指定在该列上不允许 NULL 值。NULL 与没有数据是不一样的，它代表着未知的数据。

下面实例创建了一张新表叫 COMPANY1，添加了 5 个字段，其中三个 ID，NAME，AGE 设置不接受空置：

```sql
CREATE TABLE COMPANY1(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);
```

###### UNIQUE 约束

UNIQUE 约束可以设置列是唯一的，避免同一列出现重复值。

下面实例创建了一张新表叫 COMPANY3，添加了 5 个字段，其中 AGE 设置为 UNIQUE，因此你不能添加两条有相同年龄的记录：

```sql
CREATE TABLE COMPANY3(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL UNIQUE,
   ADDRESS        CHAR(50),
   SALARY         REAL    DEFAULT 50000.00
);
```

###### PRIMARY KEY

在设计数据库时，PRIMARY KEY 非常重要。PRIMARY KEY 称为主键，是数据表中每一条记录的唯一标识。设置 UNIQUE 的列可能有多个，但是一张表只有一列可以设置 PRIMARY KEY。我们可以使用主键来引用表中的行，也可以通过把主键设置为其他表的外键，来创建表之间的关系。主键是非空约束和唯一约束的组合。一个表只能有一个主键，它可以由一个或多个字段组成，当多个字段作为主键，它们被称为复合键。如果一个表在任何字段上定义了一个主键，那么在这些字段上不能有两个记录具有相同的值。

下面我们创建 COMAPNY4 表，其中 ID 作为主键：

```sql
CREATE TABLE COMPANY4(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);
```

###### FOREIGN KEY 约束

FOREIGN KEY 即外键约束，指定列(或一组列)中的值必须匹配另一个表的某一行中出现的值。通常一个表中的 FOREIGN KEY 指向另一个表中的 UNIQUE KEY(唯一约束的键)，即维护了两个相关表之间的引用完整性。

下面实例创建了一张 COMPANY6 表，并添加了5个字段：

```sql
CREATE TABLE COMPANY6(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);
```

下面实例创建一张 DEPARTMENT1 表，并添加 3 个字段，EMP_ID 就是外键，参照 COMPANY6 的 ID：

```sql
CREATE TABLE DEPARTMENT1(
   ID INT PRIMARY KEY      NOT NULL,
   DEPT           CHAR(50) NOT NULL,
   EMP_ID         INT      REFERENCES COMPANY6(ID)
   # 或者更完整的写法  FOREIGN KEY (EMP_ID) REFERENCES COMPANY6(ID)
);
```

###### CHECK 约束

CHECK 约束保证列中的所有值满足某一条件，即对输入一条记录要进行检查。如果条件值为 false，则记录违反了约束，且不能输入到表。

例如，下面实例建一个新的表 COMPANY5，增加了五列。在这里，我们为 SALARY 列添加 CHECK，所以工资不能为零：

```sql
CREATE TABLE COMPANY5(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL    CHECK(SALARY > 0)
);
```

###### EXCLUSION 约束

EXCLUSION 约束确保如果使用指定的运算符在指定列或表达式上比较任意两行，至少其中一个运算符比较将返回 false 或 null。

下面实例创建了一张 COMPANY7 表，添加 5 个字段，并且使用了 EXCLUDE 约束。

```sql
CREATE TABLE COMPANY7(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT,
   AGE            INT  ,
   ADDRESS        CHAR(50),
   SALARY         REAL,
   EXCLUDE USING gist
   (NAME WITH =,  -- 如果满足 NAME 相同，AGE 不相同则不允许插入，否则允许插入
   AGE WITH <>)   -- 其比较的结果是如果整个表达式返回 true，则不允许插入，否则允许
);
```

这里的 `gist` 指的是 **GiST 索引访问方法**，写在 `USING` 后面是语法的一部分。您需要为每个数据库执行一次 CREATE EXTENSION btree_gist 命令，这将安装 btree_gist 扩展，它定义了对纯标量数据类型的 EXCLUDE 约束。由于我们已经强制执行了年龄必须相同，让我们通过向表插入记录来查看这一点：

```sql
INSERT INTO COMPANY7 VALUES(1, 'Paul', 32, 'California', 20000.00 );
INSERT INTO COMPANY7 VALUES(2, 'Paul', 32, 'Texas', 20000.00 );
-- 此条数据的 NAME 与第一条相同，且 AGE 与第一条也相同，故满足插入条件
INSERT INTO COMPANY7 VALUES(3, 'Allen', 42, 'California', 20000.00 );
-- 此数据与上面数据的 NAME 相同，但 AGE 不相同，故不允许插入
```

前面两条顺利添加的 COMPANY7 表中，但是第三条则会报错：

```
ERROR:  conflicting key value violates exclusion constraint "company7_name_age_excl"
DETAIL:  Key (name, age)=(Paul, 42) conflicts with existing key (name, age)=(Paul, 32).
```

###### AUTO INCREMENT

AUTO INCREMENT（自动增长） 会在新记录插入表中时生成一个唯一的数字。PostgreSQL 使用序列来标识字段的自增长，数据类型有 smallserial、serial 和 bigserial 。这些属性类似于 MySQL 数据库支持的AUTO_INCREMENT 属性。

使用 MySQL 设置自动增长的语句如下:

```sql
CREATE TABLE IF NOT EXISTS `runoob_tbl`(
   `runoob_id` INT UNSIGNED AUTO_INCREMENT,
   `runoob_title` VARCHAR(100) NOT NULL,
   `runoob_author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY ( `runoob_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

MySQL 是用 AUTO_INCREMENT 这个属性来标识字段的自增。

PostgreSQL 使用序列来标识字段的自增长：

```sql
CREATE TABLE runoob
(
    id serial NOT NULL,
    alttext text,
    imgurl text
)
```

SMALLSERIAL、SERIAL 和 BIGSERIAL 范围：

| 伪类型        | 存储大小 | 范围                          |
| :------------ | :------- | :---------------------------- |
| `SMALLSERIAL` | 2字节    | 1 到 32,767                   |
| `SERIAL`      | 4字节    | 1 到 2,147,483,647            |
| `BIGSERIAL`   | 8字节    | 1 到 922,337,2036,854,775,807 |

SERIAL 数据类型基础语法如下：

```sql
CREATE TABLE tablename (
   colname SERIAL
);
```

###### 删除约束

删除约束必须知道约束名称，已经知道名称来删除约束很简单，如果不知道名称，则需要找到系统生成的名称，使用 **\d 表名** 可以找到这些信息。通用语法如下：

```
ALTER TABLE table_name DROP CONSTRAINT some_name;
```

##### 清空表格

PostgreSQL 中 TRUNCATE TABLE 用于删除表的数据，但不删除表结构。也可以用 DROP TABLE 删除表，但是这个命令会连表的结构一起删除，如果想插入数据，需要重新建立这张表。TRUNCATE TABLE 与 DELETE 具有相同的效果，但是由于它实际上并不扫描表，所以速度更快。 此外，TRUNCATE TABLE 可以立即释放表空间，而不需要后续 VACUUM 操作，这在大型表上非常有用。PostgreSQL VACUUM 操作用于释放、再利用更新/删除行所占据的磁盘空间。

TRUNCATE TABLE 基础语法如下：

```sql
TRUNCATE TABLE  table_name;
```

##### 删除表格

PostgreSQL 使用 DROP TABLE 语句来删除表格，包含表格数据、规则、触发器等，所以删除表格要慎重，删除后所有信息就消失了。**DROP TABLE** 语法格式如下：

```sql
DROP TABLE table_name;
```

从以上结果可以看出，我们表格已经创建成功，接下来我们删除这两个表格：

```sql
runoobdb=# drop table department, company;
DROP TABLE
```

再使用 **\d** 命令来查看就找不到表格了：

```sql
testdb=# \d
Did not find any relations.
```

#### 记录操作

##### 插入操作

PostgreSQL INSERT INTO 语句用于向表中插入新记录。INSERT INTO 语句语法格式如下：

```sql
INSERT INTO TABLE_NAME (column1, column2, column3,...columnN)
VALUES (value1, value2, value3,...valueN);
```

- column1, column2,...columnN 为表中字段名。
- value1, value2, value3,...valueN 为字段对应的值。

在使用 INSERT INTO 语句时，字段列必须和数据值数量相同，且顺序也要对应。如果我们向表中的所有字段插入值，则可以不需要指定字段，只需要指定插入的值即可：

```sql
INSERT INTO TABLE_NAME VALUES (value1,value2,value3,...valueN);
```

下表列出执行插入后返回结果的说明：

| 序号 |                       输出信息 & 描述                        |
| :--- | :----------------------------------------------------------: |
| 1    | **INSERT oid 1**只插入一行并且目标表具有 OID的返回信息， 那么 oid 是分配给被插入行的 OID。 |
| 2    |     **INSERT 0 #**插入多行返回的信息， # 为插入的行数。      |

##### 查找记录

SELECT 语句语法格式如下：

```
SELECT column1, column2,...columnN FROM table_name;
```

- column1, column2,...columnN 为表中字段名。
- table_name 为表名。



如果我们想读取表中的所有数据可以使用以下 SQL 语句：

```
SELECT * FROM table_name;
```

##### 更新记录

以下是 UPDATE 语句修改数据的通用 SQL 语法：

```
UPDATE table_name
SET column1 = value1, column2 = value2...., columnN = valueN
WHERE [condition];
```

- 我们可以同时更新一个或者多个字段。
- 我们可以在 WHERE 子句中指定任何条件。

##### 删除记录

以下是 DELETE 语句删除数据的通用语法：

```
DELETE FROM table_name WHERE [condition];
```

如果没有指定 WHERE 子句，PostgreSQL 表中的所有记录将被删除。

##### 过滤记录

在 PostgreSQL 中，当我们需要根据指定条件从单张表或者多张表中查询数据时，就可以在 SELECT 语句中添加 WHERE 子句，从而过滤掉我们不需要数据。WHERE 子句不仅可以用于 SELECT 语句中，同时也可以用于 UPDATE，DELETE 等等语句中。

以下是 SELECT 语句中使用 WHERE 子句从数据库中读取数据的通用语法：

```sql
SELECT column1, column2, columnN
FROM table_name
WHERE [condition1]
```

我们可以在 WHERE 子句中使用比较运算符或逻辑运算符，例如 **>, <, =, LIKE, NOT** 等等。

创建 COMPANY 表，数据内容如下：

```sql
runoobdb# select * from COMPANY;
 id | name  | age | address   | salary
----+-------+-----+-----------+--------
  1 | Paul  |  32 | California|  20000
  2 | Allen |  25 | Texas     |  15000
  3 | Teddy |  23 | Norway    |  20000
  4 | Mark  |  25 | Rich-Mond |  65000
  5 | David |  27 | Texas     |  85000
  6 | Kim   |  22 | South-Hall|  45000
  7 | James |  24 | Houston   |  10000
(7 rows)
```

以下几个实例我们使用逻辑运算符来读取表中的数据。

###### AND

AND 运算符表示一个或者多个条件必须同时成立。在 WHERE 子句中，AND 的使用语法如下：

```sql
SELECT column1, column2, columnN
FROM table_name
WHERE [condition1] AND [condition2]...AND [conditionN];
```

###### OR

OR 运算符表示多个条件中只需满足其中任意一个即可。在 WHERE 子句中，OR 的使用语法如下：

```sql
SELECT column1, column2, columnN
FROM table_name
WHERE [condition1] OR [condition2]...OR [conditionN]
```

###### NULL/Not NULL

当创建表时，NULL 的基本语法如下：

```sql
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);
```

这里，NOT NULL 表示强制字段始终包含值。这意味着，如果不向字段添加值，就无法插入新记录或者更新记录。具有 NULL 值的字段表示在创建记录时可以留空。在查询数据时，NULL 值可能会导致一些问题，因为一个未知的值去与其他任何值比较，结果永远是未知的。另外无法比较 NULL 和 0，因为它们是不等价的。

用 IS NOT NULL 操作符把所有 SALARY（薪资） 值不为空的记录列出来：

```SQL
SELECT  ID, NAME, AGE, ADDRESS, SALARY FROM COMPANY WHERE SALARY IS NOT NULL;
```

IS NULL 用来查找为 NULL 值的字段。下面是 IS NULL 操作符的用法，列出 SALARY（薪资） 值为空的记录：

```SQL
SELECT  ID, NAME, AGE, ADDRESS, SALARY FROM COMPANY WHERE SALARY IS NULL;
```

###### DISTINCT

在 PostgreSQL 中，DISTINCT 关键字与 SELECT 语句一起使用，用于去除重复记录，只获取唯一的记录。用于去除重复记录的 DISTINCT 关键字的基本语法如下：

```sql
SELECT DISTINCT column1, column2,.....columnN
FROM table_name
WHERE [condition]
```

###### LIKE

在 PostgreSQL 数据库中，我们如果要获取包含某些字符的数据，可以使用 **LIKE** 子句。在 LIKE 子句中，通常与通配符结合使用，通配符表示任意字符，在 PostgreSQL 中，主要有以下两种通配符：

- 百分号 **%**： 匹配任意字符
- 下划线 **_**： 匹配一个字符

如果没有使用以上两种通配符，LIKE 子句和等号 **=** 得到的结果是一样的。以下是使用 LIKE 子句搭配百分号 **%** 和下划线 **_** 从数据库中获取数据的通用语法：

```sql
SELECT FROM table_name WHERE column LIKE 'XXXX%';
或者
SELECT FROM table_name WHERE column LIKE '%XXXX%';
或者
SELECT FROM table_name WHERE column LIKE 'XXXX_';
或者
SELECT FROM table_name WHERE column LIKE '_XXXX';
或者
SELECT FROM table_name WHERE column LIKE '_XXXX_';
```

###### IN

以下 SELECT 语句列出了 **AGE(年龄)** 字段为 25 或 27 的数据：

```
runoobdb=# SELECT * FROM COMPANY WHERE AGE IN ( 25, 27 );
 id | name  | age | address    | salary
----+-------+-----+------------+--------
  2 | Allen |  25 | Texas      |  15000
  4 | Mark  |  25 | Rich-Mond  |  65000
  5 | David |  27 | Texas      |  85000
(3 rows)
```

###### NOT IN

以下 SELECT 语句列出了 **AGE(年龄)** 字段不为 25 或 27 的数据：

```
runoobdb=# SELECT * FROM COMPANY WHERE AGE NOT IN ( 25, 27 );
 id | name  | age | address    | salary
----+-------+-----+------------+--------
  1 | Paul  |  32 | California |  20000
  3 | Teddy |  23 | Norway     |  20000
  6 | Kim   |  22 | South-Hall |  45000
  7 | James |  24 | Houston    |  10000
(4 rows)
```

###### BETWEEN

以下 SELECT 语句列出了 **AGE(年龄)** 字段在 25 到 27 的数据：

```
runoobdb=# SELECT * FROM COMPANY WHERE AGE BETWEEN 25 AND 27;
 id | name  | age | address    | salary
----+-------+-----+------------+--------
  2 | Allen |  25 | Texas      |  15000
  4 | Mark  |  25 | Rich-Mond  |  65000
  5 | David |  27 | Texas      |  85000
(3 rows)
```

###### LIMIT 与 OFFSET

PostgreSQL 中的 **limit** 子句用于限制 SELECT 语句中查询的数据的数量。带有 LIMIT 子句的 SELECT 语句的基本语法如下：

```sql
SELECT column1, column2, columnN
FROM table_name
LIMIT [no of rows]
```

下面是 LIMIT 子句与 OFFSET 子句一起使用时的语法，用以表示偏移现实多少行：

```sql
SELECT column1, column2, columnN 
FROM table_name
LIMIT [no of rows] OFFSET [row num]
```

###### ORDER BY

在 PostgreSQL 中，**ORDER BY** 用于对一列或者多列数据进行升序（ASC）或者降序（DESC）排列。ORDER BY 子句的基础语法如下：

```sql
SELECT column-list
FROM table_name
[WHERE condition]
[ORDER BY column1, column2, .. columnN] [ASC | DESC];
```

您可以在 ORDER BY 中使用一列或者多列，但是必须保证要排序的列必须存在。**ASC** 表示升序，**DESC** 表示降序。

###### 子查询

以下的 SELECT 语句使用了 SQL 的子查询，子查询语句中读取 **SALARY(薪资)** 字段大于 65000 的数据，然后通过 **EXISTS** 运算符判断它是否返回行，如果有返回行则读取所有的 **AGE(年龄)** 字段。

```
runoobdb=# SELECT AGE FROM COMPANY
        WHERE EXISTS (SELECT AGE FROM COMPANY WHERE SALARY > 65000);
 age
-----
  32
  25
  23
  25
  27
  22
  24
(7 rows)
```

以下的 SELECT 语句同样使用了 SQL 的子查询，子查询语句中读取 **SALARY(薪资)** 字段大于 65000 的 **AGE(年龄)** 字段数据，然后用 **>** 运算符查询大于该 **AGE(年龄)** 字段数据：

```
runoobdb=# SELECT * FROM COMPANY
        WHERE AGE > (SELECT AGE FROM COMPANY WHERE SALARY > 65000);
 id | name | age | address    | salary
----+------+-----+------------+--------
  1 | Paul |  32 | California |  20000
```

##### 分组记录

###### GROUP BY

在 PostgreSQL 中，**GROUP BY** 语句和 SELECT 语句一起使用，用来对相同的数据进行分组。GROUP BY 在一个 SELECT 语句中，放在 WHERE 子句的后面，ORDER BY 子句的前面。下面给出了 GROUP BY 子句的基本语法:

```sql
SELECT column-list
FROM table_name
WHERE [ conditions ]
GROUP BY column1, column2....columnN
ORDER BY column1, column2....columnN
```

GROUP BY 子句必须放在 WHERE 子句中的条件之后，必须放在 ORDER BY 子句之前。在 GROUP BY 子句中，你可以对一列或者多列进行分组，但是被分组的列必须存在于列清单中。

HAVING 子句可以让我们筛选分组后的各组数据。

WHERE 子句在所选列上设置条件，而 HAVING 子句则在由 GROUP BY 子句创建的分组上设置条件。

###### HAVING

HAVING 子句可以让我们筛选分组后的各组数据。HAVING 子句必须放置于 GROUP BY 子句后面，ORDER BY 子句前面，下面是 HAVING 子句在 SELECT 语句中基础语法：

```sql
SELECT column1, column2
FROM table1, table2
WHERE [ conditions ]
GROUP BY column1, column2
HAVING [ conditions ]
ORDER BY column1, column2
```

##### 多表记录

###### 连接

PostgreSQL JOIN 子句用于把来自两个或多个表的行结合起来，基于这些表之间的共同字段。

在 PostgreSQL 中，JOIN 有五种连接类型：

- CROSS JOIN ：交叉连接
- INNER JOIN：内连接
- LEFT OUTER JOIN：左外连接
- RIGHT OUTER JOIN：右外连接
- FULL OUTER JOIN：全外连接

其中交叉连接是无条件连接，而其他连接必须给出布尔表达式或者列名做条件连接。

**交叉连接/笛卡尔积**：交叉连接（CROSS JOIN）把第一个表的每一行与第二个表的每一行进行匹配。如果两个输入表分别有 x 和 y 行，则结果表有 x*y 行。由于交叉连接（CROSS JOIN）有可能产生非常大的表，使用时必须谨慎，只在适当的时候使用它们。下面是 CROSS JOIN 的基础语法：

```sql
SELECT ... FROM table1 CROSS JOIN table2 ...
```

**内连接**：内连接（INNER JOIN）根据连接谓词结合两个表（table1 和 table2）的列值来创建一个新的结果表。查询会把 table1 中的每一行与 table2 中的每一行进行比较，找到所有满足连接谓词的行的匹配对。当满足连接谓词时，A 和 B 行的每个匹配对的列值会合并成一个结果行。内连接（INNER JOIN）是最常见的连接类型，是默认的连接类型。INNER 关键字是可选的。

下面是内连接（INNER JOIN）的语法：

```sql
SELECT table1.column1, table2.column2...
FROM table1
INNER JOIN table2
ON table1.common_filed = table2.common_field;
```

**左外连接**：对于左外连接，首先执行一个内连接。然后，对于表 T1 中不满足表 T2 中连接条件的每一行，其中 T2 的列中有 null 值也会添加一个连接行。因此，连接的表在 T1 中每一行至少有一行。

下面是左外连接（ LEFT OUTER JOIN ）的基础语法：

```sql
SELECT ... FROM table1 LEFT OUTER JOIN table2 ON conditional_expression ...
```

**右外连接**：首先，执行内部连接。然后，对于表T2中不满足表T1中连接条件的每一行，其中T1列中的值为空也会添加一个连接行。这与左联接相反;对于T2中的每一行，结果表总是有一行。

下面是右外连接（ RIGHT OUT JOIN）的基本语法：

```sql
SELECT ... FROM table1 RIGHT OUTER JOIN table2 ON conditional_expression ...
```

**外连接**：首先，执行内部连接。然后，对于表 T1 中不满足表 T2 中任何行连接条件的每一行，如果 T2 的列中有 null 值也会添加一个到结果中。此外，对于 T2 中不满足与 T1 中的任何行连接条件的每一行，将会添加 T1 列中包含 null 值的到结果中。下面是外连接的基本语法：

```sql
SELECT ... FROM table1 FULL OUTER JOIN table2 ON conditional_expression ...
```

有些数据库里，可以不用 `ON`，改用 `USING`，前提是两边连接列同名。

```sql
SELECT *
FROM A
JOIN B
USING (id);、
# 这就相当于：
SELECT *
FROM A
JOIN B
ON A.id = B.id;
```

###### 联合

PostgreSQL UNION 操作符合并两个或多个 SELECT 语句的结果。UNION 操作符用于合并两个或多个 SELECT 语句的结果集。请注意，UNION 内部的每个 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型。但是并不要求列名一致。同时，每个 SELECT 语句中的列的顺序必须相同。合并结果一般以第一操作为主。

UNIONS 基础语法如下：

```sql
SELECT column1 [, column2 ]
FROM table1 [, table2 ]
[WHERE condition]

UNION

SELECT column1 [, column2 ]
FROM table1 [, table2 ]
[WHERE condition]
```

这里的条件语句可以根据您的需要设置任何表达式。UNION ALL 操作符可以连接两个有重复行的 SELECT 语句，默认地，UNION 操作符选取不同的值。如果允许重复的值，请使用 UNION ALL。UINON ALL 子句基础语法如下：

```sql
SELECT column1 [, column2 ]
FROM table1 [, table2 ]
[WHERE condition]

UNION ALL

SELECT column1 [, column2 ]
FROM table1 [, table2 ]
[WHERE condition]
```

#### 视图操作

View（视图）是一张假表，只不过是通过相关的名称存储在数据库中的一个 PostgreSQL 语句。View（视图）实际上是一个以预定义的 PostgreSQL 查询形式存在的表的组合。View（视图）可以包含一个表的所有行或从一个或多个表选定行。View（视图）可以从一个或多个表创建，这取决于要创建视图的 PostgreSQL 查询。View（视图）是一种虚拟表，允许用户实现以下几点：

- 用户或用户组认为更自然或直观查找结构数据的方式。
- 限制数据访问，用户只能看到有限的数据，而不是完整的表。
- 汇总各种表中的数据，用于生成报告。

PostgreSQL 视图是只读的，因此可能无法在视图上执行 DELETE、INSERT 或 UPDATE 语句。但是可以在视图上创建一个触发器，当尝试 DELETE、INSERT 或 UPDATE 视图时触发，需要做的动作在触发器内容中定义。

##### 创建视图

在 PostgreSQL 用 CREATE VIEW 语句创建视图，视图创建可以从一张表，多张表或者其他视图。

CREATE VIEW 基础语法如下：

```sql
CREATE [TEMP | TEMPORARY] VIEW view_name AS
SELECT column1, column2.....
FROM table_name
WHERE [condition];
```

您可以在 SELECT 语句中包含多个表，这与在正常的 SQL SELECT 查询中的方式非常相似。如果使用了可选的 TEMP 或 TEMPORARY 关键字，则将在临时数据库中创建视图。

##### 删除视图

要删除视图，只需使用带有 view_name 的 DROP VIEW 语句。DROP VIEW 的基本语法如下：

```sql
DROP VIEW view_name;
```

#### 触发器操作

PostgreSQL 触发器是数据库的回调函数，它会在指定的数据库事件发生时自动执行/调用。

下面是关于 PostgreSQL 触发器几个比较重要的点：

- PostgreSQL 触发器可以在下面几种情况下触发：
  - 在执行操作之前（在检查约束并尝试插入、更新或删除之前）。
  - 在执行操作之后（在检查约束并插入、更新或删除完成之后）。
  - 更新操作（在对一个视图进行插入、更新、删除时）。
- 触发器的 FOR EACH ROW 属性是可选的，如果选中，当操作修改时每行调用一次；相反，选中 FOR EACH STATEMENT，不管修改了多少行，每个语句标记的触发器执行一次。
- WHEN 子句和触发器操作在引用 NEW.column-name 和 OLD.column-name 表单插入、删除或更新时可以访问每一行元素。其中 column-name 是与触发器关联的表中的列的名称。
- 如果存在 WHEN 子句，PostgreSQL 语句只会执行 WHEN 子句成立的那一行，如果没有 WHEN 子句，PostgreSQL 语句会在每一行执行。
- BEFORE 或 AFTER 关键字决定何时执行触发器动作，决定是在关联行的插入、修改或删除之前或者之后执行触发器动作。
- 要修改的表必须存在于同一数据库中，作为触发器被附加的表或视图，且必须只使用 tablename，而不是 database.tablename。
- 当创建约束触发器时会指定约束选项。这与常规触发器相同，只是可以使用这种约束来调整触发器触发的时间。当约束触发器实现的约束被违反时，它将抛出异常。

##### 创建触发器

创建触发器时的基础语法如下：

```sql
CREATE  TRIGGER trigger_name [BEFORE|AFTER|INSTEAD OF] event_name
ON table_name
[
 -- 触发器逻辑....
];
```

在这里，event_name 可以是在所提到的表 table_name 上的 INSERT、DELETE 和 UPDATE 数据库操作。您可以在表名后选择指定 FOR EACH ROW。以下是在 UPDATE 操作上在表的一个或多个指定列上创建触发器的语法：

```sql
CREATE  TRIGGER trigger_name [BEFORE|AFTER] UPDATE OF column_name
ON table_name
[
 -- 触发器逻辑....
];
```

##### 查询触发器

你可以把从 pg_trigger 表中把当前数据库所有触发器列举出来：

```sql
SELECT * FROM pg_trigger;
```

如果，你想列举出特定表的触发器，语法如下：

```sql
SELECT tgname FROM pg_trigger, pg_class WHERE tgrelid=pg_class.oid AND relname=TableName;
```

##### 删除触发器

删除触发器基础语法如下：

```sql
drop trigger ${trigger_name} on ${table_of_trigger_dependent};
```

#### 事务操作

TRANSACTION（事务）是数据库管理系统执行过程中的一个逻辑单位，由一个有限的数据库操作序列构成。数据库事务通常包含了一个序列的对数据库的读/写操作。包含有以下两个目的：

- 为数据库操作序列提供了一个从失败中恢复到正常状态的方法，同时提供了数据库即使在异常状态下仍能保持一致性的方法。
- 当多个应用程序在并发访问数据库时，可以在这些应用程序之间提供一个隔离方法，以防止彼此的操作互相干扰。

当事务被提交给了数据库管理系统（DBMS），则 DBMS 需要确保该事务中的所有操作都成功完成且其结果被永久保存在数据库中，如果事务中有的操作没有成功完成，则事务中的所有操作都需要回滚，回到事务执行前的状态；同时，该事务对数据库或者其他事务的执行无影响，所有的事务都好像在独立的运行。

##### 启动事务

事务可以使用 BEGIN TRANSACTION 命令或简单的 BEGIN 命令来启动。此类事务通常会持续执行下去，直到遇到下一个 COMMIT 或 ROLLBACK 命令。不过在数据库关闭或发生错误时，事务处理也会回滚。以下是启动一个事务的简单语法：

```sql
BEGIN;

或者

BEGIN TRANSACTION;
```

##### 确认事务

COMMIT 命令是用于把事务调用的更改保存到数据库中的事务命令，即确认事务。COMMIT 命令的语法如下：

```sql
COMMIT;

或者

END TRANSACTION;
```

##### 回滚事务

ROLLBACK 命令是用于撤消尚未保存到数据库的事务命令，即回滚事务。ROLLBACK 命令的语法如下：

```sql
ROLLBACK;
```

#### 锁操作

锁主要是为了保持数据库数据的一致性，可以阻止用户修改一行或整个表，一般用在并发较高的数据库中。在多个用户访问数据库的时候若对并发操作不加控制就可能会读取和存储不正确的数据，破坏数据库的一致性。数据库中有两种基本的锁：排它锁（Exclusive Locks）和共享锁（Share Locks）。如果数据对象加上排它锁，则其他的事务不能对它读取和修改。如果加上共享锁，则该数据库对象可以被其他事务读取，但不能修改。

LOCK 命令基础语法如下：

```sql
LOCK [ TABLE ]
name
 IN
lock_mode
```

- name：要锁定的现有表的名称（可选模式限定）。如果只在表名之前指定，则只锁定该表。如果未指定，则锁定该表及其所有子表（如果有）。
- lock_mode：锁定模式指定该锁与哪个锁冲突。如果没有指定锁定模式，则使用限制最大的访问独占模式。可能的值是：ACCESS SHARE，ROW SHARE， ROW EXCLUSIVE， SHARE UPDATE EXCLUSIVE， SHARE，SHARE ROW EXCLUSIVE，EXCLUSIVE，ACCESS EXCLUSIVE。

一旦获得了锁，锁将在当前事务的其余时间保持。没有解锁表命令；锁总是在事务结束时释放。

#### 索引操作

索引是加速搜索引擎检索数据的一种特殊表查询。简单地说，索引是一个指向表中数据的指针。一个数据库中的索引与一本书的索引目录是非常相似的。索引有助于加快 SELECT 查询和 WHERE 子句，但它会减慢使用 UPDATE 和 INSERT 语句时的数据输入。索引可以创建或删除，但不会影响数据。

##### 建立索引

使用 CREATE INDEX 语句创建索引，它允许命名索引，指定表及要索引的一列或多列，并指示索引是升序排列还是降序排列。索引也可以是唯一的，与 UNIQUE 约束类似，在列上或列组合上防止重复条目。

CREATE INDEX （创建索引）的语法如下：

```sql
CREATE INDEX index_name ON table_name;
```

**单列索引**

单列索引是一个只基于表的一个列上创建的索引，基本语法如下：

```sql
CREATE INDEX index_name
ON table_name (column_name);
```

**组合索引**

组合索引是基于表的多列上创建的索引，基本语法如下：

```sql
CREATE INDEX index_name
ON table_name (column1_name, column2_name);
```

不管是单列索引还是组合索引，该索引必须是在 WHERE 子句的过滤条件中使用非常频繁的列。如果只有一列被使用到，就选择单列索引，如果有多列就使用组合索引，且注意最左匹配原则。

**唯一索引**

使用唯一索引不仅是为了性能，同时也为了数据的完整性。唯一索引不允许任何重复的值插入到表中。基本语法如下：

```sql
CREATE UNIQUE INDEX index_name
on table_name (column_name);
```

**局部索引**

局部索引 是在表的子集上构建的索引；子集由一个条件表达式上定义。索引只包含满足条件的行。基础语法如下：

```sql
CREATE INDEX index_name
ON table_name(column_list)
WHERE condition;
```

在这里，index_name 是你想要创建的索引的名称，table_name 是包含你想要索引的列的表的名称，column_list 是你想要索引的列的列表，而 condition 是一个布尔表达式，用于定义哪些行将被包含在索引中。

**隐式索引**

在 PostgreSQL 中，隐式索引是在创建对象时，由数据库服务器自动创建的索引。这类索引通常为主键约束和唯一约束自动创建。当在创建表时声明一个列为主键、唯一约束或外键时，PostgreSQL 会自动为该列创建一个隐式索引。这样做的好处是简化了索引管理，并且提高了数据库的性能。例如，如果在创建一个名为 "users" 的表时，声明了一个名为 "userid" 的列为主键，PostgreSQL会自动为 "userid" 列创建一个隐式索引，这意味着在插入新记录时，数据库会自动为 "userid" 列生成一个唯一的索引值。隐式索引的创建和管理是由 PostgreSQL 自动完成的，用户不需要手动干预，这使得数据库管理变得更加简单和高效。

##### 查询索引

可以使用 **\di** 命令列出数据库中所有索引：

```
runoobdb=# \di
                    List of relations
 Schema |      Name       | Type  |  Owner   |   Table    
--------+-----------------+-------+----------+------------
 public | company_pkey    | index | postgres | company
 public | department_pkey | index | postgres | department
 public | salary_index    | index | postgres | company
(3 rows)
```

##### 删除索引

一个索引可以使用 PostgreSQL 的 DROP 命令删除。

```
DROP INDEX index_name;
```



#### 辅助操作

##### 别名

我们可以用 SQL 重命名一张表或者一个字段的名称，这个名称就叫着该表或该字段的别名。创建别名是为了让表名或列名的可读性更强。SQL 中 使用 **AS** 来创建别名。

表的别名语法:

```sql
SELECT column1, column2....
FROM table_name AS alias_name
WHERE [condition];
```

列的别名语法:

```sql
SELECT column_name AS alias_name
FROM table_name
WHERE [condition];
```

##### 临时表

在 PostgreSQL 中，WITH 子句提供了一种编写辅助语句的方法，以便在更大的查询中使用。WITH 子句有助于将复杂的大型查询分解为更简单的表单，便于阅读。这些语句通常称为通用表表达式（Common Table Express， CTE），也可以当做一个为查询而存在的临时表。WITH 子句是在多次执行子查询时特别有用，允许我们在查询中通过它的名称(可能是多次)引用它。WITH 子句在使用前必须先定义。WITH 查询的基础语法如下：

```sql
WITH
   name_for_summary_data AS (
      SELECT Statement)
   SELECT columns
   FROM name_for_summary_data
   WHERE conditions <=> (
      SELECT column
      FROM name_for_summary_data)
   [ORDER BY columns]
```

**name_for_summary_data** 是 WITH 子句的名称，**name_for_summary_data** 可以与现有的表名相同，并且具有优先级。可以在 WITH 中使用数据 INSERT, UPDATE 或 DELETE 语句，允许您在同一个查询中执行多个不同的操作。在 WITH 子句中可以使用自身输出的数据。公用表表达式 (CTE) 具有一个重要的优点，那就是能够引用其自身，从而创建递归 CTE。递归 CTE 是一个重复执行初始 CTE 以返回数据子集直到获取完整结果集的公用表表达式。

