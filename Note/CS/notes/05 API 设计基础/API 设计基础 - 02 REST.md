# 02 REST

## REST

REST（Representational State Transfer）是一种软件架构风格，用于设计网络应用程序的接口。REST API（Application Programming Interface）是基于 REST 原则构建的 Web 服务接口，它允许不同的系统通过 HTTP 协议进行通信和数据交换。其核心理念是客户端与服务端独立，客户端无需知道服务端的服务逻辑，服务端无需知道客户端的用户界面。

### REST 核心

其核心为：

* RE (Representational)  资源表示性：要求资源以某种形式表示
* ST (State Transfer) 状态传输：要求用户状态不保留在服务端而是由用户自己传输。

![img](https://www.runoob.com/wp-content/uploads/2025/05/how-does-restful-api-work.webp)

### REST 约束

REST API 的约束包括：

* 客户端服务端：采用CS 结构

* 统一接口：所有数据被视为资源，通过 URI 标识，使用标准 HTTP 方法（GET、POST、PUT、DELETE 等）并以某种形式比如 json ，xml表示（Representational）

- 无状态性：客户端的状态不保存在服务端，每个请求都包含处理该请求所需的全部信息（State Transfer）
- 缓存：无状态不意味着无缓存，一般使用 GET 会设置缓存，而 POST 不设置；响应可以明确标记为可缓存或不可缓存
- 分层系统： REST 架构不一定只有两层架构，允许服务端做分层进行流量分配，负载均衡，安全管理
- 按需代码：服务端可响应代码给客户端来扩展客户端功能

### REST API 的主要概念

#### 资源标识与表示

在 REST 中，资源是任何可以命名的信息，如用户、产品、订单等。每个资源都有一个唯一的标识符（URI）。

#### HTTP 方法

REST API 使用标准 HTTP 方法来定义对资源的操作：

| HTTP 方法 | 描述         | 幂等性 | 安全性 |
| :-------- | :----------- | :----- | :----- |
| GET       | 获取资源     | 是     | 是     |
| POST      | 创建新资源   | 否     | 否     |
| PUT       | 更新整个资源 | 是     | 否     |
| PATCH     | 部分更新资源 | 否     | 否     |
| DELETE    | 删除资源     | 是     | 否     |

#### 状态码

HTTP 状态码表示请求的处理结果：

| 状态码 | 类别       | 常见状态码                     |
| :----- | :--------- | :----------------------------- |
| 2xx    | 成功       | 200 OK, 201 Created            |
| 3xx    | 重定向     | 301 Moved Permanently          |
| 4xx    | 客户端错误 | 400 Bad Request, 404 Not Found |
| 5xx    | 服务器错误 | 500 Internal Server Error      |

#### 数据格式

REST API 常用的数据交换格式：

- JSON（JavaScript Object Notation）
- XML（eXtensible Markup Language）
- 有时也使用 YAML、CSV 等格式

------

### REST API 的不足

* 非常依赖文档：由于 REST 使用 URI 标识资源位置，每一种资源都需要一份专门的文档描述其获取途径，方式，传输形式；若没有文档，调用者很难正常获取资源
* 资源获取：REST 规范下，用户无法指定获取资源的范围，因此获取资源经常遇到获取不足或者过量获取问题，导致了宽带浪费。

## REST API 设计最佳实践

设计实践有非常多的指导，这里列出几个为例：

### URI 设计原则

使用名词而非动词表示资源，比如好：`/users`，不好：`/getUsers`；使用小写字母和连字符（-）；避免文件扩展名；使用复数形式表示集合；分层次表示关系：`/users/{id}/orders`
### 版本控制

建议在 URI 或请求头中包含 API 版本信息，如URI 路径：`/v1/users`、请求头：`Accept: application/vnd.myapi.v1+json`

### 实现HATEOAS原则

HATEOAS（Hypermedia as the Engine of Application State），在响应中包含相关资源链接，使API具有自描述性

### 过滤、排序和分页

对于集合资源，提供查询参数，比如过滤：`/users?role=admin`、排序：`/users?sort=-created_at`、分页：`/users?page=2&limit=10`

### 一致性响应结构

使用包装对象，区分数据和元数据、保持错误响应格式一致。

在错误响应中包含唯一的错误代码，便于故障排除和文档参考；对于复杂错误，提供结构化的错误详情，特别是表单验证错误；包含请求标识符（request_id），便于日志跟踪和客户支持；考虑国际化支持，提供错误消息的多语言版本或错误代码映射；避免在错误消息中泄露敏感信息或实现细节。

### 安全性

使用 HTTPS、实施身份验证（OAuth2、JWT）、限制请求频率、验证输入数据

## REST API 测试工具

1. **Postman**：功能强大的 API 测试工具
2. **cURL**：命令行工具
3. **Insomnia**：轻量级 API 测试客户端
4. **Swagger/OpenAPI**：API 文档和测试工具

## REST API 开发框架

根据编程语言不同，有多种框架可用于开发 REST API：

| 语言       | 流行框架                     |
| :--------- | :--------------------------- |
| JavaScript | Express.js, NestJS           |
| Python     | Django REST Framework, Flask |
| Java       | Spring Boot                  |
| PHP        | Laravel, Symfony             |
| Ruby       | Ruby on Rails                |
| Go         | Gin, Echo                    |

## 示例

### 用户管理 API 示例

```json
\# 获取用户列表
GET /api/v1/users
Accept: application/json

\# 创建新用户
POST /api/v1/users
Content-Type: application/json

{
 "name": "张三",
 "email": "zhangsan@example.com"
}

\# 获取特定用户
GET /api/v1/users/123
Accept: application/json

\# 更新用户信息
PUT /api/v1/users/123
Content-Type: application/json

{
 "name": "张三(更新)",
 "email": "new-email@example.com"
}

\# 删除用户
DELETE /api/v1/users/123
```

### 响应示例

```json
*// 成功响应*
{
 "status": "success",
 "data": {
  "id": 123,
  "name": "张三",
  "email": "zhangsan@example.com",
  "created_at": "2023-01-01T00:00:00Z"
 }
}

*// 错误响应*
{
 "status": "error",
 "message": "User not found",
 "code": 404
}
```

