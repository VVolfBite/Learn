# C# 学习笔记

本笔记面向已学过 C# 但需要快速复习的读者。目标是重建知识体系，达到面试和工作入门水平。

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

很多人会把 C# 和 .NET 混在一起说，但它们是两个东西：C# 是编程语言（你写代码用的），.NET 是平台（负责把代码跑起来的）。类比一下，C# 是剧本，.NET 是剧院。

这几个概念容易混：

| 概念 | 是什么 | 作用 |
|------|--------|------|
| **C#** | 编程语言 | 写代码用的语法规则 |
| **.NET** | 平台/生态 | 运行时、类库、工具的整体 |
| **CLR** | 公共语言运行时 | 执行编译后代码的引擎 |
| **.NET SDK** | 开发工具包 | 编译器、命令行工具、类库 |

简单流程：你用C#写代码（`.cs`文件）→ SDK编译成中间语言（IL）→ CLR把IL翻译成机器码执行。这种方式叫"托管代码"，类似Java的字节码机制。

```csharp
Console.WriteLine("Hello, C#!");
```

这就是一个完整的C#程序（C# 9.0+的顶级语句）。保存为`Program.cs`，执行`dotnet run`就能看到输出。

**最容易混淆的版本问题：** .NET Framework（老版本，只能Windows，最高4.8）、.NET Core（跨平台重写，1.0到3.1）、.NET 5/6/7/8（统一后的版本，现在主流用这个）。现在说".NET"通常指.NET 5及以后。C#版本和.NET版本不是一一对应的，但新版.NET通常支持新版C#。


记忆时先抓这几句：C#是语言，.NET是平台，CLR是运行时引擎。现在主流用.NET 6/7/8（跨平台），不是老的.NET Framework。C#代码先编译成IL，再由CLR的JIT编译成机器码。另外，.NET提供自动内存管理（GC），不需要手动释放内存。

---

## 1.2 开发环境、运行方式与第一个程序

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

**常见坑点：** 找不到dotnet命令（没装SDK或没加PATH）、项目里有多个Main方法（只能有一个入口点）、顶级语句和传统Main混用（选一种统一用）、中文乱码（加`Console.OutputEncoding = System.Text.Encoding.UTF8;`）。


记忆时先抓这几句：.NET SDK包含编译器和`dotnet`命令行工具。`dotnet new console`创建项目，`dotnet run`编译并运行。C# 9.0+可以用顶级语句简化入口代码。另外，命令行参数通过`args`数组访问，返回0表示成功，非零表示错误、一个项目只能有一个入口点。

---

## 1.3 基本类型与变量

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

**容易混淆的点：** `double` vs `decimal`（double是二进制浮点有精度误差，decimal是十进制高精度，金融计算必须用decimal）、`string`是引用类型但不可变（每次修改创建新对象，大量拼接用`StringBuilder`）、`var`不是`dynamic`（var编译时确定，dynamic运行时确定）。


记忆时先抓这几句：`int`最常用，`double`默认浮点，金融计算用`decimal`。`var`是编译时类型推断，不是动态类型。字符串插值`$"{变量}"`比`+`拼接更清晰。另外，值类型加`?`变可空类型，`??`是空合并，`?.`是空条件。

---

## 1.4 控制流与基本语法

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

**容易混淆的点：** 传统switch每个case必须有`break`，C#不允许贯穿（和C/C++不同）；`foreach`遍历时不能添加或删除元素，需要修改用`for`循环；`string`用`==`比较内容（重写了`==`），不需要用`Equals()`。


记忆时先抓这几句：switch表达式（C# 8.0+）比传统switch更简洁。`for`适合已知次数，`foreach`适合遍历集合。模式匹配可以同时做类型判断和赋值。另外，`string`用`==`比较内容。

---

## 1.5 方法与参数传递

方法定义：`访问修饰符 返回类型 方法名(参数列表)`。表达式体方法：`public int Add(int a, int b) => a + b;`

**参数传递是面试高频考点：**

| 传递方式 | 关键字 | 传递内容 | 能否修改原值 | 必须初始化 | 典型用途 |
|---------|--------|---------|------------|-----------|---------|
| **值传递** | 无 | 复制值 | 否 | 是 | 默认方式 |
| **引用传递** | `ref` | 传递引用 | 是 | 是 | 需要修改原变量 |
| **输出参数** | `out` | 传递引用 | 是 | 否 | 返回多个值 |
| **只读引用** | `in` | 传递引用 | 否 | 是 | 大结构体只读传递 |

```csharp
void Increment(int x) { x++; }           // 值传递，不影响原值
void Increment(ref int x) { x++; }       // ref，修改原值，调用时加ref
bool TryParse(string input, out int result) { ... }  // out，返回多个值
```

**容易混淆的点：** `ref` vs `out`（ref传入前必须初始化，out不需要但方法内必须赋值；ref用于修改原值，out用于返回多个值）、值类型vs引用类型的参数传递（值类型默认传副本，引用类型传引用的副本，引用类型不加ref时可以修改对象内容但不能改变引用本身）、方法重载根据参数类型/数量/顺序区分，只有返回值不同不算重载。


记忆时先抓这几句：默认是值传递，传递副本，不影响原值。`ref`传递引用可修改原值，传入前必须初始化。`out`用于返回多个值，传入前不需要初始化，方法内必须赋值。另外，引用类型不加`ref`时，可以修改对象内容，但不能改变引用本身、方法重载根据参数类型、数量、顺序区分。

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

| 特性 | 数组 | List<T> |
|------|------|---------|
| **长度** | 固定 | 动态扩容 |
| **性能** | 访问快 | 访问快，扩容时需复制 |
| **API** | 基础 | 丰富（Add、Remove、Find等） |
| **适用场景** | 长度固定、性能敏感 | 长度不确定、需要频繁增删 |

**容易混淆的点：** 数组用`Length`，List用`Count`；List扩容时容量翻倍，如果知道大概数量可以预分配容量`new List<int>(100)`；`foreach`遍历时不能修改集合，需要修改用`for`循环；`ToArray()`和`ToList()`可以互相转换。


记忆时先抓这几句：数组长度固定，`List<T>`长度动态，工作中优先用`List<T>`。数组用`Length`，List用`Count`。`List<T>`扩容时会复制所有元素，性能敏感时可预分配容量。另外，`foreach`遍历时不能修改集合。

---

## 2.2 Dictionary<TKey, TValue> 与 HashSet<T>

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

| 特性 | Dictionary | HashSet |
|------|-----------|---------|
| **存储** | 键值对 | 单个值 |
| **重复** | 键不重复 | 不重复 |
| **查找** | O(1) | O(1) |
| **用途** | 映射关系、缓存 | 去重、集合运算 |

**容易混淆的点：** Dictionary用`[]`赋值时键存在会覆盖，用`Add()`时键存在会抛异常，推荐用`TryGetValue()`安全访问；自定义类型作为键时必须重写`GetHashCode()`和`Equals()`；Dictionary和HashSet都不是线程安全的，多线程用`ConcurrentDictionary`。


记忆时先抓这几句：`Dictionary`用于键值对映射，`HashSet`用于去重，查找都是O(1)。Dictionary的键必须唯一，推荐用`TryGetValue()`安全访问。HashSet自动去重，添加重复元素会被忽略。另外，自定义类型作为键时必须重写`GetHashCode()`和`Equals()`。

---

## 2.3 Stack<T>、Queue<T> 与其他集合

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

| 特性 | Stack<T> | Queue<T> |
|------|---------|---------|
| **顺序** | 后进先出（LIFO） | 先进先出（FIFO） |
| **添加** | `Push()` | `Enqueue()` |
| **移除** | `Pop()` | `Dequeue()` |
| **典型场景** | 撤销操作、递归模拟、括号匹配 | 任务队列、BFS、消息队列 |

**其他集合：** `LinkedList<T>`（双向链表，不支持索引访问，工作中用得少）、`SortedSet<T>`（有序不重复）、`SortedDictionary<TKey, TValue>`（按键排序）、`ConcurrentDictionary<TKey, TValue>`（线程安全）。


记忆时先抓这几句：`Stack<T>`是LIFO，用`Push()`和`Pop()`。`Queue<T>`是FIFO，用`Enqueue()`和`Dequeue()`。`Peek()`只查看不移除，`Pop()`/`Dequeue()`移除并返回。另外，Stack适合撤销操作，Queue适合任务队列。

---

## 2.4 集合的遍历、查找与排序

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

**容易混淆的点：** `Find()`是List的方法，`FirstOrDefault()`是LINQ方法，功能类似但LINQ更通用；`Sort()`修改原集合，`OrderBy()`返回新集合，需要修改原集合用`Sort()`，不想修改用`OrderBy()`；LINQ是延迟执行的，调用`ToList()`才会立即执行，需要立即执行或多次使用结果时要调用`ToList()`。


记忆时先抓这几句：`foreach`最常用，`for`适合需要索引。`Find()`查找单个，`FindAll()`查找多个。`Sort()`修改原集合，`OrderBy()`返回新集合。另外，LINQ是延迟执行的，调用`ToList()`才立即执行、多字段排序用`OrderBy().ThenBy()`。

---

## 2.5 集合选型与面试常问

| 需求 | 推荐集合 | 理由 |
|------|---------|------|
| 动态数组，按索引访问 | `List<T>` | 最常用，性能好 |
| 键值对映射 | `Dictionary<TKey, TValue>` | O(1)查找 |
| 去重 | `HashSet<T>` | 自动去重，O(1)查找 |
| 后进先出 | `Stack<T>` | 撤销操作、递归模拟 |
| 先进先出 | `Queue<T>` | 任务队列、消息队列 |
| 有序且去重 | `SortedSet<T>` | 自动排序 |
| 线程安全字典 | `ConcurrentDictionary<TKey, TValue>` | 多线程环境 |

**面试高频问题：**

**List vs 数组？** 长度不确定、需要频繁增删用`List<T>`；长度固定、性能敏感用数组。工作中90%用`List<T>`。

**Dictionary查找为什么是O(1)？** 基于哈希表实现，通过键的哈希值快速定位到桶，哈希冲突时用链表或红黑树解决。

**HashSet和List去重的区别？** `HashSet`自动去重O(1)查找，`List`需要手动去重（`Distinct()`）O(n)查找。需要去重时优先用`HashSet`。

**什么时候用Stack/Queue？** Stack后进先出，适合撤销操作、递归模拟、括号匹配；Queue先进先出，适合任务队列、BFS、消息队列。

**LINQ性能怎么样？** LINQ是延迟执行的，性能略低于手写循环但差距不大（通常10%以内）。工作中优先用LINQ代码更清晰，性能敏感的地方再优化。

**如何选择集合？** 先看是否需要键值对（是→Dictionary，否→继续）→是否需要去重（是→HashSet，否→继续）→是否需要有序（是→SortedSet/SortedDictionary，否→继续）→是否需要LIFO/FIFO（是→Stack/Queue，否→List）。


记忆时先抓这几句：工作中最常用的是`List<T>`和`Dictionary<TKey, TValue>`。`Dictionary`和`HashSet`查找都是O(1)。`HashSet`自动去重，`List`需要手动去重。另外，`Stack`是LIFO，`Queue`是FIFO、LINQ是延迟执行的，调用`ToList()`才立即执行、集合选型优先考虑：是否需要键值对、是否需要去重、是否需要有序、多线程环境用`ConcurrentDictionary`。

---
## 第3章 面向对象与类型系统

### 目录
3.1 类、对象、成员的基本使用  
3.2 字段 vs 属性  
3.3 接口 vs 抽象类  
3.4 值类型 vs 引用类型  
3.5 struct vs class vs record

---

这一章最容易混的不是"类和对象是什么"，而是那些"看起来很像、实际边界不同"的概念组合。字段和属性都在类里，为什么要分两个？接口和抽象类都能定义契约，什么时候用哪个？值类型和引用类型都能存数据，为什么赋值行为不一样？这些才是复习时最该重新理清的地方。

---

## 3.1 类、对象、成员的基本使用

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


记忆时先抓这几句：类是模板，对象是实例，用`new`创建对象。`new`做三件事：分配内存、调用构造函数、返回引用。`this`是当前对象的引用。另外，静态成员属于类，实例成员属于对象。

---

## 3.2 字段 vs 属性

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

面试常问：字段是直接存储数据的变量，属性是通过get/set方法访问数据。属性可以在set中验证、可以改成计算属性而不影响调用方、可以设置断点调试。工作中对外暴露数据必须用属性。


记忆时先抓这几句：字段是变量，属性是方法（get/set），对外暴露用属性不要用字段。自动属性`{ get; set; }`会自动生成私有字段，最常用。只读属性只有get，只能在构造函数中赋值。另外，工作中90%用自动属性，需要验证或计算时才写完整属性。

---

## 3.3 接口 vs 抽象类

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

| 特性 | 接口 | 抽象类 |
|------|------|--------|
| **继承数量** | 多实现 | 单继承 |
| **成员类型** | 属性、方法、事件 | 字段、属性、方法、构造函数 |
| **实现** | 传统上没有实现 | 可以有实现 |
| **使用场景** | can-do关系，定义能力 | is-a关系，共享代码 |

面试常问：接口用于can-do关系定义能力（如IFlyable表示"能飞"的能力），抽象类用于is-a关系且有共享代码（如Shape有共同的Display方法）。优先用接口因为更灵活（支持多实现），只有在需要共享代码时才用抽象类。

继承不是默认答案。继承用于is-a关系（Dog is an Animal），组合用于has-a关系（Car has an Engine）。优先使用组合，因为继承耦合度高，组合更灵活。


记忆时先抓这几句：接口定义能力（can-do），抽象类定义本质（is-a）且有共享代码。C#支持单继承但支持多接口实现。优先使用接口因为更灵活，只有需要共享代码时才用抽象类。另外，抽象类不能实例化，抽象方法没有实现子类必须重写、继承用于is-a关系，组合用于has-a关系，优先使用组合。

---

## 3.4 值类型 vs 引用类型

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

| 特性 | 值类型 | 引用类型 |
|------|--------|---------|
| **存储位置** | 栈 | 堆（引用在栈上） |
| **赋值行为** | 复制值 | 复制引用 |
| **默认值** | 0、false等 | null |
| **包含** | 基本类型、struct、enum | class、interface、delegate、string、数组 |

最容易混淆的三个点：**`string`是引用类型但不可变**（每次修改创建新对象，行为像值类型）、**数组是引用类型**（即使是`int[]`，数组对象也存储在堆上）、**值类型也可以为null**（使用可空类型`int?`）。

参数传递：默认是值传递（传副本），`ref`传递引用可修改原值（传入前必须初始化），`out`用于返回多个值（传入前不需要初始化，方法内必须赋值）。

面试常问：值类型存储在栈上赋值复制值，引用类型存储在堆上赋值复制引用。值类型包括基本类型、struct、enum，引用类型包括class、interface、delegate、string、数组。`ref`传递引用可修改原值，`out`用于返回多个值。


记忆时先抓这几句：值类型变量直接包含数据，引用类型变量包含引用。值类型赋值复制值，引用类型赋值复制引用。基本类型、struct、enum是值类型，class、interface、delegate、string、数组是引用类型。另外，`string`是引用类型但不可变，数组是引用类型、`ref`传递引用可修改原值，`out`用于返回多个值。

---

## 3.5 struct vs class vs record

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

| 特性 | struct | class | record |
|------|--------|-------|--------|
| **类型** | 值类型 | 引用类型 | 引用类型 |
| **赋值** | 复制值 | 复制引用 | 复制引用 |
| **相等比较** | 按值比较 | 按引用比较 | 按值比较 |
| **适用场景** | 小型数据结构 | 一般对象 | 不可变数据 |

什么时候用struct？数据量小（通常小于16字节）、逻辑上表示单个值（如Point、Color）、不需要继承、不会频繁装箱。典型例子：`DateTime`、`TimeSpan`、`Guid`都是struct。

什么时候用record？需要不可变数据、需要值相等比较、需要with表达式创建副本。典型场景：DTO（数据传输对象）、配置对象、事件数据。record的价值不只是"语法更短"，而是明确表达了"这是不可变数据"的建模意图。


记忆时先抓这几句：struct是值类型，class和record是引用类型。struct适合小型数据结构（小于16字节），class适合一般对象，record适合不可变数据。record自动实现值相等比较，支持`with`表达式创建副本。另外，工作中90%用class，只有明确性能需求时才用struct、record典型用于DTO、配置对象、事件数据。

---

## 高频判断

- 字段是变量，属性是方法，对外暴露用属性不要用字段
- 接口定义能力（can-do），抽象类定义本质（is-a）且有共享代码
- C#支持单继承但支持多接口实现，优先使用接口
- 值类型赋值复制值，引用类型赋值复制引用
- 基本类型、struct、enum是值类型，class、interface、delegate、string、数组是引用类型
- `string`是引用类型但不可变，数组是引用类型
- struct是值类型，class和record是引用类型
- record适合不可变数据，自动实现值相等比较

---
## 第4章 核心语言特性与 LINQ

### 目录
4.1 泛型与泛型约束  
4.2 委托、Lambda 与事件  
4.3 LINQ 查询与方法链  
4.4 异常处理与可空引用类型

---

这一章帮你看懂现代C#代码。工作中你会看到泛型、Lambda、LINQ链式调用、可空引用类型，这些都是现代C#的标配。理解它们不是为了背语法，而是为了看懂别人的代码、写出更简洁的代码。

---

## 4.1 泛型与泛型约束

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

泛型约束限制类型参数必须满足特定条件。工作中最常用的约束：`where T : class`（引用类型）、`where T : new()`（有无参构造函数）、`where T : IComparable`（实现接口）。

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
```

面试常问：泛型和object有什么区别？答案是泛型编译时检查类型安全，值类型不装箱拆箱，性能更好。object运行时才知道类型，值类型会装箱拆箱，性能较差。


记忆时先抓这几句：泛型提供类型安全和性能优化，避免装箱拆箱。泛型约束限制类型参数必须满足特定条件。`where T : class`要求引用类型，`where T : new()`要求有无参构造函数。另外，泛型编译时检查类型，object运行时检查类型。

---

## 4.2 委托、Lambda 与事件

这三个概念为什么总一起出现？因为它们都在解决"把行为当参数传递"的问题。委托是方法的引用，Lambda是委托的简写形式，事件是委托的特殊用法。

工作中你会看到大量Lambda表达式，它们通常作为参数传递给LINQ方法、事件订阅、异步回调。理解Lambda就是理解"方法可以当参数传递"。

```csharp
// 委托定义
public delegate bool Predicate(int x);

// Lambda（现代写法，推荐）
Predicate pred = x => x % 2 == 0;
bool result = pred(4);  // true

// 内置委托类型（最常用）
Func<int, bool> isEven = x => x % 2 == 0;  // 有返回值
Action<string> print = s => Console.WriteLine(s);  // 无返回值
```

工作中最常用的是`Func`和`Action`，不需要自己定义委托类型。`Func`有返回值，`Action`无返回值。

事件是委托的封装，用于发布-订阅模式。事件只能在类内部触发，外部只能订阅和取消订阅，不能直接调用。

```csharp
public class Button
{
    public event EventHandler Clicked;
    
    public void Click()
    {
        Clicked?.Invoke(this, EventArgs.Empty);
    }
}

// 订阅事件
Button button = new Button();
button.Clicked += (sender, e) => Console.WriteLine("按钮被点击了");
```

面试常问：委托和事件有什么区别？答案是事件是委托的封装，只能在类内部触发，外部只能订阅和取消订阅。委托可以在外部直接调用。事件更安全，防止外部误触发。


记忆时先抓这几句：委托是方法的引用，Lambda是委托的简写形式。`Func`有返回值，`Action`无返回值，是最常用的内置委托类型。事件是委托的封装，只能在类内部触发，外部只能订阅。另外，工作中大量使用Lambda作为参数传递。

---

## 4.3 LINQ 查询与方法链

LINQ让集合操作更简洁。工作中你会看到大量LINQ链式调用，理解怎么读这些链式调用比记住所有LINQ方法更重要。

先看一个典型的LINQ链式调用：

```csharp
var result = numbers
    .Where(x => x > 2)        // 过滤：保留大于2的
    .Select(x => x * 2)       // 映射：每个元素乘以2
    .OrderByDescending(x => x) // 排序：降序
    .ToList();                // 立即执行
```

这段代码怎么读？从上到下，每一行都是对上一行结果的操作。`Where`过滤出符合条件的元素，`Select`把每个元素映射成新值，`OrderByDescending`排序，`ToList`立即执行并返回列表。

工作中最常用的LINQ操作：

```csharp
List<int> numbers = new List<int> { 1, 2, 3, 4, 5, 6 };

// 过滤
var evens = numbers.Where(x => x % 2 == 0);  // [2, 4, 6]

// 映射
var doubled = numbers.Select(x => x * 2);  // [2, 4, 6, 8, 10, 12]

// 查找
int first = numbers.FirstOrDefault(x => x > 3);  // 4

// 判断
bool hasEven = numbers.Any(x => x % 2 == 0);  // true

// 聚合
int sum = numbers.Sum();  // 21
```

LINQ是延迟执行的，调用`ToList()`、`ToArray()`、`Count()`等方法才会立即执行。需要立即执行或多次使用结果时要调用`ToList()`。

面试常问：LINQ的延迟执行是什么意思？答案是LINQ查询不会立即执行，只有在遍历结果或调用`ToList()`等方法时才会执行。好处是可以组合多个查询，只执行一次。坏处是如果数据源改变，结果也会改变。


记忆时先抓这几句：LINQ让集合操作更简洁，链式调用从上到下读。`Where`过滤，`Select`映射，`OrderBy`排序，`FirstOrDefault`查找第一个。LINQ是延迟执行的，调用`ToList()`才立即执行。另外，需要立即执行或多次使用结果时要调用`ToList()`。

---

## 4.4 异常处理与可空引用类型

异常处理让错误可控。工作中最常见的异常：`NullReferenceException`（空引用）、`ArgumentException`（参数错误）、`InvalidOperationException`（操作无效）。

```csharp
try
{
    int result = int.Parse(input);
}
catch (FormatException ex)
{
    Console.WriteLine("输入格式错误");
}
catch (Exception ex)
{
    Console.WriteLine($"发生错误: {ex.Message}");
}
finally
{
    Console.WriteLine("清理资源");
}
```

不要捕获所有异常然后什么都不做（`catch (Exception) { }`），这会隐藏错误。要么记录日志，要么重新抛出，要么给用户提示。不要用异常控制正常流程，异常处理有性能开销。用`TryParse`代替`Parse`，避免抛异常。

可空引用类型（C# 8.0+）减少空引用异常。默认情况下，引用类型不能为null，要用`?`标记可空。编译器会警告可能的空引用，强制你处理null情况。

```csharp
#nullable enable

// 不可空引用类型（默认）
string name = "Alice";
// name = null;  // 编译警告

// 可空引用类型
string? nullableName = null;  // 允许为null

// 空合并运算符
string result = nullableName ?? "默认值";

// 空条件运算符
int? length = nullableName?.Length;
```

工作中通常：新项目启用可空引用类型，老项目逐步迁移。遇到编译警告时，要么用`?`标记可空，要么用`??`提供默认值，要么用`?.`安全访问，要么用`!`断言不为null。


记忆时先抓这几句：异常处理让错误可控，不要捕获所有异常然后什么都不做。用`TryParse`代替`Parse`，避免抛异常。可空引用类型减少空引用异常，引用类型默认不可空。另外，`??`空合并运算符提供默认值，`?.`空条件运算符安全访问。

---

## 高频判断

- 泛型提供类型安全和性能优化，避免装箱拆箱
- 委托是方法的引用，Lambda是委托的简写形式
- `Func`有返回值，`Action`无返回值，是最常用的内置委托类型
- LINQ让集合操作更简洁，链式调用从上到下读
- LINQ是延迟执行的，调用`ToList()`才立即执行
- 异常处理让错误可控，用`TryParse`代替`Parse`
- 可空引用类型减少空引用异常，引用类型默认不可空

---
## 第5章 常用开发能力

### 目录
5.1 文件、目录与路径  
5.2 JSON 序列化与反序列化  
5.3 时间与字符串  
5.4 配置与日志

---

程序迟早要读文件、处理JSON、处理时间和字符串、读配置、写日志。这些东西不算高深，但几乎天天都能碰到。真正重要的不是API背诵，而是知道哪几类问题最常见，先从哪里下手。

---

## 5.1 文件、目录与路径

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


记忆时先抓这几句：相对路径是相对于当前工作目录，不是可执行文件所在目录。路径拼接用`Path.Combine`不要用字符串拼接，避免跨平台问题。文件操作要用try-catch处理异常。另外，`File.ReadAllText`读取整个文件，大文件用`StreamReader`逐行处理。

---

## 5.2 JSON 序列化与反序列化

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


记忆时先抓这几句：`System.Text.Json`是.NET内置JSON库性能好，新项目优先用。`JsonSerializer.Serialize()`序列化对象转JSON。`JsonSerializer.Deserialize<T>()`反序列化JSON转对象。另外，属性名大小写敏感，设置`PropertyNameCaseInsensitive = true`忽略大小写。

---

## 5.3 时间与字符串

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


记忆时先抓这几句：`DateTime.Now`获取本地时间，`DateTime.UtcNow`获取UTC时间。存储时间到数据库建议用UTC时间避免时区问题。`DateTime.Parse()`解析时间字符串，`TryParse()`更安全。另外，`string.IsNullOrWhiteSpace()`判断null、空字符串或只包含空格、字符串插值`$"{变量}"`比`+`拼接更清晰、大量拼接用`StringBuilder`，`string`是不可变的。

---

## 5.4 配置与日志

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


记忆时先抓这几句：配置放在`appsettings.json`文件中，通过`IConfiguration`读取。不同环境用不同配置文件（`appsettings.Development.json`、`appsettings.Production.json`）。敏感信息不要写在代码里，放在配置文件或环境变量中。另外，日志用`ILogger`接口，开发环境Debug级别，生产环境Information级别、日志要结构化用占位符，不要记录敏感信息、日志不是为了多打，而是为了定位问题。

---

## 高频判断

- 路径拼接用`Path.Combine`不要用字符串拼接，避免跨平台问题
- 文件操作要用try-catch处理异常，大文件用`StreamReader`逐行处理
- JSON处理用`System.Text.Json`（新项目）或`Newtonsoft.Json`（老项目）
- 属性名大小写敏感，设置`PropertyNameCaseInsensitive = true`忽略大小写
- 存储时间到数据库建议用UTC时间避免时区问题
- 字符串判空用`IsNullOrWhiteSpace()`，大量拼接用`StringBuilder`
- 配置放在`appsettings.json`，敏感信息不要写在代码里
- 日志用`ILogger`，开发环境Debug级别，生产环境Information级别

---
## 第6章 .NET 工程与工具链

### 目录
6.1 项目文件与解决方案  
6.2 NuGet 包管理  
6.3 dotnet CLI 常用命令  
6.4 构建、运行、测试、发布的完整流程

---

## 6.1 项目文件与解决方案

一个.NET项目的核心是`.csproj`文件（C# Project），它定义了项目的基本信息、依赖包、编译选项。多个项目可以组织在一个`.sln`文件（Solution）中。理解这两个文件，就理解了.NET项目是怎么组织的。

### 项目文件（.csproj）

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

| SDK | 项目类型 | OutputType | 典型用途 |
|-----|---------|-----------|---------|
| `Microsoft.NET.Sdk` | 控制台/类库 | Exe / Library | 控制台程序、类库 |
| `Microsoft.NET.Sdk.Web` | Web应用 | Exe | Web API、MVC |
| `Microsoft.NET.Sdk.Worker` | 后台服务 | Exe | 后台任务、定时任务 |

工作中最常见的就是控制台项目和Web项目。类库项目用于封装可复用的代码，`OutputType`是`Library`，编译后生成`.dll`文件。

### 解决方案（.sln）

解决方案是多个项目的容器，用于组织大型应用。一个典型的Web应用可能有这样的结构：

```
MySolution.sln
├── MyApi/              (Web API项目)
├── MyApi.Core/         (业务逻辑类库)
├── MyApi.Data/         (数据访问类库)
└── MyApi.Tests/        (单元测试项目)
```

解决方案文件本身不需要手动编辑，用`dotnet sln`命令管理就行。工作中通常是：先创建解决方案，再往里面添加项目。


记忆时先抓这几句：`.csproj`是项目文件，定义项目类型、目标框架、依赖包。`.sln`是解决方案文件，组织多个项目。SDK风格项目文件非常简洁，通常只有几行。另外，控制台项目用`Microsoft.NET.Sdk`，Web项目用`Microsoft.NET.Sdk.Web`、`OutputType=Exe`是可执行程序，`OutputType=Library`是类库、解决方案用于组织大型应用，一个解决方案包含多个项目。

---

## 6.2 NuGet 包管理

NuGet是.NET的包管理器，类似npm（Node.js）、pip（Python）。工作中几乎所有第三方库都通过NuGet安装。包的信息存储在`.csproj`文件的`<PackageReference>`节点中。

### 常用包管理操作

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

### 包的版本管理

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

### 常用的NuGet包

| 包名 | 用途 | 典型场景 |
|------|------|---------|
| `Newtonsoft.Json` | JSON序列化 | 老项目的JSON处理 |
| `Serilog` | 日志库 | 结构化日志 |
| `Dapper` | 轻量ORM | 数据库访问 |
| `AutoMapper` | 对象映射 | DTO转换 |
| `FluentValidation` | 数据验证 | 输入验证 |
| `xUnit` / `NUnit` | 单元测试 | 测试框架 |


记忆时先抓这几句：NuGet是.NET的包管理器，类似npm、pip。`dotnet add package`添加包，`dotnet remove package`移除包。包信息存储在`.csproj`的`<PackageReference>`节点。另外，包文件下载到全局缓存，不复制到项目目录、工作中通常用精确版本，避免自动更新导致兼容性问题、大版本更新可能有破坏性变更，要谨慎升级。

---

## 6.3 dotnet CLI 常用命令

`dotnet`命令行工具是.NET开发的核心，涵盖了创建、构建、运行、测试、发布的全流程。记住最常用的几个命令就够了，其他的用到再查。

### 项目和解决方案管理

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

### 依赖管理

```bash
# 添加项目引用（MyApp引用MyLib）
dotnet add MyApp/MyApp.csproj reference MyLib/MyLib.csproj

# 添加NuGet包
dotnet add package Newtonsoft.Json

# 恢复依赖（下载包）
dotnet restore
```

### 构建、运行、测试、发布

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


记忆时先抓这几句：`dotnet new`创建项目，`dotnet sln`管理解决方案。`dotnet add reference`添加项目引用，`dotnet add package`添加NuGet包。`dotnet restore`恢复依赖，`dotnet build`构建项目。另外，`dotnet run`运行项目，`dotnet test`运行测试、`dotnet publish`发布项目，生成部署包。

---

## 6.4 构建、运行、测试、发布的完整流程

理解.NET项目的生命周期，就是理解这四个步骤：**构建**（编译代码）、**运行**（执行程序）、**测试**（验证功能）、**发布**（生成部署包）。这是从开发到上线的完整流程。

### 构建（Build）

构建就是把`.cs`源代码编译成`.dll`或`.exe`文件。`dotnet build`会做这些事：恢复NuGet包（如果需要）、编译代码、生成输出文件到`bin/Debug`或`bin/Release`目录。

```bash
# 调试版本（默认）
dotnet build

# 发布版本（优化性能）
dotnet build -c Release

# 指定输出目录
dotnet build -o ./output
```

**Debug vs Release：** Debug版本包含调试信息（`.pdb`文件），方便调试但性能较差。Release版本优化了性能，去掉了调试信息，用于生产环境。工作中开发时用Debug，部署时用Release。

### 运行（Run）

`dotnet run`会先构建项目（如果有改动），然后运行生成的程序。这是开发时最常用的命令。

```bash
# 运行项目
dotnet run

# 传递命令行参数
dotnet run -- arg1 arg2

# 指定项目文件
dotnet run --project MyApp/MyApp.csproj
```

也可以直接运行编译后的`.dll`文件：

```bash
dotnet bin/Debug/net8.0/MyApp.dll
```

### 测试（Test）

`dotnet test`会运行项目中的所有单元测试。测试项目通常以`.Tests`结尾，使用xUnit、NUnit或MSTest框架。

```bash
# 运行所有测试
dotnet test

# 运行测试并显示详细输出
dotnet test --logger "console;verbosity=detailed"

# 只运行特定测试
dotnet test --filter "FullyQualifiedName~MyTest"
```

工作中通常：提交代码前先运行`dotnet test`，确保所有测试通过。CI/CD流程也会自动运行测试。

### 发布（Publish）

发布就是生成可以部署到服务器的完整包，包括编译后的文件、依赖的库、配置文件。

```bash
# 发布到文件夹
dotnet publish -c Release -o ./publish

# 发布时指定运行时（独立发布）
dotnet publish -c Release -r linux-x64 --self-contained -o ./publish
```

**依赖框架 vs 独立发布：**

| 类型 | 命令 | 包含.NET运行时 | 体积 | 适用场景 |
|------|------|--------------|------|---------|
| **依赖框架** | `dotnet publish` | 否 | 小（几MB） | 服务器已安装.NET |
| **独立发布** | `dotnet publish --self-contained` | 是 | 大（几十MB） | 服务器未安装.NET |

工作中服务器通常已安装.NET，用依赖框架发布就行。桌面应用或需要在没有.NET的环境运行时，用独立发布。

### 完整流程串起来

从开发到部署的典型流程：

```bash
# 1. 创建项目
dotnet new webapi -n MyApi
cd MyApi

# 2. 添加依赖
dotnet add package Serilog

# 3. 开发时运行
dotnet run

# 4. 运行测试
dotnet test

# 5. 发布
dotnet publish -c Release -o ./publish

# 6. 部署到服务器
scp -r ./publish user@server:/app
ssh user@server "cd /app && dotnet MyApi.dll"
```

这就是一个.NET项目从创建到部署的完整生命周期。理解了这个流程，就理解了.NET工程是怎么运转的。


记忆时先抓这几句：`dotnet build`编译代码，生成`.dll`或`.exe`文件。Debug版本包含调试信息方便调试，Release版本优化性能用于生产。`dotnet run`先构建再运行，是开发时最常用的命令。另外，`dotnet test`运行单元测试，提交代码前要确保测试通过、`dotnet publish`生成部署包，包括编译后的文件、依赖库、配置文件、依赖框架发布体积小需要服务器安装.NET，独立发布体积大但不需要安装、完整流程：创建项目 → 添加依赖 → 开发运行 → 测试 → 发布 → 部署。

---

## 高频判断

- `.csproj`是项目文件定义项目类型和依赖，`.sln`是解决方案文件组织多个项目
- NuGet是.NET的包管理器，`dotnet add package`添加包
- 包信息存储在`.csproj`的`<PackageReference>`节点
- `dotnet new`创建项目，`dotnet sln`管理解决方案
- `dotnet build`构建项目，`dotnet run`运行项目
- `dotnet test`运行测试，`dotnet publish`发布项目
- Debug版本用于开发，Release版本用于生产
- 依赖框架发布体积小，独立发布体积大但不需要安装.NET
- 完整流程：创建 → 添加依赖 → 开发 → 测试 → 发布 → 部署

---
## 第7章 异步、并发与测试

### 目录

7.1 为什么会有异步与并发  
7.2 Task、async 与 await  
7.3 并发、线程安全与常见误区  
7.4 取消、异常处理与异步中的常见坑  
7.5 单元测试基础  
7.6 断言、Mock 与测试价值

---

## 7.1 为什么会有异步与并发

### 先理解问题场景

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

### 异步解决什么问题

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

### 同步 vs 异步

| 特性         | 同步       | 异步       |
| ------------ | ---------- | ---------- |
| **线程占用** | 一直占用   | 等待时释放 |
| **吞吐量**   | 低         | 高         |
| **响应性**   | 阻塞       | 不阻塞     |
| **复杂度**   | 简单       | 稍复杂     |
| **适用场景** | CPU 密集型 | I/O 密集型 |

### I/O 密集 vs CPU 密集

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

### 并发 vs 并行 vs 异步

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

### 容易混淆的点

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


记忆时先抓这几句：异步解决 I/O 等待时线程浪费的问题。同步阻塞线程，异步释放线程去处理其他请求。I/O 密集型用异步，CPU 密集型用并行。另外，并发是交替执行，并行是同时执行，异步是不阻塞等待、异步不等于多线程，I/O 异步通常不需要额外线程、异步提高吞吐量，不是单个请求速度、Web 应用、UI 应用、I/O 操作适合用异步。

---

## 7.2 Task、async 与 await

### Task 

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

### async 和 await 的基本用法

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

### 异步方法的返回类型

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

### 常见异步操作

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

### Task.WhenAll vs 顺序 await

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

### Task vs Thread

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

### 容易混淆的点

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


记忆时先抓这几句：Task 代表异步操作，不是线程。`async` 标记方法是异步的，`await` 等待 Task 完成。`await` 不阻塞线程，线程会被释放。另外，异步方法返回 `Task` 或 `Task<T>`，避免 `async void`、`Task.WhenAll` 并行执行多个任务，顺序 `await` 串行执行、不要用 `.Result` 或 `.Wait()` 阻塞异步方法、Task 是高层抽象，Thread 是低层抽象，优先用 Task。

---

## 7.3 并发、线程安全与常见误区

### 什么是线程安全

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

### 线程安全的实现方式

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

### 共享可变状态为什么危险

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

### 常见线程安全集合

| 集合                       | 线程安全版本                         | 适用场景 |
| -------------------------- | ------------------------------------ | -------- |
| `List<T>`                  | `ConcurrentBag<T>`                   | 无序集合 |
| `Dictionary<TKey, TValue>` | `ConcurrentDictionary<TKey, TValue>` | 键值对   |
| `Queue<T>`                 | `ConcurrentQueue<T>`                 | 先进先出 |
| `Stack<T>`                 | `ConcurrentStack<T>`                 | 后进先出 |

### 死锁

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

### 容易混淆的点

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


记忆时先抓这几句：线程安全是指多线程访问共享数据不会出错。共享可变状态是并发问题的根源。`lock` 用于保护临界区，确保同一时间只有一个线程执行。另外，`Interlocked` 提供原子操作，性能比 lock 好、线程安全集合：`ConcurrentDictionary`、`ConcurrentBag` 等、死锁是两个线程互相等待对方释放锁、异步不等于线程安全，仍需要保护共享状态、"能跑"不等于"线程安全"，需要压力测试验证。

---

## 7.4 取消、异常处理与异步中的常见坑

### 取消异步操作

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

### 异步中的异常处理

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

### 异步异常传播

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

### 常见的异步陷阱

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

### 容易混淆的点

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


记忆时先抓这几句：`CancellationToken` 用于取消异步操作。异步异常会被捕获并存储在 Task 中。`Task.WhenAll` 只能捕获第一个异常，需要检查每个 Task。另外，忘记 await 会导致方法立即返回，操作未完成、`async void` 吞掉异常，只用于事件处理器、构造函数不能是 async，使用工厂方法、CPU 密集型用 `Task.Run`，I/O 密集型不需要、异步方法以 `Async` 结尾是约定。

---

## 7.5 单元测试基础

### 单元测试

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

### Arrange-Act-Assert（AAA）模式

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

### 测试命名约定

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

### xUnit 常用特性

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

### 单元测试 vs 集成测试

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

### 什么值得测试

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

### 容易混淆的点

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


记忆时先抓这几句：单元测试测试代码的最小单元（通常是方法）。AAA 模式：Arrange（准备）、Act（执行）、Assert（断言）。测试命名：MethodName_Scenario_ExpectedResult。另外，`[Fact]` 单个测试，`[Theory]` 参数化测试、单元测试快速、隔离依赖，集成测试慢、使用真实依赖、测试业务逻辑和边界条件，不测试简单 getter/setter、测试应该独立、快速、可重复、覆盖率是指标不是目标，重点是测试关键逻辑。

---

## 7.6 断言、Mock 与测试价值

### 常用断言

```csharp
// xUnit 断言
Assert.Equal(expected, actual);           // 相等
Assert.NotEqual(expected, actual);        // 不相等
Assert.True(condition);                   // 为真
Assert.False(condition);                  // 为假
Assert.Null(obj);                         // 为 null
Assert.NotNull(obj);                      // 不为 null
Assert.Empty(collection);                 // 集合为空
Assert.NotEmpty(collection);              // 集合不为空
Assert.Contains(item, collection);        // 包含元素
Assert.Throws<Exception>(() => method()); // 抛出异常

// 字符串断言
Assert.StartsWith("Hello", text);
Assert.EndsWith("World", text);
Assert.Contains("test", text);

// 集合断言
Assert.Equal(3, list.Count);
Assert.All(list, item => Assert.True(item > 0));
```

### Mock 

Mock 是模拟依赖对象的行为，用于隔离测试：

```csharp
// 被测试的代码
public class OrderService
{
    private readonly IEmailService emailService;
    
    public OrderService(IEmailService emailService)
    {
        this.emailService = emailService;
    }
    
    public bool ProcessOrder(Order order)
    {
        // 处理订单
        order.Status = "Processed";
        
        // 发送邮件
        emailService.SendEmail(order.Email, "订单已处理");
        
        return true;
    }
}

// 测试代码（使用 Moq）
[Fact]
public void ProcessOrder_ValidOrder_SendsEmail()
{
    // Arrange
    var mockEmailService = new Mock<IEmailService>();
    var service = new OrderService(mockEmailService.Object);
    var order = new Order { Email = "test@example.com" };
    
    // Act
    service.ProcessOrder(order);
    
    // Assert
    mockEmailService.Verify(
        x => x.SendEmail("test@example.com", "订单已处理"),
        Times.Once
    );
}
```

### Stub / Fake / Mock

| 类型     | 含义       | 用途         | 示例               |
| -------- | ---------- | ------------ | ------------------ |
| **Stub** | 返回固定值 | 提供测试数据 | 返回固定的用户对象 |
| **Fake** | 简化实现   | 替代真实依赖 | 内存数据库         |
| **Mock** | 验证交互   | 验证方法调用 | 验证邮件是否发送   |

```csharp
// Stub：返回固定值
var stubRepository = new Mock<IUserRepository>();
stubRepository.Setup(x => x.GetById(1))
    .Returns(new User { Id = 1, Name = "Alice" });

// Mock：验证交互
var mockEmailService = new Mock<IEmailService>();
service.SendNotification(user);
mockEmailService.Verify(x => x.SendEmail(It.IsAny<string>()), Times.Once);
```

### 依赖注入与可测试性

```csharp
// 不可测试：直接 new 依赖
public class OrderService
{
    public bool ProcessOrder(Order order)
    {
        var emailService = new EmailService();  // 无法 Mock
        emailService.SendEmail(order.Email, "订单已处理");
        return true;
    }
}

// 可测试：依赖注入
public class OrderService
{
    private readonly IEmailService emailService;
    
    public OrderService(IEmailService emailService)
    {
        this.emailService = emailService;  // 可以 Mock
    }
    
    public bool ProcessOrder(Order order)
    {
        emailService.SendEmail(order.Email, "订单已处理");
        return true;
    }
}
```

### 测试的价值

**1. 防止回归**

- 修改代码后运行测试，确保原有功能不受影响
- 重构时的安全网

**2. 作为文档**

- 测试展示如何使用代码
- 测试说明预期行为

**3. 提高设计质量**

- 可测试的代码通常设计更好
- 强制使用依赖注入
- 降低耦合度

**4. 提高信心**

- 修改代码时更有信心
- 部署时更有信心

### 测试驱动开发（TDD）

```csharp
// 1. 先写测试（红灯）
[Fact]
public void Add_TwoNumbers_ReturnsSum()
{
    var calculator = new Calculator();
    int result = calculator.Add(2, 3);
    Assert.Equal(5, result);
}

// 2. 写最小实现（绿灯）
public class Calculator
{
    public int Add(int a, int b)
    {
        return a + b;
    }
}

// 3. 重构（保持绿灯）
```

**TDD 的价值：**

- 先思考需求
- 确保代码可测试
- 避免过度设计

**TDD 不是银弹：**

- 不是所有场景都适合
- 学习曲线陡峭
- 可能降低开发速度

### 容易混淆的点

**1. Mock 不是万能的**

- 过度 Mock 会导致测试脆弱
- 优先测试行为，不是实现细节
- 简单依赖可以用真实对象

**2. 测试不是越多越好**

- 重点测试关键逻辑
- 避免测试简单代码
- 维护测试也有成本

**3. 私有方法要测试吗？**

- 不直接测试私有方法
- 通过公开方法间接测试
- 如果私有方法很复杂，考虑提取为独立类

**4. 面试常问：如何提高代码可测试性？**

- 使用依赖注入
- 避免静态方法和全局状态
- 单一职责原则
- 接口隔离


记忆时先抓这几句：断言用于验证结果是否符合预期。Mock 模拟依赖对象的行为，用于隔离测试。Stub 返回固定值，Mock 验证交互。另外，依赖注入提高可测试性、测试的价值：防止回归、作为文档、提高设计质量、TDD 先写测试再写实现，确保代码可测试、不要过度 Mock，优先测试行为不是实现细节、私有方法通过公开方法间接测试。

---

## 高频判断

- 异步解决 I/O 等待时线程浪费的问题，提高吞吐量
- Task 代表异步操作不是线程，`async/await` 不阻塞线程
- I/O 密集型用异步，CPU 密集型用并行
- 并发是交替执行，并行是同时执行，异步是不阻塞等待
- 线程安全是指多线程访问共享数据不会出错
- 共享可变状态是并发问题的根源，用 lock 或线程安全集合保护
- `CancellationToken` 用于取消异步操作
- 单元测试测试最小单元，AAA 模式：Arrange-Act-Assert
- Mock 模拟依赖对象，隔离测试
- 测试的价值：防止回归、作为文档、提高设计质量

---

## 第8章 Web 开发与部署入门

### 目录
8.1 Web API 项目的最小结构  
8.2 请求是怎么进来的  
8.3 路由、控制器、中间件、依赖注入的区分  
8.4 从发布到部署的完整流程

---

理解Web应用，就是理解两条主线：**Web主线**（请求怎么进来、怎么处理、怎么返回）和**部署主线**（代码怎么发布、怎么部署、怎么运行）。这一章就是帮你把这两条主线重新接起来。

---

## 8.1 Web API 项目的最小结构

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


记忆时先抓这几句：控制台程序执行一次就结束，Web项目持续运行等待请求。`Program.cs`做三件事：创建构建器、注册服务、配置中间件、启动应用。`builder`配置依赖注入，`app`配置中间件管道。另外，Kestrel是内置Web服务器，生产环境通常加反向代理。

---

## 8.2 请求是怎么进来的

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


记忆时先抓这几句：请求流程：Kestrel接收 → 中间件处理 → 路由匹配 → 控制器执行 → 返回响应、路由找到处理方法，中间件做通用处理，控制器组织业务逻辑，依赖注入管理对象、HTTP方法：GET查询、POST创建、PUT更新、DELETE删除。

---

## 8.3 路由、控制器、中间件、依赖注入的区分

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


记忆时先抓这几句：路由决定URL如何映射到代码，中间件做通用处理，控制器组织业务逻辑，依赖注入管理对象。中间件顺序很重要：异常处理最外层，认证在授权之前。依赖注入三种生命周期：Transient、Scoped、Singleton。另外，Scoped适合数据库上下文和业务服务，Singleton适合配置和缓存。

---

## 8.4 从发布到部署的完整流程

写完代码后，要把应用部署到服务器让用户访问。这个过程是一条主线：**发布** → **容器化** → **部署** → **配置运行环境**。理解这条主线，就理解了应用是怎么从开发环境到生产环境的。

### 发布：生成部署包

发布就是把代码编译成可执行文件，并把所有依赖打包在一起。`dotnet publish`做的就是这件事。

```bash
# 发布到文件夹
dotnet publish -c Release -o ./publish
```

发布有两种模式：**依赖框架**（需要服务器安装.NET，体积小）和**独立发布**（包含.NET运行时，体积大但不需要安装.NET）。工作中服务器通常用依赖框架。

### 容器化：Docker统一运行环境

发布后，下一步是容器化。Docker把应用和依赖打包成镜像，可以在任何支持Docker的环境运行。这是现在最流行的部署方式，因为它解决了"开发环境能跑，生产环境不能跑"的问题。

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY publish/ .
ENTRYPOINT ["dotnet", "MyApi.dll"]
```

```bash
# 构建镜像
docker build -t myapi .

# 运行容器
docker run -d -p 8080:80 myapi
```

Docker的好处是环境一致（开发、测试、生产用同一个镜像）、部署简单（一个命令启动）、易于扩展（启动多个容器做负载均衡）。

### 部署：上传并运行

容器化后，就可以部署了。部署方式有三种：**手动部署**（上传文件到服务器，手动运行）、**容器部署**（推送镜像到仓库，服务器拉取并运行）、**云平台托管**（Azure、AWS、阿里云提供托管服务）。

工作中最常用的是容器部署。推送镜像到Docker Hub或私有仓库，服务器拉取镜像并运行。云平台托管更省心（不用管服务器维护、自动扩展、集成日志监控），但成本较高。

### 配置运行环境

部署后，还需要配置运行环境。主要是三件事：**反向代理**、**环境变量**、**CI/CD**。

**反向代理**：Kestrel虽然性能好，但生产环境通常在它前面加个反向代理（Nginx或IIS）。反向代理做三件事：负载均衡（多个Kestrel实例分担流量）、SSL终止（处理HTTPS）、静态文件服务（直接返回图片、CSS、JS）。

**环境变量**：Web应用需要配置数据库连接、API密钥、日志级别等信息，这些配置通常放在`appsettings.json`文件中。不同环境（开发、测试、生产）有不同的配置，通过环境变量`ASPNETCORE_ENVIRONMENT`区分。

**CI/CD**：手动部署容易出错，CI/CD自动化整个流程：代码提交 → 自动测试 → 自动构建 → 自动部署。常用工具有GitHub Actions、GitLab CI、Jenkins。CI（持续集成）是自动测试和构建，CD（持续部署）是自动部署到服务器。

### 完整流程串起来

从开发到上线的完整流程：

1. **开发**：写代码，本地测试（`dotnet run`）
2. **发布**：生成部署包（`dotnet publish`）
3. **容器化**：构建Docker镜像（`docker build`）
4. **推送**：推送镜像到仓库（`docker push`）
5. **部署**：服务器拉取镜像并运行（`docker pull` + `docker run`）
6. **配置**：设置反向代理、环境变量、SSL证书
7. **自动化**：配置CI/CD，每次提交代码自动走一遍

这就是一个Web应用从开发到上线的完整主线。理解了这条主线，就理解了应用是怎么部署的。


记忆时先抓这几句：部署主线：发布 → 容器化 → 部署 → 配置运行环境。发布是生成部署包（`dotnet publish`），依赖框架发布体积小需要安装.NET。Docker把应用和依赖打包成镜像，环境一致、部署简单。另外，反向代理做负载均衡、SSL终止、静态文件服务、CI/CD自动化测试、构建、部署流程、完整流程：开发 → 发布 → 容器化 → 推送 → 部署 → 配置 → 自动化。

---

## 高频判断

- 控制台程序执行一次就结束，Web项目持续运行等待请求
- 请求流程：路由找方法 → 中间件处理 → 控制器执行 → 依赖注入提供服务
- 中间件顺序很重要：异常处理最外层，认证在授权之前
- 依赖注入三种生命周期：Transient、Scoped、Singleton
- 部署主线：发布 → 容器化 → 部署 → 配置运行环境
- Docker把应用和依赖打包成镜像，环境一致、部署简单
- 反向代理做负载均衡、SSL终止、静态文件服务
- CI/CD自动化测试、构建、部署流程

---
