# 数据库原理 - Next-Key Lock 与幻读

## 目录

这篇内容层次较多，先看目录更容易定位复习重点。

- [幻读到底是什么](#幻读到底是什么)
- [为什么仅有行锁不够](#为什么仅有行锁不够)
- [为什么 RR 下还要讨论幻读](#为什么-rr-下还要讨论幻读)
- [MVCC 为什么不能完全解决幻读](#mvcc-为什么不能完全解决幻读)
- [Next-Key Lock 的三种锁](#next-key-lock-的三种锁)
- [Next-Key Lock 如何防止幻读](#next-key-lock-如何防止幻读)
- [Next-Key Lock 的加锁规则](#next-key-lock-的加锁规则)
- [RR 级别下的幻读解决方案](#rr-级别下的幻读解决方案)
- [Next-Key Lock 的局限](#next-key-lock-的局限)
- [幻读的易混点](#幻读的易混点)
- [追问](#追问)

## 幻读到底是什么

幻读是指在同一个事务中，多次执行相同的范围查询，结果集的行数不一致。

**核心特征**：
- 针对范围查询（不是单条数据）
- 行数变化（不是值变化）
- 由 INSERT 或 DELETE 引起

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191207222134306.png"/> </div><br>

**例子**：

```sql
-- 事务 A
START TRANSACTION;
SELECT * FROM t WHERE age > 18;  -- 查到 5 条

-- 事务 B
INSERT INTO t VALUES(6, 20);  -- 插入一条 age=20 的记录
COMMIT;

-- 事务 A
SELECT * FROM t WHERE age > 18;  -- 查到 6 条（幻读）
```

## 为什么仅有行锁不够

假设没有间隙锁，只有行锁：

```sql
-- 假设表中有 id = [5, 10, 15, 20]

-- 事务 A
START TRANSACTION;
SELECT * FROM t WHERE id > 10 AND id <= 20 FOR UPDATE;
-- 只能锁住 id=15 和 id=20 这两行

-- 事务 B
INSERT INTO t VALUES(12, ...);  -- 成功插入，因为 id=12 这一行不存在，没有被锁

-- 事务 A
SELECT * FROM t WHERE id > 10 AND id <= 20 FOR UPDATE;
-- 读到了 id=12 这一行（幻读）
```

**问题的本质**：行锁只能锁住已存在的行，无法阻止其他事务插入新行。

**间隙锁的作用**：锁住行与行之间的间隙，阻止其他事务在间隙中插入数据。

## 为什么 RR 下还要讨论幻读

SQL 标准中，RR 级别无法解决幻读，只有 Serializable 才能解决。

但 MySQL InnoDB 在 RR 级别下，通过 **Next-Key Lock** 解决了幻读问题。

**注意**：这里说的"解决幻读"有前提条件，后面会详细说明。

## MVCC 为什么不能完全解决幻读

MVCC 只对快照读有效，对当前读无效。

### 快照读不会出现幻读

```sql
-- 事务 A (RR 级别)
START TRANSACTION;
SELECT * FROM t WHERE age > 18;  -- 快照读，读到 5 条

-- 事务 B
INSERT INTO t VALUES(6, 20);
COMMIT;

-- 事务 A
SELECT * FROM t WHERE age > 18;  -- 快照读，还是 5 条（MVCC 保证）
```

因为 RR 级别下，事务开始时生成 ReadView，后续的快照读都用这个 ReadView，看不到事务 B 的插入。

### 当前读会出现幻读

```sql
-- 事务 A (RR 级别)
START TRANSACTION;
SELECT * FROM t WHERE age > 18 FOR UPDATE;  -- 当前读，读到 5 条，加锁

-- 事务 B
INSERT INTO t VALUES(6, 20);  -- 如果没有间隙锁，可以插入成功
COMMIT;

-- 事务 A
SELECT * FROM t WHERE age > 18 FOR UPDATE;  -- 当前读，读到 6 条（幻读）
```

当前读不使用 MVCC，读的是最新数据，所以会看到事务 B 的插入。

## Next-Key Lock 的三种锁

Next-Key Lock 是 MySQL InnoDB 的一种锁实现，用于解决幻读问题。

### Record Lock 记录锁

锁定索引上的一条记录。

**特点**：
- 锁定的是索引记录，不是数据行本身
- 如果表没有索引，InnoDB 会自动创建隐藏的聚簇索引

**例子**：

```sql
SELECT * FROM t WHERE id = 10 FOR UPDATE;
-- 锁定 id=10 这条索引记录
```

### Gap Lock 间隙锁

锁定索引记录之间的间隙，但不包括记录本身。

**作用**：防止其他事务在间隙中插入数据。

**例子**：

假设索引值为 [10, 11, 13, 20]

```sql
SELECT * FROM t WHERE id > 10 AND id < 20 FOR UPDATE;
-- 锁定间隙：(10, 11), (11, 13), (13, 20)
-- 其他事务不能在这些间隙中插入数据
```

**注意**：间隙锁只在 RR 级别及以上存在，RC 级别没有间隙锁。

### Next-Key Lock 临键锁

Record Lock + Gap Lock 的组合，锁定一个左开右闭的区间。

**例子**：

假设索引值为 [10, 11, 13, 20]，Next-Key Lock 会锁定以下区间：

```
(-∞, 10]
(10, 11]
(11, 13]
(13, 20]
(20, +∞)
```

**作用**：既锁定记录本身，又锁定记录前的间隙，防止幻读。

## Next-Key Lock 如何防止幻读

通过锁定范围查询涉及的所有间隙，阻止其他事务在这些间隙中插入数据。

**例子**：

```sql
-- 假设表中有 id = [5, 10, 15, 20]

-- 事务 A
START TRANSACTION;
SELECT * FROM t WHERE id > 10 AND id <= 20 FOR UPDATE;
-- 加 Next-Key Lock：(10, 15], (15, 20]
-- 加 Gap Lock：(20, +∞)

-- 事务 B
INSERT INTO t VALUES(12, ...);  -- 阻塞，因为 12 在 (10, 15] 区间内
INSERT INTO t VALUES(18, ...);  -- 阻塞，因为 18 在 (15, 20] 区间内
INSERT INTO t VALUES(25, ...);  -- 阻塞，因为 25 在 (20, +∞) 区间内
INSERT INTO t VALUES(8, ...);   -- 成功，因为 8 不在锁定区间内
```

## Next-Key Lock 的加锁规则

加锁规则比较复杂，这里只说核心原则：

### 原则 1：加锁的基本单位是 Next-Key Lock

默认是左开右闭区间。

### 原则 2：查询过程中访问到的对象才会加锁

如果使用了索引，只锁索引；如果没用索引，会锁全表。

### 原则 3：索引上的等值查询

- 如果记录存在，退化为 Record Lock
- 如果记录不存在，退化为 Gap Lock

**例子**：

```sql
-- 假设 id = [5, 10, 15]

-- 记录存在
SELECT * FROM t WHERE id = 10 FOR UPDATE;
-- 只加 Record Lock，锁 id=10

-- 记录不存在
SELECT * FROM t WHERE id = 12 FOR UPDATE;
-- 加 Gap Lock，锁 (10, 15)
```

### 原则 4：范围查询会锁定整个范围

包括范围内的所有记录和间隙。

## RR 级别下的幻读解决方案

### 快照读

使用 MVCC，读取事务开始时的快照，天然不会出现幻读。

```sql
SELECT * FROM t WHERE age > 18;  -- 快照读，MVCC 保证
```

### 当前读

使用 Next-Key Lock，锁定范围内的所有记录和间隙，阻止插入。

```sql
SELECT * FROM t WHERE age > 18 FOR UPDATE;  -- 当前读，Next-Key Lock 保证
```

## Next-Key Lock 的局限

### 只对当前读有效

如果不加 `FOR UPDATE` 或 `LOCK IN SHARE MODE`，就是快照读，不会加 Next-Key Lock。

### 可能导致死锁

间隙锁之间可能互相等待，导致死锁。

**例子**：

```sql
-- 事务 A
SELECT * FROM t WHERE id > 10 FOR UPDATE;  -- 锁 (10, +∞)

-- 事务 B
SELECT * FROM t WHERE id < 20 FOR UPDATE;  -- 锁 (-∞, 20)

-- 事务 A
INSERT INTO t VALUES(15, ...);  -- 等待事务 B 释放 (10, 20) 的锁

-- 事务 B
INSERT INTO t VALUES(15, ...);  -- 等待事务 A 释放 (10, 20) 的锁

-- 死锁！
```

### 降低并发性能

锁定的范围越大，其他事务被阻塞的概率越高。

## 幻读的易混点

### 幻读 vs 不可重复读

| 维度 | 不可重复读 | 幻读 |
|------|-----------|------|
| 关注点 | 同一条数据的值 | 数据的行数 |
| 原因 | UPDATE | INSERT/DELETE |
| 解决方案 | MVCC（RR 级别） | Next-Key Lock |

### 快照读的幻读 vs 当前读的幻读

| 维度 | 快照读 | 当前读 |
|------|--------|--------|
| 是否会出现幻读 | 不会（MVCC 保证） | 会（需要 Next-Key Lock） |
| 解决方案 | MVCC | Next-Key Lock |

## 追问

**Q: 幻读是什么？**
同一事务中，多次执行相同的范围查询，结果集的行数不一致。

**Q: 幻读和不可重复读的区别？**
不可重复读是同一条数据的值变了（UPDATE），幻读是数据行数变了（INSERT/DELETE）。

**Q: MVCC 能解决幻读吗？**
只能解决快照读的幻读，不能解决当前读的幻读。

**Q: Next-Key Lock 是什么？**
Record Lock + Gap Lock 的组合，锁定一个左开右闭的区间，防止其他事务在区间内插入数据。

**Q: 间隙锁的作用是什么？**
锁定索引记录之间的间隙，防止其他事务在间隙中插入数据，从而防止幻读。

**Q: RR 级别下一定不会出现幻读吗？**
不一定。快照读不会出现幻读，但如果混用快照读和当前读，仍可能出现幻读。

**Q: 为什么 RC 级别没有间隙锁？**
因为 RC 级别本身就允许不可重复读和幻读，不需要间隙锁。间隙锁会降低并发性能。

**Q: Next-Key Lock 会导致什么问题？**
可能导致死锁，降低并发性能。

**Q: 如何避免幻读？**
使用 RR 级别 + 当前读（FOR UPDATE 或 LOCK IN SHARE MODE）。

**Q: 什么时候会加 Next-Key Lock？**
RR 级别下，执行当前读的范围查询时。

**Q: 等值查询会加间隙锁吗？**
如果记录不存在，会加间隙锁；如果记录存在，只加记录锁。

**Q: 为什么 MySQL 在 RR 级别下能解决幻读，而 SQL 标准说 RR 不能解决？**
因为 MySQL InnoDB 通过 Next-Key Lock 增强了 RR 级别的能力，这是 MySQL 的特有实现。
