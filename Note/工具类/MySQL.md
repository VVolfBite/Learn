# MySQL

## 工具介绍

MySQL 是最常见的关系型数据库管理系统之一。菜鸟教程在开篇里把它放在 RDBMS 的语境中介绍，这个定位很适合入门：它的核心不是“会写几条 SQL”，而是把数据放到表里，通过关系、索引、约束和事务来管理。citeturn0search0turn0search1

在后端项目里，MySQL 往往是主业务数据的落点。用户、订单、库存、支付、审批流转这类数据，通常最终都要落到它这里。缓存可以挡热点，消息队列可以做异步，但真正的业务主状态很多时候还是靠 MySQL 兜底。

所以写 MySQL 笔记时，必须同时回答三件事：表怎么设计，数据怎么查，为什么有些查询快有些查询慢。

## 核心机制

### 表、行、列与关系

菜鸟教程在最开始会先解释数据库、表、列、行、主键、外键、索引这些术语。这个顺序很朴素，但很有用，因为 MySQL 的很多后续问题都围绕这些最基本的元素展开。citeturn0search0

项目里常见的一张表大致长这样：

```sql
CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL,
  email VARCHAR(128),
  status TINYINT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
```

真正开始写项目时，先要熟悉的不是复杂 SQL，而是建库、建表、插入、查询、更新和删除。

### 索引与 B+ 树

MySQL 的高频问题几乎绕不开索引。对后端开发来说，可以先抓住这个核心理解：索引是在用额外空间换查询速度，而 InnoDB 里最常见的索引结构是 B+ 树。索引之所以适合数据库，不只是因为“查得快”，更因为它适合范围查询、排序和磁盘页读取。

最先要会的不是背定义，而是知道以下几件事：

- 主键索引很重要，主键最好稳定、短、顺序性较好。
- 常作为查询条件、排序条件、连接条件的列，适合考虑索引。
- 索引不是越多越好，写入、更新和存储都会付出代价。
- 有索引不代表一定走索引，查询写法同样关键。

一个最简单的索引例子：

```sql
CREATE INDEX idx_users_email ON users(email);
```

### 存储引擎

MySQL 不只是“一个数据库”，它下面还有存储引擎的概念。现在项目里最常见的是 InnoDB。它支持事务、行级锁、崩溃恢复，所以业务系统一般默认就是它。

如果只是做入门笔记，先记住这句就够：**业务表优先考虑 InnoDB**。后面再深入时，再去展开聚簇索引、MVCC、锁和 redo/undo。

### 事务与锁

MySQL 真正区别于“只会存数据”的工具，在于它能处理一组需要一起成功或一起失败的更新。

```sql
START TRANSACTION;
UPDATE account SET balance = balance - 100 WHERE id = 1;
UPDATE account SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

如果中间出错，就不该留下半完成状态。事务就是在干这件事。与此同时，事务一多就会碰到锁。最基本的理解是：锁在保护并发更新，但也会带来等待、阻塞和死锁。

## 基本使用

### 连接

命令行最基本的连接方式：

```bash
mysql -u root -p
mysql -h 127.0.0.1 -P 3306 -u app -p
```

服务管理方面，菜鸟教程给了在 Windows 和 Linux 上启动、停止 MySQL 服务的基本方式，比如 `systemctl start mysql` 或 `service mysql start`。这些命令不是面试细节，而是你真在机器上装数据库时会先碰到的东西。citeturn0search1

### 建库建表

```sql
CREATE DATABASE demo;
USE demo;

CREATE TABLE products (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0
);
```

### 增删改查

```sql
INSERT INTO products(name, price, stock)
VALUES ('keyboard', 199.00, 10);

SELECT id, name, price FROM products WHERE stock > 0;

UPDATE products SET stock = stock - 1 WHERE id = 1;

DELETE FROM products WHERE id = 1;
```

### 常见查询动作

```sql
SELECT * FROM orders WHERE user_id = 1001 ORDER BY created_at DESC LIMIT 20;

SELECT user_id, COUNT(*)
FROM orders
GROUP BY user_id;

SELECT o.id, u.username
FROM orders o
JOIN users u ON o.user_id = u.id;
```

如果你只是刚上项目，这几类 SQL 的熟练度比“复杂理论背了多少”更重要。

## 项目工程中的使用

### 业务主数据存储

用户表、订单表、库存表、支付记录表，这些有明确结构、事务要求和关系约束的数据，很适合放 MySQL。

### 后台管理与报表的基础查询

管理后台经常会有条件筛选、分页、排序、聚合统计，这些都离不开 MySQL。

### 和缓存、消息队列配合

项目里常见模式不是“只用 MySQL”，而是 **MySQL 保存权威状态，Redis 扛热点读，消息队列做异步扩散**。这时候你更要清楚：哪个是最终数据源，哪个只是加速层。

## 常见问题与注意点

第一，不要上来就迷信索引。索引是手段，不是护身符。查询条件、排序方式、返回字段同样重要。

第二，表结构设计很关键。字段类型、是否允许为空、主键设计、唯一约束，这些会直接影响后续开发质量。

第三，事务不要乱包。事务范围太大，会放大锁冲突和阻塞。

第四，线上不要随便全表更新、全表删除。先写 `SELECT` 验证条件，再执行修改。

第五，MySQL 不是只能“存表数据”，它更是项目里业务一致性的底座。
