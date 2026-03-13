### 一、SSE 协议概述

**Server-Sent Events（SSE）** 是 HTML5 标准中定义的一种基于 HTTP 的服务器向客户端单向推送实时数据的协议。其核心特性包括：

- **单向通信**：服务器主动推送数据至客户端，客户端无需轮询；
- **自动重连**：连接中断后客户端自动尝试恢复；
- **文本流式传输**：数据格式为 `text/event-stream`，支持纯文本消息；
- **事件类型支持**：可自定义事件名称（如 `event: update`）。

------

### 二、SSE 与其他技术的对比

| 特性         | SSE                         | WebSocket               | 长轮询            |
| ------------ | --------------------------- | ----------------------- | ----------------- |
| **协议**     | HTTP                        | 自定义 TCP 协议         | HTTP              |
| **通信方向** | 单向（服务器 → 客户端）     | 双向（服务器 ↔ 客户端） | 单向（请求-响应） |
| **复杂度**   | 简单，无需握手              | 复杂，需维护长连接      | 高延迟，频繁请求  |
| **兼容性**   | 主流浏览器支持（IE 不支持） | 广泛支持（含旧版本）    | 完全兼容          |
| **适用场景** | 流式输出、通知推送          | 实时游戏、协作编辑      | 旧系统兼容        |

**典型选择建议**：

- **大模型流式输出**（如 ChatGPT 的逐字生成）首选 SSE ；
- **双向高频交互**（如在线游戏）使用 WebSocket；
- **兼容性优先**（如企业内网）采用长轮询。

------

### 三、SSE 在大模型接口调用中的核心应用

#### 1. 流式文本生成

大语言模型（LLM）生成文本时，SSE 可逐 token 推送结果至前端，显著降低用户等待感知延迟。例如：

- **ChatGPT**：逐字输出对话内容；
- **通义千问**：分段返回代码或文章生成结果 。

**技术实现**：
 后端通过 `text/event-stream` 响应持续发送数据片段，前端监听 `message` 事件拼接内容：

```javascript
javascript 体验AI代码助手 代码解读复制代码const eventSource = new EventSource('/stream?prompt=AI时代');
eventSource.onmessage = (event) => {
  document.getElementById("output").innerText += event.data;
};
```

#### 2. 实时对话与交互

在智能客服或聊天机器人中，SSE 支持服务器实时推送对话回复。例如：

- **金融客服**：实时解答用户问题；
- **教育平台**：AI 助教逐句解析题目 。

**数据格式规范**：
 每行以 `data:` 开头，最终以 `data: [DONE]` 标识结束：

```css
css 体验AI代码助手 代码解读复制代码data: {"content": "你好", "is_final": false}
data: {"content": "世界", "is_final": true}
```

#### 3. 任务进度监控

图像生成（如 Stable Diffusion）或视频处理任务中，SSE 可推送任务进度：

```python
python 体验AI代码助手 代码解读复制代码@app.route('/generate')
def generate():
    def progress():
        for i in range(100):
            yield f"data: 生成进度: {i}%\n\n"
    return Response(progress(), mimetype='text/event-stream')
```

------

### 四、SSE 的其他典型应用场景

1. **金融数据推送**
    股票行情、加密货币价格的实时更新 。
2. **物联网（IoT）监控**
    传感器数据（温度、湿度）的持续上报与展示。
3. **日志与调试信息**
    后端服务日志流式输出至前端控制台。
4. **在线教育互动**
    实时答题反馈与教学内容同步。

------

### 五、技术实现：前后端示例

#### 1. 后端实现（Python + Flask）

```python
python 体验AI代码助手 代码解读复制代码@app.route('/stream')
def stream():
    def event_stream():
        for i in range(5):
            yield f"data: 消息 {i}\n\n"
            time.sleep(1)
    return Response(event_stream(), mimetype='text/event-stream')
```

#### 2. 前端实现（JavaScript）

```javascript
javascript 体验AI代码助手 代码解读复制代码const eventSource = new EventSource('/stream');
eventSource.onmessage = (event) => {
  console.log('收到:', event.data);
};
eventSource.onerror = () => {
  console.error('连接异常');
};
```

#### 3. Spring Boot 示例（Java）

```java
java 体验AI代码助手 代码解读复制代码@GetMapping(value = "/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
public SseEmitter stream() {
    SseEmitter emitter = new SseEmitter(60_000L);
    new Thread(() -> {
        try {
            for (int i = 0; i < 5; i++) {
                emitter.send(SseEmitter.event().data("消息 " + i));
                Thread.sleep(1000);
            }
            emitter.complete();
        } catch (Exception e) {
            emitter.completeWithError(e);
        }
    }).start();
    return emitter;
}
```

------

### 六、最佳实践与优化策略

1. **性能优化**
   - 使用异步框架（如 Spring WebFlux、FastAPI）处理长连接 ；
   - 启用 HTTP/2 以复用连接，减少资源消耗。
2. **安全性**
   - 结合 JWT 或 API Key 认证，防止未授权访问；
   - 对敏感数据进行脱敏处理。
3. **错误处理**
   - 客户端监听 `error` 事件并自动重连；
   - 服务端设置超时机制（如 `SseEmitter.setTimeout()`）。

------

### 七、局限性与未来展望

#### 局限性：

- **单向通信**：无法通过同一连接发送客户端请求；
- **浏览器兼容性**：IE 和 Opera Mini 不支持；
- **连接管理**：高并发下需优化服务器资源 。

#### 未来趋势：

- **HTTP/2 Server Push**：结合 HTTP/2 提升性能；
- **SSE + WebSocket 混合架构**：互补实现双向通信需求 。

作者：rollinginthedeep
链接：https://juejin.cn/post/7504167136328269858
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。