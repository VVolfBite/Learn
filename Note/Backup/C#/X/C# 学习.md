# C# 学习

**前言**：C# 的背景与目的，是围绕 .NET 平台提供一门适合“长期维护的大型工程”的现代语言：不仅写代码，还要把项目创建、依赖管理、构建测试、发布部署串成一条统一工作流。它与 Java 同属企业级与工程化路线，但更强调与微软生态/工具链的深度整合；与 Python 那种“轻量脚本优先”相比，C# 更偏向用规范与类型系统来支撑复杂项目。语言特性上，C# 的风格是“强类型 + 面向对象为主 + 高表达力”：泛型、属性、委托/事件、LINQ、模式匹配、async/await 等特性让代码既能保持结构化，又能写得简洁。对比 Go 的“语言特性克制”、C++ 的“底层控制强但复杂度高”、Python 的“动态灵活但大型重构成本高”，C# 更像把现代抽象能力与可维护性放在优先级更高的位置。具体功能上，C# 的独特优势往往来自“语言 + 运行时 + 库 + 框架 + 工具链”的一体化：.NET 标准库覆盖网络/并发/序列化/IO 等常见需求，`dotnet` + NuGet + MSBuild 让依赖与构建发布更统一；后端可直接走 ASP.NET Core，游戏侧又有 Unity 以 C# 作为主脚本语言。相比需要自行拼装生态的 C/C++，或需要多套工具组合的动态语言栈，C# 更容易在同一套工程体系下同时支撑后端与游戏开发。

**后文描述**：

第 1 章 基础语法与通用编程能力

本章旨在建立 C# 编程的基本表达能力与调试习惯，内容涵盖变量与类型体系、表达式与运算符、分支与循环、方法与参数机制、基础输入输出与常用容器的入门使用，并配合断点调试、单步执行、调用栈与变量观察等手段完成问题定位。阶段性要求为能够独立完成若干控制台小程序，并具备将逻辑拆分为可复用函数的能力。

第 2 章 C# 语言特性与惯用写法

本章聚焦 C# 区别于通用语法层的核心特性与主流编码风格，重点包括属性与封装习惯、泛型与泛型集合、委托与事件模型、LINQ 数据查询表达、异常体系与资源管理（`IDisposable/using`）、以及异步编程模型（`async/await`）的基础认知，同时纳入类型安全与空值处理的基本规范。阶段性要求为能够读写具有典型 C# 风格的代码，并在小型模块中正确运用上述机制提升可读性与可维护性。

第 3 章 工程化能力与项目交付链路

本章面向“可维护、可测试、可发布”的工程目标，系统掌握 .NET 生态的项目组织与交付流程，包括解决方案与项目结构设计、NuGet 依赖管理、构建与发布（`dotnet`/MSBuild）、配置与环境区分、日志与错误边界治理、以及单元测试体系（xUnit/NUnit）与基础测试策略；同时将序列化、IO、异步与并发控制纳入工程约束进行综合训练。阶段性要求为能够产出结构清晰、具备测试、可稳定运行并可发布的完整小项目。

第 4 章 实战与作品集构建（方向实践）

本章以真实项目为载体完成能力整合：后端方向以 ASP.NET Core 为主线，覆盖 API 设计、中间件管线、鉴权、数据访问（EF Core）与部署；游戏方向以 Unity 为主线，覆盖组件化架构、生命周期管理、协程/异步、资源与场景管理、性能优化与网络交互。最终形成 2–3 个可展示项目，并以可运行、可发布、可扩展与可解释（技术取舍清晰）作为验收标准。

## 通用编程

### 基础格式

```c#
using System;
// using 关键字用于在程序中包含命名空间。一个程序可以包含多个 using 语句。
namespace RectangleApplication
// 命名空间，命名空间用于区分不同空间的名称定义，最常见的是用于分割不同文件间的名称定义
{
    class Rectangle
    // 类，一个类由成员变量与方法函数组成
    {
        // 成员变量
        double length;
        double width;
        // 成员函数
        public void Acceptdetails()
        {
            length = 4.5;    
            width = 3.5;
        }
        public double GetArea()
        {
            return length * width;
        }
        public void Display()
        {
            Console.WriteLine("Length: {0}", length);
            Console.WriteLine("Width: {0}", width);
            Console.WriteLine("Area: {0}", GetArea());
        }
    }
    
    class ExecuteRectangle
    {
        // 执行入口，通常为Main函数
        static void Main(string[] args)
        {
            Rectangle r = new Rectangle();
            r.Acceptdetails();
            r.Display();
            Console.ReadLine();
        }
    }
}
```

### 预编译与命名空间

#### 预编译

​	预处理器指令指导编译器在实际编译开始之前对信息进行预处理。通过这些指令，可以控制编译器如何编译文件或编译哪些部分。常见的预处理器指令包括条件编译、宏定义等。所有的预处理器指令都是以 **#** 开始，且在一行上，只有空白字符可以出现在预处理器指令之前。预处理器指令不是语句，所以它们不以分号 **;** 结束。C# 编译器没有一个单独的预处理器，但是，指令被处理时就像是有一个单独的预处理器一样。在 C# 中，预处理器指令用于在条件编译中起作用。与 C 和 C++ 不同的是，它们不是用来创建宏。一个预处理器指令必须是该行上的唯一指令。通过预编译可以实现：1. **提高代码可读性**：使用`#region`可以帮助分隔代码块，提高代码的组织性。2. **条件编译**：通过`#if`等指令可以在开发和生产环境中编译不同的代码，方便调试和发布。3. **警告和错误**：通过`#warning`和`#error`可以在编译时提示开发人员注意特定问题。

以下是C# 中可用的预处理器指令：

| 指令         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| `#define`    | 定义一个符号，可以用于条件编译。                             |
| `#undef`     | 取消定义一个符号。                                           |
| `#if`        | 开始一个条件编译块，如果符号被定义则包含代码块。             |
| `#elif`      | 如果前面的 `#if` 或 `#elif` 条件不满足，且当前条件满足，则包含代码块。 |
| `#else`      | 如果前面的 `#if` 或 `#elif` 条件不满足，则包含代码块。       |
| `#endif`     | 结束一个条件编译块。                                         |
| `#warning`   | 生成编译器警告信息。                                         |
| `#error`     | 生成编译器错误信息。                                         |
| `#region`    | 标记一段代码区域，可以在IDE中折叠和展开这段代码，便于代码的组织和阅读。 |
| `#endregion` | 结束一个代码区域。                                           |
| `#line`      | 更改编译器输出中的行号和文件名，可以用于调试或生成工具的代码。 |
| `#pragma`    | 用于给编译器发送特殊指令，例如禁用或恢复特定的警告。         |
| `#nullable`  | 控制可空性上下文和注释，允许启用或禁用对可空引用类型的编译器检查。 |

**#define** 用于定义符号（通常用于条件编译），**#undef** 用于取消定义符号。这样，通过使用符号作为传递给 #if 指令的表达式，条件指令用于测试符号是否为真。如果为真，编译器会执行 **#if** 和下一个指令之间的代码。一个以 **#if** 指令开始的条件指令，必须显示地以一个 **#endif** 指令终止。

```c#
#define DEBUG

#if DEBUG
    Console.WriteLine("Debug mode");
#elif RELEASE
    Console.WriteLine("Release mode");
#else
    Console.WriteLine("Other mode");
#endif
```

**#warning** 用于生成编译器警告，**#error** 用于生成编译器错误。

```
#warning This is a warning message
#error This is an error message
```

**#region** 和 **#endregion** 用于代码折叠，使代码更加可读。**#line** 用于更改文件行号和文件名的编译器输出。**#pragma** 用于向编译器发送特殊指令。最常见的用法是禁用特定的警告。

```c#
#region MyRegion
    // Your code here
#endregion

#line 100 "MyFile.cs"
    // The next line will be reported as line 100 in MyFile.cs
    Console.WriteLine("This is line 100");
#line default
    // Line numbering returns to normal
    
#pragma warning disable 414
    private int unusedVariable;
#pragma warning restore 414
```

#### 命名空间

​	**命名空间**的设计目的是提供一种让一组名称与其他名称分隔开的方式。在一个命名空间中声明的类的名称与另一个命名空间中声明的相同的类的名称不冲突。命名空间的定义是以关键字 **namespace** 开始，后跟命名空间的名称。为了调用支持命名空间版本的函数或变量，会把命名空间的名称置于前面。**using** 关键字表明程序使用的是给定命名空间中的名称。该指令告诉编译器随后的代码使用了指定命名空间中的名称。命名空间可以嵌套，使用点（.）运算符访问嵌套的命名空间的成员。

```c#
// 1.a 使用 using 引入命名空间
using System;
using SomeNameSpace;
using SomeNameSpace.Nested;
// 1.b 为命名空间起别名
using Nested = SomeNameSpace.Nested;

// 2. 定义一个命名空间
namespace SomeNameSpace
{
    public class MyClass 
    {
        static void Main() 
        {
            // 3.此时不需要使用完整的路径即可使用 System 下的函数
            Console.WriteLine("In SomeNameSpace");
            Nested.NestedNameSpaceClass.SayHello();
        }
    }

    // 4.内嵌命名空间
    namespace Nested   
    {
        public class NestedNameSpaceClass 
        {
            public static void SayHello() 
            {
                Console.WriteLine("In Nested");
            }
        }
    }
}
```

### 类型、变量与常量

#### 类型

**变量类型**：**值类型、引用类型、指针类型**

**值类型**：值类型变量可以直接分配给一个值。它们是从类 **System.ValueType** 中派生的。值类型直接包含数据。比如 **int、char、float**，它们分别存储数字、字符、浮点数。当您声明一个 **int** 类型时，系统分配内存来存储值。如需得到一个类型或一个变量在特定平台上的准确尺寸，可以使用 **sizeof** 方法。表达式 *sizeof(type)* 产生以字节为单位存储对象或类型的存储尺寸。

```c#
// 1. 使用sizeof获取数据类型长度
Console.WriteLine("Size of int: {0}", sizeof(int));
```

| 类型    | 描述                                 | 范围                                                    | 默认值 |
| :------ | :----------------------------------- | :------------------------------------------------------ | :----- |
| bool    | 布尔值                               | True 或 False                                           | False  |
| byte    | 8 位无符号整数                       | 0 到 255                                                | 0      |
| char    | 16 位 Unicode 字符                   | U +0000 到 U +ffff                                      | '\0'   |
| decimal | 128 位精确的十进制值，28-29 有效位数 | (-7.9 x 1028 到 7.9 x 1028) / 100 到 28                 | 0.0M   |
| double  | 64 位双精度浮点型                    | (+/-)5.0 x 10-324 到 (+/-)1.7 x 10308                   | 0.0D   |
| float   | 32 位单精度浮点型                    | -3.4 x 1038 到 + 3.4 x 1038                             | 0.0F   |
| int     | 32 位有符号整数类型                  | -2,147,483,648 到 2,147,483,647                         | 0      |
| long    | 64 位有符号整数类型                  | -9,223,372,036,854,775,808 到 9,223,372,036,854,775,807 | 0L     |
| sbyte   | 8 位有符号整数类型                   | -128 到 127                                             | 0      |
| short   | 16 位有符号整数类型                  | -32,768 到 32,767                                       | 0      |
| uint    | 32 位无符号整数类型                  | 0 到 4,294,967,295                                      | 0      |
| ulong   | 64 位无符号整数类型                  | 0 到 18,446,744,073,709,551,615                         | 0      |
| ushort  | 16 位无符号整数类型                  | 0 到 65,535                                             | 0      |

**引用类型**：引用类型指的是一个内存位置，它不包含存储在变量中的实际数据，但它们包含对变量的引用。如果内存位置的数据是由一个变量改变的，其他变量会自动反映这种值的变化。**内置的** 引用类型有：**object**、**dynamic** 和 **string**。

```c#
// 1.object 类型
object obj;
obj = 100; // 这是装箱
// 2. dynamic 类型
dynamic d = 20; // 运行时推测类型
// 3. string 类型
string str = @"C:\Windows"; // 逐字处理""内的字符
string str = "C:\\Windows"; // 转义处理\后的字符
string str = @"<script type=""text/javascript"">
    <!--
    -->
</script>"; //逐字符后允许随意换行表示字符串
```

| 类型                 | 描述                                                         |
| :------------------- | :----------------------------------------------------------- |
| 对象（Object）类型   | C# 通用类型系统（CTS）中所有数据类型的终极基类。Object 是 System.Object 类的别名。所以对象（Object）类型可以被分配任何其他类型（值类型、引用类型、预定义类型或用户自定义类型）的值。但是，在分配值之前，需要先进行类型转换。当一个值类型转换为对象类型时，则被称为 **装箱**；另一方面，当一个对象类型转换为值类型时，则被称为 **拆箱**。 |
| 动态（Dynamic）类型  | 可以存储任何类型的值在动态数据类型变量中。这些变量的类型检查是在**运行时**发生的。 |
| 字符串（String）类型 | 字符串（String）类型是 System.String 类的别名。它是从对象（Object）类型派生的。字符串（String）类型的值可以通过两种形式进行分配：引号和 @引号。 |
| 自定义引用类型       | class、interface 或 delegate等是可以自定义的引用类型。       |

**指针类型**：指针类型变量存储其他变量类型的内存地址。本质上引用类型是扩展了部分操作的指针类型。

**类型转换**：将一个数据类型的值转换为另一个数据类型的过程。可以分为两种：**隐式类型转换**和**显式类型转换**（也称为强制类型转换）。隐式转换是不需要编写代码来指定的转换，编译器会自动进行。例如，从 int 到 long，从 float 到 double 等。从小的整数类型转换为大的整数类型，从派生类转换为基类。将一个 byte 类型的变量赋值给 int 类型的变量，编译器会自动将 byte 类型转换为 int 类型，不需要显示转换。显式类型转换，即强制类型转换，需要程序员在代码中明确指定，强制转换会造成数据丢失。本身有许多方法提供了类型转换，例如ToType()，Convert，Parse。

```c#
// 0. 强制转换
double doubleValue = 3.14;
int intValue = (int)doubleValue; // 强制从 double 到 int，数据可能损失小数部分
// 1. Convert 类提供了一组静态方法，可以在各种基本数据类型之间进行转换。
string str = "123";
int num = Convert.ToInt32(str);
// 2. Parse 方法用于将字符串转换为对应的数值类型，如果转换失败会抛出异常。
string str = "123.45";
double d = double.Parse(str);
// 3. TryParse 方法类似于 Parse，但它不会抛出异常，而是返回一个布尔值指示转换是否成功。
string str = "123.45";
double d;
bool success = double.TryParse(str, out d);

if (success) {
    Console.WriteLine("转换成功: " + d);
} else {
    Console.WriteLine("转换失败");
}

// 4. C# 还允许你定义自定义类型转换操作，通过在类型中定义 implicit 或 explicit 关键字。
using System;
public class Fahrenheit
{
    public double Degrees { get; set; }

    public Fahrenheit(double degrees)
    {
        Degrees = degrees;
    }

    // 隐式转换从Fahrenheit到double
    public static implicit operator double(Fahrenheit f)
    {
        return f.Degrees;
    }

    // 显式转换从double到Fahrenheit
    public static explicit operator Fahrenheit(double d)
    {
        return new Fahrenheit(d);
    }
}
public class Program
{
    public static void Main()
    {
        Fahrenheit f = new Fahrenheit(98.6);
        Console.WriteLine("Fahrenheit object: " + f.Degrees + " degrees");

        double temp = f; // 隐式转换
        Console.WriteLine("After implicit conversion to double: " + temp + " degrees");

        Fahrenheit newF = (Fahrenheit)temp; // 显式转换
        Console.WriteLine("After explicit conversion back to Fahrenheit: " + newF.Degrees + " degrees");
    }
}
```

#### 变量

**变量定义**：`<data_type> <variable_list>;`在这里，data_type 必须是一个有效的 C# 数据类型，可以是 char、int、float、double 或其他用户自定义的数据类型。variable_list 可以由一个或多个用逗号分隔的标识符名称组成。变量的命名需要遵循一些规则：1. 变量名可以包含字母、数字和下划线。2. 变量名必须以字母或下划线开头。3. 变量名区分大小写。4. 避免使用 C# 的关键字作为变量名。

**变量作用域**：1. 在方法、循环、条件语句等代码块内声明的变量是局部变量，它们只在声明它们的代码块中可见。2. 块级作用域，即使用大括号 **{}** 创建的任何块都可以定义变量的作用域。3. 方法的参数也有其自己的作用域，它们在整个方法中都是可见的。4. 在类的成员级别定义的变量是成员变量，它们在整个类中可见，如果在命名空间级别定义，那么它们在整个命名空间中可见。5. 静态变量是在类级别上声明的，但它们的作用域也受限于其定义的类。

#### 常量

常量是固定值，程序执行期间不会改变。常量可以是任何基本数据类型，比如整数常量、浮点常量、字符常量或者字符串常量，还有枚举常量。常量可以被当作常规的变量，只是它们的值在定义后不能被修改。常量是使用 **const** 关键字来定义的 。

### 运算符与表达式

#### 运算符

运算符可以分为**算术运算符、关系运算符、逻辑运算符、位运算符、赋值运算符、其他运算符**

| 运算符   | 描述                                                         | 实例                                                         |
| :------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| +        | 把两个操作数相加                                             | A + B 将得到 30                                              |
| -        | 从第一个操作数中减去第二个操作数                             | A - B 将得到 -10                                             |
| *        | 把两个操作数相乘                                             | A * B 将得到 200                                             |
| /        | 分子除以分母                                                 | B / A 将得到 2                                               |
| %        | 取模运算符，整除后的余数                                     | B % A 将得到 0                                               |
| ++       | 自增运算符，整数值增加 1                                     | A++ 将得到 11                                                |
| --       | 自减运算符，整数值减少 1                                     | A-- 将得到 9                                                 |
| ==       | 检查两个操作数的值是否相等，如果相等则条件为真。             | (A == B) 不为真。                                            |
| !=       | 检查两个操作数的值是否相等，如果不相等则条件为真。           | (A != B) 为真。                                              |
| >        | 检查左操作数的值是否大于右操作数的值，如果是则条件为真。     | (A > B) 不为真。                                             |
| <        | 检查左操作数的值是否小于右操作数的值，如果是则条件为真。     | (A < B) 为真。                                               |
| >=       | 检查左操作数的值是否大于或等于右操作数的值，如果是则条件为真。 | (A >= B) 不为真。                                            |
| <=       | 检查左操作数的值是否小于或等于右操作数的值，如果是则条件为真。 | (A <= B) 为真。                                              |
| &&       | 称为逻辑与运算符。如果两个操作数都非零，则条件为真。         | (A && B) 为假。                                              |
| \|\|     | 称为逻辑或运算符。如果两个操作数中有任意一个非零，则条件为真。 | (A \|\| B) 为真。                                            |
| !        | 称为逻辑非运算符。用来逆转操作数的逻辑状态。如果条件为真则逻辑非运算符将使其为假。 | !(A && B) 为真                                               |
| &        | 如果同时存在于两个操作数中，二进制 AND 运算符复制一位到结果中。 | (A & B) 将得到 12，即为 0000 1100                            |
| \|       | 如果存在于任一操作数中，二进制 OR 运算符复制一位到结果中。   | (A \| B) 将得到 61，即为 0011 1101                           |
| ^        | 如果存在于其中一个操作数中但不同时存在于两个操作数中，二进制异或运算符复制一位到结果中。 | (A ^ B) 将得到 49，即为 0011 0001                            |
| ~        | 按位取反运算符是一元运算符，具有"翻转"位效果，即0变成1，1变成0，包括符号位。 | (~A ) 将得到 -61，即为 1100 0011，一个有符号二进制数的补码形式。 |
| <<       | 二进制左移运算符。左操作数的值向左移动右操作数指定的位数。   | A << 2 将得到 240，即为 1111 0000                            |
| >>       | 二进制右移运算符。左操作数的值向右移动右操作数指定的位数。   | A >> 2 将得到 15，即为 0000 1111                             |
| =        | 简单的赋值运算符，把右边操作数的值赋给左边操作数             | C = A + B 将把 A + B 的值赋给 C                              |
| +=       | 加且赋值运算符，把右边操作数加上左边操作数的结果赋值给左边操作数 | C += A 相当于 C = C + A                                      |
| -=       | 减且赋值运算符，把左边操作数减去右边操作数的结果赋值给左边操作数 | C -= A 相当于 C = C - A                                      |
| *=       | 乘且赋值运算符，把右边操作数乘以左边操作数的结果赋值给左边操作数 | C *= A 相当于 C = C * A                                      |
| /=       | 除且赋值运算符，把左边操作数除以右边操作数的结果赋值给左边操作数 | C /= A 相当于 C = C / A                                      |
| %=       | 求模且赋值运算符，求两个操作数的模赋值给左边操作数           | C %= A 相当于 C = C % A                                      |
| <<=      | 左移且赋值运算符                                             | C <<= 2 等同于 C = C << 2                                    |
| >>=      | 右移且赋值运算符                                             | C >>= 2 等同于 C = C >> 2                                    |
| &=       | 按位与且赋值运算符                                           | C &= 2 等同于 C = C & 2                                      |
| ^=       | 按位异或且赋值运算符                                         | C ^= 2 等同于 C = C ^ 2                                      |
| \|=      | 按位或且赋值运算符                                           | C \|= 2 等同于 C = C \| 2                                    |
| sizeof() | 返回数据类型的大小。                                         | sizeof(int)，将返回 4.                                       |
| typeof() | 返回 class 的类型。                                          | typeof(StreamReader);                                        |
| &        | 返回变量的地址。                                             | &a; 将得到变量的实际地址。                                   |
| *        | 变量的指针。                                                 | *a; 将指向一个变量。                                         |
| ? :      | 条件表达式                                                   | 如果条件为真 ? 则为 X : 否则为 Y                             |
| is       | 判断对象是否为某一类型。                                     | If( Ford is Car) // 检查 Ford 是否是 Car 类的一个对象。      |
| as       | 强制转换，即使转换失败也不会抛出异常。                       | Object obj = new StringReader("Hello"); StringReader r = obj as StringReader; |

优先级如下：

| 类别       | 运算符                            | 结合性   |
| :--------- | :-------------------------------- | :------- |
| 后缀       | () [] -> . ++ - -                 | 从左到右 |
| 一元       | + - ! ~ ++ - - (type)* & sizeof   | 从右到左 |
| 乘除       | * / %                             | 从左到右 |
| 加减       | + -                               | 从左到右 |
| 移位       | << >>                             | 从左到右 |
| 关系       | < <= > >=                         | 从左到右 |
| 相等       | == !=                             | 从左到右 |
| 位与 AND   | &                                 | 从左到右 |
| 位异或 XOR | ^                                 | 从左到右 |
| 位或 OR    | \|                                | 从左到右 |
| 逻辑与 AND | &&                                | 从左到右 |
| 逻辑或 OR  | \|\|                              | 从左到右 |
| 条件       | ?:                                | 从右到左 |
| 赋值       | = += -= *= /= %=>>= <<= &= ^= \|= | 从右到左 |
| 逗号       | ,                                 | 从左到右 |

#### 数组

数组是一个存储相同类型元素的固定大小的顺序集合。数组中某个指定的元素是通过索引来访问的。所有的数组都是由连续的内存位置组成的。最低的地址对应第一个元素，最高的地址对应最后一个元素。

其使用形式如下：

```c#
// 声明数组
double[] balance;
// 初始化数组
double[] balance = new double[10];
double[] balance = { 2340.0, 4523.69, 3421.0};
// 访问数组
double salary = balance[9];
for ( i = 0; i < 10; i++ )
{
	balance[i] = i + 100;
}
foreach (int j in balance )
{
    int i = j-100;
    Console.WriteLine("Element[{0}] = {1}", i, j);
}
```

#### 字符串

string 关键字是 **System.String** 类的别名,使用 **string** 关键字来声明一个字符串变量。

其使用形式如下：

```c#
using System;

namespace StringApplication
{
    class Program
    {
        static void Main(string[] args)
        {
           //字符串，字符串连接
            string fname, lname;
            fname = "Rowan";
            lname = "Atkinson";

            string fullname = fname + lname;
            Console.WriteLine("Full Name: {0}", fullname);

            //通过使用 string 构造函数
            char[] letters = { 'H', 'e', 'l', 'l','o' };
            string greetings = new string(letters);
            Console.WriteLine("Greetings: {0}", greetings);

            //方法返回字符串
            string[] sarray = { "Hello", "From", "Tutorials", "Point" };
            string message = String.Join(" ", sarray);
            Console.WriteLine("Message: {0}", message);

            //用于转化值的格式化方法
            DateTime waiting = new DateTime(2012, 10, 10, 17, 58, 1);
            string chat = String.Format("Message sent at {0:t} on {0:D}", 
            waiting);
            Console.WriteLine("Message: {0}", chat);
            Console.ReadKey() ;
        }
    }
}
```

String 类有以下两个属性：

| 序号 | 属性名称 & 描述                                              |
| :--- | :----------------------------------------------------------- |
| 1    | **Chars** 在当前 *String* 对象中获取 *Char* 对象的指定位置。 |
| 2    | **Length** 在当前的 *String* 对象中获取字符数。              |

String 类有许多方法用于 string 对象的操作。下面的表格提供了一些最常用的方法：

| 序号 | 方法名称 & 描述                                              |
| :--- | :----------------------------------------------------------- |
| 1    | **public static int Compare( string strA, string strB )** 比较两个指定的 string 对象，并返回一个表示它们在排列顺序中相对位置的整数。该方法区分大小写。 |
| 2    | **public static int Compare( string strA, string strB, bool ignoreCase )** 比较两个指定的 string 对象，并返回一个表示它们在排列顺序中相对位置的整数。但是，如果布尔参数为真时，该方法不区分大小写。 |
| 3    | **public static string Concat( string str0, string str1 )** 连接两个 string 对象。 |
| 4    | **public static string Concat( string str0, string str1, string str2 )** 连接三个 string 对象。 |
| 5    | **public static string Concat( string str0, string str1, string str2, string str3 )** 连接四个 string 对象。 |
| 6    | **public bool Contains( string value )** 返回一个表示指定 string 对象是否出现在字符串中的值。 |
| 7    | **public static string Copy( string str )** 创建一个与指定字符串具有相同值的新的 String 对象。 |
| 8    | **public void CopyTo( int sourceIndex, char[] destination, int destinationIndex, int count )** 从 string 对象的指定位置开始复制指定数量的字符到 Unicode 字符数组中的指定位置。 |
| 9    | **public bool EndsWith( string value )** 判断 string 对象的结尾是否匹配指定的字符串。 |
| 10   | **public bool Equals( string value )** 判断当前的 string 对象是否与指定的 string 对象具有相同的值。 |
| 11   | **public static bool Equals( string a, string b )** 判断两个指定的 string 对象是否具有相同的值。 |
| 12   | **public static string Format( string format, Object arg0 )** 把指定字符串中一个或多个格式项替换为指定对象的字符串表示形式。 |
| 13   | **public int IndexOf( char value )** 返回指定 Unicode 字符在当前字符串中第一次出现的索引，索引从 0 开始。 |
| 14   | **public int IndexOf( string value )** 返回指定字符串在该实例中第一次出现的索引，索引从 0 开始。 |
| 15   | **public int IndexOf( char value, int startIndex )** 返回指定 Unicode 字符从该字符串中指定字符位置开始搜索第一次出现的索引，索引从 0 开始。 |
| 16   | **public int IndexOf( string value, int startIndex )** 返回指定字符串从该实例中指定字符位置开始搜索第一次出现的索引，索引从 0 开始。 |
| 17   | **public int IndexOfAny( char[] anyOf )** 返回某一个指定的 Unicode 字符数组中任意字符在该实例中第一次出现的索引，索引从 0 开始。 |
| 18   | **public int IndexOfAny( char[] anyOf, int startIndex )** 返回某一个指定的 Unicode 字符数组中任意字符从该实例中指定字符位置开始搜索第一次出现的索引，索引从 0 开始。 |
| 19   | **public string Insert( int startIndex, string value )** 返回一个新的字符串，其中，指定的字符串被插入在当前 string 对象的指定索引位置。 |
| 20   | **public static bool IsNullOrEmpty( string value )** 指示指定的字符串是否为 null 或者是否为一个空的字符串。 |
| 21   | **public static string Join( string separator, string[] value )** 连接一个字符串数组中的所有元素，使用指定的分隔符分隔每个元素。 |
| 22   | **public static string Join( string separator, string[] value, int startIndex, int count )** 连接一个字符串数组中的指定位置开始的指定元素，使用指定的分隔符分隔每个元素。 |
| 23   | **public int LastIndexOf( char value )** 返回指定 Unicode 字符在当前 string 对象中最后一次出现的索引位置，索引从 0 开始。 |
| 24   | **public int LastIndexOf( string value )** 返回指定字符串在当前 string 对象中最后一次出现的索引位置，索引从 0 开始。 |
| 25   | **public string Remove( int startIndex )** 移除当前实例中的所有字符，从指定位置开始，一直到最后一个位置为止，并返回字符串。 |
| 26   | **public string Remove( int startIndex, int count )** 从当前字符串的指定位置开始移除指定数量的字符，并返回字符串。 |
| 27   | **public string Replace( char oldChar, char newChar )** 把当前 string 对象中，所有指定的 Unicode 字符替换为另一个指定的 Unicode 字符，并返回新的字符串。 |
| 28   | **public string Replace( string oldValue, string newValue )** 把当前 string 对象中，所有指定的字符串替换为另一个指定的字符串，并返回新的字符串。 |
| 29   | **public string[] Split( params char[] separator )** 返回一个字符串数组，包含当前的 string 对象中的子字符串，子字符串是使用指定的 Unicode 字符数组中的元素进行分隔的。 |
| 30   | **public string[] Split( char[] separator, int count )** 返回一个字符串数组，包含当前的 string 对象中的子字符串，子字符串是使用指定的 Unicode 字符数组中的元素进行分隔的。int 参数指定要返回的子字符串的最大数目。 |
| 31   | **public bool StartsWith( string value )** 判断字符串实例的开头是否匹配指定的字符串。 |
| 32   | **public char[] ToCharArray()** 返回一个带有当前 string 对象中所有字符的 Unicode 字符数组。 |
| 33   | **public char[] ToCharArray( int startIndex, int length )** 返回一个带有当前 string 对象中所有字符的 Unicode 字符数组，从指定的索引开始，直到指定的长度为止。 |
| 34   | **public string ToLower()** 把字符串转换为小写并返回。       |
| 35   | **public string ToUpper()** 把字符串转换为大写并返回。       |
| 36   | **public string Trim()** 移除当前 String 对象中的所有前导空白字符和后置空白字符。 |

#### 结构体

*结构体（struct）是一种值类型（value type），用于组织和存储相关数据。***struct** *关键字用于创建结构体。*

类的对象是存储在堆空间中，结构存储在栈中。堆空间大，但访问速度较慢，栈空间小，访问速度相对更快。故而，当我们描述一个轻量级对象的时候，结构可提高效率，成本更低。当然，这也得从需求出发，假如我们在传值的时候希望传递的是对象的引用地址而不是对象的拷贝，就应该使用类了。

其使用形式如下：

```c#
using System;
using System.Text;
     
struct Books
{
   public string title;
   public string author;
   public string subject;
   public int book_id;
};  

public class testStructure
{
   public static void Main(string[] args)
   {

      Books Book1;        /* 声明 Book1，类型为 Books */
      Books Book2;        /* 声明 Book2，类型为 Books */

      /* book 1 详述 */
      Book1.title = "C Programming";
      Book1.author = "Nuha Ali"; 
      Book1.subject = "C Programming Tutorial";
      Book1.book_id = 6495407;

      /* book 2 详述 */
      Book2.title = "Telecom Billing";
      Book2.author = "Zara Ali";
      Book2.subject =  "Telecom Billing Tutorial";
      Book2.book_id = 6495700;

      /* 打印 Book1 信息 */
      Console.WriteLine( "Book 1 title : {0}", Book1.title);
      Console.WriteLine("Book 1 author : {0}", Book1.author);
      Console.WriteLine("Book 1 subject : {0}", Book1.subject);
      Console.WriteLine("Book 1 book_id :{0}", Book1.book_id);

      /* 打印 Book2 信息 */
      Console.WriteLine("Book 2 title : {0}", Book2.title);
      Console.WriteLine("Book 2 author : {0}", Book2.author);
      Console.WriteLine("Book 2 subject : {0}", Book2.subject);
      Console.WriteLine("Book 2 book_id : {0}", Book2.book_id);       

      Console.ReadKey();

   }
}
```

#### 枚举类型

*枚举是一组命名整型常量。枚举类型是使用* **enum** *关键字声明的。**C# 枚举是值类型。换句话说，枚举包含自己的值，且不能继承或传递继承。*

其使用形式如下：

```c#
enum <enum_name>
{ 
    enumeration list 
};

using System;

public class EnumTest
{
    enum Day { Sun, Mon, Tue, Wed, Thu, Fri, Sat };

    static void Main()
    {
        int x = (int)Day.Sun;
        int y = (int)Day.Fri;
        Console.WriteLine("Sun = {0}", x);
        Console.WriteLine("Fri = {0}", y);
    }
}
```



### 语句

#### 判断语句

| 语句               | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| if 语句            | 一个 **if 语句** 由一个布尔表达式后跟一个或多个语句组成。    |
| if...else 语句     | 一个 **if 语句** 后可跟一个可选的 **else 语句**，else 语句在布尔表达式为假时执行。 |
| 嵌套 if 语句       | 您可以在一个 **if** 或 **else if** 语句内使用另一个 **if** 或 **else if** 语句。 |
| switch 语句        | 一个 **switch** 语句允许测试一个变量等于多个值时的情况。     |
| 嵌套 switch 语句   | 您可以在一个 **switch** 语句内使用另一个 **switch** 语句。   |
| C# Null 条件运算符 | C# 6.0 引入了 Null 条件运算符 **?.**，用于安全地访问属性或方法，而不必写一堆 if 判断。 |
| ? : 运算符         | Exp1 ? Exp2 : Exp3; ? 表达式的值是由 Exp1 决定的。如果 Exp1 为真，则计算 Exp2 的值，结果即为整个 ? 表达式的值。如果 Exp1 为假，则计算 Exp3 的值，结果即为整个 ? 表达式的值。 |

```c#
// 1. if / if else / if 嵌套语句
if(boolean_expression)
{
   /* 如果布尔表达式为真将执行的语句 */
}
else
{
  /* 如果布尔表达式为假将执行的语句 */
}
// 2. switch / 嵌套 switch 语句
switch(ch1) 
{
   case 'A': 
      printf("这个 A 是外部 switch 的一部分" );
      switch(ch2) 
      {
         case 'A':
            printf("这个 A 是内部 switch 的一部分" );
            break;
         case 'B': /* 内部 B case 代码 */
      }
      break;
   case 'B': /* 外部 B case 代码 */
}
// 3. 三目运算符
Exp1 ? Exp2 : Exp3;
```

**C# Null 条件运算符**:Null 条件运算符是 C# 6.0 引入的一个语法糖，它允许开发者在访问对象的成员或元素之前，先检查该对象是否为 `null`。如果对象为 `null`，则整个表达式的结果为 `null`，而不会抛出 `NullReferenceException`。简单来说就是在访问前加?，如果为空则停止访问。

| 语法          | 说明                                            |
| :------------ | :---------------------------------------------- |
| `a?.b`        | 如果 `a` 不为 null，则访问 `a.b`；否则返回 null |
| `a?.Method()` | 如果 `a` 不为 null，则调用方法；否则什么都不做  |
| `a?[i]`       | 如果 `a` 不为 null，则访问索引；否则返回 null   |
| `?`           | 可空类型声明                                    |
| `??`          | Null 合并运算符                                 |
| `?.`          | Null 条件运算符                                 |
| `?[]`         | Null 条件索引运算符                             |
| `?:`          | 条件（三元）运算符                              |

#### 循环语句

| 循环类型         | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| while 循环       | 当给定条件为真时，重复语句或语句组。它会在执行循环主体之前测试条件。 |
| for/foreach 循环 | 多次执行一个语句序列，简化管理循环变量的代码。               |
| do...while 循环  | 除了它是在循环主体结尾测试条件外，其他与 while 语句类似。    |
| 嵌套循环         | 您可以在 while、for 或 do..while 循环内使用一个或多个循环。  |

| 控制语句      | 描述                                                         |
| :------------ | :----------------------------------------------------------- |
| break 语句    | 终止 **loop** 或 **switch** 语句，程序流将继续执行紧接着 loop 或 switch 的下一条语句。 |
| continue 语句 | 跳过本轮循环，开始下一轮循环。                               |

```c#
using System;

namespace Loops
{
    
    class Program
    {
        static void Main(string[] args)
        {
            /* 局部变量定义 */
            int a = 10;

            /* while 循环执行 */
            while (a < 20)
            {
                Console.WriteLine("a 的值： {0}", a);
                a++;
                if (a > 15)
                {
                    /* 使用 break 语句终止 loop */
                    break;
                }
            }
            Console.ReadLine();
            
            /* 局部变量定义 */
            int a = 10;

            /* do 循环执行 */
            do
            {
                if (a == 15)
                {
                    /* 跳过迭代 */
                    a = a + 1;
                    continue;
                }
                Console.WriteLine("a 的值： {0}", a);
                a++;

            } while (a < 20);
 
            Console.ReadLine();
        }
    }
}
```

### 异常与异常处理

#### 异常处理

异常是在程序执行期间出现的问题。C# 中的异常是对程序运行时出现的特殊情况的一种响应，比如尝试除以零。异常提供了一种把程序控制权从某个部分转移到另一个部分的方式。C# 异常处理时建立在四个关键词之上的：**try**、**catch**、**finally** 和 **throw**。**try**块标识了一个将被激活的特定的异常的代码块，后跟一个或多个 catch 块。**catch**块在程序通过异常处理程序捕获异常。**finally**块用于执行给定的语句，不管异常是否被抛出都会执行。**throw**块用于在问题出现时，抛出一个异常。

```c#
using System;
namespace ErrorHandlingApplication
{
    class DivNumbers
    {
        int result;
        DivNumbers()
        {
            result = 0;
        }
        public void division(int num1, int num2)
        {
            try
            {
                result = num1 / num2;
            }
            catch (DivideByZeroException e)
            {
                Console.WriteLine("Exception caught: {0}", e);
            }
            finally
            {
                Console.WriteLine("Result: {0}", result);
            }

        }
        static void Main(string[] args)
        {
            DivNumbers d = new DivNumbers();
            d.division(25, 0);
            Console.ReadKey();
        }
    }
}
```

#### 异常

​	C# 异常是使用类来表示的。C# 中的异常类主要是直接或间接地派生于 **System.Exception** 类。**System.ApplicationException** 和 **System.SystemException** 类是派生于 System.Exception 类的异常类。**System.ApplicationException** 类支持由应用程序生成的异常。所以程序员定义的异常都应派生自该类。**System.SystemException** 类是所有预定义的系统异常的基类。如果异常是直接或间接派生自 **System.Exception** 类，则可以抛出一个对象。可以在 catch 块中使用 throw 语句来抛出当前的对象。

下表列出了一些派生自 System.SystemException 类的预定义的异常类：

| 异常类                            | 描述                                           |
| :-------------------------------- | :--------------------------------------------- |
| System.IO.IOException             | 处理 I/O 错误。                                |
| System.IndexOutOfRangeException   | 处理当方法指向超出范围的数组索引时生成的错误。 |
| System.ArrayTypeMismatchException | 处理当数组类型不匹配时生成的错误。             |
| System.NullReferenceException     | 处理当依从一个空对象时生成的错误。             |
| System.DivideByZeroException      | 处理当除以零时生成的错误。                     |
| System.InvalidCastException       | 处理在类型转换期间生成的错误。                 |
| System.OutOfMemoryException       | 处理空闲内存不足生成的错误。                   |
| System.StackOverflowException     | 处理栈溢出生成的错误。                         |

## 面向对象

### 封装

**封装**指把一个或多个项目封闭在一个物理的或者逻辑的包中。**封装**根据具体的需要，设置使用者的访问权限，并通过* **访问修饰符** *来实现。*

- public：所有对象都可以访问；
- private：对象本身在对象内部可以访问；
- protected：只有该类对象及其子类对象可以访问
- internal：同一个程序集的对象可以访问；
- protected internal：访问限于当前程序集或派生自包含类的类型。

#### 方法

一个方法是把一些相关的语句组织在一起，用来执行一个任务的语句块。每一个 C# 程序至少有一个带有 Main 方法的类。

```c#
<Access Specifier> <Return Type> <Method Name>(Parameter List)
{
   Method Body
}
// Access Specifier：访问修饰符，这个决定了变量或方法对于另一个类的可见性。
// Return type：返回类型，一个方法可以返回一个值。返回类型是方法返回的值的数据类型。如果方法不返回任何值，则返回类型为 void。
// Method name：方法名称，是一个唯一的标识符，且是大小写敏感的。它不能与类中声明的其他标识符相同。
// Parameter list：参数列表，使用圆括号括起来，该参数是用来传递和接收方法的数据。参数列表是指方法的参数类型、顺序和数量。参数是可选的，也就是说，一个方法可能不包含参数。
// Method body：方法主体，包含了完成任务所需的指令集。
```

在 C# 中，有三种向方法传递参数的方式：

| 方式     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| 值参数   | 这种方式复制参数的实际值给函数的形式参数，实参和形参使用的是两个不同内存中的值。在这种情况下，当形参的值发生改变时，不会影响实参的值，从而保证了实参数据的安全。 |
| 引用参数 | 这种方式复制参数的内存位置的引用给形式参数。这意味着，当形参的值发生改变时，同时也改变实参的值。 |
| 输出参数 | 这种方式可以返回多个值。                                     |

#### 类与对象

当定义一个类时，你定义了一个数据类型的蓝图。这实际上并没有定义任何的数据，但它定义了类的名称意味着什么，也就是说，类的对象由什么组成及在这个对象上可执行什么操作。对象是类的实例。构成类的方法和变量称为类的成员。类的定义：以关键字 **class** 开始，后跟类的名称。类的主体，包含在一对花括号内。访问标识符 <access specifier> 指定了对类及其成员的访问规则。如果没有指定，则使用默认的访问标识符。类的默认访问标识符是 **internal**，成员的默认访问标识符是 **private**。数据类型 <data type> 指定了变量的类型，返回类型 <return type> 指定了返回的方法返回的数据类型。如果要访问类的成员，要使用点（.）运算符。

**成员变量与函数**

类的成员函数是一个在类定义中有它的定义或原型的函数，就像其他变量一样。作为类的一个成员，它能在类的任何对象上操作，且能访问该对象的类的所有成员。成员变量是对象的属性（从设计角度），且它们保持私有来实现封装。这些变量只能使用公共成员函数来访问。

**构造函数与析构函数**

构造函数是类的一个特殊的成员函数，当创建类的新对象时执行。构造函数的名称与类的名称完全相同，它没有任何返回类型。**默认的构造函数**没有任何参数。但是如果你需要一个带有参数的构造函数可以有参数，这种构造函数叫做**参数化构造函数**。析构函数是类的一个特殊的成员函数，当类的对象超出范围时执行。析构函数的名称是在类的名称前加上一个波浪形（~）作为前缀，它不返回值，也不带任何参数。析构函数用于在结束程序（比如关闭文件、释放内存等）之前释放资源。析构函数不能继承或重载。

**static、this、base**

关键字 **static** 意味着类中只有一个该成员的实例。静态变量用于定义常量，因为它们的值可以通过直接调用类而不需要创建类的实例来获取。静态变量可在成员函数或类的定义外部进行初始化。你也可以在类的定义内部初始化静态变量。简而言之，静态属性是在定义类时被分配内存而非实例化时，这也就意味着所有的实例化对象共用这所属对象的同一份静态变量或函数。

关键字 **this** 是一个特殊的指针，其在实例化一个对象后永远指向该对象本身。

关键字 **base** 是一个特殊的指针，其在实例化一个对象后永远指向该对象基类。

```c#
using System;
namespace LineApplication
{
   // 1. 定义一个类 Line
   class Line
   {
      // 2. 成员变量
      private static double thick = 9； 
      private double length;   // 线条的长度
      // 3. 构造函数
      public Line()  // 构造函数
      {
         Console.WriteLine("对象已创建");
      }
      // 4.析构函数
      ~Line() //析构函数
      {
         Console.WriteLine("对象已删除");
      }

      // 5.成员函数
      public void setLength( double len )
      {
         length = len;
      }
      public double getLength()
      {
         return length;
      }
		
      static void Main(string[] args)
      {
          // 6. 实例化一个属于line类的对象
         Line line = new Line();
         // 设置线条长度
         line.setLength(6.0);
         Console.WriteLine("线条的长度： {0}", line.getLength());           
      }
   }
}
```

### 继承

继承是面向对象程序设计中最重要的概念之一。当创建一个类时，程序员不需要完全重新编写新的数据成员和成员函数，只需要设计一个新的类，继承了已有的类的成员即可。这个已有的类被称为的**基类**，这个新的类被称为**派生类**。继承的思想实现了 **属于（IS-A）** 关系。例如，哺乳动物 **属于（IS-A）** 动物，狗 **属于（IS-A）** 哺乳动物，因此狗 **属于（IS-A）** 动物。

**类继承**:一个类可以继承自另一个类，被称为基类（父类）和派生类（子类）。**概括来说：**一个类可以继承多个接口，但只能继承自一个类。

**接口继承**:一个接口可以继承自一个或多个其他接口，派生接口继承了基接口的所有成员。派生接口可以扩展基接口的成员列表，但不能改变它们的访问修饰符。接口使用 **interface** 关键字声明，它与类的声明类似。接口声明默认是 public 的。

```c#
using System;
namespace InheritanceApplication
{
   class Shape 
   {
      public void setWidth(int w)
      {
         width = w;
      }
      public void setHeight(int h)
      {
         height = h;
      }
      protected int width;
      protected int height;
   }

   // 基类 PaintCost
   public interface PaintCost 
   {
      int getCost(int area);

   }
   // 派生类
   class Rectangle : Shape, PaintCost
   {
      public int getArea()
      {
         return (width * height);
      }
      public int getCost(int area)
      {
         return area * 70;
      }
   }
   class RectangleTester
   {
      static void Main(string[] args)
      {
         Rectangle Rect = new Rectangle();
         int area;
         Rect.setWidth(5);
         Rect.setHeight(7);
         area = Rect.getArea();
         // 打印对象的面积
         Console.WriteLine("总面积： {0}",  Rect.getArea());
         Console.WriteLine("油漆总成本： ${0}" , Rect.getCost(area));
         Console.ReadKey();
      }
   }
}
```

### 多态

多态是同一个行为具有多个不同表现形式或形态的能力。**多态性**意味着有多重形式。在面向对象编程范式中，多态性往往表现为"一个接口，多个功能"。多态性可以是静态的或动态的。在**静态多态性**中，函数的响应是在编译时发生的。在**动态多态性**中，函数的响应是在运行时发生的。在 C# 中，每个类型都是多态的，因为包括用户定义类型在内的所有类型都继承自 Object。多态就是同一个接口，使用不同的实例而执行不同操作。在编译时，函数和对象的连接机制被称为早期绑定，也被称为静态绑定。动态多态性是通过函数重载和运算符重载实现的。动态多态性是通过抽象类和虚方法实现的。

**函数重载**：在同一个范围内对相同的函数名有多个定义。函数的定义必须彼此不同，可以是参数列表中的参数类型不同，也可以是参数个数不同。不同重载只有返回类型不同的函数声明。

**运算符重载**：*重载运算符是具有特殊名称的函数，是通过关键字* **operator** *后跟运算符的符号来定义的。与其他函数一样，重载运算符有返回类型和参数列表。

| 运算符               | 描述                                         |
| :------------------- | :------------------------------------------- |
| +, -, !, ~, ++, --   | 这些一元运算符只有一个操作数，且可以被重载。 |
| +, -, *, /, %        | 这些二元运算符带有两个操作数，且可以被重载。 |
| ==, !=, <, >, <=, >= | 这些比较运算符可以被重载。                   |

**抽象**：使用关键字 **abstract** 创建抽象类，用于提供接口的部分类的实现。当一个派生类继承自该抽象类时，实现即完成。**抽象类**包含抽象方法，抽象方法可被派生类实现。派生类具有更专业的功能。下面是有关抽象类的一些规则：1. 不能创建一个抽象类的实例。2.不能在一个抽象类外部声明一个抽象方法。3. 通过在类定义前面放置关键字 **sealed**，可以将类声明为**密封类**。当一个类被声明为 **sealed** 时，它不能被继承。抽象类不能被声明为 sealed。

**虚方法**：当有一个定义在类中的函数需要在继承类中实现时，可以使用**虚方法**。虚方法是使用关键字 **virtual** 声明的。虚方法可以在不同的继承类中有不同的实现。对虚方法的调用是在运行时发生的。动态多态性是通过 **抽象类** 和 **虚方法** 实现的。

```c#
using System;
namespace PolymorphismApplication
{
   class Shape 
   {
      protected int width, height;
      public Shape( int a=0, int b=0)
      {
         width = a;
         height = b;
      }
      public virtual int area()
      {
         Console.WriteLine("父类的面积：");
         return 0;
      }
   }
   class Rectangle: Shape
   {
      public Rectangle( int a=0, int b=0): base(a, b)
      {

      }
      public override int area ()
      {
         Console.WriteLine("Rectangle 类的面积：");
         return (width * height); 
      }
   }
   class Triangle: Shape
   {
      public Triangle(int a = 0, int b = 0): base(a, b)
      {
      
      }
      public override int area()
      {
         Console.WriteLine("Triangle 类的面积：");
         return (width * height / 2); 
      }
   }
   class Caller
   {
      public void CallArea(Shape sh)
      {
         int a;
         a = sh.area();
         Console.WriteLine("面积： {0}", a);
      }
   }  
   class Tester
   {
      
      static void Main(string[] args)
      {
         Caller c = new Caller();
         Rectangle r = new Rectangle(10, 7);
         Triangle t = new Triangle(10, 5);
         c.CallArea(r);
         c.CallArea(t);
         Console.ReadKey();
      }
   }
}
```

## C# 特性内容

### 特性

 C# 里“**特性**”通常指 **Attribute（属性标记）**：一种把**元数据**附加到代码元素（类、方法、属性、字段、参数、程序集等）上的机制。它的核心用途不是“改变语法”，而是让**编译器、运行时或框架**在看到这些标记时，按约定做额外的事情：检查、生成、序列化、验证、路由映射、权限控制等。.Net 框架提供了两种类型的特性：*预定义*特性和*自定义*特性。规定特性（Attribute）的语法如下：

```
[attribute(positional_parameters, name_parameter = value, ...)]
element
```

特性（Attribute）的名称和值是在方括号内规定的，放置在它所应用的元素之前。positional_parameters 规定必需的信息，name_parameter 规定可选的信息。

#### 预定义特性

Net 框架提供了三种预定义特性——AttributeUsage、Conditional、Obsolete

**AttributeUsage** 用来声明一个自定义特性类“允许如何被使用”，它决定该特性能贴在什么语言元素上、同一目标能否重复贴以及是否会被继承。`AttributeUsage` 的 `validOn` 参数用于限定特性可以放置到哪些语言元素上，它取自枚举 `AttributeTargets`，并且可以按位组合，默认值为 `AttributeTargets.All`；可选参数 `AllowMultiple` 为该特性的同名属性提供布尔值，若为 `true` 则允许在同一目标上重复使用该特性，默认 `false`（只能使用一次）；可选参数 `Inherited` 同样为该特性的同名属性提供布尔值，若为 `true` 则该特性可被派生类（或继承链）继承，默认 `false`（不继承）。

```
[AttributeUsage(
   validon,
   AllowMultiple=allowmultiple,
   Inherited=inherited
)]
```

`Conditional` 是一个预定义特性，用于标记“条件方法”：该方法的调用是否会被编译进最终程序，取决于指定的预处理标识符是否被定义（例如 `DEBUG` 或 `TRACE`）。当标识符存在时，对该方法的调用会正常编译并执行；当标识符不存在时，这些**调用语句会在编译时被直接移除**（方法本身可以存在，但调用点不会进入 IL），从而常用于调试日志、跟踪埋点等只在特定构建配置下启用的代码。

```
[Conditional(
   conditionalSymbol
)]
```

`Obsolete` 是一个预定义特性，用于标记“不建议继续使用”的程序实体（如类、方法、属性等），以便在仍需保留旧实现时提醒使用者迁移到新方案。给某个成员加上 `[Obsolete("请改用 NewMethod")]` 后，当代码引用该成员时编译器会给出警告并显示指定消息；也可以通过设置参数将其提升为编译错误，从而强制禁止继续使用。常见场景是类中引入了新方法但为了兼容旧代码暂时保留旧方法，通过 `Obsolete` 明确提示应使用新方法而非旧方法。

```
[Obsolete(
   message
)]
[Obsolete(
   message,
   iserror
)]
```

#### 自定义特性

.NET 允许创建自定义特性（Attribute），用于在代码中以“声明式”的方式附加额外信息，并在运行时检索这些信息。特性本质上是元数据的一部分，可附着在类、方法、属性、字段等目标元素上；框架或应用程序可通过反射读取这些元数据，从而实现校验、映射、标记、诊断等功能。创建并使用自定义特性通常包含四步：声明特性类、实现特性内容（构造与属性）、将特性应用到目标元素、通过反射读取特性信息。

**声明自定义特性**

自定义特性需要继承 `System.Attribute`。同时可使用 `[AttributeUsage]` 指定它允许作用的目标以及是否允许重复使用，例如下面的 `DeBugInfo` 特性允许标注在类及其成员上，并允许同一目标重复标注：

```csharp
[AttributeUsage(
    AttributeTargets.Class |
    AttributeTargets.Constructor |
    AttributeTargets.Field |
    AttributeTargets.Method |
    AttributeTargets.Property,
    AllowMultiple = true)]
public class DeBugInfo : System.Attribute
{
}
```

**构建自定义特性**

下面构建一个 `DeBugInfo` 特性，用于记录调试相关信息：Bug 编号、开发者、最后审查日期，以及一条可选的消息。前三项作为“定位参数”（positional parameters）通过构造函数传入；消息作为“命名参数”（named parameter）通过属性设置。每个特性至少需要一个构造函数，定位参数应由构造函数接收。

```csharp
[AttributeUsage(
    AttributeTargets.Class |
    AttributeTargets.Constructor |
    AttributeTargets.Field |
    AttributeTargets.Method |
    AttributeTargets.Property,
    AllowMultiple = true)]
public class DeBugInfo : System.Attribute
{
    private readonly int bugNo;
    private readonly string developer;
    private readonly string lastReview;

    // 命名参数通常通过 public 属性提供
    public string Message { get; set; }

    public DeBugInfo(int bugNo, string developer, string lastReview)
    {
        this.bugNo = bugNo;
        this.developer = developer;
        this.lastReview = lastReview;
    }

    public int BugNo => bugNo;
    public string Developer => developer;
    public string LastReview => lastReview;
}
```

**应用自定义特性**

将特性写在目标元素之前即可应用。下面示例在类与方法上重复应用 `DeBugInfo`，其中前三个参数为定位参数，`Message = ...` 为命名参数：

```csharp
[DeBugInfo(45, "Zara Ali", "12/8/2012", Message = "Return type mismatch")]
[DeBugInfo(49, "Nuha Ali", "10/10/2012", Message = "Unused variable")]
class Rectangle
{
    protected double length;
    protected double width;

    public Rectangle(double l, double w)
    {
        length = l;
        width = w;
    }

    [DeBugInfo(55, "Zara Ali", "19/10/2012", Message = "Return type mismatch")]
    public double GetArea()
    {
        return length * width;
    }

    [DeBugInfo(56, "Zara Ali", "19/10/2012")]
    public void Display()
    {
        Console.WriteLine("Length: {0}", length);
        Console.WriteLine("Width: {0}", width);
        Console.WriteLine("Area: {0}", GetArea());
    }
}
```



### 反射

反射是指程序在运行时**获取类型信息并操作类型成员**的能力。简单理解：程序集（Assembly）包含模块（Module），模块包含类型（Type），类型包含成员（Member：字段、属性、方法等）；反射提供了一套 API，把这些结构封装成对象，供程序在运行时读取与使用。借助反射可以在运行时完成诸如：动态创建对象实例、把类型与现有对象绑定、从对象获取其真实类型，然后进一步调用方法、读取/写入字段与属性等操作。如果形象的类比的话，简而言之就是C#提供了一种操作获得指向运行时程序元素的指针，通过这些指针使得我们可以查看运行时程序的信息。反射可以在运行时读取并处理特性（Attribute）信息（例如框架的路由、序列化、校验等机制），扫描程序集/集合中的类型，按条件实例化并执行（插件化、自动注册、脚本系统等），延迟绑定（Late Binding）：在编译时不依赖具体类型，运行时再决定调用哪个成员以及在运行时生成新类型并使用（通常借助 `Reflection.Emit`，较高级，用于动态代理、运行时代码生成等）。反射读取特性时，常见入口是 `System.Type`（类型对象）。例如：

```csharp
System.Reflection.MemberInfo info = typeof(MyClass);
```

其中 `typeof(MyClass)` 返回 `Type`，而 `Type` 继承自 `MemberInfo`，所以可以用 `MemberInfo` 来接收并调用反射相关 API。

* 示例 1：读取类上的自定义特性

```csharp
using System;

[AttributeUsage(AttributeTargets.All)]
public class HelpAttribute : Attribute
{
    // 只读字段
    public readonly string Url;

    // 命名参数通常用 public 属性承载
    public string Topic { get; set; }  // named parameter

    // 构造函数参数为定位参数（positional parameters）
    public HelpAttribute(string url)   // positional parameter
    {
        Url = url;
    }
}

[Help("Information on the class MyClass")]
class MyClass
{
}

namespace AttributeAppl
{
    class Program
    {
        static void Main(string[] args)
        {
            var info = typeof(MyClass);

            object[] attributes = info.GetCustomAttributes(inherit: true);
            foreach (var a in attributes)
            {
                Console.WriteLine(a.GetType().Name);
            }

            Console.ReadKey();
        }
    }
}
```

* 示例 2：读取 Rectangle 类及其方法上的 DeBugInfo 特性

下面示例使用上一章的 `DeBugInfo` 自定义特性，并通过反射分别读取：`Rectangle` 类上的特性  和`Rectangle` 类各方法上的特性

```csharp
using System;
using System.Reflection;

namespace BugFixApplication
{
    [AttributeUsage(
        AttributeTargets.Class |
        AttributeTargets.Constructor |
        AttributeTargets.Field |
        AttributeTargets.Method |
        AttributeTargets.Property,
        AllowMultiple = true)]
    public class DeBugInfo : Attribute
    {
        private readonly int bugNo;
        private readonly string developer;
        private readonly string lastReview;

        public string Message { get; set; }  // named parameter

        public DeBugInfo(int bugNo, string developer, string lastReview) // positional parameters
        {
            this.bugNo = bugNo;
            this.developer = developer;
            this.lastReview = lastReview;
        }

        public int BugNo => bugNo;
        public string Developer => developer;
        public string LastReview => lastReview;
    }

    [DeBugInfo(45, "Zara Ali", "12/8/2012", Message = "Return type mismatch")]
    [DeBugInfo(49, "Nuha Ali", "10/10/2012", Message = "Unused variable")]
    class Rectangle
    {
        protected double length;
        protected double width;

        public Rectangle(double l, double w)
        {
            length = l;
            width = w;
        }

        [DeBugInfo(55, "Zara Ali", "19/10/2012", Message = "Return type mismatch")]
        public double GetArea()
        {
            return length * width;
        }

        [DeBugInfo(56, "Zara Ali", "19/10/2012")]
        public void Display()
        {
            Console.WriteLine("Length: {0}", length);
            Console.WriteLine("Width: {0}", width);
            Console.WriteLine("Area: {0}", GetArea());
        }
    }

    class ExecuteRectangle
    {
        static void Main(string[] args)
        {
            Rectangle r = new Rectangle(4.5, 7.5);
            r.Display();

            Type type = typeof(Rectangle);

            // 1) 遍历 Rectangle 类上的特性
            foreach (object a in type.GetCustomAttributes(inherit: false))
            {
                if (a is DeBugInfo dbi)
                {
                    Console.WriteLine("Bug No: {0}", dbi.BugNo);
                    Console.WriteLine("Developer: {0}", dbi.Developer);
                    Console.WriteLine("Last Reviewed: {0}", dbi.LastReview);
                    Console.WriteLine("Remarks: {0}", dbi.Message);
                }
            }

            // 2) 遍历 Rectangle 类的方法特性
            foreach (MethodInfo m in type.GetMethods())
            {
                foreach (object a in m.GetCustomAttributes(inherit: true))
                {
                    if (a is DeBugInfo dbi)
                    {
                        Console.WriteLine("Bug No: {0}, for Method: {1}", dbi.BugNo, m.Name);
                        Console.WriteLine("Developer: {0}", dbi.Developer);
                        Console.WriteLine("Last Reviewed: {0}", dbi.LastReview);
                        Console.WriteLine("Remarks: {0}", dbi.Message);
                    }
                }
            }

            Console.ReadLine();
        }
    }
}
```

### 属性

属性是类/结构体对外暴露数据的主要方式，本质上是一组可执行的访问器（`get` / `set`），用来读取、写入或计算一个值。它常被用作字段（field）的“门面”：字段负责内部存储，而属性负责对外提供受控的访问入口，从而实现封装（例如只读、只写、校验、延迟计算）。需要特别记住的是：属性本身并不等同于一个固定的存储单元；它更像“读写规则”。当属性是自动实现的（`{ get; set; }`）时，编译器会在后台生成隐藏字段来保存值；当属性带有自定义访问器时，`get`/`set` 中的代码决定了取值与赋值行为（包括校验、转换、触发事件等）。因此在工程代码里，字段通常保持私有以避免无约束写入，而通过属性统一管控数据一致性。

属性的常见形态可以用同一个例子串起来理解：有些属性只是简单存取数据，最适合用自动属性；有些属性需要保证有效性，就把校验逻辑放进 `set`；有些属性不需要存储而是由其他数据推导出来，就写成计算属性（只有 `get`，不落地存储）；还有一些属性为了限制外部修改，可以只保留 `get`，并只允许在构造或初始化阶段赋值。抽象类也可以声明抽象属性，用来规定派生类必须提供哪些属性签名，派生类通过 `override` 给出具体实现。总体上，复习时抓住一句话：字段是内部状态，属性是对外契约；简单用自动属性，复杂规则写访问器。



```csharp
using System;

public abstract class Person
{
    // 抽象属性：只定义“必须有”，实现交给派生类（override）
    public abstract string Name { get; set; }
    public abstract int Age { get; set; }
}

public class Student : Person
{
    // 自动属性：最常见的“存储型属性”（后台有隐藏字段）
    public string Code { get; set; } = "N.A";

    // 字段 + 自定义属性：需要校验/转换/额外逻辑时用
    private string _name = "N.A";
    public override string Name
    {
        get => _name;
        set
        {
            // set 里做校验：防止写入非法状态
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("Name cannot be empty.");
            _name = value.Trim();
        }
    }

    // 普通属性（这里也可以写成字段+校验）
    public override int Age { get; set; }

    // 只读属性：对外只读，通常在构造/初始化阶段确定（不可再被外部赋值）
    public DateTime CreatedAt { get; } = DateTime.UtcNow;

    // 计算属性：不存储，按当前状态计算得到
    public int NextAge => Age + 1;

    public override string ToString()
        => $"Code={Code}, Name={Name}, Age={Age}, NextAge={NextAge}, CreatedAt={CreatedAt:O}";
}

class Demo
{
    static void Main()
    {
        var s = new Student
        {
            Code = "001",
            Name = "  Zara  ",
            Age = 9
        };

        Console.WriteLine(s);

        s.Age += 1;   // 通过属性修改状态（仍然受属性规则约束）
        Console.WriteLine(s);

        // s.CreatedAt = DateTime.Now; // ❌ 编译错误：只读属性不能再赋值
    }
}
```

### 索引器

索引器（Indexer）让一个对象可以像数组一样用下标 `[]` 访问其内部数据。给类定义索引器后，外部代码就能写出 `obj[0]`、`obj["key"]` 这样的访问形式，而不需要显式调用 `Get/Set` 方法。索引器在语义上很像属性：同样通过 `get`/`set` 访问器控制“读”和“写”，但区别在于属性面向的是一个命名的成员（例如 `student.Name`），而索引器面向的是“对象内部的一段数据集合”，通过索引参数把数据切成更小的单元（例如第 0 个元素、某个键对应的值）。索引器没有名字，固定使用 `this` 关键字，表示“对当前实例进行下标访问”。

索引器的基本形式是 `element-type this[参数列表] { get; set; }`。返回类型 `element-type` 表示通过下标拿到的值是什么类型；参数列表不要求必须是 `int`，也可以是 `string` 等其他类型，甚至可以写多个参数（类似二维索引）。因此同一个类可以提供多个索引器重载，只要它们的参数列表不同即可。工程上索引器常见于“自定义容器”“对字典/数组的包装”“让对象提供更自然的读写语法”，同时也常用来在 `get/set` 中统一做边界检查、默认值策略或映射转换。

下面的 `IndexedNames` 内部用数组保存名字，并通过两个索引器提供两种访问方式：用 `int` 下标读写元素；用 `string` 名字反查位置（演示索引器重载）。注意 `get/set` 中可以集中处理边界检查与默认值策略，使外部访问保持简洁。

```csharp
using System;

class IndexedNames
{
    private readonly string[] _names;
    public int Size => _names.Length;

    public IndexedNames(int size = 10)
    {
        _names = new string[size];
        for (int i = 0; i < _names.Length; i++)
            _names[i] = "N.A.";
    }

    // 索引器 1：int 下标 -> string（读写）
    public string this[int index]
    {
        get
        {
            // 统一处理边界：越界返回空字符串（也可以改成抛异常）
            if (index < 0 || index >= _names.Length) return "";
            return _names[index];
        }
        set
        {
            // 统一处理边界：越界写入直接忽略（也可以改成抛异常）
            if (index < 0 || index >= _names.Length) return;
            _names[index] = value;
        }
    }

    // 索引器 2：string 名字 -> int（只读），演示索引器重载
    public int this[string name]
    {
        get
        {
            for (int i = 0; i < _names.Length; i++)
                if (_names[i] == name) return i;

            return -1; // 没找到返回 -1（也可以改成抛异常或返回 Nullable）
        }
    }
}

class Demo
{
    static void Main()
    {
        var names = new IndexedNames(size: 10);

        // 用 int 索引器写入/读取（像数组一样）
        names[0] = "Zara";
        names[1] = "Riz";
        names[2] = "Nuha";

        for (int i = 0; i < names.Size; i++)
            Console.WriteLine(names[i]);

        // 用 string 索引器反查位置（索引器重载）
        Console.WriteLine(names["Nuha"]); // 输出 2
    }
}
```

### 委托与事件

#### 委托

**委托可以理解为“类型安全的函数引用/回调句柄”。它用一个固定的方法签名（参数与返回值）来约束可绑定的方法，只有签名匹配的方法才能赋值给该委托；因此委托既能保证类型安全，又能把“要执行的逻辑”从“何时执行/由谁触发”中解耦出来。委托变量在运行时可以指向不同的方法，也可以作为参数传递，让调用方把行为注入到另一个方法里（回调、策略、管道式处理都属于这一类用法）。委托还支持多播：用 `+=` 把多个方法组合成调用链，用 `-=` 从链中移除方法；调用多播委托时会按加入顺序依次执行。工程实践中，很多自定义 delegate 声明可以直接用 `Action`、`Func`、`Predicate<T>` 替代，再配合 lambda 表达式减少样板代码。

**声明与使用**：通常先确定要表达的签名（输入/输出），再用 delegate 类型或 `Action/Func` 承载；将方法（或 lambda）赋值给委托变量后即可像调用函数一样调用。多播委托适合“一次触发，多处处理”的场景，但要记住 `-=` 移除时必须移除“同一个委托实例”，因此常把处理器保存成变量再订阅/取消订阅。

#### 事件

**事件**是在委托之上加了一层“发布-订阅”的约束，用来表达“发生了某件事，需要通知外部”。事件底层仍然是委托调用链（订阅者列表），但语义和权限不同：事件对外只暴露订阅与取消订阅（`+=` / `-=`），外部不能直接触发事件，也不能用 `=` 覆盖整个调用链，从而保证“只有发布者能发通知”。发布者通常在内部封装一个 `OnXxx` 方法来触发事件，并用 `?.Invoke(...)` 保证无订阅者时安全；订阅者只负责提供事件处理方法并注册进去。事件最常见于 UI 交互、状态变化、任务完成通知、跨组件通信等场景，本质上是观察者模式在 C# 的标准落地方式。

**声明与使用**：先选事件签名（通常优先用 `EventHandler` / `EventHandler<TEventArgs>`），在发布者类里用 `event` 声明事件；再提供触发入口（`OnXxx`），在状态变化点调用它；最后由订阅者通过 `+=` 注册处理器、通过 `-=` 取消订阅。相比“直接暴露委托字段”，事件的价值在于它把触发权收回到发布者内部，避免外部误触发或覆盖订阅列表造成的不可控行为。

**delegate** 相当于定义一个函数类型。**event** 相当于定义一个 **delegate** 的函数指针（回调函数指针）。

```csharp
using System;

public class CounterChangedEventArgs : EventArgs
{
    public int OldValue { get; }
    public int NewValue { get; }

    public CounterChangedEventArgs(int oldValue, int newValue)
    {
        OldValue = oldValue;
        NewValue = newValue;
    }
}

public class Counter
{
    public int Value { get; private set; }

    // 事件：外部只能 += / -=；触发只能在类内部
    public event EventHandler<CounterChangedEventArgs>? ValueChanged;

    // 触发事件的统一入口（标准模式）
    protected virtual void OnValueChanged(int oldValue, int newValue)
        => ValueChanged?.Invoke(this, new CounterChangedEventArgs(oldValue, newValue));

    // 委托作为参数：把“变化后要做什么”作为回调传入
    public void Add(int delta, Action<int>? afterChanged = null)
    {
        int old = Value;
        Value += delta;

        // 1) 委托回调：调用者注入的处理逻辑
        afterChanged?.Invoke(Value);

        // 2) 事件通知：发布者通知所有订阅者
        OnValueChanged(old, Value);
    }
}

class Demo
{
    static void Main()
    {
        var c = new Counter();

        // --- 事件订阅（发布-订阅）：外部只能注册/取消，不能触发 ---
        c.ValueChanged += (sender, e) =>
            Console.WriteLine($"[Event] {e.OldValue} -> {e.NewValue}");

        // --- 多播委托：把多个处理器串成调用链 ---
        Action<int> a = v => Console.WriteLine($"[A] now={v}");
        Action<int> b = v => Console.WriteLine($"[B] now*2={v * 2}");

        Action<int> pipeline = a;
        pipeline += b;  // 追加
        pipeline -= b;  // 移除（必须是同一个委托实例 b）

        // --- 委托回调：把 pipeline 作为参数传入 ---
        c.Add(5, afterChanged: pipeline);

        // 再加一次：只执行 A，同时仍触发事件通知
        c.Add(3, afterChanged: pipeline);

        // --- 内置委托类型（复习用）：Func / Predicate ---
        Func<int, int, int> add = (x, y) => x + y;
        Predicate<int> isEven = x => x % 2 == 0;

        Console.WriteLine($"Func add(3,4)={add(3, 4)}");
        Console.WriteLine($"Predicate isEven(8)={isEven(8)}");
    }
}
```

### 多线程

线程（Thread）可以理解为程序内部的一条执行路径：同一个进程里可以同时存在多条线程，各自跑自己的控制流。写多线程的意义通常不是“更快”，而是把耗时/阻塞的工作从主流程里拆出去，让程序保持响应（例如 UI 不卡、服务端能同时处理多个请求）。在 C# 里最直接的线程 API 来自 `System.Threading.Thread`：它能创建线程、启动线程、等待线程结束，并提供一些线程状态与调度相关的控制方法。需要注意：现代 .NET 更推荐用 `Task`/`async-await` 表达并发与异步，但 `Thread` 仍是理解底层模型与读旧代码的必备知识。

线程对象创建后还没 `Start()` 时处于“未启动”；调用 `Start()` 后进入可调度状态（就绪/运行由 OS 决定）；执行过程中可能因为 `Sleep()`、等待锁、I/O 等进入阻塞；当线程函数返回或异常终止后进入结束状态。实际写代码时最常关心的是：线程是否已经启动、是否仍在运行（`IsAlive`）、是否是后台线程（`IsBackground`），以及是否需要等待它结束（`Join`）。

#### 属性

**CurrentThread**：获取当前正在执行的线程对象，常用于调试或给线程命名。  
**Name**：线程名（方便日志与调试），只建议设置一次。  
**ManagedThreadId**：托管线程 ID（用于日志定位，不能当业务 ID 用）。  
**IsAlive**：线程是否仍在运行（用于判断是否已经结束）。  
**IsBackground**：是否后台线程。后台线程不会阻止进程退出：前台线程结束时，进程会直接退出并终止后台线程。  
**Priority**：调度优先级（一般不推荐随意调整，容易制造不可预测的性能问题）。  
**ThreadState**：线程状态（用于诊断，别写业务逻辑依赖状态机判断）。

#### 方法

**Start()**：启动线程。线程入口一般是 `ThreadStart`（无参）或 `ParameterizedThreadStart`（单个 object 参数）。现代写法通常直接 `new Thread(() => {...})` 用 lambda 指定入口。线程对象只能 `Start()` 一次，重复启动会抛异常。  

**Join()**：等待线程结束。常用于“主线程必须等子线程做完再继续”的场景，比如后台计算完成后再汇总结果。`Join()` 会阻塞调用方线程，因此在 UI 线程/请求线程里慎用（会卡住响应）；有超时版本 `Join(timeout)` 可避免无限等待。  

**Sleep(ms)**：让当前线程暂停一段时间，进入等待状态。常用于演示、简单节流、轮询间隔，但不适合做精确计时或高质量的并发控制（会受调度影响）。如果只是等待异步结果，现代更倾向 `await Task.Delay(...)`。  

**Interrupt()**：中断处于 `Wait/Sleep/Join` 状态的线程，使其抛出 `ThreadInterruptedException`。它更像“把正在睡/等的线程叫醒”，用于配合线程退出策略；但写起来容易复杂，现代更推荐取消令牌（`CancellationToken`）的模式。  

**Yield()**：提示调度器让出当前时间片，让同 CPU 上其他就绪线程先跑一会儿。它不是保证行为，更像一个“建议”，主要用于忙等待/自旋场景的微调。  

**Abort()（重要）**：强行终止线程会抛 `ThreadAbortException`（并不安全），现代 .NET（尤其 .NET Core/5+）里已经不推荐甚至不可用/行为变化。工程上应当用“协作式退出”：线程循环里定期检查一个标志或 `CancellationToken`，自行返回结束。换句话说：不要把 `Abort` 当作正常的线程结束方式。



```csharp
using System;
using System.Threading;

class Demo
{
    // 用一个共享标志做“协作式退出”（演示用；工程里更推荐 CancellationToken）
    private static volatile bool _stopRequested = false;

    static void Worker()
    {
        Thread.CurrentThread.Name = "WorkerThread";

        int counter = 0;
        while (!_stopRequested)
        {
            counter++;
            Console.WriteLine($"[{Thread.CurrentThread.Name}] counter={counter}");

            // Sleep：模拟耗时工作/节流
            Thread.Sleep(500);
        }

        Console.WriteLine($"[{Thread.CurrentThread.Name}] exiting gracefully.");
    }

    static void Main()
    {
        Thread main = Thread.CurrentThread;
        main.Name = "MainThread";
        Console.WriteLine($"This is {main.Name}, id={main.ManagedThreadId}");

        var t = new Thread(Worker)
        {
            IsBackground = true // 后台线程：不阻止进程退出（演示用）
        };

        Console.WriteLine("Main: start worker thread");
        t.Start(); // Start：启动

        // 主线程做点别的事
        Thread.Sleep(2000);

        // 请求线程退出（协作式）
        Console.WriteLine("Main: request worker to stop");
        _stopRequested = true;

        // Join：等待线程优雅退出（这里等待会阻塞 MainThread）
        t.Join();
        Console.WriteLine("Main: worker joined, program end");
    }
}
```

### 集合

集合是标准库里用于“存储与检索一组数据”的类型集合。对比数组，集合更强调可扩展、可组合和统一遍历；对比自定义结构，集合提供了成熟的接口与方法（增删查改、排序、复制等），让工程代码更稳定、更少重复造轮子。现代 C# 开发中优先使用 `System.Collections.Generic` 的泛型集合（`List<T> / Dictionary<TKey,TValue> / Stack<T> / Queue<T>` 等），因为它们类型安全且避免装箱拆箱；`System.Collections` 里的 `ArrayList / Hashtable / SortedList` 等非泛型集合更多用于读旧代码、兼容场景或快速原型理解。

---

**C# 动态数组（ArrayList）**

`ArrayList` 位于 `System.Collections`，是一种“可动态扩容的有序集合”，支持按索引访问，并提供插入、删除、搜索、排序、复制等常用操作。它的关键特点是容量会按需增长：当元素数量超过容量时会自动扩容（通常按倍数增长），所以不需要像数组那样预先固定长度。由于 `ArrayList` 是非泛型集合，元素以 `object` 存储，意味着可以混放任意类型，但会带来装箱/拆箱与运行时类型转换风险；在新项目中更推荐使用 `List<T>` 替代。

基本结构（理解用）：
`public class ArrayList : ICollection, IEnumerable, IList, ICloneable`

常用属性（记住“数量 Count”和“容量 Capacity”即可）：

| 属性                      | 类型          | 含义                           |
| :------------------------ | :------------ | :----------------------------- |
| Count                     | int           | 当前元素数量                   |
| Capacity                  | int           | 容量（预留存储空间）           |
| IsFixedSize / IsReadOnly  | bool          | 是否固定大小 / 是否只读        |
| IsSynchronized / SyncRoot | bool / object | 线程同步相关（默认不线程安全） |

常用方法（重点：Add/Insert/Remove/Sort）：

| 方法                                     | 返回                        | 用途                            |
| :--------------------------------------- | :-------------------------- | :------------------------------ |
| Add / AddRange                           | int / void                  | 追加单个/批量追加               |
| Insert / InsertRange                     | void                        | 指定位置插入（整体后移）        |
| Remove / RemoveAt / RemoveRange / Clear  | void                        | 删除（按值/按索引/按区间/清空） |
| Contains / IndexOf / LastIndexOf         | bool / int                  | 查询与定位                      |
| Sort / Sort(IComparer) / Reverse         | void                        | 排序/自定义排序/反转            |
| GetRange / ToArray / CopyTo / TrimToSize | ArrayList / object[] / void | 子集、复制、收缩容量            |

---

**C# 哈希表（Hashtable）**

`Hashtable` 位于 `System.Collections`，以键值对存储数据，通过 key 快速定位 value，典型用途是“按键查找”。它同样是非泛型：key/value 都是 `object`，灵活但缺少编译期类型约束；新项目更推荐 `Dictionary<TKey,TValue>`。`Hashtable` 的重点是查找与更新：写入可用 `table[key] = value`，读取时要考虑 key 不存在的情况（可能返回 `null` 或抛异常取决于用法）。

常见用法与方法（抓住索引器、ContainsKey、Remove）：

| 方法/成员                   | 含义                            |
| :-------------------------- | :------------------------------ |
| table[key]                  | 按 key 读写 value（新增或覆盖） |
| Add(key, value)             | 添加（key 已存在会异常）        |
| ContainsKey / ContainsValue | 判断是否存在                    |
| Remove(key) / Clear()       | 删除/清空                       |
| Keys / Values               | 获取键集合/值集合（用于遍历）   |

---

**C# 排序列表（SortedList）**

`SortedList` 位于 `System.Collections`，可以理解为“按键排序的键值对集合”，同时支持按 key 查找，也支持按 index 访问第 n 个键值对（因为内部按 key 排序后是有序的）。它是数组 + 哈希思想的折中：按键有序、也能用索引访问，但插入/删除可能涉及移动元素。泛型版本为 `SortedList<TKey,TValue>`；如果只关心“按键自动排序”，也常会用 `SortedDictionary<TKey,TValue>`。

常用点：按 key 访问、按 index 访问（GetKey/GetByIndex）、自动按 key 排序。

| 方法/成员                 | 含义                 |
| :------------------------ | :------------------- |
| list[key]                 | 按 key 读写          |
| GetKey(i) / GetByIndex(i) | 按索引取 key / value |
| ContainsKey               | 判断 key 是否存在    |
| Add / Remove / Clear      | 增删清空             |

---

**C# 堆栈（Stack）**

`Stack` 是后进先出（LIFO）结构，核心语义是“最后放进去的最先取出来”。常用场景包括撤销/回退、表达式求值、深度优先遍历等。对应泛型版本为 `Stack<T>`（推荐）。

常用方法（记 Push/Pop/Peek）：

| 方法          | 含义             |
| :------------ | :--------------- |
| Push(x)       | 入栈             |
| Pop()         | 出栈并返回       |
| Peek()        | 查看栈顶但不移除 |
| Count / Clear | 数量/清空        |

---

**C# 队列（Queue）**

`Queue` 是先进先出（FIFO）结构，核心语义是“先来先服务”。常用场景包括任务调度、消息缓冲、广度优先遍历等。对应泛型版本为 `Queue<T>`（推荐）。

常用方法（记 Enqueue/Dequeue/Peek）：

| 方法          | 含义             |
| :------------ | :--------------- |
| Enqueue(x)    | 入队             |
| Dequeue()     | 出队并返回       |
| Peek()        | 查看队首但不移除 |
| Count / Clear | 数量/清空        |

---

**C# 点阵列（BitArray）**

`BitArray` 位于 `System.Collections`，用位（0/1）表示布尔集合，适合“开关集合”“掩码”“大量 bool 的压缩存储”。它支持按索引读写位，且提供位运算（And/Or/Xor/Not）来批量操作。工程里常见于权限位、状态位、特征位集合等场景。

常用方法/成员：

| 方法/成员            | 含义                             |
| :------------------- | :------------------------------- |
| bits[i]              | 读写第 i 位                      |
| And / Or / Xor / Not | 位运算                           |
| Length               | 位长度                           |
| CopyTo(array, index) | 复制到数组（如 bool[] 或 int[]） |

---

**现代写法：泛型集合（推荐）**

`List<T>` 基本上就是“强类型的动态数组”：常用方法包括 `Add / AddRange / Insert / Remove / RemoveAt / Sort / Find`；`Dictionary<TKey,TValue>` 是“强类型的键值映射”：常用 `TryGetValue / ContainsKey / Remove`；`Stack<T>` 与 `Queue<T>` 分别是强类型的栈与队列。学习 `System.Collections` 的这些类型时，建议同步建立“它的泛型对应物”映射，这样读旧代码与写新代码都更顺。

```csharp
using System;
using System.Collections;
using System.Collections.Generic;

class Demo
{
    static void Main()
    {
        // List<T>：动态序列（推荐）
        var list = new List<int> { 5, 1, 3 };
        list.Insert(1, 99);                // 插入：5,99,1,3
        list.Remove(1);                    // 删除值：5,99,3
        list.RemoveAt(0);                  // 删除索引：99,3
        list.AddRange(new[] { 7, 2, 8 });   // 批量追加
        list.Sort();                        // 排序：2,3,7,8,99
        int firstGt5 = list.Find(x => x > 5);
        Console.WriteLine(string.Join(",", list));
        Console.WriteLine($"firstGt5={firstGt5}");

        // Dictionary<TKey,TValue>：按键查找（推荐）
        var dict = new Dictionary<string, int> { ["alice"] = 10, ["bob"] = 20 };
        dict["bob"] = 21;                   // 覆盖写
        if (dict.TryGetValue("alice", out var v)) Console.WriteLine($"alice={v}");
        dict.Remove("alice");

        // Stack<T>：LIFO
        var stack = new Stack<string>();
        stack.Push("A"); stack.Push("B");
        Console.WriteLine(stack.Peek());    // B
        Console.WriteLine(stack.Pop());     // B

        // Queue<T>：FIFO
        var queue = new Queue<string>();
        queue.Enqueue("A"); queue.Enqueue("B");
        Console.WriteLine(queue.Peek());    // A
        Console.WriteLine(queue.Dequeue()); // A

        // BitArray：位集合
        var bits = new BitArray(8);
        bits[2] = true; bits[5] = true;
        Console.WriteLine(bits[2]);         // True

        // 旧集合（了解用）：ArrayList / Hashtable / SortedList
        ArrayList arr = new ArrayList();
        arr.Add(123); arr.Add("hello");     // object 存储，可混类型（不推荐新代码）
        Console.WriteLine(arr[0]);

        Hashtable table = new Hashtable();
        table["k"] = 42;
        Console.WriteLine(table["k"]);

        SortedList sorted = new SortedList();
        sorted["b"] = 2;
        sorted["a"] = 1;                    // 自动按 key 排序
        Console.WriteLine(sorted.GetKey(0)); // a
    }
}
```

### 泛型

**泛型**的核心是“把类型当作参数传入”。写代码时先用类型参数（如 `T`）占位，把“元素/参数/返回值的类型”暂时延迟；等到真正使用时再指定具体类型（如 `int`、`string`、自定义类型）。这样同一份代码就能在不同类型之间复用，同时在编译期仍然保持类型安全。可以把它理解为：与其写很多份 `IntArray`、`CharArray`、`StringArray`，不如写一个 `Array<T>`；编译器在看到 `Array<int>`、`Array<char>` 时，会生成对应类型的可用代码（对你来说就是“用起来像专门为该类型写的一样”）。

泛型在工程里的意义主要体现在三个方向：第一是复用，一套容器/算法能服务多种类型；第二是安全，避免 `object` 带来的强制转换与运行时类型错误；第三是性能，尤其对值类型来说，泛型集合（例如 `List<int>`）可以避免非泛型集合（例如 `ArrayList`）里的装箱/拆箱。也正因为如此，`System.Collections.Generic`（`List<T>`、`Dictionary<TKey,TValue>` 等）是现代 .NET 代码的默认选择，而 `System.Collections` 的 `ArrayList/Hashtable` 更多用于兼容旧代码。

这段代码用一个统一例子把三类泛型用法连在一起：  

- `Box<T>` 展示“泛型类”：把存储的元素类型参数化；  
- `Swap<T>` 展示“泛型方法”：算法与类型无关；  
- `Transformer<T>` 展示“泛型委托”：把“输入输出同类型”的函数签名参数化；  
  同时顺手对比一下与 `List<T>` 的联系（实际开发常直接用标准库泛型集合，而不是自己造容器）。

```csharp
using System;
using System.Collections.Generic;

// 1) 泛型委托：签名里用类型参数 T
public delegate T Transformer<T>(T value);

// 2) 泛型类：把内部元素类型参数化
public class Box<T>
{
    private readonly T[] _items;

    public Box(int size)
    {
        _items = new T[size]; // T 在使用时才确定
    }

    public T this[int index]
    {
        get => _items[index];
        set => _items[index] = value;
    }

    public int Length => _items.Length;
}

class Demo
{
    // 3) 泛型方法：算法与类型无关，只要求“同一类型可交换”
    static void Swap<T>(ref T left, ref T right)
    {
        T tmp = left;
        left = right;
        right = tmp;
    }

    static void Main()
    {
        // --- 泛型类：同一个 Box<T>，用不同 T 复用 ---
        var intBox = new Box<int>(5);
        for (int i = 0; i < intBox.Length; i++) intBox[i] = i * 5;
        Console.WriteLine($"{intBox[0]} {intBox[1]} {intBox[2]} {intBox[3]} {intBox[4]}");

        var charBox = new Box<char>(5);
        for (int i = 0; i < charBox.Length; i++) charBox[i] = (char)('a' + i);
        Console.WriteLine($"{charBox[0]} {charBox[1]} {charBox[2]} {charBox[3]} {charBox[4]}");

        // --- 泛型方法：Swap<T> ---
        int a = 10, b = 20;
        Swap(ref a, ref b);
        Console.WriteLine($"a={a}, b={b}");

        // --- 泛型委托：Transformer<T> ---
        Transformer<int> plusOne = x => x + 1;
        Transformer<string> trim = s => s.Trim();

        Console.WriteLine(plusOne(41));        // 42
        Console.WriteLine(trim("  hi  "));     // "hi"

        // --- 标准库泛型集合：实际开发更常直接用 List<T> ---
        var list = new List<int> { 1, 2, 3 };
        list.Add(4);
        Console.WriteLine(string.Join(",", list));
    }
}
```

**泛型类/接口**：容器与抽象最常见，例如 `List<T>`、`Dictionary<TKey,TValue>`、`IEnumerable<T>`。 
**泛型方法**：算法型工具函数最常见，例如交换、映射、转换、过滤等。  
**泛型委托/事件**：把回调签名参数化，例如 `Func<T,...>`、`Action<T,...>`、`EventHandler<TEventArgs>`。  
**约束（Constraint）**：当泛型需要调用某些成员时，可以用约束限制 `T` 的能力范围，例如要求 `T : class`（引用类型）、`T : struct`（值类型）、`T : new()`（可无参构造）、`T : 某接口`（必须实现接口）。约束的意义是：让泛型在“仍然通用”的同时，能安全地使用目标类型必须具备的特性。  
**运行时类型信息**：泛型类型参数在运行时仍可通过反射等方式获取（尤其是在 .NET 的泛型实现中），但日常编码更多依赖编译期类型系统完成约束与推断。

### 匿名方法与 Lambda

#### 匿名方法

匿名方法可以理解为“没有名字的函数体”，通常用来**直接创建一个委托实例**，把一段代码块当作参数传给需要委托的地方。它的语法关键点是 `delegate(...) { ... }`：`delegate` 后面是参数列表，花括号里是要执行的代码块，最后整个匿名方法表达式要以 `;` 结束。匿名方法的返回类型一般不需要显式写出来，编译器会根据 `return` 推断（当然前提是你赋值/传入的目标委托签名已经确定了返回类型）。

匿名方法常见出现位置是“回调/事件处理”：比如订阅一个事件时，直接写一段处理逻辑；或把一个小逻辑作为参数传给方法（例如过滤、转换、完成回调）。它和“命名方法 + 委托变量”本质上做的是同一件事：都在给委托提供可执行的目标，只是匿名方法更适合短小的一次性逻辑。

#### Lambda 表达式

Lambda 是匿名函数的更简洁写法，形式是 `(parameters) => expression` 或 `(parameters) => { statements; }`。它的意义可以理解为“把匿名方法写得更短、更适合阅读”，因此在 LINQ、集合操作、事件订阅中非常常见。Lambda 可以自动推断参数类型（在上下文足够明确时），也能捕获外部变量（闭包），这让它非常适合写小的过滤条件、映射规则或回调逻辑。实际工程中，大多数匿名函数都会优先用 Lambda 写，匿名方法（`delegate{}`）更多见于旧代码或需要刻意表达“这里是匿名委托块”的场景。

#### 

下面用一个 `NumberChanger` 委托贯穿：先用匿名方法绑定、再切换到命名方法、最后用 Lambda 绑定。记住它们只是“提供委托目标”的不同写法，本质一致。

```csharp
using System;

delegate void NumberChanger(int n);

class Demo
{
    static int num = 10;

    // 命名方法（可复用、可测试）
    static void AddNum(int p)
    {
        num += p;
        Console.WriteLine($"Named(Add): {num}");
    }

    static void MultNum(int q)
    {
        num *= q;
        Console.WriteLine($"Named(Mult): {num}");
    }

    static void Main()
    {
        // 1) 匿名方法：delegate(...) { ... }
        NumberChanger nc = delegate (int x)
        {
            Console.WriteLine($"Anonymous Method: {x}");
        };
        nc(10);

        // 2) 命名方法：直接绑定已有方法
        nc = AddNum;
        nc(5);

        nc = MultNum;
        nc(2);

        // 3) Lambda：更简洁的匿名函数
        nc = x => Console.WriteLine($"Lambda: {x}");
        nc(99);

        Console.ReadKey();
    }
}
```

### C# 不安全代码

`unsafe` 用来开启 C# 的“指针模式”：允许在代码里直接操作内存地址（指针）、解引用（`*p`）、取地址（`&x`）等。这类代码也常被称为“不安全/非托管风格”的代码，因为它绕过了 C# 的部分安全检查与运行时保护（比如类型安全、边界检查），出错时更容易造成崩溃或不可预期行为。工程上 `unsafe` 的典型用途很集中：性能极限优化（少一次边界检查/拷贝）、与 C/C++ 互操作（P/Invoke、原生库）、处理需要固定内存布局的数据结构等；一般业务代码不建议依赖它。使用 `unsafe` 需要两个条件：第一是在代码层面用 `unsafe` 标记方法或代码块；第二是在项目/编译器层面允许 unsafe（例如编译参数 `/unsafe` 或 VS 勾选 “Allow unsafe code”）。

指针变量保存的是“某个变量在内存中的地址”。声明形式是 `type* name;`，例如 `int* p` 表示“指向 int 的指针”，`int** pp` 表示“指向 int 指针的指针”。要强调的一点是：在同一条声明里 `*` 跟的是基础类型而不是变量名，所以习惯写 `int* p1, p2;` 时，只有 `p1` 是指针，`p2` 是 int；如果想两个都是指针，需要分别写 `int* p1; int* p2;`（更清晰，也更不容易踩坑）。

常见语法含义（够用级别）：

- `&x`：取变量 `x` 的地址  
- `*p`：解引用，访问指针 `p` 指向的值  
- `p->Member`：等价于 `(*p).Member`，用于指针指向结构体/对象布局时访问成员  
- `(nint)p` / `(IntPtr)p`：把指针转成可打印/可传递的整型指针表示（注意：直接转 `int` 在 64 位环境可能截断）

托管数组在 GC（垃圾回收）运行时可能被移动位置（压缩内存时会搬家），所以“数组首地址”在运行期间不一定恒定。如果你要拿到数组的指针并在一段代码里安全地使用它，就需要 `fixed` 把该对象“钉住”在当前位置，保证这段期间地址不变。`fixed` 的作用范围是它的代码块，离开块后对象可以再次被 GC 移动，因此指针不能“带出 fixed 块长期保存”。

```csharp
using System;

class UnsafeDemo
{
    static unsafe void Main()
    {
        // 1) 取地址 & 解引用
        int a = 10;
        int* pa = &a;
        Console.WriteLine($"a={a}");
        Console.WriteLine($"*pa={*pa}");
        Console.WriteLine($"addr(pa)={(nint)pa}"); // 用 nint/IntPtr 更稳妥（兼容 32/64 位）

        // 2) 指针作为参数：交换两个 int
        int b = 20;
        Swap(&a, &b);
        Console.WriteLine($"after swap: a={a}, b={b}");

        // 3) fixed：固定数组地址，用指针遍历
        int[] arr = { 10, 100, 200 };
        fixed (int* pArr = arr)
        {
            for (int i = 0; i < arr.Length; i++)
            {
                Console.WriteLine($"arr[{i}]={*(pArr + i)}, addr={(nint)(pArr + i)}");
            }
        }
    }

    static unsafe void Swap(int* x, int* y)
    {
        int tmp = *x;
        *x = *y;
        *y = tmp;
    }
}
```

命令行编译：`csc /unsafe prog1.cs`  
Visual Studio：项目属性 -> Build -> 勾选 “Allow unsafe code”

