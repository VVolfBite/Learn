# 02 REST

REST 本质上不是一套“URL 写法规范”，也不等于“接口走 HTTP 就算 REST”。它更接近一种**围绕资源组织系统能力的设计方式**：先把业务世界里的核心对象抽象成资源，再用统一的方法去读取、创建、更新、删除这些资源。
 因此，REST 真正关心的不是“路径里是不是用了名词”，而是接口是否围绕清晰稳定的资源展开，是否让调用方容易理解“这是什么对象、能做什么、状态怎么变化”。

如果一个接口表面上用了 `GET /orders/123` 这样的路径，但实际语义混乱、状态推进靠一堆隐式动作、不同接口的行为完全不一致，那么它只是“长得像 REST”，并不真的具备 REST 的设计价值。
 REST 的核心收益在于：**把接口从“零散动作集合”整理成“围绕资源的统一系统”**。

---

## REST

REST（Representational State Transfer）是一种软件架构风格，用于设计网络应用程序的接口。REST API（Application Programming Interface）是基于 REST 原则构建的 Web 服务接口，它允许不同的系统通过 HTTP 协议进行通信和数据交换。

![img](https://www.runoob.com/wp-content/uploads/2025/05/how-does-restful-api-work.webp)

REST API 的核心特点包括：

- 无状态性（Stateless）：每个请求都包含处理该请求所需的全部信息
- 资源导向（Resource-based）：所有数据被视为资源，通过 URI 标识
- 统一接口（Uniform Interface）：使用标准 HTTP 方法（GET、POST、PUT、DELETE 等）
- 可缓存性（Cacheable）：响应可以明确标记为可缓存或不可缓存

## REST API 的核心概念

### 1. 资源（Resource）

在 REST 中，资源是任何可以命名的信息，如用户、产品、订单等。每个资源都有一个唯一的标识符（URI）。

### 2. HTTP 方法

REST API 使用标准 HTTP 方法来定义对资源的操作：

| HTTP 方法 | 描述         | 幂等性 | 安全性 |
| :-------- | :----------- | :----- | :----- |
| GET       | 获取资源     | 是     | 是     |
| POST      | 创建新资源   | 否     | 否     |
| PUT       | 更新整个资源 | 是     | 否     |
| PATCH     | 部分更新资源 | 否     | 否     |
| DELETE    | 删除资源     | 是     | 否     |

### 3. 状态码

HTTP 状态码表示请求的处理结果：

| 状态码 | 类别       | 常见状态码                     |
| :----- | :--------- | :----------------------------- |
| 2xx    | 成功       | 200 OK, 201 Created            |
| 3xx    | 重定向     | 301 Moved Permanently          |
| 4xx    | 客户端错误 | 400 Bad Request, 404 Not Found |
| 5xx    | 服务器错误 | 500 Internal Server Error      |

### 4. 数据格式

REST API 常用的数据交换格式：

- JSON（JavaScript Object Notation）
- XML（eXtensible Markup Language）
- 有时也使用 YAML、CSV 等格式

------

## REST API 设计最佳实践

### 1. URI 设计原则

- 使用名词而非动词表示资源
  - 好：`/users`
  - 不好：`/getUsers`
- 使用小写字母和连字符（-）
- 避免文件扩展名
- 使用复数形式表示集合
- 分层次表示关系：`/users/{id}/orders`

### 2. 版本控制

建议在 URI 或请求头中包含 API 版本信息：

- URI 路径：`/v1/users`
- 请求头：`Accept: application/vnd.myapi.v1+json`

### 3. 过滤、排序和分页

对于集合资源，提供查询参数：

- 过滤：`/users?role=admin`
- 排序：`/users?sort=-created_at`
- 分页：`/users?page=2&limit=10`

### 4. 安全性

- 使用 HTTPS
- 实施身份验证（OAuth2、JWT）
- 限制请求频率
- 验证输入数据

