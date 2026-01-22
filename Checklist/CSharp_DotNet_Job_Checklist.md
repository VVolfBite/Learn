# C# / .NET 求职学习 Checklist（可打勾 Markdown）

> 用法：把 `- [ ]` 改成 `- [x]` 即可打勾。  
> 建议：按「了解 → 熟悉 → 精通」推进，每一层至少完成 1 个可展示的项目输出物。

---

## ✅ 进度总览

- [ ] 了解：能读懂/修改代码，完成基础功能
- [ ] 熟悉：能独立完成模块/小型项目，上线可用
- [ ] 精通：能做架构/性能/并发/稳定性与疑难排查

---

## 1）了解（入门 / 能看懂 + 能写基础代码）

### 1.1 C# 语法与基本功
- [ ] 熟悉基本结构：namespace / class / method / using
- [ ] 掌握流程控制：if/else、switch、for/foreach、while、break/continue
- [ ] 掌握基本类型：int/long/double/decimal/bool/char/string
- [ ] 理解 DateTime / TimeSpan / Guid 的常用用法
- [ ] 掌握方法参数：可选参数、命名参数
- [ ] 理解 ref / out / in（知道使用场景即可）
- [ ] 了解 `var` 的含义与边界（编译期类型推断）
- [ ] 理解 `const` vs `readonly`
- [ ] 熟悉字符串：插值 `$""`、格式化、转义、逐步拼接为何要用 StringBuilder
- [ ] 掌握异常处理：try/catch/finally、throw、常见异常类型
- [ ] 理解“不要吞异常”的基本原则（至少要记录/抛出）

### 1.2 面向对象 OOP（入门）
- [ ] 理解封装/继承/多态
- [ ] 会定义类/属性/方法
- [ ] 会用访问修饰符：public/private/protected/internal
- [ ] 理解 virtual/override 的基本用法
- [ ] 理解 abstract class 与 interface 的区别与适用场景（入门版）
- [ ] 会写简单的接口 + 实现类（为 DI 打基础）

### 1.3 集合与泛型
- [ ] 会用数组
- [ ] 会用 List<T>
- [ ] 会用 Dictionary<TKey,TValue>
- [ ] 会用 HashSet<T>
- [ ] 理解泛型的意义（类型安全 + 性能）
- [ ] 理解 IEnumerable<T> 的“可枚举”概念（知道 foreach 依赖它）

### 1.4 LINQ（入门）
- [ ] 会用 Where/Select/OrderBy/ThenBy
- [ ] 会用 First/FirstOrDefault/Single/SingleOrDefault（知道差异）
- [ ] 会用 Any/All/Count
- [ ] 会用 GroupBy（简单分组统计）
- [ ] 了解延迟执行（知道“可能多次枚举导致重复执行”的坑）

### 1.5 .NET / 工具链（入门）
- [ ] 知道 .NET SDK / Runtime / CLR 是什么（概念层面）
- [ ] 会用 dotnet CLI：dotnet new/build/run/test/publish
- [ ] 会用 NuGet（PackageReference）添加/更新包
- [ ] 了解解决方案 .sln 与项目 .csproj 的关系
- [ ] 熟悉 Visual Studio / Rider / VS Code 的基本调试
- [ ] 会打断点、单步、查看变量、查看调用堆栈（Call Stack）
- [ ] 会使用 Git：clone、branch、commit、push、pull、merge（至少能合并）

### 1.6 了解级输出物（至少完成 1 个）
- [ ] 控制台小工具：读取 CSV/JSON → 统计 → 输出报告
- [ ] HTTP 小客户端：调用公开 API → 解析 JSON → 展示结果
- [ ] 文件处理工具：目录扫描/批量重命名/重复文件查找
- [ ] 写一篇总结：值类型/引用类型 + 异常处理 + LINQ 常用

---

## 2）熟悉（中级 / 能独立做功能模块 + 项目可上线）

### 2.1 C# 语言进阶（会用 + 知道边界）
- [ ] 委托 delegate：Action/Func 的常用写法
- [ ] 事件 event：订阅/发布、知道需要退订避免泄漏
- [ ] Lambda 表达式熟练使用
- [ ] 了解表达式树 Expression（至少能区分与 Lambda 的不同用途）
- [ ] 扩展方法（extension methods）
- [ ] Attribute（特性）：知道常见用途（序列化/验证/框架标注）
- [ ] 记录类型 record：适用场景（DTO/不可变数据）
- [ ] init-only setter / with 表达式
- [ ] 模式匹配：is/switch pattern（用来减少 if-else）
- [ ] 可空引用类型（NRT）：string?、null 警告、正确处理 null
- [ ] IDisposable：using/await using、资源释放（流/连接/句柄）

### 2.2 异步与并发（高频）
- [ ] 掌握 async/await 的正确写法
- [ ] 理解为什么不要用 `.Result` / `.Wait()` 阻塞（死锁/线程池问题）
- [ ] 掌握 Task.WhenAll/WhenAny 的并发执行
- [ ] 会用 CancellationToken（支持取消）
- [ ] 会用 Timeout（超时控制）
- [ ] 理解 IO-bound vs CPU-bound 的不同策略
- [ ] 会用 lock 做临界区保护
- [ ] 会用并发集合：ConcurrentDictionary / ConcurrentQueue
- [ ] 理解线程安全的基本原则（共享可变状态要同步）

### 2.3 ASP.NET Core Web API（后端核心）
- [ ] 能创建并运行 Web API 项目
- [ ] 路由：attribute routing（[HttpGet]/[HttpPost]）
- [ ] 模型绑定：FromBody/FromQuery/FromRoute
- [ ] 模型验证：DataAnnotations + 自动 400
- [ ] 了解 Middleware 管道（请求如何经过各个中间件）
- [ ] 了解 Filters（ActionFilter/ExceptionFilter 的用途）
- [ ] 依赖注入 DI：能注册与使用服务
- [ ] 生命周期：Singleton/Scoped/Transient 的区别与常见坑
- [ ] 配置：appsettings.json + 环境变量
- [ ] Options 模式：IOptions<T>/IOptionsSnapshot<T>
- [ ] 日志：ILogger（结构化日志：用参数占位而非字符串拼接）
- [ ] Swagger/OpenAPI：生成文档、注释、分组
- [ ] CORS：跨域配置与常见误区
- [ ] 认证/授权基础：JWT 或 Cookie（至少掌握一种）
- [ ] 全局异常处理（统一错误响应）

### 2.4 数据库与数据访问（必备）
- [ ] SQL 基础：SELECT/JOIN/GROUP BY/HAVING/ORDER BY
- [ ] 索引基础：为什么索引能加速、什么时候会失效
- [ ] 事务基础：ACID、隔离级别（至少知道“读已提交/可重复读”）
- [ ] EF Core：DbContext 的作用
- [ ] EF Core：迁移 Migrations 的创建与应用
- [ ] EF Core：关系映射（1-1 / 1-n / n-n）
- [ ] EF Core：跟踪/非跟踪（AsNoTracking）
- [ ] EF Core：避免 N+1（Include 或投影）
- [ ] 了解 Dapper（知道什么时候选它：简单高性能查询）

### 2.5 常见组件（按岗位加分）
- [ ] Redis：基本读写、过期策略、缓存 Key 设计
- [ ] 缓存策略：Cache-Aside 思想（先查缓存，miss 再查库并回填）
- [ ] 缓存风险：穿透/击穿/雪崩（知道对策：布隆/互斥/过期抖动）
- [ ] 消息队列：RabbitMQ/Kafka（至少理解生产者/消费者）
- [ ] 幂等：消费端如何避免重复处理
- [ ] 重试与死信队列（知道为什么要）
- [ ] 定时任务：Hangfire/Quartz.NET（至少会用一种）
- [ ] 上传下载：文件流、Content-Type、大小限制、存储策略

### 2.6 测试与工程化（决定“熟悉”的含金量）
- [ ] 单元测试框架：xUnit/NUnit/MSTest 任选一种
- [ ] Mock 框架：Moq/NSubstitute 任选一种
- [ ] 会写 Arrange-Act-Assert 结构的测试
- [ ] 会写集成测试（WebApplicationFactory 或测试环境）
- [ ] 会用 Git 分支策略（feature 分支、PR/MR）
- [ ] 会写 README（如何运行、配置、依赖）
- [ ] 会用 Docker 打包 ASP.NET Core 服务（加分）
- [ ] 了解 CI/CD 基本流程（build/test/publish/deploy）

### 2.7 安全与规范（中级必须有意识）
- [ ] 密码存储：知道必须 hash + salt（不要明文）
- [ ] 输入校验：避免注入（SQL 注入、XSS 等基本概念）
- [ ] 认证授权：最小权限原则
- [ ] 记录关键操作日志（审计）
- [ ] 统一错误码与错误信息（避免泄漏内部细节）

### 2.8 熟悉级项目输出物（建议至少完成 1 个“可展示”）
- [ ] Web API 项目：用户体系 + JWT + EF Core + Swagger
- [ ] 加分：接入 Redis 缓存 + 统一异常处理 + 日志
- [ ] 加分：单元测试覆盖核心业务（至少 10~30 个）
- [ ] 加分：Docker 化 + 一键启动（docker compose 更佳）
- [ ] 写一份接口文档 & Postman/Bruno/Swagger 测试说明
- [ ] 在简历中量化：QPS、响应时间、失败率、成本或性能提升

---

## 3）精通（高级 / 架构、性能、并发、稳定性、疑难排查）

### 3.1 CLR / JIT / GC 深入（性能根基）
- [ ] 理解 IL 与 JIT 编译的基本流程
- [ ] 理解 GC 分代（Gen0/1/2）与触发条件
- [ ] 了解 LOH（大对象堆）与常见问题（碎片/回收）
- [ ] 理解“分配率”与 GC 压力的关系
- [ ] 理解引用类型/装箱带来的额外分配
- [ ] 会用 Span<T>/Memory<T> 的基本场景（减少复制、切片）
- [ ] 了解对象池（ArrayPool/ObjectPool）与适用场景

### 3.2 性能诊断与工具（能定位问题）
- [ ] 会用 BenchmarkDotNet 做基准测试（方法级）
- [ ] 会用 dotnet-counters 看运行指标（CPU/GC/线程池等）
- [ ] 会用 dotnet-trace/dotnet-dump 做现场分析（至少会一种）
- [ ] 会读懂火焰图或采样结果（知道热点在哪里）
- [ ] 会做性能优化闭环：测量 → 定位 → 修改 → 回归验证

### 3.3 高并发与并行设计（能解释权衡）
- [ ] 会用 SemaphoreSlim 做并发限制
- [ ] 理解线程池饥饿（ThreadPool starvation）与典型诱因
- [ ] 理解背压（Backpressure）与队列堆积风险
- [ ] 了解 Channel（System.Threading.Channels）用于高吞吐管道
- [ ] 了解无锁/低锁设计思路（Interlocked 等）
- [ ] 设计幂等策略（请求/消息重复的处理）
- [ ] 设计超时/重试/熔断/降级策略（Polly 思想）
- [ ] 设计限流（令牌桶/漏桶的概念与实践）
- [ ] 设计热点 Key 的拆分与缓存穿透治理

### 3.4 分布式与一致性（中大型系统必备）
- [ ] 理解 CAP/最终一致性在业务中的含义
- [ ] 了解 Outbox 模式（本地事务 + 可靠消息）
- [ ] 了解 Saga（分布式事务补偿）
- [ ] 了解去重/幂等表（Exactly-once 的工程实现）
- [ ] 设计事件驱动架构（领域事件/集成事件）
- [ ] 了解分布式锁（使用边界与陷阱）

### 3.5 可观测性与稳定性（线上能力）
- [ ] 结构化日志：TraceId/SpanId 贯穿请求链路
- [ ] 指标 Metrics：QPS、延迟分位数、错误率、依赖失败率
- [ ] 链路追踪 Tracing：定位慢点/失败点
- [ ] 了解 OpenTelemetry 基本概念与落地方式
- [ ] 告警策略：阈值/同比环比/静默与升级
- [ ] 故障演练与回滚策略
- [ ] 事故复盘：根因、影响面、改进项、行动闭环

### 3.6 架构与设计（能带方案）
- [ ] 分层架构的边界清晰（API/应用/领域/基础设施）
- [ ] SOLID 深入理解并能在代码中体现
- [ ] 了解 DDD：实体/值对象/聚合/仓储/领域服务/领域事件
- [ ] 接口设计：版本管理、兼容性策略、错误码体系
- [ ] 数据建模：一致性、扩展性、性能（索引/分库分表概念）
- [ ] 安全体系：最小权限、密钥管理、审计、合规意识

### 3.7 精通级“证明材料”（建议至少 1~2 条）
- [ ] 交付过高并发/低延迟优化：吞吐提升、延迟下降（可量化）
- [ ] 做过稳定性治理：限流/熔断/重试/隔离/降级落地
- [ ] 主导过架构演进：模块化、拆分、异步化、缓存体系升级
- [ ] 有线上疑难排查案例：内存泄漏/死锁/线程池饥饿/慢查询定位
- [ ] 输出技术文档：架构图、关键链路、容量评估、SLA/SLO

---

## 4）面试准备 Checklist（通用加分）

### 4.1 必会“讲清楚”的主题
- [ ] 值类型 vs 引用类型（含装箱拆箱）
- [ ] async/await 的原理与常见坑（.Result/.Wait、async void）
- [ ] LINQ 延迟执行与多次枚举风险
- [ ] IDisposable 与资源释放（连接/流）
- [ ] DI 生命周期：为什么 DbContext 通常是 Scoped
- [ ] EF Core 常见坑：N+1、Include、跟踪/非跟踪、迁移

### 4.2 简历与项目表达
- [ ] 每个项目能用 STAR 描述（背景/任务/行动/结果）
- [ ] 至少 2~3 个量化指标（性能、成本、稳定性、规模）
- [ ] 写清楚你的职责边界（我做了什么、怎么做的、带来什么）
- [ ] 准备 1 个“失败/踩坑”案例与复盘（很加分）

