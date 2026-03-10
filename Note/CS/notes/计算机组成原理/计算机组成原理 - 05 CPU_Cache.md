
# 计算机组成原理 - CPU Cache

<!-- GFM-TOC -->
* [计算机组成原理 - CPU Cache](#计算机组成原理---cpu-cache)
    * [CPU Cache 概述](#cpu-cache-概述)
        * [1. 什么是 CPU Cache](#1-什么是-cpu-cache)
        * [2. 为什么需要 Cache](#2-为什么需要-cache)
        * [3. Cache 的层次结构](#3-cache-的层次结构)
    * [Cache 的作用](#cache-的作用)
        * [1. 缓解 CPU 与内存的速度差距](#1-缓解-cpu-与内存的速度差距)
        * [2. 提高数据访问效率](#2-提高数据访问效率)
        * [3. 利用局部性原理](#3-利用局部性原理)
    * [Cache 与主存的关系](#cache-与主存的关系)
        * [1. Cache 是主存的缓存](#1-cache-是主存的缓存)
        * [2. Cache 的工作流程](#2-cache-的工作流程)
        * [3. Cache 映射方式](#3-cache-映射方式)
    * [Cache 命中与未命中](#cache-命中与未命中)
        * [1. Cache 命中](#1-cache-命中)
        * [2. Cache 未命中](#2-cache-未命中)
        * [3. Cache 替换策略](#3-cache-替换策略)
    * [Cache 一致性](#cache-一致性)
    * [高频判断](#高频判断)
    <!-- GFM-TOC -->

## CPU Cache

CPU Cache(高速缓存)是位于 CPU 内部的高速存储器,用于缓存主存中频繁访问的数据和指令。**Cache 的本质**是主存(RAM)的缓存，存储主存中最近使用的数据副本，利用局部性原理提高访问效率。

**核心特点:**位于 CPU 内部，使用 SRAM 实现，速度快但成本高，容量小(几 KB 到几 MB)，对程序员透明(硬件自动管理)

### 层次结构

**三级 Cache 结构:**

| 部件     | 访问时间    | 容量       | 作用           |
| -------- | ----------- | ---------- | -------------- |
| 寄存器   | 0.3-1 纳秒  | 几百字节   | 正在运算的数据 |
| L1 Cache | 1-2 纳秒    | 32-64 KB   | 最热的数据     |
| L2 Cache | 3-10 纳秒   | 256-512 KB | 较热的数据     |
| L3 Cache | 10-20 纳秒  | 8-32 MB    | 热点数据       |
| 内存     | 50-100 纳秒 | 几 GB      | 全部数据       |

```
CPU 核心
  ├─ 寄存器
  ├─ L1 Cache (L1 指令 Cache + L1 数据 Cache)
  │    ├─ 速度: 1-2 纳秒
  │    ├─ 容量: 32-64 KB
  │    └─ 每个核心独享
  │
  ├─ L2 Cache
  │    ├─ 速度: 3-10 纳秒
  │    ├─ 容量: 256-512 KB
  │    └─ 每个核心独享
  │
  └─ L3 Cache
       ├─ 速度: 10-20 纳秒
       ├─ 容量: 8-32 MB
       └─ 所有核心共享
            ↕
       主存(RAM)
```

多级 Cache 提供更好的性价比，其中：

**L1 Cache:**最快,最小，分为指令 Cache(I-Cache)和数据 Cache(D-Cache)，由每个 CPU 核心独享

**L2 Cache:**速度和容量介于 L1 和 L3 之间，由每个 CPU 核心独享

**L3 Cache:**最慢(但仍比内存快很多)，最大，所有 CPU 核心共享，减少核心间数据传输

### 作用

* **缓解 CPU 与内存的速度差距**

**没有 Cache 的情况:**

```
CPU 执行指令:
  1. 从内存读取指令 (100ns)
  2. 执行指令 (1ns)
  3. 从内存读取数据 (100ns)
  4. 运算 (1ns)
  5. 写回内存 (100ns)

总时间: 约 300ns,其中 CPU 实际运算只占 2ns
CPU 利用率: 2/300 = 0.67%
```

**有 Cache 的情况(假设命中率 95%):**

```
CPU 执行指令:
  1. 从 L1 Cache 读取指令 (2ns, 95% 命中)
  2. 执行指令 (1ns)
  3. 从 L1 Cache 读取数据 (2ns, 95% 命中)
  4. 运算 (1ns)
  5. 写回 Cache (2ns)

总时间: 约 8ns
CPU 利用率: 大幅提升
```

* **提高数据访问效率**

**示例:** 数组求和

```c
int sum = 0;
int arr[1000];
for (int i = 0; i < 1000; i++) {
    sum += arr[i];
}
```

**没有 Cache:** 每次访问 arr[i] 都需要访问内存(100ns)，因此总时间: 1000 × 100ns = 100,000ns = 0.1ms

**有 Cache:** 第一次访问 arr[0] 时,Cache 会加载一整个 Cache Line(通常 64 字节)，后续访问 arr[1], arr[2]... 都命中 Cache(2ns)，假设每个 int 4 字节,一个 Cache Line 包含 16 个 int，则总时间: (1000/16) × 100ns + 1000 × 2ns ≈ 8,250ns = 0.008ms，其加速约 12 倍

### 局部性原理原理

**时间局部性(Temporal Locality):**最近访问的数据,很可能在不久的将来再次被访问，Cache 保留最近访问的数据

**示例:**

```c
for (int i = 0; i < 1000; i++) {
    sum += arr[i];  // sum 被反复访问
}
```

**空间局部性(Spatial Locality):**如果访问了某个地址,很可能接下来会访问相邻地址，Cache 以 Cache Line 为单位加载数据(通常 64 字节)

**示例:**

```c
for (int i = 0; i < 1000; i++) {
    sum += arr[i];  // 顺序访问数组元素
}
```

### 工作流程

**读操作:**

```
1. CPU 发出读请求,地址为 A
2. 检查 L1 Cache 是否有地址 A 的数据
   ├─ 命中: 直接从 L1 Cache 读取,结束
   └─ 未命中: 继续
3. 检查 L2 Cache 是否有地址 A 的数据
   ├─ 命中: 从 L2 Cache 读取,同时加载到 L1 Cache
   └─ 未命中: 继续
4. 检查 L3 Cache 是否有地址 A 的数据
   ├─ 命中: 从 L3 Cache 读取,同时加载到 L2、L1 Cache
   └─ 未命中: 继续
5. 从主存读取地址 A 的数据
6. 将数据加载到 L3、L2、L1 Cache
7. 返回数据给 CPU
```

**写操作:**

* **写直达(Write-Through):**同时写入 Cache 和主存，这样Cache 和主存始终一致，但是每次写都要访问主存

* **写回(Write-Back):**只写入 Cache，标记为"脏"(Dirty)；当 Cache Line 被替换时，才写回主存；写操作快然而Cache 和主存可能不一致

#### 映射方式

* **直接映射(Direct Mapped):**主存的每个块只能映射到 Cache 的固定位置，简单,但容易冲突

* **全相联映射(Fully Associative):**主存的每个块可以映射到 Cache 的任意位置，灵活,但硬件复杂,查找慢

* **组相联映射(Set Associative):**折中方案,最常用，Cache 分成多个组,每个组有多个 Cache Line；主存块映射到固定的组,但可以放在组内任意位置，常见的是 8 路组相联(每组 8 个 Cache Line)

#### 命中与未命中

* **Cache 命中**：CPU 要访问的数据在 Cache 中找到。**命中率(Hit Rate)**=命中次数 / 总访问次数，一版在90%-99%。通常来说 Cache 容量越大，局部性越好，替换策略越好，命中率越高

* **Cache 未命中**：CPU 要访问的数据不在 Cache 中。**未命中的类型**有**强制性未命中(Compulsory Miss)**——第一次访问数据,Cache 中肯定没有，因此无法避免，**容量未命中(Capacity Miss)**——Cache 容量不足,无法存储所有需要的数据，说明需要增大Cache容量，**冲突未命中(Conflict Miss)**——多个数据映射到同一 Cache 位置,相互替换，说明需要分组并使用组相联映射。**未命中惩罚(Miss Penalty)**是额外的从主存加载数据到 Cache 的时间通常在 50-100 纳秒。

#### Cache 替换策略

**LRU(Least Recently Used):**替换最久未使用的 Cache Line，最常用，效果好，只需要维护访问时间信息

**FIFO(First In First Out):**替换最早加载的 Cache Line，简单，但效果不如 LRU

**随机替换(Random):**随机选择一个 Cache Line 替换，实现简单，效果难以评价

**LFU(Least Frequently Used):**替换访问次数最少的 Cache Line，需要维护访问计数

### 一致性

#### 多核 Cache 一致性问题

多核 CPU,每个核心有独立的 L1、L2 Cache，如果多个核心缓存了同一内存地址的数据，一个核心修改数据后,其他核心的 Cache 会过期。

**示例:**

```
初始: 内存地址 X = 10

核心 1:
  读取 X → L1 Cache: X = 10
  修改 X = 20 → L1 Cache: X = 20

核心 2:
  读取 X → L1 Cache: X = 10 (过期数据!)
```

使用**MESI 协议**解决，其中**MESI 状态:**

- **M(Modified)**: 已修改,与内存不一致,只有本 Cache 有
- **E(Exclusive)**: 独占,与内存一致,只有本 Cache 有
- **S(Shared)**: 共享,与内存一致,多个 Cache 可能都有
- **I(Invalid)**: 无效,数据过期

**工作流程:**

```
核心 1 修改 X:
  1. 核心 1 的 Cache: X 状态变为 M(Modified)
  2. 通过总线通知其他核心
  3. 核心 2 的 Cache: X 状态变为 I(Invalid)
  4. 核心 2 再次读取 X 时,发现 Invalid,从核心 1 或内存重新加载
```

#### 伪共享(False Sharing)

Cache Line 通常 64 字节，如果两个变量在同一 Cache Line，但被不同核心频繁修改，会导致 Cache Line 频繁失效,性能下降。

**示例:**

```c
struct {
    int a;  // 核心 1 频繁修改
    int b;  // 核心 2 频繁修改
} data;  // a 和 b 在同一 Cache Line
```

**解决方案**比较简单，一般填充(Padding)，让 a 和 b 在不同 Cache Line即可
```c
struct {
    int a;
    char padding[60];  // 填充到 64 字节
    int b;
} data;
```

## 高频判断

### 判断 1: Cache 是主存的缓存

**正确。** Cache 存储主存中频繁访问的数据副本,加速数据访问。

### 判断 2: Cache 容量比主存大

**错误。** Cache 容量很小(几 MB),主存容量大(几 GB 到几十 GB)。

### 判断 3: Cache 比主存快

**正确。** L1 Cache 访问时间约 1-2 纳秒,主存约 50-100 纳秒,Cache 快 50-100 倍。

### 判断 4: Cache 对程序员透明

**正确。** Cache 由硬件自动管理,程序员无需(也无法)直接操作 Cache。

### 判断 5: L1 Cache 比 L3 Cache 快

**正确。** L1 Cache 最快(1-2 纳秒),L3 Cache 相对慢(10-20 纳秒),但都比主存快。

### 判断 6: Cache 命中率越高,程序运行越快

**正确。** Cache 命中意味着快速访问,未命中需要访问主存,慢很多。

### 判断 7: Cache 使用 DRAM 实现

**错误。** Cache 使用 SRAM 实现,速度快但成本高。主存使用 DRAM。

### 判断 8: 所有 CPU 核心共享 L1 Cache

**错误。** L1 和 L2 Cache 每个核心独享,L3 Cache 所有核心共享。

### 判断 9: Cache Line 是 Cache 的基本单位

**正确。** Cache 以 Cache Line 为单位加载数据,通常 64 字节。

### 判断 10: 顺序访问数组比随机访问快

**正确。** 顺序访问利用空间局部性,Cache 命中率高;随机访问 Cache 命中率低。

### 判断 11: Cache 一致性问题只存在于多核 CPU

**正确。** 单核 CPU 只有一套 Cache,不存在一致性问题。

### 判断 12: 写回(Write-Back)比写直达(Write-Through)快

**正确。** 写回只写 Cache,写直达需要同时写 Cache 和主存。

### 判断 13: LRU 是最常用的 Cache 替换策略

**正确。** LRU(最近最久未使用)效果好,应用广泛。

### 判断 14: Cache 未命中会导致性能下降

**正确。** Cache 未命中需要访问主存,延迟大,性能下降。

### 判断 15: 增大 Cache 容量一定能提高性能

**基本正确。** 更大的 Cache 可以提高命中率,但收益递减,且成本增加。
