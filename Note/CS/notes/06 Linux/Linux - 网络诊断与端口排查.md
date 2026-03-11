# 网络诊断与端口排查

## 目录

这篇内容层次较多，先看目录更容易定位复习重点。

- [核心场景](#核心场景)
- [端口排查（最高频）](#端口排查最高频)
- [网络连通性测试](#网络连通性测试)
- [查看网络连接](#查看网络连接)
- [DNS 查询](#dns-查询)
- [场景](#场景)
- [命令对比](#命令对比)
- [面试重点](#面试重点)
- [常见问题](#常见问题)

## 核心场景

后端开发中最常见的网络问题：
- 服务启动了，但访问不通
- 端口被占用，不知道是谁
- 网络连接异常，不知道哪里断了

## 端口排查（最高频）

### 场景 1：端口被占用

**问题**：启动服务时报错"端口已被占用"

**排查步骤**：

```bash
# 方法 1：lsof（推荐）
lsof -i :8080
# COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
# java     1234 user   45u  IPv6  12345      0t0  TCP *:8080 (LISTEN)

# 方法 2：netstat
netstat -tulnp | grep 8080
# tcp6  0  0  :::8080  :::*  LISTEN  1234/java

# 方法 3：ss（更快）
ss -tulnp | grep 8080
```

**解决**：
```bash
kill 1234              # 优雅关闭
kill -9 1234           # 强制关闭（如果上面不行）
```

### 场景 2：服务启动了但访问不通

**问题**：进程在运行，端口在监听，但就是访问不通

**排查步骤**：

```bash
# 1. 确认端口在监听
lsof -i :8080
netstat -tulnp | grep 8080

# 2. 确认监听地址
# 0.0.0.0:8080  - 监听所有 IP，外部可访问
# 127.0.0.1:8080 - 只监听本地，外部不可访问

# 3. 测试本地连接
telnet 127.0.0.1 8080
curl http://127.0.0.1:8080

# 4. 测试外部连接
telnet 服务器IP 8080
curl http://服务器IP:8080
```

**常见原因**：
- 只监听了 127.0.0.1（改配置，监听 0.0.0.0）
- 防火墙拦截（检查 iptables、firewalld）
- 服务内部逻辑错误（看日志）

### 场景 3：查看所有监听端口

```bash
# 查看所有监听端口
netstat -tulnp
ss -tulnp

# 只看 TCP
netstat -tlnp

# 只看 UDP
netstat -ulnp
```

**输出解释**：
```
Proto  Local Address   State    PID/Program
tcp    0.0.0.0:22      LISTEN   1234/sshd
tcp    0.0.0.0:80      LISTEN   5678/nginx
tcp    127.0.0.1:3306  LISTEN   9012/mysqld
```

- `0.0.0.0:22`：所有 IP 的 22 端口（SSH）
- `127.0.0.1:3306`：只有本地可访问的 3306 端口（MySQL）

## 网络连通性测试

### ping - 测试网络是否可达

这一节看起来往往容易变成一串结论，其实先抓住“ping - 测试网络是否可达”在Linux里的作用会更稳。后面的内容可以理解成围绕这个问题展开的几种常见判断和做法。

```bash
ping www.baidu.com              # 测试连通性
ping -c 4 8.8.8.8               # 发送 4 个包后停止
```

**能 ping 通说明**：
- 网络层可达
- 对方主机在线
- 防火墙允许 ICMP

**不能 ping 通可能是**：
- 网络不通
- 对方主机关机
- 防火墙禁止 ICMP（但服务可能正常）

**注意**：ping 通不代表服务可用，只代表网络层可达。

### telnet - 测试端口是否开放

```bash
telnet 192.168.1.1 8080         # 测试端口

# 成功：显示 Connected
# 失败：显示 Connection refused 或超时
```

**适用场景**：
- 测试 TCP 端口是否开放
- 测试服务是否启动
- 排查网络连通性

### nc（netcat）- 更强大的网络工具

```bash
nc -zv 192.168.1.1 8080         # 测试端口
nc -zv 192.168.1.1 8080-8090    # 测试端口范围
```

## 查看网络连接

### 查看所有连接

```bash
netstat -an                     # 查看所有连接
ss -an                          # 更快的替代品
```

### 查看 ESTABLISHED 连接

```bash
netstat -an | grep ESTABLISHED
ss -an | grep ESTABLISHED
```

### 统计连接状态

```bash
netstat -an | awk '/^tcp/ {print $6}' | sort | uniq -c
# 输出：
#  10 ESTABLISHED
#   5 TIME_WAIT
#   2 LISTEN
```

## DNS 查询

### nslookup - 查询域名

```bash
nslookup www.baidu.com          # 查询域名对应的 IP
```

### dig - 更详细的查询

```bash
dig www.baidu.com               # 查询域名
dig @8.8.8.8 www.baidu.com      # 指定 DNS 服务器
```

## 场景

### 场景 1：服务启动失败，提示端口被占用

```bash
# 1. 查看谁占用了端口
lsof -i :8080

# 2. 杀死占用进程
kill -9 PID

# 3. 重新启动服务
./start.sh
```

### 场景 2：服务启动了但访问不通

```bash
# 1. 确认进程在运行
ps aux | grep java

# 2. 确认端口在监听
lsof -i :8080

# 3. 确认监听地址（是 0.0.0.0 还是 127.0.0.1）
netstat -tulnp | grep 8080

# 4. 测试本地连接
curl http://127.0.0.1:8080

# 5. 测试外部连接
curl http://服务器IP:8080

# 6. 检查防火墙
iptables -L -n
```

### 场景 3：排查网络连接问题

```bash
# 1. 测试网络连通性
ping 目标IP

# 2. 测试端口是否开放
telnet 目标IP 端口

# 3. 查看路由
traceroute 目标IP

# 4. 查看 DNS 解析
nslookup 域名
```

## 命令对比

| 命令 | 用途 | 速度 | 推荐度 |
|------|------|------|--------|
| lsof | 查看端口占用 | 慢 |  |
| netstat | 查看网络连接 | 中 |  |
| ss | 查看网络连接 | 快 |  |
| ping | 测试连通性 | 快 |  |
| telnet | 测试端口 | 快 |  |
| nc | 测试端口 | 快 |  |

## 面试重点

读到“面试重点”时，先别急着记结论。更有效的方式是先弄清它在“Linux - 网络诊断与端口排查”这一张卡片里到底解决什么问题，这样后面的分点和对比才不至于显得太散。

**必须掌握**：
- `lsof -i :端口` 查看端口占用
- `netstat -tulnp` 查看监听端口
- `ping` 测试连通性
- `telnet IP 端口` 测试端口是否开放

**应该了解**：
- `ss` 是 `netstat` 的替代品，更快
- `0.0.0.0` 监听所有 IP，`127.0.0.1` 只监听本地
- ping 通不代表服务可用

**常见误区**：
- 端口在监听不等于服务可用
- ping 通不代表端口开放
- netstat 只能看本机连接，看不到网络层的包

## 常见问题

**Q: 如何查看端口被谁占用？**  
A: `lsof -i :8080` 或 `netstat -tulnp | grep 8080`

**Q: 如何测试端口是否开放？**  
A: `telnet IP 端口` 或 `nc -zv IP 端口`

**Q: netstat 和 ss 有什么区别？**  
A: ss 更快，是 netstat 的替代品

**Q: 为什么 ping 通但服务访问不了？**  
A: ping 只测试网络层，服务可能没启动、端口没开放、防火墙拦截

**Q: 0.0.0.0 和 127.0.0.1 有什么区别？**  
A: 0.0.0.0 监听所有 IP（外部可访问），127.0.0.1 只监听本地（外部不可访问）

**Q: 如何查看所有监听端口？**  
A: `netstat -tulnp` 或 `ss -tulnp`
