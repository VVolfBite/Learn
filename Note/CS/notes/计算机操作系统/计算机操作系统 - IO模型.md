
# 计算机操作系统 - I/O模型

I/O 操作通常包括两个阶段：等待数据准备好（Waiting for data），将数据从内核复制到用户空间（Copying data）。不同的 I/O 模型在这两个阶段的处理方式不同。

## 阻塞与非阻塞

阻塞（Blocking）和非阻塞（Non-blocking）描述的是调用者的状态。

阻塞方式下，调用者发起请求后一直等待结果返回，在等待期间被挂起，不能做其他事情，直到操作完成才返回。

非阻塞方式下，调用者发起请求后立即返回，不管操作是否完成，都会立即返回一个状态，调用者可以继续做其他事情。

```c
// 阻塞方式读取数据
int n = read(fd, buf, size);  // 如果没有数据，会一直等待

// 非阻塞方式读取数据
fcntl(fd, F_SETFL, O_NONBLOCK);  // 设置为非阻塞
int n = read(fd, buf, size);     // 如果没有数据，立即返回 -1
```

## 同步与异步

同步（Synchronous）和异步（Asynchronous）描述的是消息通知机制。

同步方式下，调用者主动等待或轮询结果，调用者需要自己去获取结果，在结果返回之前调用流程不会继续。

异步方式下，被调用者通过回调、事件等方式通知调用者，调用者不需要主动等待，可以继续执行，结果准备好后会被通知。

```c
// 同步方式
int n = read(fd, buf, size);  // 主动等待读取完成

// 异步方式
aio_read(&aiocb);             // 发起异步读取
// ... 继续做其他事情 ...
// 读取完成后，通过信号或回调通知
```

阻塞/非阻塞和同步/异步是两个不同维度的概念：

| 组合 | 说明 | 示例 |
|------|------|------|
| 同步阻塞 | 调用者等待，主动获取结果 | 传统的 read() |
| 同步非阻塞 | 调用者轮询，主动获取结果 | 非阻塞 read() + 轮询 |
| 异步阻塞 | 调用者等待通知 | 很少见 |
| 异步非阻塞 | 调用者继续执行，被动接收通知 | Linux AIO |

## 五种 I/O 模型

### 1. 阻塞 I/O

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/1492928416812_4.png"/> </div><br>

应用进程调用 recvfrom 后被阻塞，直到数据准备好并复制到用户空间。整个过程都在等待。

过程：
```
1. 应用进程调用 recvfrom
   ↓
2. 内核开始准备数据（等待网络数据到达）
   应用进程阻塞等待
   ↓
3. 数据准备好，内核将数据复制到用户空间
   应用进程继续阻塞
   ↓
4. 复制完成，返回成功
   应用进程恢复运行
```

优点：编程简单，逻辑清晰。

缺点：一个线程只能处理一个连接，需要大量线程处理多个连接，线程切换开销大。

适合连接数较少、对实时性要求不高的场景。

### 2. 非阻塞 I/O

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/1492929000361_5.png"/> </div><br>

应用进程调用 recvfrom 立即返回。如果数据未准备好，返回错误，需要不断轮询检查数据是否准备好。

过程：
```
1. 应用进程调用 recvfrom（非阻塞）
   ↓
2. 数据未准备好，立即返回 EWOULDBLOCK
   ↓
3. 应用进程继续轮询调用 recvfrom
   ↓
4. 数据准备好，内核将数据复制到用户空间
   应用进程在复制期间阻塞
   ↓
5. 复制完成，返回成功
```

优点：不会一直阻塞，可以在等待期间做其他事情。

缺点：需要不断轮询，消耗 CPU，数据复制阶段仍然阻塞。

通常配合 I/O 多路复用使用，很少单独使用。

### 3. I/O 多路复用

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/1492929444818_6.png"/> </div><br>

使用 select、poll、epoll 等机制，可以同时监听多个文件描述符。当某个文件描述符就绪时，通知应用进程。

过程：
```
1. 应用进程调用 select/epoll_wait
   监听多个文件描述符
   ↓
2. 阻塞等待，直到有文件描述符就绪
   ↓
3. select/epoll_wait 返回就绪的文件描述符
   ↓
4. 应用进程调用 recvfrom 读取数据
   在数据复制期间阻塞
   ↓
5. 复制完成，返回成功
```

优点：一个线程可以处理多个连接，不需要为每个连接创建线程，适合高并发场景。

缺点：编程复杂度较高，数据复制阶段仍然阻塞。

典型应用：Nginx（使用 epoll）、Redis（使用 epoll）、Node.js（使用 libuv，底层是 epoll/kqueue）。

### 4. 信号驱动 I/O

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/1492929553651_7.png"/> </div><br>

应用进程注册信号处理函数，数据准备好时，内核发送信号通知。应用进程在信号处理函数中读取数据。

过程：
```
1. 应用进程注册 SIGIO 信号处理函数
   ↓
2. 立即返回，应用进程继续执行
   ↓
3. 数据准备好，内核发送 SIGIO 信号
   ↓
4. 信号处理函数被调用
   应用进程调用 recvfrom 读取数据
   在数据复制期间阻塞
   ↓
5. 复制完成，返回成功
```

优点：不需要轮询，数据准备阶段不阻塞。

缺点：信号处理机制复杂，数据复制阶段仍然阻塞，实际应用较少。

### 5. 异步 I/O

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/1492930243286_8.png"/> </div><br>

应用进程发起 I/O 请求后立即返回，内核完成数据准备和复制后通知应用进程。整个过程应用进程都不阻塞。

过程：
```
1. 应用进程调用 aio_read
   ↓
2. 立即返回，应用进程继续执行
   ↓
3. 内核准备数据
   ↓
4. 内核将数据复制到用户空间
   ↓
5. 复制完成，内核通知应用进程（信号或回调）
```

优点：真正的异步，整个过程不阻塞，性能最好。

缺点：编程复杂，操作系统支持有限（Linux 的 AIO 支持不完善）。

典型应用：高性能数据库、高性能文件服务器、Windows IOCP、Linux io_uring（新的异步 I/O 接口）。

### 五种模型对比

| I/O 模型 | 数据准备阶段 | 数据复制阶段 | 是否阻塞 | 是否同步 |
|----------|-------------|-------------|---------|---------|
| 阻塞 I/O | 阻塞 | 阻塞 | 是 | 是 |
| 非阻塞 I/O | 非阻塞（轮询） | 阻塞 | 部分阻塞 | 是 |
| I/O 多路复用 | 阻塞（等待就绪） | 阻塞 | 是 | 是 |
| 信号驱动 I/O | 非阻塞 | 阻塞 | 部分阻塞 | 是 |
| 异步 I/O | 非阻塞 | 非阻塞 | 否 | 否 |

同步 vs 异步的关键区别：前四种都是同步 I/O，因为数据复制阶段会阻塞。只有异步 I/O 是真正的异步，整个过程都不阻塞。

## I/O 多路复用详解

### select

函数原型：
```c
int select(int nfds, fd_set *readfds, fd_set *writefds,
           fd_set *exceptfds, struct timeval *timeout);
```

工作原理：
1. 将需要监听的文件描述符集合从用户空间复制到内核空间
2. 内核遍历所有文件描述符，检查是否就绪
3. 将结果复制回用户空间
4. 用户程序遍历文件描述符集合，找出就绪的描述符

优点：跨平台，几乎所有系统都支持，可以同时监听多个文件描述符。

缺点：
- 单个进程能监听的文件描述符数量有限（通常是 1024）
- 每次调用都需要复制文件描述符集合
- 需要遍历所有文件描述符，时间复杂度 O(n)
- 不能精确知道哪个文件描述符就绪，需要遍历

示例：
```c
fd_set readfds;
FD_ZERO(&readfds);
FD_SET(sockfd, &readfds);

int ret = select(sockfd + 1, &readfds, NULL, NULL, NULL);
if (ret > 0) {
    if (FD_ISSET(sockfd, &readfds)) {
        // sockfd 可读
        read(sockfd, buf, size);
    }
}
```

### poll

函数原型：
```c
int poll(struct pollfd *fds, nfds_t nfds, int timeout);

struct pollfd {
    int   fd;         // 文件描述符
    short events;     // 监听的事件
    short revents;    // 实际发生的事件
};
```

工作原理：
1. 将 pollfd 数组从用户空间复制到内核空间
2. 内核遍历所有文件描述符，检查是否就绪
3. 将结果写入 revents 字段
4. 将 pollfd 数组复制回用户空间
5. 用户程序遍历数组，检查 revents 字段

优点：没有文件描述符数量限制，使用链表存储，可以监听任意数量的文件描述符。

缺点：
- 每次调用都需要复制 pollfd 数组
- 需要遍历所有文件描述符，时间复杂度 O(n)
- 不能精确知道哪个文件描述符就绪，需要遍历

示例：
```c
struct pollfd fds[2];
fds[0].fd = sockfd1;
fds[0].events = POLLIN;
fds[1].fd = sockfd2;
fds[1].events = POLLIN;

int ret = poll(fds, 2, -1);
if (ret > 0) {
    if (fds[0].revents & POLLIN) {
        // sockfd1 可读
        read(sockfd1, buf, size);
    }
    if (fds[1].revents & POLLIN) {
        // sockfd2 可读
        read(sockfd2, buf, size);
    }
}
```

### epoll

函数原型：
```c
int epoll_create(int size);
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout);
```

工作原理：
1. epoll_create：创建 epoll 实例
2. epoll_ctl：向 epoll 实例添加/删除/修改文件描述符
3. epoll_wait：等待事件发生，只返回就绪的文件描述符

核心机制：
- 使用红黑树存储所有监听的文件描述符
- 使用就绪链表存储就绪的文件描述符
- 当文件描述符就绪时，通过回调函数将其加入就绪链表

优点：
- 没有文件描述符数量限制
- 不需要每次都复制所有文件描述符
- 只返回就绪的文件描述符，时间复杂度 O(1)
- 支持边缘触发（ET）和水平触发（LT）

缺点：只支持 Linux，编程复杂度较高。

示例：
```c
// 创建 epoll 实例
int epfd = epoll_create(1);

// 添加文件描述符
struct epoll_event ev;
ev.events = EPOLLIN;
ev.data.fd = sockfd;
epoll_ctl(epfd, EPOLL_CTL_ADD, sockfd, &ev);

// 等待事件
struct epoll_event events[MAX_EVENTS];
int nfds = epoll_wait(epfd, events, MAX_EVENTS, -1);

for (int i = 0; i < nfds; i++) {
    if (events[i].events & EPOLLIN) {
        // events[i].data.fd 可读
        read(events[i].data.fd, buf, size);
    }
}
```

边缘触发 vs 水平触发：

水平触发（LT）是默认模式，只要文件描述符就绪就会一直通知，如果不处理，下次 epoll_wait 还会返回。可以分多次读取，编程简单。

边缘触发（ET）只在状态变化时通知一次，必须一次性读取所有数据，否则不会再通知。性能更高，但编程更复杂。

示例：
```
假设缓冲区有 100 字节数据：

LT 模式：
- 第一次 epoll_wait 返回
- 读取 50 字节
- 第二次 epoll_wait 仍然返回（还有 50 字节）

ET 模式：
- 第一次 epoll_wait 返回
- 必须读取全部 100 字节
- 否则不会再通知
```

### 三者对比

这里真正要说明的是“三者对比”为什么值得单独拿出来讲。把它放到“计算机操作系统 - IO模型”这张卡片的上下文里看，后面的要点和区别会更容易读顺。

| 特性 | select | poll | epoll |
|------|--------|------|-------|
| 文件描述符数量限制 | 有（1024） | 无 | 无 |
| 数据结构 | 位图 | 数组 | 红黑树 + 链表 |
| 时间复杂度 | O(n) | O(n) | O(1) |
| 是否需要遍历 | 是 | 是 | 否 |
| 是否需要复制 | 是 | 是 | 否（只在添加时） |
| 跨平台 | 是 | 是 | 否（仅 Linux） |
| 性能 | 低 | 中 | 高 |

性能对比：
- 连接数少（< 1000）：三者差异不大
- 连接数多（> 10000）：epoll 性能明显优于 select 和 poll
- 活跃连接比例高：epoll 优势更明显

为什么 epoll 比 select 快？

1. 不需要遍历：select 需要遍历所有文件描述符，epoll 只返回就绪的文件描述符
2. 不需要复制：select 每次都要复制文件描述符集合，epoll 只在添加时复制一次
3. 数据结构：select 使用位图有数量限制，epoll 使用红黑树无数量限制
4. 回调机制：epoll 使用回调，文件描述符就绪时自动加入链表，select 需要轮询检查

## 应用场景

阻塞 I/O 适合连接数较少、每个连接都很活跃、对实时性要求不高的场景，如简单的客户端程序、低并发服务器。

非阻塞 I/O 很少单独使用，通常作为 I/O 多路复用的基础。

I/O 多路复用适合高并发服务器、需要同时处理大量连接、连接活跃度不高的场景，如 Nginx、Redis、Node.js。

异步 I/O 适合高性能文件 I/O、数据库系统，如 Windows IOCP、Linux AIO、io_uring。

## 常见问题

**阻塞 vs 非阻塞**  
阻塞是调用者等待结果，非阻塞是调用者立即返回。这两个概念描述的是调用者的状态。

**同步 vs 异步**  
同步是主动等待或轮询结果，异步是被动接收通知。这两个概念描述的是消息通知机制。

**I/O 多路复用是同步还是异步**  
同步。虽然可以同时监听多个文件描述符，但在数据复制阶段仍然会阻塞，需要主动调用 read/write 获取数据。容易混淆的点：I/O 多路复用可以实现"异步"的效果，但本质上仍然是同步 I/O。

**select、poll、epoll 的选择**  
跨平台用 select 或 poll，Linux 高性能用 epoll，连接数少三者都可以。

**什么时候用阻塞 I/O，什么时候用非阻塞 I/O**  
阻塞 I/O：连接数少，每个连接都很活跃，编程简单。非阻塞 I/O + I/O 多路复用：连接数多，大部分连接不活跃，高并发场景。异步 I/O：极高性能要求，文件 I/O 密集，操作系统支持。

**为什么 Nginx 性能高**  
使用 epoll 实现 I/O 多路复用，事件驱动架构，非阻塞 I/O，一个进程可以处理大量连接。
