
# 数据库原理 - MVCC

## 目录

这篇内容层次较多，先看目录更容易定位复习重点。

- [MVCC 是什么](#mvcc-是什么)
- [为什么需要 MVCC](#为什么需要-mvcc)
- [MVCC 适用的隔离级别](#mvcc-适用的隔离级别)
- [MVCC 的实现机制](#mvcc-的实现机制)
- [RC 和 RR 的 MVCC 区别](#rc-和-rr-的-mvcc-区别)
- [快照读与当前读](#快照读与当前读)
- [MVCC 和锁的关系](#mvcc-和锁的关系)
- [MVCC 能解决什么问题](#mvcc-能解决什么问题)
- [MVCC 的优缺点](#mvcc-的优缺点)
- [追问](#追问)

## MVCC 是什么

MVCC（Multi-Version Concurrency Control，多版本并发控制）是一种并发控制机制，通过保存数据的多个版本，让读写操作不互相阻塞。

**核心思想**：写操作创建新版本，读操作读旧版本，读写不冲突。

## 为什么需要 MVCC

### 传统锁的问题

使用锁来控制并发时：
- 读操作需要加 S 锁
- 写操作需要加 X 锁
- 读写互斥，并发性能差

### MVCC 的优势

这一节主要把“MVCC 的优势”放回“数据库原理 - MVCC”这条主线里看。先抓住它在整个数据库原理知识体系中的位置，再去看后面的分类和结论，会更容易把零散的判断串起来。

- 读操作不加锁，直接读快照
- 写操作创建新版本
- 读写不互斥，并发性能高

**类比**：就像 CopyOnWrite，写时复制一份新的，读操作继续读旧的。

## MVCC 适用的隔离级别

MVCC 用于实现 **Read Committed** 和 **Repeatable Read** 两种隔离级别。

- **Read Uncommitted**：总是读最新数据，不需要 MVCC
- **Serializable**：需要加锁，单纯的 MVCC 无法实现

## MVCC 的实现机制

### 版本号

每个事务和每行数据都有版本号：

- **系统版本号 SYS_ID**：全局递增，每开启一个新事务就自增
- **事务版本号 TRX_ID**：事务开始时的系统版本号

### 隐藏字段

InnoDB 为每行数据添加了三个隐藏字段：

- **DB_TRX_ID**：最后修改该行的事务 ID
- **DB_ROLL_PTR**：回滚指针，指向 undo log 中的上一个版本
- **DB_ROW_ID**：行 ID（如果没有主键，InnoDB 会自动生成）

### Undo Log 版本链

每次修改数据时，旧版本会被保存到 undo log 中，通过回滚指针形成版本链。

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208164808217.png"/> </div><br>

**例子**：

```sql
INSERT INTO t(id, x) VALUES(1, "a");  -- TRX_ID = 1
UPDATE t SET x="b" WHERE id=1;        -- TRX_ID = 2
UPDATE t SET x="c" WHERE id=1;        -- TRX_ID = 3
```

版本链：
```
当前版本: x="c", TRX_ID=3, ROLL_PTR → 
旧版本1: x="b", TRX_ID=2, ROLL_PTR → 
旧版本2: x="a", TRX_ID=1, ROLL_PTR → NULL
```

### ReadView

ReadView 是事务读取数据时的"视图"，决定了能看到哪些版本的数据。

**ReadView 包含的信息**：

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208171445674.png"/> </div><br>

- **TRX_IDs**：当前系统中所有活跃（未提交）的事务 ID 列表
- **TRX_ID_MIN**：TRX_IDs 中的最小值
- **TRX_ID_MAX**：系统下一个要分配的事务 ID（即当前最大事务 ID + 1）

### 可见性判断规则

读取数据时，根据数据行的 TRX_ID 和 ReadView 判断该版本是否可见：

**规则 1**：`TRX_ID < TRX_ID_MIN`
- 说明该版本在所有活跃事务之前就提交了
- **可见** 正确

**规则 2**：`TRX_ID >= TRX_ID_MAX`
- 说明该版本在当前事务开始之后才创建
- **不可见** 错误

**规则 3**：`TRX_ID_MIN <= TRX_ID < TRX_ID_MAX`
- 需要进一步判断：
  - 如果 `TRX_ID` 在 `TRX_IDs` 列表中（未提交）→ **不可见** 错误
  - 如果 `TRX_ID` 不在 `TRX_IDs` 列表中（已提交）→ 根据隔离级别判断
    - **RC**：可见 正确
    - **RR**：不可见 错误（因为是在当前事务开始后提交的）

**规则 4**：如果当前版本不可见，沿着 ROLL_PTR 找上一个版本，重复上述判断。

## RC 和 RR 的 MVCC 区别

| 维度 | Read Committed | Repeatable Read |
|------|---------------|-----------------|
| ReadView 生成时机 | 每次 SELECT 时生成 | 事务第一次 SELECT 时生成 |
| 能否读到其他事务的提交 | 能 | 不能 |
| 实现效果 | 每次读都是最新的已提交数据 | 每次读都是事务开始时的快照 |

**例子**：

```sql
-- 初始数据：x = "a", TRX_ID = 1

-- 事务 A (TRX_ID = 10)
START TRANSACTION;
SELECT x FROM t WHERE id = 1;  -- 读到 "a"

-- 事务 B (TRX_ID = 11)
START TRANSACTION;
UPDATE t SET x = "b" WHERE id = 1;
COMMIT;  -- 提交

-- 事务 A
SELECT x FROM t WHERE id = 1;  
-- RC 级别：读到 "b"（因为重新生成 ReadView，11 已提交）
-- RR 级别：读到 "a"（因为用的是事务开始时的 ReadView，11 > 10）
```

## 快照读与当前读

### 快照读

读取的是数据的快照版本，不加锁。

```sql
SELECT * FROM t WHERE id = 1;
```

**特点**：
- 使用 MVCC 机制
- 不加锁，并发性能高
- 读到的可能不是最新数据

### 当前读

读取的是数据的最新版本，需要加锁。

```sql
-- 加 S 锁
SELECT * FROM t WHERE id = 1 LOCK IN SHARE MODE;

-- 加 X 锁
SELECT * FROM t WHERE id = 1 FOR UPDATE;

-- 所有写操作都是当前读
INSERT INTO t VALUES(...);
UPDATE t SET x = "b" WHERE id = 1;
DELETE FROM t WHERE id = 1;
```

**特点**：
- 不使用 MVCC，直接读最新数据
- 需要加锁，可能阻塞
- 读到的一定是最新数据

## MVCC 和锁的关系

**MVCC 和锁不是对立关系，而是配合使用。这是理解 MySQL 并发控制的关键。**

### MVCC 的作用范围

MVCC 只用于**快照读**（普通的 SELECT），让读操作不需要加锁，提高并发性能。

```sql
-- 快照读，使用 MVCC，不加锁
SELECT * FROM t WHERE id = 1;
```

### 锁的作用范围

锁用于**当前读**和**写操作**，保证数据一致性。

```sql
-- 当前读，需要加锁
SELECT * FROM t WHERE id = 1 FOR UPDATE;  -- 加 X 锁
SELECT * FROM t WHERE id = 1 LOCK IN SHARE MODE;  -- 加 S 锁

-- 写操作，需要加锁
UPDATE t SET x = "b" WHERE id = 1;  -- 加 X 锁
DELETE FROM t WHERE id = 1;  -- 加 X 锁
INSERT INTO t VALUES(...);  -- 加 X 锁
```

### 为什么需要两种机制

**只用锁的问题**：读写互斥，并发性能差。如果所有 SELECT 都加 S 锁，那么读操作会阻塞写操作，写操作也会阻塞读操作。

**只用 MVCC 的问题**：无法保证写操作的一致性。如果写操作也用 MVCC，两个事务可能同时修改同一行，导致丢失更新。

**MVCC + 锁的方案**：
- 读操作用 MVCC，不加锁，读写不互斥
- 写操作用锁，保证写写互斥
- 当前读用锁，保证读到最新数据

### 实际例子

```sql
-- 事务 A
START TRANSACTION;
SELECT * FROM t WHERE id = 1;  -- 快照读，使用 MVCC，不加锁
-- 此时事务 B 可以同时执行 UPDATE，不会被阻塞

UPDATE t SET x = "b" WHERE id = 1;  -- 当前读 + 写操作，加 X 锁
-- 此时事务 B 的 UPDATE 会被阻塞，等待 X 锁释放
COMMIT;
```

### 关键理解

**MVCC 解决的是"读-写"冲突**：让读操作不阻塞写操作，写操作也不阻塞读操作。

**锁解决的是"写-写"冲突**：让多个写操作串行执行，避免丢失更新。

**两者配合**：
- 普通 SELECT 用 MVCC，高并发
- 写操作和当前读用锁，保证一致性
- 这就是 MySQL InnoDB 的并发控制机制

## MVCC 能解决什么问题

### 能解决

- **脏读** 正确：只读已提交的版本
- **不可重复读** 正确（RR 级别）：读的是快照，不受其他事务提交影响

### 不能解决

这里真正要说明的是“不能解决”为什么值得单独拿出来讲。把它放回“数据库原理 - MVCC”这张卡片的上下文里看，后面的分点会更容易读顺。

这里真正要说明的是“不能解决”为什么值得单独拿出来讲。把它放到“数据库原理 - MVCC”这张卡片的上下文里看，后面的要点和区别会更容易读顺。

- **幻读** 错误：MVCC 只能保证读到的数据一致，但无法阻止其他事务插入新数据
- **丢失更新** 错误：需要通过锁来解决

**幻读例子**：

```sql
-- 事务 A (RR 级别)
START TRANSACTION;
SELECT * FROM t WHERE age > 18;  -- 快照读，读到 5 条

-- 事务 B
INSERT INTO t VALUES(6, 20);  -- 插入新数据
COMMIT;

-- 事务 A
SELECT * FROM t WHERE age > 18;  -- 快照读，还是 5 条（MVCC 保证）
UPDATE t SET name = "xxx" WHERE age > 18;  -- 当前读，更新了 6 条！
SELECT * FROM t WHERE age > 18;  -- 当前读，读到 6 条（幻读）
```

**关键点**：
- 快照读使用 MVCC，读到的是快照，不会出现幻读
- 当前读不使用 MVCC，读到的是最新数据，可能出现幻读
- MySQL 通过 Next-Key Lock 解决当前读的幻读问题

## MVCC 的优缺点

### 优点

- 读操作不加锁，并发性能高
- 读写不互相阻塞
- 实现了非阻塞的一致性读

### 缺点

- 需要额外的存储空间（undo log）
- 需要定期清理旧版本（purge 线程）
- 无法完全解决幻读（需要配合 Next-Key Lock）

## 追问

**Q: MVCC 的核心思想是什么？**
通过保存数据的多个版本，让读操作读旧版本、写操作创建新版本，实现读写不互相阻塞。

**Q: MVCC 如何实现的？**
通过 undo log 保存旧版本，通过 ReadView 判断版本可见性，通过隐藏字段（TRX_ID、ROLL_PTR）串联版本链。

**Q: ReadView 什么时候生成？**
RC 级别每次 SELECT 时生成，RR 级别事务第一次 SELECT 时生成。

**Q: 快照读和当前读的区别？**
快照读使用 MVCC 读快照不加锁，当前读读最新数据需要加锁。

**Q: MVCC 能解决幻读吗？**
不能完全解决。快照读不会出现幻读，但当前读可能出现幻读，需要配合 Next-Key Lock。

**Q: MVCC 和锁是什么关系？**
不是对立关系，而是配合使用。MVCC 用于快照读，锁用于当前读和写操作。

**Q: 为什么 MVCC 能提高并发性能？**
因为读操作不需要加锁，读写不互相阻塞，多个事务可以同时读取不同版本的数据。

**Q: undo log 会一直保存吗？**
不会。MySQL 有 purge 线程定期清理不再需要的旧版本。

**Q: MVCC 在哪些隔离级别下使用？**
RC 和 RR。RU 不需要 MVCC，Serializable 需要加锁。

**Q: 为什么 RR 能解决不可重复读？**
因为 RR 级别下，事务开始时生成 ReadView，整个事务期间都用这个 ReadView，读到的都是事务开始时的快照，不受其他事务提交影响。

**Q: 为什么 RR 下事务开始时生成 ReadView，而不是事务提交时？**
如果事务提交时才生成，那事务执行期间就看不到任何数据了。事务开始时生成 ReadView，可以看到事务开始前已提交的数据，同时保证事务内多次读取一致。

**Q: MVCC 的版本链会无限增长吗？**
不会。MySQL 有 purge 线程定期清理不再需要的旧版本（所有活跃事务都不需要的版本）。
