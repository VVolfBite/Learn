# C# 学习笔记

本笔记面向已学过 C# 但需要快速复习的读者。目标是重建知识体系，达到面试和工作入门水平。

## 入门基础

### C# 与 .NET

很多人会把 C# 和 .NET 混在一起说，但它们是两个东西：C# 是编程语言（你写代码用的），.NET 是平台（负责把代码跑起来的）。类比一下，C# 是剧本，.NET 是剧院。

这几个概念容易混：

| 概念         | 是什么         | 作用                     |
| ------------ | -------------- | ------------------------ |
| **C#**       | 编程语言       | 写代码用的语法规则       |
| **.NET**     | 平台/生态      | 运行时、类库、工具的整体 |
| **CLR**      | 公共语言运行时 | 执行编译后代码的引擎     |
| **.NET SDK** | 开发工具包     | 编译器、命令行工具、类库 |

简单流程：你用C#写代码（`.cs`文件）→ SDK编译成中间语言（IL）→ CLR把IL翻译成机器码执行。这种方式叫"托管代码"，类似Java的字节码机制。

刚开始学 C# 时，还有一组特别容易被忽略、但看别人代码时绕不过去的词：`using`、`namespace`、`class`、`Main`。它们不是“额外语法”，而是在告诉你这个程序是怎么组织起来的。菜鸟教程在程序结构和命名空间部分会把这些点单独拿出来讲，本质上就是在帮初学者先看懂骨架：`using` 决定当前文件默认可以直接使用哪些命名空间中的类型，`namespace` 负责给类型分组、避免重名，`class` 是大多数 C# 代码的基本组织单位，而 `Main` 或顶级语句则是程序入口。([runoob.com](https://www.runoob.com/csharp/csharp-program-structure.html?utm_source=chatgpt.com)) ([runoob.com](https://www.runoob.com/csharp/csharp-namespace.html?utm_source=chatgpt.com))

可以先把这几样东西理解成“代码的外壳”：

| 结构              | 先这样理解就够了                             |
| ----------------- | -------------------------------------------- |
| `using`           | 告诉编译器：后面我会用到某个命名空间里的类型 |
| `namespace`       | 给类型分组，避免不同模块下的同名类冲突       |
| `class`           | 把数据和行为组织在一起的基本单位             |
| `Main` / 顶级语句 | 程序从哪里开始执行                           |

例如下面这段代码，重点不在业务逻辑，而在“骨架”怎么读：

```csharp
using System;

namespace DemoApp;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello, C#!");
    }
}
```

用顶级语句时，代码会更短，但编译器实际上还是会替你生成入口方法。所以读到这两种写法时，不要把它们当成两种完全不同的语言风格，它们只是同一件事的两种表达。

```csharp
Console.WriteLine("Hello, C#!");
```

这就是一个完整的C#程序（C# 9.0+的顶级语句）。保存为`Program.cs`，执行`dotnet run`就能看到输出。

**最容易混淆的版本问题：** .NET Framework（老版本，只能Windows，最高4.8）、.NET Core（跨平台重写，1.0到3.1）、.NET 5/6/7/8（统一后的版本，现在主流用这个）。现在说".NET"通常指.NET 5及以后。C#版本和.NET版本不是一一对应的，但新版.NET通常支持新版C#。

### 开发环境与第一个程序

学C#可以用Visual Studio（Windows，功能全）、VS Code（跨平台，轻量）、Rider（跨平台，专业）或直接用`dotnet` CLI。初学者Windows用VS Community，macOS/Linux用VS Code。

一个C#程序从写完到运行的最小路径：安装.NET SDK → `dotnet new console -n MyApp` → `cd MyApp` → 编辑`Program.cs` → `dotnet run`。背后发生的是：`dotnet new`创建项目模板，`dotnet run`先编译再执行。

C# 9.0+支持顶级语句，可以直接写`Console.WriteLine("Hello");`，不需要完整的类和Main方法结构。编译器会自动生成Main方法。如果需要访问命令行参数，顶级语句里直接用`args`变量；需要返回退出码，直接`return 0`。

```csharp
// 接收命令行参数
if (args.Length > 0)
    Console.WriteLine($"你好，{args[0]}！");
else
    Console.WriteLine("你好，陌生人！");
```

运行：`dotnet run -- Alice`，输出：`你好，Alice！`

**容易出错的地方：** 找不到dotnet命令（没装SDK或没加PATH）、项目里有多个Main方法（只能有一个入口点）、顶级语句和传统Main混用（选一种统一用）、中文乱码（加`Console.OutputEncoding = System.Text.Encoding.UTF8;`）。
很多初学者还会把“SDK”和“运行时”混在一起。可以先记一个够用的区分：**SDK 是给开发者用的，包含创建、编译、运行项目所需的工具；Runtime 是给程序运行用的，只负责把已经编译好的程序跑起来。** 所以你的机器上如果只安装运行时，往往能执行现成程序，却不能 `dotnet new` 或 `dotnet build`。这个区分在面试里很常见，在工作里也有用：开发机通常装 SDK，生产机可能只需要对应运行时，容器镜像则常常直接选已经带运行时的基础镜像。

如果把一个最小控制台项目拆开来看，真正值得先熟悉的只有几个文件：`Program.cs` 是入口，`.csproj` 说明这个项目用什么 SDK、目标框架和依赖，`bin/` 和 `obj/` 是构建产物目录。初学时不必被这些目录吓到，只要先知道一件事：**C# 项目不是“单文件脚本”，而是“由项目文件驱动的一组源码”。** 这也是为什么读 .NET 代码时，除了看 `Program.cs`，还要顺手看一眼 `.csproj`。

### 程序结构、using 与 namespace

刚接触 C# 时，很多人会把注意力都放在语法本身，却忽略了“代码是怎么被组织起来的”。但在真实项目里，读代码往往不是先看算法，而是先看外壳：文件头部引入了哪些命名空间，类型放在哪个 `namespace` 下面，这个文件里到底定义的是一个实体、一个服务、一个扩展方法类，还是单纯的程序入口。把这些东西看顺以后，你读工程代码的速度会快很多。

可以先记住一个最朴素的关系：`using` 解决的是“我在当前文件里想直接使用哪些命名空间中的类型”，`namespace` 解决的是“我定义的这些类型应该放在哪个逻辑分组下，避免跟别人的类型重名”。它们一个偏“使用视角”，一个偏“组织视角”。所以 `using` 不是“导入某个文件”，而是“把某个命名空间里的类型放到当前文件的可见范围里”；`namespace` 也不是单纯为了好看，它直接影响类型的全名、模块边界和项目结构。

在控制台小程序里，这些概念看起来很轻；到了工程代码里，它们会变得非常重要。比如一个 ASP.NET Core 项目里，`StudentManagerApp.Controllers`、`StudentManagerApp.Services`、`StudentManagerApp.Models` 往往分别表达控制器、服务和模型的归属。你看到类型名相同但命名空间不同的类时，也不该惊讶，因为命名空间本来就是用来隔离名称冲突的。一个很实用的阅读习惯是：先看 `namespace`，大概判断这个文件属于哪一层；再看 `using`，判断这个文件依赖了哪些模块；最后再看具体类型和方法。

| 结构                     | 它在解决什么问题         | 常见误解                     | 更稳的理解方式                               |
| ------------------------ | ------------------------ | ---------------------------- | -------------------------------------------- |
| `using`                  | 在当前文件里简化类型引用 | 以为是“导入某个文件”         | 实际上是引入命名空间中的类型可见性           |
| `namespace`              | 给类型分组、避免重名     | 以为只是目录名的镜像         | 它表达逻辑边界，不一定和物理目录完全一致     |
| 顶级语句                 | 简化小程序入口写法       | 以为和 `Main` 是两套不同机制 | 编译器仍会生成入口方法，只是写法更短         |
| `class Program` + `Main` | 显式入口                 | 以为已经过时                 | 在需要更清晰组织入口、多个类型共存时仍很常见 |

下面这段代码更接近“项目代码的基本骨架”，你读的时候要重点看命名空间和 using 的配合，而不是把它只当作 Hello World：

```csharp
using System;
using StudentManagerApp.Services;
using StudentManagerApp.Models;

namespace StudentManagerApp;

class Program
{
    static void Main(string[] args)
    {
        var service = new StudentService();
        service.Add(new Student("S001", "Alice"));
        Console.WriteLine("Student added.");
    }
}
```

如果你读到下面这种写法，也不用紧张。它只是文件作用域命名空间（file-scoped namespace），目的是减少一层大括号嵌套，本质上和传统写法是一样的：

```csharp
namespace StudentManagerApp.Services;

public class StudentService
{
}
```

再往前走一步，`using` 还经常配合别名和 static 引入一起出现。别名适合解决重名类型或长命名空间的问题，`using static` 则适合少量引入静态成员，但这两种写法都不要滥用，否则代码会失去可读性。

```csharp
using ModelStudent = StudentManagerApp.Models.Student;
using static System.Math;
```

你可以把这部分当成“读工程代码前的地图”。只要 `using`、`namespace`、入口、类型归属这几个点不乱，后面不管是控制台程序、类库项目还是 Web 项目，骨架都不会太陌生。

再往前走一步，程序结构其实是在回答一个很朴素的问题：**编译器和阅读者，应该如何找到你写的类型。** 目录结构更多是给人看的，命名空间则是给编译器和人同时看的。两者通常会保持一致，但不是强制一一对应；真正重要的是，同一层代码的命名空间要稳定，不要今天在 `StudentManager.Services`，明天又跑到 `StudentManager.ServiceImpl`，否则项目一大，阅读成本会上来得很快。

真实项目里还有一个很常见的小习惯：`using` 越少越好，但要足够表达依赖边界。一个文件如果 `using` 很多层基础设施命名空间，往往说明这个文件知道得太多；如果 `namespace` 非常深、又混入了多个层次的类型，通常也是结构需要重新收拾的信号。对入门阶段来说，先把这条直觉记住就很够用：**命名空间是在给代码分层，using 则是在暴露当前文件依赖了哪些层。** 以后你读 Web 项目、类库项目、测试项目，先看这两处，通常能很快建立全局感。

### 最小控制台项目与最小 Web 项目

很多人学到这里会产生一个错觉：控制台项目、类库项目、Web 项目是不是只是模板不同？从文件数量上看像是这样，但从运行模型上看，区别比表面更大。控制台项目更像“一次启动、顺序执行、结束退出”；Web 项目更像“启动后常驻，持续接收请求，再把请求分派给不同的处理逻辑”。这个差异决定了你读代码的视角也要变：控制台程序先找入口和执行顺序，Web 项目先找服务注册、请求管道和路由映射。

最小控制台项目的骨架通常很朴素：`Program.cs` 里放入口，`.csproj` 说明目标框架和依赖，必要时再拆几个类文件。它适合练习语法、写小工具、做脚本式自动化，也适合承担“命令执行完就退出”的任务。反过来，最小 Web 项目虽然入口仍在 `Program.cs`，但重点已经变成“应用启动时要准备什么”和“请求来了以后按什么顺序处理”。

| 项目类型   | 先看哪里                       | 运行模型               | 读代码时最先关心什么   |
| ---------- | ------------------------------ | ---------------------- | ---------------------- |
| 控制台项目 | `Program.cs` / `Main`          | 启动 → 执行 → 结束     | 执行顺序、参数、输出   |
| 类库项目   | public 类型与命名空间          | 不独立运行，被别人引用 | 对外 API、边界、依赖   |
| Web 项目   | `Program.cs` / 路由 / 服务注册 | 启动后常驻，处理请求   | 服务、管道、路由、配置 |

这条线之所以值得补，是因为很多初学者刚从控制台程序跳到 Web 项目时，最容易困惑的不是语法，而是“为什么代码不再从上到下一路跑”。一旦把运行模型这个差异想通，你再回头看 `builder.Services`、中间件、控制器，就不会觉得它们只是“模板魔法”。

### 基本类型与变量

C#是强类型语言，变量必须先声明类型。常用类型：`int`（32位整数，最常用）、`long`（64位）、`double`（默认浮点）、`float`（需要`f`后缀）、`decimal`（金融计算，需要`m`后缀）、`string`（字符串）、`bool`（布尔）、`char`（单字符）。

```csharp
int age = 25;
var name = "Bob";        // var自动推断类型，编译时确定
const double PI = 3.14;  // 常量

string fullName = $"{firstName} {lastName}";  // 字符串插值，推荐
```

**var的使用原则：** 右边类型明显时用`var`提高可读性，不明显时显式写类型。`var`不是动态类型，编译时就确定了，之后不能改。

**可空类型：** 值类型默认不能为null，要用`int?`。空合并运算符`??`和空条件运算符`?.`很常用：

```csharp
int? age = null;
int actualAge = age ?? 0;        // age为null时用0
int? length = name?.Length;      // name为null时length也是null
```

**类型转换：** 隐式转换（小到大，如`int`到`long`）、显式转换（可能丢精度，如`(int)9.8`得9）、字符串转数字用`int.Parse()`（失败抛异常）或`int.TryParse()`（失败返回false）。

**最容易混淆的：** `double` vs `decimal`（double是二进制浮点有精度误差，decimal是十进制高精度，金融计算必须用decimal）、`string`是引用类型但不可变（每次修改创建新对象，大量拼接用`StringBuilder`）、`var`不是`dynamic`（var编译时确定，dynamic运行时确定）。

### 控制流与基本语法

`if/else`、三元运算符`? :`、switch表达式（C# 8.0+推荐，比传统switch简洁）：

```csharp
string dayName = day switch
{
    1 => "Monday",
    2 => "Tuesday",
    _ => "Unknown"
};
```

循环：`for`（已知次数）、`foreach`（遍历集合）、`while`、`do-while`。`break`跳出循环，`continue`跳过本次。

**模式匹配：** 可以在`if`和`switch`中同时做类型判断和赋值：

```csharp
if (obj is string str)
    Console.WriteLine($"字符串长度：{str.Length}");

string result = obj switch
{
    int n => $"整数：{n}",
    string s => $"字符串：{s}",
    null => "空值",
    _ => "其他类型"
};
```

**容易混淆的：** 传统switch每个case必须有`break`，C#不允许贯穿（和C/C++不同）；`foreach`遍历时不能添加或删除元素，需要修改用`for`循环；`string`用`==`比较内容（重写了`==`），不需要用`Equals()`。

### 方法与参数传递

方法定义：`访问修饰符 返回类型 方法名(参数列表)`。表达式体方法：`public int Add(int a, int b) => a + b;`

**参数传递是面试高频考点：**

| 传递方式     | 关键字 | 传递内容 | 能否修改原值 | 必须初始化 | 典型用途         |
| ------------ | ------ | -------- | ------------ | ---------- | ---------------- |
| **值传递**   | 无     | 复制值   | 否           | 是         | 默认方式         |
| **引用传递** | `ref`  | 传递引用 | 是           | 是         | 需要修改原变量   |
| **输出参数** | `out`  | 传递引用 | 是           | 否         | 返回多个值       |
| **只读引用** | `in`   | 传递引用 | 否           | 是         | 大结构体只读传递 |

```csharp
void Increment(int x) { x++; }           // 值传递，不影响原值
void Increment(ref int x) { x++; }       // ref，修改原值，调用时加ref
bool TryParse(string input, out int result) { ... }  // out，返回多个值
```

**最容易混淆的：** `ref` vs `out`（ref传入前必须初始化，out不需要但方法内必须赋值；ref用于修改原值，out用于返回多个值）、值类型vs引用类型的参数传递（值类型默认传副本，引用类型传引用的副本，引用类型不加ref时可以修改对象内容但不能改变引用本身）、方法重载根据参数类型/数量/顺序区分，只有返回值不同不算重载。

## 常用数据结构与集合

### 数组与 List<T>

数组是固定长度的，创建后不能改变大小。`List<T>`是动态数组，可以自动扩容。工作中90%的情况用`List<T>`，除非有明确的性能要求。

```csharp
// 数组
int[] numbers = { 1, 2, 3, 4, 5 };
int length = numbers.Length;  // 注意是Length属性

// List<T>
List<int> list = new List<int> { 1, 2, 3 };
list.Add(4);
list.Remove(2);
int count = list.Count;  // 注意是Count属性
```

| 特性         | 数组               | List<T>                     |
| ------------ | ------------------ | --------------------------- |
| **长度**     | 固定               | 动态扩容                    |
| **性能**     | 访问快             | 访问快，扩容时需复制        |
| **API**      | 基础               | 丰富（Add、Remove、Find等） |
| **适用场景** | 长度固定、性能敏感 | 长度不确定、需要频繁增删    |

**容易混淆的：** 数组用`Length`，List用`Count`；List扩容时容量翻倍，如果知道大概数量可以预分配容量`new List<int>(100)`；`foreach`遍历时不能修改集合，需要修改用`for`循环；`ToArray()`和`ToList()`可以互相转换。

### Dictionary<TKey, TValue> 与 HashSet<T>

`Dictionary`是键值对集合，通过键快速查找值（O(1)）。`HashSet`是无序不重复集合，用于去重和集合运算（O(1)）。

```csharp
// Dictionary
Dictionary<string, int> ages = new Dictionary<string, int>();
ages["Alice"] = 25;
ages.Add("Bob", 30);

// 安全访问（推荐）
if (ages.TryGetValue("Charlie", out int age))
    Console.WriteLine(age);

// HashSet
HashSet<int> numbers = new HashSet<int> { 1, 2, 3 };
numbers.Add(2);  // 重复元素被忽略，返回false

// 集合运算
set1.UnionWith(set2);      // 并集
set1.IntersectWith(set2);  // 交集
set1.ExceptWith(set2);     // 差集
```

| 特性     | Dictionary     | HashSet        |
| -------- | -------------- | -------------- |
| **存储** | 键值对         | 单个值         |
| **重复** | 键不重复       | 不重复         |
| **查找** | O(1)           | O(1)           |
| **用途** | 映射关系、缓存 | 去重、集合运算 |

**容易混淆的：** Dictionary用`[]`赋值时键存在会覆盖，用`Add()`时键存在会抛异常，推荐用`TryGetValue()`安全访问；自定义类型作为键时必须重写`GetHashCode()`和`Equals()`；Dictionary和HashSet都不是线程安全的，多线程用`ConcurrentDictionary`。

### Stack<T>、Queue<T> 与其他集合

`Stack<T>`是后进先出（LIFO），`Queue<T>`是先进先出（FIFO）。

```csharp
// Stack
Stack<int> stack = new Stack<int>();
stack.Push(1);
int top = stack.Pop();   // 移除并返回
int peek = stack.Peek(); // 只查看不移除

// Queue
Queue<string> queue = new Queue<string>();
queue.Enqueue("Alice");
string first = queue.Dequeue();  // 移除并返回
string peek = queue.Peek();      // 只查看不移除
```

| 特性         | Stack<T>                     | Queue<T>                |
| ------------ | ---------------------------- | ----------------------- |
| **顺序**     | 后进先出（LIFO）             | 先进先出（FIFO）        |
| **添加**     | `Push()`                     | `Enqueue()`             |
| **移除**     | `Pop()`                      | `Dequeue()`             |
| **典型场景** | 撤销操作、递归模拟、括号匹配 | 任务队列、BFS、消息队列 |

**其他集合：** `LinkedList<T>`（双向链表，不支持索引访问，工作中用得少）、`SortedSet<T>`（有序不重复）、`SortedDictionary<TKey, TValue>`（按键排序）、`ConcurrentDictionary<TKey, TValue>`（线程安全）。

### 集合的遍历、查找与排序

遍历：`foreach`最常用，`for`适合需要索引的场景。查找：`Find()`查找单个，`FindAll()`查找多个，`FirstOrDefault()`找不到返回默认值不抛异常。排序：`Sort()`修改原集合，`OrderBy()`返回新集合。

```csharp
List<int> numbers = new List<int> { 5, 2, 8, 1, 9 };

// 查找
int first = numbers.Find(x => x > 5);  // 找第一个大于5的
bool any = numbers.Any(x => x > 10);   // 是否有元素大于10

// 排序
numbers.Sort();  // 修改原集合，升序
var sorted = numbers.OrderBy(x => x).ToList();  // 返回新集合

// 多字段排序
var sorted = students.OrderBy(s => s.Age).ThenBy(s => s.Name).ToList();

// 常用LINQ
var filtered = numbers.Where(x => x > 2);  // 过滤
var doubled = numbers.Select(x => x * 2);  // 映射
int sum = numbers.Sum();
int max = numbers.Max();
var distinct = numbers.Distinct();  // 去重
var page = numbers.Skip(10).Take(10);  // 分页
```

**容易混淆的：** `Find()`是List的方法，`FirstOrDefault()`是LINQ方法，功能类似但LINQ更通用；`Sort()`修改原集合，`OrderBy()`返回新集合，需要修改原集合用`Sort()`，不想修改用`OrderBy()`；LINQ是延迟执行的，调用`ToList()`才会立即执行，需要立即执行或多次使用结果时要调用`ToList()`。

### 集合选型与面试常问

| 需求                 | 推荐集合                             | 理由               |
| -------------------- | ------------------------------------ | ------------------ |
| 动态数组，按索引访问 | `List<T>`                            | 最常用，性能好     |
| 键值对映射           | `Dictionary<TKey, TValue>`           | O(1)查找           |
| 去重                 | `HashSet<T>`                         | 自动去重，O(1)查找 |
| 后进先出             | `Stack<T>`                           | 撤销操作、递归模拟 |
| 先进先出             | `Queue<T>`                           | 任务队列、消息队列 |
| 有序且去重           | `SortedSet<T>`                       | 自动排序           |
| 线程安全字典         | `ConcurrentDictionary<TKey, TValue>` | 多线程环境         |

**面试高频问题：**

**List vs 数组？** 长度不确定、需要频繁增删用`List<T>`；长度固定、性能敏感用数组。工作中90%用`List<T>`。

**Dictionary查找为什么是O(1)？** 基于哈希表实现，通过键的哈希值快速定位到桶，哈希冲突时用链表或红黑树解决。

**HashSet和List去重的区别？** `HashSet`自动去重O(1)查找，`List`需要手动去重（`Distinct()`）O(n)查找。需要去重时优先用`HashSet`。

**什么时候用Stack/Queue？** Stack后进先出，适合撤销操作、递归模拟、括号匹配；Queue先进先出，适合任务队列、BFS、消息队列。

**LINQ性能怎么样？** LINQ是延迟执行的，性能略低于手写循环但差距不大（通常10%以内）。工作中优先用LINQ代码更清晰，性能敏感的地方再优化。

**如何选择集合？** 先看是否需要键值对（是→Dictionary，否→继续）→是否需要去重（是→HashSet，否→继续）→是否需要有序（是→SortedSet/SortedDictionary，否→继续）→是否需要LIFO/FIFO（是→Stack/Queue，否→List）。

## 面向对象与类型系统

很多人一复习面向对象，就容易重新掉回“类是模板、对象是实例”这种课本式记忆。真到读项目代码或回答面试题时，真正容易混的其实不是这些最基础的定义，而是几组边界很近、但设计意图完全不同的概念：字段和属性、接口和抽象类、值类型和引用类型、struct 和 class 和 record。把这些边界重新理顺，后面看业务代码、看框架代码都会顺很多。

这一章可以始终带着一个问题去看：**我现在是在建模数据、约束能力，还是在组织实现细节？** 一旦带着这个问题读下去，很多平时看起来像“语法区别”的内容，都会重新变成“设计选择”的问题。

这一章最容易混的不是"类和对象是什么"，而是那些"看起来很像、实际边界不同"的概念组合。字段和属性都在类里，为什么要分两个？接口和抽象类都能定义契约，什么时候用哪个？值类型和引用类型都能存数据，为什么赋值行为不一样？这些才是复习时最该重新理清的地方。

### 类、对象与成员

类是模板，对象是实例。`new`做三件事：在堆上分配内存、调用构造函数、返回引用。每个对象有自己独立的字段值，但共享方法。

```csharp
public class User
{
    private string name;
    private int age;
    
    public User(string name, int age)
    {
        this.name = name;  // this指当前对象
        this.age = age;
    }
    
    public void Login() => Console.WriteLine($"{name} 登录了");
}

User user1 = new User("Alice", 20);
User user2 = new User("Bob", 22);
```

构造函数用来初始化对象，方法名与类名相同，没有返回类型。静态成员属于类不属于对象，通过类名访问。

### 字段与属性

这是C#非常典型的一组，面试里也常问。最容易混的地方是：它们都能存数据，为什么要分两个？

答案是：**字段像内部存储，属性像对外访问面**。对外暴露数据时，永远用属性不要用字段，因为属性可以加验证、可以改成计算属性、可以加断点调试。

```csharp
public class BankAccount
{
    // 字段（private，内部用）
    private decimal balance;
    
    // 属性（public，对外暴露）
    public decimal Balance
    {
        get { return balance; }
        set { if (value >= 0) balance = value; }  // 可以加验证
    }
    
    // 自动属性（最常用）
    public string AccountNumber { get; set; }
    
    // 只读属性
    public string BankName { get; }
    
    public BankAccount(string bankName)
    {
        BankName = bankName;  // 只读属性只能在构造函数中赋值
    }
}
```

自动属性是最常用的，编译器会自动生成私有字段。工作中90%的情况用自动属性就够了，只有需要验证或计算时才写完整属性。

面试标准回答：字段是直接存储数据的变量，属性是通过get/set方法访问数据。属性可以在set中验证、可以改成计算属性而不影响调用方、可以设置断点调试。工作中对外暴露数据必须用属性。

### 接口、抽象类与继承

这是面试高频考点，重点是理解什么时候用接口、什么时候用抽象类。先记住一句话：**接口更像能力契约，抽象类更像共享骨架**。

接口定义"能做什么"，不关心"怎么做"。类实现接口必须实现所有成员。C#支持多接口实现。

```csharp
public interface IFlyable
{
    void Fly();
    int MaxSpeed { get; }
}

public class Duck : IFlyable
{
    public int MaxSpeed => 50;
    public void Fly() => Console.WriteLine("鸭子在飞");
}
```

抽象类不能实例化，只能被继承。可以有抽象方法（没有实现，子类必须重写）和普通方法（有实现，子类可以直接用）。

```csharp
public abstract class Shape
{
    public string Color { get; set; }
    
    // 抽象方法（没有实现）
    public abstract double GetArea();
    
    // 普通方法（有实现）
    public void Display() => Console.WriteLine($"这是一个{Color}的图形");
}

public class Circle : Shape
{
    public double Radius { get; set; }
    public override double GetArea() => Math.PI * Radius * Radius;
}
```

| 特性         | 接口                 | 抽象类                     |
| ------------ | -------------------- | -------------------------- |
| **继承数量** | 多实现               | 单继承                     |
| **成员类型** | 属性、方法、事件     | 字段、属性、方法、构造函数 |
| **实现**     | 传统上没有实现       | 可以有实现                 |
| **使用场景** | can-do关系，定义能力 | is-a关系，共享代码         |

面试标准回答：接口用于can-do关系定义能力（如IFlyable表示"能飞"的能力），抽象类用于is-a关系且有共享代码（如Shape有共同的Display方法）。优先用接口因为更灵活（支持多实现），只有在需要共享代码时才用抽象类。

继承不是默认答案。继承用于is-a关系（Dog is an Animal），组合用于has-a关系（Car has an Engine）。优先使用组合，因为继承耦合度高，组合更灵活。

### 值类型、引用类型与参数传递

这是C#中最重要的概念之一，面试高频考点。核心区别是：**变量里放的到底是什么**。

值类型变量直接包含数据，引用类型变量包含引用（地址）。这导致赋值行为完全不同：

```csharp
// 值类型
int a = 10;
int b = a;  // 复制值
b = 20;
Console.WriteLine(a);  // 10（a不受影响）

// 引用类型
class Person { public string Name { get; set; } }

Person p1 = new Person { Name = "Alice" };
Person p2 = p1;  // 复制引用，指向同一个对象
p2.Name = "Bob";
Console.WriteLine(p1.Name);  // Bob（p1受影响）
```

| 特性         | 值类型                 | 引用类型                                 |
| ------------ | ---------------------- | ---------------------------------------- |
| **存储位置** | 栈                     | 堆（引用在栈上）                         |
| **赋值行为** | 复制值                 | 复制引用                                 |
| **默认值**   | 0、false等             | null                                     |
| **包含**     | 基本类型、struct、enum | class、interface、delegate、string、数组 |

最容易混淆的三个点：**`string`是引用类型但不可变**（每次修改创建新对象，行为像值类型）、**数组是引用类型**（即使是`int[]`，数组对象也存储在堆上）、**值类型也可以为null**（使用可空类型`int?`）。

参数传递：默认是值传递（传副本），`ref`传递引用可修改原值（传入前必须初始化），`out`用于返回多个值（传入前不需要初始化，方法内必须赋值）。

面试标准回答：值类型存储在栈上赋值复制值，引用类型存储在堆上赋值复制引用。值类型包括基本类型、struct、enum，引用类型包括class、interface、delegate、string、数组。`ref`传递引用可修改原值，`out`用于返回多个值。

### 访问修饰符与封装边界

面向对象这一章如果只讲“字段、属性、接口、继承”，但不把访问修饰符讲透，读工程代码时还是会发虚。因为真正决定“外部能看到什么、能改什么、继承层级能碰到什么”的，很多时候不是类图，而是访问修饰符。你看到一个成员是 `public`、`private set`、`internal`，其实已经能大致推断出作者想把它暴露到什么边界。

最常用的四个修饰符其实就够你覆盖大多数工作场景：`public`、`private`、`protected`、`internal`。其中最容易建立直觉的是：`public` 是对外契约，`private` 是实现细节，`protected` 是给子类留的扩展口，`internal` 是“只给当前程序集内部看”。如果你在同一个项目里写业务代码，`internal` 往往比 `public` 更值得先考虑，因为不是所有东西都应该成为“公共 API”。

这也是为什么很多成熟代码库会倾向于：类本身能不 public 就不 public，属性能不 public set 就不 public set，集合能不直接暴露可变 List 就不直接暴露。它不是在故意增加门槛，而是在把“谁能改状态”这件事提前收紧，减少未来维护成本。换句话说，访问修饰符不仅是语法点，更是设计边界。

| 修饰符                 | 谁能访问           | 最常见用途             | 你读代码时的直觉       |
| ---------------------- | ------------------ | ---------------------- | ---------------------- |
| `public`               | 任何地方           | 对外暴露的类型和成员   | 这是契约，改动要谨慎   |
| `private`              | 仅当前类型内部     | 字段、内部辅助方法     | 这是实现细节           |
| `protected`            | 当前类型及其子类   | 可被重写或复用的扩展点 | 这是给继承体系留的口子 |
| `internal`             | 当前程序集内部     | 模块内共享但不对外开放 | 这是“项目内可见”       |
| `private set` / `init` | 读取公开，写入受限 | 受控状态、初始化后冻结 | 状态不是谁都能改       |

一个很高频、也很容易被忽略的模式是：**公开读，限制写**。比如学生实体的 `Id`、`CreatedAt`、`Grade` 这类信息，通常希望外部能读，但不希望任何代码随便改，这时 `public get; private set;` 或 `public get; init;` 就很合适。

```csharp
public class Student
{
    public string Id { get; }
    public string Name { get; private set; }
    public DateTime CreatedAt { get; } = DateTime.UtcNow;

    public Student(string id, string name)
    {
        Id = id;
        Name = name;
    }

    public void Rename(string newName)
    {
        Name = newName;
    }
}
```

这段代码真正想表达的不是“我会写属性”，而是：`Id` 一旦创建就不该变，`Name` 可以变但必须通过方法改，`CreatedAt` 只初始化一次。也就是说，访问修饰符在这里承担的是**状态规则**，而不只是“能不能访问”。

如果你读到 `internal class`、`internal interface`，也不用觉得它高级。它很多时候只是在说：“这个类型只服务于当前程序集的实现，不打算作为公共库的一部分对外承诺。”对面试来说，你只要能把这层边界意识说出来，就已经比单纯背修饰符表格更好了。

很多初学者学到访问修饰符时，只记住“谁能访问谁”，却没把它和封装边界联系起来。更实用的理解是：**访问修饰符是在给状态和行为设门禁。** 如果一个类的状态任何地方都能随便改，那这个类表面上很“方便”，实际上很难维护。相反，当你看到 `private set`、`internal`、受保护的构造函数，往往说明作者已经在明确边界：哪些东西是外部契约，哪些只是内部实现，哪些只能在同程序集或继承体系中流动。

还有一个容易忽略但很工程化的点：C# 的访问修饰符和程序集边界是连在一起的。`internal` 不是“比 private 大一点”的语法糖，而是在说“这部分只给当前程序集内部的代码用”。这对多项目解决方案特别重要。比如 `MyApp.Core` 里的很多辅助类型，未必想暴露给 `MyApp.Api` 之外的所有调用者，这时 `internal` 往往比 `public` 更稳。你可以把它理解成：`public` 是跨模块契约，`internal` 是模块内协作，`private` 是类内细节。

### struct、class 与 record

这三个为什么总被比较？因为它们都能定义对象，但代表不同的建模意图。struct是值类型，class是引用类型，record是专为不可变数据设计的引用类型。工作中90%用class，只有明确的性能需求或逻辑上表示单个值时才用struct。

```csharp
// struct（值类型）
public struct Point
{
    public int X { get; set; }
    public int Y { get; set; }
}

Point p1 = new Point { X = 1, Y = 2 };
Point p2 = p1;  // 复制值
p2.X = 10;
Console.WriteLine(p1.X);  // 1（p1不受影响）

// class（引用类型）
public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
}

// record（引用类型，不可变）
public record Student(string Name, int Age);

Student s1 = new Student("Alice", 20);
Student s2 = s1 with { Age = 21 };  // 创建副本并修改
Console.WriteLine(s1.Age);  // 20
```

| 特性         | struct       | class      | record     |
| ------------ | ------------ | ---------- | ---------- |
| **类型**     | 值类型       | 引用类型   | 引用类型   |
| **赋值**     | 复制值       | 复制引用   | 复制引用   |
| **相等比较** | 按值比较     | 按引用比较 | 按值比较   |
| **适用场景** | 小型数据结构 | 一般对象   | 不可变数据 |

什么时候用struct？数据量小（通常小于16字节）、逻辑上表示单个值（如Point、Color）、不需要继承、不会频繁装箱。典型例子：`DateTime`、`TimeSpan`、`Guid`都是struct。

什么时候用record？需要不可变数据、需要值相等比较、需要with表达式创建副本。典型场景：DTO（数据传输对象）、配置对象、事件数据。record的价值不只是"语法更短"，而是明确表达了"这是不可变数据"的建模意图。
还有一个经常被忽略但非常影响判断的点：**值类型/引用类型** 和 **按值相等/按引用相等** 不是完全同一回事。`struct` 默认更接近值语义，`class` 默认更接近对象身份，而 `record` 则是把“按值比较”这件事显式推到了台前。也就是说，`record` 的意义不只是语法短，而是在告诉读代码的人：这里更关心“数据内容是否相同”，而不是“是不是同一个对象实例”。

这也是为什么 DTO、事件消息、配置对象很适合用 `record`。这些对象很多时候只是“携带一组数据”，我们更关心内容等价，而不是身份。相反，像实体对象、聚合根、生命周期复杂的业务对象，通常还是 `class` 更自然，因为它们往往有自己的状态变化、边界和身份。把这一层直觉补上以后，`struct / class / record` 就不再只是三个语法关键词，而是三种不同的建模意图。

### 枚举与状态建模

`enum` 这一类节点在压缩版笔记里很容易被漏掉，但实际工作和面试里都很常见。它适合表达“一组可枚举、可比较、语义清楚的状态值”，比如订单状态、用户角色、任务阶段。菜鸟教程会把枚举单独拿出来讲，原因也很简单：它虽然不复杂，但属于 C# 里非常典型的建模工具。([runoob.com](https://www.runoob.com/csharp/csharp-enum.html?utm_source=chatgpt.com))

如果一个字段的取值只可能在几个固定选项之间变化，用 `enum` 往往比直接用 `string` 或 `int` 更稳。前者的好处是可读性更强、出错空间更小，后者虽然灵活，但很容易写出魔法数字和拼写错误。

```csharp
enum OrderStatus
{
    Pending,
    Paid,
    Shipped,
    Cancelled
}

OrderStatus status = OrderStatus.Paid;
if (status == OrderStatus.Paid)
{
    Console.WriteLine("订单已支付");
}
```

默认情况下，枚举底层是 `int`，第一个成员从 `0` 开始递增。必要时也可以显式指定值：

```csharp
enum HttpStatus
{
    Ok = 200,
    NotFound = 404,
    InternalServerError = 500
}
```

这里真正值得记住的不是语法，而是建模判断：`enum` 适合表示“有限状态集”，不适合承载会频繁变化、来自外部输入、需要国际化展示的文本。比如数据库里存状态码可以用枚举，但界面上直接给用户展示的文案通常还是要单独映射。再往前走一步，面试里有时还会问到 `[Flags]` 枚举，它适合做权限位组合；这一层知道概念和使用场景就够了，不必在这份入门笔记里展开太深。 

枚举还有一个很实用的变体：`[Flags]`。普通枚举更像“单选状态”，而 `[Flags]` 更像“可组合标记”，适合表示权限、开关集合、能力位。比如一个用户可能同时拥有读取、写入、删除权限，这时用多个布尔属性当然也能做，但表达和比较都不够自然；用按位组合的枚举，代码会更紧凑。

```csharp
[Flags]
enum Permission
{
    None = 0,
    Read = 1,
    Write = 2,
    Delete = 4
}

var permission = Permission.Read | Permission.Write;
bool canWrite = permission.HasFlag(Permission.Write);
```

这里最值得记的不是位运算本身，而是建模判断：**单选状态用普通 enum，多选能力用 Flags 枚举。** 如果你以后在权限系统、功能开关、状态组合里看到这种写法，不要把它当“高级技巧”，它本质上只是更贴合业务语义的表示方法。

## 核心语言特性与 LINQ

这一章最容易被写成“现代 C# 语法清单”，但真正复习时更有用的角度是：这些特性为什么总会一起出现在真实项目里。泛型是在减少把一切都当成 `object` 的粗糙写法，委托和 Lambda 让“把行为当参数传递”变得自然，`IEnumerable<T>`、`yield` 和 LINQ 则把“按需枚举、逐步处理数据”这件事抽成了统一模型。把这些东西拆开记并不难，难的是重新把它们连成一条线。

所以这一章不必把每个语法点都当成独立知识岛去背，更稳妥的方式是记住它们各自在帮你减少什么样的样板代码、解决什么样的表达问题。这样回头看框架源码、业务查询代码或现代 C# 的惯用写法时，就不会只剩下“这段语法我见过，但不知道为什么这么写”。

这一章容易被写成"语言特性大全"，但真正重要的是理解这些特性解决什么问题。泛型避免装箱拆箱，委托和Lambda让方法可以当参数传递，LINQ让集合操作更简洁，异常处理让错误可控，可空引用类型减少空引用异常。这些都是工作中天天用到的能力。
再补一个工作里很常见、但入门稿里容易漏掉的点：`[Flags]` 枚举。它适合表达“多个开关可以组合”的状态，例如用户权限、导出选项、通知渠道。普通枚举更像“从几个状态里选一个”，`[Flags]` 更像“几个位可以同时打开”。这类代码在权限和配置场景里很常见，读到时别把它误解成普通状态机。

```csharp
[Flags]
enum Permission
{
    None = 0,
    Read = 1,
    Write = 2,
    Delete = 4
}

var p = Permission.Read | Permission.Write;
bool canWrite = (p & Permission.Write) != 0;
```

### 静态类、partial 与嵌套类型

这几个点都不算主线语法，但在真实项目里经常会碰到，所以值得补一个“看代码时别慌”的说明。旧稿里把它们归在“运行时补强”附近，这个位置其实很合理：它们不是新能力，而是**组织代码的不同外形**。fileciteturn28file18L35-L40

`static class` 最容易理解。它表达的是“这一组成员不依赖对象实例”，典型例子是工具方法、扩展入口、全局约束或纯函数转换器。它的好处是不会让调用方误以为“这里要先 new 一个对象”；它的代价是更容易滑向全局状态。如果静态类里开始塞缓存、配置、共享可变对象，问题通常就不是“静态语法不好”，而是职责已经失控了。

`partial class` 更像“把同一个类型拆到多个文件里”。业务代码里自己手写它的场景不算多，但一旦接触 WinForms、WPF、Source Generator、EF Core 生成代码，就很容易遇到。最稳的理解方式是：**partial 不是继承，也不是组合，它只是把同一个类型的定义分散到多个位置，由编译器在编译时合并。** 你读到它时，不要以为这里有两个类，通常只是一个类被拆开了。

嵌套类型则是在类型内部再定义类型。它适合那些只在外层类型上下文里有意义的小类型，例如状态机内部状态、构造辅助器、细粒度策略对象。它的好处是把关联关系写得更近；它的代价是层级太深时会伤害可读性。所以工程里更常见的原则是：**真的只在这个类里有意义，再考虑嵌套；否则宁可提升成独立类型。**

这一节不需要记很多语法，记住这三句话就够了：静态类表达“不需要实例”；partial 表达“同一个类型拆文件”；嵌套类型表达“这个小类型只服务于外层类型”。

### 泛型

泛型解决的问题是"既要类型安全，又要代码复用"。没有泛型之前，要么用`object`（失去类型安全，值类型会装箱），要么为每种类型写一遍代码（代码重复）。泛型让你写一次代码，适用于多种类型，编译时检查类型安全，值类型不装箱。

```csharp
// 泛型类
public class Box<T>
{
    private T value;
    public void Set(T item) => value = item;
    public T Get() => value;
}

Box<int> intBox = new Box<int>();
intBox.Set(123);  // 不装箱
int value = intBox.Get();  // 不拆箱

// 泛型方法
public T FindFirst<T>(List<T> list, Func<T, bool> predicate)
{
    foreach (T item in list)
    {
        if (predicate(item)) return item;
    }
    return default(T);
}
```

**泛型约束是给“类型参数能做什么”划边界。**

约束限制类型参数必须满足特定条件。工作中最常用的约束：`where T : class`（引用类型）、`where T : new()`（有无参构造函数）、`where T : IComparable`（实现接口）。

```csharp
// 必须是引用类型
public class Repository<T> where T : class
{
    public void Save(T entity) { }
}

// 必须有无参构造函数
public class Factory<T> where T : new()
{
    public T Create() => new T();
}

// 必须实现接口
public T Max<T>(T a, T b) where T : IComparable<T>
{
    return a.CompareTo(b) > 0 ? a : b;
}
```

面试常问：泛型和object有什么区别？答案是泛型编译时检查类型安全，值类型不装箱拆箱，性能更好。object运行时才知道类型，值类型会装箱拆箱，性能较差。

### 委托、Lambda 与事件

委托让方法可以当参数传递，Lambda是委托的简写形式，事件是委托的特殊用法。这三个概念经常一起出现，因为它们都在解决"把行为当参数传递"的问题。

**委托和 Lambda 总是一起出现，因为它们本来就在解决同一类问题。**

委托是方法的引用，可以把方法当参数传递。Lambda是委托的简写形式，工作中90%的情况用Lambda。

```csharp
// 委托定义
public delegate bool Predicate(int x);

// 使用委托（传统写法）
bool IsEven(int x) => x % 2 == 0;
Predicate pred = IsEven;
bool result = pred(4);  // true

// 使用Lambda（现代写法，推荐）
Predicate pred = x => x % 2 == 0;
bool result = pred(4);  // true

// 内置委托类型（最常用）
Func<int, bool> isEven = x => x % 2 == 0;  // 有返回值
Action<string> print = s => Console.WriteLine(s);  // 无返回值
```

工作中最常用的是`Func`和`Action`，不需要自己定义委托类型。`Func`有返回值，`Action`无返回值。

**事件可以看成是对委托的一层受控封装。**

事件是委托的特殊用法，用于发布-订阅模式。事件只能在类内部触发，外部只能订阅和取消订阅，不能直接调用。

```csharp
public class Button
{
    // 定义事件
    public event EventHandler Clicked;
    
    // 触发事件
    public void Click()
    {
        Clicked?.Invoke(this, EventArgs.Empty);
    }
}

// 订阅事件
Button button = new Button();
button.Clicked += (sender, e) => Console.WriteLine("按钮被点击了");
button.Click();  // 触发事件
```

面试常问：委托和事件有什么区别？答案是事件是委托的封装，只能在类内部触发，外部只能订阅和取消订阅。委托可以在外部直接调用。事件更安全，防止外部误触发。

### IEnumerable 与 LINQ

LINQ让集合操作更简洁。没有LINQ之前，过滤、映射、排序都要写循环。有了LINQ，一行代码就能搞定。工作中最常用的LINQ操作：`Where`（过滤）、`Select`（映射）、`OrderBy`（排序）、`FirstOrDefault`（查找第一个）、`Any`（是否存在）。

```csharp
List<int> numbers = new List<int> { 1, 2, 3, 4, 5, 6 };

// 过滤
var evens = numbers.Where(x => x % 2 == 0);  // [2, 4, 6]

// 映射
var doubled = numbers.Select(x => x * 2);  // [2, 4, 6, 8, 10, 12]

// 排序
var sorted = numbers.OrderBy(x => x);  // [1, 2, 3, 4, 5, 6]

// 查找
int first = numbers.FirstOrDefault(x => x > 3);  // 4

// 判断
bool hasEven = numbers.Any(x => x % 2 == 0);  // true

// 方法链
var result = numbers
    .Where(x => x > 2)
    .Select(x => x * 2)
    .OrderByDescending(x => x)
    .ToList();  // [12, 10, 8, 6]
```

LINQ是延迟执行的，调用`ToList()`、`ToArray()`、`Count()`等方法才会立即执行。需要立即执行或多次使用结果时要调用`ToList()`。

如果想把这块真正理解扎实，还要补上 `yield return` 这个节点。它和 Python 笔记里“迭代器与生成器、惰性求值”的作用很像：不是一次性把全部结果都造出来，而是在枚举时按需产生数据。fileciteturn21file0L33-L36

```csharp
IEnumerable<int> GetEvenNumbers(int max)
{
    for (int i = 0; i <= max; i++)
    {
        if (i % 2 == 0)
            yield return i;
    }
}
```

`yield` 最有价值的地方，不是语法酷，而是它让你更容易写出“按需返回”的序列。读 LINQ 代码时，如果脑子里没有“延迟执行”和“按需枚举”这两个概念，很多行为会显得很怪：为什么改了数据源，结果跟着变了？为什么枚举第二次又重新跑了一遍？为什么这里明明看起来像返回了一个列表，实际上却还没执行？

另外，现代 C# 代码里很多 LINQ 风格调用，其实还和扩展方法连在一起。像 `Where`、`Select` 这种写法之所以能挂在对象后面，本质上就是扩展方法把“函数式操作”接到了集合对象上。这里不必单独开一节去讲扩展方法语法，但读代码时要有这个直觉：点出来的方法不一定真的是那个类型自己定义的，也可能是扩展方法提供的能力。

面试常问：LINQ 的延迟执行是什么意思？答案是查询表达式本身往往只是在描述“怎么取数据”，只有真正遍历结果或调用 `ToList()` 之类的终止方法时才会执行。好处是可以组合、过滤、推迟成本；风险是如果你没有意识到它还没执行，就会在性能和结果一致性上踩坑。
如果把 LINQ 再往下挖一层，你会发现它和 `yield` 其实共享同一种思路：**把“结果是什么”写出来，而不是立刻把所有元素搬进新列表。** 这也是为什么 `IEnumerable<T>` 在 C# 里这么重要——它不只是一种接口名，更是在告诉你“这是一段可以被枚举的序列”。只要对象能被枚举，很多 LINQ 操作就能串起来。

这里还有一个很容易在面试里被追问的小边界：`IEnumerable<T>` 和 `IQueryable<T>` 不一样。前者更多表示“在内存里按序枚举”，后者常见于 ORM 或数据库查询，表达的是“这段查询还可能被翻译成别的东西执行”。入门阶段不需要展开太深，但至少要知道：看到 LINQ 不一定意味着它已经在内存里跑完了，有时它只是先把查询表达出来，真正执行发生在后面。

所以读 LINQ 代码时，一个很稳的习惯是先问自己三件事：数据源是什么、是不是延迟执行、在哪里物化。如果这三件事你能看清，很多“为什么结果变了”“为什么查了两次数据库”“为什么这里要 `ToList()`”的问题就不难了。

### 迭代器与 yield

如果只把 `yield return` 看成一个语法糖，这一节就会显得有点轻；但一旦你把它放回 `IEnumerable<T>` 和延迟执行这条线上，它就会立刻变得很有用。旧稿里有一类很典型的面试点：为什么很多 LINQ 看起来像“还没做事”，为什么枚举多次会重复执行，为什么一到 `ToList()`、`ToArray()` 这类物化操作，结果才真正落地。`yield` 正是这套心智模型里最容易讲清楚的一块。

最简单的理解是：普通方法一次性把结果都算好再返回；带 `yield return` 的迭代器方法则是“枚举器每要一个元素，我就现算一个”。这会带来两个直接结果。第一，它对流式处理更友好，因为不需要一次性把所有结果都装进列表；第二，它天然带着延迟执行的味道，所以枚举边界会变得很重要。

```csharp
public static IEnumerable<int> RangePlusOne(int count)
{
    for (int i = 0; i < count; i++)
    {
        Console.WriteLine($"generate {i}");
        yield return i + 1;
    }
}
```

```csharp
var seq = RangePlusOne(3);   // 这里只是拿到可枚举对象，还没真正执行循环
foreach (var n in seq)
{
    Console.WriteLine(n);
}
```

这类代码最容易踩的坑有两个。第一个是**多次枚举**：如果底层逻辑本身有成本，例如数据库查询、网络读取、复杂转换，那么每枚举一次都可能把那套逻辑重新跑一遍。第二个是**枚举边界不清楚**：有时你以为自己传的是“结果集”，其实传的是“还没执行完的查询描述”。这也是为什么 `ToList()` 很关键——它通常意味着“在这里把结果真正拉平并固定下来”。

可以把它和 Python 的生成器类比着记：目标都不是炫技，而是让“按需产生、流式处理、减少中间集合”这件事更自然。对面试来说，你只要能把这几层关系串起来就够了：`yield` 让方法变成按需返回元素的迭代器；`IEnumerable<T>` 往往意味着延迟执行；`ToList()` 则常常是从“查询描述”切到“真实结果”的边界。

### 异常处理与资源释放

异常和资源释放在 C# 里经常一起出现，不是因为语法长得像，而是因为它们都在处理“代码出错时还能不能把现场收干净”这件事。旧稿里有一段讲得很值得保留：异常不是日志，也不是返回码的替代品；工程里真正常见的坑，不是不会写 `try-catch`，而是把可预期分支都用异常表达，或者在重新抛出时把原始堆栈弄丢。fileciteturn29file0L29-L33

先说异常。对复习来说，最重要的不是背异常类，而是理解边界：**哪里负责保留底层异常细节，哪里负责把它转换成业务语义，哪里决定是否向上抛。** 这也是为什么 `throw;` 和 `throw ex;` 的区别很重要——前者保留原始堆栈，后者会重置抛出位置，排查问题时差别非常大。

```csharp
try
{
    SaveToDatabase(student);
}
catch (SqlException ex)
{
    logger.LogError(ex, "保存学生失败");
    throw; // 保留原始堆栈
}
```

资源释放则是另一条底线。内存可以交给 GC 管，但文件句柄、Socket、数据库连接、定时器这些资源，GC 只负责“最终回收”，不负责“你希望它什么时候马上归还”。旧稿里对这一点的总结很准：`Dispose()` 负责确定性释放，Finalizer 只是最后兜底，不能拿来当主路径。fileciteturn29file17L3-L9

`using` 的本质可以直接记成一句话：它是 `try/finally + Dispose()` 的语法糖。你在工作里经常看到 `using var stream = ...;`，不要把它当“好看写法”，它真正表达的是“这个对象离开当前作用域时必须被显式释放”。

```csharp
using var writer = new StreamWriter("students.log");
writer.WriteLine("start");
```

如果你自己实现 `IDisposable`，真正要守住的是语义，而不是背模板。旧稿里还提醒了一点也很有价值：`GC.SuppressFinalize(this)` 不是所有 `Dispose` 都必须写的咒语，它主要在你确实实现了 Finalizer 时，用来避免对象再走一遍终结路径。fileciteturn29file17L5-L9

最后把 GC 补一句就够了。面试里问 GC，通常不是让你背所有世代，而是在看你有没有“减少不必要分配、避免热路径制造垃圾”的意识。旧稿把这个角度讲得很好：性能问题很多并不是算法有多差，而是分配太多、GC 压力太大，所以像 `Span<T>`、对象池、缓存这些手段，本质上都在帮你减少额外分配。fileciteturn29file1L46-L52

这一节最终要形成的直觉是：异常负责把错误传播对，资源释放负责把收尾做对；两件事都不是“语法会不会写”，而是“边界和习惯立没立住”。

### 可空引用与现代 C# 写法

可空引用（Nullable Reference Types）这一组内容，真正解决的不是“语法更花”，而是把很多原本要等到运行时才炸出来的空引用问题，提前搬到编译期。对已经写过一段时间 C# 的人来说，这一节最值得建立的直觉不是每个符号怎么用，而是：**哪些对象按设计就不该为 null，哪些地方允许为空，边界在哪里说清楚。**

启用可空引用后，`string` 和 `string?` 不再只是写法区别，而是在表达契约。前者更像“调用方可以默认它有值”，后者更像“这里天然可能缺失，调用方必须处理”。这会让很多原来模棱两可的接口变清楚，也会逼着你在输入边界、DTO、数据库映射、外部调用结果这些地方更认真地思考 null 的来源。

```csharp
#nullable enable

string name = "Alice";
string? nickname = null;

string displayName = nickname ?? name;
int? length = nickname?.Length;
string definitelyNotNull = displayName!;
```

真正容易被误用的是 `!`。它不是“把 null 变没了”，而是在告诉编译器“这里我确认不为空，你先别警告我”。如果这句判断本身站不住脚，运行时照样会出问题。所以工程里更稳的顺序通常是：先用构造函数、`required`、校验和默认值把状态尽量收紧，实在没办法再用 `!` 做局部断言，而不是把 `!` 当万能消音器。

这一节和现代 C# 写法其实是连着的。`var`、`init`、`required`、模式匹配这些能力，本质上都在帮你把“代码真正想表达的约束”写得更接近业务意图。你可以把它们理解成两条共同目标：一条是减少样板代码，另一条是让错误更早暴露。

### 模式匹配、Tuple 与现代写法

这一组内容在旧稿里是比较值钱的部分，因为它能明显拉开“会写基础 C#”和“看得懂现代 C# 代码”的差距。它们不一定每天都手写很多，但你在中大型代码库里几乎一定会遇到：`switch` 表达式、模式匹配、`record`、`with`、tuple 解构、`required`，这些能力加在一起，解决的是同一类问题——**把原来分散、啰嗦、容易漏分支的代码，收成更紧凑也更有约束感的表达。** fileciteturn29file0L1-L5 fileciteturn29file6L9-L17

先看模式匹配。它不是“炫技版 if-else”，而是在分支多、类型多、状态多的时候，把条件和结果更集中地写在一起。尤其是状态机、解析逻辑、结果分发这类代码，用 `switch` 表达式往往更不容易漏分支。你在面试里如果能把“它让分支更集中、也更适合表达类型和属性条件”讲出来，已经很够用。fileciteturn29file0L1-L5

```csharp
public abstract record PaymentResult
{
    public sealed record Success(string TxnId) : PaymentResult;
    public sealed record Failed(string Reason) : PaymentResult;
}

static string ToMessage(PaymentResult result) => result switch
{
    PaymentResult.Success { TxnId: var id } => $"支付成功：{id}",
    PaymentResult.Failed { Reason: var reason } => $"支付失败：{reason}",
    _ => "未知结果"
};
```

再看 tuple 和解构。旧稿里有一句话说得很实用：当一个方法天然要返回多个值时，不必为了“凑返回类型”专门建一个只用一次的小类，tuple 往往更顺手。fileciteturn29file1L10-L19 它适合那种“结果数量少、语义也清楚”的场景，例如 `TryParse` 风格、校验结果、分页返回值。如果返回值本身有长期演进空间、要跨层传递，还是 DTO 或 record 更稳。

```csharp
public (bool Ok, string Message) TryRegister(string id, string name)
{
    if (string.IsNullOrWhiteSpace(id)) return (false, "Id 不能为空");
    if (string.IsNullOrWhiteSpace(name)) return (false, "Name 不能为空");
    return (true, "OK");
}

var (ok, message) = TryRegister("S001", "Alice");
```

`required` 可以和可空引用一起看。它表达的是“这个属性初始化时必须赋值”，把很多“对象半初始化”的问题拦在编译阶段。你可以把它理解成：当一个对象一旦创建就应该是完整的，`required` 比“先 new 出来，再慢慢补字段”更稳。旧稿里对这点的总结很准——它的价值就是让错误更早暴露。fileciteturn29file6L15-L17

```csharp
public class CreateStudentRequest
{
    public required string Id { get; init; }
    public required string Name { get; init; }
    public string? Email { get; init; }
}
```

这一节最后要形成的不是“背更多新语法”，而是一个阅读直觉：**当你在现代 C# 代码里看到 `record`、`with`、tuple、模式匹配、`required` 同时出现时，它们通常都在服务于同一个目标——把状态、分支和约束写得更明确。**

### 特性、反射与索引器

这一组内容放在压缩版笔记里，目的不是让你马上写框架，而是让你在看工程代码时别陌生。菜鸟教程会把 Attribute、Reflection、Indexer 单独列出来，因为它们都属于“C# 特有存在感很强，但第一次接触容易发懵”的节点。([runoob.com](https://www.runoob.com/csharp/csharp-attribute.html?utm_source=chatgpt.com)) ([runoob.com](https://www.runoob.com/csharp/csharp-reflection.html?utm_source=chatgpt.com)) ([runoob.com](https://www.runoob.com/csharp/csharp-indexer.html?utm_source=chatgpt.com))

先说 Attribute。它本质上是在类、方法、属性等程序元素上挂“元数据标签”。你在 ASP.NET Core、序列化、验证、ORM 映射里经常会看到它，比如 `[Obsolete]`、`[Required]`、`[ApiController]`。它的价值不是“多一个装饰语法”，而是给框架和运行时提供声明式信息。

```csharp
[Obsolete("请改用 NewMethod")]
public void OldMethod()
{
}
```

再往前一步，反射（Reflection）就是在运行时读取这些类型和元数据的能力。它可以查看类型、方法、属性，也可以读取特性，甚至动态创建对象。它非常灵活，但代价是性能和可维护性都会变差，所以反射更适合框架、工具、基础设施层，而不是普通业务代码到处滥用。

```csharp
Type type = typeof(MyService);
foreach (var method in type.GetMethods())
{
    Console.WriteLine(method.Name);
}
```

索引器（Indexer）相对没那么高频，但值得知道。它让一个对象可以像数组那样用下标访问，本质上很像“给对象定义一个 `this[...]` 的访问入口”。如果以后读到自定义集合、缓存包装器、配置访问器，这种写法不要慌，它和属性很像，只是把访问方式从点号换成了下标。([runoob.com](https://www.runoob.com/csharp/csharp-indexer.html?utm_source=chatgpt.com))

```csharp
class Team
{
    private readonly string[] members = new string[3];

    public string this[int index]
    {
        get => members[index];
        set => members[index] = value;
    }
}
```

这一组真正该记住的不是 API 细节，而是边界：Attribute 是声明式元数据，Reflection 是运行时读取和操作元数据的能力，Indexer 是让对象支持下标访问。前两者经常一起出现，后者更像“语法层的可读性设计”。面试里如果问到这几个点，能说清“它们解决什么问题、为什么别滥用”，就已经很够用了。

## 常用开发能力

这一章讲的东西不算“高级”，但几乎天天都会碰到：读文件、处理 JSON、拼接路径、处理时间、读配置、看日志。很多人复习语言时会把注意力都放在泛型、异步、LINQ 这些更显眼的主题上，结果真正工作里先把人绊住的，反而是这些基础但高频的问题。也正因为它们太常见，很多坑并不是“不会写”，而是“第一次写能跑，第二次线上出问题才想起来边界条件”。

如果把这一章当成 API 索引去背，效果通常并不好。更有用的方式是从问题出发：程序为什么总要和文件系统、JSON、配置、日志打交道？这些东西最容易在哪一步出错？哪些 API 只要知道存在就够，哪些边界必须尽早形成直觉？

程序迟早要读文件、处理JSON、处理时间和字符串、读配置、写日志。这些东西不算高深，但几乎天天都能碰到。真正重要的不是API背诵，而是知道哪几类问题最常见，先从哪里下手。

### 文件与路径

工作里为什么总要碰文件系统？因为配置要读文件、日志要写文件、数据要导入导出。最常见的就三类操作：判断文件是否存在、读文本、写文本。

真正常踩坑的是：**相对路径和绝对路径最容易混**。相对路径是相对于当前工作目录的，不是相对于可执行文件所在目录。开发时工作目录通常是项目根目录，发布后可能是别的地方。所以工作中要么用绝对路径，要么用`Path.Combine`拼接路径。

**路径拼接不要用字符串拼接。** Windows用反斜杠`\`，Linux用正斜杠`/`，手动拼接容易出错。用`Path.Combine`自动处理跨平台问题。

```csharp
// 判断文件是否存在
if (File.Exists("config.txt"))
{
    string content = File.ReadAllText("config.txt");
}

// 路径拼接（推荐）
string path = Path.Combine("data", "users", "profile.json");

// 大文件逐行处理
using (var reader = new StreamReader("large.txt"))
{
    string line;
    while ((line = reader.ReadLine()) != null)
    {
        // 处理每一行
    }
}
```

大文件不要用`ReadAllText`，它会一次性读取整个文件到内存。大文件要用`StreamReader`逐行处理。文件操作要用try-catch处理异常（文件不存在、权限不足、文件被占用）。

### JSON 处理

JSON 之所以高频，不是因为它“看起来简单”，而是因为接口请求、配置文件、消息队列、日志落盘，很多场景最后都会落到一份 JSON 文本上。复习这节时，重点不是记住一长串 API，而是先搞清三件事：对象怎样转成 JSON、JSON 怎样还原成对象，以及字段名、空值、时间格式这些细节为什么总容易出问题。

工作里为什么总要和JSON打交道？因为前后端数据交换用JSON、调用Web API返回JSON、配置文件也常用JSON。序列化是对象转JSON，反序列化是JSON转对象。

C#处理JSON主要用两个库：`System.Text.Json`（.NET内置，性能好）和`Newtonsoft.Json`（功能更强，兼容性好）。新项目优先用`System.Text.Json`，老项目通常用`Newtonsoft.Json`。

```csharp
using System.Text.Json;

// 对象转JSON（序列化）
var user = new User { Id = 1, Name = "Alice", Age = 20 };
string json = JsonSerializer.Serialize(user);

// JSON转对象（反序列化）
User user = JsonSerializer.Deserialize<User>(json);
```

真正常踩坑的是：**属性名大小写敏感**。JSON里是`"name"`但C#属性是`Name`会反序列化失败。解决方法是设置`PropertyNameCaseInsensitive = true`或用`[JsonPropertyName]`特性。

```csharp
// 忽略大小写
var options = new JsonSerializerOptions 
{ 
    PropertyNameCaseInsensitive = true 
};
User user = JsonSerializer.Deserialize<User>(json, options);
```

面试里这类题常被问成：如何处理JSON属性名和C#属性名不一致的情况？答案是设置`PropertyNameCaseInsensitive = true`忽略大小写，或用`[JsonPropertyName]`特性指定JSON属性名。

### 时间与字符串

这两个东西为什么最容易藏坑？因为时间涉及时区、格式化、本地化，字符串涉及不可变、编码、大量拼接。工作中最常见的问题都集中在这两个类型上。

时间处理最常见的就是：获取当前时间、格式化时间、计算时间差。`DateTime`是最常用的类型，但要注意它不包含时区信息。需要时区信息用`DateTimeOffset`。

```csharp
// 获取当前时间
DateTime now = DateTime.Now;  // 本地时间
DateTime utcNow = DateTime.UtcNow;  // UTC时间

// 格式化时间
string str = now.ToString("yyyy-MM-dd HH:mm:ss");

// 时间计算
DateTime tomorrow = now.AddDays(1);
TimeSpan diff = end - start;
```

真正常踩坑的是：`DateTime.Now` vs `DateTime.UtcNow`，存储时间到数据库建议用UTC时间避免时区问题。字符串解析时格式不匹配会抛异常，用`TryParse`更安全。

字符串处理工作中最常见的场景：判断空字符串、去空格、分割、替换。记住`string`是不可变的，每次修改都创建新对象，大量拼接用`StringBuilder`。

```csharp
// 判断空字符串
bool isEmpty = string.IsNullOrWhiteSpace(text);  // 推荐

// 分割和拼接
string[] names = csv.Split(',');
string joined = string.Join(", ", names);

// 字符串插值（推荐）
string message = $"{name} is {age} years old";

// 大量拼接用StringBuilder
var sb = new StringBuilder();
for (int i = 0; i < 1000; i++)
{
    sb.Append(i);
}
```

### 配置与日志

程序离开本地以后，为什么就离不开配置和日志？因为开发环境和生产环境的数据库连接不同、API密钥不同、日志级别不同。配置用来管理这些差异，日志用来定位问题。

.NET应用的配置通常放在`appsettings.json`文件中，通过`IConfiguration`接口读取。不同环境（开发、测试、生产）有不同的配置文件。

```csharp
// 读取配置
public class MyService
{
    private readonly IConfiguration _config;
    
    public MyService(IConfiguration config)
    {
        _config = config;
    }
    
    public void DoSomething()
    {
        string apiKey = _config["AppSettings:ApiKey"];
        string connString = _config.GetConnectionString("DefaultConnection");
    }
}
```

真正常踩坑的是：不要把敏感信息（密码、密钥）直接写在代码里，要放在配置文件或环境变量中。生产环境的敏感信息用Azure Key Vault或AWS Secrets Manager管理。

日志不是为了多打，而是为了定位问题。工作中最常见的场景：记录关键操作（用户登录、订单创建）、记录错误信息和堆栈、记录外部调用（数据库查询、API调用）。

```csharp
public class MyService
{
    private readonly ILogger<MyService> _logger;
    
    public void ProcessData(int id)
    {
        _logger.LogInformation("开始处理数据，ID: {Id}", id);
        
        try
        {
            // 处理数据
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "处理数据失败，ID: {Id}", id);
            throw;
        }
    }
}
```

日志级别：Trace（最详细）、Debug（调试信息）、Information（一般信息）、Warning（警告）、Error（错误）、Critical（严重错误）。开发环境用Debug级别，生产环境用Information或Warning级别。

工作里通常先从这几个点查起：日志太多会影响性能和存储，要控制日志级别。日志太少会导致问题难以排查，关键操作和错误必须记录。日志要结构化（用占位符`{Id}`而不是字符串拼接），方便查询和分析。不要记录敏感信息（密码、身份证号）。

### 运行保障与稳定性策略

这部分内容在很多语言笔记里都会被忽略，但 Python 面试笔记把它单独拉成了“运行保障”模块，这个做法很值得借过来：真正进入工作后，程序能不能稳定跑，往往不是由语法决定的，而是由超时、重试、日志、异常边界、资源治理这些策略决定的。fileciteturn28file1L11-L17 fileciteturn28file6L25-L39

先抓一条总线：**日志负责留下足够上下文，异常边界负责把错误翻译到合适层级，超时/重试/幂等/限流负责把故障控制在可承受范围内。** 这几件事不是独立知识点，而是一整条“让系统可定位、可恢复、可保护”的链路。

不是所有失败都适合重试，也不是所有重试都安全。网络抖动、偶发超时、下游瞬时不可用，这些往往可以重试；参数错误、业务校验失败、幂等性不成立的写操作，盲目重试只会把问题放大。真正稳妥的思路通常是：先判断错误类型，再决定是否重试，并且尽量让写操作具备幂等性。

```csharp
using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(3));

try
{
    var response = await httpClient.GetAsync(url, cts.Token);
    response.EnsureSuccessStatusCode();
}
catch (OperationCanceledException)
{
    logger.LogWarning("请求超时：{Url}", url);
}
```

如果把“日志、错误边界与可观测”放在一起看，思路会更清楚。日志不是为了多打，而是为了在出问题时把请求标识、业务标识、异常链和关键上下文串起来。异常边界则决定了谁保留底层细节，谁转换成业务语义，谁决定是否重试或降级。这一点和 Python 笔记里 adapter/service/entry 三层的讲法很像：底层保留根因，中层做策略，入口层做对外返回。fileciteturn28file6L1-L7

| 策略 | 解决什么问题         | 最容易犯的错                 |
| ---- | -------------------- | ---------------------------- |
| 超时 | 防止调用无限等待     | 把超时当成默认值，不显式设置 |
| 重试 | 处理瞬时失败         | 对不可重试错误也盲目重试     |
| 幂等 | 保证重复请求结果可控 | 写操作没有幂等键却直接重试   |
| 限流 | 保护自己和下游       | 只盯吞吐，不看失败扩散       |

这一节最后要形成的不是术语记忆，而是工程判断：**先让问题可观察，再让故障可控制。** 你能把“超时、重试、幂等、限流”这条线讲清楚，面试官通常会觉得你不是只写过 demo，而是开始站到生产环境的角度看问题了。

## .NET 工程与工具链

这一章开始把视角从“语言本身”稍微拉远一点，转到一个普通 .NET 项目是怎么被组织、构建、运行和交付的。前面几章更多是在讲代码怎么写，这一章关注的是代码写完以后，项目如何落到工程里。对刚接触 C# 的人来说，最容易困惑的其实不是语法，而是 `.csproj`、解决方案、NuGet、命令行和发布流程这些东西到底是什么关系。

可以先把主线记成一句话：代码写在项目里，项目被解决方案组织，依赖通过 NuGet 管理，构建和运行由 `dotnet` 工具链负责，最终通过发布把应用带到目标环境。只要这条线不乱，后面很多工程细节都会变得顺手。

### 项目文件与解决方案

一个.NET项目的核心是`.csproj`文件（C# Project），它定义了项目的基本信息、依赖包、编译选项。多个项目可以组织在一个`.sln`文件（Solution）中。理解这两个文件，就理解了.NET项目是怎么组织的。

**`.csproj`：项目真正的配置入口。**

`.csproj`是XML格式，但现在的SDK风格项目非常简洁，通常只有几行：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Newtonsoft.Json" Version="13.0.3" />
  </ItemGroup>
</Project>
```

这个文件告诉编译器：这是一个可执行程序（`OutputType=Exe`），目标框架是.NET 8.0，启用了可空引用类型检查，依赖`Newtonsoft.Json`包。

**常见的项目类型：**

| SDK                        | 项目类型    | OutputType    | 典型用途           |
| -------------------------- | ----------- | ------------- | ------------------ |
| `Microsoft.NET.Sdk`        | 控制台/类库 | Exe / Library | 控制台程序、类库   |
| `Microsoft.NET.Sdk.Web`    | Web应用     | Exe           | Web API、MVC       |
| `Microsoft.NET.Sdk.Worker` | 后台服务    | Exe           | 后台任务、定时任务 |

工作中最常见的就是控制台项目和Web项目。类库项目用于封装可复用的代码，`OutputType`是`Library`，编译后生成`.dll`文件。

**`.sln`：把多个项目组织到一起的壳。**

解决方案是多个项目的容器，用于组织大型应用。一个典型的Web应用可能有这样的结构：

```
MySolution.sln
├── MyApi/              (Web API项目)
├── MyApi.Core/         (业务逻辑类库)
├── MyApi.Data/         (数据访问类库)
└── MyApi.Tests/        (单元测试项目)
```

解决方案文件本身不需要手动编辑，用`dotnet sln`命令管理就行。工作中通常是：先创建解决方案，再往里面添加项目。
项目文件之外，还有一个常被忽略但很值得知道的词：**程序集（Assembly）**。最朴素地说，程序集就是 .NET 编译后的交付单元，常见形式是 `.dll` 或 `.exe`。从阅读角度看，程序集决定了 `internal` 的边界；从运行角度看，它承载了类型、资源、元数据和版本信息；从部署角度看，发布产物本质上也是围绕一组程序集组织起来的。

这也是为什么“项目”和“程序集”不能完全画等号。通常一个 `.csproj` 会产出一个程序集，但一个解决方案可以包含多个项目、多个程序集，它们通过项目引用或包引用协作。你在读多项目方案时，可以先把 `sln` 看成“组织容器”，把项目看成“构建单位”，把程序集看成“编译后的交付单位”。这三个层级分开以后，很多工具链问题就会清楚得多。

### NuGet 包管理

NuGet 对 .NET 项目，就像 npm 对 Node.js、pip 对 Python：它负责把第三方依赖引入到项目里，并帮助你管理版本。工作里这节真正重要的不是背命令，而是理解包引用写在哪里、包下载到哪里、项目为什么会因为版本不一致而出问题。几乎所有常见库——JSON 处理、日志、测试框架、数据访问、对象映射——最终都会落回到 NuGet 这条线。

先抓住两个最容易混淆的点。第一，`using` 只是让当前文件“看得见”某个命名空间里的类型，真正让项目拿到第三方库的是 `.csproj` 里的 `<PackageReference>`。第二，包下载到全局缓存目录，不会一份份复制进项目文件夹，所以“项目里没看到 dll 并不代表没引用成功”。把这两个点理顺以后，NuGet 相关的大部分问题都会顺很多。

包管理最常做的操作其实不多：

```bash
# 添加包
dotnet add package Newtonsoft.Json

# 添加指定版本的包
dotnet add package Serilog --version 3.1.0

# 移除包
dotnet remove package Newtonsoft.Json

# 列出项目的所有包
dotnet list package

# 更新包到最新版本
dotnet add package Newtonsoft.Json
```

添加包后，`.csproj`文件会自动更新，添加一行`<PackageReference>`。包的实际文件下载到全局缓存目录（通常是`~/.nuget/packages`），不会复制到项目目录，节省空间。

版本管理真正需要记的，不是命令，而是升级边界。

NuGet支持语义化版本（Semantic Versioning）：`主版本.次版本.修订号`，如`13.0.3`。

```xml
<!-- 精确版本 -->
<PackageReference Include="Newtonsoft.Json" Version="13.0.3" />

<!-- 最低版本（允许更新） -->
<PackageReference Include="Newtonsoft.Json" Version="13.0.*" />

<!-- 版本范围 -->
<PackageReference Include="Newtonsoft.Json" Version="[13.0.0,14.0.0)" />
```

工作中通常用精确版本，避免自动更新导致的兼容性问题。大版本更新（如12.x到13.x）可能有破坏性变更，要谨慎升级。

**常见包的价值，主要在于它们解决的通用问题。**

| 包名                                                         | 用途       | 典型场景         |
| ------------------------------------------------------------ | ---------- | ---------------- |
| `Newtonsoft.Json`                                            | JSON序列化 | 老项目的JSON处理 |
| `Serilog`                                                    | 日志库     | 结构化日志       |
| `Dapper`                                                     | 轻量ORM    | 数据库访问       |
| `AutoMapper`                                                 | 对象映射   | DTO转换          |
| `FluentValidation`                                           | 数据验证   | 输入验证         |
| `xUnit` / `NUnit`                                            | 单元测试   | 测试框架         |
| 真正进入团队协作后，NuGet 不只是“下载包”这么简单，它还关系到版本策略和依赖边界。一个常见误区是：看到新版本就顺手升级，或者不同项目各自引用不同版本的同一包。短期看可能没问题，长期看很容易把解决方案拖进兼容性泥潭。更稳妥的习惯通常是：先确认升级动机，再看破坏性变更说明，最后在测试通过后统一升级。 |            |                  |

如果项目里已经开始用 `Directory.Packages.props` 或集中包版本管理，也不用把它想得太复杂。它做的事情其实很朴素：把“版本号写在哪”从分散到各个项目里，改成尽量集中统一管理。对初学者来说，先知道这类机制存在、知道它是在解决“多项目版本漂移”问题，就已经很够用了。

### using、命名空间与引用关系

这一章如果只讲 `.csproj`、NuGet 和 `dotnet` 命令，读者还是容易把“项目能跑起来”和“项目为什么这样组织”割裂开。更顺手的理解方式是把三层东西分开看：**命名空间**负责组织类型名，**项目**负责定义构建边界，**程序集**负责承载编译后的交付结果。把这三层分开以后，多项目解决方案就不会只剩下一堆文件名，而会变成一张比较清楚的依赖图。

先抓住几个最容易混淆的点。`using` 只是告诉当前文件“我想引用哪个命名空间里的类型”，它不会替你建立编译依赖；真正让项目之间能互相看到类型的，是 `.csproj` 里的 `ProjectReference` 或 `PackageReference`。很多初学者会觉得“我明明写了 `using StudentManager.Domain;`，为什么编译器还报找不到类型”，真正缺的通常不是 `using`，而是项目引用。

| 概念               | 更偏哪一层   | 先这样理解就够了                         |
| ------------------ | ------------ | ---------------------------------------- |
| `using`            | 代码文件     | 简化命名空间引用，让文件里不用反复写全名 |
| `namespace`        | 代码组织     | 给类型分组，避免命名冲突                 |
| 项目 `.csproj`     | 构建层       | 决定如何编译、依赖谁、输出什么           |
| 程序集 `.dll/.exe` | 运行与交付层 | 编译后的实际产物，会被加载、部署和引用   |
| 项目引用           | 构建层       | 依赖自己维护的另一个项目                 |
| 包引用             | 构建层       | 依赖外部或内部发布好的 NuGet 包          |

例如一个典型解决方案可以拆成 `Domain`、`Application`、`Infrastructure`、`Web` 四个项目。你在 `Web` 项目里看到 `using StudentManager.Domain;`，只是说明当前文件想用 Domain 里的类型；真正决定它能不能编译通过的，是 `Web.csproj` 里有没有对应的项目引用。

```xml
<ItemGroup>
  <ProjectReference Include="..\StudentManager.Domain\StudentManager.Domain.csproj" />
</ItemGroup>
```

```csharp
using StudentManager.Domain;
```

对复习来说，这一节最重要的不是背术语，而是建立一个判断顺序：**先看解决方案和项目引用，判断模块边界；再看命名空间，判断代码组织；最后再看具体类型和调用。** 你只要把这个顺序养成习惯，读一个陌生的 .NET 项目会轻松很多。

### dotnet CLI 常用命令

`dotnet`命令行工具是.NET开发的核心，涵盖了创建、构建、运行、测试、发布的全流程。记住最常用的几个命令就够了，其他的用到再查。

命令行里最常见的是项目和解决方案管理：

```bash
# 创建新项目
dotnet new console -n MyApp          # 控制台项目
dotnet new webapi -n MyApi           # Web API项目
dotnet new classlib -n MyLib         # 类库项目

# 创建解决方案
dotnet new sln -n MySolution

# 添加项目到解决方案
dotnet sln add MyApp/MyApp.csproj
dotnet sln add MyLib/MyLib.csproj

# 列出解决方案中的项目
dotnet sln list
```

依赖管理的重点是让项目状态可重复：

```bash
# 添加项目引用（MyApp引用MyLib）
dotnet add MyApp/MyApp.csproj reference MyLib/MyLib.csproj

# 添加NuGet包
dotnet add package Newtonsoft.Json

# 恢复依赖（下载包）
dotnet restore
```

构建、运行、测试和发布是同一条工程链上的不同节点：

这是最常用的四个命令，下一节会详细讲它们的流程。

```bash
# 构建项目
dotnet build

# 运行项目
dotnet run

# 运行测试
dotnet test

# 发布项目
dotnet publish -c Release -o ./publish
```

有些基础内容在教材里会放进“预处理器”一章，但对当前这份笔记来说，最值得知道的其实只有两类：条件编译和区域折叠。条件编译用 `#if / #endif` 这类指令，根据编译符号决定一段代码是否参与编译；区域折叠 `#region` 则更多是给阅读器或编辑器服务，用来把一组代码收起来。

```csharp
#if DEBUG
Console.WriteLine("当前是调试构建");
#endif
```

这类写法不算高频主线，但你在实际项目里确实会看到，尤其是日志开关、平台差异、调试辅助代码。对入门阶段来说，知道“这是编译期控制，不是运行时 if”就够了，不必把预处理器学成一大章。

### 构建、运行、测试与发布

理解 .NET 项目的生命周期，其实就是理解四个动作：**build** 把代码编译出来，**run** 把程序跑起来，**test** 验证规则没坏，**publish** 产出可交付结果。旧稿里有一句很值得保留：从开发到部署的整条链路，不是命令越多越厉害，而是你是否知道每一步到底在解决什么问题。fileciteturn29file12L3-L9

`dotnet build` 负责把源码编译成程序集，通常输出到 `bin/Debug` 或 `bin/Release`。开发阶段最常用的是 Debug，因为它保留调试信息；交付阶段更常用 Release，因为它会做优化，产物也更接近真实部署环境。`dotnet run` 则更像“开发时直接启动当前项目”，它会在需要时先 build 再运行，所以适合日常迭代。

`dotnet test` 的意义也不只是“跑一遍测试框架”。它是把“这次改动有没有破坏已知规则”提前变成事实，而不是等到手工验证或上线后才发现。只要团队开始有 CI，这条命令就会变成提交前和合并前的基本门槛。

```bash
dotnet build
dotnet run
dotnet test
dotnet publish -c Release -o ./publish
```

最容易混的是 publish。很多人会把它理解成“上线部署”，其实 publish 只是把项目整理成更适合交付的产物：程序集、依赖、配置、静态资源都被放到一个更清晰的输出目录里。真正的部署还包括把这些产物放进服务器、容器或云平台，并补上环境变量、日志、反向代理和启动配置。

```bash
# 依赖框架发布
dotnet publish -c Release -o ./publish

# 自包含发布
dotnet publish -c Release -r linux-x64 --self-contained -o ./publish
```

旧稿里提到一个很实用的交付判断：publish 的选择取决于部署环境与体积、启动、兼容性的权衡。服务器本身已经安装 .NET 时，依赖框架发布通常更轻；如果目标环境没有运行时，或者你更想把运行环境一起打包，自包含发布会更稳，但体积也会明显变大。fileciteturn28file4L1-L5

对复习来说，这一节真正要记住的是：**build 解决“能不能编译”，run 解决“本地能不能跑”，test 解决“规则有没有被改坏”，publish 解决“能不能稳定交付”。** 这四步串起来以后，项目从写代码到上线的主线就完整了。

### 预处理器与条件编译

预处理器这块不需要学成一整章，但在基础补强里值得出现，因为你在项目里迟早会看到 `#if`、`#nullable`、`#pragma` 或 `#region`。最稳的理解方式是：它们不属于运行时逻辑，而是**告诉编译器和分析器如何看待这段代码**。

真正高频的其实只有两类。第一类是条件编译，例如在 Debug 环境下编进调试辅助代码，在 Release 环境下把它排除掉。第二类是分析控制，例如用 `#nullable` 切换可空上下文，或用 `#pragma warning disable` 局部压制某条警告。至于 `#region`，它更多是给编辑器折叠代码用的，不会影响程序行为。

```csharp
#if DEBUG
Console.WriteLine("当前是调试构建");
#endif
```

这一节最重要的边界意识是：**预处理器适合做少量编译期控制，不适合拿来承载复杂业务分支。** 真正影响系统行为的环境差异，更应该放到配置文件、环境变量和依赖注入里。

## 异步、并发与测试

从这一章开始，重点不再是“如何把代码写出来”，而是“如何把代码写得更稳、更适合真实工作”。很多人第一次接触异步和并发时，会同时被一堆名词砸到：同步、异步、并发、并行、线程、Task、线程池、取消令牌。真正需要先抓住的，其实不是所有定义，而是它们分别在解决什么问题。

可以先这样理解：异步主要解决等待浪费，并发主要解决多件事同时推进，而测试是在代码复杂起来以后帮助你确认行为没有悄悄变掉。把这三条线放在一起看，读起来会比一块一块拆开更顺。

### 异步与并发

**先看问题场景。**

假设你写了一个 Web API，处理用户请求：

```csharp
// 同步版本
public string GetUserData(int userId)
{
    var user = database.Query(userId);        // 等待数据库，100ms
    var orders = orderService.GetOrders(userId);  // 等待接口，200ms
    return $"{user.Name} has {orders.Count} orders";
}
// 总耗时：300ms，期间线程一直在等待
```

问题：

- 线程在等待数据库、网络时什么都不做，浪费资源
- 服务器线程数有限，大量请求会耗尽线程池
- 用户体验差，响应慢

**异步最先解决的是等待浪费。**

```csharp
// 异步版本
public async Task<string> GetUserDataAsync(int userId)
{
    var user = await database.QueryAsync(userId);        // 释放线程，等待完成
    var orders = await orderService.GetOrdersAsync(userId);  // 释放线程，等待完成
    return $"{user.Name} has {orders.Count} orders";
}
// 总耗时：300ms，但线程可以处理其他请求
```

**关键区别：**

- 同步：线程一直等待，不能做其他事
- 异步：等待时释放线程，线程可以处理其他请求

**同步和异步的区别，最好放到“等待时谁被占住”这个角度理解。**

| 特性         | 同步       | 异步       |
| ------------ | ---------- | ---------- |
| **线程占用** | 一直占用   | 等待时释放 |
| **吞吐量**   | 低         | 高         |
| **响应性**   | 阻塞       | 不阻塞     |
| **复杂度**   | 简单       | 稍复杂     |
| **适用场景** | CPU 密集型 | I/O 密集型 |

**I/O 密集和 CPU 密集，决定了你更该优先考虑哪种优化方向。**

```csharp
// I/O 密集：等待外部资源
await File.ReadAllTextAsync("file.txt");  // 等待磁盘
await httpClient.GetAsync("https://api.com");  // 等待网络
await database.QueryAsync("SELECT ...");  // 等待数据库

// CPU 密集：计算任务
for (int i = 0; i < 1000000; i++)
{
    result += Math.Sqrt(i);  // CPU 计算
}
```

| 类型         | 特点         | 瓶颈               | 优化方式                   |
| ------------ | ------------ | ------------------ | -------------------------- |
| **I/O 密集** | 等待外部资源 | 网络、磁盘、数据库 | 异步（async/await）        |
| **CPU 密集** | 计算任务     | CPU                | 并行（Task.Run、Parallel） |

**并发、并行和异步很容易一起出现，但它们不是一回事。**

这三个概念容易混淆，先这样记：

| 概念     | 含义             | 实现方式            | 典型场景     |
| -------- | ---------------- | ------------------- | ------------ |
| **并发** | 多个任务交替执行 | 单核 CPU 时间片轮转 | 处理多个请求 |
| **并行** | 多个任务同时执行 | 多核 CPU 同时运行   | 大量计算     |
| **异步** | 不阻塞等待       | 释放线程，回调通知  | I/O 操作     |

**简单理解：**

- 并发：看起来同时做多件事（实际是快速切换）
- 并行：真的同时做多件事（多个 CPU 核心）
- 异步：不等结果，先做其他事，结果好了再处理

**容易混淆的点**

**1. 异步不等于多线程**

- 异步是编程模型，多线程是实现方式
- 异步可以用单线程实现（事件循环）
- I/O 异步通常不需要额外线程

**2. async/await 不会自动提升性能**

- 只有 I/O 操作才能从异步中受益
- CPU 密集型任务用异步反而更慢
- 异步的价值是提高吞吐量，不是单个请求速度

**3. 什么时候用异步？**

- I/O 操作：文件、网络、数据库
- Web 应用：处理大量并发请求
- UI 应用：避免界面卡顿
- 不要：纯计算任务、简单控制台程序

**4. 面试常问：异步和多线程的区别**

- 异步是编程模型，关注"不阻塞等待"
- 多线程是实现方式，关注"并行执行"
- 异步可以用单线程实现（如 Node.js）
- I/O 异步不需要额外线程，CPU 并行需要多线程

### Task、async 与 await

`Task` 代表一个异步操作，可以理解为"未来会完成的工作"：

```csharp
// Task 代表一个异步操作
Task task = DoSomethingAsync();

// Task<T> 代表有返回值的异步操作
Task<int> task = GetNumberAsync();
int result = await task;
```

**Task 不是线程：**

- Task 是异步操作的抽象
- 一个 Task 可能不占用线程（I/O 操作）
- 一个 Task 可能占用线程（CPU 操作）

**`async/await` 的重点不是语法糖本身，而是把异步流程写得更像顺序代码。**

```csharp
// async 标记方法是异步的
public async Task<string> GetDataAsync()
{
    // await 等待异步操作完成
    string data = await ReadFileAsync();
    return data;
}

// 调用异步方法
string result = await GetDataAsync();
```

**关键规则：**

- `async` 方法必须返回 `Task` 或 `Task<T>`
- `await` 只能在 `async` 方法中使用
- `await` 会暂停方法执行，等待 Task 完成
- `await` 不会阻塞线程，线程会被释放

**返回类型会暴露这段异步代码准备怎么被使用。**

```csharp
// Task - 无返回值
public async Task ProcessAsync()
{
    await Task.Delay(1000);
}

// Task<T> - 有返回值
public async Task<int> GetNumberAsync()
{
    await Task.Delay(1000);
    return 42;
}

// void - 只用于事件处理器（不推荐）
public async void Button_Click(object sender, EventArgs e)
{
    await ProcessAsync();
}
```

**返回类型选择：**

- 有返回值：`Task<T>`
- 无返回值：`Task`
- 事件处理器：`async void`（其他情况避免使用）

**工作里最常见的异步操作，通常都和等待外部资源有关。**

```csharp
// 文件 I/O
string content = await File.ReadAllTextAsync("file.txt");
await File.WriteAllTextAsync("file.txt", "content");

// HTTP 请求
using HttpClient client = new HttpClient();
string response = await client.GetStringAsync("https://api.com");

// 数据库查询（Entity Framework）
var users = await dbContext.Users.ToListAsync();

// 延迟
await Task.Delay(1000);  // 等待 1 秒

// 并行执行多个任务
Task<string> task1 = GetData1Async();
Task<string> task2 = GetData2Async();
await Task.WhenAll(task1, task2);
string result1 = task1.Result;
string result2 = task2.Result;
```

**Task.WhenAll 与顺序 await**

```csharp
// 顺序 await（串行）
var data1 = await GetData1Async();  // 等待 1 秒
var data2 = await GetData2Async();  // 等待 1 秒
// 总耗时：2 秒

// Task.WhenAll（并行）
var task1 = GetData1Async();
var task2 = GetData2Async();
await Task.WhenAll(task1, task2);
var data1 = task1.Result;
var data2 = task2.Result;
// 总耗时：1 秒（并行执行）
```

| 方式             | 执行顺序 | 总耗时     | 适用场景   |
| ---------------- | -------- | ---------- | ---------- |
| **顺序 await**   | 串行     | 累加       | 有依赖关系 |
| **Task.WhenAll** | 并行     | 最长的一个 | 无依赖关系 |

**Task 与 Thread**

| 特性         | Task     | Thread                 |
| ------------ | -------- | ---------------------- |
| **抽象层次** | 高层抽象 | 低层抽象               |
| **资源占用** | 轻量     | 重量                   |
| **适用场景** | 异步操作 | 需要精确控制线程       |
| **推荐程度** | 推荐     | 不推荐（除非特殊需求） |

```csharp
// Task（推荐）
await Task.Run(() => DoWork());

// Thread（不推荐，除非特殊需求）
Thread thread = new Thread(() => DoWork());
thread.Start();
thread.Join();
```

**容易混淆的点**

**1. async 方法不会自动异步执行**

```csharp
public async Task<int> GetNumberAsync()
{
    return 42;  // 没有 await，实际是同步执行
}

// 正确：有真正的异步操作
public async Task<int> GetNumberAsync()
{
    await Task.Delay(1000);
    return 42;
}
```

**2. 不要阻塞异步方法**

```csharp
// 错误：阻塞异步方法
Task<string> task = GetDataAsync();
string result = task.Result;  // 阻塞，可能死锁

// 正确：await
string result = await GetDataAsync();
```

**3. async void 的危险**

- 异常无法捕获
- 无法 await
- 只用于事件处理器

**4. ConfigureAwait(false) 是什么？**

- 用于库代码，避免捕获同步上下文
- 应用代码通常不需要
- 面试可能会问，但工作中用得少

**5. 面试常问：async/await 的原理**

- 编译器生成状态机
- await 时保存状态，释放线程
- 操作完成后恢复状态，继续执行
- 不需要深入理解，知道"释放线程"就够了

### 线程安全与并发误区

多个线程同时访问共享数据时，不会出现数据错误或不一致：

```csharp
// 不安全的代码
public class Counter
{
    private int count = 0;
    
    public void Increment()
    {
        count++;  // 不是原子操作，多线程不安全
    }
}

// 多线程调用
var counter = new Counter();
Parallel.For(0, 1000, i => counter.Increment());
Console.WriteLine(counter.count);  // 结果不确定，可能小于 1000
```

**为什么不安全？**

- `count++` 实际是三步：读取、加1、写回
- 多个线程可能同时读取相同的值
- 导致部分增量丢失

**线程安全的实现方式**

```csharp
// 方式1：lock（最常用）
public class Counter
{
    private int count = 0;
    private readonly object lockObj = new object();
    
    public void Increment()
    {
        lock (lockObj)
        {
            count++;
        }
    }
}

// 方式2：Interlocked（原子操作）
public class Counter
{
    private int count = 0;
    
    public void Increment()
    {
        Interlocked.Increment(ref count);
    }
}

// 方式3：线程安全集合
ConcurrentDictionary<string, int> dict = new ConcurrentDictionary<string, int>();
dict.TryAdd("key", 1);
dict.TryUpdate("key", 2, 1);
```

**共享可变状态几乎是并发问题的源头。**

```csharp
// 危险：多个线程修改同一个 List
List<int> numbers = new List<int>();

Parallel.For(0, 1000, i =>
{
    numbers.Add(i);  // 不安全，可能抛异常或数据丢失
});

// 安全：使用线程安全集合
ConcurrentBag<int> numbers = new ConcurrentBag<int>();

Parallel.For(0, 1000, i =>
{
    numbers.Add(i);  // 安全
});
```

**关键原则：**

- 避免共享可变状态
- 如果必须共享，使用锁或线程安全集合
- 优先使用不可变对象

**线程安全集合**

| 集合                       | 线程安全版本                         | 适用场景 |
| -------------------------- | ------------------------------------ | -------- |
| `List<T>`                  | `ConcurrentBag<T>`                   | 无序集合 |
| `Dictionary<TKey, TValue>` | `ConcurrentDictionary<TKey, TValue>` | 键值对   |
| `Queue<T>`                 | `ConcurrentQueue<T>`                 | 先进先出 |
| `Stack<T>`                 | `ConcurrentStack<T>`                 | 后进先出 |

**死锁通常不是因为“多线程很危险”，而是因为资源等待顺序出了问题。**

```csharp
// 死锁示例
object lock1 = new object();
object lock2 = new object();

Task.Run(() =>
{
    lock (lock1)
    {
        Thread.Sleep(100);
        lock (lock2)  // 等待 lock2
        {
            Console.WriteLine("Task 1");
        }
    }
});

Task.Run(() =>
{
    lock (lock2)
    {
        Thread.Sleep(100);
        lock (lock1)  // 等待 lock1
        {
            Console.WriteLine("Task 2");
        }
    }
});
// 两个任务互相等待，死锁
```

**避免死锁：**

- 按固定顺序获取锁
- 减少锁的持有时间
- 使用 `Monitor.TryEnter` 设置超时

**容易混淆的点**

**1. "能跑"不等于"线程安全"**

- 单线程测试通过不代表多线程安全
- 并发问题可能偶尔出现，难以复现
- 必须用压力测试验证

**2. 异步不等于线程安全**

- `async/await` 不保证线程安全
- 多个异步操作可能同时修改共享数据
- 仍然需要锁或线程安全集合

**3. lock 的性能影响**

- lock 会降低并发性能
- 锁的粒度要合适：太大影响性能，太小容易死锁
- 能避免共享状态就避免

**4. 什么时候需要考虑线程安全？**

- 多线程环境（Parallel、Task.Run）
- Web 应用的单例服务
- 静态变量
- 不需要：局部变量、每次请求创建的对象

**5. 面试常问：如何保证线程安全？**

- 避免共享可变状态
- 使用 lock 或 Interlocked
- 使用线程安全集合（ConcurrentDictionary）
- 使用不可变对象

### 取消、异常与异步陷阱

**取消不是异常流程的补丁，而是异步代码里很正常的一部分。**

```csharp
// 使用 CancellationToken
public async Task ProcessDataAsync(CancellationToken cancellationToken)
{
    for (int i = 0; i < 1000; i++)
    {
        // 检查是否取消
        cancellationToken.ThrowIfCancellationRequested();
        
        await Task.Delay(100, cancellationToken);
        // 处理数据
    }
}

// 调用
CancellationTokenSource cts = new CancellationTokenSource();

// 启动任务
Task task = ProcessDataAsync(cts.Token);

// 5 秒后取消
await Task.Delay(5000);
cts.Cancel();

try
{
    await task;
}
catch (OperationCanceledException)
{
    Console.WriteLine("任务已取消");
}
```

**CancellationToken 的作用：**

- 通知异步操作应该取消
- 协作式取消，不是强制终止
- 常用于长时间运行的操作

**异步里的异常处理，仍然离不开边界和资源释放这两个关键词。**

```csharp
// 异常会被捕获并存储在 Task 中
public async Task<string> GetDataAsync()
{
    await Task.Delay(1000);
    throw new Exception("出错了");
}

// 调用时捕获异常
try
{
    string result = await GetDataAsync();
}
catch (Exception ex)
{
    Console.WriteLine($"捕获异常：{ex.Message}");
}
```

**异常传播要看你在什么边界等待结果。**

```csharp
// Task.WhenAll 中的异常
Task<string> task1 = GetData1Async();  // 抛异常
Task<string> task2 = GetData2Async();  // 抛异常

try
{
    await Task.WhenAll(task1, task2);
}
catch (Exception ex)
{
    // 只能捕获第一个异常
    Console.WriteLine(ex.Message);
    
    // 获取所有异常
    if (task1.IsFaulted)
        Console.WriteLine(task1.Exception);
    if (task2.IsFaulted)
        Console.WriteLine(task2.Exception);
}
```

**真正容易踩的坑，通常集中在几个地方。**

**1. 忘记 await**

```csharp
// 错误：忘记 await
public async Task ProcessAsync()
{
    SaveDataAsync();  // 没有 await，方法立即返回
    Console.WriteLine("完成");  // 可能在保存完成前执行
}

// 正确
public async Task ProcessAsync()
{
    await SaveDataAsync();
    Console.WriteLine("完成");
}
```

**2. async void 吞掉异常**

```csharp
// 危险：异常无法捕获
public async void ProcessAsync()
{
    throw new Exception("出错了");  // 异常会导致程序崩溃
}

// 正确：返回 Task
public async Task ProcessAsync()
{
    throw new Exception("出错了");  // 异常可以被捕获
}
```

**3. 在构造函数中使用 async**

```csharp
// 错误：构造函数不能是 async
public class MyClass
{
    public MyClass()
    {
        await InitAsync();  // 编译错误
    }
}

// 正确：使用工厂方法
public class MyClass
{
    private MyClass() { }
    
    public static async Task<MyClass> CreateAsync()
    {
        var obj = new MyClass();
        await obj.InitAsync();
        return obj;
    }
}
```

**4. 在循环中创建大量 Task**

```csharp
// 低效：创建大量 Task
List<Task> tasks = new List<Task>();
for (int i = 0; i < 10000; i++)
{
    tasks.Add(ProcessAsync(i));
}
await Task.WhenAll(tasks);

// 更好：限制并发数
SemaphoreSlim semaphore = new SemaphoreSlim(10);  // 最多 10 个并发
List<Task> tasks = new List<Task>();

for (int i = 0; i < 10000; i++)
{
    await semaphore.WaitAsync();
    tasks.Add(Task.Run(async () =>
    {
        try
        {
            await ProcessAsync(i);
        }
        finally
        {
            semaphore.Release();
        }
    }));
}
await Task.WhenAll(tasks);
```

**容易混淆的点**

**1. Task.Run 什么时候用？**

- CPU 密集型任务：用 `Task.Run`
- I/O 密集型任务：不需要 `Task.Run`
- 面试常问：什么时候用 `Task.Run`？

**2. ConfigureAwait(false) 什么时候用？**

- 库代码：用 `ConfigureAwait(false)`
- 应用代码：通常不需要
- 避免捕获同步上下文，提高性能

**3. 异步方法的命名约定**

- 异步方法以 `Async` 结尾
- 例如：`GetDataAsync`、`SaveAsync`
- 这是约定，不是强制

**4. 面试常问：async/await 的常见坑**

- 忘记 await
- async void 吞掉异常
- 阻塞异步方法（.Result、.Wait()）
- 在构造函数中使用 async

### 并发原语与异步桥接

到这一章后半段，值得再补两个旧稿里比较有辨识度、但当前主稿还偏轻的点：**并发原语**和**把回调改成 await**。前者解决“并发度如何被约束、共享状态如何被安全访问”，后者解决“老式事件/回调 API 怎么接入 async/await”。这两块不一定天天手写，但读真实项目代码时很常见。fileciteturn29file4L1-L5

先看并发原语。很多人一提线程安全就只想到 `lock`，但工程里更常见的往往是：用 `ConcurrentDictionary` 这类并发集合处理共享状态，用 `SemaphoreSlim` 限制同时运行的任务数。旧稿里那个 `StudentExporter` 的例子就很典型：真正重要的不是“我会不会并发”，而是“我会不会把并发度控制在系统能承受的范围内”。fileciteturn29file4L19-L37

```csharp
private readonly SemaphoreSlim _gate = new(initialCount: 2);

public async Task ExportAsync(string id, CancellationToken ct)
{
    await _gate.WaitAsync(ct);
    try
    {
        await Task.Delay(200, ct);
    }
    finally
    {
        _gate.Release();
    }
}
```

再看异步桥接。旧稿里有一块 `TaskCompletionSource<T>` 的内容非常值得保留：当你面对的是事件或回调，而你又想把它接到 `await` 风格里时，`TaskCompletionSource<T>` 就是那座桥。fileciteturn29file4L40-L48 你手动在合适的时机调用 `SetResult / SetException / SetCanceled`，外面就能正常 `await` 这个 `Task` 了。

`ValueTask<T>` 也值得至少知道名字。它不是“Task 的升级版”，而是一个偏性能取向的工具：当某个异步 API 很多时候可以同步完成时，用它能减少额外分配；但它的使用规则更严格，所以面试里通常点到为止即可。最稳妥的说法就是：**常规业务先用 Task，只有在明确有性能收益且团队也理解其约束时，再考虑 ValueTask。** fileciteturn29file5L40-L48

这一节真正想补上的，是一个更工程的底线：并发不是越高越好，异步也不是越复杂越先进。你能把“并发上限、共享状态最小化、取消与超时、旧接口桥接到新模型”这几件事讲清楚，就已经很够用了。

### 单元测试

单元测试这一节最容易被误解成“为了覆盖率写测试”，但在入门阶段更实用的理解是：测试是在帮你确认一个小块逻辑是否稳定，同时也在倒逼代码更容易拆分、更容易验证。真正会在工作里反复遇到的，不是测试框架本身有多少特性，而是哪些逻辑值得测、怎样让测试更容易写、失败时怎样快速定位原因。

单元测试这一节最容易被误解成“为了覆盖率写测试”，但在入门阶段更实用的理解是：测试是在帮你确认一个小块逻辑是否稳定，同时也在倒逼代码更容易拆分、更容易验证。真正会在工作里反复遇到的，不是测试框架本身有多少特性，而是哪些逻辑值得测、怎样让测试更容易写、失败时怎样快速定位原因。

单元测试是测试代码的最小单元（通常是方法）是否按预期工作：

```csharp
// 被测试的代码
public class Calculator
{
    public int Add(int a, int b)
    {
        return a + b;
    }
}

// 测试代码（xUnit）
public class CalculatorTests
{
    [Fact]
    public void Add_TwoNumbers_ReturnsSum()
    {
        // Arrange（准备）
        var calculator = new Calculator();
        
        // Act（执行）
        int result = calculator.Add(2, 3);
        
        // Assert（断言）
        Assert.Equal(5, result);
    }
}
```

**Arrange-Act-Assert 只是帮助你把测试写清楚的一种常见结构。**

这是单元测试的标准结构：

```csharp
[Fact]
public void ProcessOrder_ValidOrder_ReturnsSuccess()
{
    // Arrange：准备测试数据和依赖
    var order = new Order { Id = 1, Amount = 100 };
    var service = new OrderService();
    
    // Act：执行被测试的方法
    var result = service.ProcessOrder(order);
    
    // Assert：验证结果
    Assert.True(result.IsSuccess);
    Assert.Equal("订单处理成功", result.Message);
}
```

**测试命名写得好，测试本身就会更像文档。**

```csharp
// 推荐格式：MethodName_Scenario_ExpectedResult
[Fact]
public void Add_TwoPositiveNumbers_ReturnsSum() { }

[Fact]
public void Add_NegativeNumber_ReturnsCorrectResult() { }

[Fact]
public void Divide_ByZero_ThrowsException() { }
```

**命名要清晰：**

- 看名字就知道测试什么
- 看名字就知道预期结果
- 失败时容易定位问题

**以 xUnit 为例，常见特性并不多。**

```csharp
// [Fact]：单个测试
[Fact]
public void Test1() { }

// [Theory]：参数化测试
[Theory]
[InlineData(2, 3, 5)]
[InlineData(0, 0, 0)]
[InlineData(-1, 1, 0)]
public void Add_DifferentInputs_ReturnsExpectedSum(int a, int b, int expected)
{
    var calculator = new Calculator();
    int result = calculator.Add(a, b);
    Assert.Equal(expected, result);
}

// [Skip]：跳过测试
[Fact(Skip = "暂时跳过")]
public void Test2() { }
```

**单元测试与集成测试**

| 特性         | 单元测试    | 集成测试     |
| ------------ | ----------- | ------------ |
| **测试范围** | 单个方法/类 | 多个组件协作 |
| **依赖**     | Mock/Stub   | 真实依赖     |
| **速度**     | 快          | 慢           |
| **稳定性**   | 高          | 较低         |
| **典型场景** | 业务逻辑    | API、数据库  |

```csharp
// 单元测试：隔离依赖
[Fact]
public void CalculateDiscount_VipUser_Returns20Percent()
{
    var user = new User { IsVip = true };
    var service = new DiscountService();
    
    decimal discount = service.CalculateDiscount(user, 100);
    
    Assert.Equal(20, discount);
}

// 集成测试：使用真实数据库
[Fact]
public async Task GetUser_ExistingId_ReturnsUser()
{
    var dbContext = new AppDbContext(options);
    var repository = new UserRepository(dbContext);
    
    var user = await repository.GetByIdAsync(1);
    
    Assert.NotNull(user);
    Assert.Equal("Alice", user.Name);
}
```

**测试范围决定了失败时你能多快定位问题。**

**应该测试：**

- 业务逻辑
- 边界条件
- 异常情况
- 复杂算法

**不需要测试：**

- 简单的 getter/setter
- 框架代码
- 第三方库
- 私有方法（通过公开方法间接测试）

**容易混淆的点**

**1. 测试不是为了覆盖率**

- 覆盖率是指标，不是目标
- 100% 覆盖率不等于没有 bug
- 重点是测试关键逻辑和边界条件

**2. 测试应该独立**

- 每个测试应该独立运行
- 不依赖其他测试的执行顺序
- 不共享状态

**3. 测试应该快速**

- 单元测试应该在毫秒级完成
- 慢的测试会降低开发效率
- 慢的测试通常是集成测试

**4. 面试常问：为什么要写单元测试？**

- 验证代码正确性
- 防止回归（修改代码后确保原有功能不受影响）
- 作为文档（展示如何使用代码）
- 提高代码质量（可测试的代码通常设计更好）
  测试这一节如果只理解成“写几个断言”，就会觉得它很机械；更稳的理解是：**测试是在给代码的边界和行为写说明。** 当你看到一个测试方法命名清晰、输入输出明确，其实它同时在扮演文档角色。也正因为如此，测试不该过度依赖实现细节，否则一重构就全碎了。入门阶段先把“测行为，不测实现细节”这个直觉建立起来，比背更多测试框架 API 更重要。

### 断言、Mock 与测试价值

如果单元测试只剩“会不会写 Assert.Equal”，这一节就会很薄。更像 Python 笔记的写法，应该先把测试放回工程目标里看：测试的价值不是凑覆盖率，而是把规则、边界和回归风险变成可重复验证的事实。Python 那份在讲测试时很强调“测试不碰真实外部依赖、fixture 管理依赖、优先测规则与边界条件”，这套思路放到 C# 里同样成立。fileciteturn28file11L18-L24

先说断言。断言只是测试的语言，不是测试本身。你真正该关心的是：测试在说明什么规则，失败后能不能让人快速定位。很多初学者会写一长串断言去“证明方法能跑”，但更稳的做法是让每个测试围绕一个清晰结论，例如“空 id 应该失败”“重复注册应该返回已存在”“超时应该转换成业务异常”。

```csharp
[Fact]
public void Empty_Id_Should_Fail()
{
    var svc = new StudentService();

    var (ok, message) = svc.TryRegister("", "Alice");

    Assert.False(ok);
    Assert.Equal("Id 不能为空", message);
}
```

再说 Mock。Mock 的价值不是“模拟得越花越好”，而是把你当前想验证的对象从外部依赖里隔离出来。比如订单服务里发邮件、调支付、访问仓储，这些依赖本身不该成为当前测试的不确定因素。你要测的是“处理逻辑是否正确”，而不是“SMTP 服务器今天是否正常”。

```csharp
var emailMock = new Mock<IEmailService>();
var service = new OrderService(emailMock.Object);

service.Process(order);

emailMock.Verify(x => x.SendEmail(order.Email, "订单已处理"), Times.Once);
```

这里最容易混的其实不是 API，而是几种替身的意图差别。Stub/Fake/Mock 在书里会分得很细，但对入门复习来说，先把一句话记住就够了：**Mock 更强调“验证交互是否发生”，Fake 更像“简化版可运行实现”，Stub 更像“返回固定数据的替身”。** 你能把“我为什么要隔离外部依赖”讲清楚，比把每个框架 API 背熟更重要。

这一节最后还应该落到一个工程判断：测试本身也是文档。一个好的单元测试不只是防回归，还会告诉后来的人“这个边界本来就该这样”。所以工作里最有价值的测试，往往不是数量最多的，而是那些把业务规则写得最清楚的测试。

## Web 开发与部署入门

这一章把前面那些相对独立的能力串到一起，看看一个 C# 应用真正变成 Web 服务以后，项目结构、请求处理和部署交付是怎么连起来的。很多人一看到 ASP.NET Core 就会被 `builder`、`services`、中间件、控制器、配置、Docker 这些词同时包围，其实没有必要一下子把所有术语都背下来，先抓主线更重要。

最小主线可以分成两段：在开发阶段，程序如何接收请求并返回响应；在交付阶段，项目如何从本地代码走到可运行的服务。前一段解决“应用怎么工作”，后一段解决“应用怎么上线”。

### Web API 项目结构

第一次看 ASP.NET Core 项目时，很多人会觉得文件不多，但不知道主线在哪里。其实可以先抓住最小骨架：`Program.cs` 负责把应用搭起来，`Services` 决定依赖怎么注册，路由和控制器负责接请求、回响应，配置和环境变量决定应用在不同环境下怎么运行。先把这条线看懂，后面的中间件、依赖注入、发布部署就不容易散。

控制台程序是"从头到尾执行一次就结束"，Web项目是"持续运行，等待请求，每个请求调用你的代码"。这是最本质的区别。

打开一个ASP.NET Core Web API项目，`Program.cs`里有这样一组东西：

```csharp
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();  // 注册服务

var app = builder.Build();
app.UseHttpsRedirection();  // 配置中间件
app.UseAuthorization();
app.MapControllers();

app.Run();  // 启动，持续运行
```

这段代码在做三件事：**创建构建器** → **注册服务** → **配置中间件** → **启动应用**。`builder`用来配置"应用需要什么"（依赖注入），`app`用来配置"请求怎么处理"（中间件管道）。最后`app.Run()`启动Kestrel服务器，监听端口（默认5000/5001），进入"等待请求"的状态。

Kestrel是ASP.NET Core内置的Web服务器，开发时直接用就行。生产环境通常在Kestrel前面加个反向代理（Nginx或IIS），用来做负载均衡、SSL终止、静态文件服务。

### 请求处理流程

一个HTTP请求从浏览器发出，到你的代码处理，再返回响应，中间经过了这样一条路径：

```
浏览器发送：GET /api/users/123
    ↓
Kestrel接收请求
    ↓
中间件：日志、认证、授权
    ↓
路由：匹配到 UsersController.GetById(123)
    ↓
控制器：调用 UserService.GetById(123)
    ↓
返回：{"id":123,"name":"Alice"}
```

这条路径上有四个关键角色：**路由**找到处理方法，**中间件**在请求前后做通用处理，**控制器**组织业务逻辑，**依赖注入**管理对象创建。

```csharp
// 控制器风格（工作中最常用）
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        return Ok(new { Id = id, Name = "User" + id });
    }
}
```

HTTP方法对应CRUD操作：GET查询、POST创建、PUT更新、DELETE删除。这就是RESTful API的核心思想——用HTTP方法表示操作，用URL表示资源。

### 路由、控制器、中间件与依赖注入

这四个概念最容易混，因为它们都在"处理请求"这件事上扮演角色，但位置和职责不同。面试里经常会问：请求从进来到返回，经过了哪些环节？答案就是这四个概念串起来的流程。

**路由**决定URL调用哪段代码。框架会自动把路径参数（`{id}`）、查询参数（`?page=1`）、请求体（POST的JSON）绑定到方法参数上。

**中间件**是一层层包裹在业务代码外面的"洋葱圈"。每个中间件可以在请求到达控制器之前做处理（比如记录日志、检查登录），也可以在响应返回之前做处理。

```csharp
var app = builder.Build();

// 中间件的顺序很重要
app.UseExceptionHandler("/error");  // 1. 异常处理（最外层）
app.UseHttpsRedirection();           // 2. HTTPS重定向
app.UseAuthentication();             // 3. 认证（检查是否登录）
app.UseAuthorization();              // 4. 授权（检查是否有权限）
app.MapControllers();                // 5. 路由到控制器

app.Run();
```

工作中最常用的中间件就这几个：异常处理、认证、授权、HTTPS重定向。顺序必须对：认证在授权之前（先确认身份再检查权限），异常处理在最外层（捕获所有错误）。

**依赖注入**解决的问题是"不要在代码里到处new对象"。你定义接口和实现，在`Program.cs`里注册，框架会自动创建对象并注入到需要的地方。

```csharp
// 注册服务
builder.Services.AddScoped<IUserService, UserService>();

// 使用服务（控制器构造函数注入）
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;
    
    public UsersController(IUserService userService)
    {
        _userService = userService;  // 框架自动注入
    }
}
```

依赖注入有三种生命周期：**Transient**（每次请求都创建新实例）、**Scoped**（每个HTTP请求创建一个实例）、**Singleton**（应用启动时创建一个实例）。工作中90%的情况用Scoped就够了。数据库上下文（DbContext）必须用Scoped，配置和缓存用Singleton。

### 发布与部署

写完代码后，要把应用部署到服务器让用户访问。这个过程分三步：**发布**（生成部署包）、**部署**（上传到服务器）、**运行**（启动应用）。很多人会把发布和部署混淆，先理清这条主线。

先看发布产物。

发布就是把代码编译成可执行文件，并把所有依赖打包在一起。`dotnet publish`做的就是这件事。

```bash
# 发布到文件夹
dotnet publish -c Release -o ./publish
```

发布有两种模式：**依赖框架**（需要服务器安装.NET，体积小）和**独立发布**（包含.NET运行时，体积大但不需要安装.NET）。工作中服务器通常用依赖框架。

再看部署运行。

最简单的部署方式是手动上传文件到服务器，然后用`dotnet`命令运行。但这样有个问题：SSH断开后程序就停了。生产环境要用进程管理工具（Linux用systemd，Windows用Windows Service）让程序在后台持续运行。

**Docker：统一运行环境。** Docker把应用和依赖打包成镜像，可以在任何支持Docker的环境运行。这是现在最流行的部署方式，因为它解决了"开发环境能跑，生产环境不能跑"的问题。

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY publish/ .
ENTRYPOINT ["dotnet", "MyApi.dll"]
```

Docker的好处是环境一致（开发、测试、生产用同一个镜像）、部署简单（一个命令启动）、易于扩展（启动多个容器做负载均衡）。

**云平台：托管服务。** 云平台（Azure、AWS、阿里云）提供托管服务，不需要自己管理服务器。好处是省心（不用管服务器维护）、弹性（自动扩展）、集成（日志、监控、数据库都有）。缺点是成本较高。

### 运行环境与交付

**反向代理：** Kestrel虽然性能好，但生产环境通常在它前面加个反向代理（Nginx或IIS）。反向代理做三件事：负载均衡（多个Kestrel实例分担流量）、SSL终止（处理HTTPS）、静态文件服务（直接返回图片、CSS、JS）。

**环境变量和配置：** Web应用需要配置数据库连接、API密钥、日志级别等信息，这些配置通常放在`appsettings.json`文件中。不同环境（开发、测试、生产）有不同的配置，通过环境变量`ASPNETCORE_ENVIRONMENT`区分。

**CI/CD：** 手动部署容易出错，CI/CD自动化整个流程：代码提交 → 自动测试 → 自动构建 → 自动部署。常用工具有GitHub Actions、GitLab CI、Jenkins。CI（持续集成）是自动测试和构建，CD（持续部署）是自动部署到服务器。

**把整条交付链串起来看，会更清楚。**

从开发到上线的完整流程：

1. **开发**：写代码，本地测试（`dotnet run`）
2. **发布**：生成部署包（`dotnet publish`）
3. **容器化**：构建Docker镜像（`docker build`）
4. **部署**：服务器拉取镜像并运行（`docker run`）
5. **配置**：设置反向代理、环境变量、SSL证书

这个流程可以通过CI/CD自动化，每次提交代码就自动走一遍。
