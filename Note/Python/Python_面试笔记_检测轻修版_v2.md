
# Python

**前言**：这份笔记围绕 **Python 语言与相关生态技术**书写，目标是记录并复习Python语言本身特点和使用技巧，对于更系统的算法与数据结构和架构设计体系并不在本笔记描述内容。

**后文结构**：

第 1 章 基础语法与通用编程能力

本章旨在建立 Python 编程的基本表达能力与调试习惯，内容覆盖解释器与运行方式、编码与文本处理、内置类型与容器、控制流与函数、异常与 IO、以及最基本的日志与排错手段。阶段性要求为能够独立完成若干脚本/小模块，并能用清晰的函数边界组织逻辑，遇到问题能定位到原因。

第 2 章 面向对象与类型建模

本章聚焦 Python 里 OOP 的真实落地：类与实例、属性与方法、继承与 MRO、抽象与协议式设计、以及建模工具（property/dataclass/slots）背后的取舍。阶段性要求为能够读写中型工程里常见的类设计，并能把“为什么这样设计”讲清楚，而不是只会写语法。

第 3 章 Python 语言特性与惯用写法

本章整理 Python 面试高频的“机制题”：数据模型与魔术方法、迭代器与生成器、装饰器与闭包、上下文管理器、模块与导入机制、并发模型（线程/进程/asyncio）以及类型标注与序列化边界。阶段性要求为能够解释机制、写出惯用写法，并能说清楚代价与边界。

第 4 章 工程化能力与项目交付链路

本章补齐从写代码到交付项目的最小闭环：项目结构、依赖与构建、测试与质量、运行保障（日志/异常边界/性能/鲁棒性）、以及工程里并发与 IO 的常见落地方式。阶段性要求为能够独立搭建一个结构清晰、可测试、可运行、可发布的小项目，并能在面试里讲清楚工程取舍。

## 基础

### 运行与环境
#### 解释器与运行方式
Python 的 3.0 版本，常被称为 Python 3000，或简称 Py3k。相对于 Python 的早期版本，这是一个较大的升级。为了不带入过多的历史包袱，Python 3.0 在设计时没有考虑向下兼容。

Python 解释器不止一种，有 CPython、IPython、Jython、PyPy 等。顾名思义，CPython 就是用 C 语言开发的了，是官方标准实现，拥有良好的生态，所以应用也就最为广泛了。而 IPython 是在 CPython 的基础之上在交互式方面得到增强的解释器（http://ipython.org/）。Jython 是专为 Java 平台设计的 Python 解释器（http://www.jython.org/），它把 Python 代码编译成 Java 字节码执行。PyPy 是 Python 语言（2.7.13和3.5.3）的一种快速、兼容的替代实现（http://pypy.org/），以速度快著称。

Python 首先是一门“运行时语言”。可以把解释器理解成一个持续运行的进程，它负责读取源代码、编译为字节码并执行；脚本运行、模块运行、交互式运行三者的差别，主要体现在入口文件的确定方式、`__name__` 的取值，以及导入路径的初始化方式。

下面把常见运行方式放在一张表里，作为项目启动时的默认选择指南。

| 方式 | 命令形态 | `__name__` | 更适合的场景 |
| --- | --- | --- | --- |
| 交互式 | `python` | 交互环境 | 快速验证语义 |
| 脚本 | `python path/to/file.py` | 入口文件为 `__main__` | 临时脚本、一次性工具 |
| 模块 | `python -m pkg.module` | 入口模块为 `__main__` | 工程化入口、部署 |

在 Python 中，`__name__` 和 `__main__` 是两个与模块和脚本执行相关的特殊概念。它们通常用于控制代码的执行方式，尤其是在模块既可以作为独立脚本运行，也可以被其他模块导入时。当模块作为主程序运行时，`__name__` 的值会被设置为 `"__main__"`；当模块被导入时，`__name__` 的值会被设置为模块名（通常为文件名，不包括 `.py` 扩展名）。`__main__` 是一个特殊的字符串，用于表示当前模块是作为主程序运行的。它通常与 `__name__` 一起使用，以判断模块是被导入还是作为独立脚本运行。

```python
def greet():
    print("来自 example 模块的问候！")

if __name__ == "__main__":
    print("该脚本正在直接运行。")
    greet()
else:
    print("该脚本作为模块被导入。")
```

#### 数据与表达式
#### 变量

Python 中的变量不需要声明。每个变量在使用前都必须赋值，变量赋值以后该变量才会被创建。在 Python 中，变量就是变量，它没有类型，我们所说的"类型"是变量所指的内存中对象的类型。Python 的“变量”更准确叫名称。名称需要符合标识符规范：

- 第一个字符必须以字母（a-z, A-Z）或下划线 **_** 。
- 标识符的其他的部分由字母、数字和下划线组成。
- 标识符对大小写敏感，count 和 Count 是不同的标识符。
- 标识符对长度无硬性限制，但建议保持简洁（一般不超过 20 个字符）。
- 禁止使用保留关键字，如 if、for、class 等不能作为标识符。

名称和对象之间是绑定关系，赋值只是把名字重新指向另一个对象，并不会把对象复制一份。理解名称绑定，最关键的就是把对象身份与对象值区分开。对象身份可以理解为这块对象在内存里的那份实体，`id(x)` 只是观察用的标识；对象值是你关心的内容，例如字典里有哪些键、列表里有哪些元素。使用`is` 比较两个对象的身份，而`==` 比较的是值。工程里 `is` 的主场通常只有一个：判断是否为 None，以及少量单例对象。真值测试也是类型感的一部分。Python 在 `if x:` 里并不是只接受布尔值，而是把对象转换为布尔语义，这个转换通常依赖 `__bool__` 或 `__len__`。`None`、空字符串、空列表、空字典会被当成 False，但 `0` 也会被当成 False。如果用 `if amount:` 判断金额是否传入，就会把金额为 0 的合法情况误判成没传。更稳的写法是对“缺省”和“合法值为 0”做清晰区分，通常用 `is None` 判断缺省。另外短路求值，`and`、`or` 会按从左到右求值，并返回最后参与计算的那个操作数，而不是一定返回 True/False，这个特性在工程里常用于给默认值，但也会被滥用导致可读性下降。另一个是可变默认参数坑，它和名称绑定是同一类问题：默认值在定义时求值并共享，如果默认值是可变对象，就会在多次调用之间共享状态。

下面这张表把一组“表达式与绑定”问题放在一起。

| 场景 | 推荐写法 | 不推荐写法 | 为什么 |
| --- | --- | --- | --- |
| 判断缺省 | `x is None` | `if not x` | 0、""、[] 都会被当成 False，容易误判 |
| 比较值 | `a == b` | `a is b` | is 比身份，受驻留与构造影响 |
| 给默认值 | `x if x is not None else d` | `x or d` | `or` 会把 0 当成缺省 |
| 判断空容器 | `if not items` | `if len(items) == 0` | 语义更直接 |
| 复制容器 | `new = old.copy()` | `new = old` | 赋值只是别名绑定 |

示例把 `is/==`、真值测试、短路返回值都跑出来。

```python
# ordersys/binding_demo.py
order = {"id": 1001, "amount_cents": 0, "items": ["apple"]}

alias = order
alias["items"].append("banana")
print(order["items"])

print(order["id"] == 1001)
print(order["id"] is 1001)

amount = order.get("amount_cents")
print(amount is None)
print(bool(amount))

x = 0
print(x or 10)                 # 10
print(x if x is not None else 10)  # 0

```
#### 基础数据

##### 数字 Number

Python 数字数据类型用于存储数值。数据类型是不允许改变的，这就意味着如果改变数字数据类型的值，将重新分配内存空间。您也可以使用del语句删除一些数字对象的引用。

```
var1,var2 = 1,10 # 定义数字变量
del var1[,var2[,var3[....,varN]]] # 删除数字变量
```

Python 支持三种不同的数值类型：

- **整型(int)** - 通常被称为是整型或整数，是正或负整数，不带小数点。Python3 整型是没有限制大小的，可以当作 Long 类型使用，所以 Python3 没有 Python2 的 Long 类型。布尔(bool)是整型的子类型。
- **浮点型(float)** - 浮点型由整数部分与小数部分组成，浮点型也可以使用科学计数法表示（2.5e2 = 2.5 x 102 = 250）
- **复数( (complex))** - 复数由实数部分和虚数部分构成，可以用a + bj,或者complex(a,b)表示， 复数的实部a和虚部b都是浮点型。

以下是一些常用的数学函数：

| 函数                                                         | 返回值 ( 描述 )                                              |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [abs(x)](https://www.runoob.com/python3/python3-func-number-abs.html) | 返回数字的绝对值，如abs(-10) 返回 10                         |
| [ceil(x)](https://www.runoob.com/python3/python3-func-number-ceil.html) | 返回数字的上入整数，如math.ceil(4.1) 返回 5                  |
| cmp(x, y)                                                    | 如果 x < y 返回 -1, 如果 x == y 返回 0, 如果 x > y 返回 1。 **Python 3 已废弃，使用 (x>y)-(x<y) 替换**。 |
| [exp(x)](https://www.runoob.com/python3/python3-func-number-exp.html) | 返回e的x次幂(ex),如math.exp(1) 返回2.718281828459045         |
| [fabs(x)](https://www.runoob.com/python3/python3-func-number-fabs.html) | 以浮点数形式返回数字的绝对值，如math.fabs(-10) 返回10.0      |
| [floor(x)](https://www.runoob.com/python3/python3-func-number-floor.html) | 返回数字的下舍整数，如math.floor(4.9)返回 4                  |
| [log(x)](https://www.runoob.com/python3/python3-func-number-log.html) | 如math.log(math.e)返回1.0,math.log(100,10)返回2.0            |
| [log10(x)](https://www.runoob.com/python3/python3-func-number-log10.html) | 返回以10为基数的x的对数，如math.log10(100)返回 2.0           |
| [max(x1, x2,...)](https://www.runoob.com/python3/python3-func-number-max.html) | 返回给定参数的最大值，参数可以为序列。                       |
| [min(x1, x2,...)](https://www.runoob.com/python3/python3-func-number-min.html) | 返回给定参数的最小值，参数可以为序列。                       |
| [modf(x)](https://www.runoob.com/python3/python3-func-number-modf.html) | 返回x的整数部分与小数部分，两部分的数值符号与x相同，整数部分以浮点型表示。 |
| [pow(x, y)](https://www.runoob.com/python3/python3-func-number-pow.html) | x**y 运算后的值。                                            |
| [round(x [,n\])](https://www.runoob.com/python3/python3-func-number-round.html) | 返回浮点数 x 的四舍五入值，如给出 n 值，则代表舍入到小数点后的位数。**其实准确的说是保留值将保留到离上一位更近的一端。** |
| [sqrt(x)](https://www.runoob.com/python3/python3-func-number-sqrt.html) | 返回数字x的平方根。                                          |

| 函数                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [choice(seq)](https://www.runoob.com/python3/python3-func-number-choice.html) | 从序列的元素中随机挑选一个元素，比如random.choice(range(10))，从0到9中随机挑选一个整数。 |
| [randrange ([start,\] stop [,step])](https://www.runoob.com/python3/python3-func-number-randrange.html) | 从指定范围内，按指定基数递增的集合中获取一个随机数，基数默认值为 1 |
| [random()](https://www.runoob.com/python3/python3-func-number-random.html) | 随机生成下一个实数，它在[0,1)范围内。                        |
| [seed([x\])](https://www.runoob.com/python3/python3-func-number-seed.html) | 改变随机数生成器的种子seed。如果你不了解其原理，你不必特别去设定seed，Python会帮你选择seed。 |
| [shuffle(lst)](https://www.runoob.com/python3/python3-func-number-shuffle.html) | 将序列的所有元素随机排序                                     |
| [uniform(x, y)](https://www.runoob.com/python3/python3-func-number-uniform.html) | 随机生成下一个实数，它在[x,y]范围内。                        |

| 函数                                                         | 描述                                              |
| :----------------------------------------------------------- | :------------------------------------------------ |
| [acos(x)](https://www.runoob.com/python3/python3-func-number-acos.html) | 返回x的反余弦弧度值。                             |
| [asin(x)](https://www.runoob.com/python3/python3-func-number-asin.html) | 返回x的反正弦弧度值。                             |
| [atan(x)](https://www.runoob.com/python3/python3-func-number-atan.html) | 返回x的反正切弧度值。                             |
| [atan2(y, x)](https://www.runoob.com/python3/python3-func-number-atan2.html) | 返回给定的 X 及 Y 坐标值的反正切值。              |
| [cos(x)](https://www.runoob.com/python3/python3-func-number-cos.html) | 返回x的弧度的余弦值。                             |
| [hypot(x, y)](https://www.runoob.com/python3/python3-func-number-hypot.html) | 返回欧几里德范数 sqrt(x*x + y*y)。                |
| [sin(x)](https://www.runoob.com/python3/python3-func-number-sin.html) | 返回的x弧度的正弦值。                             |
| [tan(x)](https://www.runoob.com/python3/python3-func-number-tan.html) | 返回x弧度的正切值。                               |
| [degrees(x)](https://www.runoob.com/python3/python3-func-number-degrees.html) | 将弧度转换为角度,如degrees(math.pi/2) ， 返回90.0 |
| [radians(x)](https://www.runoob.com/python3/python3-func-number-radians.html) | 将角度转换为弧度                                  |

| 常量 | 描述                                  |
| :--- | :------------------------------------ |
| pi   | 数学常量 pi（圆周率，一般以π来表示）  |
| e    | 数学常量 e，e即自然常数（自然常数）。 |

##### 字符串 String

字符串是 Python 中最常用的数据类型。我们可以使用引号( **'** 或 **"** )来创建字符串。创建字符串很简单，只要为变量分配一个值即可。Python 不支持单字符类型，单字符在 Python 中也是作为一个字符串使用。字符串的截取的语法格式如下：

```
str = 'TestString'  # 定义字符串变量

str[0:-1]	# 打印字符串第一个到倒数第二个字符（不包含倒数第一个字符）
str[0]		# 打印字符串的第一个字符
str[2:5]	# 打印字符串第三到第五个字符（不包含索引为 5 的字符）
str[2:]		# 打印字符串从第三个字符开始到末尾

str * 2		# 打印字符串两次
str + "TEST"# 打印字符串和"TEST"拼接在一起
```

下表实例变量 a 值为字符串 "Hello"，b 变量值为 "Python"：

| 操作符 | 描述                                                         | 实例                            |
| :----- | :----------------------------------------------------------- | :------------------------------ |
| +      | 字符串连接                                                   | a + b 输出结果： HelloPython    |
| *      | 重复输出字符串                                               | a*2 输出结果：HelloHello        |
| []     | 通过索引获取字符串中字符                                     | a[1] 输出结果 **e**             |
| [ : ]  | 截取字符串中的一部分，遵循**左闭右开**原则，str[0:2] 是不包含第 3 个字符的。 | a[1:4] 输出结果 **ell**         |
| in     | 成员运算符 - 如果字符串中包含给定的字符返回 True             | **'H' in a** 输出结果 True      |
| not in | 成员运算符 - 如果字符串中不包含给定的字符返回 True           | **'M' not in a** 输出结果 True  |
| r/R    | 原始字符串 - 原始字符串：所有的字符串都是直接按照字面的意思来使用，没有转义特殊或不能打印的字符。 原始字符串除在字符串的第一个引号前加上字母 **r**（可以大小写）以外，与普通字符串有着几乎完全相同的语法。 | `print( r'\n' ) print( R'\n' )` |
| %      | 格式字符串                                                   | 请看下一节内容。                |

以下是一些常用的内建函数：

| 序号 | 方法及描述                                                   |
| :--- | :----------------------------------------------------------- |
| 1    | [capitalize()](https://www.runoob.com/python3/python3-string-capitalize.html) 将字符串的第一个字符转换为大写 |
| 2    | [center(width, fillchar)](https://www.runoob.com/python3/python3-string-center.html)返回一个指定的宽度 width 居中的字符串，fillchar 为填充的字符，默认为空格。 |
| 3    | [count(str, beg= 0,end=len(string))](https://www.runoob.com/python3/python3-string-count.html) 返回 str 在 string 里面出现的次数，如果 beg 或者 end 指定则返回指定范围内 str 出现的次数 |
| 4    | [bytes.decode(encoding="utf-8", errors="strict")](https://www.runoob.com/python3/python3-string-decode.html) Python3 中没有 decode 方法，但我们可以使用 bytes 对象的 decode() 方法来解码给定的 bytes 对象，这个 bytes 对象可以由 str.encode() 来编码返回。 |
| 5    | [encode(encoding='UTF-8',errors='strict')](https://www.runoob.com/python3/python3-string-encode.html) 以 encoding 指定的编码格式编码字符串，如果出错默认报一个ValueError 的异常，除非 errors 指定的是'ignore'或者'replace' |
| 6    | [endswith(suffix, beg=0, end=len(string))](https://www.runoob.com/python3/python3-string-endswith.html) 检查字符串是否以 suffix 结束，如果 beg 或者 end 指定则检查指定的范围内是否以 suffix 结束，如果是，返回 True,否则返回 False。 |
| 7    | [expandtabs(tabsize=8)](https://www.runoob.com/python3/python3-string-expandtabs.html) 把字符串 string 中的 tab 符号转为空格，tab 符号默认的空格数是 8 。 |
| 8    | [find(str, beg=0, end=len(string))](https://www.runoob.com/python3/python3-string-find.html) 检测 str 是否包含在字符串中，如果指定范围 beg 和 end ，则检查是否包含在指定范围内，如果包含返回开始的索引值，否则返回-1 |
| 9    | [index(str, beg=0, end=len(string))](https://www.runoob.com/python3/python3-string-index.html) 跟find()方法一样，只不过如果str不在字符串中会报一个异常。 |
| 10   | [isalnum()](https://www.runoob.com/python3/python3-string-isalnum.html) 检查字符串是否由字母和数字组成，即字符串中的所有字符都是字母或数字。如果字符串至少有一个字符，并且所有字符都是字母或数字，则返回 True；否则返回 False。 |
| 11   | [isalpha()](https://www.runoob.com/python3/python3-string-isalpha.html) 如果字符串至少有一个字符并且所有字符都是字母或中文字则返回 True, 否则返回 False |
| 12   | [isdigit()](https://www.runoob.com/python3/python3-string-isdigit.html) 如果字符串只包含数字则返回 True 否则返回 False.. |
| 13   | [islower()](https://www.runoob.com/python3/python3-string-islower.html) 如果字符串中包含至少一个区分大小写的字符，并且所有这些(区分大小写的)字符都是小写，则返回 True，否则返回 False |
| 14   | [isnumeric()](https://www.runoob.com/python3/python3-string-isnumeric.html) 如果字符串中只包含数字字符，则返回 True，否则返回 False |
| 15   | [isspace()](https://www.runoob.com/python3/python3-string-isspace.html) 如果字符串中只包含空白，则返回 True，否则返回 False. |
| 16   | [istitle()](https://www.runoob.com/python3/python3-string-istitle.html) 如果字符串是标题化的(见 title())则返回 True，否则返回 False |
| 17   | [isupper()](https://www.runoob.com/python3/python3-string-isupper.html) 如果字符串中包含至少一个区分大小写的字符，并且所有这些(区分大小写的)字符都是大写，则返回 True，否则返回 False |
| 18   | [join(seq)](https://www.runoob.com/python3/python3-string-join.html) 以指定字符串作为分隔符，将 seq 中所有的元素(的字符串表示)合并为一个新的字符串 |
| 19   | [len(string)](https://www.runoob.com/python3/python3-string-len.html) 返回字符串长度 |
| 20   | [ljust(width[, fillchar\])](https://www.runoob.com/python3/python3-string-ljust.html) 返回一个原字符串左对齐,并使用 fillchar 填充至长度 width 的新字符串，fillchar 默认为空格。 |
| 21   | [lower()](https://www.runoob.com/python3/python3-string-lower.html) 转换字符串中所有大写字符为小写. |
| 22   | [lstrip()](https://www.runoob.com/python3/python3-string-lstrip.html) 截掉字符串左边的空格或指定字符。 |
| 23   | [maketrans()](https://www.runoob.com/python3/python3-string-maketrans.html) 创建字符映射的转换表，对于接受两个参数的最简单的调用方式，第一个参数是字符串，表示需要转换的字符，第二个参数也是字符串表示转换的目标。 |
| 24   | [max(str)](https://www.runoob.com/python3/python3-string-max.html) 返回字符串 str 中最大的字母。 |
| 25   | [min(str)](https://www.runoob.com/python3/python3-string-min.html) 返回字符串 str 中最小的字母。 |
| 26   | [replace(old, new [, max\])](https://www.runoob.com/python3/python3-string-replace.html) 把 将字符串中的 old 替换成 new,如果 max 指定，则替换不超过 max 次。 |
| 27   | [rfind(str, beg=0,end=len(string))](https://www.runoob.com/python3/python3-string-rfind.html) 类似于 find()函数，不过是从右边开始查找. |
| 28   | [rindex( str, beg=0, end=len(string))](https://www.runoob.com/python3/python3-string-rindex.html) 类似于 index()，不过是从右边开始. |
| 29   | [rjust(width,[, fillchar\])](https://www.runoob.com/python3/python3-string-rjust.html) 返回一个原字符串右对齐,并使用fillchar(默认空格）填充至长度 width 的新字符串 |
| 30   | [rstrip()](https://www.runoob.com/python3/python3-string-rstrip.html) 删除字符串末尾的空格或指定字符。 |
| 31   | [split(str="", num=string.count(str))](https://www.runoob.com/python3/python3-string-split.html) 以 str 为分隔符截取字符串，如果 num 有指定值，则仅截取 num+1 个子字符串 |
| 32   | [splitlines([keepends\])](https://www.runoob.com/python3/python3-string-splitlines.html) 按照行('\r', '\r\n', \n')分隔，返回一个包含各行作为元素的列表，如果参数 keepends 为 False，不包含换行符，如果为 True，则保留换行符。 |
| 33   | [startswith(substr, beg=0,end=len(string))](https://www.runoob.com/python3/python3-string-startswith.html) 检查字符串是否是以指定子字符串 substr 开头，是则返回 True，否则返回 False。如果beg 和 end 指定值，则在指定范围内检查。 |
| 34   | [strip([chars\])](https://www.runoob.com/python3/python3-string-strip.html) 在字符串上执行 lstrip()和 rstrip() |
| 35   | [swapcase()](https://www.runoob.com/python3/python3-string-swapcase.html) 将字符串中大写转换为小写，小写转换为大写 |
| 36   | [title()](https://www.runoob.com/python3/python3-string-title.html) 返回"标题化"的字符串,就是说所有单词都是以大写开始，其余字母均为小写(见 istitle()) |
| 37   | [translate(table, deletechars="")](https://www.runoob.com/python3/python3-string-translate.html) 根据 table 给出的表(包含 256 个字符)转换 string 的字符, 要过滤掉的字符放到 deletechars 参数中 |
| 38   | [upper()](https://www.runoob.com/python3/python3-string-upper.html) 转换字符串中的小写字母为大写 |
| 39   | [zfill (width)](https://www.runoob.com/python3/python3-string-zfill.html) 返回长度为 width 的字符串，原字符串右对齐，前面填充0 |
| 40   | [isdecimal()](https://www.runoob.com/python3/python3-string-isdecimal.html) 检查字符串是否只包含十进制字符，如果是返回 true，否则返回 false。 |

###### 格式化与转义字符 

Python 支持格式化字符串的输出 。尽管这样可能会用到非常复杂的表达式，但最基本的用法是将一个值插入到一个有字符串格式符 %s 的字符串中。在 Python 中，字符串格式化使用与 C 中 sprintf 函数一样的语法。

| 符  号 | 描述                                 |
| :----- | :----------------------------------- |
| %c     | 格式化字符及其ASCII码                |
| %s     | 格式化字符串                         |
| %d     | 格式化整数                           |
| %u     | 格式化无符号整型                     |
| %o     | 格式化无符号八进制数                 |
| %x     | 格式化无符号十六进制数               |
| %X     | 格式化无符号十六进制数（大写）       |
| %f     | 格式化浮点数字，可指定小数点后的精度 |
| %e     | 用科学计数法格式化浮点数             |
| %E     | 作用同%e，用科学计数法格式化浮点数   |
| %g     | %f和%e的简写                         |
| %G     | %f 和 %E 的简写                      |
| %p     | 用十六进制数格式化变量的地址         |

格式化操作符辅助指令:

| 符号  | 功能                                                         |
| :---- | :----------------------------------------------------------- |
| *     | 定义宽度或者小数点精度                                       |
| -     | 用做左对齐                                                   |
| +     | 在正数前面显示加号( + )                                      |
| <sp>  | 在正数前面显示空格                                           |
| #     | 在八进制数前面显示零('0')，在十六进制前面显示'0x'或者'0X'(取决于用的是'x'还是'X') |
| 0     | 显示的数字前面填充'0'而不是默认的空格                        |
| %     | '%%'输出一个单一的'%'                                        |
| (var) | 映射变量(字典参数)                                           |
| m.n.  | m 是显示的最小总宽度,n 是小数点后的位数(如果可用的话)        |

**f-string**：f-string 是 python3.6 之后版本添加的，称之为字面量格式化字符串，是新的格式化字符串的语法。**f-string** 格式化字符串以 **f** 开头，后面跟着字符串，字符串中的表达式用大括号 {} 包起来，它会将变量或表达式计算后的值替换进去，用了这种方式明显更简单了，不用再去判断使用 %s，还是 %d。

```
name = 'Runoob'
'Hello %s' % name
'Hello Runoob'

name = 'Runoob'
f'Hello {name}' # 替换变量
'Hello Runoob'
f'{1+2}'     # 使用表达式
'3'

w = {'name': 'Runoob', 'url': 'www.runoob.com'}
f'{w["name"]}: {w["url"]}'
'Runoob: www.runoob.com'
```

在需要在字符中使用特殊字符时，python 用反斜杠 **\** 转义字符。如下表：

| 转义字符    | 描述                                                         | 实例                                                         |
| :---------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| \(在行尾时) | 续行符                                                       | `>>> print("line1 \ ... line2 \ ... line3") line1 line2 line3 >>> ` |
| \\          | 反斜杠符号                                                   | `>>> print("\\") \`                                          |
| \'          | 单引号                                                       | `>>> print('\'') '`                                          |
| \"          | 双引号                                                       | `>>> print("\"") "`                                          |
| \a          | 响铃                                                         | `>>> print("\a")`执行后电脑有响声。                          |
| \b          | 退格(Backspace)                                              | `>>> print("Hello \b World!") Hello World!`                  |
| \000        | 空                                                           | `>>> print("\000") >>> `                                     |
| \n          | 换行                                                         | `>>> print("\n")  >>>`                                       |
| \v          | 纵向制表符                                                   | `>>> print("Hello \v World!") Hello        World! >>>`       |
| \t          | 横向制表符                                                   | `>>> print("Hello \t World!") Hello    World! >>>`           |
| \r          | 回车，将 **\r** 后面的内容移到字符串开头，并逐一替换开头部分的字符，直至将 **\r** 后面的内容完全替换完成。 | `>>> print("Hello\rWorld!") World! >>> print('google runoob taobao\r123456') 123456 runoob taobao` |
| \f          | 换页                                                         | `>>> print("Hello \f World!") Hello        World! >>> `      |
| \yyy        | 八进制数，y 代表 0~7 的字符，例如：\012 代表换行。           | `>>> print("\110\145\154\154\157\40\127\157\162\154\144\41") Hello World!` |
| \xyy        | 十六进制数，以 \x 开头，y 代表的字符，例如：\x0a 代表换行    | `>>> print("\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x72\x6c\x64\x21") Hello World!` |
| \other      | 其它的字符以普通格式输出                                     |                                                              |

##### 布尔 Bool

布尔类型即 True 或 False。在 Python 中，True 和 False 都是关键字，表示布尔值。布尔类型可以用来控制程序的流程，比如判断某个条件是否成立，或者在某个条件满足时执行某段代码。

布尔类型只有两个值：True 和 False。布尔类型可以和其他数据类型进行比较，布尔类型也可以被转换成其他数据类型，比如数字、字符串等。这时，Python 会将 True 视为 1，False 视为 0。布尔类型也可以和逻辑运算符一起使用，包括 and、or 和 not。这些运算符可以用来组合多个布尔表达式，生成一个新的布尔值。可以使用 `bool()` 函数将其他类型的值转换为布尔值。以下值在转换为布尔值时为 `False`：`None`、`False`、零 (`0`、`0.0`、`0j`)、空序列（如 `''`、`()`、`[]`）和空映射（如 `{}`）。其他所有值转换为布尔值时均为 `True`。

**注意:** 在 Python 中，所有非零的数字和非空的字符串、列表、元组等数据类型都被视为 True，只有 **0、空字符串、空列表、空元组**等被视为 False。因此，在进行布尔类型转换时，需要注意数据类型的真假性。

##### 列表 List

序列是 Python 中最基本的数据结构。序列中的每个值都有对应的位置值，称之为索引，第一个索引是 0，第二个索引是 1，依此类推。Python 有 6 个序列的内置类型，但最常见的是列表和元组。列表都可以进行的操作包括索引，切片，加，乘，检查成员。此外，Python 已经内置确定序列的长度以及确定最大和最小的元素的方法。列表是最常用的 Python 数据类型，它可以作为一个方括号内的逗号分隔值出现。列表的数据项不需要具有相同的类型。创建一个列表，只要把逗号分隔的不同的数据项使用方括号括起来即可。与字符串的索引一样，列表索引从 **0** 开始，第二个索引是 **1**，依此类推。通过索引列表可以进行截取、组合等操作。可以使用 append() 方法来添加列表项，使用 del 语句来删除列表中的元素，\+ 号用于组合列表，* 号用于重复列表。

```
list = ['Google', 'Runoob', "Zhihu", "Taobao", "Wiki"] # 定义列表

list[1]	# 取第二个元素 Runoob 
list[1:-2] # 从第二位开始（包含）截取到倒数第二位（不包含） ['Runoob', 'Zhihu']

list1 = ['Google', 'Runoob', 'Taobao']
list1.append('Baidu') # 追加数据
del list1[0]	# 删除数据

list2 = list + list1 # +追加
list2 = list * 2 # *重复

```

以下是一些常用函数与方法。

Python包含以下函数:

| 序号 | 函数                                                         |
| :--- | :----------------------------------------------------------- |
| 1    | [len(list)](https://www.runoob.com/python3/python3-att-list-len.html) 列表元素个数 |
| 2    | [max(list)](https://www.runoob.com/python3/python3-att-list-max.html) 返回列表元素最大值 |
| 3    | [min(list)](https://www.runoob.com/python3/python3-att-list-min.html) 返回列表元素最小值 |
| 4    | [list(seq)](https://www.runoob.com/python3/python3-att-list-list.html) 将元组转换为列表 |

Python包含以下方法:

| 序号 | 方法                                                         |
| :--- | :----------------------------------------------------------- |
| 1    | [list.append(obj)](https://www.runoob.com/python3/python3-att-list-append.html) 在列表末尾添加新的对象 |
| 2    | [list.count(obj)](https://www.runoob.com/python3/python3-att-list-count.html) 统计某个元素在列表中出现的次数 |
| 3    | [list.extend(seq)](https://www.runoob.com/python3/python3-att-list-extend.html) 在列表末尾一次性追加另一个序列中的多个值（用新列表扩展原来的列表） |
| 4    | [list.index(obj)](https://www.runoob.com/python3/python3-att-list-index.html) 从列表中找出某个值第一个匹配项的索引位置 |
| 5    | [list.insert(index, obj)](https://www.runoob.com/python3/python3-att-list-insert.html) 将对象插入列表 |
| 6    | [list.pop([index=-1\])](https://www.runoob.com/python3/python3-att-list-pop.html) 移除列表中的一个元素（默认最后一个元素），并且返回该元素的值 |
| 7    | [list.remove(obj)](https://www.runoob.com/python3/python3-att-list-remove.html) 移除列表中某个值的第一个匹配项 |
| 8    | [list.reverse()](https://www.runoob.com/python3/python3-att-list-reverse.html) 反向列表中元素 |
| 9    | [list.sort( key=None, reverse=False)](https://www.runoob.com/python3/python3-att-list-sort.html) 对原列表进行排序 |
| 10   | [list.clear()](https://www.runoob.com/python3/python3-att-list-clear.html) 清空列表 |
| 11   | [list.copy()](https://www.runoob.com/python3/python3-att-list-copy.html) 复制列表 |

##### 元组 Tuple

Python 的元组与列表类似，不同之处在于元组的元素不能修改。元组使用小括号 **( )**，列表使用方括号 **[ ]**。元组创建很简单，只需要在括号中添加元素，并使用逗号隔开即可。元组中只包含一个元素时，需要在元素后面添加逗号 **,** ，否则括号会被当作运算符使用。元组与字符串类似，下标索引从 0 开始，可以进行截取，组合等。元组中的元素值是不允许修改的，但我们可以对元组进行连接组合。元组中的元素值是不允许删除的，但我们可以使用del语句来删除整个元组。与字符串一样，元组之间可以使用 **+**、**+=**和 ***** 号进行运算。这就意味着他们可以组合和复制，运算后会生成一个新的元组。因为元组也是一个序列，所以我们可以访问元组中的指定位置的元素，也可以截取索引中的一段元素。

```
tuple = ( 'abcd', 786 , 2.23, 'runoob', 70.2  ) # 定义一个元组
tuple2 = ('1')
tup1 = ()    # 空元组
tup2 = (20,) # 一个元素，需要在元素后添加逗号

tuple             	# 输出完整元组
tuple[0]          	# 输出元组的第一个元素
tuple[1:3]        	# 输出从第二个元素开始到第三个元素
tuple[2:]        	# 输出从第三个元素开始的所有元素
tuple2 * 2     		# 输出两次元组
tuple2 + tinytuple 	# 连接元组

tup1 = ()    # 空元组
tup2 = (20,) # 一个元素，需要在元素后添加逗号

del tup # 删除元组


```

Python元组包含了以下内置函数

| 序号 | 方法及描述                               | 实例                                                         |
| :--- | :--------------------------------------- | :----------------------------------------------------------- |
| 1    | len(tuple) 计算元组元素个数。            | `>>> tuple1 = ('Google', 'Runoob', 'Taobao') >>> len(tuple1) 3 >>> ` |
| 2    | max(tuple) 返回元组中元素最大值。        | `>>> tuple2 = ('5', '4', '8') >>> max(tuple2) '8' >>> `      |
| 3    | min(tuple) 返回元组中元素最小值。        | `>>> tuple2 = ('5', '4', '8') >>> min(tuple2) '4' >>> `      |
| 4    | tuple(iterable) 将可迭代系列转换为元组。 | `>>> list1= ['Google', 'Taobao', 'Runoob', 'Baidu'] >>> tuple1=tuple(list1) >>> tuple1 ('Google', 'Taobao', 'Runoob', 'Baidu')` |

##### 集合 Set

集合（set）是一个无序的不重复元素序列。集合中的元素不会重复，并且可以进行交集、并集、差集等常见的集合操作。可以使用大括号 **{ }** 创建集合，元素之间用逗号 **,** 分隔， 或者也可以使用 **set()** 函数创建集合。**注意：**创建一个空集合必须用 **set()** 而不是 **{ }**，因为 **{ }** 是用来创建一个空字典。添加元素可以用add方法也可以用update方法。移除元素用remove方法或者discard方法。也可以使用pop方法随机删除集合中的一个元素。使用clear我们可以直接清空一个集合。

```
thisset = set(("Google", "Runoob", "Taobao"))
thisset.add("Facebook")
thisset.update({1,3})
thisset.update([1,4],[5,6])  
thisset.remove("Taobao")
thisset.discard("Facebook")  # 不存在不会发生错误
x = thisset.pop()
thisset.clear()
```

| 方法                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [add()](https://www.runoob.com/python3/ref-set-add.html)     | 为集合添加元素                                               |
| [clear()](https://www.runoob.com/python3/ref-set-clear.html) | 移除集合中的所有元素                                         |
| [copy()](https://www.runoob.com/python3/ref-set-copy.html)   | 拷贝一个集合                                                 |
| [difference()](https://www.runoob.com/python3/ref-set-difference.html) | 返回多个集合的差集                                           |
| [difference_update()](https://www.runoob.com/python3/ref-set-difference_update.html) | 移除集合中的元素，该元素在指定的集合也存在。                 |
| [discard()](https://www.runoob.com/python3/ref-set-discard.html) | 删除集合中指定的元素                                         |
| [intersection()](https://www.runoob.com/python3/ref-set-intersection.html) | 返回集合的交集                                               |
| [intersection_update()](https://www.runoob.com/python3/ref-set-intersection_update.html) | 返回集合的交集。                                             |
| [isdisjoint()](https://www.runoob.com/python3/ref-set-isdisjoint.html) | 判断两个集合是否包含相同的元素，如果没有返回 True，否则返回 False。 |
| [issubset()](https://www.runoob.com/python3/ref-set-issubset.html) | 判断指定集合是否为该方法参数集合的子集。                     |
| [issuperset()](https://www.runoob.com/python3/ref-set-issuperset.html) | 判断该方法的参数集合是否为指定集合的子集                     |
| [pop()](https://www.runoob.com/python3/ref-set-pop.html)     | 随机移除元素                                                 |
| [remove()](https://www.runoob.com/python3/ref-set-remove.html) | 移除指定元素                                                 |
| [symmetric_difference()](https://www.runoob.com/python3/ref-set-symmetric_difference.html) | 返回两个集合中不重复的元素集合。                             |
| [symmetric_difference_update()](https://www.runoob.com/python3/ref-set-symmetric_difference_update.html) | 移除当前集合中在另外一个指定集合相同的元素，并将另外一个指定集合中不同的元素插入到当前集合中。 |
| [union()](https://www.runoob.com/python3/ref-set-union.html) | 返回两个集合的并集                                           |
| [update()](https://www.runoob.com/python3/ref-set-update.html) | 给集合添加元素                                               |
| [len()](https://www.runoob.com/python3/python3-string-len.html) | 计算集合元素个数                                             |

##### 字典 Dictionary

字典是另一种可变容器模型，且可存储任意类型对象。字典的每个键值 **key=>value** 对用冒号 **:** 分割，每个对之间用逗号(**,**)分割，整个字典包括在花括号 **{}** 中。**注意：****dict** 作为 Python 的关键字和内置函数，变量名不建议命名为 **dict**。键必须是唯一的，但值则不必。值可以取任何数据类型，但键必须是不可变的，如字符串，数字。

构造函数 dict() 可以直接从键值对序列中构建字典，也可以使用大括号 **{ }** 创建字典。另外，字典类型也有一些内置的函数，例如 clear()、keys()、values() 等。在同一个字典中，键(key)必须是唯一的。向字典添加新内容的方法是增加新的键/值对，修改或删除已有键/值对。能删单一的元素也能清空字典，清空只需一项操作。显式删除一个字典用del命令。

```
tinydict = {'Name': 'Runoob', 'Age': 7, 'Class': 'First'}
 
print ("tinydict['Name']: ", tinydict['Name'])
print ("tinydict['Age']: ", tinydict['Age'])
tinydict['Age'] = 8               # 更新 Age
tinydict['School'] = "菜鸟教程"  # 添加信息
del tinydict['Name'] # 删除键 'Name'
tinydict.clear()     # 清空字典
del tinydict         # 删除字典

```

Python字典包含了以下内置函数：

| 序号 | 函数及描述                                                   | 实例                                                         |
| :--- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 1    | len(dict) 计算字典元素个数，即键的总数。                     | `>>> tinydict = {'Name': 'Runoob', 'Age': 7, 'Class': 'First'} >>> len(tinydict) 3` |
| 2    | str(dict) 输出字典，可以打印的字符串表示。                   | `>>> tinydict = {'Name': 'Runoob', 'Age': 7, 'Class': 'First'} >>> str(tinydict) "{'Name': 'Runoob', 'Class': 'First', 'Age': 7}"` |
| 3    | type(variable) 返回输入的变量类型，如果变量是字典就返回字典类型。 | `>>> tinydict = {'Name': 'Runoob', 'Age': 7, 'Class': 'First'} >>> type(tinydict) <class 'dict'>` |

Python字典包含了以下内置方法：

| 序号 | 函数及描述                                                   |
| :--- | :----------------------------------------------------------- |
| 1    | [dict.clear()](https://www.runoob.com/python3/python3-att-dictionary-clear.html) 删除字典内所有元素 |
| 2    | [dict.copy()](https://www.runoob.com/python3/python3-att-dictionary-copy.html) 返回一个字典的浅复制 |
| 3    | [dict.fromkeys()](https://www.runoob.com/python3/python3-att-dictionary-fromkeys.html) 创建一个新字典，以序列seq中元素做字典的键，val为字典所有键对应的初始值 |
| 4    | [dict.get(key, default=None)](https://www.runoob.com/python3/python3-att-dictionary-get.html) 返回指定键的值，如果键不在字典中返回 default 设置的默认值 |
| 5    | [key in dict](https://www.runoob.com/python3/python3-att-dictionary-in.html) 如果键在字典dict里返回true，否则返回false |
| 6    | [dict.items()](https://www.runoob.com/python3/python3-att-dictionary-items.html) 以列表返回一个视图对象 |
| 7    | [dict.keys()](https://www.runoob.com/python3/python3-att-dictionary-keys.html) 返回一个视图对象 |
| 8    | [dict.setdefault(key, default=None)](https://www.runoob.com/python3/python3-att-dictionary-setdefault.html) 和get()类似, 但如果键不存在于字典中，将会添加键并将值设为default |
| 9    | [dict.update(dict2)](https://www.runoob.com/python3/python3-att-dictionary-update.html) 把字典dict2的键/值对更新到dict里 |
| 10   | [dict.values()](https://www.runoob.com/python3/python3-att-dictionary-values.html) 返回一个视图对象 |
| 11   | [dict.pop(key[,default\])](https://www.runoob.com/python3/python3-att-dictionary-pop.html) 删除字典 key（键）所对应的值，返回被删除的值。 |
| 12   | [dict.popitem()](https://www.runoob.com/python3/python3-att-dictionary-popitem.html) 返回并删除字典中的最后一对键和值。 |

##### 字节 Bytes

在 Python3 中，bytes 类型表示的是不可变的二进制序列（byte sequence）。与字符串类型不同的是，bytes 类型中的元素是整数值（0 到 255 之间的整数），而不是 Unicode 字符。bytes 类型通常用于处理二进制数据，比如图像文件、音频文件、视频文件等等。在网络编程中，也经常使用 bytes 类型来传输二进制数据。创建 bytes 对象的方式有多种，最常见的方式是使用 b 前缀：此外，也可以使用 bytes() 函数将其他类型的对象转换为 bytes 类型。与字符串类型类似，bytes 类型也支持许多操作和方法，如切片、拼接、查找、替换等等。同时，由于 bytes 类型是不可变的，因此在进行修改操作时需要创建一个新的 bytes 对象。bytes() 函数的第一个参数是要转换的对象，第二个参数是编码方式，如果省略第二个参数，则默认使用 UTF-8 编码：

```
x = bytes("hello", encoding="utf-8"
```

#### 数据类型转换

有时候，我们需要对数据内置的类型进行转换，数据类型的转换，一般情况下你只需要将数据类型作为函数名即可。Python 数据类型转换可以分为两种：隐式类型转换 - 自动完成，显式类型转换 - 需要使用类型函数来转换。

##### 隐式类型转换

在隐式类型转换中，Python 会自动将一种数据类型转换为另一种数据类型，不需要我们去干预。以下实例中，我们对两种不同类型的数据进行运算，较低数据类型（整数）就会转换为较高数据类型（浮点数）以避免数据丢失。

```
num_int = 123
num_flo = 1.23

num_new = num_int + num_flo

print("num_int 数据类型为:",type(num_int))
print("num_flo 数据类型为:",type(num_flo))

print("num_new 值为:",num_new)
print("num_new 数据类型为:",type(num_new))

num_int 数据类型为: <class 'int'>
num_flo 数据类型为: <class 'float'>
num_new: 值为: 124.23
num_new 数据类型为: <class 'float'>
```

##### 显式类型转换

在显式类型转换中，用户将对象的数据类型转换为所需的数据类型。 我们使用 int()、float()、str() 等预定义函数来执行显式类型转换。

```
num_int = 123
num_str = "456"

print("num_int 数据类型为:",type(num_int))
print("类型转换前，num_str 数据类型为:",type(num_str))

num_str = int(num_str)    # 强制转换为整型
print("类型转换后，num_str 数据类型为:",type(num_str))

num_sum = num_int + num_str

print("num_int 与 num_str 相加结果为:",num_sum)
print("sum 数据类型为:",type(num_sum))
```

##### 常用转换函数

| 函数                                                         | 描述                                                |
| :----------------------------------------------------------- | :-------------------------------------------------- |
| [int(x [,base\])](https://www.runoob.com/python3/python-func-int.html) | 将x转换为一个整数                                   |
| [float(x)](https://www.runoob.com/python3/python-func-float.html) | 将x转换到一个浮点数                                 |
| [complex(real [,imag\])](https://www.runoob.com/python3/python-func-complex.html) | 创建一个复数                                        |
| [str(x)](https://www.runoob.com/python3/python-func-str.html) | 将对象 x 转换为字符串                               |
| [repr(x)](https://www.runoob.com/python3/python-func-repr.html) | 将对象 x 转换为表达式字符串                         |
| [eval(str)](https://www.runoob.com/python3/python-func-eval.html) | 用来计算在字符串中的有效Python表达式,并返回一个对象 |
| [tuple(s)](https://www.runoob.com/python3/python3-func-tuple.html) | 将序列 s 转换为一个元组                             |
| [list(s)](https://www.runoob.com/python3/python3-att-list-list.html) | 将序列 s 转换为一个列表                             |
| [set(s)](https://www.runoob.com/python3/python-func-set.html) | 转换为可变集合                                      |
| [dict(d)](https://www.runoob.com/python3/python-func-dict.html) | 创建一个字典。d 必须是一个 (key, value)元组序列。   |
| [frozenset(s)](https://www.runoob.com/python3/python-func-frozenset.html) | 转换为不可变集合                                    |
| [chr(x)](https://www.runoob.com/python3/python-func-chr.html) | 将一个整数转换为一个字符                            |
| [ord(x)](https://www.runoob.com/python3/python-func-ord.html) | 将一个字符转换为它的整数值                          |
| [hex(x)](https://www.runoob.com/python3/python-func-hex.html) | 将一个整数转换为一个十六进制字符串                  |
| [oct(x)](https://www.runoob.com/python3/python-func-oct.html) | 将一个整数转换为一个八进制字符串                    |

#### 运算符

##### 算术运算符

以下假设变量 **a=10**，变量 **b=21**：

| 运算符 | 描述                                            | 实例                   |
| :----- | :---------------------------------------------- | :--------------------- |
| +      | 加 - 两个对象相加                               | a + b 输出结果 31      |
| -      | 减 - 得到负数或是一个数减去另一个数             | a - b 输出结果 -11     |
| *      | 乘 - 两个数相乘或是返回一个被重复若干次的字符串 | a * b 输出结果 210     |
| /      | 除 - x 除以 y                                   | b / a 输出结果 2.1     |
| %      | 取模 - 返回除法的余数                           | b % a 输出结果 1       |
| **     | 幂 - 返回x的y次幂                               | a**b 为10的21次方      |
| //     | 取整除 - 往小的方向取整数                       | 9//2 = 4   -9//2 = -5` |

##### 比较运算符

以下假设变量 a 为 10，变量 b 为20：

| 运算符 | 描述                                                         | 实例                  |
| :----- | :----------------------------------------------------------- | :-------------------- |
| ==     | 等于 - 比较对象是否相等                                      | (a == b) 返回 False。 |
| !=     | 不等于 - 比较两个对象是否不相等                              | (a != b) 返回 True。  |
| >      | 大于 - 返回x是否大于y                                        | (a > b) 返回 False。  |
| <      | 小于 - 返回x是否小于y。所有比较运算符返回1表示真，返回0表示假。这分别与特殊的变量True和False等价。注意，这些变量名的大写。 | (a < b) 返回 True。   |
| >=     | 大于等于 - 返回x是否大于等于y。                              | (a >= b) 返回 False。 |
| <=     | 小于等于 - 返回x是否小于等于y。                              | (a <= b) 返回 True。  |

##### 赋值运算符

以下假设变量a为10，变量b为20：

| 运算符 | 描述                                                         | 实例                                                         |
| :----- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| =      | 简单的赋值运算符                                             | c = a + b 将 a + b 的运算结果赋值为 c                        |
| +=     | 加法赋值运算符                                               | c += a 等效于 c = c + a                                      |
| -=     | 减法赋值运算符                                               | c -= a 等效于 c = c - a                                      |
| *=     | 乘法赋值运算符                                               | c *= a 等效于 c = c * a                                      |
| /=     | 除法赋值运算符                                               | c /= a 等效于 c = c / a                                      |
| %=     | 取模赋值运算符                                               | c %= a 等效于 c = c % a                                      |
| **=    | 幂赋值运算符                                                 | c **= a 等效于 c = c ** a                                    |
| //=    | 取整除赋值运算符                                             | c //= a 等效于 c = c // a                                    |
| :=     | 海象运算符，这个运算符的主要目的是在表达式中同时进行赋值和返回赋值的值。**Python3.8 版本新增运算符**。 | 在这个示例中，赋值表达式可以避免调用 len() 两次:`if (n := len(a)) > 10:    print(f"List is too long ({n} elements, expected <= 10)")` |

##### 位运算符

按位运算符是把数字看作二进制来进行计算的。下表中变量 a 为 60，b 为 13二进制格式如下：

| 运算符 | 描述                                                         | 实例                                                         |
| :----- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| &      | 按位与运算符：参与运算的两个值,如果两个相应位都为1,则该位的结果为1,否则为0 | (a & b) 输出结果 12 ，二进制解释： 0000 1100                 |
| \|     | 按位或运算符：只要对应的二个二进位有一个为1时，结果位就为1。 | (a \| b) 输出结果 61 ，二进制解释： 0011 1101                |
| ^      | 按位异或运算符：当两对应的二进位相异时，结果为1              | (a ^ b) 输出结果 49 ，二进制解释： 0011 0001                 |
| ~      | 按位取反运算符：对数据的每个二进制位取反,即把1变为0,把0变为1。**~x** 类似于 **-x-1** | (~a ) 输出结果 -61 ，二进制解释： 1100 0011， 在一个有符号二进制数的补码形式。 |
| <<     | 左移动运算符：运算数的各二进位全部左移若干位，由"<<"右边的数指定移动的位数，高位丢弃，低位补0。 | a << 2 输出结果 240 ，二进制解释： 1111 0000                 |
| >>     | 右移动运算符：把">>"左边的运算数的各二进位全部右移若干位，">>"右边的数指定移动的位数 | a >> 2 输出结果 15 ，二进制解释： 0000 1111                  |

##### 逻辑运算符

以下假设变量 a 为 10, b为 20:

| 运算符 | 逻辑表达式 | 描述                                                         | 实例                    |
| :----- | :--------- | :----------------------------------------------------------- | :---------------------- |
| and    | x and y    | 布尔"与" - 如果 x 为 False，x and y 返回 x 的值，否则返回 y 的计算值。 | (a and b) 返回 20。     |
| or     | x or y     | 布尔"或" - 如果 x 是 True，它返回 x 的值，否则它返回 y 的计算值。 | (a or b) 返回 10。      |
| not    | not x      | 布尔"非" - 如果 x 为 True，返回 False 。如果 x 为 False，它返回 True。 | not(a and b) 返回 False |

##### 成员运算符

测试实例中包含了一系列的成员，包括字符串，列表或元组。

| 运算符 | 描述                                                    | 实例                                              |
| :----- | :------------------------------------------------------ | :------------------------------------------------ |
| in     | 如果在指定的序列中找到值返回 True，否则返回 False。     | x 在 y 序列中 , 如果 x 在 y 序列中返回 True。     |
| not in | 如果在指定的序列中没有找到值返回 True，否则返回 False。 | x 不在 y 序列中 , 如果 x 不在 y 序列中返回 True。 |

##### 身份运算符

身份运算符用于比较两个对象的存储单元

| 运算符 | 描述                                        | 实例                                                         |
| :----- | :------------------------------------------ | :----------------------------------------------------------- |
| is     | is 是判断两个标识符是不是引用自一个对象     | **x is y**, 类似 **id(x) == id(y)** , 如果引用的是同一个对象则返回 True，否则返回 False |
| is not | is not 是判断两个标识符是不是引用自不同对象 | **x is not y** ， 类似 **id(x) != id(y)**。如果引用的不是同一个对象则返回结果 True，否则返回 False。 |

**注：** [id()](https://www.runoob.com/python/python-func-id.html) 函数用于获取对象内存地址。

##### 运算符优先级

以下表格列出了从最高到最低优先级的所有运算符， 相同单元格内的运算符具有相同优先级。 运算符均指二元运算，除非特别指出。 相同单元格内的运算符从左至右分组（除了幂运算是从右至左分组）：

| 运算符                                                       | 描述                               |
| :----------------------------------------------------------- | :--------------------------------- |
| `(expressions...)`,`[expressions...]`, `{key: value...}`, `{expressions...}` | 圆括号的表达式                     |
| `x[index]`, `x[index:index]`, `x(arguments...)`, `x.attribute` | 读取，切片，调用，属性引用         |
| await x                                                      | await 表达式                       |
| `**`                                                         | 乘方(指数)                         |
| `+x`, `-x`, `~x`                                             | 正，负，按位非 NOT                 |
| `*`, `@`, `/`, `//`, `%`                                     | 乘，矩阵乘，除，整除，取余         |
| `+`, `-`                                                     | 加和减                             |
| `<<`, `>>`                                                   | 移位                               |
| `&`                                                          | 按位与 AND                         |
| `^`                                                          | 按位异或 XOR                       |
| `|`                                                          | 按位或 OR                          |
| `in,not in, is,is not, <, <=, >, >=, !=, ==`                 | 比较运算，包括成员检测和标识号检测 |
| `not x`                                                      | 逻辑非 NOT                         |
| `and`                                                        | 逻辑与 AND                         |
| `or`                                                         | 逻辑或 OR                          |
| `if -- else`                                                 | 条件表达式                         |
| `lambda`                                                     | lambda 表达式                      |
| `:=`                                                         | 赋值表达式                         |

#### 数值与精度

float 不能直接用于金额，以及工程上怎么把风险压下去。`float` 的核心问题是它用二进制表示小数，很多十进制小数无法被精确表示，于是会产生误差，这个误差一旦进入累计、折扣、税费、分摊，最后会变成对账差异。`int` 在 Python 里是任意精度整数，不会像某些语言那样溢出回绕，代价是大整数计算会更慢一些。订单号、用户 id、金额分通常都落在 `int` 上，这让你不用担心溢出，但你仍然要注意系统边界，例如数据库字段类型的上限、JSON 数字在某些语言端的精度上限、以及前端展示的格式化规则。工程里对外接口如果可能出现超大整数，最好是把它当字符串传输，避免跨语言精度坑。

处理金额最常见的方案是用最小货币单位的整数表示，例如分，配合明确的舍入与单位转换策略。确实需要十进制精确规则计算时用 `decimal.Decimal`，但输入必须来自字符串或整数，不能来自 float。除此之外还经常会用万分比或基点表示比例，避免 float 漂移。看到 `discount_bp`、`rate_bp` 这类命名，通常就是以万分比表达比例。

下面的表展示数值策略按存储、计算、展示的链路。

| 场景 | 推荐类型 | 推荐原因 | 注意 |
| --- | --- | --- | --- |
| 金额存储 | `int`（分） | 精确、快、便于索引 | 展示时忘记换算 |
| 比例 | `int`（万分比） | 避免漂移 | 用 float 累计误差 |
| 规则计算 | `int` 或 `Decimal` | 取决于规则复杂度 | Decimal 从 float 构造 |
| 时间戳/计数 | `int` | 不溢出 | 对外精度边界 |
| 近似值 | `float` | 性能好 | 不能用于对账字段 |


### 控制流与函数

#### 分支与循环
##### 条件控制

Python 条件语句是通过一条或多条语句的执行结果（True 或者 False）来决定执行的代码块。

**if 语句**：每个条件后面要使用冒号 **:**，表示接下来是满足条件后要执行的语句块。使用缩进来划分语句块，相同缩进数的语句在一起组成一个语句块。

```
if condition_1:
    statement_block_1
elif condition_2:
    statement_block_2
else:
    statement_block_3
```

**match...case...语句**：Python 3.10 增加了 **match...case** 的条件判断，不需要再使用一连串的 **if-else** 来判断了。match 后的对象会依次与 case 后的内容进行匹配，如果匹配成功，则执行匹配到的表达式，否则直接跳过，**_** 可以匹配一切。`match`语句后跟一个表达式，然后使用`case`语句来定义不同的模式。`case`后跟一个模式，可以是具体值、变量、通配符等。可以使用`if`关键字在`case`中添加条件。`_`通常用作通配符，匹配任何值。

```
match subject:
    case <pattern_1>:
        <action_1>
    case <pattern_2>:
        <action_2>
    case <pattern_3>:
        <action_3>
    case _:
        <action_wildcard>
```

##### 循环

Python 中的循环语句有 for 和 while。

**for语句**：Python for 循环可以遍历任何可迭代对象。当循环执行完毕（即遍历完 iterable 中的所有元素）后，会执行 else 子句中的代码，如果在循环过程中遇到了 break 语句，则会中断循环，此时不会执行 else 子句。

```
for iter in iterable:
    # 循环主体
else:
    # 循环结束后执行的代码
```

**while语句**：expr 条件语句为 true 则执行 statement(s) 语句块，如果为 false，则执行additional_statement(s)。

```
while <expr>:
    <statement(s)>
else:
    <additional_statement(s)>
```

**注意**：for循环遍历的是一个可迭代体，这通常要求该迭代体提供next与iter方法。如果你需要遍历数字序列，可以使用内置 range() 函数。它会生成可迭代数列。

**break** 语句可以跳出 for 和 while 的循环体。如果你从 for 或 while 循环中终止，任何对应的循环 else 块将不执行。

**continue** 语句被用来告诉 Python 跳过当前循环块中的剩余语句，然后继续进行下一轮循环。

#### 函数与参数规则

##### 函数定义

函数是组织好的，可重复使用的，用来实现单一，或相关联功能的代码段。函数能提高应用的模块性，和代码的重复利用率。你可以定义一个由自己想要功能的函数，以下是简单的规则：

- 函数代码块以 **def** 关键词开头，后接函数标识符名称和圆括号 **()**。
- 任何传入参数和自变量必须放在圆括号中间，圆括号之间可以用于定义参数。
- 函数的第一行语句可以选择性地使用文档字符串—用于存放函数说明。
- 函数内容以冒号 **:** 起始，并且缩进。
- **return [表达式]** 结束函数，选择性地返回一个值给调用方，不带表达式的 return 相当于返回 None。

```
#!/usr/bin/python3

def hello() :
    print("Hello World!")

hello()
```

##### 函数调用

定义一个函数：给了函数一个名称，指定了函数里包含的参数，和代码块结构。这个函数的基本结构完成以后，你可以通过另一个函数调用执行，也可以直接从 Python 命令提示符执行。

```
# 定义函数
def printme( str ):
   # 打印任何传入的字符串
   print (str)
   return
 
# 调用函数
printme("我要调用用户自定义函数!")
printme("再次调用同一函数")
```

##### 函数参数

必需参数须以正确的顺序传入函数。调用时的数量必须和声明时的一样。

关键字参数和函数调用关系紧密，函数调用使用关键字参数来确定传入的参数值。使用关键字参数允许函数调用时参数的顺序与声明时不一致，因为 Python 解释器能够用参数名匹配参数值。

调用函数时，如果没有传递参数，则会使用默认参数。以下实例中如果没有传入 age 参数，则使用默认值。

你可能需要一个函数能处理比当初声明时更多的参数。这些参数叫做不定长参数，和上述 2 种参数不同，声明时不会命名。

Python3.8 新增了一个函数形参语法 / 用来指明函数形参必须使用指定位置参数，不能使用关键字参数的形式。

### 异常与 IO
#### 异常体系
异常是 Python 里最重要的错误表达机制之一。Python 有两种错误很容易辨认：语法错误和异常。Python assert（断言）用于判断一个表达式，在表达式条件为 false 的时候触发异常。

Python 的语法错误或者称之为解析错，也就是编写的代码不符合语法规范而导致错误。运行期检测到的错误被称为异常。大多数的异常都不会被程序处理，都以错误信息的形式展现在这里。但是用户可以手动处理异常。

##### 异常捕获

异常捕捉可以使用 **try/except/else/finally** 语句。

![img](https://www.runoob.com/wp-content/uploads/2019/07/try_except_else_finally.png)

```
try:
    runoob()
except AssertionError as error:
    print(error)
else:
    try:
        with open('file.log') as file:
            read_data = file.read()
    except FileNotFoundError as fnf_error:
        print(fnf_error)
finally:
    print('这句话，无论异常是否发生都会执行。')
```

##### 异常抛出

Python 使用 raise 语句抛出一个指定的异常。raise 唯一的一个参数指定了要被抛出的异常。它必须是一个异常的实例或者是异常的类（也就是 Exception 的子类）。

```
raise [Exception [, args [, traceback]]]
```

##### 自定义异常

你可以通过创建一个新的异常类来拥有自己的异常。异常类继承自 Exception 类，可以直接继承，或者间接继承:

```
>>> class MyError(Exception):
        def __init__(self, value):
            self.value = value
        def __str__(self):
            return repr(self.value)
   
>>> try:
        raise MyError(2*2)
    except MyError as e:
        print('My exception occurred, value:', e.value)
   
My exception occurred, value: 4
>>> raise MyError('oops!')
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
__main__.MyError: 'oops!'
```

在这个例子中，类 Exception 默认的 __init__() 被覆盖。当创建一个模块有可能抛出多种不同的异常时，一种通常的做法是为这个包建立一个基础异常类，然后基于这个基础类为不同的错误情况创建不同的子类

##### 断言

Python assert（断言）用于判断一个表达式，在表达式条件为 false 的时候触发异常。断言可以在条件不满足程序运行的情况下直接返回错误，而不必等待程序运行后出现崩溃的情况。

```
assert expression [, arguments]
# 等价于
if not expression:
    raise AssertionError(arguments)
```



#### 文件与IO

##### 文件

文件的工程底线是显式编码、with 保证关闭、按行/按块流式处理避免大文件爆内存。Python **open()** 方法用于打开一个文件，并返回文件对象。在对文件进行处理过程都需要使用到这个函数，如果该文件无法被打开，会抛出 **OSError**。**注意：**使用 **open()** 方法一定要保证关闭文件对象，即调用 **close()** 方法。

**open()** 函数常用形式是接收两个参数：文件名(file)和模式(mode)。完整的语法格式为：

```
open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None)
```

参数说明：file: 必需，文件路径（相对或者绝对路径）；mode: 可选，文件打开模式；buffering: 设置缓冲；encoding: 一般使用utf8；errors: 报错级别；newline: 区分换行符；closefd: 传入的file参数类型；opener: 设置自定义开启器，开启器的返回值必须是一个打开的文件描述符。

mode 参数有：

| 模式 | 描述                                                         |
| :--- | :----------------------------------------------------------- |
| t    | 文本模式 (默认)。                                            |
| x    | 写模式，新建一个文件，如果该文件已存在则会报错。             |
| b    | 二进制模式。                                                 |
| +    | 打开一个文件进行更新(可读可写)。                             |
| U    | 通用换行模式（**Python 3 不支持**）。                        |
| r    | 以只读方式打开文件。文件的指针将会放在文件的开头。这是默认模式。 |
| rb   | 以二进制格式打开一个文件用于只读。文件指针将会放在文件的开头。这是默认模式。一般用于非文本文件如图片等。 |
| r+   | 打开一个文件用于读写。文件指针将会放在文件的开头。           |
| rb+  | 以二进制格式打开一个文件用于读写。文件指针将会放在文件的开头。一般用于非文本文件如图片等。 |
| w    | 打开一个文件只用于写入。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
| wb   | 以二进制格式打开一个文件只用于写入。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。一般用于非文本文件如图片等。 |
| w+   | 打开一个文件用于读写。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
| wb+  | 以二进制格式打开一个文件用于读写。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。一般用于非文本文件如图片等。 |
| a    | 打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。也就是说，新的内容将会被写入到已有内容之后。如果该文件不存在，创建新文件进行写入。 |
| ab   | 以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。也就是说，新的内容将会被写入到已有内容之后。如果该文件不存在，创建新文件进行写入。 |
| a+   | 打开一个文件用于读写。如果该文件已存在，文件指针将会放在文件的结尾。文件打开时会是追加模式。如果该文件不存在，创建新文件用于读写。 |
| ab+  | 以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。如果该文件不存在，创建新文件用于读写。 |

默认为文本模式，如果要以二进制模式打开，加上 **b** 。file 对象使用 open 函数来创建，下表列出了 file 对象常用的函数：

| 序号 | 方法及描述                                                   |
| :--- | :----------------------------------------------------------- |
| 1    | [file.close()](https://www.runoob.com/python3/python3-file-close.html)关闭文件。关闭后文件不能再进行读写操作。 |
| 2    | [file.flush()](https://www.runoob.com/python3/python3-file-flush.html)刷新文件内部缓冲，直接把内部缓冲区的数据立刻写入文件, 而不是被动的等待输出缓冲区写入。 |
| 3    | [file.fileno()](https://www.runoob.com/python3/python3-file-fileno.html)返回一个整型的文件描述符(file descriptor FD 整型), 可以用在如os模块的read方法等一些底层操作上。 |
| 4    | [file.isatty()](https://www.runoob.com/python3/python3-file-isatty.html)如果文件连接到一个终端设备返回 True，否则返回 False。 |
| 5    | [file.next()](https://www.runoob.com/python3/python3-file-next.html)**Python 3 中的 File 对象不支持 next() 方法。**返回文件下一行。 |
| 6    | [file.read([size\])](https://www.runoob.com/python3/python3-file-read.html)从文件读取指定的字节数，如果未给定或为负则读取所有。 |
| 7    | [file.readline([size\])](https://www.runoob.com/python3/python3-file-readline.html)读取整行，包括 "\n" 字符。 |
| 8    | [file.readlines([sizeint\])](https://www.runoob.com/python3/python3-file-readlines.html)读取所有行并返回列表，若给定sizeint>0，返回总和大约为sizeint字节的行, 实际读取值可能比 sizeint 较大, 因为需要填充缓冲区。 |
| 9    | [file.seek(offset[, whence\])](https://www.runoob.com/python3/python3-file-seek.html)移动文件读取指针到指定位置 |
| 10   | [file.tell()](https://www.runoob.com/python3/python3-file-tell.html)返回文件当前位置。 |
| 11   | [file.truncate([size\])](https://www.runoob.com/python3/python3-file-truncate.html)从文件的首行首字符开始截断，截断文件为 size 个字符，无 size 表示从当前位置截断；截断之后后面的所有字符被删除，其中 windows 系统下的换行代表2个字符大小。 |
| 12   | [file.write(str)](https://www.runoob.com/python3/python3-file-write.html)将字符串写入文件，返回的是写入的字符长度。 |
| 13   | [file.writelines(sequence)](https://www.runoob.com/python3/python3-file-writelines.html)向文件写入一个序列字符串列表，如果需要换行则要自己加入每行的换行符。 |

##### IO

Python 提供了 [input() 内置函数](https://www.runoob.com/python3/python3-func-input.html)从标准输入读入一行文本，默认的标准输入是键盘。

python的pickle模块实现了基本的数据序列和反序列化。

通过pickle模块的序列化操作我们能够将程序中运行的对象信息保存到文件中去，永久存储。

通过pickle模块的反序列化操作，我们能够从文件中创建上一次程序保存的对象。

基本接口：

```
pickle.dump(obj, file, [,protocol])
```

有了 pickle 这个对象, 就能对 file 以读取的形式打开:

```
x = pickle.load(file)
```

**注解：**从 file 中读取一个字符串，并将它重构为原来的python对象。

### 算法与数据结构

#### 栈

在 Python 中，可以使用列表（list）来实现栈的功能。栈是一种后进先出（LIFO, Last-In-First-Out）数据结构，意味着最后添加的元素最先被移除。列表提供了一些方法，使其非常适合用于栈操作，特别是 **append()** 和 **pop()** 方法。用 append() 方法可以把一个元素添加到栈顶，用不指定索引的 pop() 方法可以把一个元素从栈顶释放出来。

```
class Stack:
    def __init__(self):
        self.stack = []

    def push(self, item):
        self.stack.append(item)

    def pop(self):
        if not self.is_empty():
            return self.stack.pop()
        else:
            raise IndexError("pop from empty stack")

    def peek(self):
        if not self.is_empty():
            return self.stack[-1]
        else:
            raise IndexError("peek from empty stack")

    def is_empty(self):
        return len(self.stack) == 0

    def size(self):
        return len(self.stack)

# 使用示例
stack = Stack()
stack.push(1)
stack.push(2)
stack.push(3)

print("栈顶元素:", stack.peek())  # 输出: 栈顶元素: 3
print("栈大小:", stack.size())    # 输出: 栈大小: 3

print("弹出元素:", stack.pop())  # 输出: 弹出元素: 3
print("栈是否为空:", stack.is_empty())  # 输出: 栈是否为空: False
print("栈大小:", stack.size())    # 输出: 栈大小: 2
```

#### 队列

collections.deque 是 Python 标准库的一部分，非常适合用于实现队列。队列是一种先进先出（FIFO, First-In-First-Out）的数据结构，意味着最早添加的元素最先被移除。使用列表时，如果频繁地在列表的开头插入或删除元素，性能会受到影响，因为这些操作的时间复杂度是 O(n)。

```
from collections import deque

# 创建一个空队列
queue = deque()

# 向队尾添加元素
queue.append('a')
queue.append('b')
queue.append('c')

print("队列状态:", queue)  # 输出: 队列状态: deque(['a', 'b', 'c'])

# 从队首移除元素
first_element = queue.popleft()
print("移除的元素:", first_element)  # 输出: 移除的元素: a
print("队列状态:", queue)            # 输出: 队列状态: deque(['b', 'c'])

# 查看队首元素（不移除）
front_element = queue[0]
print("队首元素:", front_element)    # 输出: 队首元素: b

# 检查队列是否为空
is_empty = len(queue) == 0
print("队列是否为空:", is_empty)     # 输出: 队列是否为空: False

# 获取队列大小
size = len(queue)
print("队列大小:", size)            # 输出: 队列大小: 2
```

#### 堆



### 注释

在 Python3 中，注释不会影响程序的执行，但是会使代码更易于阅读和理解。Python 中的注释有**单行注释**和**多行注释**。

**Python 中单行注释以 \**#\** 开头**。在 Python中，多行字符串（由三个单引号 **'''** 或三个双引号 **"""** 包围的文本块）在某些情况下可以被视为一种实现多行注释的技巧。**多行注释用三个单引号 \**'''\** 或者三个双引号 \**"""\** 将注释括起来**。在 Python 中，多行注释是由三个单引号 **'''** 或三个双引号 **"""** 来定义的，而且这种注释方式并不能嵌套使用。当你开始一个多行注释块时，Python 会一直将后续的行都当作注释，直到遇到另一组三个单引号或三个双引号。**嵌套多行注释会导致语法错误。**一般来说，单行注释用于普通注释；而多行注释用于文档说明，函数说明等等。

```
# 这是一个注释 print("Hello, World!")

'''
这是多行注释，用三个单引号
这是多行注释，用三个单引号 
这是多行注释，用三个单引号
'''

"""
这是多行注释（字符串），用三个双引号
这是多行注释（字符串），用三个双引号 
这是多行注释（字符串），用三个双引号
"""

print("Hello, World!")

def a():
    '''这是文档字符串'''
    pass
print(a.__doc__)
```

### 常用标准库

Python 标准库非常庞大，所提供的组件涉及范围十分广泛，使用标准库我们可以让您轻松地完成各种任务。

以下是一些 Python3 标准库中的模块：

- os 模块：os 模块提供了许多与操作系统交互的函数，例如创建、移动和删除文件和目录，以及访问环境变量等。
- sys 模块：sys 模块提供了与 Python 解释器和系统相关的功能，例如解释器的版本和路径，以及与 stdin、stdout 和 stderr 相关的信息。
- time 模块：time 模块提供了处理时间的函数，例如获取当前时间、格式化日期和时间、计时等。
- datetime 模块：datetime 模块提供了更高级的日期和时间处理函数，例如处理时区、计算时间差、计算日期差等。
- random 模块：random 模块提供了生成随机数的函数，例如生成随机整数、浮点数、序列等。
- math 模块：math 模块提供了数学函数，例如三角函数、对数函数、指数函数、常数等。
- re 模块：re 模块提供了正则表达式处理函数，可以用于文本搜索、替换、分割等。
- json 模块：json 模块提供了 JSON 编码和解码函数，可以将 Python 对象转换为 JSON 格式，并从 JSON 格式中解析出 Python 对象。
- urllib 模块：urllib 模块提供了访问网页和处理 URL 的功能，包括下载文件、发送 POST 请求、处理 cookies 等。

### 调试
调试与日志的目标是把现象变成可定位的信息。

## 面向对象

### 类的基本能力
#### 类/实例/属性/方法
Python从设计之初就已经是一门面向对象的语言，正因为如此，在Python中创建一个类和对象是很容易的。和其它编程语言相比。Python 在尽可能不增加新的语法和语义的情况下加入了类机制。Python中的类提供了面向对象编程的所有基本功能：类的继承机制允许多个基类，派生类可以覆盖基类中的任何方法，方法中可以调用基类中的同名方法。对象可以包含任意数量和类型的数据。

##### 类定义

类实例化后，可以使用其属性，实际上，创建一个类之后，可以通过类名访问其属性。

```
class ClassName:
    <statement-1>
    .
    .
    .
    <statement-N>
```

##### 类实例

类可以被实例化为一个具体的对象，对象可以使用self来指代自己，用以说明指向实例对象。

```
#!/usr/bin/python3
 
class MyClass:
 
x = MyClass()
```

##### 类属性

属性引用使用和 Python 中所有的属性引用一样的标准语法：**obj.name**。

类对象创建后，类命名空间中所有的命名都是有效属性名。

```
#!/usr/bin/python3
 
class MyClass:
    """一个简单的类实例"""
    i = 12345
    def f(self):
        return 'hello world'
 
# 实例化类
x = MyClass()
 
# 访问类的属性和方法
print("MyClass 类的属性 i 为：", x.i)
print("MyClass 类的方法 f 输出为：", x.f())
```

**__private_attrs**：两个下划线开头，声明该属性为私有，不能在类的外部被使用或直接访问。在类内部的方法中使用时 **self.__private_attrs**。

##### 类方法

在类的内部，使用 **def** 关键字来定义一个方法，与一般函数定义不同，类方法必须包含参数 self, 且为第一个参数，self 代表的是类的实例。在类的内部，使用 def 关键字来定义一个方法，与一般函数定义不同，类方法必须包含参数 **self**，且为第一个参数，**self** 代表的是类的实例。**self** 的名字并不是规定死的，也可以使用 **this**，但是最好还是按照约定使用 **self**。

```
#!/usr/bin/python3
 
#类定义
class people:
    #定义基本属性
    name = ''
    age = 0
    #定义私有属性,私有属性在类外部无法直接进行访问
    __weight = 0
    #定义构造方法
    def __init__(self,n,a,w):
        self.name = n
        self.age = a
        self.__weight = w
    def speak(self):
        print("%s 说: 我 %d 岁。" %(self.name,self.age))
 
# 实例化类
p = people('runoob',10,30)
p.speak()
```

- **__init__ :** 构造函数，在生成对象时调用
- **__del__ :** 析构函数，释放对象时使用
- **__repr__ :** 打印，转换
- **__setitem__ :** 按照索引赋值
- **__getitem__:** 按照索引获取值
- **__len__:** 获得长度
- **__cmp__:** 比较运算
- **__call__:** 函数调用
- **__add__:** 加运算
- **__sub__:** 减运算
- **__mul__:** 乘运算
- **__truediv__:** 除运算
- **__mod__:** 求余运算
- **__pow__:** 乘方

#### 继承
##### 继承
Python 同样支持类的继承，如果一种语言不支持继承，类就没有什么意义。子类（派生类 DerivedClassName）会继承父类（基类 BaseClassName）的属性和方法。除了类，还可以用表达式，基类定义在另一个模块中时这一点非常有用。Python同样有限的支持多继承形式。

```
class DerivedClassName(BaseClassName):
    <statement-1>
    .
    .
    .
    <statement-N>
    
class DerivedClassName(modname.BaseClassName):

class DerivedClassName(Base1, Base2, Base3):
    <statement-1>
    .
    .
    .
    <statement-N>
```

#### 多态

##### 多态

如果你的父类方法的功能不能满足你的需求，你可以在子类重写你父类的方法.[super() 函数](https://www.runoob.com/python/python-func-super.html)是用于调用父类(超类)的一个方法。 Python同样支持运算符重载，我们可以对类的专有方法进行重载

```
#!/usr/bin/python3
 
class Parent:        # 定义父类
   def myMethod(self):
      print ('调用父类方法')
 
class Child(Parent): # 定义子类
   def myMethod(self):
      print ('调用子类方法')
 
c = Child()          # 子类实例
c.myMethod()         # 子类调用重写方法
super(Child,c).myMethod() #用子类对象调用父类已被覆盖的方法


#!/usr/bin/python3
 
class Vector:
   def __init__(self, a, b):
      self.a = a
      self.b = b
 
   def __str__(self):
      return 'Vector (%d, %d)' % (self.a, self.b)
   
   def __add__(self,other):
      return Vector(self.a + other.a, self.b + other.b)
 
v1 = Vector(2,10)
v2 = Vector(5,-2)
print (v1 + v2)
```

#### 生命周期

如果在子类中需要父类的构造方法就需要显式地调用父类的构造方法，或者不重写父类的构造方法。

子类不重写 **__init__**，实例化子类时，会自动调用父类定义的 **__init__**。如果重写了**__init__** 时，实例化子类，就不会调用父类已经定义的 **__init__**。

python也有简单的析构函数，**`__del__` 不是可靠的资源释放机制**。它什么时候调用，未必完全由你控制。对象被垃圾回收时才可能触发。

| 方式      | 时机   | 稳定性 |
| --------- | ------ | ------ |
| __init__  | 构建时 | 推荐   |
| `__del__` | 不确定 | 不推荐 |

## 并发

### 多线程

多线程类似于同时执行多个不同程序，多线程运行有如下优点：

- 使用线程可以把占据长时间的程序中的任务放到后台去处理。
- 用户界面可以更加吸引人，比如用户点击了一个按钮去触发某些事件的处理，可以弹出一个进度条来显示处理的进度。
- 程序的运行速度可能加快。
- 在一些等待的任务实现上如用户输入、文件读写和网络收发数据等，线程就比较有用了。在这种情况下我们可以释放一些珍贵的资源如内存占用等等。

每个独立的线程有一个程序运行的入口、顺序执行序列和程序的出口。但是线程不能够独立执行，必须依存在应用程序中，由应用程序提供多个线程执行控制。

每个线程都有他自己的一组CPU寄存器，称为线程的上下文，该上下文反映了线程上次运行该线程的CPU寄存器的状态。

指令指针和堆栈指针寄存器是线程上下文中两个最重要的寄存器，线程总是在进程得到上下文中运行的，这些地址都用于标志拥有线程的进程地址空间中的内存。

- 线程可以被抢占（中断）。
- 在其他线程正在运行时，线程可以暂时搁置（也称为睡眠） -- 这就是线程的退让。

线程可以分为:

- **内核线程：**由操作系统内核创建和撤销。
- **用户线程：**不需要内核支持而在用户程序中实现的线程。

Python3 线程中常用的两个模块为：

- **_thread**
- **threading(推荐使用)**

thread 模块已被废弃。用户可以使用 threading 模块代替。所以，在 Python3 中不能再使用"thread" 模块。为了兼容性，Python3 将 thread 重命名为 "_thread"。

### 异步

### GIL 



## 语言特性

### 命名空间与作用域

作用域遵循 LEGB。作用域就是一个 Python 程序可以直接访问命名空间的正文区域。在一个 python 程序中，直接访问一个变量，会从内到外依次访问所有的作用域直到找到，否则会报未定义的错误。Python 中，程序的变量并不是在哪个位置都可以访问的，访问权限决定于这个变量是在哪里赋值的。变量的作用域决定了在哪一部分程序可以访问哪个特定的变量名称。Python 的作用域一共有 4 种，分别是：

- **L（Local）**：最内层，包含局部变量，比如一个函数/方法内部。
- **E（Enclosing）**：包含了非局部(non-local)也非全局(non-global)的变量。比如两个嵌套函数，一个函数（或类） A 里面又包含了一个函数 B ，那么对于 B 中的名称来说 A 中的作用域就为 nonlocal。
- **G（Global）**：当前脚本的最外层，比如当前模块的全局变量。
- **B（Built-in）**： 包含了内建的变量/关键字等，最后被搜索。
- 查找变量时的顺序是： **L –> E –> G –> B**。

Python 中只有模块（module），类（class）以及函数（def、lambda）才会引入新的作用域，其它的代码块（如 if/elif/else/、try/except、for/while等）是不会引入新的作用域的，也就是说这些语句内定义的变量，外部也可以访问。定义在函数内部的变量拥有一个局部作用域，定义在函数外的拥有全局作用域。局部变量只能在其被声明的函数内部访问，而全局变量可以在整个程序范围内访问。在函数内部声明的变量只在函数内部的作用域中有效，调用函数时，这些内部变量会被加入到函数内部的作用域中，并且不会影响到函数外部的同名变量。

```
total = 0 # 这是一个全局变量
# 可写函数说明
def sum( arg1, arg2 ):
    #返回2个参数的和."
    total = arg1 + arg2 # total在这里是局部变量.
    print ("函数内是局部变量 : ", total)
    return total
 
#调用sum函数
sum( 10, 20 )
print ("函数外是全局变量 : ", total)
```

当内部作用域想修改全局作用域的变量时，就要用到 global 关键字。

如果要修改嵌套作用域（enclosing 作用域，外层非全局作用域）中的变量则需要 nonlocal 关键字。

```
#!/usr/bin/python3
 
num = 1
def fun1():
    global num  # 需要使用 global 关键字声明
    print(num) 
    num = 123
    print(num)
fun1()
print(num)

1
123
123

#!/usr/bin/python3
 
def outer():
    num = 10
    def inner():
        nonlocal num   # nonlocal关键字声明
        num = 100
        print(num)
    inner()
    print(num)
outer()

100
100
```

### 包与模块

#### 模块

Python 提供了一个机制，可以将函数、类、变量和可执行代码存放在单个 `.py` 文件中，这个文件被称为模块（Module）。模块可以被脚本或交互式解释器实例导入和使用，以便将代码组织成可重用单元，方便管理和维护。每个模块都有一个内置属性 `__name__`：如果模块是直接运行的入口文件，`__name__` 的值为 `"__main__"`；如果模块被导入，`__name__` 的值为模块名（通常是文件名，不含 `.py` 后缀，或包路径形式）。内置函数 `dir()` 可以返回模块内定义的所有名称，以字符串列表形式呈现。Python 自带一些标准模块库，如下：

| 模块名        | 功能描述                                      |
| :------------ | :-------------------------------------------- |
| `math`        | 数学运算（平方根、三角函数等）                |
| `os`          | 操作系统相关功能（文件、目录操作等）          |
| `sys`         | 系统参数和函数                                |
| `random`      | 生成随机数                                    |
| `datetime`    | 处理日期和时间                                |
| `json`        | 处理 JSON 数据                                |
| `re`          | 正则表达式操作                                |
| `collections` | 提供额外数据结构（`defaultdict`、`deque` 等） |
| `itertools`   | 迭代器工具                                    |
| `functools`   | 高阶函数工具（如 `reduce`、`lru_cache`）      |

```python
# 模块示例
# module1.py
def func1():
    print("func1 in module1")

if __name__ == "__main__":
    print("module1 is running as main")
    func1()
```

#### 包

包（Package）是管理 Python 模块命名空间的一种形式，采用“点模块名称”的方式组织模块。例如模块名 `package1.module2` 表示包 `package1` 中的子模块 `module2`。包可以防止不同模块或库的全局变量冲突和模块重名问题。在导入包时，Python 会根据 `sys.path` 中的路径寻找包含 `__init__.py` 的目录。目录中必须包含 `__init__.py`（可以为空），该文件会在包被导入时执行，可以包含初始化代码，也可定义 `__all__` 列表变量，用于控制 `from package import *` 导入的内容。例如：

```python
# package1/__init__.py
__all__ = ["module2", "module3"]
```

包内模块可使用相对导入或绝对导入：

```python
# package1/module1.py 导入 package1/module2.py
from . import module2       # 相对导入
from package1 import module2 # 绝对导入
```

#### 导入方式

Python 提供两种主要导入语法，分别用于引入整个模块或包，或者从模块或包中导入特定符号。

* **import module1[, module2[,... moduleN] as alisa1[, alisa2[,... alisaN]** ：import 整个模块或包，他的效果是告诉解析器要从外部导入包/模块，之后的使用可以用 `module.func`来访问导入的包/模块下的名称。

```python
# import 整个模块或包
import module1
import module2 as m2

module1.func1()
m2.func2()
```

* **from module1 import func1**： import的是对应包/模块，他的效果是告诉解析器要从外部包/模块导入命名名称到本地的命名空间，之后的使用可以直接使用 `func`来直接访问导入的包/模块下的名称

```python
# from xxx import yyy
from module1 import func1
from module2 import func2 as f2
func1()
f2()
```

导入解析遵循模块搜索路径 (`sys.path`)：第一个匹配的包或模块被认为是顶层包。相对导入使用 `.` / `..`，基于当前模块所在包层级，绝对导入以顶层包或 `sys.path` 路径开始解析。注意，导入是相对包而言的，而非模块而言的。示例：

```python
# 包和模块导入示例
import package1.module2
from package1 import module2
from . import module2
from .. import module3
from ..subpackage import module4
```

绝对导入路径从顶层包开始，相对导入路径基于模块所在包，`__name__` 永远是 "__main__" 的模块作为主程序入口，主模块应使用绝对路径引用。

### Lambdas表达式

Python 使用 **lambda** 来创建匿名函数。lambda 函数是一种小型、匿名的、内联函数，它可以具有任意数量的参数，但只能有一个表达式。匿名函数不需要使用 **def** 关键字定义完整函数。lambda 函数通常用于编写简单的、单行的函数，通常在需要函数作为参数传递的情况下使用，例如在 map()、filter()、reduce() 等函数中。

**lambda 函数特点：**

- lambda 函数是匿名的，它们没有函数名称，只能通过赋值给变量或作为参数传递给其他函数来使用。
- lambda 函数通常只包含一行代码，这使得它们适用于编写简单的函数。

**lambda 语法格式：**

```
lambda arguments: expression
```

- `lambda`是 Python 的关键字，用于定义 lambda 函数。
- `arguments` 是参数列表，可以包含零个或多个参数，但必须在冒号(`:`)前指定。
- `expression` 是一个表达式，用于计算并返回函数的结果。

lambda 函数也可以设置多个参数，参数使用逗号 **,** 隔开。lambda 函数通常与内置函数如 map()、filter() 和 reduce() 一起使用，以便在集合上执行操作。

### Decorators 装饰器

装饰器（decorators）是 Python 中的一种高级功能，它允许你动态地修改函数或类的行为。装饰器是一种函数，它接受一个函数作为参数，并返回一个新的函数或修改原来的函数。

![img](https://www.runoob.com/wp-content/uploads/2024/03/decorators-python-1.png)

#### 函数装饰器

装饰器的语法使用 **@decorator_name** 来应用在函数或方法上。

Python 还提供了一些内置的装饰器，比如 **@staticmethod** 和 **@classmethod**，用于定义静态方法和类方法。Python 装饰允许在不修改原有函数代码的基础上，动态地增加或修改函数的功能，装饰器本质上是一个接收函数作为输入并返回一个新的包装过后的函数的对象。**解析：**decorator 是一个装饰器函数，它接受一个函数 func 作为参数，并返回一个内部函数 wrapper，在 wrapper 函数内部，你可以执行一些额外的操作，然后调用原始函数 func，并返回其结果。

- `decorator_function` 是装饰器，它接收一个函数 `original_function` 作为参数。
- `wrapper` 是内部函数，它是实际会被调用的新函数，它包裹了原始函数的调用，并在其前后增加了额外的行为。
- 当我们使用 `@decorator_function` 前缀在 `target_function` 定义前，Python会自动将 `target_function` 作为参数传递给 `decorator_function`，然后将返回的 `wrapper` 函数替换掉原来的 `target_function`。

装饰器通过 **@** 符号应用在函数定义之前，例如：

```
@time_logger
def target_function():
    pass
```

等同于：

```
def target_function():
    pass
target_function = time_logger(target_function)
```

这会将 target_function 函数传递给 decorator 装饰器，并将返回的函数重新赋值给 target_function。从而，每次调用 target_function 时，实际上是调用了经过装饰器处理后的函数。

通过装饰器，开发者可以在保持代码整洁的同时，灵活且高效地扩展程序的功能。带参数的装饰器

如果原函数需要参数，可以在装饰器的 wrapper 函数中传递参数。

#### 类装饰器

除了函数装饰器，Python 还支持类装饰器。

类装饰器（Class Decorator）是一种用于动态修改类行为的装饰器，它接收一个类作为参数，并返回一个新的类或修改后的类。

类装饰器可以用于：

- 添加/修改类的方法或属性
- 拦截实例化过程
- 实现单例模式、日志记录、权限检查等功能

**类装饰器有两种常见形式：**

- 函数形式的类装饰器（接收类作为参数，返回新类）
- 类形式的类装饰器（实现 **__call__** 方法，使其可调用）

```
def log_class(cls):
    """类装饰器，在调用方法前后打印日志"""
    class Wrapper:
        def __init__(self, *args, **kwargs):
            self.wrapped = cls(*args, **kwargs)  # 实例化原始类
        
        def __getattr__(self, name):
            """拦截未定义的属性访问，转发给原始类"""
            return getattr(self.wrapped, name)
        
        def display(self):
            print(f"调用 {cls.__name__}.display() 前")
            self.wrapped.display()
            print(f"调用 {cls.__name__}.display() 后")
    
    return Wrapper  # 返回包装后的类

@log_class
class MyClass:
    def display(self):
        print("这是 MyClass 的 display 方法")

obj = MyClass()
obj.display()
```

#### 内置装饰器

Python 提供了一些内置的装饰器，例如：

1. **`@staticmethod`**: 将方法定义为静态方法，不需要实例化类即可调用。
2. **`@classmethod`**: 将方法定义为类方法，第一个参数是类本身（通常命名为 `cls`）。
3. **`@property`**: 将方法转换为属性，使其可以像属性一样访问。

```
class MyClass:
    @staticmethod
    def static_method():
        print("This is a static method.")

    @classmethod
    def class_method(cls):
        print(f"This is a class method of {cls.__name__}.")

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

# 使用
MyClass.static_method()
MyClass.class_method()

obj = MyClass()
obj.name = "Alice"
print(obj.name)
```

### 迭代器与生成器 

#### 迭代器

迭代是 Python 最强大的功能之一，是访问集合元素的一种方式。迭代器是一个可以记住遍历的位置的对象。迭代器对象从集合的第一个元素开始访问，直到所有的元素被访问完结束。迭代器只能往前不会后退。迭代器有两个基本的方法：**iter()** 和 **next()**。字符串，列表或元组对象都可用于创建迭代器。迭代器对象可以使用常规for**语句进行遍历**。也可以使用 next() 函数。

```
#!/usr/bin/python3
 
list=[1,2,3,4]
it = iter(list)    # 创建迭代器对象
for x in it:
    print (x, end=" ")


#!/usr/bin/python3
 
import sys         # 引入 sys 模块
 
list=[1,2,3,4]
it = iter(list)    # 创建迭代器对象
 
while True:
    try:
        print (next(it))
    except StopIteration:
        sys.exit()
```

##### 创建迭代器

把一个类作为一个迭代器使用需要在类中实现两个方法 __iter__() 与 __next__() 。如果你已经了解的面向对象编程，就知道类都有一个构造函数，Python 的构造函数为 __init__(), 它会在对象初始化的时候执行。

__iter__() 方法返回一个特殊的迭代器对象， 这个迭代器对象实现了 __next__() 方法并通过 StopIteration 异常标识迭代的完成。

__next__() 方法（Python 2 里是 next()）会返回下一个迭代器对象。StopIteration 异常用于标识迭代的完成，防止出现无限循环的情况，在 __next__() 方法中我们可以设置在完成指定循环次数后触发 StopIteration 异常来结束迭代。

```
class MyNumbers:
  def __iter__(self):
    self.a = 1
    return self
 
  def __next__(self):
    if self.a <= 20:
      x = self.a
      self.a += 1
      return x
    else:
      raise StopIteration
 
myclass = MyNumbers()
myiter = iter(myclass)
 
for x in myiter:
  print(x)
```

#### 生成器

在 Python 中，使用了 **yield** 的函数被称为生成器（generator）。**yield** 是一个关键字，用于定义生成器函数，生成器函数是一种特殊的函数，可以在迭代过程中逐步产生值，而不是一次性返回所有结果。跟普通函数不同的是，生成器是一个返回迭代器的函数，只能用于迭代操作，更简单点理解生成器就是一个迭代器。当在生成器函数中使用 **yield** 语句时，函数的执行将会暂停，并将 **yield** 后面的表达式作为当前迭代的值返回。然后，每次调用生成器的 **next()** 方法或使用 **for** 循环进行迭代时，函数会从上次暂停的地方继续执行，直到再次遇到 **yield** 语句。这样，生成器函数可以逐步产生值，而不需要一次性计算并返回所有结果。调用一个生成器函数，返回的是一个迭代器对象。

```
def countdown(n):
    while n > 0:
        yield n
        n -= 1
 
# 创建生成器对象
generator = countdown(5)
 
# 通过迭代生成器获取值
print(next(generator))  # 输出: 5
print(next(generator))  # 输出: 4
print(next(generator))  # 输出: 3
 
# 使用 for 循环迭代生成器
for value in generator:
    print(value)  # 输出: 2 1
```

### 正则表达式

正则表达式是一个特殊的字符序列，它能帮助你方便的检查一个字符串是否与某种模式匹配。在 Python 中，使用 **re** 模块来处理正则表达式。re 模块提供了一组函数，允许你在字符串中进行模式匹配、搜索和替换操作。**re** 模块使 Python 语言拥有完整的正则表达式功能。

#### re.match函数

re.match 尝试从字符串的起始位置匹配一个模式，如果不是起始位置匹配成功的话，match() 就返回 None。

**函数语法**：

```
re.match(pattern, string, flags=0)
```

函数参数说明：

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| pattern | 匹配的正则表达式                                             |
| string  | 要匹配的字符串。                                             |
| flags   | 标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。参见：[正则表达式修饰符 - 可选标志](https://www.runoob.com/python3/python3-reg-expressions.html#flags) |

匹配成功 **re.match** 方法返回一个匹配的对象，否则返回 **None**。

我们可以使用 **group(num)** 或 **groups()** 匹配对象函数来获取匹配表达式。

| 匹配对象方法 | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| group(num=0) | 匹配的整个表达式的字符串，group() 可以一次输入多个组号，在这种情况下它将返回一个包含那些组所对应值的元组。 |
| groups()     | 返回一个包含所有小组字符串的元组，从 1 到 所含的小组号。     |

#### re.search方法

re.search 扫描整个字符串并返回第一个成功的匹配。

函数语法：

```
re.search(pattern, string, flags=0)
```

函数参数说明：

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| pattern | 匹配的正则表达式                                             |
| string  | 要匹配的字符串。                                             |
| flags   | 标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。参见：[正则表达式修饰符 - 可选标志](https://www.runoob.com/python3/python3-reg-expressions.html#flags) |

匹配成功re.search方法返回一个匹配的对象，否则返回None。

我们可以使用group(num) 或 groups() 匹配对象函数来获取匹配表达式。

| 匹配对象方法 | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| group(num=0) | 匹配的整个表达式的字符串，group() 可以一次输入多个组号，在这种情况下它将返回一个包含那些组所对应值的元组。 |
| groups()     | 返回一个包含所有小组字符串的元组，从 1 到 所含的小组号。     |

#### 检索和替换

Python 的re模块提供了re.sub用于替换字符串中的匹配项。

语法：

```
re.sub(pattern, repl, string, count=0, flags=0)
```

参数：

- pattern : 正则中的模式字符串。
- repl : 替换的字符串，也可为一个函数。
- string : 要被查找替换的原始字符串。
- count : 模式匹配后替换的最大次数，默认 0 表示替换所有的匹配。
- flags : 编译时用的匹配模式，数字形式。

前三个为必选参数，后两个为可选参数。

#### compile 函数

compile 函数用于编译正则表达式，生成一个正则表达式（ Pattern ）对象，供 match() 和 search() 这两个函数使用。

语法格式为：

```
re.compile(pattern[, flags])
```

参数：

- pattern : 一个字符串形式的正则表达式

- flags 可选，表示匹配模式，比如忽略大小写，多行模式等，具体参数为：

- - re.IGNORECASE 或 re.I
  - re.L 表示特殊字符集 \w, \W, \b, \B, \s, \S 依赖于当前环境
  - re.MULTILINE 或 re.M - 多行模式，改变 ^ 和 $ 的行为，使它们匹配字符串的每一行的开头和结尾。
  - re.DOTALL 或 re.S - 使 **.** 匹配包括换行符在内的任意字符。
  - re.ASCII - 使 \w, \W, \b, \B, \d, \D, \s, \S 仅匹配 ASCII 字符。
  - re.VERBOSE 或 re.X - 忽略空格和注释，可以更清晰地组织复杂的正则表达式。

  这些标志可以单独使用，也可以通过按位或（|）组合使用。例如，re.IGNORECASE | re.MULTILINE 表示同时启用忽略大小写和多行模式。

当匹配成功时返回一个 Match 对象，其中：

- `group([group1, …])` 方法用于获得一个或多个分组匹配的字符串，当要获得整个匹配的子串时，可直接使用 `group()` 或 `group(0)`；
- `start([group])` 方法用于获取分组匹配的子串在整个字符串中的起始位置（子串第一个字符的索引），参数默认值为 0；
- `end([group])` 方法用于获取分组匹配的子串在整个字符串中的结束位置（子串最后一个字符的索引+1），参数默认值为 0；
- `span([group])` 方法返回 `(start(group), end(group))`。

#### findall

在字符串中找到正则表达式所匹配的所有子串，并返回一个列表，如果有多个匹配模式，则返回元组列表，如果没有找到匹配的，则返回空列表。

**注意：** match 和 search 是匹配一次 findall 匹配所有。

语法格式为：

```
re.findall(pattern, string, flags=0)
或
pattern.findall(string[, pos[, endpos]])
```

参数：

- **pattern** 匹配模式。
- **string** 待匹配的字符串。
- **pos** 可选参数，指定字符串的起始位置，默认为 0。
- **endpos** 可选参数，指定字符串的结束位置，默认为字符串的长度。

#### re.finditer

和 findall 类似，在字符串中找到正则表达式所匹配的所有子串，并把它们作为一个迭代器返回。

```
re.finditer(pattern, string, flags=0)
```

参数：

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| pattern | 匹配的正则表达式                                             |
| string  | 要匹配的字符串。                                             |
| flags   | 标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。参见：[正则表达式修饰符 - 可选标志](https://www.runoob.com/python3/python3-reg-expressions.html#flags) |

#### re.split

split 方法按照能够匹配的子串将字符串分割后返回列表，它的使用形式如下：

```
re.split(pattern, string[, maxsplit=0, flags=0])
```

参数：

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| pattern  | 匹配的正则表达式                                             |
| string   | 要匹配的字符串。                                             |
| maxsplit | 分割次数，maxsplit=1 分割一次，默认为 0，不限制次数。        |
| flags    | 标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。参见：[正则表达式修饰符 - 可选标志](https://www.runoob.com/python3/python3-reg-expressions.html#flags) |

#### re.RegexObject

re.compile() 返回 RegexObject 对象。

#### re.MatchObject

group() 返回被 RE 匹配的字符串。

- **start()** 返回匹配开始的位置
- **end()** 返回匹配结束的位置
- **span()** 返回一个元组包含匹配 (开始,结束) 的位置

#### 正则表达式修饰符 - 可选标志

正则表达式可以包含一些可选标志修饰符来控制匹配的模式。

以下标志可以单独使用，也可以通过按位或（|）组合使用。例如，re.IGNORECASE | re.MULTILINE 表示同时启用忽略大小写和多行模式。

| 修饰符                | 描述                                                         | 实例                                                         |
| :-------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| re.IGNORECASE 或 re.I | 使匹配对大小写不敏感                                         | `import re pattern = re.compile(r'apple', flags=re.IGNORECASE) result = pattern.match('Apple') print(result.group())  # 输出: 'Apple'` |
| re.MULTILINE 或 re.M  | 多行匹配，影响 **^** 和 **$**，使它们匹配字符串的每一行的开头和结尾。 | `import re pattern = re.compile(r'^\d+', flags=re.MULTILINE) text = '123\n456\n789' result = pattern.findall(text) print(result)  # 输出: ['123', '456', '789']` |
| re.DOTALL 或 re.S：   | 使 **.** 匹配包括换行符在内的任意字符。                      | `import re pattern = re.compile(r'a.b', flags=re.DOTALL) result = pattern.match('a\nb') print(result.group())  # 输出: 'a\nb'` |
| re.ASCII              | 使 \w, \W, \b, \B, \d, \D, \s, \S 仅匹配 ASCII 字符。        | `import re pattern = re.compile(r'\w+', flags=re.ASCII) result = pattern.match('Hello123') print(result.group())  # 输出: 'Hello123'` |
| re.VERBOSE 或 re.X    | 忽略空格和注释，可以更清晰地组织复杂的正则表达式。           | `import re pattern = re.compile(r'''    \d+  # 匹配数字    [a-z]+  # 匹配小写字母 ''', flags=re.VERBOSE) result = pattern.match('123abc') print(result.group())  # 输出: '123abc'` |

------

#### 正则表达式模式

模式字符串使用特殊的语法来表示一个正则表达式。

字母和数字表示他们自身。一个正则表达式模式中的字母和数字匹配同样的字符串。

多数字母和数字前加一个反斜杠时会拥有不同的含义。

标点符号只有被转义时才匹配自身，否则它们表示特殊的含义。

反斜杠本身需要使用反斜杠转义。

由于正则表达式通常都包含反斜杠，所以你最好使用原始字符串来表示它们。模式元素(如 **r'\t'**，等价于 **\\t** )匹配相应的特殊字符。

下表列出了正则表达式模式语法中的特殊元素。如果你使用模式的同时提供了可选的标志参数，某些模式元素的含义会改变。

| 模式         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| ^            | 匹配字符串的开头                                             |
| $            | 匹配字符串的末尾。                                           |
| .            | 匹配任意字符，除了换行符，当re.DOTALL标记被指定时，则可以匹配包括换行符的任意字符。 |
| [...]        | 用来匹配所包含的任意一个字符，例如 [amk] 匹配 'a'，'m'或'k'  |
| [^...]       | 不在[]中的字符：[^abc] 匹配除了a,b,c之外的字符。             |
| re*          | 匹配0个或多个的表达式。                                      |
| re+          | 匹配1个或多个的表达式。                                      |
| re?          | 匹配0个或1个由前面的正则表达式定义的片段，非贪婪方式         |
| re{ n}       | 匹配n个前面表达式。例如，"o{2}"不能匹配"Bob"中的"o"，但是能匹配"food"中的两个o。 |
| re{ n,}      | 精确匹配n个前面表达式。例如，"o{2,}"不能匹配"Bob"中的"o"，但能匹配"foooood"中的所有o。"o{1,}"等价于"o+"。"o{0,}"则等价于"o*"。 |
| re{ n, m}    | 匹配 n 到 m 次由前面的正则表达式定义的片段，贪婪方式         |
| a\| b        | 匹配a或b                                                     |
| (re)         | 匹配括号内的表达式，也表示一个组                             |
| (?imx)       | 正则表达式包含三种可选标志：i, m, 或 x 。只影响括号中的区域。 |
| (?-imx)      | 正则表达式关闭 i, m, 或 x 可选标志。只影响括号中的区域。     |
| (?: re)      | 类似 (...), 但是不表示一个组                                 |
| (?imx: re)   | 在括号中使用i, m, 或 x 可选标志                              |
| (?-imx: re)  | 在括号中不使用i, m, 或 x 可选标志                            |
| (?#...)      | 注释.                                                        |
| (?= re)      | 前向肯定界定符。如果所含正则表达式，以 ... 表示，在当前位置成功匹配时成功，否则失败。但一旦所含表达式已经尝试，匹配引擎根本没有提高；模式的剩余部分还要尝试界定符的右边。 |
| (?! re)      | 前向否定界定符。与肯定界定符相反；当所含表达式不能在字符串当前位置匹配时成功。 |
| (?> re)      | 匹配的独立模式，省去回溯。                                   |
| \w           | 匹配数字字母下划线                                           |
| \W           | 匹配非数字字母下划线                                         |
| \s           | 匹配任意空白字符，等价于 [\t\n\r\f]。                        |
| \S           | 匹配任意非空字符                                             |
| \d           | 匹配任意数字，等价于 [0-9]。                                 |
| \D           | 匹配任意非数字                                               |
| \A           | 匹配字符串开始                                               |
| \Z           | 匹配字符串结束，如果是存在换行，只匹配到换行前的结束字符串。 |
| \z           | 匹配字符串结束                                               |
| \G           | 匹配最后匹配完成的位置。                                     |
| \b           | 匹配一个单词边界，也就是指单词和空格间的位置。例如， 'er\b' 可以匹配"never" 中的 'er'，但不能匹配 "verb" 中的 'er'。 |
| \B           | 匹配非单词边界。'er\B' 能匹配 "verb" 中的 'er'，但不能匹配 "never" 中的 'er'。 |
| \n, \t, 等。 | 匹配一个换行符。匹配一个制表符, 等                           |
| \1...\9      | 匹配第n个分组的内容。                                        |
| \10          | 匹配第n个分组的内容，如果它经匹配。否则指的是八进制字符码的表达式。 |



#### 字符匹配

| 实例   | 描述           |
| :----- | :------------- |
| python | 匹配 "python". |

#### 字符类

| 实例        | 描述                              |
| :---------- | :-------------------------------- |
| [Pp]ython   | 匹配 "Python" 或 "python"         |
| rub[ye]     | 匹配 "ruby" 或 "rube"             |
| [aeiou]     | 匹配中括号内的任意一个字母        |
| [0-9]       | 匹配任何数字。类似于 [0123456789] |
| [a-z]       | 匹配任何小写字母                  |
| [A-Z]       | 匹配任何大写字母                  |
| [a-zA-Z0-9] | 匹配任何字母及数字                |
| [^aeiou]    | 除了aeiou字母以外的所有字符       |
| [^0-9]      | 匹配除了数字外的字符              |

#### 特殊字符类

| 实例 | 描述                                                         |
| :--- | :----------------------------------------------------------- |
| .    | 匹配除 "\n" 之外的任何单个字符。要匹配包括 '\n' 在内的任何字符，请使用象 '[.\n]' 的模式。 |
| \d   | 匹配一个数字字符。等价于 [0-9]。                             |
| \D   | 匹配一个非数字字符。等价于 [^0-9]。                          |
| \s   | 匹配任何空白字符，包括空格、制表符、换页符等等。等价于 [ \f\n\r\t\v]。 |
| \S   | 匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。                  |
| \w   | 匹配包括下划线的任何单词字符。等价于'[A-Za-z0-9_]'。         |
| \W   | 匹配任何非单词字符。等价于 '[^A-Za-z0-9_]'。                 |

### List Comprehensions 列表推导式 

[列表推导式](https://zhida.zhihu.com/search?content_id=242962851&content_type=Article&match_order=1&q=列表推导式&zhida_source=entity)（List Comprehensions）是 Python 中一种简洁的创建列表的语法。它允许你从一个已有的[可迭代对象](https://zhida.zhihu.com/search?content_id=242962851&content_type=Article&match_order=1&q=可迭代对象&zhida_source=entity)（如列表、元组、字符串、集合或迭代器）中快速生成一个新的列表。列表推导式的基本语法是：

```python
[expression for item in iterable if condition]
```

其中：

- `expression`：对于可迭代对象中的每一个元素，都要执行这个表达式，结果将添加到新列表中。
- `item`：可迭代对象中的每一个元素，通常用于在表达式中进行某种操作。
- `iterable`：要进行迭代操作的可迭代对象。
- `if condition`：这是一个可选的子句，用于过滤可迭代对象中的元素，只有满足条件的元素才会被考虑。

**组合数据**

你可以使用列表推导式将多个列表的元素进行组合，生成新的列表结构。例如，你可以使用嵌套的列表推导式来创建一个二维列表的转置。

```python
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
transposed = [[row[i] for row in matrix] for i in range(len(matrix[0]))]
print(transposed)  # 输出: [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
```

**执行复杂操作**

列表推导式不仅限于简单的算术运算或条件判断，你还可以在其中执行更复杂的操作，如函数调用、属性访问等。

```python
# 假设有一个Person类，具有name和age属性
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

people = [Person("Alice", 25), Person("Bob", 30), Person("Charlie", 35)]
names = [person.name for person in people]
print(names)  # 输出: ['Alice', 'Bob', 'Charlie']
```

**循环执行某个函数**

你可以使用列表推导式来循环执行某个函数，并将结果收集到一个列表中。

```python
def square(x):
    return x ** 2

numbers = [1, 2, 3, 4, 5]
squares = [square(x) for x in numbers]
print(squares)  # 输出: [1, 4, 9, 16, 25]
```

**将list转换为dict或将dict转换为list**

虽然这不是列表推导式的直接用途，但你可以结合[字典推导式](https://zhida.zhihu.com/search?content_id=242962851&content_type=Article&match_order=1&q=字典推导式&zhida_source=entity)（Dictionary Comprehensions）来实现这些转换。

例如，将一个包含元组的列表转换为字典：

```python
items = [(1, 'apple'), (2, 'banana'), (3, 'cherry')]
dictionary = {key: value for key, value in items}
print(dictionary)  # 输出: {1: 'apple', 2: 'banana', 3: 'cherry'}
```

或者，将一个字典的键值对转换为列表：

```python
dictionary = {'a': 1, 'b': 2, 'c': 3}
keys = list(dictionary.keys())
values = list(dictionary.values())
print(keys)  # 输出: ['a', 'b', 'c']
print(values)  # 输出: [1, 2, 3]
```

### Generator Expressions 生成器表达式

生成器表达式是一种创建生成器的简洁语法，它类似于列表推导式（List Comprehension），但使用圆括号而不是方括号。生成器表达式返回一个生成器对象，这是一种特殊的迭代器。与列表推导式不同，生成器表达式不会一次性生成所有元素，而是在需要时逐个生成元素，这种特性称为惰性求值。惰性求值是生成器表达式的核心特性之一。当使用生成器表达式时，Python不会立即计算所有元素的值，而是在迭代过程中，当需要某个元素时才进行计算。这种方式避免了一次性将所有元素加载到内存中，从而节省了大量的内存空间，尤其在处理大规模数据时优势明显。

生成器表达式的语法非常简单，它的基本形式如下：

```
(expression for item in iterable)
```

这里的 `expression` 是对每个元素进行的操作，`item` 是迭代的元素，`iterable` 是可迭代对象，如列表、元组、集合等。

以下是一个简单的示例：

```
# 生成器表达式示例gen_exp = (i * 2 for i in range(5)) # 遍历生成器for num in gen_exp:    print(num)
```

在上述代码中，`(i * 2 for i in range(5))` 是一个生成器表达式，它会生成一个生成器对象 `gen_exp`。在 `for` 循环中，每次迭代时，生成器会根据需要生成下一个元素。

**数据处理**

生成器表达式在处理大规模数据集时非常有用，例如从文件中读取大量数据。假设我们有一个包含大量数字的文本文件，每行一个数字，我们可以使用生成器表达式逐行处理这些数字：

```
# 假设文件名为 numbers.txt，每行一个数字with open('numbers.txt', 'r') as file:    # 生成器表达式用于处理文件中的数字    numbers = (int(line.strip()) for line in file)    # 计算所有数字的总和    total = sum(numbers)    print(total)
```

在这个示例中，生成器表达式 `(int(line.strip()) for line in file)` 逐行读取文件内容，将每行的字符串转换为整数，并且只有在 `sum` 函数需要时才会进行转换，避免了一次性将整个文件内容加载到内存中。

**过滤数据**

生成器表达式可以结合条件语句来过滤数据。例如，我们要从一个列表中过滤出所有的偶数：

```
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]even_numbers = (i for i in numbers if i % 2 == 0)for num in even_numbers:    print(num)
```

在这个示例中，`(i for i in numbers if i % 2 == 0)` 是一个生成器表达式，它会过滤出列表 `numbers` 中的所有偶数。

### 编程范式

Python 支持四种主要的 [编程范式](https://en.wikipedia.org/wiki/Programming_paradigm)：命令式、函数式、过程式和面向对象。无论你是否认同它们是有效的甚至是实用的，Python 都力求使所有四种范式都可用且可工作。

#### 命令式编程范式

[命令式编程范式](https://en.wikipedia.org/wiki/Imperative_programming) 使用自然语言的祈使语气来表达指令。它以逐步的方式执行命令，就像一系列口头命令一样。遵循“如何解决”的方法，它直接改变程序的状态；因此它也被称为有状态编程模型。使用命令式编程范式，你可以快速编写非常简单但优雅的代码，并且对于涉及数据操作的任务非常方便。由于其相对较慢和顺序的执行策略，它不能用于复杂或并行计算。以命令式编程风格执行此操作的一种方法类似于

```python
>>> sample_characters = ['p','y','t','h','o','n']
>>> sample_string = ''
>>> sample_string
''
>>> sample_string = sample_string + sample_characters[0]
>>> sample_string
'p'
>>> sample_string = sample_string + sample_characters[1]
>>> sample_string
'py'
>>> sample_string = sample_string + sample_characters[2]
>>> sample_string
'pyt'
>>> sample_string = sample_string + sample_characters[3]
>>> sample_string
'pyth'
>>> sample_string = sample_string + sample_characters[4]
>>> sample_string
'pytho'
>>> sample_string = sample_string + sample_characters[5]
>>> sample_string
'python'
>>>
```

#### 函数式编程范式

[函数式编程范式](https://en.wikipedia.org/wiki/Functional_programming) 将程序计算视为基于 [lambda 演算](https://en.wikipedia.org/wiki/Lambda_calculus) 的数学函数的求值。Lambda 演算是数理逻辑中的一种形式系统，用于基于函数抽象和使用变量绑定和替换的应用来表达计算。它遵循“解决什么”的方法——也就是说，它表达逻辑而不描述其控制流——因此它也被归类为声明式编程模型。

函数式编程范式提倡无状态函数，但重要的是要注意，Python 函数式编程的实现偏离了标准实现。Python 被称为*不纯*函数式语言，因为如果你不小心，可能会保持状态并产生副作用。也就是说，函数式编程对于并行处理非常方便，并且对于需要递归和并发执行的任务非常高效。

```python
>>> sample_characters = ['p','y','t','h','o','n']
>>> import functools
>>> sample_string = functools.reduce(lambda s,c: s + c, sample_characters)
>>> sample_string
'python'
>>>
```

使用相同的示例，将字符列表连接以形成字符串的函数式方法与上述相同。由于计算在一行中发生，因此没有明确的方法可以通过 **sample_string** 获取程序的状态并跟踪进度。此示例的函数式编程实现非常引人入胜，因为它减少了代码行数，并且仅用一行代码即可完成其工作，但需要使用 **functools** 模块和 **reduce** 方法。三个关键字——**functools**、**reduce** 和 **lambda**——定义如下

- **functools** 是用于高阶函数的模块，它提供对其他函数进行操作或返回其他函数的函数。它鼓励编写可重用代码，因为它更容易复制现有函数，并在已传递某些参数的情况下以文档完善的方式创建函数的新版本。

- **reduce** 是一种方法，它将具有两个参数的函数从左到右累积地应用于序列中的项，以将序列减少为单个值。例如

  ```python
  >>> sample_list = [1,2,3,4,5]
  >>> import functools
  >>> sum = functools.reduce(lambda x,y: x + y, sample_list)
  >>> sum
  15
  >>> ((((1+2)+3)+4)+5)
  15
  >>> 
  ```

- **lambda 函数**是小的、匿名的（即无名的）函数，可以接受任意数量的参数，但只输出一个值。当它们用作另一个函数的参数或驻留在另一个函数内部时，它们很有用；因此它们旨在仅在一次实例中使用。

#### 过程式编程范式

[过程式编程范式](https://en.wikipedia.org/wiki/Procedural_programming) 是命令式编程的一个子类型，其中语句被结构化为过程（也称为子例程或函数）。程序组合更像是一个过程调用，程序可能位于宇宙中的某个位置，并且执行是顺序的，因此成为资源利用的瓶颈。与命令式编程范式一样，过程式编程遵循有状态模型。过程式编程范式有助于良好的程序设计实践，并允许以代码库的形式重用模块。

这种模块化开发形式是一种非常古老的开发风格。程序中的不同模块可能彼此没有关系，并且可以位于不同的位置，但是拥有大量模块会给许多开发者带来困难，因为它不仅会导致逻辑重复，而且还会导致在查找和进行正确调用方面产生大量开销。请注意，在以下实现中，方法 **stringify** 可以定义在宇宙中的任何位置，并且为了发挥作用，只需要使用所需的参数进行正确的调用即可。

```python
>>> def stringify(characters):
...    string = ''
...    for c in characters:
...        string = string + c
...    return stringify
...
>>> sample_characters = ['p','y','t','h','o','n']
>>> stringify(sample_characters)
'python'
>>> 
```

#### 面向对象编程范式

[面向对象编程范式](https://en.wikipedia.org/wiki/Object-oriented_programming) 将基本实体视为对象，其实例可以同时包含数据和修改该数据的相应方法。面向对象设计的不同原则有助于代码重用性、数据隐藏等，但它是一个复杂的野兽，并且以面向对象的方法编写相同的逻辑很棘手。例如

```python
>>> class StringOps:
...    def __init__(self, characters):
...        self.characters = characters
...    def stringify(self):
...        self.string = ''.join(self.characters)
...
>>> sample_characters = ['p','y','t','h','o','n']
>>> sample_string = StringOps(sample_characters)
>>> sample_string.stringify()
>>> sample_string.string
'python'
>>>
```

### Context Manager 上下文管理器

在 Python 中，`with` 语句几乎无处不在 —— 打开文件、连接数据库、获取锁、建立网络会话……这些操作有一个共同点：**需要正确地分配与释放资源**。这正是“[上下文管理器](https://zhida.zhihu.com/search?content_id=264267526&content_type=Article&match_order=1&q=上下文管理器&zhida_source=entity)”（Context Manager）存在的意义。上下文管理器是一种对象协议，允许你优雅地管理资源的“进入”和“退出”，从而在使用完资源后安全地释放它们。

简单来说：

- 当你执行 `with obj as x:` 时，Python 会自动调用：
  - `obj.__enter__()` —— 进入上下文之前执行；
  - `obj.__exit__()` —— 退出上下文时执行（无论正常还是异常退出）。

例如：

```python3
with open("test.txt", "w") as f:
    f.write("Hello World!")
```

`open()` 创建了一个文件对象，在 `with` 块结束后，文件会自动关闭，即使有异常也不用担心资源泄漏。

| 场景       | 示例                                   | 优点                 |
| ---------- | -------------------------------------- | -------------------- |
| 文件读写   | with open()                            | 自动关闭文件         |
| 数据库连接 | with sqlite3.connect()                 | 自动提交/回滚事务    |
| 线程锁     | with threading.Lock()                  | 线程安全释放         |
| 临时配置   | with context():                        | 状态恢复             |
| 网络连接   | async with httpx.AsyncClient()         | 自动关闭连接         |
| 自定义资源 | @contextmanager / @asynccontextmanager | 灵活控制资源生命周期 |

**自动释放资源**

手动关闭文件的写法：

```python3
f = open("data.txt", "r")
try:
    data = f.read()
finally:
    f.close()
```

使用上下文管理器：

```python3
with open("data.txt", "r") as f:
    data = f.read()
```

更简洁、也更安全。

**异常安全，防止资源泄漏**

即使 `with` 块中抛出异常，`__exit__()` 仍会执行，确保资源被清理。



Python 在执行 `with expr as var:` 时，底层流程大致如下：

1. 计算 `expr`，得到一个上下文管理器对象；
2. 通过 `__enter__()` 进入上下文，结果赋值给 `var`；
3. 执行 `with` 块的代码；
4. 执行完毕后，不论是否有异常，调用 `__exit__(exc_type, exc_val, exc_tb)`；
5. 如果 `__exit__` 返回 `True`，异常会被吞掉，否则会重新抛出。



#### 自定义上下文管理器

**类实现**

```python3
class MyContext:
    def __enter__(self):
        print("进入上下文")
        return "资源对象"

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("退出上下文")
        print(f"异常信息: {exc_type}, {exc_val}")
        return False  # False 表示不中断异常传播
    
with MyContext() as res:
    print(f"使用 {res}")
```

**使用 `contextlib.contextmanager`（同步版）**

上面的类实现很好理解，但在实际工作中，很多时候只是简单的“前后处理”，写类会显得繁琐。Python 提供了标准库模块 `contextlib` 来简化编写。

```python3
@contextmanager
def managed_resource():
    print("资源初始化")
    try:
        yield "资源对象"
    except Exception as e:
        print(f"捕获异常: {e}")
    finally:
        print("资源清理完成")

with managed_resource() as r:
    print(f"正在使用 {r}")
    raise ValueError("出错了！")
```

**使用 `contextlib.asynccontextmanager`（异步版）**

随着异步编程的普及，Python 还提供了异步上下文管理器的对应版本，用于 `async with`。

```python3
from contextlib import asynccontextmanager
import asyncio

@asynccontextmanager
async def connect():
    print("建立异步连接")
    conn = "异步资源"
    try:
        yield conn
    finally:
        print("关闭异步连接")

async def main():
    async with connect() as c:
        print(f"使用 {c}")
        await asyncio.sleep(1)

asyncio.run(main())
```

## Python框架

### Django

Django 是一个由 Python 编写的一个开放源代码的 Web 应用框架。使用 Django，只要很少的代码，Python 的程序开发人员就可以轻松地完成一个正式网站所需要的大部分内容，并进一步开发出全功能的 Web 服务。Django 提供了全栈开发所需的工具，包括数据库 ORM、模板引擎、路由系统、用户认证等，大幅减少重复代码。

**Django 的哲学:**

- **DRY（Don't Repeat Yourself）:** 避免重复代码，提倡复用（如模板继承、模型继承）。
- **约定优于配置:** 默认提供合理配置（如自动生成 Admin 界面），减少决策成本。
- **快速开发:** 从原型到生产环境均可高效推进。

Django 遵循 MVC（Model-View-Controller）架构，但在 Django 中更常被称为 MTV（Model-Template-View）。

| 功能           | 说明                                                |
| :------------- | :-------------------------------------------------- |
| **Admin 后台** | 自动生成管理界面，无需手动编写 CRUD 逻辑。          |
| **ORM**        | 用 Python 类操作数据库，无需写 SQL。                |
| **表单处理**   | 内置表单验证，防止 CSRF 攻击。                      |
| **用户认证**   | 提供登录、注册、权限管理（`django.contrib.auth`）。 |
| **路由系统**   | URL 映射灵活，支持正则表达式。                      |
| **缓存机制**   | 支持 Memcached、Redis 等后端。                      |

![img](./assets/Django-MVT-pattern.webp)

#### Django 安装

可以通过 Python 的包管理工具 `pip` 来完成。

```
pip --version
pip install Django
python -m django --version
```

#### Django Admin 后台

django-admin 是 Django 框架提供的一个命令行工具，它是管理 Django 项目的核心工具。

无论是创建新项目、运行开发服务器，还是执行数据库迁移，django-admin 都是不可或缺的工具。

要查看 django-admin 提供的所有命令，可以运行：

```
django-admin help
```

输出内容类似如下：

```
Type 'django-admin help <subcommand>' for help on a specific subcommand.

Available subcommands:

[django]
    check
    compilemessages
    createcachetable
    dbshell
    diffsettings
    dumpdata
    flush
    inspectdb
    loaddata
    makemessages
    makemigrations
    migrate
    optimizemigration
    runserver
    sendtestemail
    shell
    showmigrations
    sqlflush
    sqlmigrate
    sqlsequencereset
    squashmigrations
    startapp
    startproject
    test
    testserver
```

**创建新项目**

```
ddjango-admin startproject <项目名称> [目标目录]
```

这个命令会在当前目录下创建一个新的 Django 项目，包含基本的项目结构：

- `manage.py`：项目管理脚本
- `项目名称/`：项目主目录
  - `__init__.py`
  - `settings.py`：项目设置文件
  - `urls.py`：URL 路由配置
  - `wsgi.py`：WSGI 应用入口

参数说明:

| 参数          | 作用                                           | 示例                                                         |
| :------------ | :--------------------------------------------- | :----------------------------------------------------------- |
| `<项目名称>`  | 必填，项目名称（会生成同名目录）               | `django-admin startproject mysite`                           |
| `[目标目录]`  | 可选，指定项目存放目录                         | `django-admin startproject mysite /opt/myproject`            |
| `--template`  | 使用自定义项目模板                             | `django-admin startproject --template=my_template.zip mysite` |
| `--extension` | 指定文件扩展名（如 `.py`, `.txt`）             | `django-admin startproject --extension=py,txt mysite`        |
| `--name`      | 指定文件名模式（如 `Dockerfile`, `README.md`） | `django-admin startproject --name=Dockerfile mysite`         |

```
django-admin startproject mysite  # 创建默认项目
django-admin startproject mysite /opt/code  # 指定目录
django-admin startproject --template=https://example.com/my_template.zip mysite  # 使用远程模板
```

**创建新应用**

虽然通常使用 `manage.py` 来创建应用，但也可以通过 django-admin：

```
django-admin startapp <应用名称> [目标目录]
```

这会创建一个新的 Django 应用，包含：

- `migrations/`：数据库迁移文件目录
- `__init__.py`
- `admin.py`：管理后台配置
- `apps.py`：应用配置
- `models.py`：数据模型定义
- `tests.py`：测试代码
- `views.py`：视图函数

| 参数         | 作用                                                | 示例                                                        |
| :----------- | :-------------------------------------------------- | :---------------------------------------------------------- |
| `<应用名称>` | 必填，应用名称（会生成 `models.py`, `views.py` 等） | `django-admin startapp blog`                                |
| `[目标目录]` | 可选，指定应用存放目录                              | `django-admin startapp blog /opt/myapp`                     |
| `--template` | 使用自定义应用模板                                  | `django-admin startapp --template=my_app_template.zip blog` |

```
django-admin startapp blog  # 创建默认应用
django-admin startapp blog /opt/myapp  # 指定目录
django-admin startapp --template=my_template.zip blog  # 使用模板
```

**启动开发服务器**

```
python manage.py runserver [IP:端口]
```

参数说明:

| 参数         | 作用                                                | 示例                                      |
| :----------- | :-------------------------------------------------- | :---------------------------------------- |
| `[IP:端口]`  | 可选，指定监听的 IP 和端口（默认 `127.0.0.1:8000`） | `python manage.py runserver 0.0.0.0:8080` |
| `--noreload` | 禁用自动重载（调试时使用）                          | `python manage.py runserver --noreload`   |
| `--insecure` | 强制静态文件服务（非 DEBUG 模式）                   | `python manage.py runserver --insecure`   |

```
python manage.py runserver  # 默认启动（127.0.0.1:8000）
python manage.py runserver 0.0.0.0:8000  # 允许外部访问
python manage.py runserver 8080  # 仅修改端口
```

**数据库迁移**

Django 使用迁移系统来管理数据库模式变更：

```
python manage.py migrate [应用名] [迁移版本]
```

参数说明:

| 参数             | 作用                                 | 示例                                      |
| :--------------- | :----------------------------------- | :---------------------------------------- |
| `[应用名]`       | 可选，指定要迁移的应用               | `python manage.py migrate blog`           |
| `[迁移版本]`     | 可选，指定迁移版本号                 | `python manage.py migrate blog 0002`      |
| `--fake`         | 标记迁移为已执行（不实际修改数据库） | `python manage.py migrate --fake`         |
| `--fake-initial` | 仅当表已存在时标记为已执行           | `python manage.py migrate --fake-initial` |

```
python manage.py migrate  # 执行所有未应用的迁移
python manage.py migrate blog  # 仅迁移 blog 应用
python manage.py migrate blog 0002  # 迁移到特定版本
```



**检查项目配置**

```
django-admin check
```

这个命令会检查你的 Django 项目是否有配置错误，包括：

- 模型定义是否正确
- URL 配置是否有效
- 模板设置是否正确
- 静态文件配置等

**创建超级用户**

```
django-admin createsuperuser
```

这个命令会引导你创建一个可以访问 Django 管理后台的超级用户。

#### Django 项目结构

![img](./assets/mermaid_20250509_bef6e2-scaled.png)

**manage.py**：`manage.py` 是 Django 项目的命令行工具入口，它提供了许多有用的命令：

```
#!/usr/bin/env python
import os
import sys

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "myproject.settings")
    try:
        from django.core.management import execute_from_command_line
    except ImportError:
        # 处理导入错误
        pass
    execute_from_command_line(sys.argv)
```

常用命令示例：

- `python manage.py runserver` - 启动开发服务器
- `python manage.py migrate` - 应用数据库迁移
- `python manage.py createsuperuser` - 创建管理员账户

**settings.py**：`settings.py` 是 Django 项目的配置文件，包含所有重要的设置。

```
# 关键配置项详解：
DEBUG = True  # 开发时设为True，显示详细错误；生产环境必须改为False
ALLOWED_HOSTS = []  # DEBUG=False时需指定允许访问的域名（如['example.com']）

INSTALLED_APPS = [
    'django.contrib.admin',    # 后台管理
    'django.contrib.auth',     # 认证系统
    'django.contrib.contenttypes',  # 内容类型框架
    'django.contrib.sessions', # 会话管理
    'django.contrib.messages', # 消息框架
    'django.contrib.staticfiles',  # 静态文件管理
    # 可添加自定义应用：'myapp.apps.MyAppConfig'
]

DATABASES = {  # 数据库配置
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',  # 使用 pathlib 语法
        # MySQL示例：
        # 'ENGINE': 'django.db.backends.mysql',
        # 'NAME': 'mydb',
        # 'USER': 'root',
        # 'PASSWORD': 'password',
    }
}

STATIC_URL = '/static/'  # 静态文件URL前缀
STATICFILES_DIRS = [BASE_DIR / 'static']  # 开发时静态文件搜索目录
MEDIA_URL = '/media/'   # 用户上传文件URL前缀
MEDIA_ROOT = BASE_DIR / 'media'  # 上传文件存储路径
```

**urls.py**：URL 调度中心。

```
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),  # 后台路由
    path('blog/', include('blog.urls')),  # 子应用路由分发
    # path('api/', include('api.urls', namespace='api')),
]
```

- **include()**：实现路由模块化，将不同应用的路由分离到各自的 urls.py。
- **namespace**：用于反向解析 URL 时避免命名冲突。

**wsgi.py & asgi.py**

| 文件          | 用途                                                         |
| :------------ | :----------------------------------------------------------- |
| **`wsgi.py`** | WSGI（Web Server Gateway Interface）配置，用于传统同步服务器（如 Gunicorn、uWSGI）。生产环境通过此文件启动项目。 |
| **`asgi.py`** | ASGI（Asynchronous Server Gateway Interface）配置，支持异步服务器（如 Daphne、Uvicorn）。用于 WebSocket 或异步视图。 |

**静态文件与媒体文件**

- **static/**：存放 CSS、JavaScript、图片等，通过 STATIC_URL 访问。

- **media/**：用户上传的文件（如头像），通过 MEDIA_URL 访问。需配置服务器在开发时提供访问：

  ```
  # urls.py（仅开发环境）
  from django.conf import settings
  from django.conf.urls.static import static
  
  urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
  ```

**apps/ 目录（推荐结构）**

将应用集中管理，避免散落在项目根目录。需在 settings.py 中配置 Python 路径：

```
import sys
sys.path.insert(0, os.path.join(BASE_DIR, 'apps'))
```

通常具有以下结构：

```
myapp/
│
├── migrations/
│   └── __init__.py
├── __init__.py
├── admin.py
├── apps.py
├── models.py
├── tests.py
└── views.py

```

* **models.py**：定义数据模型，与数据库表对应

```
from django.db import models

class Product(models.Model):
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.TextField()
    
    def __str__(self):
        return self.name
```

* **views.py**：处理业务逻辑，返回响应。

```
from django.shortcuts import render
from .models import Product

def product_list(request):
    products = Product.objects.all()
    return render(request, 'myapp/product_list.html', {'products': products})
```

* **admin.py**：配置 Django 管理后台。

```
from django.contrib import admin
from .models import Product

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'price')
```

* **migrations 目录**：存储数据库迁移文件，Django 使用这些文件来跟踪模型变更并同步到数据库。

* **templates 目录**：存放 HTML 模板文件，Django 使用模板语言动态生成页面。

#### Django 模板

Django 的模板系统（Template System）是用于将业务逻辑（Python）与展示层（HTML）分离的核心组件，它允许开发者通过简单的标签和变量动态生成 HTML 页面。

使用 render 来替代之前使用的 HttpResponse,render 还使用了一个字典 context 作为参数。context 字典中元素的键值 **hello** 对应了模板中的变量 **{{ hello }}**。

```
from django.shortcuts import render
 
def runoob(request):
    context          = {}
    context['hello'] = 'Hello World!'
    return render(request, 'runoob.html', context)
```

| 能               | 语法/示例                      | 适用场景           |
| :--------------- | :----------------------------- | :----------------- |
| **变量渲染**     | `{{ variable }}`               | 动态显示数据       |
| **逻辑控制**     | `{% if %}`, `{% for %}`        | 条件/循环渲染      |
| **模板继承**     | `{% extends %}`, `{% block %}` | 避免重复 HTML 结构 |
| **静态文件**     | `{% static 'path' %}`          | 加载 CSS/JS/图片   |
| **自定义过滤器** | `@register.filter`             | 扩展模板功能       |

##### Django 模板标签

**变量模板**：

```
view：｛"HTML变量名" : "views变量名"｝
HTML：｛｛变量名｝｝
```

**列表模板**：

```
<p>{{ views_list }}</p>   # 取出整个列表
<p>{{ views_list.0 }}</p> # 取出列表的第一个元素
```

**字典模板**

```
<p>{{ views_dict }}</p>
<p>{{ views_dict.name }}</p>
```

**过滤器模板**

模板语法：

```
{{ 变量名 | 过滤器：可选参数 }}
```

* **default**：default 为变量提供一个默认值。如果 views 传的变量的布尔值是 false，则使用指定的默认值。
* **length**：返回对象的长度，适用于字符串和列表。字典返回的是键值对的数量，集合返回的是去重后的长度。
* **filesizeformat**：以更易读的方式显示文件的大小（即'13 KB', '4.1 MB', '102 bytes'等）。字典返回的是键值对的数量，集合返回的是去重后的长度。
* **date**：根据给定格式对一个日期变量进行格式化。格式 **Y-m-d H:i:s**返回 **年-月-日 小时:分钟:秒** 的格式时间。

* **truncatechars**：如果字符串包含的字符总个数多于指定的字符数量，那么会被截断掉后面的部分。截断的字符串将以 **...** 结尾。
* **safe**：将字符串标记为安全，不需要转义。要保证 views.py 传过来的数据绝对安全，才能用 safe。和后端 views.py 的 mark_safe 效果相同。Django 会自动对 views.py 传到HTML文件中的标签语法进行转义，令其语义失效。加 safe 过滤器是告诉 Django 该数据是安全的，不必对其进行转义，可以让该数据语义生效。

**If 模板**

基本语法格式如下：

```
{% if condition1 %}
   ... display 1
{% elif condition2 %}
   ... display 2
{% else %}
   ... display 3
{% endif %}
```

根据条件判断是否输出。if/else 支持嵌套。{% if %} 标签接受 and ， or 或者 not 关键字来对多个变量做判断 ，或者对变量取反（ not )

**for 标签**

{% for %} 允许我们在一个序列上迭代。与 Python 的 for 语句的情形类似，循环语法是 for X in Y ，Y 是要迭代的序列而 X 是在每一个特定的循环中使用的变量名称。每一次循环中，模板系统会渲染在 **{% for %}** 和 **{% endfor %}** 之间的所有内容。**遍历字典**: 可以直接用字典 **.items** 方法，用变量的解包分别获取键和值。可选的 {% empty %} 从句：在循环为空的时候执行（即 in 后面的参数布尔值为 False ）。

```
{% for i in listvar %}
    {{ forloop.counter0 }}
{% empty %}
    空空如也～
{% endfor %}
```

**include 标签**

{% include %} 标签允许在模板中包含其它的模板的内容。下面这个例子都包含了 nav.html 模板：

```
{% include "nav.html" %}
```

##### Django 模板继承

模板可以用继承的方式来实现复用，减少冗余内容。

网页的头部和尾部内容一般都是一致的，我们就可以通过模板继承来实现复用。

父模板用于放置可重复利用的内容，子模板继承父模板的内容，并放置自己的内容。

**标签 block...endblock:** 父模板中的预留区域，该区域留给子模板填充差异性的内容，不同预留区域名字不能相同。

```
{% block 名称 %} 
预留给子模板的区域，可以设置设置默认内容
{% endblock 名称 %}
```

子模板使用标签 extends 继承父模板：

```
{% extends "父模板路径"%} 
```

子模板如果没有设置父模板预留区域的内容，则使用在父模板设置的默认内容，当然也可以都不设置，就为空。

子模板设置父模板预留区域的内容：

```
{ % block 名称 % }
内容 
{% endblock 名称 %}
```

#### Django 模型

Django 对各种数据库提供了很好的支持，包括：PostgreSQL、MySQL、SQLite、Oracle。Django 为这些数据库提供了统一的调用API。 我们可以根据自己业务需求选择不同的数据库。下文以MySql为例。

```
sudo pip3 install pymysql
```

##### Django ORM

Django 模型使用自带的 ORM。对象关系映射（Object Relational Mapping，简称 ORM ）用于实现面向对象编程语言里不同类型系统的数据之间的转换。ORM 在业务逻辑层和数据库层之间充当了桥梁的作用。ORM 是通过使用描述对象和数据库之间的映射的元数据，将程序中的对象自动持久化到数据库中。

![img](./assets/django-orm1.png)

ORM 解析过程:

- 1、ORM 会将 Python 代码转成为 SQL 语句。
- 2、SQL 语句通过 pymysql 传送到数据库服务端。
- 3、在数据库中执行 SQL 语句并将结果返回。

ORM 对应关系表：

![img](./assets/orm-object.png)

##### 数据库配置

创建 MySQL 数据库( ORM 无法操作到数据库级别，只能操作到数据表)语法：

```
create database 数据库名称 default charset=utf8; # 防止编码问题，指定为 utf8
```

settings.py 文件中找到 DATABASES 配置项，配置信息修改为：

```
DATABASES = { 
    'default': 
    { 
        'ENGINE': 'django.db.backends.mysql',    # 数据库引擎
        'NAME': 'runoob', # 数据库名称
        'HOST': '127.0.0.1', # 数据库地址，本机 ip 地址 127.0.0.1 
        'PORT': 3306, # 端口 
        'USER': 'root',  # 数据库用户名
        'PASSWORD': '123456', # 数据库密码
    }  
}
```

然后告诉 Django 使用 pymysql 模块连接 mysql 数据库：

```
# 在与 settings.py 同级目录下的 __init__.py 中引入模块和进行配置 
import pymysql
pymysql.install_as_MySQLdb()
```

##### 定义模型

Django 规定，如果要使用模型，必须要创建一个 app。我们使用以下命令创建一个 TestModel 的 app:

```
django-admin startapp TestModel
```

修改 models.py 文件，代码如下：

```
# models.py
from django.db import models
 
class Test(models.Model):
    name = models.CharField(max_length=20)
```

以上的类名代表了数据库表名，且继承了models.Model，类里面的字段代表数据表中的字段(name)，数据类型则由CharField（相当于varchar）、DateField（相当于datetime）， max_length 参数限定长度。

接下来在 settings.py 中找到INSTALLED_APPS这一项，如下：

```
INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'TestModel',               # 添加此项
)
```

在命令行中运行：

```
$ python3 manage.py migrate   # 创建表结构

$ python3 manage.py makemigrations TestModel  # 让 Django 知道我们在我们的模型有一些变更
$ python3 manage.py migrate TestModel   # 创建表结构
```

看到几行 "Creating table…" 的字样，你的数据表就创建好了。

```
Creating tables ...
……
Creating table TestModel_test  #我们自定义的表
……
```

表名组成结构为：应用名_类名（如：TestModel_test）。

**注意：**尽管我们没有在 models 给表设置主键，但是 Django 会自动添加一个 id 作为主键。

##### 操作数据库

虽然Django提供了多种操作方法，但是还是推荐使用ORM交互。

* **创建模型**

在项目中的 models.py 中添加以下类：

class Book**(**models.Model**)**:
  **id** = models.AutoField**(**primary_key=True**)** *# id 会自动创建,可以手动写入*
  title = models.CharField**(**max_length=32**)** *# 书籍名称*
  price = models.DecimalField**(**max_digits=5, decimal_places=2**)** *# 书籍价格*
  publish = models.CharField**(**max_length=32**)** *# 出版社名称*
  pub_date = models.DateField**(****)** *# 出版时间*

然后在命令行执行以下命令：

```
$ python3 manage.py migrate   # 创建表结构

$ python3 manage.py makemigrations app01  # 让 Django 知道我们在我们的模型有一些变更
$ python3 manage.py migrate app01   # 创建表结构
```









#### Django 表单

HTTP协议以"请求－回复"的方式工作。客户发送请求时，可以在请求中附加数据。服务器通过解析请求，就可以获得客户传来的数据，并根据URL来提供特定的服务。

创建表单处理脚本和添加表单组件：

```
from django.http import HttpResponse
from django.shortcuts import render
# 表单
def search_form(request):
    return render(request, 'search_form.html')
 
# 接收请求数据
def search(request):  
    request.encoding='utf-8'
    if 'q' in request.GET and request.GET['q']:
        message = '你搜索的内容为: ' + request.GET['q']
    else:
        message = '你提交了空表单'
    return HttpResponse(message)
```

```
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>菜鸟教程(runoob.com)</title>
</head>
<body>
    <form action="/search/" method="get">
        <input type="text" name="q">
        <input type="submit" value="搜索">
    </form>
</body>
</html>
```

#### Django 视图

一个视图函数，简称视图，是一个简单的 Python 函数，它接受 Web 请求并且返回 Web 响应。响应可以是一个 HTML 页面、一个 404 错误页面、重定向页面、XML 文档、或者一张图片...无论视图本身包含什么逻辑，都要返回响应。代码写在哪里都可以，只要在 Python 目录下面，一般放在项目的 views.py 文件中。每个视图函数都负责返回一个 HttpResponse 对象，对象中包含生成的响应。视图层中有两个重要的对象：请求对象(request)与响应对象(HttpResponse)。

##### Request 对象

每个视图函数的第一个参数是一个 HttpRequest 对象，就像下面这个 runoob() 函数:

```
from django.http import HttpResponse

def runoob(request):
    return HttpResponse("Hello world")
```

HttpRequest对象包含当前请求URL的一些信息：

| **属性**      | **描述**                                                     |
| ------------- | ------------------------------------------------------------ |
| path          | 请求页面的全路径,不包括域名—例如, "/hello/"。                |
| method        | 请求中使用的HTTP方法的字符串表示。全大写表示。例如:if request.method == 'GET':   do_something() elif request.method == 'POST':   do_something_else() |
| GET           | 包含所有HTTP GET参数的类字典对象。参见QueryDict 文档。       |
| POST          | 包含所有HTTP POST参数的类字典对象。参见QueryDict 文档。服务器收到空的POST请求的情况也是有可能发生的。也就是说，表单form通过HTTP POST方法提交请求，但是表单中可以没有数据。因此，不能使用语句if request.POST来判断是否使用HTTP POST方法；应该使用if request.method == "POST" (参见本表的method属性)。注意: POST不包括file-upload信息。参见FILES属性。 |
| REQUEST       | 为了方便，该属性是POST和GET属性的集合体，但是有特殊性，先查找POST属性，然后再查找GET属性。借鉴PHP's $_REQUEST。例如，如果GET = {"name": "john"} 和POST = {"age": '34'},则 REQUEST["name"] 的值是"john", REQUEST["age"]的值是"34".强烈建议使用GET and POST,因为这两个属性更加显式化，写出的代码也更易理解。 |
| COOKIES       | 包含所有cookies的标准Python字典对象。Keys和values都是字符串。 |
| FILES         | 包含所有上传文件的类字典对象。FILES中的每个Key都是<input type="file" name="" />标签中name属性的值. FILES中的每个value 同时也是一个标准Python字典对象，包含下面三个Keys:filename: 上传文件名,用Python字符串表示content-type: 上传文件的Content typecontent: 上传文件的原始内容注意：只有在请求方法是POST，并且请求页面中<form>有enctype="multipart/form-data"属性时FILES才拥有数据。否则，FILES 是一个空字典。 |
| META          | 包含所有可用HTTP头部信息的字典。 例如:CONTENT_LENGTHCONTENT_TYPEQUERY_STRING: 未解析的原始查询字符串REMOTE_ADDR: 客户端IP地址REMOTE_HOST: 客户端主机名SERVER_NAME: 服务器主机名SERVER_PORT: 服务器端口META 中这些头加上前缀 **HTTP_** 为 Key, 冒号(:)后面的为 Value， 例如:HTTP_ACCEPT_ENCODINGHTTP_ACCEPT_LANGUAGEHTTP_HOST: 客户发送的HTTP主机头信息HTTP_REFERER: referring页HTTP_USER_AGENT: 客户端的user-agent字符串HTTP_X_BENDER: X-Bender头信息 |
| user          | 是一个django.contrib.auth.models.User 对象，代表当前登录的用户。如果访问用户当前没有登录，user将被初始化为django.contrib.auth.models.AnonymousUser的实例。你可以通过user的is_authenticated()方法来辨别用户是否登录：`if request.user.is_authenticated():    # Do something for logged-in users. else:    # Do something for anonymous users.`只有激活Django中的AuthenticationMiddleware时该属性才可用 |
| session       | 唯一可读写的属性，代表当前会话的字典对象。只有激活Django中的session支持时该属性才可用。 |
| raw_post_data | 原始HTTP POST数据，未解析过。 高级处理时会有用处。           |

Request对象也有一些有用的方法：

| 方法             | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| __getitem__(key) | 返回GET/POST的键值,先取POST,后取GET。如果键不存在抛出 KeyError。 这是我们可以使用字典语法访问HttpRequest对象。 例如,request["foo"]等同于先request.POST["foo"] 然后 request.GET["foo"]的操作。 |
| has_key()        | 检查request.GET or request.POST中是否包含参数指定的Key。     |
| get_full_path()  | 返回包含查询字符串的请求路径。例如， "/music/bands/the_beatles/?print=true" |
| is_secure()      | 如果请求是安全的，返回True，就是说，发出的是HTTPS请求。      |

##### QueryDict对象

在HttpRequest对象中, GET和POST属性是django.http.QueryDict类的实例。

QueryDict类似字典的自定义类，用来处理单键对应多值的情况。

QueryDict实现所有标准的词典方法。还包括一些特有的方法：

| **方法**    | **描述**                                                     |
| :---------- | :----------------------------------------------------------- |
| __getitem__ | 和标准字典的处理有一点不同，就是，如果Key对应多个Value，__getitem__()返回最后一个value。 |
| __setitem__ | 设置参数指定key的value列表(一个Python list)。注意：它只能在一个mutable QueryDict 对象上被调用(就是通过copy()产生的一个QueryDict对象的拷贝). |
| get()       | 如果key对应多个value，get()返回最后一个value。               |
| update()    | 参数可以是QueryDict，也可以是标准字典。和标准字典的update方法不同，该方法添加字典 items，而不是替换它们:`>>> q = QueryDict('a=1') >>> q = q.copy() # to make it mutable >>> q.update({'a': '2'}) >>> q.getlist('a')  ['1', '2'] >>> q['a'] # returns the last ['2']` |
| items()     | 和标准字典的items()方法有一点不同,该方法使用单值逻辑的__getitem__():`>>> q = QueryDict('a=1&a=2&a=3') >>> q.items() [('a', '3')]` |
| values()    | 和标准字典的values()方法有一点不同,该方法使用单值逻辑的__getitem__(): |

此外, QueryDict也有一些方法，如下表：

| **方法**                 | **描述**                                                     |
| :----------------------- | :----------------------------------------------------------- |
| copy()                   | 返回对象的拷贝，内部实现是用Python标准库的copy.deepcopy()。该拷贝是mutable(可更改的) — 就是说，可以更改该拷贝的值。 |
| getlist(key)             | 返回和参数key对应的所有值，作为一个Python list返回。如果key不存在，则返回空list。 It's guaranteed to return a list of some sort.. |
| setlist(key,list_)       | 设置key的值为list_ (unlike __setitem__()).                   |
| appendlist(key,item)     | 添加item到和key关联的内部list.                               |
| setlistdefault(key,list) | 和setdefault有一点不同，它接受list而不是单个value作为参数。  |
| lists()                  | 和items()有一点不同, 它会返回key的所有值，作为一个list, 例如:`>>> q = QueryDict('a=1&a=2&a=3') >>> q.lists() [('a', ['1', '2', '3'])] ` |
| urlencode()              | 返回一个以查询字符串格式进行格式化后的字符串(例如："a=2&b=3&b=5")。 |

##### Response 对象

响应对象主要有三种形式：HttpResponse()、render()、redirect()。

**HttpResponse():** 返回文本，参数为字符串，字符串中写文本内容。如果参数为字符串里含有 html 标签，也可以渲染。

**render():** 返回文本，第一个参数为 request，第二个参数为字符串（页面名称），第三个参数为字典（可选参数，向页面传递的参数：键为页面参数名，值为views参数名）。

**redirect()**：重定向，跳转新页面。参数为字符串，字符串中填写页面路径。一般用于 form 表单提交后，跳转到新页面。

render 和 redirect 是在 HttpResponse 的基础上进行了封装：

- render：底层返回的也是 HttpResponse 对象
- redirect：底层继承的是 HttpResponse 对象

#### Django 路由

路由简单的来说就是根据用户请求的 URL 链接来判断对应的处理程序，并返回处理结果，也就是 URL 与 Django 的视图建立映射关系。Django 路由在 urls.py 配置，urls.py 中的每一条配置对应相应的处理方法。

路由有两种配置：

- path：用于普通路径，不需要自己手动添加正则首位限制符号，底层已经添加。
- re_path：用于正则路径，需要自己手动添加正则首位限制符号。

```
from django.urls import re_path # 用re_path 需要引入 
urlpatterns = [ 
    path('admin/', admin.site.urls), 
    path('index/', views.index), # 普通路径 
    re_path(r'^articles/([0-9]{4})/$', views.articles), # 正则路径 
]
```

##### 路由分发(include)

Django 项目里多个app目录共用一个 urls 容易造成混淆，后期维护也不方便。使用路由分发（include），让每个app目录都单独拥有自己的 urls。

**步骤：**

- 1、在每个 app 目录里都创建一个 urls.py 文件。
- 2、在项目名称目录下的 urls 文件里，统一将路径分发给各个 app 目录。

```
from django.contrib import admin 
from django.urls import path,include # 从 django.urls 引入 include 
urlpatterns = [ 
    path('admin/', admin.site.urls), 
    path("app01/", include("app01.urls")), 
    path("app02/", include("app02.urls")), 
]
```

##### 反向解析

随着功能的增加，路由层的 url 发生变化，就需要去更改对应的视图层和模板层的 url，非常麻烦，不便维护。这时我们可以利用反向解析，当路由层 url 发生改变，在视图层和模板层动态反向解析出更改后的 url，免去修改的操作。反向解析一般用在模板中的超链接及视图中的重定向。

在 urls.py 中给路由起别名，**name="路由别名"**。

```
path("login1/", views.login, name="login")
```

在 views.py 中，从 django.urls 中引入 reverse，利用 **reverse("路由别名")** 反向解析:

```
return redirect(reverse("login"))
```

在模板 templates 中的 HTML 文件中，利用 **{% url "路由别名" %}** 反向解析。

```
<form action="{% url 'login' %}" method="post"> 
```

#### Django Admin 管理工具

Django 提供了基于 web 的管理工具。Django 自动管理工具是 django.contrib 的一部分。通过命令 **python manage.py createsuperuser** 来创建超级用户，如下所示：



```
# python manage.py createsuperuser
Username (leave blank to use 'root'): admin
Email address: admin@runoob.com
Password:
Password (again):
Superuser created successfully.
[root@solar HelloWorld]#
```

之后输入用户名密码登录，界面如下：

![img](./assets/A995340B-8F8C-4777-9B79-846B6A34508A.jpg)

其功能相对较多，不在详细说明。

#### Django 鉴权

Django 用户认证（Auth）组件一般用在用户的登录注册上，用于判断当前的用户是否合法，并跳转到登陆成功或失败页面。Django 用户认证（Auth）组件需要导入 auth 模块:

```
# 认证模块
from django.contrib import auth

# 对应数据库
from django.contrib.auth.models import User
```

返回值是用户对象。

创建用户对象的三种方法：

- **create()**：创建一个普通用户，密码是明文的。
- **create_user()**：创建一个普通用户，密码是密文的。
- **create_superuser()**：创建一个超级用户，密码是密文的，要多传一个邮箱 email 参数。

**参数：**

- username: 用户名。
- password：密码。
- email：邮箱 (create_superuser 方法要多加一个 email)。

验证用户的用户名和密码使用 authenticate() 方法，从需要 auth_user 表中过滤出用户对象。

使用前要导入：

```
from django.contrib import auth
```

参数：

- username：用户名
- password：密码

**返回值：**如果验证成功，就返回用户对象，反之，返回 None。

给验证成功的用户加 session，将 request.user 赋值为用户对象。

登陆使用 login() 方法。

使用前要导入：

```
from django.contrib import auth
```

参数：

- request：用户对象

返回值：None

注销用户使用 logout() 方法，需要清空 session 信息，将 request.user 赋值为匿名用户。

使用前要导入：

```
from django.contrib import auth
```

参数：

- request：用户对象

返回值：None

设置装饰器，给需要登录成功后才能访问的页面统一加装饰器。

使用前要导入：

```
from django.contrib.auth.decorators import login_required
```

#### Django Cookies 与 Sessions

Cookie 是存储在客户端计算机上的文本文件，并保留了各种跟踪信息。

识别返回用户包括三个步骤：

- 服务器脚本向浏览器发送一组 Cookie。例如：姓名、年龄或识别号码等。
- 浏览器将这些信息存储在本地计算机上，以备将来使用。
- 当下一次浏览器向 Web 服务器发送任何请求时，浏览器会把这些 Cookie 信息发送到服务器，服务器将使用这些信息来识别用户。

HTTP 是一种"无状态"协议，这意味着每次客户端检索网页时，客户端打开一个单独的连接到 Web 服务器，服务器会自动不保留之前客户端请求的任何记录。

但是仍然有以下三种方式来维持 Web 客户端和 Web 服务器之间的 session 会话：

##### Cookies

一个 Web 服务器可以分配一个唯一的 session 会话 ID 作为每个 Web 客户端的 cookie，对于客户端的后续请求可以使用接收到的 cookie 来识别。

在Web开发中，使用 session 来完成会话跟踪，session 底层依赖 Cookie 技术。

![img](./assets/cookie.png)



一个 Web 服务器可以分配一个唯一的 session 会话 ID 作为每个 Web 客户端的 cookie，对于客户端的后续请求可以使用接收到的 cookie 来识别。

在Web开发中，使用 session 来完成会话跟踪，session 底层依赖 Cookie 技术。

![img](./assets/cookie-1773910347379-13.png)

设置 cookie:

```
rep.set_cookie(key,value,...) 
rep.set_signed_cookie(key,value,salt='加密盐',...)
```

获取 cookie:

```
request.COOKIES.get(key)
```

删除 cookie:

```
rep =HttpResponse || render || redirect 
rep.delete_cookie(key)
```

##### Session

服务器在运行时可以为每一个用户的浏览器创建一个其独享的 session 对象，由于 session 为用户浏览器独享，所以用户在访问服务器的 web 资源时，可以把各自的数据放在各自的 session 中，当用户再去访问该服务器中的其它 web 资源时，其它 web 资源再从用户各自的 session 中取出数据为用户服务。

![img](./assets/5-21-1.jpg)

- a. 浏览器第一次请求获取登录页面 login。

- b. 浏览器输入账号密码第二次请求，若输入正确，服务器响应浏览器一个 index 页面和一个键为 sessionid，值为随机字符串的 cookie，即 set_cookie ("sessionid",随机字符串)。

- c. 服务器内部在 django.session 表中记录一条数据。

  django.session 表中有三个字段。

  - session_key：存的是随机字符串，即响应给浏览器的 cookie 的 sessionid 键对应的值。
  - session_data：存的是用户的信息，即多个 request.session["key"]=value，且是密文。
  - expire_date：存的是该条记录的过期时间（默认14天）

- d. 浏览器第三次请求其他资源时，携带 cookie :{sessionid:随机字符串}，服务器从 django.session 表中根据该随机字符串取出该用户的数据，供其使用（即保存状态）。

**注意:** django.session 表中保存的是浏览器的信息，而不是每一个用户的信息。 因此， 同一浏览器多个用户请求只保存一条记录（后面覆盖前面）,多个浏览器请求才保存多条记录。

cookie 弥补了 http 无状态的不足，让服务器知道来的人是"谁"，但是 cookie 以文本的形式保存在浏览器端，安全性较差，且最大只支持 4096 字节，所以只通过 cookie 识别不同的用户，然后，在对应的 session 里保存私密的信息以及超过 4096 字节的文本。

session 设置：

```
request.session["key"] = value
```

执行步骤：

- a. 生成随机字符串
- b. 把随机字符串和设置的键值对保存到 django_session 表的 session_key 和 session_data 里
- c. 设置 **cookie：set_cookie("sessionid",随机字符串)** 响应给浏览器

session 获取：

```
request.session.get('key')
```

执行步骤：

- a. 从 cookie 中获取 sessionid 键的值，即随机字符串。
- b. 根据随机字符串从 django_session 表过滤出记录。
- c. 取出 session_data 字段的数据。

session 删除，删除整条记录（包括 session_key、session_data、expire_date 三个字段）：

```
request.session.flush()
```

删除 session_data 里的其中一组键值对：

```
del request.session["key"]
```

执行步骤：

- a. 从 cookie 中获取 sessionid 键的值，即随机字符串
- b. 根据随机字符串从 django_session 表过滤出记录
- c. 删除过滤出来的记录

#### Django 中间件

Django 中间件是修改 Django request 或者 response 对象的钩子，可以理解为是介于 HttpRequest 与 HttpResponse 处理之间的一道处理过程。

浏览器从请求到响应的过程中，Django 需要通过很多中间件来处理，可以看如下图所示：

![img](./assets/1_t9TAX89Y3rZUXth2Le07Xg.png)

Django 中间件作用：

- 修改请求，即传送到 view 中的 HttpRequest 对象。
- 修改响应，即 view 返回的 HttpResponse 对象。



中间件可以定义四个方法，分别是：

process_request(self,request)
process_view(self, request, view_func, view_args, view_kwargs)
process_exception(self, request, exception)
process_response(self, request, response)

##### process_request 方法

process_request 方法有一个参数 request，这个 request 和视图函数中的 request 是一样的。

process_request 方法的返回值可以是 None 也可以是 HttpResponse 对象。

- 返回值是 None 的话，按正常流程继续走，交给下一个中间件处理。
- 返回值是 HttpResponse 对象，Django 将不执行后续视图函数之前执行的方法以及视图函数，直接以该中间件为起点，倒序执行中间件，且执行的是视图函数之后执行的方法。

process_request 方法是在视图函数之前执行的。

当配置多个中间件时，会按照 MIDDLEWARE中 的注册顺序，也就是列表的索引值，顺序执行。

不同中间件之间传递的 request 参数都是同一个请求对象。

**from** django.utils.deprecation **import** MiddlewareMixin

**from** django.shortcuts **import** render, HttpResponse

**class** MD1(MiddlewareMixin):
  **def** process_request(self, request):
    **print**("md1  process_request 方法。", id(request)) #在视图之前执行

##### process_response

process_response 方法有两个参数，一个是 request，一个是 response，request 是请求对象，response 是视图函数返回的 HttpResponse 对象，该方法必须要有返回值，且必须是response。

process_response 方法是在视图函数之后执行的。

当配置多个中间件时，会按照 MIDDLEWARE 中的注册顺序，也就是列表的索引值，倒序执行。

**class** MD1(MiddlewareMixin):
  **def** process_request(self, request):
    **print**("md1  process_request 方法。", id(request)) #在视图之前执行


  **def** process_response(self,request, response): :#基于请求响应
    **print**("md1  process_response 方法！", id(request)) #在视图之后
    **return** response

从下图看，正常的情况下按照绿色的路线进行执行,假设**中间件1**有返回值，则按照红色的路线走，直接执行该类下的 process_response 方法返回，后面的其他中间件就不会执行。

![img](./assets/md-sssss-1.png)

##### process_view

process_view 方法格式如下：

```
process_view(request, view_func, view_args, view_kwargs)
```

process_view 方法有四个参数：

- request 是 HttpRequest 对象。
- view_func 是 Django 即将使用的视图函数。
- view_args 是将传递给视图的位置参数的列表。
- view_kwargs 是将传递给视图的关键字参数的字典。

view_args 和 view_kwargs 都不包含第一个视图参数（request）。

process_view 方法是在视图函数之前，process_request 方法之后执行的。

返回值可以是 None、view_func(request) 或 HttpResponse 对象。

- 返回值是 None 的话，按正常流程继续走，交给下一个中间件处理。

- 返回值是 HttpResponse 对象，Django 将不执行后续视图函数之前执行的方法以及视图函数，直接以该中间件为起点，倒序执行中间件，且执行的是视图函数之后执行的方法。

- c.返回值是 view_func(request)，Django 将不执行后续视图函数之前执行的方法，提前执行视图函数，然后再倒序执行视图函数之后执行的方法。

- 当最后一个中间件的 process_request 到达路由关系映射之后，返回到第一个中间件 process_view，然后依次往下，到达视图函数。

  **class** MD1(MiddlewareMixin):
    **def** process_request(self, request):
      **print**("md1  process_request 方法。", id(request)) #在视图之前执行

  
    **def** process_response(self,request, response): :#基于请求响应
      **print**("md1  process_response 方法！", id(request)) #在视图之后
      **return** response


    **def** process_view(self,request, view_func, view_args, view_kwargs):
      **print**("md1  process_view 方法！") #在视图之前执行 顺序执行
      \#return view_func(request)

##### process_exception

process_exception 方法如下：

```
process_exception(request, exception)
```

参数说明：

- request 是 HttpRequest 对象。
- exception 是视图函数异常产生的 Exception 对象。

process_exception 方法只有在视图函数中出现异常了才执行，按照 settings 的注册倒序执行。

在视图函数之后，在 process_response 方法之前执行。

process_exception 方法的返回值可以是一个 None 也可以是一个 HttpResponse 对象。

返回值是 None，页面会报 500 状态码错误，视图函数不会执行。

process_exception 方法倒序执行，然后再倒序执行 process_response 方法。

返回值是 HttpResponse 对象，页面不会报错，返回状态码为 200。

视图函数不执行，该中间件后续的 process_exception 方法也不执行，直接从最后一个中间件的 process_response 方法倒序开始执行。

若是 process_view 方法返回视图函数，提前执行了视图函数，且视图函数报错，则无论 process_exception 方法的返回值是什么，页面都会报错， 且视图函数和 process_exception 方法都不执行。

直接从最后一个中间件的 process_response 方法开始倒序执行：

**class** MD1(MiddlewareMixin):
  **def** process_request(self, request):
    **print**("md1  process_request 方法。", id(request)) #在视图之前执行

  **def** process_response(self,request, response): :#基于请求响应
    **print**("md1  process_response 方法！", id(request)) #在视图之后
    **return** response

  **def** process_view(self,request, view_func, view_args, view_kwargs):
    **print**("md1  process_view 方法！") #在视图之前执行 顺序执行
    \#return view_func(request)


  **def** process_exception(self, request, exception):#引发错误 才会触发这个方法
    **print**("md1  process_exception 方法！")
    \# return HttpResponse(exception) #返回错误信息





### FastAPI

FastAPI 是一个用于构建 API 的现代、快速（高性能）的 web 框架，专为在 Python 中构建 RESTful API 而设计。FastAPI 使用 Python 3.8+ 并基于标准的 Python 类型提示。FastAPI 建立在 Starlette 和 Pydantic 之上，利用类型提示进行数据处理，并自动生成API文档。FastAPI 于 2018 年 12 月 5 日发布第一版本，以其易用性、速度和稳健性在开发者中间迅速流行起来。FastAPI 支持异步编程，可在生产环境中运行。

#### FastAPI 安装

FastAPI 依赖 Python 3.8 及更高版本。安装 FastAPI 很简单，这里我们使用 **pip** 命令来安装。

```
# 检查 Python 版本
python --version
pip install "fastapi[all]"
# fastapi - FastAPI 框架
# uvicorn[standard] - ASGI 服务器
# python-multipart - 表单和文件上传支持
# jinja2 - 模板引擎
# python-jose - JWT 令牌支持
# passlib - 密码哈希
# bcrypt - 密码加密
# python-dotenv - 环境变量支持
```

#### FastAPI 路由

在 FastAPI 中，基本路由是定义 API 端点的关键。每个路由都映射到应用程序中的一个函数，用于处理特定的 HTTP 请求，并返回相应的响应。

```
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}
```

**代码说明：**

- `FastAPI()`：创建 FastAPI 应用实例。
- `@app.get("/")`：使用 `@app.get` 装饰器创建一个处理根路径的路由。
- `def read_root()`：路由处理函数，返回一个包含 {"Hello": "World"} 的字典。

- `@app.get("/items/{item_id}")`：定义了一个路由路径，其中 `{item_id}` 是路径参数，对应于函数参数 `item_id`。
- `def read_item(item_id: int, q: str = None)`：路由处理函数接受一个整数类型的路径参数 `item_id` 和一个可选的字符串类型查询参数 `q`。

使用 Uvicorn 启动应用：

```
uvicorn main:app --reload
```

FastAPI 自动生成的交互式 API 文档将包括定义的路由信息、路径参数、查询参数等。访问文档地址 **http://127.0.0.1:8000/docs** 查看详细的文档和测试界面：

![img](./assets/index-01-swagger-ui-simple.png)

#### FastAPI 请求与响应

在 FastAPI 中，请求（Request）和响应（Response）是与客户端交互的核心。FastAPI 提供了强大的工具来解析请求数据，并根据需要生成规范的响应。

##### 请求

**查询参数**

以下实例中我们定义了一个 **/items/** 路由，接受两个查询参数 **skip** 和 **limit**，它们的类型均为整数，默认值分别为 **0** 和 **10**。

```
from fastapi import FastAPI

app = FastAPI()

@app.get("/items/")
def read_item(skip: int = 0, limit: int = 10):
    return {"skip": skip, "limit": limit}
```

**路径参数**

我们可以把参数设置在路径上，这样 URL 看起来更美观一些。以下实例我们定义了一个带有路径参数 **item_id** 和查询参数 **q** 的路由。

```
from fastapi import FastAPI

app = FastAPI()

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}
```

**请求体**

接下来我们创建了一个 **/items/** 路由，使用 **@app.post** 装饰器表示这是一个处理 **POST** 请求的路由。

```
from pydantic import BaseModel
from fastapi import FastAPI

app = FastAPI()
class Item(BaseModel):
    name: str
    description: str = None
    price: float
    tax: float = None

@app.post("/items/")
def create_item(item: Item):
    return item
```

使用 Pydantic 模型 Item 定义了一个请求体，包含多个字段

##### 响应

**返回 JSON 数据**

路由处理函数返回一个字典，该字典将被 FastAPI 自动转换为 JSON 格式，并作为响应发送给客户端：

```
from fastapi import FastAPI

app = FastAPI()

@app.get("/items/")
def read_item(skip: int = 0, limit: int = 10):
    return {"skip": skip, "limit": limit}
```

**返回 Pydantic 模型**

路由处理函数返回一个 Pydantic 模型实例，FastAPI 将自动将其转换为 JSON 格式，并作为响应发送给客户端：

```
from pydantic import BaseModel
from fastapi import FastAPI

app = FastAPI()
class Item(BaseModel):
    name: str
    description: str = None
    price: float
    tax: float = None

@app.post("/items/")
def create_item(item: Item):
    return item
```

**请求头和 Cookie**

使用 Header 和 Cookie 类型注解获取请求头和 Cookie 数据。

```
from fastapi import Header, Cookie
from fastapi import FastAPI

app = FastAPI()

@app.get("/items/")
def read_item(user_agent: str = Header(None), session_token: str = Cookie(None)):
    return {"User-Agent": user_agent, "Session-Token": session_token}
```

**重定向和状态码**

使用 **RedirectResponse** 实现重定向，将客户端重定向到 **/items/** 路由。

```
from fastapi import Header, Cookie
from fastapi import FastAPI
from fastapi.responses import RedirectResponse

app = FastAPI()

@app.get("/items/")
def read_item(user_agent: str = Header(None), session_token: str = Cookie(None)):
    return {"User-Agent": user_agent, "Session-Token": session_token}

@app.get("/redirect")
def redirect():
    return RedirectResponse(url="/items/")
```

**自定义响应头**

使用 **JSONResponse** 自定义响应头:

```
from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI()

@app.get("/items/{item_id}")
def read_item(item_id: int):
    content = {"item_id": item_id}
    headers = {"X-Custom-Header": "custom-header-value"}
    return JSONResponse(content=content, headers=headers)
```

#### FastAPI Pydantic 模型

Pydantic 是一个用于数据验证和序列化的 Python 模型库。它在 FastAPI 中广泛使用，用于定义请求体、响应体和其他数据模型，提供了强大的类型检查和自动文档生成功能。以下是关于 Pydantic 模型的详细介绍：

**定义 Pydantic 模型**

使用 Pydantic 定义一个模型非常简单，只需创建一个继承自 pydantic.BaseModel 的类，并在其中定义字段。字段的类型可以是任何有效的 Python 类型，也可以是 Pydantic 内置的类型。

```
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    description: str = None
    price: float
    tax: float = None
```

以上代码中中，我们定义了一个名为 Item 的 Pydantic 模型，包含了四个字段：name、description、price 和 tax，name 和 price 是必需的字段，而 description 和 tax 是可选的字段，其默认值为 None。

**使用 Pydantic 模型**

* **请求体验证**：在 FastAPI 中，可以将 Pydantic 模型用作请求体（Request Body），以自动验证和解析客户端发送的数据。

```
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    description: str = None
    price: float
    tax: float = None

@app.post("/items/")
def create_item(item: Item):
    return item
```

以上代码中中，create_item 路由处理函数接受一个名为 item 的参数，其类型是 Item 模型。FastAPI 将自动验证传入的 JSON 数据是否符合模型的定义，并将其转换为 Item 类型的实例。

* **查询参数验证**：Pydantic 模型还可以用于验证查询参数、路径参数等。

```
from fastapi import FastAPI, Query
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    description: str = None
    price: float
    tax: float = None

@app.get("/items/")
def read_item(item: Item, q: str = Query(..., max_length=10)):
    return {"item": item, "q": q}
```

以上代码中，read_item 路由处理函数接受一个 Item 模型的实例作为查询参数，以及一个名为 q 的字符串查询参数。通过使用 Query 函数，我们还可以为查询参数指定更多的验证规则，如最大长度限制。

**自动文档生成**

使用 Pydantic 模型的一个重要优势是，它能够自动为 FastAPI 生成交互式 API 文档。文档会包括模型的字段、类型、验证规则等信息，让开发者和 API 使用者能够清晰地了解如何正确使用 API。打开 **http://127.0.0.1:8000/docs**，API 文档显示如下：

![img](./assets/fa461333139a7714dc4533af11d98dfe.png)

**数据转换和序列化**

Pydantic 模型不仅提供了验证功能，还可以用于将数据转换为特定类型（例如 JSON）或反向序列化。在 FastAPI 中，这种能力是自动的，你无需手动处理。通过使用 Pydantic 模型，你可以更轻松地定义和验证数据，使得代码更清晰、更健壮，并通过自动生成的文档提供更好的 API 交互体验。接下来我们可以打开 **http://127.0.0.1:8000/docs** 来进行 POST 测试：填写请求参数：

![img](./assets/2ad6a4628a07ffede6521119828c083f.png)

返回结果如下：

![img](./assets/e8cd27575ac43d40eb06c8fc4c6ff938.png)

#### FastAPI 路径操作依赖项

FastAPI 提供了简单易用，但功能强大的依赖注入系统，这个依赖系统设计的简单易用，可以让开发人员轻松地把组件集成至 FastAPI。FastAPI 提供了路径操作依赖项（Path Operation Dependencies）的机制，允许你在路由处理函数执行之前或之后运行一些额外的逻辑。依赖项就是一个函数，且可以使用与路径操作函数相同的参数。路径操作依赖项提供了一种灵活的方式来组织代码、验证输入、进行身份验证等。

依赖项是在路由操作函数执行前或后运行的可复用的函数或对象。它们被用于执行一些通用的逻辑，如验证、身份验证、数据库连接等。在 FastAPI 中，依赖项通常用于两个方面：

- **预处理（Before）依赖项：** 在路由操作函数执行前运行，用于预处理输入数据，验证请求等。
- **后处理（After）依赖项：** 在路由操作函数执行后运行，用于执行一些后处理逻辑，如日志记录、清理等。

**依赖注入**：依赖注入是将依赖项注入到路由操作函数中的过程。在 FastAPI 中，通过在路由操作函数参数中声明依赖项来实现依赖注入。FastAPI 将负责解析依赖项的参数，并确保在执行路由操作函数之前将其传递给函数。

**依赖项的使用**：

* **定义依赖项**

```
from fastapi import Depends, FastAPI

app = FastAPI()

# 依赖项函数
def common_parameters(q: str = None, skip: int = 0, limit: int = 100):
    return {"q": q, "skip": skip, "limit": limit}
```

在这个例子中，common_parameters 是一个依赖项函数，用于预处理查询参数。在路由中使用依赖项：

```
from fastapi import Depends

# 路由操作函数
@app.get("/items/")
async def read_items(commons: dict = Depends(common_parameters)):
    return commons
```

在这个例子中，read_items 路由操作函数中的参数 commons 使用了 Depends(common_parameters)，表示 common_parameters 是一个依赖项。FastAPI 将在执行路由操作函数之前运行 common_parameters 函数，并将其返回的结果传递给 read_items 函数。

**依赖项的用途**：

* **预处理（Before）**：以下实例中，**common_parameters** 是一个依赖项函数，它接受查询参数 **q、skip 和 limit**，并返回一个包含这些参数的字典。在路由操作函数 **read_items** 中，通过传入 Depends(common_parameters)，我们使用了这个依赖项函数，实现了在路由执行前预处理输入数据的功能。

```
from fastapi import Depends, FastAPI, HTTPException

app = FastAPI()

# 依赖项函数
def common_parameters(q: str = None, skip: int = 0, limit: int = 100):
    return {"q": q, "skip": skip, "limit": limit}

# 路由操作函数
@app.get("/items/")
async def read_items(commons: dict = Depends(common_parameters)):
    return commons
```

* **后处理（After）**：以下例子中，**after_request** 是一个后处理函数，用于在路由执行后执行一些逻辑。在路由操作函数 read_items_after 中，通过传入 Depends(after_request)，我们使用了这个后处理依赖项，实现了在路由执行后进行额外操作的功能。

```
from fastapi import Depends, FastAPI, HTTPException

app = FastAPI()

# 依赖项函数
def common_parameters(q: str = None, skip: int = 0, limit: int = 100):
    return {"q": q, "skip": skip, "limit": limit}

# 路由操作函数
@app.get("/items/")
async def read_items(commons: dict = Depends(common_parameters)):
    return commons

# 后处理函数
async def after_request():
    # 这里可以执行一些后处理逻辑，比如记录日志
    pass

# 后处理依赖项
@app.get("/items/", response_model=dict)
async def read_items_after(request: dict = Depends(after_request)):
    return {"message": "Items returned successfully"}
```

**多个依赖项的组合**

以下例子中，**common_parameters** 和 **verify_token** 是两个不同的依赖项函数，**verify_token** 依赖于 **common_parameters**，这种组合依赖项的方式允许我们在路由执行前先验证一些参数，然后在进行身份验证。

```
from fastapi import Depends, FastAPI, HTTPException

app = FastAPI()

# 依赖项函数1
def common_parameters(q: str = None, skip: int = 0, limit: int = 100):
    return {"q": q, "skip": skip, "limit": limit}

# 依赖项函数2
def verify_token(token: str = Depends(common_parameters)):
    if token is None:
        raise HTTPException(status_code=400, detail="Token required")
    return token

# 路由操作函数
@app.get("/items/")
async def read_items(token: dict = Depends(verify_token)):
    return token
```

**异步依赖项**

依赖项函数和后处理函数可以是异步的，允许在它们内部执行异步操作。以下例子中，**get_token** 是一个异步的依赖项函数，模拟了一个异步操作。在路由操作函数 read_items 中，我们使用了这个异步依赖项函数。

```
from fastapi import Depends, FastAPI, HTTPException
from typing import Optional
import asyncio

app = FastAPI()

# 异步依赖项函数
async def get_token():
    # 模拟异步操作
    await asyncio.sleep(2)
    return "fake-token"

# 异步路由操作函数
@app.get("/items/")
async def read_items(token: Optional[str] = Depends(get_token)):
    return {"token": token}
```

#### FastAPI 表单数据

在 FastAPI 中，接收表单数据是一种常见的操作，通常用于处理用户通过 HTML 表单提交的数据。FastAPI 提供了 Form 类型，可以用于声明和验证表单数据。

**声明表单数据模型**

接下来我们设计一个接收一个登陆的表单数据，要使用表单，需预先安装 python-multipart：

```
pip install python-multipart。
```

代码如下：

```
from fastapi import FastAPI, Form

app = FastAPI()


@app.post("/login/")
async def login(username: str = Form(), password: str = Form()):
    return {"username": username}
```

接下来我们可以进入 API 文档 **http://127.0.0.1:8000/docs** 进行测验：

![img](./assets/927e7dfc95fb795eeaa3af240662cb94.png)

使用 Pydantic 模型来声明表单数据模型。在模型中，使用 Field 类型声明每个表单字段，并添加必要的验证规则。

```
from pydantic import BaseModel, Field

class Item(BaseModel):
    name: str = Field(..., title="Item Name", max_length=100)
    description: str = Field(None, title="Item Description", max_length=255)
    price: float = Field(..., title="Item Price", gt=0)
```

以上例子中，Item 是一个 Pydantic 模型，用于表示表单数据。模型中的字段 name、description 和 price 分别对应表单中的不同输入项，并设置了相应的验证规则。除了可以在 API 文档中测验，另外我们也可以自己创建 html 来测试：

```
<form action="http://localhost:8000/items/" method="post">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required>
    <br>
    <label for="description">Description:</label>
    <textarea id="description" name="description"></textarea>
    <br>
    <label for="price">Price:</label>
    <input type="number" id="price" name="price" required min="0">
    <br>
    <button type="submit">Submit</button>
</form>
```

**在路由中接收表单数据**

在路由操作函数中，可以使用 Form 类型来接收表单数据。Form 类型的参数可以与 Pydantic 模型的字段一一对应，以实现表单数据的验证和转换。

```
from fastapi import FastAPI, Form

app = FastAPI()

# 路由操作函数
@app.post("/items/")
async def create_item(
    name: str = Form(...),
    description: str = Form(None),
    price: float = Form(..., gt=0),
):
    return {"name": name, "description": description, "price": price}
```

以上例子中，create_item 路由操作函数接收了三个表单字段：name、description 和 price，这些字段与 Item 模型的相应字段一致，FastAPI 将自动根据验证规则验证表单数据。接下来我们可以进入 API 文档 **http://127.0.0.1:8000/docs** 进行测验：

![img](./assets/514028636203aef522a8addb3f4eb62a.png)

**表单数据的验证和文档生成**

使用 Pydantic 模型和 Form 类型，表单数据的验证和文档生成都是自动的。FastAPI 将根据模型中的字段信息生成交互式 API 文档，并根据验证规则进行数据验证。API 文档地址 **http://127.0.0.1:8000/docs** 。

![img](./assets/0d28c66e90a6ad39fc4ef693c146835c.png)

![img](./assets/7eb01111becfc49e6e380300ad66c7a3.png)

**处理文件上传**

如果表单包含文件上传，可以使用 UploadFile 类型处理。以下是一个处理文件上传的实例：

```
from fastapi import FastAPI, File, UploadFile

app = FastAPI()

# 路由操作函数
@app.post("/files/")
async def create_file(file: UploadFile = File(...)):
    return {"filename": file.filename}
```

在这个例子中，create_file 路由操作函数接收了一个 UploadFile 类型的文件参数。FastAPI 将负责处理文件上传，并将文件的相关信息包装在 UploadFile 对象中，可以轻松地获取文件名、内容类型等信息。通过上述方式，FastAPI 提供了一种简单而强大的方法来接收和处理表单数据，同时保持了代码的清晰性和可维护性。

#### FastAPI 交互式API文档

FastAPI 提供了内置的交互式 API 文档，使开发者能够轻松了解和测试 API 的各个端点。

这个文档是自动生成的，基于 OpenAPI 规范，支持 Swagger UI 和 ReDoc 两种交互式界面。

通过 FastAPI 的交互式 API 文档，开发者能够更轻松地理解和使用 API，提高开发效率

在运行 FastAPI 应用时，Uvicorn 同时启动了交互式 API 文档服务。

默认情况下，你可以通过访问 **http://127.0.0.1:8000/docs** 来打开 Swagger UI 风格的文档：

![img](./assets/index-01-swagger-ui-simple-1773918165488-17.png)

Swagger UI 提供了一个直观的用户界面，用于浏览 API 的各个端点、查看请求和响应的结构，并支持直接在文档中进行 API 请求测试。通过 Swagger UI，你可以轻松理解每个路由操作的输入参数、输出格式和请求示例。

或者通过 **http://127.0.0.1:8000/redoc** 来打开 ReDoc 风格的文档。

![img](./assets/index-02-redoc-simple.png)

ReDoc 是另一种交互式文档界面，具有清晰简洁的外观。它使得开发者能够以可读性强的方式查看 API 的描述、请求和响应。与 Swagger UI 不同，ReDoc 的设计强调文档的可视化和用户体验。



### AIOHTTP

aiohttp 是一个基于异步 I/O 的 Web 框架，专注于提供高性能、低开销的异步 Web 服务。它允许我们同时处理大量并发请求，而不会阻塞程序执行。aiohttp 使用 Python 的 async /await 语法来实现异步编程，这使得编写异步代码更加直观和简洁。`asyncio`可以实现单线程并发IO操作。如果仅用在客户端，发挥的威力不大。如果把`asyncio`用在服务器端，例如Web服务器，由于HTTP连接就是IO操作，因此可以用单线程+`async`函数实现多用户的高并发支持。

`asyncio`实现了TCP、UDP、SSL等协议，`aiohttp`则是基于`asyncio`实现的HTTP框架。

我们先安装`aiohttp`：

```plain
$ pip install aiohttp
```



然后编写一个HTTP服务器，分别处理以下URL：

- `/` - 首页返回`Index Page`；
- `/{name}` - 根据URL参数返回文本`Hello, {name}!`。

代码如下：

```python
# app.py
from aiohttp import web

async def index(request):
    text = "<h1>Index Page</h1>"
    return web.Response(text=text, content_type="text/html")

async def hello(request):
    name = request.match_info.get("name", "World")
    text = f"<h1>Hello, {name}</h1>"
    return web.Response(text=text, content_type="text/html")

app = web.Application()

# 添加路由:
app.add_routes([web.get("/", index), web.get("/{name}", hello)])

if __name__ == "__main__":
    web.run_app(app)
```



直接运行`app.py`，访问首页：

![Index](./assets/index.png)

访问`http://localhost:8080/Bob`：

![Hello](./assets/hello.png)

使用aiohttp时，定义处理不同URL的`async`函数，然后通过`app.add_routes()`添加映射，最后通过`run_app()`以asyncio的机制启动整个处理流程。

### Dash Plotly

Dash 是一个基于 Python 的开源框架，专门用于构建数据分析和数据可视化的 Web 应用程序。Dash 由 Plotly 团队开发，旨在帮助数据分析师、数据科学家和开发人员快速创建交互式的、基于数据的 Web 应用，而无需深入掌握前端技术（如 HTML、CSS 和 JavaScript）。Dash 的核心优势在于其简单易用性和强大的功能。通过 Dash，用户可以使用纯 Python 代码来构建复杂的 Web 应用，而无需编写繁琐的前端代码。Dash 应用通常由两个主要部分组成：**布局**和**交互性**。Dash 是它结合了 Flask 的后端能力、Plotly.js 的可视化能力以及 React.js 的交互能力，为用户提供了一个简单而强大的开发平台。

![img](https://www.runoob.com/wp-content/uploads/2025/01/2bcc0391-c369-4545-95f2-72246984cac5.png)

Dash 并不是一个完全独立的框架，而是基于以下技术构建的：

**Flask**：Dash 的后端基于 Flask，一个轻量级的 Python Web 框架。Flask 负责处理 HTTP 请求和响应。

**Plotly.js**：Dash 使用 Plotly.js 来渲染交互式图表。Plotly.js 支持多种图表类型，如折线图、柱状图、散点图、热力图等。

**React.js**：Dash 的前端组件基于 React.js，一个流行的 JavaScript 库。React.js 使得 Dash 的组件可以动态更新，而无需刷新页面。

**其他依赖**：Dash 还依赖于其他 Python 库，如 Pandas（数据处理）、NumPy（数值计算）等。

#### Dash 安装

Dash 支持 Python 3.6 及以上版本。可以通过 Python 的包管理工具 `pip` 来完成。除了核心库外，Dash 还支持一些可选依赖库，用于增强功能。

```
pip --version

pip install dash
#	dash：Dash 的核心库。
#	dash-core-components：Dash 的核心组件库（如输入框、下拉菜单、图表等）。
#	dash-html-components：Dash 的 HTML 组件库（如 div、h1、p 等）。
#	dash-table：用于显示和操作表格数据的组件。

pip install plotly #	Plotly 是 Dash 默认的图表渲染库。
pip install pandas # Pandas 是一个强大的数据处理库，常用于与 Dash 结合使用。
pip install jupyter-dash # 在 Jupyter Notebook 中使用 Dash
pip install dash-bootstrap-components 	# Dash Bootstrap Components 提供了 Bootstrap 风格的组件，用于快速构建美观的布局

python -c "import dash; print(dash.__version__)"
```

#### Dash 使用

##### Dash 组件

Dash 的核心组件可以分为两大类：`dash.html` 和 `dash.dcc`。`dash.html` 提供了 HTML 标签的 Python 封装，而 `dash.dcc` 则提供了更高级的交互式组件，如滑块、下拉菜单、图形等。

**`dash.html` 组件**： `dash.html` 模块提供了与 HTML 标签对应的 Python 类。这些类允许你以 Python 的方式编写 HTML 代码。例如，`dash.html.Div` 对应 HTML 的 `<div>` 标签，`dash.html.H1` 对应 `<h1>` 标签。

**`dash.dcc` 组件**:`dash.dcc` 模块提供了更高级的交互式组件，这些组件通常用于数据可视化和用户输入。常见的 `dash.dcc` 组件包括 `Graph`、`Dropdown`、`Slider` 等。

每个 Dash 组件都有一些属性，这些属性用于控制组件的外观和行为。例如，`dash.html.Div` 的 `children` 属性用于指定其子元素，`dash.dcc.Graph` 的 `figure` 属性用于指定图表的数据和布局。

- **children**: 用于指定组件的子元素。大多数组件都有这个属性。
- **id**: 用于唯一标识组件，通常在回调函数中使用。
- **style**: 用于设置组件的 CSS 样式。
- **className**: 用于指定组件的 CSS 类名。

| **组件**           | **说明**                                         | **示例代码**                                                 |
| :----------------- | :----------------------------------------------- | :----------------------------------------------------------- |
| **`html.Div`**     | 创建一个容器（`<div>`），用于包裹其他组件        | `html.Div(children=[html.H1("标题"), html.P("这是一个段落。")])` |
| **`html.H1`**      | 创建一级标题（`<h1>`）                           | `html.H1("一级标题")`                                        |
| **`html.H2`**      | 创建二级标题（`<h2>`）                           | `html.H2("二级标题")`                                        |
| **`html.H3`**      | 创建三级标题（`<h3>`）                           | `html.H3("三级标题")`                                        |
| **`html.P`**       | 创建段落（`<p>`）                                | `html.P("这是一个段落。")`                                   |
| **`html.Span`**    | 创建行内容器（`<span>`），用于包裹行内文本或元素 | `html.Span("这是一段行内文本。")`                            |
| **`html.Br`**      | 创建换行（`<br>`）                               | `html.Div(children=[html.P("第一行"), html.Br(), html.P("第二行")])` |
| **`html.A`**       | 创建超链接（`<a>`）                              | `html.A("点击这里访问 Dash 官网", href="https://dash.plotly.com")` |
| **`html.Img`**     | 插入图片（`<img>`）                              | `html.Img(src="https://plotly.com/assets/images/logo.png", height="50px")` |
| **`html.Ul`**      | 创建无序列表（`<ul>`）                           | `html.Ul(children=[html.Li("列表项1"), html.Li("列表项2")])` |
| **`html.Ol`**      | 创建有序列表（`<ol>`）                           | `html.Ol(children=[html.Li("第一项"), html.Li("第二项")])`   |
| **`html.Li`**      | 创建列表项（`<li>`）                             | `html.Li("列表项")`                                          |
| **`html.Button`**  | 创建按钮（`<button>`）                           | `html.Button("点击我", id='my-button')`                      |
| **`html.Label`**   | 创建标签（`<label>`），通常与输入组件一起使用    | `html.Label("用户名:"), dcc.Input(id='username', type='text')` |
| **`html.Table`**   | 创建表格（`<table>`）                            | `html.Table(children=[html.Tr(children=[html.Th("姓名"), html.Th("年龄")])])` |
| **`html.Tr`**      | 创建表格行（`<tr>`）                             | `html.Tr(children=[html.Th("姓名"), html.Th("年龄")])`       |
| **`html.Th`**      | 创建表头（`<th>`）                               | `html.Th("姓名")`                                            |
| **`html.Td`**      | 创建表格单元格（`<td>`）                         | `html.Td("张三")`                                            |
| **`html.Header`**  | 创建页眉（`<header>`）                           | `html.Header(children=[html.H1("页眉标题")])`                |
| **`html.Footer`**  | 创建页脚（`<footer>`）                           | `html.Footer(children=[html.P("版权所有 © 2023")])`          |
| **`html.Section`** | 创建章节（`<section>`）                          | `html.Section(children=[html.H2("章节标题"), html.P("章节内容")])` |
| **`html.Nav`**     | 创建导航栏（`<nav>`）                            | `html.Nav(children=[html.A("首页", href="/"), html.A("关于", href="/about")])` |
| **`html.Main`**    | 创建主要内容区域（`<main>`）                     | `html.Main(children=[html.H1("主要内容")])`                  |
| **`html.Article`** | 创建文章区域（`<article>`）                      | `html.Article(children=[html.H2("文章标题"), html.P("文章内容")])` |
| **`html.Aside`**   | 创建侧边栏（`<aside>`）                          | `html.Aside(children=[html.H2("侧边栏"), html.P("侧边栏内容")])` |
| **`html.Details`** | 创建可折叠内容（`<details>`）                    | `html.Details(children=[html.Summary("点击展开"), html.P("隐藏内容")])` |
| **`html.Summary`** | 创建可折叠内容的标题（`<summary>`）              | `html.Summary("点击展开")`                                   |



| **组件**                        | **说明**                                                     | **示例代码**                                                 |
| :------------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **`dcc.Input`**                 | 创建一个文本输入框。                                         | `dcc.Input(id='input', type='text', placeholder='请输入内容...')` |
| **`dcc.Dropdown`**              | 创建一个下拉菜单。                                           | `dcc.Dropdown(id='dropdown', options=[{'label': '选项1', 'value': '1'}], value='1')` |
| **`dcc.Slider`**                | 创建一个滑块。                                               | `dcc.Slider(id='slider', min=0, max=10, step=1, value=5)`    |
| **`dcc.Graph`**                 | 创建一个交互式图表（基于 Plotly.js）。                       | `dcc.Graph(id='graph', figure={'data': [{'x': [1, 2, 3], 'y': [4, 1, 2], 'type': 'bar'}]})` |
| **`dcc.Textarea`**              | 创建一个多行文本输入框。                                     | `dcc.Textarea(id='textarea', value='请输入多行文本...')`     |
| **`dcc.Checklist`**             | 创建一个复选框列表。                                         | `dcc.Checklist(id='checklist', options=[{'label': '选项1', 'value': '1'}], value=['1'])` |
| **`dcc.RadioItems`**            | 创建一个单选按钮组。                                         | `dcc.RadioItems(id='radio', options=[{'label': '选项1', 'value': '1'}], value='1')` |
| **`dcc.DatePickerSingle`**      | 创建一个日期选择器（单选）。                                 | `dcc.DatePickerSingle(id='date-picker', date='2023-10-01')`  |
| **`dcc.DatePickerRange`**       | 创建一个日期范围选择器。                                     | `dcc.DatePickerRange(id='date-range', start_date='2023-10-01', end_date='2023-10-07')` |
| **`dcc.Markdown`**              | 渲染 Markdown 文本。                                         | `dcc.Markdown('''# 标题\n- 列表项1''')`                      |
| **`dcc.Store`**                 | 在客户端存储数据，用于跨回调共享数据。                       | `dcc.Store(id='store', data={'key': 'value'})`               |
| **`dcc.Upload`**                | 创建一个文件上传组件。                                       | `dcc.Upload(id='upload', children=html.Div('拖放或点击上传文件'))` |
| **`dcc.Tabs`**                  | 创建选项卡组件。                                             | `dcc.Tabs(id='tabs', children=[dcc.Tab(label='标签1', value='1')])` |
| **`dcc.Tab`**                   | 创建单个选项卡（需与 `dcc.Tabs` 配合使用）。                 | `dcc.Tab(label='标签1', value='1')`                          |
| **`dcc.Interval`**              | 定时触发回调的组件。                                         | `dcc.Interval(id='interval', interval=1000)`                 |
| **`dcc.Location`**              | 用于管理 URL 的组件。                                        | `dcc.Location(id='url', pathname='/')`                       |
| **`dcc.Link`**                  | 创建一个超链接，用于页面导航（需与 `dcc.Location` 配合使用）。 | `dcc.Link('跳转到首页', href='/')`                           |
| **`dcc.ConfirmDialog`**         | 创建一个确认对话框。                                         | `dcc.ConfirmDialog(id='confirm', message='确定要执行此操作吗？')` |
| **`dcc.ConfirmDialogProvider`** | 提供一个确认对话框（需与按钮等组件配合使用）。               | `dcc.ConfirmDialogProvider(html.Button('删除'), id='confirm-provider')` |
| **`dcc.Loading`**               | 创建一个加载动画组件。                                       | `dcc.Loading(id='loading', children=[html.Div('加载中...')])` |
| **`dcc.Download`**              | 用于触发文件下载的组件。                                     | `dcc.Download(id='download')`                                |

##### Dash 回调函数

Dash 允许开发者使用Python来创建动态的、响应式的用户界面。Dash 的核心功能之一就是回调函数（Callback），它使得用户界面能够根据用户的输入或操作实时更新。回调函数是 Dash 中用于处理用户交互的核心机制，它允许你在用户与应用程序交互时，动态地更新应用程序的布局或数据。简单来说，回调函数是一个Python函数，它会在特定的输入发生变化时被触发，并根据这些输入的变化来更新输出。一个典型的 Dash 回调函数包含以下几个部分：

1. **输入（Input）**：指定哪些组件的属性变化会触发回调函数。
2. **输出（Output）**：指定回调函数执行后，哪些组件的属性会被更新。
3. **状态（State）**：可选参数，用于传递一些不会触发回调但需要在回调中使用的数据。
4. **回调函数体**：包含实际的逻辑代码，用于处理输入并生成输出。

回调函数的基本结构

```
@app.callback(
    Output(component_id='output-component', component_property='output-property'),
    Input(component_id='input-component', component_property='input-property')
)
def update_output(input_value):
    # 根据输入值计算输出值
    return output_value
```

1. **`Output`**：
   - 指定回调函数的输出目标。
   - `component_id`：目标组件的 ID。
   - `component_property`：目标组件的属性（如 `children`、`value` 等）。
2. **`Input`**：
   - 指定回调函数的输入来源。
   - `component_id`：输入组件的 ID。
   - `component_property`：输入组件的属性（如 `value`、`n_clicks` 等）。
3. **回调函数**：
   - 接收输入值，计算并返回输出值。
   - 函数名可以自定义（如 `update_output`）。

回调函数的工作原理

1. 输入与输出的绑定

在 Dash 中，回调函数的输入和输出是通过 `Input` 和 `Output` 对象来指定的。`Input` 对象指定了哪些组件的哪些属性变化会触发回调函数，而 `Output` 对象指定了回调函数执行后，哪些组件的哪些属性会被更新。

2. 回调函数的触发

当用户在界面上进行操作（例如输入文本、点击按钮等）时，相关的组件属性会发生变化。Dash 会检测到这些变化，并自动调用与之绑定的回调函数。

3. 回调函数的执行

回调函数执行时，Dash会将输入属性的当前值作为参数传递给回调函数。回调函数根据这些输入值进行计算或处理，并返回输出属性的新值。Dash会自动将返回的值更新到指定的组件属性中。

##### Dash Plotly

Dash 通过 dcc.Graph 组件与 Plotly 无缝集成，用户可以直接在 Dash 应用中嵌入 Plotly 图表。Plotly 是一个基于 JavaScript 的开源数据可视化库，支持多种编程语言，包括 Python、R、Julia 等。Plotly 提供了丰富的图表类型，如折线图、柱状图、散点图、热力图等，并且支持交互功能，如缩放、平移、悬停提示等。

Plotly Express 是 Plotly 的高级接口，能够用极简的代码创建复杂的图表。它非常适合快速原型开发。

**1、折线图 (px.line)：**

```
import plotly.express as px
df = px.data.iris()
fig = px.line(df, x='sepal_width', y='sepal_length', title='折线图示例')
```

**2、柱状图 (px.bar)：**

```
fig = px.bar(df, x='species', y='sepal_length', title='柱状图示例')
```

**3、散点图 (px.scatter)：**

```
fig = px.scatter(df, x='sepal_width', y='sepal_length', color='species', title='散点图示例')
```

**4、饼图 (px.pie)：**

```
fig = px.pie(df, names='species', values='sepal_length', title='饼图示例')
```

**5、热力图 (px.imshow)：**

```
import numpy as np
data = np.random.rand(10, 10)
fig = px.imshow(data, title='热力图示例')
```

**dcc.Graph** 是 Dash 中用于显示 Plotly 图表的组件。它的核心参数是 figure，用于指定图表的数据和布局。

**figure 参数：**

- `data`：图表的数据部分，是一个字典列表，每个字典表示一个数据系列。
- `layout`：图表的布局部分，用于设置标题、坐标轴、图例等。

```
from dash import Dash, dcc, html
import plotly.express as px
import pandas as pd

# 创建示例数据
df = pd.DataFrame({
    '城市': ['北京', '上海', '广州', '深圳'],
    '人口': [2171, 2424, 1490, 1303]
})

# 创建 Dash 应用
app = Dash(__name__)

# 使用 Plotly Express 创建柱状图
fig = px.bar(df, x='城市', y='人口', title='城市人口数据')

# 定义布局
app.layout = html.Div([
    dcc.Graph(id='example-graph', figure=fig)
])

# 运行应用
if __name__ == '__main__':
    app.run_server(debug=True)
```

#####  Dash 布局

在 Dash 中实现多页面布局可以通过 dcc.Location 和 dcc.Link 组件来实现。

dcc.Location 用于跟踪当前页面的 URL，而 dcc.Link 用于在页面之间导航。通过结合回调函数，可以根据 URL 动态加载不同的页面内容。

- 使用 `dcc.Location` 和 `dcc.Link` 可以实现多页面布局。
- 通过回调函数根据 `pathname` 动态加载页面内容。
- 结合模块化布局和 URL 参数，可以构建更复杂的多页面应用。

多页面布局的基本结构

多页面布局的核心思想是根据 URL 的路径（pathname）动态加载不同的页面内容。

以下是实现多页面布局的基本步骤：

**定义页面布局**：

- 每个页面的布局可以定义为一个函数或变量。
- 例如，`home_layout` 表示主页，`about_layout` 表示关于页面。

**使用 `dcc.Location`**：

- `dcc.Location` 组件用于跟踪当前页面的 URL。
- 通过 `pathname` 属性获取当前页面的路径。

**使用 `dcc.Link`**：

- `dcc.Link` 组件用于创建页面导航链接。
- 通过 `href` 属性指定目标页面的路径。

**动态加载页面内容**：

- 使用回调函数根据 `pathname` 动态返回对应的页面布局。

```
from dash import Dash, html, dcc, Input, Output

# 创建 Dash 应用
app = Dash(__name__)

# 定义主页布局
home_layout = html.Div([
    html.H1("主页"),
    html.P("欢迎访问主页！"),
    dcc.Link('前往关于页面', href='/about')
])

# 定义关于页面布局
about_layout = html.Div([
    html.H1("关于页面"),
    html.P("这是关于页面的内容。"),
    dcc.Link('返回主页', href='/')
])

# 定义 404 页面布局
not_found_layout = html.Div([
    html.H1("404 - 页面未找到"),
    html.P("您访问的页面不存在。"),
    dcc.Link('返回主页', href='/')
])

# 定义应用的布局
app.layout = html.Div([
    dcc.Location(id='url', refresh=False),  # 用于跟踪 URL
    html.Div(id='page-content')  # 用于动态加载页面内容
])

# 定义回调函数
@app.callback(
    Output('page-content', 'children'),  # 输出到 id 为 'page-content' 的 Div 的 children 属性
    Input('url', 'pathname')  # 输入来自 id 为 'url' 的 Location 组件的 pathname 属性
)
def display_page(pathname):
    if pathname == '/':
        return home_layout  # 显示主页
    elif pathname == '/about':
        return about_layout  # 显示关于页面
    else:
        return not_found_layout  # 显示 404 页面

# 运行应用
if __name__ == '__main__':
    app.run_server(debug=True)
```

##### Dash 样式设计

在开发交互式 Web 应用程序时，Dash 不仅允许你使用 Python 来构建复杂的应用程序，还提供了丰富的样式设计选项，使你的应用程序看起来更加专业和美观。在 Dash 中，样式设计是通过 CSS 实现的。Dash 提供了多种方式来设置组件的样式，包括：

- **内联样式**：通过 `style` 属性直接设置组件的样式。
- **外部 CSS 文件**：通过加载外部 CSS 文件设置全局样式。
- **Dash Bootstrap Components**：使用 Bootstrap 风格的组件和样式。

1. 内联样式

通过 style 属性可以直接为组件设置 CSS 样式。style 是一个字典，键是 CSS 属性，值是 CSS 值。

```
**from** dash **import** Dash, html

\# 创建 Dash 应用
app = Dash(__name__)

\# 定义布局
app.layout = html.Div(
  style={
    'backgroundColor': 'lightblue', # 背景颜色
    'padding': '20px', # 内边距
    'borderRadius': '10px', # 圆角
    'textAlign': 'center' # 文字居中
  },
  children=[
    html.H1("欢迎使用 Dash", style={'color': 'darkblue'}),
    html.P("这是一个带样式的 Div。")
  ]
)

\# 运行应用
**if** __name__ == '__main__':
  app.run_server(debug=True)
```

**运行效果：**

- 背景颜色为浅蓝色，内边距为 20px，圆角为 10px，文字居中。
- 标题文字颜色为深蓝色。

2. 外部 CSS 文件

通过加载外部 CSS 文件，可以为整个应用设置全局样式。

1. 创建一个 CSS 文件（如 `assets/styles.css`）。
2. 在 Dash 应用中加载 CSS 文件。

CSS 文件示例 (assets/styles.css)：

```
*/\* 设置全局字体 \*/*
body {
  **font-family**: Arial, sans-serif;
}

*/\* 设置标题样式 \*/*
h1 {
  **color**: darkblue;
  **text-align**: center;
}

*/\* 设置 Div 样式 \*/*
.custom-div {
  **background-color**: lightblue;
  **padding**: 20px;
  **border-radius**: 10px;
  **text-align**: center;
}

**from** dash **import** Dash, html

\# 创建 Dash 应用
app = Dash(__name__)

\# 定义布局
app.layout = html.Div(
  className='custom-div', # 使用 CSS 类名
  children=[
    html.H1("欢迎使用 Dash"),
    html.P("这是一个带样式的 Div。")
  ]
)

\# 运行应用
**if** __name__ == '__main__':
  app.run_server(debug=True)
```

**运行效果：**

- 应用加载 `assets/styles.css` 文件中的样式。
- `h1` 标题颜色为深蓝色，居中显示。
- `Div` 背景颜色为浅蓝色，带内边距和圆角。

Dash Bootstrap Components

Dash Bootstrap Components（dash-bootstrap-components）是一个第三方库，提供了 Bootstrap 风格的组件和样式。它可以帮助快速构建美观的 Dash 应用。

```
pip install dash-bootstrap-components

**from** dash **import** Dash, html
**import** dash_bootstrap_components **as** dbc

\# 创建 Dash 应用
app = Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])

\# 定义布局
app.layout = dbc.Container(
  children=[
    dbc.Row(
      dbc.Col(
        html.H1("欢迎使用 Dash Bootstrap", className="text-center text-primary")
      )
    ),
    dbc.Row(
      dbc.Col(
        dbc.Card(
          children=[
            dbc.CardHeader("卡片标题"),
            dbc.CardBody(
              children=[
                html.P("这是一个 Bootstrap 风格的卡片。", className="card-text")
              ]
            )
          ],
          className="mt-4" # 设置外边距
        )
      )
    )
  ]
)

\# 运行应用
**if** __name__ == '__main__':
  app.run_server(debug=True)
```

### Gevent

#### Greenlets

gevent中使用的主要模式是 Greenlet，这是作为C扩展模块提供给 Python 的一个轻量级协同程序。所有 greenlet 都在主程序的 OS 进程中运行，但它们是协同调度的。

操作系统在任何给定的时间内，只有一个greenlet在运行。

这不同于由 multiprocessing 或 threading 库提供的并行结构，它们这些库可以自旋进程和POSIX线程，由操作系统调度，并且真正并行的。

#### 异步和同步执行

并发性的核心思想是，可以将较大的任务分解为多个子任务的集合，这些子任务计划同时或异步运行，而不是一次或同步运行。两个子任务之间的切换称为上下文切换。

**深入探索**

编程

OS

软件

gevent中的上下文切换是通过 yielding 来完成的。在本例中，我们有两个上下文，它们通过调用 gevent.sleep(0) 相互让步。

```
import geventdef foo():    print('Running in foo')    gevent.sleep(0)    print('Explicit context switch to foo again')def bar():    print('Explicit context to bar')    gevent.sleep(0)    print('Implicit context switch back to bar')gevent.joinall([    gevent.spawn(foo),    gevent.spawn(bar),])
Running in fooExplicit context to barExplicit context switch to foo againImplicit context switch back to bar
```

当我们将 gevent 用于网络和 IO 绑定函数时，它的真正威力就来了，这些函数可以协同调度。Gevent 负责处理所有细节，以确保网络库尽可能隐式地让步出它们的 greenlet 上下文。我再怎么强调这是一个多么有力的成语也不为过。但也许可以举个例子来说明。

在这种情况下，select() 函数通常是一个阻塞调用，它轮询各种文件描述符。

```
import timeimport geventfrom gevent import selectstart = time.time()tic = lambda: 'at %1.1f seconds' % (time.time() - start)def gr1():    # Busy waits for a second, but we don't want to stick around...    print('Started Polling: %s' % tic())    select.select([], [], [], 2)                     # 可以理解成一个 IO 阻塞的操作，阻塞了2秒，这时 Greenlet 会自动切换到 gr2() 上下文执行     print('Ended Polling: %s' % tic())def gr2():    # Busy waits for a second, but we don't want to stick around...    print('Started Polling: %s' % tic())    select.select([], [], [], 2)    print('Ended Polling: %s' % tic())def gr3():    print("Hey lets do some stuff while the greenlets poll, %s" % tic())    gevent.sleep(1)    # 让当前 Greenlet 休眠1秒，上面 gr1() gr2() 阻塞操作完成后，再切换到 gr1() gr2() 的上下文执行gevent.joinall([    gevent.spawn(gr1),    gevent.spawn(gr2),    gevent.spawn(gr3),])
Started Polling: at 0.0 secondsStarted Polling: at 0.0 secondsHey lets do some stuff while the greenlets poll, at 0.0 secondsEnded Polling: at 2.0 secondsEnded Polling: at 2.0 seconds
```

另一个比较综合的例子定义了一个不确定的任务函数 (它的输出不能保证对相同的输入给出相同的结果) 。在这种情况下，运行该函数的副作用是任务暂停执行的时间是随机的。

计算机科学



```
import geventimport randomdef task(pid):    """    Some non-deterministic task    """    gevent.sleep(random.randint(0,2)*0.001)    print('Task %s done' % pid)def synchronous():    for i in range(1,10):        task(i)def asynchronous():    threads = [gevent.spawn(task, i) for i in xrange(10)]    gevent.joinall(threads)print('Synchronous:')synchronous()print('Asynchronous:')asynchronous()
Synchronous:Task 1 doneTask 2 doneTask 3 doneTask 4 doneTask 5 doneTask 6 doneTask 7 doneTask 8 doneTask 9 doneAsynchronous:Task 1 doneTask 5 doneTask 6 doneTask 2 doneTask 4 doneTask 7 doneTask 8 doneTask 9 doneTask 0 doneTask 3 done
```

在同步情况下，所有任务都是按顺序运行的，这会导致在执行每个任务时主程序阻塞(即暂停主程序的执行)。

操作系统



程序的重要部分是 gevent.spawn，它将给定的函数封装在一个 Greenlet 线程中。初始化的 greenlet 列表存储在传递给 gevent 的数组线程中。gevent.joinall 函数，它会阻塞当前程序，来运行所有给定的 greenlet。只有当所有 greenlet 终止时，执行才会继续进行。

需要注意的是，异步情况下的执行顺序本质上是随机的，异步情况下的总执行时间比同步情况下少得多。实际上，同步的例子完成的最大时间是每个任务停顿0.002秒，导致整个队列停顿0.02秒。在异步情况下，最大运行时间大约为0.002秒，因为没有一个任务会阻塞其他任务的执行。

在更常见的用例中，异步地从服务器获取数据，fetch() 的运行时在请求之间会有所不同，这取决于请求时远程服务器上的负载。

```
import gevent.monkeygevent.monkey.patch_socket()# 把内置的阻塞的 socket替换成非阻塞的socketimport geventimport urllib2import simplejson as jsondef fetch(pid):    response = urllib2.urlopen('http://json-time.appspot.com/time.json')    result = response.read()    json_result = json.loads(result)    datetime = json_result['datetime']    print('Process %s: %s' % (pid, datetime))    return json_result['datetime']def synchronous():    for i in range(1,10):        fetch(i)def asynchronous():    threads = []    for i in range(1,10):        threads.append(gevent.spawn(fetch, i))    gevent.joinall(threads)print('Synchronous:')synchronous()print('Asynchronous:')asynchronous()
```

#### 确定性

如前所述，greenlet 是确定的。给定相同的 greenlet 配置和相同的输入集，它们总是产生相同的输出。例如，让我们将一个任务分散到一个多进程（multiprocessing）池中，并将其结果与一个gevent池的结果进行比较。

Linux 与 Unix



```
import timedef echo(i):    time.sleep(0.001)    return i# Non Deterministic Process Poolfrom multiprocessing.pool import Poolp = Pool(10)run1 = [a for a in p.imap_unordered(echo, xrange(10))]          # imap_unordered 返回一个顺序随机的 iterable 对象run2 = [a for a in p.imap_unordered(echo, xrange(10))]run3 = [a for a in p.imap_unordered(echo, xrange(10))]run4 = [a for a in p.imap_unordered(echo, xrange(10))]print(run1 == run2 == run3 == run4)# Deterministic Gevent Poolfrom gevent.pool import Poolp = Pool(10)run1 = [a for a in p.imap_unordered(echo, xrange(10))]      # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]run2 = [a for a in p.imap_unordered(echo, xrange(10))]      # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]run3 = [a for a in p.imap_unordered(echo, xrange(10))]      # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]run4 = [a for a in p.imap_unordered(echo, xrange(10))]      # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]print(run1 == run2 == run3 == run4)
FalseTrue
```

尽管 gevent 通常是确定的，但当您开始与外部服务(如 socket 和文件)进行交互时，非确定性的来源可能会潜入您的程序。因此，即使 green 线程是确定性并发的一种形式，它们仍然会遇到POSIX线程和进程遇到的一些相同的问题。

操作系统



与并发有关的长期问题称为竞争条件。简而言之，当两个并发线程/进程依赖于某些共享资源但还试图修改该值时，就会发生竞争状态。这将导致资源的值变得依赖于执行顺序。这是一个问题，一般来说，应该尽量避免竞态条件，因为它们会导致全局的不确定程序行为。

最好的方法是在任何时候都避免所有全局状态。全局状态和导入时间的副作用总是会回来咬你一口

#### 生成 Greenlets

gevent提供了一些关于Greenlet初始化的包装器。一些最常见的模式是：

```
import geventfrom gevent import Greenletdef foo(message, n):    """    Each thread will be passed the message, and n arguments    in its initialization.    """    gevent.sleep(n)    print(message)# Initialize a new Greenlet instance running the named function# foothread1 = Greenlet.spawn(foo, "Hello", 1)# Wrapper for creating and running a new Greenlet from the named# function foo, with the passed argumentsthread2 = gevent.spawn(foo, "I live!", 2)# Lambda expressionsthread3 = gevent.spawn(lambda x: (x+1), 2)threads = [thread1, thread2, thread3]# Block until all threads complete.gevent.joinall(threads)
HelloI live!
```

除了使用基本的Greenlet类，您还可以子类化 Greenlet 类并覆盖 _run 方法。

Linux 与 Unix



```
import geventfrom gevent import Greenletclass MyGreenlet(Greenlet):    def __init__(self, message, n):        Greenlet.__init__(self)        self.message = message        self.n = n    def _run(self):        print(self.message)        gevent.sleep(self.n)g = MyGreenlet("Hi there!", 3)g.start()g.join()
Hi there!
```

#### Greenlets 状态

与代码的其他部分一样，greenlet可能以各种方式失败。greenlet可能无法抛出异常、无法停止或消耗太多系统资源。

greenlet 的内部状态通常是一个与时间相关的参数。在greenlets上有许多标志，它们允许您监视线程的状态：

started — 布尔值，指示Greenlet是否已启动

ready() — 布尔值，指示Greenlet是否已停止

successful() — 布尔值，指示Greenlet是否已停止且没有抛出异常

value — Greenlet返回的值

exception — 异常，在greenlet中抛出的未捕获异常实例

```
import geventdef win():    return 'You win!'def fail():    raise Exception('You fail at failing.')winner = gevent.spawn(win)loser = gevent.spawn(fail)print(winner.started) # Trueprint(loser.started)  # True# Exceptions raised in the Greenlet, stay inside the Greenlet.try:    gevent.joinall([winner, loser])except Exception as e:    print('This will never be reached')print(winner.value) # 'You win!'print(loser.value)  # Noneprint(winner.ready()) # Trueprint(loser.ready())  # Trueprint(winner.successful()) # Trueprint(loser.successful())  # False# The exception raised in fail, will not propagate outside the# greenlet. A stack trace will be printed to stdout but it# will not unwind the stack of the parent.print(loser.exception)# It is possible though to raise the exception again outside# raise loser.exception# or with# loser.get()
TrueTrueYou win!NoneTrueTrueTrueFalseYou fail at failing.
```

#### 程序关闭

当主程序接收到SIGQUIT时，无法生成（yield）的 greenlet 可能会使程序的执行时间比预期的更长。这将导致所谓的“僵尸进程”，需要从 Python 解释器外部杀死这些进程。

操作系统



一种常见的模式是监听主程序上的SIGQUIT事件并在退出前调用 gevent.shutdown 。

```
import geventimport signaldef run_forever():    gevent.sleep(1000)if __name__ == '__main__':    gevent.signal(signal.SIGQUIT, gevent.kill)    thread = gevent.spawn(run_forever)    thread.join()
```

#### 超时

超时是对代码块或Greenlet的运行时的约束。

```
import geventfrom gevent import Timeoutseconds = 10timeout = Timeout(seconds)timeout.start()def wait():    gevent.sleep(10)try:    gevent.spawn(wait).join()except Timeout:    print('Could not complete')
```

在with语句中，它们还可以与上下文管理器一起使用。

脚本语言



```
import geventfrom gevent import Timeouttime_to_wait = 5 # secondsclass TooLong(Exception):    passwith Timeout(time_to_wait, TooLong):    gevent.sleep(10)
```

此外，gevent 还为各种 Greenlet 和数据结构相关的调用提供超时参数。例如：

```
import geventfrom gevent import Timeoutdef wait():    gevent.sleep(2)timer = Timeout(1).start()thread1 = gevent.spawn(wait)try:    thread1.join(timeout=timer)except Timeout:    print('Thread 1 timed out')# --timer = Timeout.start_new(1)thread2 = gevent.spawn(wait)try:    thread2.get(timeout=timer)except Timeout:    print('Thread 2 timed out')# --try:    gevent.with_timeout(1, wait)except Timeout:    print('Thread 3 timed out')
Thread 1 timed outThread 2 timed outThread 3 timed out
```

#### 猴子补丁

我们来到了Gevent的黑暗角落。到目前为止，我一直避免提到monkey patching，以尝试和激发强大的协同模式，但是现在是讨论monkey patching的黑魔法的时候了。 如果您注意到上面我们调用了命令 monkey.patch_socket()，这是一个纯粹用于修改标准库套接字库(socket)的副作用命令。

计算机科学



```
import socketprint(socket.socket)print("After monkey patch")from gevent import monkeymonkey.patch_socket()print(socket.socket)import selectprint(select.select)monkey.patch_select()print("After monkey patch")print(select.select)
class 'socket.socket'After monkey patchclass 'gevent.socket.socket'built-in function selectAfter monkey patchfunction select at 0x1924de8
```

Python 允许在运行时修改大多数对象，包括模块、类甚至函数。这通常是一个令人震惊的坏主意，因为它创建了一个“隐式副作用”，如果出现问题，通常非常难以调试，然而在极端情况下，库需要改变Python本身的基本行为，可以使用monkey补丁。在这种情况下，gevent能够修补标准库中的大多数阻塞系统调用，包括 socket、ssl、threading 和 select 模块中的调用。

脚本语言



例如，Redis-python 的绑定通常使用常规tcp socket与Redis-server实例通信。只需调用gevent.monkey.patch_all()，我们可以让redis绑定协同调度请求，并与gevent堆栈的其他部分一起工作。

这让我们可以在不编写任何代码的情况下集成通常无法与gevent一起工作的库。（尽管猴子补丁仍然是邪恶的，但在这种情况下，它是“有用的邪恶”。）

#### 数据结构

##### 事件

事件是greenlet之间异步通信的一种形式。

```
import geventfrom gevent.event import Event'''Illustrates the use of events'''evt = Event()def setter():    '''After 3 seconds, wake all threads waiting on the value of evt'''    print('A: Hey wait for me, I have to do something')    gevent.sleep(3)    print("Ok, I'm done")    evt.set()   # 运行到evt.set()会将flag设置为True，然后另外两个被阻塞的waitter的evt.wait()方法在看到flag已经为True之后不再继续阻塞运行并且结束。def waiter():    '''After 3 seconds the get call will unblock'''    print("I'll wait for you")    evt.wait()  # blocking    print("It's about time")def main():    gevent.joinall([        gevent.spawn(setter),        gevent.spawn(waiter),        gevent.spawn(waiter),        gevent.spawn(waiter),        gevent.spawn(waiter),        gevent.spawn(waiter)    ])if __name__ == '__main__': main()
```

事件对象的扩展是 AsyncResult，它允许您在唤醒调用时发送一个值。这有时被称为future或deferred，因为它有对 future 值的引用，可以在任意的时间设置该值。

计算机科学



```
import geventfrom gevent.event import AsyncResulta = AsyncResult()def setter():    """    After 3 seconds set the result of a.    """    gevent.sleep(3)    a.set('Hello!')def waiter():    """    After 3 seconds the get call will unblock after the setter    puts a value into the AsyncResult.    """    print(a.get())gevent.joinall([    gevent.spawn(setter),    gevent.spawn(waiter),])
```

##### 队列

队列是按顺序排列的数据集，它们具有通常的 put / get 操作，但可以在Greenlets上安全操作的方式编写。

脚本语言



例如，如果一个Greenlet从队列中获取一个项目(item)，则同一项目(item)不会被同时执行的另一个Greenlet获取。

```
import geventfrom gevent.queue import Queuetasks = Queue()def worker(n):    while not tasks.empty():        task = tasks.get()        print('Worker %s got task %s' % (n, task))        gevent.sleep(0)    print('Quitting time!')def boss():    for i in xrange(1,25):        tasks.put_nowait(i)gevent.spawn(boss).join()gevent.joinall([    gevent.spawn(worker, 'steve'),    gevent.spawn(worker, 'john'),    gevent.spawn(worker, 'nancy'),])
Worker steve got task 1Worker john got task 2Worker nancy got task 3Worker steve got task 4Worker john got task 5Worker nancy got task 6Worker steve got task 7Worker john got task 8Worker nancy got task 9Worker steve got task 10Worker john got task 11Worker nancy got task 12Worker steve got task 13Worker john got task 14Worker nancy got task 15Worker steve got task 16Worker john got task 17Worker nancy got task 18Worker steve got task 19Worker john got task 20Worker nancy got task 21Worker steve got task 22Worker john got task 23Worker nancy got task 24Quitting time!Quitting time!Quitting time!
```

根据需要，队列还可以在put或get上阻塞。

每个put和get操作都有一个非阻塞的对应操作，put_nowait 和 get_nowait 不会阻塞。如果操作是不可能的，会引发 gevent.queue.Empty 或 gevent.queue.Full

在这个例子中，我们让boss同时和workers运行，并且对队列有一个限制，防止它包含三个以上的元素。这个限制意味着put操作将阻塞，直到队列上有空间为止。相反，如果队列上没有要获取的元素，get操作就会阻塞，它还会接受一个超时参数，如果在超时的时间范围内找不到工作(work)，则允许队列以异常 gevent.queue.Empty 退出。

```
import geventfrom gevent.queue import Queue, Emptytasks = Queue(maxsize=3)def worker(name):    try:        while True:            task = tasks.get(timeout=1) # decrements queue size by 1            print('Worker %s got task %s' % (name, task))            gevent.sleep(0)    except Empty:        print('Quitting time!')def boss():    """    Boss will wait to hand out work until a individual worker is    free since the maxsize of the task queue is 3.    """    for i in xrange(1,10):        tasks.put(i)                            # 输入1，2，3，到4时，队列达到最大值，put方法阻塞，gevent 切换到下一个协程worker（steve）    print('Assigned all work in iteration 1')    for i in xrange(10,20):        tasks.put(i)    print('Assigned all work in iteration 2')gevent.joinall([    gevent.spawn(boss),    gevent.spawn(worker, 'steve'),    gevent.spawn(worker, 'john'),    gevent.spawn(worker, 'bob'),])
Worker steve got task 1Worker john got task 2Worker bob got task 3Worker steve got task 4Worker john got task 5Worker bob got task 6Assigned all work in iteration 1Worker steve got task 7Worker john got task 8Worker bob got task 9Worker steve got task 10Worker john got task 11Worker bob got task 12Worker steve got task 13Worker john got task 14Worker bob got task 15Worker steve got task 16Worker john got task 17Worker bob got task 18Assigned all work in iteration 2Worker steve got task 19Quitting time!Quitting time!Quitting time!
```

##### 分组和池

组是运行中的greenlet的集合，这些greenlet作为组一起管理和调度。它还兼做并行调度程序，借鉴 Python multiprocessing 库。

脚本语言



```
import geventfrom gevent.pool import Groupdef talk(msg):    for i in xrange(3):        print(msg)g1 = gevent.spawn(talk, 'bar')g2 = gevent.spawn(talk, 'foo')         g3 = gevent.spawn(talk, 'fizz')  group = Group()group.add(g1)                           group.join()                      # 修改了官方的例子，这里join只会让当前线程等待g1，但g2和g3已经被启动，会被继续安排执行
barbarbarfoofoofoofizzfizzfizz
```

这对于管理异步任务组非常有用。

计算机科学



如上所述，Group还提供了一个API，用于将作业分派给分组的greenlet并以各种方式收集它们的结果。

```
import geventfrom gevent import getcurrentfrom gevent.pool import Groupgroup = Group()def hello_from(n):    print('Size of group %s' % len(group))    print('Hello from Greenlet %s' % id(getcurrent()))group.map(hello_from, xrange(3))def intensive(n):    gevent.sleep(3 - n)    return 'task', nprint('Ordered')ogroup = Group()for i in ogroup.imap(intensive, xrange(3)):    print(i)print('Unordered')igroup = Group()for i in igroup.imap_unordered(intensive, xrange(3)):    print(i)
Size of group 3Hello from Greenlet 4340152592Size of group 3Hello from Greenlet 4340928912Size of group 3Hello from Greenlet 4340928592Ordered('task', 0)('task', 1)('task', 2)Unordered('task', 2)('task', 1)('task', 0)
```

池是一种结构，用于处理需要限制并发的动态数量的greenlets。在需要并行执行许多网络或IO绑定任务的情况下，这通常是可取的。

```
import geventfrom gevent.pool import Poolpool = Pool(2)def hello_from(n):    print('Size of pool %s' % len(pool))pool.map(hello_from, xrange(3))
Size of pool 2Size of pool 2Size of pool 1
```

通常在构建gevent驱动的服务时，会将整个服务围绕一个池结构进行中心处理。一个例子可能是在各种套接字（socket）上轮询的类。

```
from gevent.pool import Poolclass SocketPool(object):    def __init__(self):        self.pool = Pool(1000)        self.pool.start()    def listen(self, socket):        while True:            socket.recv()    def add_handler(self, socket):        if self.pool.full():            raise Exception("At maximum pool size")        else:            self.pool.spawn(self.listen, socket)    def shutdown(self):        self.pool.kill()
```

##### 锁和信号量

信号量是一种低级同步原语，它允许greenlet协调和限制并发访问或执行。信号量公开两种方法，获取和释放信号量被获取和释放的次数之差称为信号量的界限。如果信号量范围达到0，它就会阻塞，直到另一个greenlet释放它的捕获。

```
from gevent import sleepfrom gevent.pool import Poolfrom gevent.coros import BoundedSemaphoresem = BoundedSemaphore(2)def worker1(n):    sem.acquire()    print('Worker %i acquired semaphore' % n)    sleep(0)    sem.release()    print('Worker %i released semaphore' % n)def worker2(n):    with sem:        print('Worker %i acquired semaphore' % n)        sleep(0)    print('Worker %i released semaphore' % n)pool = Pool()pool.map(worker1, xrange(0,2))pool.map(worker2, xrange(3,6))
Worker 0 acquired semaphoreWorker 1 acquired semaphoreWorker 0 released semaphoreWorker 1 released semaphoreWorker 3 acquired semaphoreWorker 4 acquired semaphoreWorker 3 released semaphoreWorker 4 released semaphoreWorker 5 acquired semaphoreWorker 5 released semaphore
```

界限为1的信号量称为锁。它提供对一个greenlet的独占执行。它们通常用于确保资源只在程序上下文中使用一次。

## Python项目管理

### 包管理与环境管理

#### Pip

pip 是 Python 包管理工具，该工具提供了对Python 包的查找、下载、安装、卸载的功能。目前如果你在 [python.org](https://www.python.org/) 下载最新版本的安装包，则是已经自带了该工具。

你可以通过以下命令来判断是否已安装：

```
pip --version     # Python2.x 版本命令
pip3 --version    # Python3.x 版本命令
```

如果你还未安装，则可以使用以下方法来安装：

```
$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py   # 下载安装脚本
$ sudo python get-pip.py    # 运行安装脚本
```

> **注意：**用哪个版本的 Python 运行安装脚本，pip 就被关联到哪个版本，如果是 Python3 则执行以下命令：
>
> ```
> $ sudo python3 get-pip.py    # 运行安装脚本。
> ```
>
> 一般情况 pip 对应的是 Python 2.7，pip3 对应的是 Python 3.x。

部分 Linux 发行版可直接用包管理器安装 pip，如 Debian 和 Ubuntu：

```
sudo apt-get install python-pip
```

##### pip 最常用命令

**显示版本和路径**

```
pip --version
```

**获取帮助**

```
pip --help
```

**升级 pip**

```
pip install -U pip
```

> 如果这个升级命令出现问题 ，可以使用以下命令：
>
> ```
> sudo easy_install --upgrade pip
> ```

**安装包**

```
pip install SomePackage              # 最新版本
pip install SomePackage==1.0.4       # 指定版本
pip install 'SomePackage>=1.0.4'     # 最小版本
```

比如我要安装 Django。用以下的一条命令就可以，方便快捷。

```
pip install Django==1.7
```

**升级包**

```
pip install --upgrade SomePackage
```

升级指定的包，通过使用==, >=, <=, >, < 来指定一个版本号。

**卸载包**

```
pip uninstall SomePackage
```

**搜索包**

```
pip search SomePackage
```

**显示安装包信息**

```
pip show 
```

**查看指定包的详细信息**

```
pip show -f SomePackage
```

**列出已安装的包**

```
pip list
```

**查看可升级的包**

```
pip list -o
```

##### pip 升级

**Linux 或 macOS**

```
pip install --upgrade pip    # python2.x
pip3 install --upgrade pip   # python3.x
```

**Windows 平台升级：**

```
python -m pip install -U pip   # python2.x
python -m pip3 install -U pip    # python3.x
```

##### pip 清华大学开源软件镜像站

使用国内镜像速度会快很多：

临时使用：

```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
```

例如，安装 Django：

```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple Django
```

如果要设为默认需要升级 pip 到最新的版本 (>=10.0.0) 后进行配置：

```
pip install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

如果您到 pip 默认源的网络连接较差，临时使用本镜像站来升级 pip：

```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
```

#### UV

uv 是由 Astral 公司开发的一款 Rust 编写的 Python 包管理器和环境管理器，它的主要目标是提供比现有工具快 10-100 倍的性能，同时保持简单直观的用户体验。uv 可以替代 pip、virtualenv、pip-tools 等工具，提供依赖管理、虚拟环境创建、Python 版本管理等一站式服务。

##### 安装 uv

**在 Linux 上安装**

```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**在 Windows 上安装**

使用 Winget：

```
winget install uv
```

或者使用官方安装脚本：

```
irm https://astral.sh/uv/install.ps1 | iex
```

安装完成后，验证安装是否成功：

```
uv --version
```

输出内容类似如下，表明安装成功：

```
uv 0.8.14 (Homebrew 2025-08-28)
```

------

##### 基本使用指南

**管理 Python 版本**

uv 可以轻松管理多个 Python 版本，无需额外安装 pyenv 等工具。

查看可用的 Python 版本：

```
uv python list
```

输出结果类似如下：

```
cpython-3.14.0rc2-macos-aarch64-none                 <download available>
cpython-3.14.0rc2+freethreaded-macos-aarch64-none    <download available>
cpython-3.13.7-macos-aarch64-none                    <download available>
cpython-3.13.7+freethreaded-macos-aarch64-none       <download available>
cpython-3.12.11-macos-aarch64-none                   <download available>
cpython-3.11.13-macos-aarch64-none                   <download available>
cpython-3.10.18-macos-aarch64-none                   <download available>
cpython-3.9.23-macos-aarch64-none                    <download available>
cpython-3.9.6-macos-aarch64-none                     /usr/bin/python3
cpython-3.8.20-macos-aarch64-none                    <download available>
pypy-3.11.13-macos-aarch64-none                      <download available>
```

安装特定版本的 Python：

```
# 安装最新的 Python 3.12
uv python install 3.12

# 安装特定版本
uv python install 3.11.6

# 安装 PyPy 版本
uv python install pypy3.10
```

设置全局默认 Python 版本：

```
uv python default 3.12
```

**管理虚拟环境**

创建并激活虚拟环境：

```
# 创建名为 .venv 的虚拟环境（默认）
uv venv

# 激活环境（macOS/Linux）
source .venv/bin/activate

# 激活环境（Windows）
.venv\Scripts\activate
```

在项目中指定 Python 版本：

```
# 为当前项目固定 Python 3.11
uv python pin 3.11
```

这会创建 .python-version 文件，标识项目所需的 Python 版本。

**包管理**

安装包：

```
# 安装最新版本
uv pip install requests

# 安装特定版本
uv pip install requests==2.31.0

# 从 requirements.txt 安装
uv pip install -r requirements.txt
```

安装包到开发环境：

```
uv pip install --dev pytest
```

升级包：

```
uv pip upgrade requests
```

卸载包：

```
uv pip uninstall requests
```

导出依赖：

```
# 导出当前环境的依赖
uv pip freeze > requirements.txt

# 导出生产环境依赖（排除开发依赖）
uv pip freeze --production > requirements.txt
```

**项目管理**

uv 支持 pyproject.toml 格式的项目管理，这是现代 Python 项目的标准配置文件。

初始化一个新项目：

```
uv init my_project
cd my_project
```

这会创建基本的项目结构和 pyproject.toml 文件。

安装项目的依赖：

```
uv sync
```

这个命令会根据 pyproject.toml 和 requirements.txt 安装所有依赖，类似于 **pip install -e .** 但更高效。

> **说明：**
>
> uv sync 是一个依赖管理命令，它的作用类似于您可能更熟悉的 pip install -r requirements.txt，但更快、更强大、更可靠。
>
> 您可以把它理解为："一键安装这个项目正常运行所需的所有第三方软件包（依赖库）"。
>
> uv sync 如果安装太慢，可以设置国内镜像源 https://pypi.tuna.tsinghua.edu.cn/simple：
>
> 在项目根目录的 pyproject.toml 文件 [tool.uv] 处设置 index-url：
>
> ```
> [tool.uv]
> index-url = "https://pypi.tuna.tsinghua.edu.cn/simple"
> ```

##### uv 的优势

- 速度极快：由于使用 Rust 编写，uv 的性能远超 pip 和其他包管理工具，安装依赖的速度可以提升 10-100 倍。
- 功能集成：集成语法分析、依赖解析、包安装、环境管理和 Python 版本管理于一体，无需再安装和学习多个工具。
- 确定性构建：uv 会生成 uv.lock 文件，确保在任何环境中都能安装完全相同的依赖版本，避免 "在我机器上能运行" 的问题。
- 与现有工具兼容：uv 可以处理 requirements.txt 和 pyproject.toml，可以无缝替代现有工作流中的 pip。

##### 迁移到 uv

如果你正在使用其他工具，可以轻松迁移到 uv：对于使用 pip + virtualenv 的项目：

```
# 创建并激活 uv 虚拟环境
uv venv
source .venv/bin/activate

# 安装依赖
uv pip install -r requirements.txt
```

对于使用 pip-tools 的项目：

```
uv pip compile requirements.in -o requirements.txt
uv pip sync
```

对于使用 poetry 或 pdm 的项目：

```
# 直接使用现有的 pyproject.toml
uv sync
```

#### Conda

Anaconda 是一个数据科学和机器学习的软件套装，它包含了许多工具和库，让您能够更轻松地进行编程、分析数据和构建机器学习模型。Anaconda 包及其依赖项和环境的管理工具为 **conda** 命令，文章后面部分会详细介绍。与传统的 **Python pip** 工具相比 Anaconda 的**conda** 可以更方便地在不同环境之间进行切换，环境管理较为简单。除了界面操作，我们还可以在命令行使用 conda 来管理不同环境。**conda** 是 Anaconda 发行版中的包管理器，用于安装、更新、卸载软件包，以及创建和管理不同的 Python 环境。

以下是一些常用的Conda命令及其简要介绍：

**环境管理**

**创建一个名为 "myenv" 的新环境:**

```
conda create --name myenv
```

**创建指定版本的环境**：

```
conda create --name myenv python=3.8
```

以上代码创建一个名为 "myenv" 的新环境，并指定 Python 版本为 3.8。

**激活环境：**

```
conda activate myenv
```

以上代码激活名为 "myenv" 的环境。

**要退出当前环境使用以下命令：**

```
deactivate
```

**查看所有环境：**

```
conda env list
```

以上代码查看所有已创建的环境。

**复制环境：**

```
conda create --name myclone --clone myenv
```

以上代码通过克隆已有环境创建新环境。

**删除环境：**

```
conda env remove --name myenv
```

以上代码删除名为 "myenv" 的环境。

**包管理**

**安装包：**

```
conda install package_name
```

以上代码安装名为 "package_name" 的软件包。

**安装指定版本的包：**

```
conda install package_name=1.2.3
```

以上代码安装 "package_name" 的指定版本。

**更新包：**

```
conda update package_name
```

以上代码更新已安装的软件包。

**卸载包：**

```
conda remove package_name
```

以上代码卸载已安装的软件包。

**查看已安装的包：**

```
conda list
```

查看当前环境下已安装的所有软件包及其版本。

**其他常用命令**

**查看帮助：**

```
conda --help
```

以上代码获取 conda 命令的帮助信息。

**查看 conda 版本：**

```
conda --version
```

以上代码查看安装的 conda 版本。

**搜索包：**

```
conda search package_name
```

以上代码在 conda 仓库中搜索指定的软件包。

**清理不再需要的包：**

```
conda clean --all
```

以上代码清理 conda 缓存，删除不再需要的软件包。

**安装 Jupyter Notebook：**

```
conda install jupyter
```

以上代码安装 Jupyter Notebook。

**启动 Jupyter Notebook：**

```
jupyter notebook
```

以上代码在已激活的环境中启动 Jupyter Notebook。

#### venv

Python 虚拟环境（Virtual Environment）是一个独立的 Python 运行环境，它允许你在同一台机器上为不同的项目创建隔离的 Python 环境。每个虚拟环境都有自己的：Python 解释器、安装的包/库、环境变量。从机制上看，虚拟环境主要改变的是 Python 的包搜索路径，让 `site-packages` 指向项目自己的目录，同时提供一组指向特定解释器的可执行入口。工程上把依赖显式写进项目配置并锁定版本，才能保证 CI、同事、本地和线上在同一套依赖集合上运行，问题才可复现。

Python 有相当多的虚拟环境管理工具，比如 uv ，venv，conda等等。这里我们以venv这种轻量级管理工具做虚拟环境设置，Python 3.3+ 内置了 `venv` 模块，无需额外安装。

```python
# 虚拟环境
## 创建虚拟环境 
## 表示启动venv模块创建一个 env_name 的虚拟环境
python3 -m venv env_name
## 激活虚拟环境
.venv\Scripts\activate # Windows
source .venv/bin/activate # Linux
## 激活成功后会出现环境名 
(.venv) $
## 退出虚拟环境
deactivate
## 删除虚拟环境 删除对应目录即可
rm -rf .venv  # Linux/macOS
del /s /q .venv  # Windows (命令提示符)

# 版本与依赖管理
python3.8 -m venv .venv  # 使用 Python 3.8
python -m venv --without-pip env_name # 创建不带pip的虚拟环境
python -m venv --system-site-packages env_name # 创建继承系统包的虚拟环境
```

### 配置管理

#### pyproject.toml

Python从[PEP 518](https://link.zhihu.com/?target=https%3A//peps.python.org/pep-0518/)开始引入的使用pyproject.toml管理项目元数据的方案。

该规范目前已经在很多开源项目中得以支持：

- [Django](https://zhida.zhihu.com/search?content_id=236166208&content_type=Article&match_order=1&q=Django&zhida_source=entity) 这个 Python 生态的顶级项目在 5 个月之前开始使用 pyproject.toml

- [Pytest](https://zhida.zhihu.com/search?content_id=236166208&content_type=Article&match_order=1&q=Pytest&zhida_source=entity) 这个 Python 生态测试框架的领头羊在 4 个月之前开始使用 pyproject.toml

- [SciPy](https://zhida.zhihu.com/search?content_id=236166208&content_type=Article&match_order=1&q=SciPy&zhida_source=entity) 这机器学习的库也在 3 周前切到了 pyproject.toml

- [poetry](https://zhida.zhihu.com/search?content_id=236166208&content_type=Article&match_order=1&q=poetry&zhida_source=entity)包管理可以直拉生成toml文件

##### 工程结构

[PyPI](https://zhida.zhihu.com/search?content_id=236166208&content_type=Article&match_order=1&q=PyPI&zhida_source=entity) 的旧时代的因为规范太松散了，每个项目的结构都五花八门。现在好了，pyproject.toml 它在 Python 项目的结构上都有一个推荐风式了。假设我们软件包的名字是 npts ，那么整个项目的目录结构在推荐的风格下看起来应该像这样。

假设我们软件包的名字是 npts ，那么整个项目的目录结构在推荐的风格下看起来应该像这样。

```text
tree ./ ./ 
├── LICENSE 
├── README.md 
├── pyproject.toml 
├── src 
│ └── npts # src 下面是包名，包下面是业务代码 
│      ├── __init__.py 
|      └── core.py 
└── tests 3 directories, 5 files
```

> 3 directories, 5 files

简单地在 src/npts/core.py 加一个函数，模拟我们的业务逻辑。

```text
# -*- coding: utf8 -*- 
def hello(name: str = "world"): 
    return f"hello {name} ."
```

##### pyproject.toml

```text
[project] 
name = "npts"
version = "0.0.1" 

[build-system] 
requires = ["hatchling"] 
build-backend = "hatchling.build"
```

##### 安装 build 依赖并用 build 来打包

```text
# 安装依赖
python3 -m pip install --upgrade build

# 打包
python3 -m build
# ...
#... ... Successfully built npts-0.0.1.tar.gz and npts-0.0.1-py2.py3-none-any.whl
```

- 编译过程中，会产生如下的输出信息：

![img](./assets/v2-236f893c1593912e93bdc50f3410bbc4_1440w.jpg)



- 该命令执行完后，会在dist目录中生成如下红框内的文件：

![img](./assets/v2-4d31ec387ad820b6ba5b6e94e53e093b_1440w.jpg)

其中，`tar.gz`文件是源发行版`a source distribution `，而`.whl`文件是构建发行版`a built distribution`。

##### 把打包好的软件包上传到 PyPI

```text
twine upload dist/npts-0.0.1-py3-none-any.whl
或 
poetry -m publish #上传发布
```

##### 安装包

```text
pip3 install npts
```

##### pyproject.toml 完整参数说明

```text
[tool.poetry] # 是最基本的section，然后它由多个 sections 组成

name #package 名字，必填
version #package 版本号  ，必填
description #package 描述  ，必填
license #package 许可证，可选
authors #package 作者，必填
maintainers #package 维护者，可选
readme #package readme 文件，可选
README.rst 或 README.md
homepage #package 项目网站的 URL，可选
repository #package 指向项目 repository 的 URL，可选
documentation #package 项目文档的 URL，可选

keywords #与 package 相关的关键字列表(最多5个)，可选

[dependencies] and [dev-dependencies]
# 默认情况下，poetry 会从 Pypi 库中查找依赖项，只需要写名称、版本就行了

[tool.poetry.dependencies]
python = "^3.9" # 重点：必须声明与包兼容的python版本 python = "^3.9" 
requests = "^2.26.0"

[[tool.poetry.source]] # 使用私有存储库
name = 'private'
url = 'http://example.com/simple'

[extras] #支持可选依赖项
...

[tool.poetry.dependencies] # 这些软件包是强制性的
mandatory = "^1.0"
psycopg2 = { version = "^2.7", optional = true }    # 可选依赖项列表，可自行选择安装哪些
mysqlclient = { version = "^1.3", optional = true }
 
[tool.poetry.extras] 
mysql = ["mysqlclient"]
pgsql = ["psycopg2"]
```

> 当需要安装可选依赖库时
> poetry install --extras "mysql pgsql" poetry install -E mysql -E pgsql

### 类型推断

#### typing

`typing` 是 Python 标准库的一部分，用来写类型标注，比如 `list[int]`、`dict[str, int]`、`Optional[str]`、`TypedDict`、`Protocol`、`Literal` 等。**typing常用类型**

以下是typing包中常用的类型和泛型。

注意，int, float,bool,str, bytes不需要import typing，Any,Union,Tuple等需要import typing

**基本类型:**

- int: 整数类型
- float: 浮点数类型
- bool: 布尔类型
- str: 字符串类型
- bytes: 字节类型
- Any: 任意类型
- Union: 多个类型的联合类型，表示可以是其中任意一个类型
- Tuple: 固定长度的元组类型
- List: 列表类型
- Dict: 字典类型，用于键值对的映射

**泛型:**

- Generic: 泛型基类，用于创建泛型类或泛型函数
- TypeVar: 类型变量，用于创建表示不确定类型的占位符
- Callable: 可调用对象类型，用于表示函数类型
- [Optional](https://zhida.zhihu.com/search?content_id=229764108&content_type=Article&match_order=1&q=Optional&zhida_source=entity): 可选类型，表示一个值可以为指定类型或None
- Iterable: 可迭代对象类型
- Mapping: 映射类型，用于表示键值对的映射
- Sequence: 序列类型，用于表示有序集合类型
- Type:泛型类，用于表示类型本身

fun1里，标明了形参和返回值的类型，fun2中却没有。

```text
from typing import List, Tuple, Dict

def fun1(a0: int, s0: str, f0: float, b0: bool) -> Tuple[List, Tuple, Dict, bool]:
    list1 = list(range(a0))
    tup1 = (a0, s0, f0, b0)
    dict1 = {s0: f0}
    b1 = b0
    return list1, tup1, dict1, b1

def fun2(a0, s0, f0, b0):
    list1 = list(range(a0))
    tup1 = (a0, s0, f0, b0)
    dict1 = {s0: f0}
    b1 = b0
    return list1, tup1, dict1, b1

print(fun1(5, "KeyName", 2.3, False))


print(help(fun1))
"""
Help on function fun1 in module __main__:
fun1(a0: int, s0: str, f0: float, b0: bool) -> Tuple[List, Tuple, Dict, bool]
"""

print(help(fun2))
"""
Help on function fun2 in module __main__:
fun2(a0, s0, f0, b0)
"""
```

#### Pyrefly 

Pyrefly 是一个 Python 静态类型检查器，帮助你在代码运行前捕获类型相关的错误。它分析你的 Python 代码，确保整个代码库的类型一致性，使你的应用程序更可靠且易于维护。Pyrefly 支持 IDE 集成和命令行使用，让你在将类型检查融入工作流程时有更大的灵活性。类型检查的优势在你的 Python 代码中添加类型注解并使用 Pyrefly 这样的类型检查器，可以带来几个重要的优势：尽早捕获错误 在开发过程中识别类型相关的错误，而不是在运行时提升代码质量 类型注解作为动态文档，使你的代码更易读且自文档化增强开发者体验 通过准确的自动补全、重构工具和内联文档获得更好的 IDE 支持更安全的重构 在知道类型检查器会捕获不兼容类型使用的情况下，更有信心进行大规模更改更好的协作 类型在代码库的不同部分之间创建了清晰的契约，使团队更容易合作试试 Pyrefly这里有一个简单的例子，展示了 Pyrefly 如何捕获类型错误：# Example: Basic Type Checkingdef greet(name: str) -> str:  return "Hello, " + name# This works fine since both "World" is a string and greet expects a stringmessage = greet("World")# Pyrefly catches this error before runtime due to a type misatch between 42 and "str"# Error: Argument of type 'int' is not assignable to parameter of type 'str'error_message = greet(42)Python在这个例子中，Pyrefly 标记了第二个对 greet() 的调用，因为我们传递了一个整数 (42)，而期望的是字符串，这有助于你在代码运行前捕获这个问题。要了解更多关于 Python 类型注解以及如何有效使用它，请查看我们的 Python 类型注解入门 页面。

#### Pydantic

Pydantic 是 Python 中使用最广泛的数据验证库。快速且可扩展，Pydantic 与你的代码检查器/集成开发环境/大脑配合良好。以纯的、规范的 Python 3.8+ 定义数据应该如何；使用 Pydantic 对其进行验证。

成功

“迁移到 Pydantic V2”

使用 Pydantic V1 吗? 在应用程序中查看[迁移指南](https://pydantic.com.cn/migration/)以获取有关升级到 Pydantic V2 的注意事项！!

**Pydantic Example**

```
from datetime import datetime
from typing import Tuple

from pydantic import BaseModel


class Delivery(BaseModel):
    timestamp: datetime
    dimensions: Tuple[int, int]


m = Delivery(timestamp='2020-01-02T03:04:05Z', dimensions=['10', '20'])
print(repr(m.timestamp))
#> datetime.datetime(2020, 1, 2, 3, 4, 5, tzinfo=TzInfo(UTC))
print(m.dimensions)
#> (10, 20)
```

问题

“为什么 Pydantic 是这样命名的？”

“Pydantic”这个名字是“Py”和“pedantic”的混合词。“Py”部分表示该库与 Python 相关，而“pedantic”指的是该库在数据验证和类型强制方面的细致方法。

综合这些元素，“Pydantic”描述了我们的 Python 库，它提供了注重细节、严格的数据验证。

我们意识到具有讽刺意味的是，Pydantic V1 在其验证中并不严格，所以如果我们很“吹毛求疵”的话，在 V2 版本之前，“Pydantic”是一个用词不当的名称😉。

**为什么使用 Pydantic?[¶](https://pydantic.com.cn/#pydantic_1)**

- 由类型提示驱动——借助 Pydantic，模式验证和序列化由类型注释控制；学习的更少，编写的代码更少，并且与您的 IDE 和静态分析工具集成。了解更多……
- 速度——Pydantic 的核心验证逻辑是用 Rust 编写的。因此，Pydantic 是 Python 中最快的数据验证库之一。了解更多……
- JSON 模式——Pydantic 模型可以生成 JSON 模式，从而便于与其他工具进行集成。了解更多……
- 严格模式和宽松模式——Pydantic 可以在 `strict=True` 模式（数据不进行转换）或 `strict=False` 模式下运行（在适当的情况下，Pydantic 尝试将数据强制转换为正确类型）。了解更多……
- 数据类、类型字典等——Pydantic 支持对许多标准库类型的验证，包括 `dataclass` 和 `TypedDict` 。了解更多……
- 自定义——Pydantic 允许自定义验证器和序列化器以多种强大方式改变数据的处理方式。了解更多……
- 生态系统——PyPI 上约有 8000 个包使用 Pydantic，包括像 FastAPI、 huggingface、Django Ninja、SQLModel 和 LangChain 这样极受欢迎的库。了解更多……
- 经过实战检验——Pydantic 每月被下载超过 7000 万次，被所有 FAANG 公司以及纳斯达克 25 家最大公司中的 20 家所使用。如果你正试图用 Pydantic 做某事，那么可能其他人已经做过了。了解更多……

安装 Pydantic 就像这样简单： `pip install pydantic`

**Pydantic 使用例子[¶](https://pydantic.com.cn/#pydantic_2)**

**Validation Successful**

```
from datetime import datetime

from pydantic import BaseModel, PositiveInt


class User(BaseModel):
    id: int  
    name: str = 'John Doe'  
    signup_ts: datetime | None  
    tastes: dict[str, PositiveInt]  


external_data = {
    'id': 123,
    'signup_ts': '2019-06-01 12:22',  
    'tastes': {
        'wine': 9,
        b'cheese': 7,  
        'cabbage': '1',  
    },
}

user = User(**external_data)  

print(user.id)  
#> 123
print(user.model_dump())  
"""
{
    'id': 123,
    'name': 'John Doe',
    'signup_ts': datetime.datetime(2019, 6, 1, 12, 22),
    'tastes': {'wine': 9, 'cheese': 7, 'cabbage': 1},
}
"""
```

如果验证失败，Pydantic 会引发一个错误并详细说明哪里出错了：

**Validation Error**

```
# continuing the above example...

from pydantic import ValidationError


class User(BaseModel):
    id: int
    name: str = 'John Doe'
    signup_ts: datetime | None
    tastes: dict[str, PositiveInt]


external_data = {'id': 'not an int', 'tastes': {}}  

try:
    User(**external_data)  
except ValidationError as e:
    print(e.errors())
    """
    [
        {
            'type': 'int_parsing',
            'loc': ('id',),
            'msg': 'Input should be a valid integer, unable to parse string as an integer',
            'input': 'not an int',
            'url': 'https://pydantic.com.cn/errors/validation_errors#int_parsing',
        },
        {
            'type': 'missing',
            'loc': ('signup_ts',),
            'msg': 'Field required',
            'input': {'id': 'not an int', 'tastes': {}},
            'url': 'https://pydantic.com.cn/errors/validation_errors#missing',
        },
    ]
    """
```

### 代码格式化

#### ruff

Ruff是使用[Rust](https://zhida.zhihu.com/search?content_id=226726558&content_type=Article&match_order=1&q=Rust&zhida_source=entity)编写的超快Python静态分析工具。

我们看看它于市面上主流Python分析工具性能对比



![img](./assets/v2-caf06a6c5f608c029378eb3f2eed82a7_1440w.jpg)

上面是针对[CPython](https://zhida.zhihu.com/search?content_id=226726558&content_type=Article&match_order=1&q=CPython&zhida_source=entity)源码进行分析时间开销，我们可以很直观看出Ruff完全碾压其余竞品。架设我们项目结构如下：

```text
number
    ├── __init__.py
    └── number.py
```

**number.py** 包含如下代码：

```python
from typing import List

import os


def sum_even_numbers(numbers: List[int]) -> int:
    """Given a list of integers, return the sum of all even numbers in the list."""
    return sum(num for num in numbers if num % 2 == 0)
```

通过PyPI安装Ruff

```text
$ pip install ruff
```

安装完后，我们使用如下执行ruff

```text
$ ruff check .
number.py:3:8: F401 [*] `os` imported but unused
Found 1 error.
[*] 1 potentially fixable with the --fix option.
```

Ruff指示这里有未使用的导入，它是一个Python里的常见错误。Ruff还指示该错误是"fixable"，即可以通过如下方式自动修复错误：

```text
$ ruff check --fix .
Found 1 error (1 fixed, 0 remaining).
```

这里我们就发现`import os`给自动移除了。

##### 配置

为给整个项目里的Python文件指定配置，Ruff会目录下寻找`pyproject.toml`或者`ruff.toml`文件。

我们来在项目根目录下创建一个`pyproject.toml`文件。

```text
[project]
# Support Python 3.10+.
requires-python = ">=3.10"

[tool.ruff]
# Decrease the maximum line length to 79 characters.
line-length = 79
src = ["src"]
```

##### 规则

Ruff支持超过[500个lint规则](https://link.zhihu.com/?target=https%3A//beta.ruff.rs/docs/rules/)，它们分布在超过40个内建插件中，根据项目所需进行选择：一些是非常严格规则，一些是框架特定的。

默认Ruff设定E-和F-前缀的规则相应派生至[pycodestyle](https://zhida.zhihu.com/search?content_id=226726558&content_type=Article&match_order=1&q=pycodestyle&zhida_source=entity)和[Pyflakes](https://zhida.zhihu.com/search?content_id=226726558&content_type=Article&match_order=1&q=Pyflakes&zhida_source=entity)。

如果你是一个linter新手，那么默认规则是一个非常好的开始，只专注公共错误。

如果你是从其它工具迁移过来的linter，你可以开启和之前所使用的相同规则。例如，如果要配置[pyupgrade](https://zhida.zhihu.com/search?content_id=226726558&content_type=Article&match_order=1&q=pyupgrade&zhida_source=entity)规则，我们可以如下对`pyproject.toml`配置：

```text
[tool.ruff]
select = [
  "E",   # pycodestyle
  "F",   # pyflakes
  "UP",  # pyupgrade
]
```

再次运行Ruff，现在强制遵循pyupgrade规则。

```text
$ ruff check .
number/number.py:5:31: UP006 [*] Use `list` instead of `List` for type annotations
number/number.py:6:80: E501 Line too long (83 > 79 characters)
Found 2 errors.
[*] 1 potentially fixable with the --fix option.
```

或者我们还想强制所有的函数都必须编写docstings：

```text
[tool.ruff]
    select = [
      "E",   # pycodestyle
      "F",   # pyflakes
      "UP",  # pyupgrade
      "D",   # pydocstyle
    ]

    [tool.ruff.pydocstyle]
    convention = "google"
```

再次运行，我们将强制遵循pydocstyle规则：

```text
$ ruff check .
number/__init__.py:1:1: D104 Missing docstring in public package
number/number.py:1:1: D100 Missing docstring in public module
number/number.py:5:31: UP006 [*] Use `list` instead of `List` for type annotations
number/number.py:5:80: E501 Line too long (83 > 79 characters)
Found 3 errors.
[*] 1 potentially fixable with the --fix option.
```

##### 忽略错误

通过使用#noqa注释来忽略行级检测。

```python
from typing import List


def sum_even_numbers(numbers: List[int]) -> int:  # noqa: UP006
    """Given a list of integers, return the sum of all even numbers in the list."""
    return sum(num for num in numbers if num % 2 == 0)
```

再次执行就没有指示`List`导入问题了。

如果想整个文件有效那么，在文件顶部加入 `# ruff: noqa: UP006`

```python
# ruff: noqa: UP006
from typing import List


def sum_even_numbers(numbers: List[int]) -> int:
    """Given a list of integers, return the sum of all even numbers in the list."""
    return sum(num for num in numbers if num % 2 == 0)
```

Ruff支持使用`--add-noqa`参数来为代码增加`# noqa`指令，我们可以组合`--add-noqa`和`--select`配置`UP006`规范忽律

```text
$ ruff check --select UP006 --add-noqa .
Added 1 noqa directive.
```

##### 持续集成

pre-commit 钩子中使用：

```yaml
- repo: https://github.com/charliermarsh/ruff-pre-commit
      # Ruff version.
      rev: 'v0.0.261'
      hooks:
        - id: ruff
```

##### 编辑器集成

[VS Code 扩展](https://link.zhihu.com/?target=https%3A//github.com/charliermarsh/ruff-vscode)或者使用[Ruff LSP](https://link.zhihu.com/?target=https%3A//github.com/charliermarsh/ruff-lsp)集成其它编辑器

#### black

**Black** 被称为”The uncompromising code formatter”（不妥协的代码格式化工具），是由Łukasz Langa开发并由Python Software Foundation维护的Python代码格式化工具。Black的核心理念是：

> “Any color you like.”（任何你喜欢的颜色。）

这句话来自于Henry Ford关于Model T汽车的名言——“你可以选择任何颜色，只要它是黑色的”。Black采用了类似的哲学：**通过放弃对代码格式细节的控制权，换取速度、确定性，以及从格式争论中解放出来的自由**。

Black的主要特点：

- **确定性输出**：相同的代码输入总是产生相同的格式化输出
- **最小化差异**：生成尽可能小的代码差异，使代码审查更高效
- **统一风格**：无论是哪个项目，使用Black格式化后的代码看起来都是一致的
- **AST安全检查**：格式化后会验证代码的抽象语法树（AST）是否与原始代码等效

##### 6.1 Pre-commit集成

使用pre-commit可以在提交代码前自动运行格式化检查：

创建`.pre-commit-config.yaml`：

```
repos:
  - repo: https://github.com/psf/black
    rev: 24.10.0
    hooks:
      - id: black
        language_version: python3.11

  - repo: https://github.com/pycqa/isort
    rev: 5.13.2
    hooks:
      - id: isort
        args: ["--profile", "black", "--filter-files"]
```

安装pre-commit钩子：

```
pip install pre-commit
pre-commit install
```

##### 6.2 GitHub Actions集成

创建`.github/workflows/lint.yml`：

```
name: Lint

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.11"
      
      - name: Install dependencies
        run: |
          pip install black isort
      
      - name: Check formatting with Black
        run: black --check --diff .
      
      - name: Check import sorting with isort
        run: isort --check-only --diff --profile black .
```

##### 6.3 跳过特定代码块

###### Black跳过格式化

```
# fmt: off
# 这里的代码不会被格式化
matrix = [
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1],
]
# fmt: on

# 单行跳过
x = [1,2,3]  # fmt: skip
```

###### isort跳过导入排序

```
# isort: skip_file
"""整个文件跳过isort处理"""

import b
import a


# 或者单个导入跳过
import specific_module  # isort: skip
```

### 

### 文件管理 

#### glob

**glob模块**也是Python标准库中一个重要的模块，主要用来**查找符合特定规则的目录和文件**，并将搜索的到的**结果返回到一个列表中**。使用这个模块最主要的原因就是，该模块支持几个特殊的[正则通配符](https://zhida.zhihu.com/search?content_id=199065431&content_type=Article&match_order=1&q=正则通配符&zhida_source=entity)，用起来贼方便，这个将会在下方为大家进行详细讲解。

![img](./assets/v2-7fd0b20a09e63aba2da1c874a0ca64a7_1440w.jpg)

##### 一、支持4个常用的通配符

使用glob模块能够快速查找我们想要的目录和文件，就是由于它支持*、**、? 、[ ]这三个通配符，那么它们到底是 什么意思呢？

*：匹配0个或多个字符；

**：匹配所有文件、目录、子目录和子目录里的文件（3.5版本新增）；

?：代匹配一个字符；

[]：匹配指定范围内的字符，如[0-9]匹配数字，[a-z]匹配小写字母；

注意：这3个通配符的用法，将在讲函数的时候，一起带大家操作一遍；

##### 二、glob库中主要的3个函数

其实glob库很简单，只有3个主要函数供我们使用，它们分别是glob()、iglob()、escape()函数，因此学习起来特别容易。

glob.glob()：返回符合匹配条件的所有文件的路径；

glob.iglob()：返回一个迭代器对象，需要循环遍历获取每个元素，得到的也是符合匹配条件的所有文件的路径；

glob.escape()：escape可以忽略所有的特殊字符，就是星号、问号、中括号，用处不大；

recursive=False：代表递归调用，与特殊通配符“**”一同使用，默认为False，False表示不递归调用，True表示递归调用；

##### 2.1 glob()函数

```text
path1 = r"C:\Users\黄伟\Desktop\publish\os模块\test_shutil_a\[0-9].png"
glob.glob(path1)

path2 = r"C:\Users\黄伟\Desktop\publish\os模块\test_shutil_a\[0-9a-z].*"
glob.glob(path2)
```

结果如下：

![img](./assets/v2-eb0c02ee59ba196cf2a1708101e78736_1440w.jpg)

##### 2.2 iglob()函数

```text
path1 = r"C:\Users\黄伟\Desktop\publish\os模块\test_shutil_a\[0-9].png"
a = glob.iglob(path1)
for i in a:
    print(i)
```

结果如下：

![img](./assets/v2-48dedaafac8759c4f33dbaf5e7d6056e_1440w.jpg)

##### 2.3 escape()函数

通过下方两行代码的对比，可以看出escape()函数只是让*只表示它本来的意思，而不再具有通配符的作用。

```text
glob.glob('t*')
glob.escape('t*')
```

结果如下：

![img](./assets/v2-ee929ce90642925edeabd17fbc2eec20_1440w.jpg)

### 测试

#### pytest

Pytest是一个基于python的测试框架，用于编写和执行测试代码。在当今的 REST 服务中，pytest 主要用于 API 测试，尽管我们可以使用 pytest 编写简单到复杂的测试，即我们可以编写代码来测试 API、数据库、UI 等。

##### 安装Pytest

要开始安装，请执行以下命令 -

```python
pip install pytest == 2.9.1
```

我们可以安装任何版本的 pytest。这里，2.9.1 是我们正在安装的版本。

要安装最新版本的 pytest，请执行以下命令 -

```python
pip install pytest
```

使用以下命令确认安装以显示 pytest 的帮助部分。

```python
pytest -h
```

##### 使用Pytest

在不提及文件名的情况下运行 pytest 将运行所有格式的文件**test_\*.py**要么***_test.py**在当前目录和子目录中。Pytest 自动将这些文件识别为测试文件。我们**能够**通过明确提及它们使 pytest 运行其他文件名。Pytest 要求测试函数名称以**test**. 不符合格式的函数名称**test\***不被 pytest 视为测试函数。我们**cannot**明确地让 pytest 考虑任何不以**test**作为测试函数。







#### PyUnit / Unittest

