# Nginx

## 工具介绍

Nginx 是一个高性能的 Web 服务器，也常被拿来做反向代理、负载均衡和静态资源服务。它在后端项目里非常常见，因为浏览器、网关、静态资源、应用服务之间，往往需要一个中间层来接请求、转发流量、做基本控制。

如果从工程视角看，Nginx 最重要的不是“它很快”，而是它常常站在流量入口：把请求接进来，再决定交给谁处理。

## 核心机制

### 正向代理与反向代理

理解 Nginx，先把代理概念搞清楚。正向代理更偏替客户端访问外部网络，反向代理则站在服务端前面，对外暴露统一入口，把请求转发到后面的应用服务。

后端项目里提到 Nginx，通常说的是反向代理。

### location 与匹配

Nginx 配置里最常见的是 `server` 和 `location`。`server` 管域名和端口，`location` 管路径匹配和转发规则。

### upstream

当后面不止一个服务实例时，经常会用 `upstream` 定义一组后端节点，再由 Nginx 做转发和基本负载均衡。

### 静态资源与转发

Nginx 很适合直接返回静态文件，也很适合把动态请求转发给 Java、Go、Node 等后端服务。

## 基本使用

### 查看配置与启动

不同系统上的安装方式不一样，但最先会碰到的是这几类动作：

```bash
nginx -t
nginx
nginx -s reload
nginx -s stop
```

其中 `nginx -t` 很重要，用来检查配置有没有写错。改完配置先测再 reload，这是非常基本的习惯。

### 最小静态站点

```nginx
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
```

### 反向代理

```nginx
server {
    listen 80;
    server_name api.demo.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

### 负载均衡

```nginx
upstream backend {
    server 127.0.0.1:8080;
    server 127.0.0.1:8081;
}

server {
    listen 80;
    server_name api.demo.com;

    location / {
        proxy_pass http://backend;
    }
}
```

## 项目工程中的使用

### 应用入口

单体服务和微服务都很常见的一种做法，是先让 Nginx 作为统一入口，对外暴露 80 或 443，再把请求转发到后端服务。

### 静态资源服务

前端打包出来的 html、css、js、图片文件，经常直接由 Nginx 提供。

### 网关前置能力

很多项目会在 Nginx 层做基础限流、路径转发、跨域头设置、HTTPS 终止和访问日志记录。

## 常见问题与注意点

第一，Nginx 配错比不会用更可怕。上线前一定先 `nginx -t`。

第二，反向代理时要注意转发头，不然下游服务可能拿不到真实 IP、Host 等信息。

第三，静态资源和动态请求可以交给不同路径处理，不要全混在一起。

第四，Nginx 只是流量入口的一层，不是所有功能都应该堆在这里。认证、业务判断、复杂路由还是应放在更合适的位置。
