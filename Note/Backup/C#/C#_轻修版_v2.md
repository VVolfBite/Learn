# C# 学习笔记（Roadmap 填充版）

本笔记面向已学过 C# 但需要快速复习、重建知识体系的读者。目标是达到面试和工作入门水平。

---

## 第1章 入门基础

### 目录
1.1 C# 与 .NET 是什么  
1.2 开发环境、运行方式与第一个程序  
1.3 基本类型与变量  
1.4 控制流与基本语法  
1.5 方法与参数传递

---

## 1.1 C# 与 .NET 是什么

### 先建立直觉

很多人刚接触时会把 C# 和 .NET 混在一起说，但它们其实是两个东西：

- **C#** 是一门编程语言，就像 Java、Python 一样，你用它写代码
- **.NET** 是一个平台/运行时环境，负责把你写的 C# 代码跑起来

类比一下：C# 相当于"剧本"，.NET 相当于"剧院+演员+舞台"。你写完剧本（C# 代码），需要有个地方能演出来（.NET 运行时）。

### 它们解决什么问题


这一节看起来像一串要点，其实先理解“它们解决什么问题”想回答什么问题，会更容易把后面的结论用起来。

**C# 的设计目标：**
- 提供一门现代、类型安全、面向对象的语言
- 语法清晰，既能写桌面程序、Web 后端，也能写游戏（Unity）
- 在性能和开发效率之间取得平衡

**.NET 的设计目标：**
- 提供跨平台运行能力（Windows、Linux、macOS）
- 统一的类库和工具链
- 自动内存管理（垃圾回收）
- 支持多种语言（C#、F#、VB.NET 等）

### C#、.NET、CLR、SDK 之间的关系

这几个概念容易混，先这样理解就够了：

| 概念 | 是什么 | 作用 |
|------|--------|------|
| **C#** | 编程语言 | 你写代码用的语法规则 |
| **.NET** | 平台/生态系统 | 包含运行时、类库、工具的整体 |
| **CLR** | 公共语言运行时 | .NET 的核心引擎，负责执行编译后的代码 |
| **.NET SDK** | 开发工具包 | 包含编译器、命令行工具、类库，用来开发和构建程序 |

**简单流程：**
1. 你用 **C#** 写代码（`.cs` 文件）
2. 用 **.NET SDK** 里的编译器把代码编译成中间语言（IL）
3. 运行时，**CLR** 把 IL 翻译成机器码并执行

### 一个最小示例

```csharp
Console.WriteLine("Hello, C#!");
```

这就是一个完整的 C# 程序（使用了 C# 9.0+ 的顶级语句特性）。

保存为 `Program.cs`，在命令行执行：
```bash
dotnet run
```

就能看到输出：
```
Hello, C#!
```

### 初学者最容易混淆的问题


这一节看起来像一串要点，其实先理解“初学者最容易混淆的问题”想回答什么问题，会更容易把后面的结论用起来。

**1. .NET Framework vs .NET Core vs .NET 5/6/7/8**
- **.NET Framework**：老版本，只能在 Windows 上跑，最高到 4.8
- **.NET Core**：跨平台重写版本，从 1.0 到 3.1
- **.NET 5/6/7/8**：统一后的版本，直接叫 .NET，跨平台，现在主流用这个

现在说 ".NET" 通常指的是 .NET 5 及以后的版本。

**2. C# 版本 vs .NET 版本**
- C# 有自己的版本号（C# 7、8、9、10、11、12...）
- .NET 也有版本号（.NET 6、.NET 7、.NET 8...）
- 它们不是一一对应的，但通常新版 .NET 会支持新版 C#

**3. 编译型 vs 解释型**
C# 是编译型语言，但不是直接编译成机器码，而是：
- 先编译成 **IL**（中间语言）
- 运行时由 **CLR** 的 JIT 编译器翻译成机器码

这种方式叫"托管代码"，类似 Java 的字节码机制。

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- C# 是语言，.NET 是平台，CLR 是运行时引擎
- 现在主流用的是 .NET 6/7/8（跨平台），不是老的 .NET Framework
- C# 代码先编译成 IL，再由 CLR 的 JIT 编译成机器码执行
- .NET SDK 是开发工具包，包含编译器和命令行工具
- C# 可以写控制台程序、Web 后端、桌面应用、游戏（Unity）等
- .NET 提供了自动内存管理（GC），不需要手动释放内存

---

## 1.2 开发环境、运行方式与第一个程序

### 常见开发方式

学 C# 可以用的工具不少，先了解这几种：

| 工具 | 定位 | 适合场景 |
|------|------|----------|
| **Visual Studio** | 微软官方 IDE，功能最全 | Windows 开发，企业级项目，需要完整调试和设计器 |
| **Visual Studio Code** | 轻量编辑器 + 插件 | 跨平台，轻量开发，Web 后端，学习阶段 |
| **JetBrains Rider** | 专业跨平台 IDE | 跨平台，性能好，适合有 IntelliJ 系列使用经验的人 |
| **dotnet CLI** | 命令行工具 | 不依赖 IDE，脚本化构建，CI/CD，快速测试 |

**初学者建议：**
- Windows 用户：Visual Studio Community（免费）
- macOS/Linux 用户：VS Code + C# 插件
- 想快速上手命令行：直接用 `dotnet` CLI

### 一个 C# 程序从"写完"到"运行"的最小路径


读这一节时，先抓住“一个 C# 程序从"写完"到"运行"的最小路径”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**步骤：**
1. 安装 .NET SDK（从 https://dotnet.microsoft.com 下载）
2. 创建项目：`dotnet new console -n MyApp`
3. 进入目录：`cd MyApp`
4. 编辑 `Program.cs`
5. 运行：`dotnet run`

**背后发生了什么：**
- `dotnet new console`：创建一个控制台项目模板
- `dotnet run`：先编译（`dotnet build`），再执行生成的程序

### 控制台程序的基本结构

**传统写法（C# 9.0 之前）：**

```csharp
using System;

namespace MyApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}
```

**现代写法（C# 9.0+ 顶级语句）：**

```csharp
Console.WriteLine("Hello World!");
```

两种写法效果一样，编译器会自动把顶级语句包装成 `Main` 方法。

### Main 方法 / 顶级语句只讲到够用

**Main 方法的几种签名：**

```csharp
static void Main()                      // 无参数，无返回值
static void Main(string[] args)         // 接收命令行参数
static int Main()                       // 返回退出码
static int Main(string[] args)          // 接收参数 + 返回退出码
static async Task Main()                // 异步版本
static async Task<int> Main(string[] args)  // 异步 + 参数 + 返回值
```

**顶级语句：**
- C# 9.0 引入，简化入口代码
- 编译器自动生成 `Main` 方法
- 一个项目只能有一个文件使用顶级语句
- 适合快速写小程序、脚本

**容易混淆的点：**
- 顶级语句不是"没有 Main"，而是编译器帮你生成了
- 如果需要访问 `args`，顶级语句里直接用 `args` 变量即可
- 如果需要返回退出码，直接 `return 0;`

### 第一个程序示例

**示例1：接收命令行参数**

```csharp
if (args.Length > 0)
{
    Console.WriteLine($"你好，{args[0]}！");
}
else
{
    Console.WriteLine("你好，陌生人！");
}
```

运行：
```bash
dotnet run -- Alice
```

输出：
```
你好，Alice！
```

**示例2：返回退出码**

```csharp
if (args.Length == 0)
{
    Console.WriteLine("错误：缺少参数");
    return 1;  // 非零表示错误
}

Console.WriteLine($"处理参数：{args[0]}");
return 0;  // 0 表示成功
```

### 常见错误与混淆点


这一节如果直接从分点往下读，很容易只剩下结论。先把“常见错误与混淆点”放回当前主线里理解，后面的要点会更容易串起来。

**1. 找不到 dotnet 命令**
- 原因：没装 .NET SDK，或者没加到 PATH
- 解决：重新安装 SDK，确认 `dotnet --version` 能执行

**2. 项目里有多个 Main 方法**
- 错误信息：`Program has more than one entry point defined`
- 原因：多个文件都有 `Main` 方法或顶级语句
- 解决：只保留一个入口点，或在 `.csproj` 里指定 `<StartupObject>`

**3. 顶级语句和传统 Main 混用**
- 不能在同一个项目里既用顶级语句，又写 `Main` 方法
- 选一种风格统一使用

**4. Console.WriteLine 没输出**
- 可能是程序太快结束了，加个 `Console.ReadLine()` 暂停
- 或者检查是不是在 GUI 程序里调用（需要改成控制台程序）

**5. 中文乱码**
- Windows 老版本控制台可能不支持 UTF-8
- 在代码开头加：`Console.OutputEncoding = System.Text.Encoding.UTF8;`

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- .NET SDK 包含了编译器和 `dotnet` 命令行工具
- `dotnet new console` 创建控制台项目，`dotnet run` 编译并运行
- C# 9.0+ 可以用顶级语句简化入口代码，编译器会自动生成 `Main` 方法
- 命令行参数通过 `args` 数组访问，顶级语句里直接用 `args`
- 返回 `0` 表示程序成功，非零表示错误
- 一个项目只能有一个入口点（一个 `Main` 或一个顶级语句文件）

---

## 1.3 基本类型与变量

### 先把常用类型过一遍

C# 是强类型语言，变量必须先声明类型才能用。常用的基本类型分几类：

| 类型分类 | 类型 | 说明 | 示例 |
|---------|------|------|------|
| **整数** | `int` | 32位整数，最常用 | `int age = 25;` |
|  | `long` | 64位整数 | `long population = 8000000000L;` |
|  | `short` | 16位整数 | `short year = 2024;` |
|  | `byte` | 8位无符号整数 | `byte level = 255;` |
| **浮点数** | `double` | 64位双精度，默认浮点类型 | `double price = 99.99;` |
|  | `float` | 32位单精度，需要加 `f` 后缀 | `float rate = 0.05f;` |
|  | `decimal` | 128位高精度，金融计算用，需要加 `m` 后缀 | `decimal amount = 1234.56m;` |
| **字符与字符串** | `char` | 单个字符，用单引号 | `char grade = 'A';` |
|  | `string` | 字符串，用双引号 | `string name = "Alice";` |
| **布尔** | `bool` | 真或假 | `bool isActive = true;` |

### 变量声明的几种方式

```csharp
// 显式声明类型
int count = 10;
string message = "Hello";

// 使用 var 自动推断类型（C# 3.0+）
var age = 25;           // 推断为 int
var name = "Bob";       // 推断为 string
var price = 99.99;      // 推断为 double

// 常量
const double PI = 3.14159;
const string AppName = "MyApp";
```

**var 的使用原则：**
- 右边类型明显时可以用 `var`，提高可读性
- 右边类型不明显时最好显式写出类型
- `var` 不是动态类型，编译时就确定了类型，之后不能改

### 字符串插值与常用操作

```csharp
string firstName = "Zhang";
string lastName = "San";

// 字符串拼接
string fullName1 = firstName + " " + lastName;

// 字符串插值（推荐，C# 6.0+）
string fullName2 = $"{firstName} {lastName}";

// 多行字符串
string message = @"这是第一行
这是第二行
这是第三行";

// 常用方法
string text = "  Hello World  ";
text.Length;              // 15
text.Trim();              // "Hello World"
text.ToUpper();           // "  HELLO WORLD  "
text.Contains("World");   // true
text.Replace("World", "C#");  // "  Hello C#  "
```

### 可空类型

值类型默认不能为 `null`，如果需要表示"没有值"，要用可空类型：

```csharp
int age = null;        // 编译错误
int? age = null;       // 正确，int? 是 Nullable<int> 的简写

// 判断和取值
if (age.HasValue)
{
    Console.WriteLine(age.Value);
}

// 空合并运算符
int actualAge = age ?? 0;  // 如果 age 为 null，用 0

// 空条件运算符（C# 6.0+）
string? name = null;
int? length = name?.Length;  // name 为 null 时，length 也是 null
```

### 类型转换

```csharp
// 隐式转换（小范围到大范围）
int a = 100;
long b = a;        // int 自动转 long
double c = a;      // int 自动转 double

// 显式转换（可能丢失精度）
double x = 9.8;
int y = (int)x;    // y = 9，小数部分被截断

// 字符串转数字
string input = "123";
int num1 = int.Parse(input);           // 转换失败会抛异常
bool success = int.TryParse(input, out int num2);  // 转换失败返回 false

// 数字转字符串
int value = 42;
string str = value.ToString();
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. double vs decimal**
- `double` 是二进制浮点数，有精度误差，适合科学计算
- `decimal` 是十进制浮点数，精度高，适合金融计算
- 面试常问：为什么 `0.1 + 0.2` 不等于 `0.3`？因为二进制浮点数无法精确表示某些十进制小数

**2. string 是引用类型，但行为像值类型**
- `string` 是不可变的（immutable），每次修改都会创建新对象
- 大量字符串拼接用 `StringBuilder`，不要用 `+`

**3. var 不是 dynamic**
- `var` 是编译时确定类型，之后不能改
- `dynamic` 是运行时确定类型，可以随时改（一般不用）

**4. null 相关的常见错误**
- 值类型默认不能为 `null`，要用 `int?` 这种可空类型
- 引用类型默认可以为 `null`（C# 8.0+ 可以开启可空引用类型检查）

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- C# 是强类型语言，变量必须先声明类型
- `int` 是最常用的整数类型，`double` 是默认浮点类型
- 金融计算用 `decimal`，不要用 `double`，因为 `double` 有精度误差
- `var` 是编译时类型推断，不是动态类型，一旦确定就不能改
- 字符串插值 `$"{变量}"` 比 `+` 拼接更清晰
- `string` 是不可变的，大量拼接用 `StringBuilder`
- 值类型加 `?` 变成可空类型，如 `int?`
- `??` 是空合并运算符，`?.` 是空条件运算符

---

## 1.4 控制流与基本语法

### if / else

```csharp
int score = 85;

if (score >= 90)
{
    Console.WriteLine("优秀");
}
else if (score >= 60)
{
    Console.WriteLine("及格");
}
else
{
    Console.WriteLine("不及格");
}

// 三元运算符
string result = score >= 60 ? "及格" : "不及格";
```

### switch

**传统 switch：**

```csharp
int day = 3;
string dayName;

switch (day)
{
    case 1:
        dayName = "Monday";
        break;
    case 2:
        dayName = "Tuesday";
        break;
    case 3:
        dayName = "Wednesday";
        break;
    default:
        dayName = "Unknown";
        break;
}
```

**switch 表达式（C# 8.0+，推荐）：**

```csharp
string dayName = day switch
{
    1 => "Monday",
    2 => "Tuesday",
    3 => "Wednesday",
    _ => "Unknown"
};
```

### 循环

**for 循环：**

```csharp
for (int i = 0; i < 5; i++)
{
    Console.WriteLine(i);
}
```

**foreach 循环：**

```csharp
string[] names = { "Alice", "Bob", "Charlie" };

foreach (string name in names)
{
    Console.WriteLine(name);
}
```

**while 和 do-while：**

```csharp
int count = 0;
while (count < 3)
{
    Console.WriteLine(count);
    count++;
}

// do-while 至少执行一次
do
{
    Console.WriteLine("至少执行一次");
} while (false);
```

### break 和 continue

```csharp
for (int i = 0; i < 10; i++)
{
    if (i == 3) continue;  // 跳过本次循环
    if (i == 7) break;     // 跳出整个循环
    Console.WriteLine(i);
}
// 输出：0 1 2 4 5 6
```

### 模式匹配（C# 7.0+）

```csharp
object obj = "Hello";

// 类型模式
if (obj is string str)
{
    Console.WriteLine($"字符串长度：{str.Length}");
}

// switch 模式匹配
string result = obj switch
{
    int n => $"整数：{n}",
    string s => $"字符串：{s}",
    null => "空值",
    _ => "其他类型"
};
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. switch 必须有 break**
- 传统 switch 每个 case 必须有 `break` 或 `return`
- C# 不允许"贯穿"到下一个 case（和 C/C++ 不同）
- switch 表达式不需要 `break`，更简洁

**2. foreach 不能修改集合**
- `foreach` 遍历时不能添加或删除元素
- 如果需要修改，用 `for` 循环或 LINQ

**3. == vs Equals()**
- 值类型用 `==` 比较值
- 引用类型用 `==` 比较引用（地址）
- `string` 重写了 `==`，比较的是内容
- 自定义类型要重写 `Equals()` 和 `GetHashCode()`

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- `if` / `else if` / `else` 是最基本的条件判断
- switch 表达式（C# 8.0+）比传统 switch 更简洁，推荐使用
- `for` 适合已知次数的循环，`foreach` 适合遍历集合
- `break` 跳出循环，`continue` 跳过本次循环
- 模式匹配可以在 `if` 和 `switch` 中同时做类型判断和赋值
- `string` 用 `==` 比较内容，不需要用 `Equals()`

---

## 1.5 方法与参数传递

### 方法的基本结构

```csharp
// 访问修饰符 返回类型 方法名(参数列表)
public int Add(int a, int b)
{
    return a + b;
}

// 无返回值
public void PrintMessage(string message)
{
    Console.WriteLine(message);
}

// 表达式体方法（C# 6.0+）
public int Multiply(int a, int b) => a * b;
```

### 参数传递方式对比

这是面试高频考点，必须搞清楚：

| 传递方式 | 关键字 | 传递内容 | 能否修改原值 | 必须初始化 | 典型用途 |
|---------|--------|---------|------------|-----------|---------|
| **值传递** | 无 | 复制值 | 否 | 是 | 默认方式，最常用 |
| **引用传递** | `ref` | 传递引用 | 是 | 是 | 需要修改原变量 |
| **输出参数** | `out` | 传递引用 | 是 | 否（方法内必须赋值） | 返回多个值 |
| **只读引用** | `in` | 传递引用 | 否 | 是 | 大结构体只读传递，避免复制 |

### 值传递

```csharp
void Increment(int x)
{
    x++;  // 只修改副本，不影响原值
}

int num = 10;
Increment(num);
Console.WriteLine(num);  // 输出：10
```

### ref 引用传递

```csharp
void Increment(ref int x)
{
    x++;  // 修改原值
}

int num = 10;
Increment(ref num);  // 调用时必须加 ref
Console.WriteLine(num);  // 输出：11
```

**要点：**
- 调用时必须加 `ref` 关键字
- 传入前必须初始化
- 方法内可以读取和修改

### out 输出参数

```csharp
bool TryParse(string input, out int result)
{
    if (int.TryParse(input, out result))
    {
        return true;
    }
    result = 0;
    return false;
}

// 使用
if (TryParse("123", out int value))
{
    Console.WriteLine(value);  // 123
}

// C# 7.0+ 可以在调用时声明
if (int.TryParse("456", out var num))
{
    Console.WriteLine(num);  // 456
}
```

**要点：**
- 调用时必须加 `out` 关键字
- 传入前不需要初始化
- 方法内必须赋值
- 常用于返回多个值

### in 只读引用

```csharp
struct LargeStruct
{
    public int A, B, C, D, E;
}

// 避免复制大结构体
void Process(in LargeStruct data)
{
    Console.WriteLine(data.A);
    // data.A = 10;  // 编译错误，不能修改
}

LargeStruct s = new LargeStruct { A = 1 };
Process(in s);
```

**要点：**
- 传递引用但不允许修改
- 主要用于性能优化，避免复制大结构体
- 日常开发用得不多

### 可选参数与命名参数

```csharp
// 可选参数（必须有默认值，且放在最后）
void PrintInfo(string name, int age = 18, string city = "北京")
{
    Console.WriteLine($"{name}, {age}岁, {city}");
}

// 调用
PrintInfo("Alice");                    // Alice, 18岁, 北京
PrintInfo("Bob", 25);                  // Bob, 25岁, 北京
PrintInfo("Charlie", city: "上海");     // Charlie, 18岁, 上海（命名参数）
```

### 方法重载

```csharp
int Add(int a, int b) => a + b;
double Add(double a, double b) => a + b;
int Add(int a, int b, int c) => a + b + c;

// 编译器根据参数类型和数量选择合适的方法
Console.WriteLine(Add(1, 2));        // 调用第一个
Console.WriteLine(Add(1.5, 2.5));    // 调用第二个
Console.WriteLine(Add(1, 2, 3));     // 调用第三个
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. ref vs out**
- `ref` 传入前必须初始化，方法内可以不赋值
- `out` 传入前不需要初始化，方法内必须赋值
- 面试常问：什么时候用 `ref`，什么时候用 `out`？
  - `ref`：需要修改原值
  - `out`：需要返回多个值

**2. 值类型 vs 引用类型的参数传递**
- 值类型（int、struct）默认传递副本
- 引用类型（class、string）传递的是引用的副本
- 引用类型不加 `ref` 时，可以修改对象内容，但不能改变引用本身

```csharp
void ModifyArray(int[] arr)
{
    arr[0] = 100;  // 可以修改数组内容
    arr = new int[] { 1, 2, 3 };  // 不影响外部引用
}

int[] numbers = { 1, 2, 3 };
ModifyArray(numbers);
Console.WriteLine(numbers[0]);  // 输出：100
```

**3. 方法重载的规则**
- 参数数量不同
- 参数类型不同
- 参数顺序不同
- 只有返回值不同不算重载

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- 默认是值传递，传递的是副本，不影响原值
- `ref` 传递引用，可以修改原值，传入前必须初始化
- `out` 用于返回多个值，传入前不需要初始化，方法内必须赋值
- `in` 传递只读引用，主要用于避免复制大结构体
- 引用类型不加 `ref` 时，可以修改对象内容，但不能改变引用本身
- 可选参数必须有默认值，且放在参数列表最后
- 方法重载根据参数类型、数量、顺序区分，只有返回值不同不算重载

---
## 第2章 常用数据结构与集合

### 目录
2.1 数组与 List<T>  
2.2 Dictionary<TKey, TValue> 与 HashSet<T>  
2.3 Stack<T>、Queue<T> 与其他集合  
2.4 集合的遍历、查找与排序  
2.5 集合选型与面试常问

---

## 2.1 数组与 List<T>

### 数组的基本使用

数组是固定长度的，创建后不能改变大小：

```csharp
// 声明并初始化
int[] numbers = { 1, 2, 3, 4, 5 };
string[] names = new string[3];  // 创建长度为 3 的数组

// 访问元素
int first = numbers[0];
numbers[1] = 10;

// 获取长度
int length = numbers.Length;

// 多维数组
int[,] matrix = new int[3, 4];  // 3行4列
matrix[0, 0] = 1;

// 交错数组（数组的数组）
int[][] jagged = new int[3][];
jagged[0] = new int[] { 1, 2 };
jagged[1] = new int[] { 3, 4, 5 };
```

### List<T> 的基本使用

`List<T>` 是动态数组，可以自动扩容：

```csharp
// 创建
List<int> numbers = new List<int>();
List<string> names = new List<string> { "Alice", "Bob" };

// 添加元素
numbers.Add(1);
numbers.Add(2);
numbers.AddRange(new[] { 3, 4, 5 });

// 访问元素
int first = numbers[0];
numbers[1] = 10;

// 插入和删除
numbers.Insert(0, 0);      // 在索引 0 处插入
numbers.Remove(10);        // 删除第一个值为 10 的元素
numbers.RemoveAt(0);       // 删除索引 0 的元素
numbers.Clear();           // 清空

// 查找
bool contains = names.Contains("Alice");
int index = names.IndexOf("Bob");

// 获取数量
int count = names.Count;
```

### 数组 vs List<T>

| 特性 | 数组 | List<T> |
|------|------|---------|
| **长度** | 固定，创建后不能改变 | 动态，可以自动扩容 |
| **性能** | 访问快，内存连续 | 访问快，扩容时需要复制 |
| **API** | 基础，只有索引访问 | 丰富，有 Add、Remove、Find 等方法 |
| **适用场景** | 长度固定、性能敏感 | 长度不确定、需要频繁增删 |
| **初始化** | `int[] arr = {1,2,3};` | `List<int> list = new() {1,2,3};` |

### 常用操作示例

```csharp
List<int> numbers = new List<int> { 5, 2, 8, 1, 9 };

// 排序
numbers.Sort();  // 升序
numbers.Reverse();  // 反转

// 查找
int first = numbers.Find(x => x > 5);  // 找第一个大于 5 的
List<int> filtered = numbers.FindAll(x => x > 5);  // 找所有大于 5 的

// 判断
bool any = numbers.Any(x => x > 10);  // 是否有元素大于 10
bool all = numbers.All(x => x > 0);   // 是否所有元素都大于 0

// 转换
int[] array = numbers.ToArray();  // List 转数组
List<int> list = array.ToList();  // 数组转 List
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. 数组的 Length vs List 的 Count**
- 数组用 `Length` 属性
- List 用 `Count` 属性
- 都是获取元素数量，但名字不一样

**2. List 的扩容机制**
- 初始容量默认是 0，第一次添加时变成 4
- 每次扩容时容量翻倍
- 可以用 `Capacity` 属性查看当前容量
- 如果知道大概数量，可以用 `new List<int>(100)` 预分配容量

**3. 遍历时不能修改集合**
- `foreach` 遍历时不能添加或删除元素
- 如果需要修改，用 `for` 倒序遍历或先收集要删除的元素

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- 数组长度固定，`List<T>` 长度动态
- 工作中优先用 `List<T>`，除非有明确的性能要求
- 数组用 `Length`，List 用 `Count`
- `List<T>` 扩容时会复制所有元素，性能敏感时可以预分配容量
- `foreach` 遍历时不能修改集合，需要修改用 `for` 循环
- `ToArray()` 和 `ToList()` 可以在数组和 List 之间转换

---

## 2.2 Dictionary<TKey, TValue> 与 HashSet<T>

### Dictionary<TKey, TValue> 的基本使用

`Dictionary` 是键值对集合，通过键快速查找值：

```csharp
// 创建
Dictionary<string, int> ages = new Dictionary<string, int>();
Dictionary<int, string> names = new Dictionary<int, string>
{
    { 1, "Alice" },
    { 2, "Bob" }
};

// 添加
ages["Alice"] = 25;
ages["Bob"] = 30;
ages.Add("Charlie", 35);

// 访问
int aliceAge = ages["Alice"];  // 键不存在会抛异常

// 安全访问
if (ages.TryGetValue("David", out int davidAge))
{
    Console.WriteLine(davidAge);
}
else
{
    Console.WriteLine("不存在");
}

// 判断键是否存在
bool exists = ages.ContainsKey("Alice");

// 删除
ages.Remove("Bob");

// 遍历
foreach (var kvp in ages)
{
    Console.WriteLine($"{kvp.Key}: {kvp.Value}");
}

// 只遍历键或值
foreach (string name in ages.Keys) { }
foreach (int age in ages.Values) { }
```

### HashSet<T> 的基本使用

`HashSet` 是无序不重复集合，用于去重和集合运算：

```csharp
// 创建
HashSet<int> numbers = new HashSet<int> { 1, 2, 3 };

// 添加（重复元素会被忽略）
numbers.Add(4);
numbers.Add(2);  // 不会添加，返回 false

// 判断是否存在
bool contains = numbers.Contains(3);

// 删除
numbers.Remove(2);

// 集合运算
HashSet<int> set1 = new HashSet<int> { 1, 2, 3 };
HashSet<int> set2 = new HashSet<int> { 3, 4, 5 };

set1.UnionWith(set2);        // 并集：{1, 2, 3, 4, 5}
set1.IntersectWith(set2);    // 交集：{3}
set1.ExceptWith(set2);       // 差集：{1, 2}
```

### Dictionary vs HashSet

| 特性 | Dictionary<TKey, TValue> | HashSet<T> |
|------|-------------------------|-----------|
| **存储内容** | 键值对 | 单个值 |
| **是否有序** | 无序（插入顺序不保证） | 无序 |
| **是否重复** | 键不重复，值可以重复 | 不重复 |
| **查找性能** | O(1) | O(1) |
| **典型用途** | 映射关系、缓存、索引 | 去重、集合运算、快速查找 |

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. Dictionary 的键必须唯一**
- 用 `[]` 赋值时，键存在会覆盖，不存在会添加
- 用 `Add()` 时，键存在会抛异常
- 推荐用 `TryGetValue()` 安全访问

**2. Dictionary 和 HashSet 的键/值必须实现 GetHashCode 和 Equals**
- 基本类型（int、string）已经实现
- 自定义类型要重写这两个方法
- 否则会按引用比较，不是按内容比较

**3. Dictionary 不是线程安全的**
- 多线程访问需要加锁或用 `ConcurrentDictionary`

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- `Dictionary` 用于键值对映射，查找性能 O(1)
- `HashSet` 用于去重和集合运算，查找性能 O(1)
- Dictionary 的键必须唯一，推荐用 `TryGetValue()` 安全访问
- HashSet 自动去重，添加重复元素会被忽略
- 自定义类型作为键时，必须重写 `GetHashCode()` 和 `Equals()`
- Dictionary 和 HashSet 都不是线程安全的

---

## 2.3 Stack<T>、Queue<T> 与其他集合

### Stack<T>（栈）

后进先出（LIFO）：

```csharp
Stack<int> stack = new Stack<int>();

// 入栈
stack.Push(1);
stack.Push(2);
stack.Push(3);

// 出栈
int top = stack.Pop();  // 3，同时移除
int peek = stack.Peek();  // 2，不移除

// 判断
bool isEmpty = stack.Count == 0;
bool contains = stack.Contains(1);
```

### Queue<T>（队列）

先进先出（FIFO）：

```csharp
Queue<string> queue = new Queue<string>();

// 入队
queue.Enqueue("Alice");
queue.Enqueue("Bob");
queue.Enqueue("Charlie");

// 出队
string first = queue.Dequeue();  // "Alice"，同时移除
string peek = queue.Peek();      // "Bob"，不移除

// 判断
bool isEmpty = queue.Count == 0;
```

### 其他常用集合

| 集合类型 | 特点 | 典型用途 |
|---------|------|---------|
| **LinkedList<T>** | 双向链表，插入删除快 | 频繁在中间插入删除 |
| **SortedDictionary<TKey, TValue>** | 按键排序的字典 | 需要有序的键值对 |
| **SortedSet<T>** | 有序不重复集合 | 需要有序且去重 |
| **ConcurrentDictionary<TKey, TValue>** | 线程安全的字典 | 多线程环境 |

### Stack vs Queue

| 特性 | Stack<T> | Queue<T> |
|------|---------|---------|
| **顺序** | 后进先出（LIFO） | 先进先出（FIFO） |
| **添加** | `Push()` | `Enqueue()` |
| **移除** | `Pop()` | `Dequeue()` |
| **查看** | `Peek()` | `Peek()` |
| **典型场景** | 撤销操作、递归模拟、括号匹配 | 任务队列、BFS、消息队列 |

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. Pop/Dequeue vs Peek**
- `Pop()` / `Dequeue()`：移除并返回元素
- `Peek()`：只查看不移除
- 空集合调用会抛异常，使用前先判断 `Count > 0`

**2. LinkedList 不是 List**
- `LinkedList<T>` 是双向链表，不支持索引访问
- 要用 `AddFirst()` / `AddLast()` / `AddBefore()` / `AddAfter()`
- 工作中用得不多，除非有明确的性能需求

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- `Stack<T>` 是后进先出（LIFO），用 `Push()` 和 `Pop()`
- `Queue<T>` 是先进先出（FIFO），用 `Enqueue()` 和 `Dequeue()`
- `Peek()` 只查看不移除，`Pop()` / `Dequeue()` 移除并返回
- Stack 适合撤销操作、递归模拟，Queue 适合任务队列、消息队列
- `LinkedList<T>` 是双向链表，不支持索引访问，工作中用得少

---

## 2.4 集合的遍历、查找与排序

### 遍历方式

```csharp
List<int> numbers = new List<int> { 1, 2, 3, 4, 5 };

// foreach（最常用）
foreach (int num in numbers)
{
    Console.WriteLine(num);
}

// for（需要索引时）
for (int i = 0; i < numbers.Count; i++)
{
    Console.WriteLine($"{i}: {numbers[i]}");
}

// ForEach 方法
numbers.ForEach(num => Console.WriteLine(num));

// LINQ 遍历
numbers.Where(x => x > 2).ToList().ForEach(Console.WriteLine);
```

### 查找

```csharp
List<string> names = new List<string> { "Alice", "Bob", "Charlie", "David" };

// 判断是否存在
bool exists = names.Contains("Alice");
bool any = names.Any(x => x.StartsWith("A"));

// 查找单个
string first = names.Find(x => x.Length > 3);  // "Alice"
string last = names.FindLast(x => x.Length > 3);  // "David"
int index = names.FindIndex(x => x == "Bob");  // 1

// 查找多个
List<string> filtered = names.FindAll(x => x.Length > 3);

// LINQ 查找
var result = names.Where(x => x.Length > 3).ToList();
var firstOrDefault = names.FirstOrDefault(x => x.StartsWith("Z"));  // null
```

### 排序

```csharp
List<int> numbers = new List<int> { 5, 2, 8, 1, 9 };

// 升序排序
numbers.Sort();  // {1, 2, 5, 8, 9}

// 降序排序
numbers.Sort((a, b) => b.CompareTo(a));
// 或
numbers.Sort();
numbers.Reverse();

// LINQ 排序（不修改原集合）
var sorted = numbers.OrderBy(x => x).ToList();
var descending = numbers.OrderByDescending(x => x).ToList();

// 自定义对象排序
List<Student> students = new List<Student>
{
    new Student { Name = "Alice", Age = 20 },
    new Student { Name = "Bob", Age = 18 }
};

// 按年龄排序
students.Sort((a, b) => a.Age.CompareTo(b.Age));
// 或用 LINQ
var sorted = students.OrderBy(s => s.Age).ToList();

// 多字段排序
var sorted = students.OrderBy(s => s.Age).ThenBy(s => s.Name).ToList();
```

### 常用 LINQ 方法

```csharp
List<int> numbers = new List<int> { 1, 2, 3, 4, 5 };

// 过滤
var filtered = numbers.Where(x => x > 2);  // {3, 4, 5}

// 映射
var doubled = numbers.Select(x => x * 2);  // {2, 4, 6, 8, 10}

// 聚合
int sum = numbers.Sum();
int max = numbers.Max();
int min = numbers.Min();
double avg = numbers.Average();
int count = numbers.Count(x => x > 2);

// 去重
var distinct = numbers.Distinct();

// 跳过和获取
var skipped = numbers.Skip(2);  // {3, 4, 5}
var taken = numbers.Take(3);    // {1, 2, 3}
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. Find vs FirstOrDefault**
- `Find()` 是 List 的方法，找不到返回默认值（引用类型是 null）
- `FirstOrDefault()` 是 LINQ 方法，找不到返回默认值
- 功能类似，但 LINQ 更通用

**2. Sort() vs OrderBy()**
- `Sort()` 修改原集合
- `OrderBy()` 返回新集合，不修改原集合
- 面试常问：什么时候用哪个？
  - 需要修改原集合用 `Sort()`
  - 不想修改原集合用 `OrderBy()`

**3. ToList() 的时机**
- LINQ 是延迟执行的，不调用 `ToList()` 不会立即执行
- 如果需要立即执行或多次使用结果，要调用 `ToList()`

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- `foreach` 最常用，`for` 适合需要索引的场景
- `Find()` 查找单个，`FindAll()` 查找多个
- `Sort()` 修改原集合，`OrderBy()` 返回新集合
- LINQ 是延迟执行的，调用 `ToList()` 才会立即执行
- `FirstOrDefault()` 找不到返回默认值，不会抛异常
- 多字段排序用 `OrderBy().ThenBy()`

---

## 2.5 集合选型与面试常问

### 集合选型速查表

| 需求 | 推荐集合 | 理由 |
|------|---------|------|
| 动态数组，按索引访问 | `List<T>` | 最常用，性能好 |
| 键值对映射 | `Dictionary<TKey, TValue>` | O(1) 查找 |
| 去重 | `HashSet<T>` | 自动去重，O(1) 查找 |
| 后进先出 | `Stack<T>` | 撤销操作、递归模拟 |
| 先进先出 | `Queue<T>` | 任务队列、消息队列 |
| 有序且去重 | `SortedSet<T>` | 自动排序 |
| 有序键值对 | `SortedDictionary<TKey, TValue>` | 按键排序 |
| 线程安全字典 | `ConcurrentDictionary<TKey, TValue>` | 多线程环境 |
| 固定长度 | 数组 | 性能最优 |

### 面试高频问题


这一节如果直接从分点往下读，很容易只剩下结论。先把“面试高频问题”放回当前主线里理解，后面的要点会更容易串起来。

**1. List vs 数组，什么时候用哪个？**
- 长度不确定、需要频繁增删：用 `List<T>`
- 长度固定、性能敏感：用数组
- 工作中 90% 的情况用 `List<T>`

**2. Dictionary 的查找为什么是 O(1)？**
- 基于哈希表实现
- 通过键的哈希值快速定位到桶（bucket）
- 哈希冲突时用链表或红黑树解决

**3. HashSet 和 List 去重的区别？**
- `HashSet` 自动去重，O(1) 查找
- `List` 需要手动去重（`Distinct()`），O(n) 查找
- 需要去重时优先用 `HashSet`

**4. 什么时候用 Stack，什么时候用 Queue？**
- Stack：后进先出，撤销操作、递归模拟、括号匹配
- Queue：先进先出，任务队列、BFS、消息队列

**5. LINQ 的性能怎么样？**
- LINQ 是延迟执行的，不调用 `ToList()` 不会立即执行
- 性能略低于手写循环，但差距不大
- 工作中优先用 LINQ，代码更清晰
- 性能敏感的地方可以手写循环

**6. 如何选择合适的集合？**
- 先看是否需要键值对：是 → `Dictionary`，否 → 继续
- 是否需要去重：是 → `HashSet`，否 → 继续
- 是否需要有序：是 → `SortedSet` / `SortedDictionary`，否 → 继续
- 是否需要 LIFO/FIFO：是 → `Stack` / `Queue`，否 → `List`

### 本章高频判断


这一节看起来像一串要点，其实先理解“本章高频判断”想回答什么问题，会更容易把后面的结论用起来。

- 工作中最常用的是 `List<T>` 和 `Dictionary<TKey, TValue>`
- `List<T>` 是动态数组，数组是固定长度
- `Dictionary` 和 `HashSet` 查找性能都是 O(1)
- `HashSet` 自动去重，`List` 需要手动去重
- `Stack` 是 LIFO，`Queue` 是 FIFO
- LINQ 是延迟执行的，调用 `ToList()` 才会立即执行
- 自定义类型作为 Dictionary 的键时，必须重写 `GetHashCode()` 和 `Equals()`
- 集合选型优先考虑：是否需要键值对、是否需要去重、是否需要有序
- `Sort()` 修改原集合，`OrderBy()` 返回新集合
- 多线程环境用 `ConcurrentDictionary`，不要用普通 `Dictionary`

---

## 第3章 面向对象与类型系统

### 目录
3.1 类与对象  
3.2 字段、属性、方法、构造函数  
3.3 封装、继承、多态  
3.4 抽象类与接口  
3.5 值类型与引用类型  
3.6 struct / class / record 与访问修饰符

---

## 3.1 类与对象

### 先理解类和对象的关系

- **类（Class）**：是对象的模板或蓝图，定义了对象的结构和行为
- **对象（Object）**：是类的实例，是具体存在的实体

类比：类就像建筑图纸，对象就是按图纸建造出来的房子。

### 定义一个类

```csharp
public class Student
{
    // 字段
    private string name;
    private int age;
    
    // 构造函数
    public Student(string name, int age)
    {
        this.name = name;
        this.age = age;
    }
    
    // 方法
    public void Study()
    {
        Console.WriteLine($"{name} 正在学习");
    }
}
```

### 创建和使用对象

```csharp
// 创建对象
Student student1 = new Student("Alice", 20);
Student student2 = new Student("Bob", 22);

// 调用方法
student1.Study();  // 输出：Alice 正在学习
student2.Study();  // 输出：Bob 正在学习
```

### this 关键字

`this` 代表当前对象实例：

```csharp
public class Person
{
    private string name;
    
    public Person(string name)
    {
        this.name = name;  // this.name 是字段，name 是参数
    }
    
    public void PrintName()
    {
        Console.WriteLine(this.name);  // this 可以省略
    }
}
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. 类 vs 对象**
- 类是模板，对象是实例
- 一个类可以创建多个对象
- 每个对象有自己独立的数据

**2. new 关键字的作用**
- 在堆上分配内存
- 调用构造函数初始化对象
- 返回对象的引用

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- 类是对象的模板，对象是类的实例
- 使用 `new` 关键字创建对象
- `this` 代表当前对象实例
- 每个对象有自己独立的字段值
- 类定义了对象的结构和行为

---

## 3.2 字段、属性、方法、构造函数

### 字段（Field）

字段是类的成员变量，存储对象的状态：

```csharp
public class Car
{
    // 字段通常是 private
    private string brand;
    private int speed;
}
```

### 属性（Property）

属性提供对字段的受控访问：

```csharp
public class Car
{
    private string brand;
    
    // 完整属性
    public string Brand
    {
        get { return brand; }
        set { brand = value; }
    }
    
    // 自动属性（C# 3.0+）
    public int Speed { get; set; }
    
    // 只读属性
    public string Model { get; }
    
    // 只写属性（少见）
    public string Password { set; }
    
    // 属性初始化器（C# 6.0+）
    public string Color { get; set; } = "White";
}
```

### 字段 vs 属性

| 特性 | 字段 | 属性 |
|------|------|------|
| **访问控制** | 直接访问 | 通过 get/set 访问 |
| **封装性** | 较差 | 较好 |
| **验证** | 不能 | 可以在 set 中验证 |
| **命名约定** | 小写开头或下划线 | 大写开头 |
| **推荐用法** | 内部使用 | 对外暴露 |

### 方法（Method）

方法定义对象的行为：

```csharp
public class Calculator
{
    // 实例方法
    public int Add(int a, int b)
    {
        return a + b;
    }
    
    // 静态方法
    public static int Multiply(int a, int b)
    {
        return a * b;
    }
    
    // 表达式体方法
    public int Subtract(int a, int b) => a - b;
}

// 使用
Calculator calc = new Calculator();
int sum = calc.Add(1, 2);              // 实例方法
int product = Calculator.Multiply(3, 4);  // 静态方法
```

### 构造函数（Constructor）

构造函数用于初始化对象：

```csharp
public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
    
    // 默认构造函数
    public Person()
    {
        Name = "Unknown";
        Age = 0;
    }
    
    // 带参数的构造函数
    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }
    
    // 构造函数链（调用其他构造函数）
    public Person(string name) : this(name, 0)
    {
    }
}
```

### 对象初始化器

```csharp
// 传统方式
Person p1 = new Person();
p1.Name = "Alice";
p1.Age = 20;

// 对象初始化器（C# 3.0+）
Person p2 = new Person
{
    Name = "Alice",
    Age = 20
};

// C# 9.0+ 目标类型 new
Person p3 = new()
{
    Name = "Alice",
    Age = 20
};
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. 字段 vs 属性**
- 字段是变量，属性是方法（get/set）
- 对外暴露用属性，内部使用用字段
- 自动属性会自动生成私有字段

**2. 实例成员 vs 静态成员**
- 实例成员属于对象，需要创建对象才能访问
- 静态成员属于类，通过类名访问
- 静态成员在所有对象间共享

**3. 构造函数的特点**
- 方法名与类名相同
- 没有返回类型
- 可以重载
- 如果不写，编译器会生成默认构造函数

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- 字段存储数据，属性提供受控访问，方法定义行为
- 对外暴露用属性，不要直接暴露字段
- 自动属性 `{ get; set; }` 会自动生成私有字段
- 构造函数用于初始化对象，方法名与类名相同
- 静态成员属于类，实例成员属于对象
- 对象初始化器可以简化对象创建代码

---

## 3.3 封装、继承、多态

### 封装（Encapsulation）

封装是隐藏内部实现细节，只暴露必要的接口：

```csharp
public class BankAccount
{
    private decimal balance;  // 私有字段，外部不能直接访问
    
    public decimal Balance    // 公开属性，只读
    {
        get { return balance; }
    }
    
    public void Deposit(decimal amount)
    {
        if (amount > 0)
        {
            balance += amount;
        }
    }
    
    public bool Withdraw(decimal amount)
    {
        if (amount > 0 && amount <= balance)
        {
            balance -= amount;
            return true;
        }
        return false;
    }
}
```

**封装的好处：**
- 保护数据不被随意修改
- 可以在方法中添加验证逻辑
- 修改内部实现不影响外部代码

### 继承（Inheritance）

继承允许创建新类（子类）来扩展现有类（父类）：

```csharp
// 父类
public class Animal
{
    public string Name { get; set; }
    
    public void Eat()
    {
        Console.WriteLine($"{Name} 正在吃东西");
    }
}

// 子类
public class Dog : Animal
{
    public void Bark()
    {
        Console.WriteLine($"{Name} 正在叫：汪汪汪");
    }
}

// 使用
Dog dog = new Dog { Name = "旺财" };
dog.Eat();   // 继承自 Animal
dog.Bark();  // Dog 自己的方法
```

### 方法重写（Override）

子类可以重写父类的虚方法：

```csharp
public class Animal
{
    public virtual void MakeSound()  // virtual 表示可以被重写
    {
        Console.WriteLine("动物发出声音");
    }
}

public class Dog : Animal
{
    public override void MakeSound()  // override 重写父类方法
    {
        Console.WriteLine("汪汪汪");
    }
}

public class Cat : Animal
{
    public override void MakeSound()
    {
        Console.WriteLine("喵喵喵");
    }
}
```

### 多态（Polymorphism）

多态允许用父类引用指向子类对象：

```csharp
Animal animal1 = new Dog();
Animal animal2 = new Cat();

animal1.MakeSound();  // 输出：汪汪汪
animal2.MakeSound();  // 输出：喵喵喵

// 多态的典型应用
Animal[] animals = { new Dog(), new Cat(), new Dog() };
foreach (Animal animal in animals)
{
    animal.MakeSound();  // 根据实际类型调用对应方法
}
```

### base 关键字

`base` 用于访问父类成员：

```csharp
public class Employee
{
    public string Name { get; set; }
    
    public virtual decimal GetSalary()
    {
        return 5000;
    }
}

public class Manager : Employee
{
    public override decimal GetSalary()
    {
        return base.GetSalary() + 3000;  // 调用父类方法
    }
}
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. virtual vs override vs new**
- `virtual`：父类方法，表示可以被重写
- `override`：子类方法，重写父类虚方法
- `new`：子类方法，隐藏父类方法（不推荐）

**2. 继承 vs 组合**
- 继承：is-a 关系（Dog is an Animal）
- 组合：has-a 关系（Car has an Engine）
- 优先使用组合，继承要慎用

**3. 多态的实现条件**
- 父类方法必须是 `virtual` 或 `abstract`
- 子类方法必须用 `override`
- 用父类引用指向子类对象

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- 封装是隐藏实现细节，只暴露必要接口
- 继承是 is-a 关系，子类继承父类的成员
- C# 只支持单继承，一个类只能继承一个父类
- `virtual` 表示方法可以被重写，`override` 重写父类方法
- 多态允许用父类引用指向子类对象，调用时根据实际类型执行
- `base` 用于访问父类成员

---

## 3.4 抽象类与接口

### 抽象类（Abstract Class）

抽象类不能实例化，只能被继承：

```csharp
public abstract class Shape
{
    public string Color { get; set; }
    
    // 抽象方法（没有实现）
    public abstract double GetArea();
    
    // 普通方法（有实现）
    public void Display()
    {
        Console.WriteLine($"这是一个{Color}的图形");
    }
}

public class Circle : Shape
{
    public double Radius { get; set; }
    
    // 必须实现抽象方法
    public override double GetArea()
    {
        return Math.PI * Radius * Radius;
    }
}

// 使用
Shape shape = new Circle { Color = "红色", Radius = 5 };
shape.Display();
Console.WriteLine(shape.GetArea());
```

### 接口（Interface）

接口定义契约，类实现接口必须实现所有成员：

```csharp
public interface IFlyable
{
    void Fly();
    int MaxSpeed { get; }
}

public interface ISwimmable
{
    void Swim();
}

// 实现接口
public class Duck : IFlyable, ISwimmable
{
    public int MaxSpeed => 50;
    
    public void Fly()
    {
        Console.WriteLine("鸭子在飞");
    }
    
    public void Swim()
    {
        Console.WriteLine("鸭子在游泳");
    }
}
```

### 抽象类 vs 接口

| 特性 | 抽象类 | 接口 |
|------|--------|------|
| **实例化** | 不能 | 不能 |
| **继承数量** | 单继承 | 多实现 |
| **成员类型** | 字段、属性、方法、构造函数 | 属性、方法、事件（C# 8.0+ 可有默认实现） |
| **访问修饰符** | 可以有 | 默认 public |
| **实现** | 可以有实现 | 传统上没有实现（C# 8.0+ 可有默认实现） |
| **使用场景** | is-a 关系，共享代码 | can-do 关系，定义能力 |

### 接口的典型应用

```csharp
// 定义接口
public interface IRepository<T>
{
    void Add(T item);
    void Remove(T item);
    T GetById(int id);
    List<T> GetAll();
}

// 实现接口
public class UserRepository : IRepository<User>
{
    private List<User> users = new List<User>();
    
    public void Add(User item)
    {
        users.Add(item);
    }
    
    public void Remove(User item)
    {
        users.Remove(item);
    }
    
    public User GetById(int id)
    {
        return users.Find(u => u.Id == id);
    }
    
    public List<User> GetAll()
    {
        return users;
    }
}
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. 什么时候用抽象类，什么时候用接口？**
- 抽象类：有共同的实现代码，is-a 关系
- 接口：定义能力，can-do 关系，支持多实现
- 面试常问：优先用接口，因为更灵活

**2. 接口的命名约定**
- 接口名通常以 `I` 开头，如 `IComparable`、`IDisposable`
- 这是 C# 的约定，不是强制要求

**3. C# 8.0+ 接口默认实现**
- 接口可以有默认实现
- 但实现类不能直接调用，需要转换为接口类型

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- 抽象类不能实例化，只能被继承
- 抽象方法没有实现，子类必须重写
- 接口定义契约，类实现接口必须实现所有成员
- C# 支持单继承但支持多接口实现
- 抽象类用于 is-a 关系，接口用于 can-do 关系
- 接口名通常以 `I` 开头
- 优先使用接口，因为更灵活

---
## 3.5 值类型与引用类型

### 先理解两者的区别

这是 C# 中最重要的概念之一，面试高频考点。

**值类型（Value Type）：**
- 存储在栈上
- 直接包含数据
- 赋值时复制整个值
- 包括：基本类型（int、double、bool等）、struct、enum

**引用类型（Reference Type）：**
- 对象存储在堆上，变量存储引用（地址）
- 赋值时复制引用，不复制对象
- 包括：class、interface、delegate、string、数组

### 值类型 vs 引用类型

| 特性 | 值类型 | 引用类型 |
|------|--------|---------|
| **存储位置** | 栈 | 堆（引用在栈上） |
| **赋值行为** | 复制值 | 复制引用 |
| **默认值** | 0、false 等 | null |
| **性能** | 较快（栈分配） | 较慢（堆分配+GC） |
| **继承** | 不能继承（除了 object） | 可以继承 |
| **null** | 不能为 null（除非用 `?`） | 可以为 null |

### 赋值行为对比

```csharp
// 值类型
int a = 10;
int b = a;  // 复制值
b = 20;
Console.WriteLine(a);  // 输出：10（a 不受影响）

// 引用类型
class Person
{
    public string Name { get; set; }
}

Person p1 = new Person { Name = "Alice" };
Person p2 = p1;  // 复制引用，指向同一个对象
p2.Name = "Bob";
Console.WriteLine(p1.Name);  // 输出：Bob（p1 受影响）
```

### 装箱（Boxing）与拆箱（Unboxing）

**装箱：**值类型转换为引用类型

```csharp
int num = 123;
object obj = num;  // 装箱：在堆上创建对象，复制值
```

**拆箱：**引用类型转换为值类型

```csharp
object obj = 123;
int num = (int)obj;  // 拆箱：从堆上复制值到栈
```

**性能影响：**
- 装箱和拆箱都有性能开销
- 频繁装箱拆箱会影响性能
- 使用泛型可以避免装箱拆箱

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. string 是引用类型，但行为像值类型**
- `string` 是引用类型，存储在堆上
- 但 `string` 是不可变的（immutable）
- 修改字符串会创建新对象，不影响原对象

```csharp
string s1 = "Hello";
string s2 = s1;
s2 = "World";
Console.WriteLine(s1);  // 输出：Hello（s1 不受影响）
```

**2. 数组是引用类型**
- 即使是 `int[]`，数组本身也是引用类型
- 数组对象存储在堆上

**3. 值类型也可以为 null**
- 使用可空类型：`int?`、`bool?` 等
- 可空类型实际上是 `Nullable<T>` 结构体

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- 值类型存储在栈上，引用类型存储在堆上
- 值类型赋值复制值，引用类型赋值复制引用
- 基本类型、struct、enum 是值类型
- class、interface、delegate、string、数组是引用类型
- 装箱是值类型转引用类型，拆箱是引用类型转值类型
- 装箱拆箱有性能开销，使用泛型可以避免
- `string` 是引用类型但不可变，行为像值类型

---

## 3.6 struct / class / record 与访问修饰符

### struct（结构体）

struct 是值类型，适合小型、简单的数据结构：

```csharp
public struct Point
{
    public int X { get; set; }
    public int Y { get; set; }
    
    public Point(int x, int y)
    {
        X = x;
        Y = y;
    }
    
    public double DistanceFromOrigin()
    {
        return Math.Sqrt(X * X + Y * Y);
    }
}

// 使用
Point p1 = new Point(3, 4);
Point p2 = p1;  // 复制值
p2.X = 10;
Console.WriteLine(p1.X);  // 输出：3（p1 不受影响）
```

### class（类）

class 是引用类型，最常用的类型：

```csharp
public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
    
    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }
}
```

### record（记录类型，C# 9.0+）

record 是引用类型，专为不可变数据设计：

```csharp
// 简洁语法
public record Person(string Name, int Age);

// 等价于
public record Person
{
    public string Name { get; init; }
    public int Age { get; init; }
    
    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }
}

// 使用
Person p1 = new Person("Alice", 20);
Person p2 = p1 with { Age = 21 };  // 创建副本并修改
Console.WriteLine(p1.Age);  // 输出：20
Console.WriteLine(p2.Age);  // 输出：21
```

### struct vs class vs record

| 特性 | struct | class | record |
|------|--------|-------|--------|
| **类型** | 值类型 | 引用类型 | 引用类型 |
| **存储位置** | 栈 | 堆 | 堆 |
| **赋值行为** | 复制值 | 复制引用 | 复制引用 |
| **继承** | 不能继承类 | 可以继承 | 可以继承 record |
| **可变性** | 可变 | 可变 | 推荐不可变 |
| **相等比较** | 按值比较 | 按引用比较 | 按值比较 |
| **适用场景** | 小型数据结构 | 一般对象 | 不可变数据 |

### 访问修饰符

| 修饰符 | 访问范围 | 典型用途 |
|--------|---------|---------|
| `public` | 任何地方 | 对外公开的 API |
| `private` | 当前类内部 | 内部实现细节 |
| `protected` | 当前类及子类 | 允许子类访问 |
| `internal` | 当前程序集 | 同一项目内部使用 |
| `protected internal` | 当前程序集或子类 | 组合访问 |
| `private protected` | 当前程序集的子类 | 更严格的保护 |

### 访问修饰符示例

```csharp
public class BankAccount
{
    private decimal balance;           // 只能在类内部访问
    protected string accountNumber;    // 子类可以访问
    internal string bankName;          // 同一程序集可以访问
    public string OwnerName { get; set; }  // 任何地方都可以访问
    
    public void Deposit(decimal amount)
    {
        if (amount > 0)
        {
            balance += amount;  // 可以访问 private 成员
        }
    }
}
```

### 容易混淆的点


读这一节时，先抓住“容易混淆的点”在整章里的位置，再看后面的分点，会比单独记条目更稳。

**1. struct 的限制**
- struct 不能有无参构造函数（C# 10 之前）
- struct 不能继承其他 struct 或 class
- struct 的字段必须在构造函数中初始化

**2. record 的特点**
- record 自动实现值相等比较
- record 支持 `with` 表达式创建副本
- record 推荐使用 `init` 而不是 `set`

**3. 什么时候用 struct？**
- 数据量小（通常小于 16 字节）
- 逻辑上表示单个值
- 不需要继承
- 不会频繁装箱

**4. 默认访问修饰符**
- 类成员默认是 `private`
- 类本身默认是 `internal`
- 接口成员默认是 `public`

### 本节高频判断


读这一节时，先抓住“本节高频判断”在整章里的位置，再看后面的分点，会比单独记条目更稳。

- struct 是值类型，class 和 record 是引用类型
- struct 适合小型数据结构，class 适合一般对象，record 适合不可变数据
- record 自动实现值相等比较，支持 `with` 表达式
- `public` 任何地方可访问，`private` 只能类内部访问
- `protected` 子类可访问，`internal` 同一程序集可访问
- 类成员默认 `private`，类本身默认 `internal`
- struct 不能继承类，但可以实现接口

---

## 本章高频判断


这一节看起来像一串要点，其实先理解“本章高频判断”想回答什么问题，会更容易把后面的结论用起来。

- 类是对象的模板，对象是类的实例
- 字段存储数据，属性提供受控访问，方法定义行为
- 封装隐藏实现，继承扩展功能，多态实现灵活调用
- 抽象类用于 is-a 关系，接口用于 can-do 关系
- C# 支持单继承但支持多接口实现
- 值类型存储在栈上，引用类型存储在堆上
- 值类型赋值复制值，引用类型赋值复制引用
- struct 是值类型，class 和 record 是引用类型
- record 适合不可变数据，自动实现值相等比较
- `public` 公开访问，`private` 私有访问，`protected` 子类访问，`internal` 程序集内访问

---
