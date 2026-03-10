# PostgreSQL

## 工具介绍

PostgreSQL 是开源的对象关系型数据库。菜鸟教程在开篇里会先把它放到 ORDBMS 的语境中介绍，再强调它在索引、函数、触发器、MVCC、JSON/JSONB 等方面的能力。对后端来说，这几个点很关键，因为它说明 PostgreSQL 不只是“另一个 MySQL”，而是在事务一致性、扩展能力和高级数据类型上很有特色。citeturn1search0turn1search4

如果项目里需要更丰富的 SQL 能力、较强的事务语义、对 JSON/JSONB 的良好支持，或者团队本身就偏 PostgreSQL 生态，那它会是非常自然的选择。

## 核心机制

### MVCC

菜鸟教程把 MVCC 明确列为 PostgreSQL 的核心特征之一。对开发者来说，先记住一句话就够：PostgreSQL 通过多版本并发控制，让读写并发时不必总靠粗暴加锁来解决冲突。这样事务里的读取更像是在看一个“快照”。citeturn1search0

### 索引与高级类型

PostgreSQL 不止支持常见的 B-Tree，还支持 GiST 等索引方法；同时它对 JSON、JSONB、数组、枚举、全文检索等支持都比较好。citeturn1search0

对项目来说，这意味着两件事：
- 如果数据模型比普通表结构更复杂，PostgreSQL 的表达能力会更舒服。
- 但能力强不代表可以乱用，表设计、索引设计和查询写法仍然决定性能。

### 事务与约束

PostgreSQL 一样支持事务、主键、外键、约束和视图。很多业务系统选它，就是因为它在“关系型数据的严谨管理”上很扎实。

## 基本使用

### 连接与进入命令行

菜鸟教程提到安装完成后可以通过 `psql` 进入命令行，也可以先切换到 `postgres` 用户再操作。citeturn1search1turn1search7

```bash
sudo -i -u postgres
psql
```

退出：

```bash
\q
```

查看帮助：

```bash
\help
\help SELECT
```

### 建库建表

```sql
CREATE DATABASE demo;
\c demo;

CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR(64) NOT NULL,
  profile JSONB,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
```

### 增删改查

```sql
INSERT INTO users(username, profile)
VALUES ('alice', '{"city":"shanghai"}');

SELECT id, username FROM users;

UPDATE users SET username = 'tom' WHERE id = 1;

DELETE FROM users WHERE id = 1;
```

### 连接查询与聚合

菜鸟教程在 PostgreSQL 的教程部分，会先带你过创建表、插入、查询、连接和聚合，这种顺序很适合写成项目笔记。因为刚接触 PostgreSQL 时，最先要会的依然是常规 SQL 操作，而不是先钻进高级特性。citeturn1search4turn1search6

## 项目工程中的使用

### 事务型业务系统

当系统对事务、一致性和复杂 SQL 支持要求较高时，PostgreSQL 很适合做主库。

### JSON/JSONB 场景

如果某些字段结构相对灵活，但你又不想完全放弃关系型数据库，PostgreSQL 的 JSON/JSONB 会很有吸引力。

### 数据分析和复杂查询

窗口函数、聚合、子查询、CTE 这些能力在 PostgreSQL 里经常被用得比较顺手。

## 常见问题与注意点

第一，不要把 PostgreSQL 只理解成“和 MySQL 语法差不多”。它们相似，但设计风格和生态习惯并不一样。

第二，先把 `psql` 的基本操作和普通 SQL 用熟，再去碰更高级的索引和扩展能力。

第三，JSON/JSONB 很方便，但不是说表结构设计从此就不重要了。

第四，如果是团队第一次上 PostgreSQL，要顺带把备份、权限、连接池和运维工具一起想清楚。菜鸟教程里也专门提到了 pgAdmin 这类图形管理工具。citeturn1search5
