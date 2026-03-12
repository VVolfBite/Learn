什么是Webhook？工作原理？如何实现？
背景
在使用钉钉机器人配置Stream推送 - 钉钉开放平台，qq机器人（微信没有机器人），企业微信机器人、飞书机器人、GitHub WebHook、腾讯问卷这些应用时，

这些应用都提供了Webhook，它允许系统之间在事件发生时主动传递信息，而无需持续轮询。

有的人一开始可能很困惑，什么是Webhook？如何使用？

什么是 Webhook？
通俗一点就是，你（自己的服务器提供一个webhook）在手机（其它支持webhook的平台注册）上定了一个明天早上6点的闹钟（将自己的webhook注册在其它平台上），当时间来到第二天早上6点时候，手机（其它支持webhook的平台）闹钟响起（触发你注册的webhook），你（自己的服务器提供一个webhook）就会听到铃声响起来（自己的服务器上的webhook触发）。

Webhook 是一种简单的 HTTP 回调机制，它允许一个应用程序在事件发生时自动通过 HTTP 请求通知另一个应用程序。这意味着 Webhook 在某个特定事件发生时，自动向指定的 URL 发送数据，通常是 JSON 或 XML 格式。与传统的 API 不同，Webhook 是一种“推送”机制，而不是“拉取”机制。

Webhook 的工作原理
Webhooks 的工作流程可以总结为以下几个步骤：

事件触发：当某个应用程序中的特定事件发生时，系统就会触发 Webhook。例如，用户完成了一笔支付，或代码库有新的提交。
发送 HTTP 请求：事件发生后，应用会通过 HTTP 请求（通常是 POST 请求）将事件数据发送到预设的 URL。这个 URL 是接收 Webhook 的端点，通常是另一个应用程序或服务提供的 API。
数据处理：接收方应用接收到 HTTP 请求后，会解析请求中的数据，并根据这些数据进行相应的操作。例如，它可能会更新数据库，发送通知，或触发其他操作。
Webhook 与 API 的区别
尽管 Webhook 和传统的 API 都用于系统间的数据交换，它们的工作方式有所不同：

Webhook：是一种主动通知机制。当事件发生时，Webhooks 会自动发送数据到指定的 URL，而接收方无需发起请求。
API：是一种请求-响应模式。接收方必须主动发起请求来获取数据或执行操作。
因此，Webhooks 更适合处理实时事件和通知，特别是在需要快速响应的场景中，如支付确认、CI/CD 构建等。

Webhook 的常见用途
Webhooks 在很多领域都得到了广泛应用，以下是一些典型的应用场景：

钉钉机器人：通过使用webhook实现各种事件订阅，让开发者应用程序即可接收到事件内容推送。
支付系统：支付平台（如 Stripe、PayPal）通常使用 Webhook 来通知商家支付状态的变化。当一个支付成功时，支付平台会触发 Webhook 通知商家进行订单更新或发货操作。
代码托管平台：像 GitHub 或 GitLab 这样的代码托管平台使用 Webhooks 来通知持续集成（CI）系统代码库的变化。例如，推送新的代码或创建拉取请求时，Webhooks 会触发自动化构建、测试或部署。
社交媒体平台：社交媒体应用（如 Twitter 或 Facebook）可能会使用 Webhooks 来推送实时更新。例如，当某个用户发布了新内容或有评论时，Webhooks 会通知其他系统进行处理。
聊天应用：像 Slack 或 Discord 这样的聊天平台允许通过 Webhooks 接收外部系统发送的消息，实时更新聊天频道中的内容。
如何实现 Webhook？
**实际开发中，要实现webhook往往更加复杂，需要做算法安全校验。

各大平台都会提供对应的工具包简化操作，按照对应文档即可快捷操作。

所以这里只是做一个简单demo展示接入流程，并不展示真实接入流程**

实现 Webhook 通常分为两个步骤：设置 Webhook URL 和配置事件触发器。

1. 设置 Webhook URL
接收方服务需要定义一个 Webhook 接口（URL），这个 URL 用于接收来自发送方系统的 HTTP 请求。通常，这个接口会解析 HTTP 请求中的数据，并根据业务需求进行处理。

2. 配置发送方
在发送方应用中（如 GitHub、Stripe 等），需要配置 Webhook。当事件发生时，系统会将相关数据通过 HTTP 请求发送到你设置的 Webhook URL。

以下是几个简单的 Webhook 示例，

下面代码展示了如何在 Python 环境中实现接收 Webhook 请求：

from flask import Flask, request

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.json
    print("Received webhook data:", data)
    # 处理数据，例如触发构建
    return 'OK', 200

if __name__ == '__main__':
    app.run(debug=True)
运行项目并下载源码

1
2
3
4
5
6
7
8
9
10
11
12
13
在这个示例中，Flask 用来构建一个简单的 HTTP 服务，接收来自其他应用的 POST 请求，并处理传递的 JSON 数据。

下面展示在node环境中使用 Express 来监听 Webhook 请求。

const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// 使用 bodyParser 中间件来解析 JSON 请求体
app.use(bodyParser.json());

// 定义 Webhook 路由
app.post('/webhook', (req, res) => {
  // 打印接收到的数据
  console.log('Received Webhook:', req.body);

  // 你可以根据接收到的数据执行相关操作
  // 例如：如果是支付成功的通知，更新订单状态
  if (req.body.event === 'payment_success') {
    console.log('Payment was successful!');
    // 在这里处理支付成功后的业务逻辑
  }

  // 响应 Webhook 请求，告诉发送方我们已成功接收
  res.status(200).send('OK');
});

// 启动服务
app.listen(port, () => {
  console.log(`Webhook server listening at http://localhost:${port}`);
});

运行项目并下载源码

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
这个应用会启动一个监听在 localhost:3000 的服务器，并在 /webhook 路径上接收 HTTP POST 请求。每当一个 Webhook 请求到达时，它会打印请求的内容，并根据数据执行某些逻辑。

4. 测试Webhool
假设你正在与一个外部服务（例如 钉钉机器人、GitHub 或其他）集成，这些服务会在特定事件发生时向你的 Webhook URL 发送 POST 请求。

Webhook 的安全性
为了防止恶意请求，通常需要对 Webhook 请求进行一些安全检查，比如验证签名或验证请求的来源 IP。

由于 Webhook 机制本身没有内建的身份验证和安全性保障，接收方需要采取额外的安全措施来保护 Webhook 请求不被滥用：

使用签名验证：发送方可以在 HTTP 请求头中附加签名，接收方则可以验证签名来确认请求的合法性。这种方式可以防止恶意攻击者伪造请求。
IP 地址白名单：为了防止来自不可信来源的请求，可以将发送方的 IP 地址加入白名单，只允许来自这些 IP 的 Webhook 请求。
验证数据：接收方还可以在处理 Webhook 数据时进行额外验证，确保数据的结构和内容是预期的，避免恶意篡改。
webhook缺点
大部分都是采用 Webhook （注册公网 HTTPS 服务）的方式，包括卡片回调，使用 Webhook 方式开发过程中会遇到较多的问题，包括

申请公网域名和TLS证书
申请公网IP并部署接入网关
部署应用防火墙并配置白名单
独立处理请求的鉴权，以及加解密处理
搭建内网穿透环境进行本地开发调试
针对以上问题，有的应用（例如钉钉）提供了stream模式，使用websocket（这种方式也有缺点）实现同样的操作配置Stream推送 - 钉钉开放平台

WebSocket 和 Webhook 各有优缺点，不能完全替代对方
————————————————
版权声明：本文为CSDN博主「red润」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_47658204/article/details/143819547