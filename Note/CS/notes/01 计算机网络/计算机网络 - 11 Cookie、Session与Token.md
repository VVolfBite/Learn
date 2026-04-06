
# 计算机网络 - 12 Cookie、Session与Token

<!-- GFM-TOC -->
* [计算机网络 - 12 Cookie、Session与Token](#计算机网络---12-cookiesession与token)
    * [Cookie](#cookie)
        * [Cookie 是什么](#cookie-是什么)
        * [Cookie 的用途](#cookie-的用途)
        * [Cookie 的创建过程](#cookie-的创建过程)
        * [Cookie 的分类](#cookie-的分类)
        * [Cookie 的属性](#cookie-的属性)
    * [Session](#session)
        * [Session 是什么](#session-是什么)
        * [Session 的工作原理](#session-的工作原理)
        * [Session 的存储方式](#session-的存储方式)
        * [Session 的安全性](#session-的安全性)
    * [Token](#token)
        * [Token 是什么](#token-是什么)
        * [Token 的工作原理](#token-的工作原理)
        * [JWT](#jwt)
        * [Token 的优势](#token-的优势)
    * [几者对比](#几者对比)
    * [高频判断](#高频判断)
    <!-- GFM-TOC -->

## Cookie

### Cookie 是什么

**Cookie** 是服务器发送到用户浏览器并保存在本地的一小块数据，它会在浏览器之后向同一服务器再次发起请求时被携带上，用于告知服务端两个请求是否来自同一浏览器。

**为什么需要 Cookie**：
- HTTP 协议是**无状态**的，服务器无法识别两次请求是否来自同一用户
- Cookie 用于在客户端保存状态信息
- 使服务器能够识别用户身份和维护会话状态

**Cookie 的特点**：
- 存储在客户端（浏览器）
- 大小限制：通常为 4KB
- 数量限制：每个域名通常限制 20-50 个
- 每次请求都会自动携带
- 可以设置过期时间

### Cookie 的用途

这一节看起来往往容易变成一串要点，其实先理解“Cookie 的用途”在计算机网络里的作用会更顺。后面的内容可以理解成围绕这个问题展开的几种常见情况。

**1. 会话状态管理**
- 用户登录状态
- 购物车内容
- 游戏分数
- 其他需要记录的信息

**2. 个性化设置**
- 用户自定义设置
- 主题偏好
- 语言选择
- 界面布局

**3. 浏览器行为跟踪**
- 跟踪分析用户行为
- 广告推荐
- 用户画像
- 访问统计

### Cookie 的创建过程

**服务器创建 Cookie**：

服务器在响应报文中包含 `Set-Cookie` 首部字段：

```http
HTTP/1.0 200 OK
Content-type: text/html
Set-Cookie: user_id=12345
Set-Cookie: session_token=abc123xyz

[page content]
```

**客户端发送 Cookie**：

客户端之后对同一个服务器发送请求时，会通过 `Cookie` 请求首部字段发送：

```http
GET /profile HTTP/1.1
Host: www.example.com
Cookie: user_id=12345; session_token=abc123xyz
```

**完整流程**：

```
1. 客户端首次访问服务器
   ↓
2. 服务器通过 Set-Cookie 设置 Cookie
   ↓
3. 客户端保存 Cookie 到浏览器
   ↓
4. 客户端再次访问时自动携带 Cookie
   ↓
5. 服务器读取 Cookie 识别用户
```

### Cookie 的分类

**1. 会话期 Cookie（Session Cookie）**
- 浏览器关闭后自动删除
- 仅在会话期内有效
- 不设置 `Expires` 或 `Max-Age` 属性

**特点**：
- 临时性
- 安全性较高（关闭浏览器即失效）
- 适合敏感信息

**2. 持久性 Cookie（Persistent Cookie）**
- 指定过期时间或有效期
- 浏览器关闭后仍然保留
- 到期后自动删除

**设置方式**：

```http
Set-Cookie: user_id=12345; Expires=Wed, 21 Oct 2025 07:28:00 GMT
Set-Cookie: user_id=12345; Max-Age=3600
```

**特点**：
- 持久性
- 方便用户（如"记住我"功能）
- 需要注意安全性

### Cookie 的属性

这一节看起来往往容易变成一串要点，其实先理解“Cookie 的属性”在计算机网络里的作用会更顺。后面的内容可以理解成围绕这个问题展开的几种常见情况。

**1. Domain（域）**
- 指定哪些主机可以接受 Cookie
- 如果不指定，默认为当前文档的主机（不包含子域名）
- 如果指定了 Domain，则一般包含子域名

```http
Set-Cookie: user_id=12345; Domain=example.com
```

**效果**：
- `example.com` 可以访问
- `www.example.com` 可以访问
- `api.example.com` 可以访问

**2. Path（路径）**
- 指定主机下的哪些路径可以接受 Cookie
- 子路径也会被匹配

```http
Set-Cookie: user_id=12345; Path=/docs
```

**效果**：
- `/docs` 可以访问
- `/docs/Web/` 可以访问
- `/` 不能访问

**3. Expires / Max-Age（过期时间）**
- `Expires`：指定具体的过期时间
- `Max-Age`：指定从现在开始的有效秒数

```http
Set-Cookie: user_id=12345; Expires=Wed, 21 Oct 2025 07:28:00 GMT
Set-Cookie: user_id=12345; Max-Age=3600
```

**4. Secure（安全标志）**
- 标记为 Secure 的 Cookie 只能通过 HTTPS 协议发送
- 防止 Cookie 在 HTTP 传输中被窃取

```http
Set-Cookie: user_id=12345; Secure
```

**5. HttpOnly（HTTP 专用）**
- 标记为 HttpOnly 的 Cookie 不能被 JavaScript 访问
- 防止 XSS 攻击窃取 Cookie

```http
Set-Cookie: session_token=abc123; HttpOnly
```

**6. SameSite（同站策略）**
- 防止 CSRF 攻击
- 控制 Cookie 在跨站请求时是否发送

```http
Set-Cookie: user_id=12345; SameSite=Strict
Set-Cookie: user_id=12345; SameSite=Lax
Set-Cookie: user_id=12345; SameSite=None; Secure
```

**SameSite 的值**：
- **Strict**：完全禁止跨站发送
- **Lax**：部分允许跨站发送（如链接跳转）
- **None**：允许跨站发送（必须配合 Secure 使用）

**完整示例**：

```http
Set-Cookie: session_token=abc123xyz; 
            Domain=example.com; 
            Path=/; 
            Max-Age=3600; 
            Secure; 
            HttpOnly; 
            SameSite=Lax
```

## Session

### Session 是什么

**Session（会话）**是服务器端用于保存用户状态的一种机制，相比于 Cookie 存储在客户端，Session 数据存储在服务器端，更加安全。

**Session 的特点**：
- 存储在服务器端
- 通过 Session ID 识别用户
- Session ID 通常通过 Cookie 传递
- 可以存储任意类型的数据
- 更加安全

### Session 的工作原理

**Session 的完整流程**：

```
1. 用户首次访问服务器
   ↓
2. 服务器创建 Session，生成唯一的 Session ID
   ↓
3. 服务器将 Session ID 通过 Cookie 发送给客户端
   ↓
4. 客户端保存 Session ID（通常在 Cookie 中）
   ↓
5. 客户端后续请求携带 Session ID
   ↓
6. 服务器根据 Session ID 查找对应的 Session 数据
   ↓
7. 服务器读取/修改 Session 数据
```

**详细示例**：

**1. 用户登录**
```
用户提交登录表单（用户名 + 密码）
   ↓
服务器验证用户名和密码
   ↓
验证成功，创建 Session
   ↓
Session 数据：{ user_id: 12345, username: "alice", role: "admin" }
Session ID：abc123xyz
   ↓
服务器返回响应，设置 Cookie
Set-Cookie: SESSIONID=abc123xyz; HttpOnly; Secure
```

**2. 后续请求**
```
客户端发送请求，携带 Cookie
Cookie: SESSIONID=abc123xyz
   ↓
服务器提取 Session ID
   ↓
服务器从 Session 存储中查找 Session 数据
   ↓
找到 Session：{ user_id: 12345, username: "alice", role: "admin" }
   ↓
服务器知道这是用户 alice 的请求
   ↓
服务器处理请求并返回响应
```

**3. 用户登出**
```
用户点击登出
   ↓
服务器删除 Session 数据
   ↓
服务器清除客户端的 Session ID Cookie
Set-Cookie: SESSIONID=; Max-Age=0
```

### Session 的存储方式

读到“Session 的存储方式”时，先别急着记结论。更稳的方式是先弄清它在“计算机网络 - 12 Cookie、Session与Token”这张卡片里到底想解决什么问题，这样后面的分类和判断就不会显得太散。

**1. 内存存储**
- 存储在服务器的内存中
- 速度最快
- 服务器重启后数据丢失
- 不适合分布式系统

**2. 文件存储**
- 存储在服务器的文件系统中
- 持久化存储
- 速度较慢
- 不适合高并发场景

**3. 数据库存储**
- 存储在关系型数据库（如 MySQL）
- 持久化存储
- 支持复杂查询
- 速度较慢

**4. 缓存存储（推荐）**
- 存储在内存型数据库（如 Redis、Memcached）
- 速度快
- 支持分布式
- 可以设置过期时间
- 适合高并发场景

**Redis 存储 Session 示例**：

```
Session ID: abc123xyz
Redis Key: session:abc123xyz
Redis Value: {
  "user_id": 12345,
  "username": "alice",
  "role": "admin",
  "login_time": "2025-03-07T10:00:00Z"
}
TTL: 3600 秒（1 小时）
```

### Session 的安全性

**1. Session ID 的安全性**
- Session ID 必须足够随机，不能被猜测
- 使用加密算法生成（如 UUID、随机字符串）
- 定期更换 Session ID（如登录后）

**2. Session 劫持防护**
- 使用 HTTPS 传输 Session ID
- 设置 Cookie 的 HttpOnly 和 Secure 属性
- 绑定 IP 地址或 User-Agent（可选）
- 设置合理的过期时间

**3. Session 固定攻击防护**
- 登录成功后重新生成 Session ID
- 不接受 URL 中的 Session ID
- 验证 Session 的来源

**4. 重要操作的二次验证**
- 转账、修改密码等操作需要重新验证
- 使用短信验证码、邮箱验证等
- 不能仅依赖 Session

## Token

### Token 是什么

**Token（令牌）**是一种无状态的身份验证机制，服务器不需要保存用户的会话信息，所有信息都包含在 Token 中。

**Token 的特点**：
- 无状态（服务器不保存 Token）
- 自包含（Token 包含所有必要信息）
- 可扩展性好（适合分布式系统）
- 跨域友好（不依赖 Cookie）

### Token 的工作原理

**Token 的完整流程**：

```
1. 用户登录，提交用户名和密码
   ↓
2. 服务器验证用户名和密码
   ↓
3. 验证成功，生成 Token
   Token 包含：用户信息 + 过期时间 + 签名
   ↓
4. 服务器将 Token 返回给客户端
   ↓
5. 客户端保存 Token（通常在 localStorage 或 sessionStorage）
   ↓
6. 客户端后续请求携带 Token（通常在 HTTP Header 中）
   Authorization: Bearer <token>
   ↓
7. 服务器验证 Token 的签名和有效期
   ↓
8. 验证通过，从 Token 中提取用户信息
   ↓
9. 服务器处理请求并返回响应
```

**关键点**：
- 服务器不保存 Token
- Token 包含所有必要信息
- 通过签名保证 Token 的完整性
- 客户端负责保存和发送 Token

### JWT

**JWT（JSON Web Token）**是目前最流行的 Token 实现方式。

**JWT 的结构**：

JWT 由三部分组成，用 `.` 分隔：

```
Header.Payload.Signature
```

**1. Header（头部）**
- 包含 Token 的类型和签名算法

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

**2. Payload（负载）**
- 包含用户信息和其他数据

```json
{
  "user_id": 12345,
  "username": "alice",
  "role": "admin",
  "exp": 1678176000
}
```

**常用字段**：
- `iss`（Issuer）：签发者
- `sub`（Subject）：主题
- `aud`（Audience）：受众
- `exp`（Expiration Time）：过期时间
- `iat`（Issued At）：签发时间
- `nbf`（Not Before）：生效时间

**3. Signature（签名）**
- 用于验证 Token 的完整性

```
HMACSHA256(
  base64UrlEncode(header) + "." + base64UrlEncode(payload),
  secret
)
```

**完整的 JWT 示例**：

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMjM0NSwidXNlcm5hbWUiOiJhbGljZSIsInJvbGUiOiJhZG1pbiIsImV4cCI6MTY3ODE3NjAwMH0.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```

**JWT 的验证过程**：

```
1. 服务器接收到 JWT
   ↓
2. 分离 Header、Payload、Signature
   ↓
3. 使用相同的算法和密钥重新计算签名
   ↓
4. 比较计算出的签名和 JWT 中的签名
   ↓
5. 如果一致，说明 Token 未被篡改
   ↓
6. 检查 Token 是否过期（exp 字段）
   ↓
7. 验证通过，提取 Payload 中的用户信息
```

### Token 的优势

**1. 无状态**
- 服务器不需要保存 Token
- 减少服务器存储压力
- 易于水平扩展

**2. 跨域友好**
- 不依赖 Cookie
- 可以在不同域名之间使用
- 适合前后端分离架构

**3. 移动端友好**
- 移动应用不支持 Cookie
- Token 可以存储在应用中
- 使用更加灵活

**4. 性能好**
- 不需要查询数据库或缓存
- 验证速度快
- 减少服务器负载

**5. 安全性**
- 通过签名保证完整性
- 可以设置过期时间
- 不容易被 CSRF 攻击

**Token 的缺点**：
- Token 一旦签发，无法主动失效（除非维护黑名单）
- Token 较长，每次请求都需要传输
- 需要客户端妥善保管 Token

## 几者对比

### Cookie vs Session vs Token

| 对比项 | Cookie | Session | Token |
| :---: | :---: | :---: | :---: |
| 存储位置 | 客户端（浏览器） | 服务器端 | 客户端（任意位置） |
| 存储内容 | 少量数据（4KB） | 任意数据 | 用户信息 + 签名 |
| 安全性 | 较低 | 较高 | 高 |
| 性能 | 好 | 一般（需要查询） | 好（无状态） |
| 跨域 | 受限 | 受限 | 友好 |
| 移动端 | 不友好 | 不友好 | 友好 |
| 扩展性 | 一般 | 差（需要共享存储） | 好（无状态） |
| 失效控制 | 容易 | 容易 | 困难 |

### 使用场景

读到“使用场景”时，先别急着记结论。更稳的方式是先弄清它在“计算机网络 - 12 Cookie、Session与Token”这张卡片里到底想解决什么问题，这样后面的分类和判断就不会显得太散。

**Cookie 适合**：
- 存储少量非敏感信息
- 用户偏好设置
- 跟踪用户行为
- 传递 Session ID

**Session 适合**：
- 传统 Web 应用
- 需要服务器端控制会话
- 需要存储大量用户数据
- 需要主动失效会话

**Token 适合**：
- 前后端分离应用
- 移动应用
- 微服务架构
- 跨域场景
- RESTful API

### 组合使用

读到“组合使用”时，先别急着记结论。更稳的方式是先弄清它在“计算机网络 - 12 Cookie、Session与Token”这张卡片里到底想解决什么问题，这样后面的分类和判断就不会显得太散。

**Cookie + Session**：
- Cookie 存储 Session ID
- Session 存储用户数据
- 传统 Web 应用的标准方案

**Token + Refresh Token**：
- Access Token：短期有效（如 15 分钟）
- Refresh Token：长期有效（如 7 天）
- Access Token 过期后用 Refresh Token 获取新的 Access Token
- 平衡安全性和用户体验

## 高频判断

### 1. Cookie 相关

**Q：Cookie 是什么？**
A：服务器发送到浏览器并保存在本地的一小块数据，用于在客户端保存状态信息。

**Q：Cookie 的大小和数量限制？**
A：单个 Cookie 通常限制 4KB，每个域名通常限制 20-50 个。

**Q：HttpOnly 和 Secure 的作用？**
A：
- HttpOnly：防止 JavaScript 访问 Cookie，防御 XSS 攻击
- Secure：只能通过 HTTPS 传输，防止中间人攻击

**Q：SameSite 的作用？**
A：防止 CSRF 攻击，控制 Cookie 在跨站请求时是否发送。

### 2. Session 相关

**Q：Session 是什么？**
A：服务器端用于保存用户状态的机制，通过 Session ID 识别用户。

**Q：Session 如何工作？**
A：服务器创建 Session 并生成 Session ID，通过 Cookie 将 Session ID 发送给客户端，客户端后续请求携带 Session ID，服务器根据 Session ID 查找 Session 数据。

**Q：Session 存储在哪里？**
A：可以存储在内存、文件、数据库或缓存（如 Redis）中，推荐使用 Redis。

**Q：浏览器禁用 Cookie 怎么办？**
A：可以使用 URL 重写技术，将 Session ID 作为 URL 参数传递，但安全性较低。

### 3. Token 相关

**Q：Token 是什么？**
A：一种无状态的身份验证机制，所有信息都包含在 Token 中，服务器不需要保存 Token。

**Q：JWT 的结构？**
A：Header（头部）+ Payload（负载）+ Signature（签名），用 `.` 分隔。

**Q：Token 如何保证安全？**
A：通过签名保证完整性，通过 HTTPS 传输保证机密性，通过过期时间限制有效期。

**Q：Token 可以主动失效吗？**
A：不能，除非维护一个 Token 黑名单。这是 Token 的一个缺点。

### 4. 对比相关

**Q：Cookie 和 Session 的区别？**
A：
- Cookie 存储在客户端，Session 存储在服务器端
- Cookie 安全性较低，Session 安全性较高
- Cookie 大小受限，Session 可以存储任意数据

**Q：Session 和 Token 的区别？**
A：
- Session 有状态（服务器保存），Token 无状态（服务器不保存）
- Session 需要查询存储，Token 只需验证签名
- Session 适合传统应用，Token 适合分布式系统

**Q：什么时候用 Cookie，什么时候用 Session，什么时候用 Token？**
A：
- Cookie：存储少量非敏感信息，如用户偏好
- Session：传统 Web 应用，需要服务器端控制会话
- Token：前后端分离、移动应用、微服务架构

### 5. 安全相关

**Q：如何防止 Cookie 被窃取？**
A：使用 HTTPS、设置 HttpOnly 和 Secure 属性、设置合理的过期时间。

**Q：如何防止 Session 劫持？**
A：使用 HTTPS、绑定 IP 或 User-Agent、定期更换 Session ID、设置合理的过期时间。

**Q：如何防止 Token 被盗用？**
A：使用 HTTPS、设置短期有效期、使用 Refresh Token、存储在安全的地方（不要存储在 localStorage）。

### 6. 实际应用

**Q：登录功能应该用什么方案？**
A：
- 传统 Web 应用：Cookie + Session
- 前后端分离应用：Token（JWT）
- 移动应用：Token（JWT）

**Q：如何实现"记住我"功能？**
A：使用持久性 Cookie 或长期有效的 Refresh Token。

**Q：如何实现单点登录（SSO）？**
A：使用 Token（JWT），在多个系统之间共享 Token。
