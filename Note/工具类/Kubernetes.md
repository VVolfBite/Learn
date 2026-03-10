# Kubernetes

## 工具介绍

Kubernetes，常写作 K8s，是容器编排平台。Docker 解决的是“把应用装进容器里怎么跑”，Kubernetes 解决的是“容器多了以后怎么统一部署、伸缩、更新、恢复和管理”。

如果项目里只有一两个容器，手工 `docker run` 还勉强能撑；一旦服务数量上来、实例数增加、环境变多，手工管理就会非常混乱，这就是 Kubernetes 出场的地方。

## 核心机制

### Pod

Pod 是 Kubernetes 最基本的调度单位。你可以先把它理解成“运行容器的一层封装”。平时说“起一个服务实例”，在 K8s 里往往对应一个或多个 Pod。

### Deployment

Deployment 负责声明某个应用要跑几个副本、用什么镜像、怎么滚动更新。它是业务服务最常见的工作负载对象之一。

### Service

Pod 会变，IP 也可能变，所以一般不会直接让别的服务去记 Pod 地址。Service 提供了一个更稳定的访问入口。

### 声明式管理

Kubernetes 很重要的一点是声明式。你不是一步步手工执行“先起容器、再挂网络、再补副本”，而是写 YAML 告诉系统“我想要什么状态”，再由它去尽量维持这个状态。

## 基本使用

### 看集群和资源

```bash
kubectl get nodes
kubectl get pods
kubectl get svc
kubectl get deploy
```

### 查看详情与日志

```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### 应用配置

一个最小 Deployment 片段：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo-app
  template:
    metadata:
      labels:
        app: demo-app
    spec:
      containers:
        - name: app
          image: demo/app:1.0
          ports:
            - containerPort: 8080
```

应用配置：

```bash
kubectl apply -f deployment.yaml
```

## 项目工程中的使用

### 容器化服务管理

服务多、副本多、环境多时，K8s 适合统一管理部署和更新。

### 弹性伸缩与故障恢复

当某个实例挂掉，系统会尽量拉起新的实例；当流量增加，也可以配合扩容机制处理。

### 配置与发布治理

镜像版本、环境变量、服务发现、滚动发布，通常都会放到 Kubernetes 体系里统一处理。

## 常见问题与注意点

第一，Kubernetes 不是“学几个 kubectl 命令”就够了，真正关键的是理解 Pod、Deployment、Service 和声明式管理这几个核心对象。

第二，如果 Docker、网络、服务启动方式都没搞清楚，直接上 Kubernetes 会很空。

第三，K8s 能解决很多部署治理问题，但它本身也带来学习和运维复杂度，所以不是所有项目都必须上。
