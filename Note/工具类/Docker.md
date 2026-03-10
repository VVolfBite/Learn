# Docker

## 工具介绍

Docker 是容器化工具。菜鸟教程在入门页里强调了它解决的几个传统部署痛点：环境不一致、依赖复杂、部署步骤容易漂移、虚拟机资源开销大。这个切入点非常适合后端开发者理解 Docker，因为大多数人第一次接触 Docker，不是为了研究容器理论，而是为了把“我本地能跑”的东西更稳定地带到测试和生产环境。citeturn0search2turn0search3

简单说，Docker 的价值是把应用和它运行所需的环境打包到一起，让同一份镜像可以在不同机器上以更一致的方式运行。

## 核心机制

### 镜像

镜像可以理解成运行模板，里面包含应用运行所需的文件、依赖和启动命令。你可以把它看成“容器启动前的静态包”。

### 容器

容器是镜像运行后的实例。镜像像类，容器像对象。真正跑起来、占端口、打日志、处理请求的是容器。

### 仓库

仓库是存放镜像的地方。最常见的是 Docker Hub，也可以是公司内部镜像仓库。菜鸟教程在 `docker run` 的例子里就展示了：本地没有镜像时，Docker 会先去镜像仓库拉取。citeturn0search6

### 数据卷与网络

容器是轻量和可替换的，所以数据不能总是直接写在容器内部。需要持久保存的数据，通常会用 volume 挂出来。服务之间要通信，则会通过 Docker 网络或端口映射来解决。

## 基本使用

### 看版本与服务状态

```bash
docker --version
docker info
```

### 拉镜像

```bash
docker pull redis
docker pull nginx:latest
```

### 运行容器

菜鸟教程的 Hello World 页面给了最基础的 `docker run` 用法：指定镜像，然后在容器里执行命令。这个例子虽然简单，但正好能让人先建立“镜像 -> 容器 -> 命令”的最小理解。citeturn0search6

```bash
docker run ubuntu:22.04 /bin/echo "hello world"
```

更常见的服务运行方式：

```bash
docker run -d --name myredis -p 6379:6379 redis
docker run -d --name mynginx -p 8080:80 nginx
```

### 查看容器

```bash
docker ps
docker ps -a
docker logs myredis
docker exec -it myredis sh
```

### 停止、启动、删除

```bash
docker stop myredis
docker start myredis
docker rm -f myredis
```

### 镜像构建

最基本的 Dockerfile 例子：

```dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/app.jar app.jar
CMD ["java", "-jar", "app.jar"]
```

构建与运行：

```bash
docker build -t demo-app:1.0 .
docker run -d -p 8080:8080 demo-app:1.0
```

## 项目工程中的使用

### 本地开发环境统一

后端项目常见的一步是：把 MySQL、Redis、Kafka 这些依赖服务都用 Docker 起起来，避免“你电脑有，我电脑没有”。

### 应用打包与部署

CI/CD 流程里经常会先构建镜像，再把镜像推到仓库，最后由测试或生产环境拉起。

### 隔离运行环境

多个服务依赖不同版本的运行时或系统库时，容器化比直接装到宿主机上更稳。

## 常见问题与注意点

第一，Docker 不是虚拟机。它更轻，但隔离边界和使用方式也不同。菜鸟教程在基础概念页里明确强调了容器共享主机内核，这一点很关键。citeturn0search2

第二，不要把数据全写进容器内部。容器删了，数据可能就没了。

第三，端口映射和网络一定要清楚，不然容器起了也访问不到。

第四，日志、配置、挂载目录都要想清楚，别把容器当成黑盒。

第五，Docker 的价值不只是“会几个命令”，而是让项目部署过程更可复制。
