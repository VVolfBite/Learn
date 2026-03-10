# OpenAPI 与 Swagger

## 工具介绍

Swagger 是一套围绕 API 设计、文档化和测试的工具集，而 OpenAPI 是接口描述规范。菜鸟教程把 Swagger 定义为“用于设计、构建、文档化和测试 RESTful API 的开源工具集”，同时明确指出它和 OpenAPI 的关系：Swagger 最初是独立规范，后来成为 OpenAPI Specification 的基础。这个说法很适合直接拿来理解这两个词的边界。citeturn2search4turn2search5

简单说：
- **OpenAPI** 更像规范文件本身。
- **Swagger** 更像围绕这份规范工作的工具生态。

## 核心机制

### OpenAPI 规范文件

OpenAPI 通常用 YAML 或 JSON 描述接口，包括路径、方法、参数、请求体、响应体、鉴权方式等。

一个最小示例：

```yaml
openapi: 3.0.0
info:
  title: Demo API
  version: 1.0.0
paths:
  /users:
    get:
      summary: 获取用户列表
      responses:
        '200':
          description: ok
```

### Swagger 的几个核心组件

菜鸟教程把 Swagger 的核心组件分成 Swagger Editor、Swagger UI 和 Swagger Codegen，这个划分非常适合做笔记：citeturn2search4turn2search5

- **Swagger Editor**：写和改 OpenAPI 文档。
- **Swagger UI**：把文档展示成可交互页面。
- **Swagger Codegen**：基于规范生成客户端或服务端代码。

### 设计优先与代码优先

很多团队会走两种路径：
- 先设计接口文档，再生成代码或约束实现。
- 先写代码，再从代码生成接口文档。

这两种方式没有绝对高下，关键是团队要有统一约束，不然文档很快就会和代码脱节。

## 基本使用

### 写一份最小 OpenAPI 文档

刚上手时，先会写路径、方法、参数和返回值就够了。

### 用 Swagger UI 查看接口

把 OpenAPI 文件喂给 Swagger UI 后，前后端和测试就能在浏览器里直接看接口文档、试发请求、看响应。

### 生成代码或 SDK

如果项目接口比较多，或者前后端协作很依赖一致性，可以考虑用代码生成工具减少重复劳动。菜鸟教程也把这一点列为 Swagger 的核心价值之一。citeturn2search4turn2search5

## 项目工程中的使用

### 统一接口文档

这是最直接的用途。接口文档不再散落在 wiki、聊天记录和脑子里，而是有一份结构化描述。

### 前后端协作

前端可以先看文档开发页面和调用逻辑，后端也能更早发现接口设计不合理的地方。

### 测试与调试

测试同学或后端自己都可以直接在 Swagger UI 里试接口，不用每次都手敲 curl。

### 生成客户端或服务端骨架

对于接口多、重复度高的系统，代码生成能省下不少模板劳动。

## 常见问题与注意点

第一，Swagger 不是“把接口列出来”就结束了，重点是文档要和实际实现保持一致。

第二，OpenAPI 文件里字段命名、响应码、错误结构最好统一，不然文档再漂亮也很难用。

第三，Swagger UI 很方便，但生产环境是否对外暴露、暴露到什么程度，要结合安全策略考虑。
