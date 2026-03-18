
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

#### 虚拟环境
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

#### 包与模块

##### 模块

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

##### 包

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

##### 导入方式

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

### 数据与表达式

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

#### 注释

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

函数这一节的关键不在 `def`，而在参数绑定规则与签名设计。订单系统里最常见的函数是服务层方法，例如创建订单、更新状态、查询订单，它们通常同时包含必填参数、可选参数、以及一些容易误用但影响行为的参数，例如 timeout、retry、dry_run。Python 允许你通过参数语法把调用约束直接写进签名里，让错误尽量在调用点暴露，而不是运行到深处才发现。

参数绑定规则里最容易被面试追问的是默认参数求值时机。默认值在函数定义时求值，而不是在每次调用时求值，所以可变对象作为默认值会被所有调用共享。订单系统里如果你写一个函数 `def add_item(order, items=[]): ...`，第一次调用 append 的结果会被第二次调用继承，这会造成跨请求污染。工程里要么用 None 作为默认值并在函数体内初始化，要么把默认值设计为不可变对象。

关键字专用参数是签名设计里非常实用的能力。把容易写错或影响行为的参数做成关键字专用，例如 source、dry_run、timeout，能显著提升调用点可读性。面试里如果被问“为什么要用 *”，你可以说这是在用语言特性防止误用，它让调用点必须写出参数名，从而减少歧义。

下面把常见参数形态放到表里，方便你在读代码时快速判断函数的意图。这里的重点是把签名当成契约，而不是把参数当成随便堆的口袋。

| 形态 | 作用 | 订单系统里常见用途 |
| --- | --- | --- |
| 位置参数 | 强制顺序 | user_id、amount_cents |
| 关键字参数 | 提升可读性 | source="web" |
| `*` 强制关键字 | 避免误用 | timeout、dry_run |
| `*args` | 收集位置参数 | 工具函数封装 |
| `**kwargs` | 收集关键字参数 | 透传选项但需谨慎 |

示例把“创建订单”与“追加明细”放在同一个语境里，同时演示默认参数坑的正确写法。后面面向对象章节会继续复用 Order 这个模型，这样整份笔记的示例能形成统一项目，而不是一节一个孤岛。

```python

在真实工程里，解包经常和参数规则一起出现。`*seq` 用来把序列按位置参数展开，`**mapping` 用来把字典按关键字参数展开。订单系统里你会经常把一份“订单字典”解包到构造函数里，或者把通用的调用参数通过 `**kwargs` 透传给下游库。这里的底线是透传要克制，最好在边界处做白名单过滤，避免把不该传的参数悄悄传下去。

解包也常用于把多个映射合并成一个配置对象。工程里更推荐用显式合并，避免后面的覆盖前面的这类行为被忽略。你在面试里只要能说清楚：`**` 的后者会覆盖前者，且解包只是一种语法形式，本质仍然遵循参数绑定规则，就算过关。

```python

```python
# ordersys/unpack_demo.py
def create_order(user_id: int, amount_cents: int, *, source: str = "web") -> dict:
    return {"user_id": user_id, "amount_cents": amount_cents, "source": source}

args = (7, 3000)
kwargs = {"source": "app"}
print(create_order(*args, **kwargs))

base_cfg = {"timeout_s": 2.0, "retries": 2}
env_cfg = {"timeout_s": 5.0}
merged = {**base_cfg, **env_cfg}
print(merged)

```

```
# ordersys/service.py
from dataclasses import dataclass
from typing import Optional

@dataclass
class Order:
    id: int
    user_id: int
    amount_cents: int
    source: str
    items: list[str]

def create_order(user_id: int, amount_cents: int, *, source: str = "web", dry_run: bool = False) -> Order:
    if dry_run:
        return Order(id=-1, user_id=user_id, amount_cents=amount_cents, source=source, items=[])
    return Order(id=1001, user_id=user_id, amount_cents=amount_cents, source=source, items=[])

def add_items(order: Order, items: Optional[list[str]] = None) -> None:
    if items is None:
        items = []
    order.items.extend(items)

o = create_order(7, 3000, source="app")
add_items(o, ["apple", "banana"])
print(o.items)

```

```

```
函数这一节你最后要形成的能力是写出可读、可调用、可测试的接口。面试里你讲参数规则，不要停留在语法名词，而要讲签名如何减少误用、如何表达契约、如何避免共享默认值这类线上坑。

#### 作用域与闭包入门
作用域遵循 LEGB，闭包常见坑是循环变量 late binding。订单系统里生成回调或规则函数时，建议用默认参数冻结变量，避免所有闭包引用同一个最终值。

```python
# ordersys/closure_demo.py
def make_checkers_good(channels):
    checkers = []
    for ch in channels:
        def checker(order, ch=ch):
            return order.get("channel") == ch
        checkers.append(checker)
    return checkers

order = {"id": 1001, "channel": "A"}
checkers = make_checkers_good(["A", "B"])
print([f(order) for f in checkers])

```
### 异常与 IO
#### 异常体系与资源释放
异常是 Python 里最重要的错误表达机制之一。订单系统的异常来源很多，例如参数校验失败、数据库超时、第三方接口错误、数据不一致。面试问异常，往往不是问语法，而是看你是否具备错误边界的概念：哪里应该抛，哪里应该捕，捕了以后是否要转换，怎么保证资源释放，怎么保留根因信息，怎么让日志与告警能快速定位到业务对象。

工程上把异常分层会更清晰。契约错误通常属于编程错误或调用方错误，例如类型不对、必填字段缺失、参数超范围，这类错误更倾向于尽早失败，让问题暴露在开发或测试阶段。运行时错误通常来自外部依赖或环境，例如网络超时、IO 失败、第三方返回异常，这类错误需要在边界处捕获并转换成业务语义，让上层能做统一策略，例如重试、降级或返回合理错误码。订单系统里最常见的边界是适配器层，例如支付网关、库存服务、风控服务，这些地方应该把底层异常转换为更明确的业务异常，并保留根因。

异常链是面试高频点。你在捕获低层异常后如果要抛出更有业务语义的异常，应当用 `raise NewError(...) from e` 保留因果链。裸 `raise` 用于原样继续抛出；`raise e` 会破坏原始堆栈信息，工程里不推荐。保留根因的价值很直接：线上排查能看到最初的失败原因，而不是只剩一句“处理失败”。

资源释放是异常题的核心落地点。最基本的保证来自 `try/finally`，无论中间是否抛异常，finally 都会执行；`with` 是更推荐的工程写法，它把获取与释放封装成协议，让资源成对出现。订单系统里典型资源包括文件句柄、连接、锁。只要涉及这些资源，就应该优先想到 with 或 finally，而不是靠“最后一行 close”。

下面用表把异常处理模式按策略拉平。面试里如果你按这张表去讲，会比背语法更像工程经验。

| 场景 | 处理方式 | 关键点 | 订单系统例子 |
| --- | --- | --- | --- |
| 契约错误 | 直接抛出 | 让 bug 尽早暴露 | amount 不是 int |
| 外部依赖失败 | 捕获并转换 | 保留根因，补充上下文 | 网关超时 -> PaymentError |
| 资源操作 | with 或 finally | 释放必达 | 导入文件、持锁区 |
| 记录异常 | logger.exception | 堆栈 + 业务标识 | order_id、channel |

示例用导入订单文件展示异常转换与异常链，并保证文件资源释放。你在工程里还会把这一层的业务异常交给上层做统一处理，但边界处的转换与根因保留必须先做好。

```python
# ordersys/importer2.py
from dataclasses import dataclass

class OrderImportError(Exception):
    pass

@dataclass
class ImportedOrder:
    id: int
    status: str

def parse_line(line: str) -> ImportedOrder:
    parts = line.strip().split(",")
    if len(parts) != 2:
        raise ValueError(f"bad format: {line!r}")
    return ImportedOrder(id=int(parts[0]), status=parts[1])

def import_orders(path: str) -> list[ImportedOrder]:
    orders: list[ImportedOrder] = []
    try:
        with open(path, "r", encoding="utf-8") as f:
            for line in f:
                if not line.strip():
                    continue
                orders.append(parse_line(line))
        return orders
    except Exception as e:
        raise OrderImportError(f"import failed: path={path}") from e

```
异常这一节的工程落点可以用一句话总结：边界处捕获并转换，保留根因，用 with/finally 保证释放，不随意吞掉异常；上层负责策略，例如是否重试、是否告警、如何对外返回。后面工程化章节会把“策略层面”的超时重试与幂等串起来，这里先把语言层面的异常机制讲透。

#### 文件与路径
文件 IO 的工程底线是显式编码、with 保证关闭、按行/按块流式处理避免大文件爆内存。订单系统里导入/导出最常见的就是 CSV 这类文本文件，路径推荐用 pathlib 让跨平台更稳。

```python
# ordersys/exporter.py
from pathlib import Path

def export_orders_csv(orders, out_dir: str) -> Path:
    out_path = Path(out_dir) / "orders.csv"
    with out_path.open("w", encoding="utf-8", newline="") as f:
        f.write("id,status\n")
        for o in orders:
            f.write(f"{o['id']},{o['status']}\n")
    return out_path

orders = [{"id": 1001, "status": "NEW"}, {"id": 1002, "status": "PAID"}]
print(export_orders_csv(orders, "."))

```
#### 标准库常用入口
标准库不是背目录，而是形成“场景到模块”的稳定联想。订单系统里最常见的就是时间、路径、计数聚合、序列化。把这些模块用熟，比引入一堆第三方库更稳。

```python

面试里你可以把这节收成一句口径：我优先用标准库把常见需求做稳，只有当标准库不足或维护成本更高时才引入第三方依赖，这样依赖更少、升级更可控、交付更可复现。
# ordersys/stdlib_demo.py
from collections import Counter
from datetime import datetime, timedelta
import json

orders = [{"id": 1001, "status": "NEW"}, {"id": 1002, "status": "PAID"}, {"id": 1003, "status": "NEW"}]
stat = Counter(o["status"] for o in orders)
print(stat)

expires_at = datetime.utcnow() + timedelta(minutes=30)
print(expires_at.isoformat())

payload = json.dumps(orders, ensure_ascii=False)
print(payload)

```
### 调试与习惯
#### 调试、日志与常见坑
调试与日志的目标是把现象变成可定位的信息。订单系统日志至少要带业务标识与异常堆栈；不要吞异常，不要为了日志提前拼大字符串。

```python

订单系统的线上排查往往要求你把一次请求在多个模块的日志串起来。最小可用的做法是引入一个 request_id，并在这一请求的所有日志里带上它。标准库层面可以用 `contextvars` 在异步场景里传递上下文，保证同一个 request_id 在协程切换后仍然可用。线程场景下如果你用线程池执行任务，也要注意上下文是否需要显式传递，工程里很多团队会用中间件或框架提供的上下文能力做统一封装。

下面的示例用 `contextvars` 存 request_id，并通过一个 logging Filter 把它注入到每条日志里。示例不依赖框架，但结构就是你在 Web 服务里会用到的那套。

```python

```python
# ordersys/request_context_demo.py
import logging
import contextvars
import uuid

request_id_var = contextvars.ContextVar("request_id", default="-")

class RequestIdFilter(logging.Filter):
    def filter(self, record: logging.LogRecord) -> bool:
        record.request_id = request_id_var.get()
        return True

handler = logging.StreamHandler()
handler.setFormatter(logging.Formatter("%(asctime)s %(levelname)s request_id=%(request_id)s %(message)s"))

root = logging.getLogger("ordersys")
root.setLevel(logging.INFO)
root.addHandler(handler)
root.addFilter(RequestIdFilter())

def handle_request() -> None:
    token = request_id_var.set(str(uuid.uuid4()))
    try:
        root.info("start")
        root.info("do something")
        root.info("end")
    finally:
        request_id_var.reset(token)

handle_request()

```

```

面试里你不需要背 contextvars 的 API，但你要能讲清楚目标：给每条日志加上可关联的请求标识，让一次请求在多个模块间可追踪；同步框架通常用中间件实现，异步框架用 contextvars 能更自然地贯穿协程上下文。
# ordersys/logging_demo.py
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(name)s order_id=%(order_id)s %(message)s"
)
logger = logging.getLogger("ordersys")

def process(order_id: int) -> None:
    try:
        if order_id < 0:
            raise ValueError("bad id")
        logger.info("ok", extra={"order_id": order_id})
    except Exception:
        logger.exception("failed", extra={"order_id": order_id})
        raise

process(1001)

```
## 面向对象

### 类的基本能力
#### 类/实例/属性/方法
Python 的面向对象在工程里更像是一套组织代码与表达边界的工具，而不是为了“用类而用类”。订单系统里最自然的对象通常是领域模型，例如订单、订单项、支付单，以及围绕它们的服务与仓储。面试里问类与实例，核心是在确认你是否理解实例数据放在哪里、方法如何绑定、属性查找顺序是什么，这些决定了你写出来的代码是清晰还是会出现诡异的覆盖与共享问题。

类是模板，实例是运行时对象。实例的状态通常放在实例自己的属性里，类属性更多用来表达常量或共享配置。方法在定义时只是函数，访问时会变成绑定方法，也就是把实例作为第一个参数自动传入。这个机制解释了为什么实例方法的签名里会有 `self`，也解释了为什么你从类上访问同一个函数时得到的是未绑定的函数对象。

属性查找顺序是一个必须讲清楚的点，因为它会直接影响你对 bug 的定位。一个最常见的真实问题是你以为自己改的是实例字段，实际上改的是类属性，导致所有实例共享了一个可变对象。另一个常见问题是实例属性覆盖了同名类属性，造成你以为配置改了，其实只是某个实例影子覆盖。你需要在脑子里有一个稳定的模型：访问 `obj.x` 时，解释器先尝试通过 `__getattribute__` 查找，优先处理数据描述符，其次看实例字典，再看类字典与基类链，最后才会触发 `__getattr__` 作为兜底。你不必把每个术语背下来，但你要知道“描述符优先级高于实例字典”这一点，因为 property 的行为就依赖它。

下面把常见对象要素放在一张表里，它既是面试回答的骨架，也是你写代码时的默认约束。订单系统里字段多、流程长，靠签名与属性约束减少误用，会比靠注释更可靠。

| 概念 | 存放位置 | 访问方式 | 订单系统里的例子 |
| --- | --- | --- | --- |
| 实例属性 | 每个对象一份 | `order.status` | 订单状态、金额、明细 |
| 类属性 | 类对象共享 | `Order.STATUS_NEW` | 状态常量、默认配置 |
| 实例方法 | 绑定到实例 | `order.mark_paid()` | 订单行为 |
| 类方法 | 绑定到类 | `Order.from_dict(...)` | 构造器、工厂方法 |
| 静态方法 | 不自动绑定 | `Order.validate(...)` | 与类相关的工具函数 |

示例实现一个最小的 Order 类，展示类属性、实例属性、实例方法与类方法的差别。示例后半段故意展示“类属性放可变对象”的风险，这是订单系统里非常典型的线上坑。

```python
# ordersys/oop_order.py
from __future__ import annotations

class Order:
    STATUS_NEW = "NEW"
    STATUS_PAID = "PAID"
    DEFAULT_TAGS = []  # 仅用于演示风险，工程里不要这样写

    def __init__(self, order_id: int, user_id: int, amount_cents: int) -> None:
        self.id = order_id
        self.user_id = user_id
        self.amount_cents = amount_cents
        self.status = Order.STATUS_NEW
        self.tags = []  # 每个实例一份

    def mark_paid(self) -> None:
        self.status = Order.STATUS_PAID

    @classmethod
    def from_dict(cls, data: dict) -> "Order":
        return cls(order_id=int(data["id"]), user_id=int(data["user_id"]), amount_cents=int(data["amount_cents"]))

o1 = Order(1001, 7, 3000)
o2 = Order(1002, 8, 4000)
Order.DEFAULT_TAGS.append("shared")
o1.tags.append("private")
print(Order.DEFAULT_TAGS, o1.tags, o2.tags)

```

```

方法绑定这一点面试也经常追问。你可以把 `Order.mark_paid` 看成函数对象，`o1.mark_paid` 看成把 `o1` 绑定进去之后得到的可调用对象。理解这个差别，你就能解释很多看似“魔法”的行为，比如为什么装饰器能拦截方法调用，为什么把函数挂到类上就自动变成方法。

```python

```python
# ordersys/method_binding_demo.py
class X:
    def f(self) -> str:
        return "ok"

x = X()
print(X.f)      # 类上拿到的是函数对象
print(x.f)      # 实例上拿到的是绑定方法
print(X.f(x))   # 手动传 self
print(x.f())    # 自动传 self

```
这一节最后你要记住的不是语法，而是模型：实例存数据，类存常量或共享策略；方法是函数加绑定；属性查找有优先级，描述符能拦截读写；把可变对象放在类属性上是常见坑。

#### 构造与生命周期
构造与生命周期这一节，面试常用来考两件事。第一件是对象创建过程里哪些钩子会被调用，尤其是 `__init__` 与 `__new__` 的区别。第二件是资源型对象的生命周期如何管理，例如数据库连接、文件句柄、锁，什么时候创建、什么时候释放，如何避免“对象被垃圾回收时才释放资源”这种不确定行为。订单系统里绝大多数对象不需要自定义 `__new__`，但你需要知道它存在，知道它在不可变对象或单例模式里可能出现。

`__init__` 负责初始化已经创建好的实例，它不能返回新对象。`__new__` 负责创建实例，它必须返回一个实例。你在工程里最常见的 `__new__` 场景通常来自第三方库或不可变类型的派生，例如你想派生一个不可变的订单号类型，或者你看到某些库用 `__new__` 做缓存与复用。业务类大多数只用 `__init__` 就足够。

生命周期管理上，Python 有垃圾回收，但不要把资源释放寄托在 `__del__` 上，因为它不保证及时执行，也不保证一定执行。工程里资源型对象用上下文管理器或显式 close 方法更稳。订单系统里最常见的资源型对象是数据库连接与 HTTP 连接，你希望它们的释放时机可控且可测试，而不是“看 GC 心情”。

下面的表把常见生命周期策略放在一起。面试里回答时可以先讲语义，再讲工程结论：资源释放要显式，要可验证。

| 方式 | 释放时机 | 稳定性 | 订单系统适用场景 |
| --- | --- | --- | --- |
| `with` 上下文 | 块结束立即释放 | 最稳 | 文件、连接、锁 |
| 显式 `close()` | 调用点决定 | 可控但易漏 | 长生命周期对象 |
| `__del__` | 不确定 | 不推荐 | 兜底，不能当主方案 |

示例用一个连接对象展示 `__enter__/__exit__` 的基本形态。真正的数据库连接会更复杂，但这个模式会一直复用。

```python
# ordersys/repo_conn.py
class RepoConnection:
    def __init__(self) -> None:
        self._opened = True

    def close(self) -> None:
        self._opened = False

    def __enter__(self) -> "RepoConnection":
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        self.close()

with RepoConnection() as conn:
    print("opened", conn._opened)
print("closed", conn._opened)

```
面试里如果继续问“对象什么时候会被释放”，更稳的回答是把焦点拉回工程结论：业务对象由 GC 管，资源对象由 with 或 close 管。你把这两个层面分开讲，通常会让人觉得你有线上经验。

### 继承与结构
#### 继承、super 与 MRO
继承、super 与 MRO 是 Python 面向对象里最容易被问到的机制题。订单系统里虽然不鼓励深继承树，但你仍然会遇到继承，例如不同渠道的支付适配器、不同类型订单的差异化校验。面试问继承不只是问语法，而是在确认你是否理解方法解析顺序，也就是在多继承时到底调用了哪个方法，`super()` 究竟做了什么。

Python 的 MRO 是一种线性化规则，它决定了属性和方法的查找顺序。`super()` 并不是“调用父类”，它是沿着 MRO 链条去找下一个实现。这个差别在单继承里看不出来，在多继承里是核心。工程里如果你要用多继承，通常是为了组合能力而不是复用状态，并且你必须遵守 cooperative multiple inheritance 的写法，也就是每一层都用 `super()`，每一层都只做自己那一部分初始化，否则很容易出现某个父类的 `__init__` 没被调用。

下面先用单继承的支付适配器演示 super 的直观含义，再用一个带 mixin 的例子说明为什么 super 是“沿 MRO 找下一个”。你在面试里能把这点讲清楚，就已经达到了多数团队对 Python OOP 的要求。

```python
# ordersys/inherit_demo.py
class PaymentBase:
    def pay(self, order_id: int) -> str:
        return f"base pay {order_id}"

class ChannelA(PaymentBase):
    def pay(self, order_id: int) -> str:
        base = super().pay(order_id)
        return base + " via A"

p = ChannelA()
print(p.pay(1001))
print(ChannelA.mro())

```

```

多继承的例子用两个 mixin 叠加行为，再由最终类组合起来。每一层都用 super，并且每一层都调用同名方法，这样链条才会完整。你会看到调用顺序严格按 MRO 走，这就是 cooperative 的意义。

```python

```python
# ordersys/mro_demo.py
class LogMixin:
    def process(self, order_id: int) -> str:
        return "log(" + super().process(order_id) + ")"

class MetricMixin:
    def process(self, order_id: int) -> str:
        return "metric(" + super().process(order_id) + ")"

class CoreProcessor:
    def process(self, order_id: int) -> str:
        return f"core:{order_id}"

class Processor(LogMixin, MetricMixin, CoreProcessor):
    pass

p = Processor()
print(p.process(1001))
print(Processor.mro())

```

```

工程结论很清晰：业务层避免复杂多继承，能用组合就用组合；确实要用时，优先用 mixin 叠加无状态行为，并严格遵守 cooperative super 的写法。面试里你把“super 是按 MRO 找下一个”讲对，基本就稳。

```python

```

```
多继承的例子用两个 mixin 叠加行为，再由最终类组合起来。每一层都用 super，并且每一层都调用同名方法，这样链条才会完整。你会看到调用顺序严格按 MRO 走，这就是 cooperative 的意义。

工程结论很清晰：业务层避免复杂多继承，能用组合就用组合；确实要用时，优先用 mixin 叠加无状态行为，并严格遵守 cooperative super 的写法。面试里你把“super 是按 MRO 找下一个”讲对，基本就稳。

#### 抽象与协议式设计
抽象与协议式设计这一节，面试常见的切入点是“Python 没有接口，那怎么约束调用方”。真实答案是 Python 倾向于鸭子类型，约束更多来自约定与测试，但在工程里也会用抽象基类与类型标注来表达契约。订单系统的典型场景是支付渠道适配器。你希望所有渠道都提供同样的方法，例如 `pay`、`refund`，并且你希望在实现不完整时能尽早失败。

抽象基类用 `abc.ABC` 与 `@abstractmethod` 表达必须实现的方法。如果子类没有实现抽象方法，实例化时就会报错，这是一种运行时约束。协议式设计更偏向静态检查层面，通常配合 typing 的 Protocol 来表达结构契约，这会让你在开发阶段就能通过类型检查发现不匹配，但它不会像 ABC 那样在运行时阻止实例化。工程里两者经常配合使用：关键边界用 ABC 做硬约束，代码提示与静态检查用 Protocol 做软约束，最终可靠性仍然靠测试与灰度。

下面的表把两种方式的取舍列出来。你在面试里不需要站队，但要能说出它们各自解决什么问题。

| 方式 | 约束发生在哪 | 优点 | 代价 | 订单系统常见用法 |
| --- | --- | --- | --- | --- |
| ABC | 运行时 | 漏实现立刻失败 | 需要继承体系 | 支付网关、仓储接口 |
| Protocol | 类型检查期 | 灵活，不要求继承 | 依赖工具链 | 服务层依赖的能力约束 |

示例仍用支付适配器演示 ABC 的最小写法。你在面试里可以顺势补一句：如果团队使用 mypy/pyright，会把 Protocol 用在更多位置，让依赖关系更清晰。

```python
# ordersys/payment_abc.py
from abc import ABC, abstractmethod

class PaymentGateway(ABC):
    @abstractmethod
    def pay(self, order_id: int, amount_cents: int) -> str:
        raise NotImplementedError

    @abstractmethod
    def refund(self, order_id: int, amount_cents: int) -> str:
        raise NotImplementedError

class ChannelAGateway(PaymentGateway):
    def pay(self, order_id: int, amount_cents: int) -> str:
        return f"A pay {order_id} {amount_cents}"

    def refund(self, order_id: int, amount_cents: int) -> str:
        return f"A refund {order_id} {amount_cents}"

g = ChannelAGateway()
print(g.pay(1001, 3000))

```

```

```
这一节的工程落点是：接口不是为了写接口，而是为了让边界更稳。订单系统的边界往往在外部依赖处，例如支付渠道、短信通知、风控服务。把边界用抽象表达出来，替换实现时成本会更低，测试也更容易写。

### 属性与建模
#### property 与描述符
`property` 与描述符这一节是 Python 面向对象的高频机制题，也是工程里能写出更稳 API 的关键能力。订单系统里经常需要做字段校验与派生字段，例如金额分必须非负，订单状态只能走合法迁移路径，展示字段需要由内部字段计算得出。如果你把所有校验都写成外部函数，调用方很容易绕过；如果你把校验放进属性访问里，模型会更自洽。

`property` 本质上是描述符的一种应用。描述符协议定义了 `__get__`、`__set__`、`__delete__`，当类属性是描述符对象时，访问行为会被它接管。你在面试里最需要讲清楚的是两点：property 为什么能拦截读写，以及它适合表达哪些不变量。订单系统里常见的用法是把“设置字段”变成一个受控入口，例如金额必须非负，状态迁移必须合法。另一个常见用法是只读派生属性，让展示逻辑不污染业务字段。

下面的示例用 property 把“金额分到元”的展示和“金额必须非负”的校验放到模型里。这样写的好处是模型本身就保证了基本不变量，调用方即使不小心也更难写出错误状态。

```python
# ordersys/property_demo.py
class Order:
    def __init__(self, amount_cents: int) -> None:
        self._amount_cents = 0
        self.amount_cents = amount_cents

    @property
    def amount_cents(self) -> int:
        return self._amount_cents

    @amount_cents.setter
    def amount_cents(self, value: int) -> None:
        if value < 0:
            raise ValueError("amount_cents must be >= 0")
        self._amount_cents = value

    @property
    def amount_yuan(self) -> str:
        return f"{self._amount_cents / 100:.2f}"

o = Order(1990)
print(o.amount_yuan)

```

```

订单系统里更常见的“更稳 API”其实是状态迁移。与其让外部直接 `order.status = "PAID"`，不如把迁移封装成方法，并在内部校验合法性。property 能拦截赋值，但它更适合校验单字段不变量；状态迁移往往涉及多字段与规则，方法比 setter 更清晰，也更好测试。这个点在面试里讲出来，会比单纯展示 property 更像工程经验。

```python

```python
# ordersys/status_transition_demo.py
class Order:
    STATUS_NEW = "NEW"
    STATUS_PAID = "PAID"
    STATUS_CANCELED = "CANCELED"

    def __init__(self) -> None:
        self.status = Order.STATUS_NEW

    def mark_paid(self) -> None:
        if self.status != Order.STATUS_NEW:
            raise RuntimeError(f"illegal transition: {self.status} -> PAID")
        self.status = Order.STATUS_PAID

o = Order()
o.mark_paid()
print(o.status)

```

```

```
描述符在工程里更常见的表现形式是 ORM 字段、缓存属性、校验属性等。你在面试里把 property 讲清楚通常就足够；描述符协议作为加分项，只要你能说明“属性访问是可定制的，并且优先级高于实例字典”，就能体现你理解背后的机制。

#### dataclass 与不可变建模
`dataclass` 是 Python 工程里非常常用的建模工具，尤其适合订单系统这种以数据为核心的代码。它能自动生成 `__init__`、`__repr__`、`__eq__` 等方法，让你的模型更轻、更一致。面试里问 dataclass，通常会追问它到底帮你生成了什么，以及你什么时候不应该用它。

当模型主要承载数据，行为不多时，dataclass 很合适。它把样板代码压掉，让字段与类型更清晰。你可以用 `frozen=True` 得到一个对外不可变的模型，这对缓存键、消息事件、快照类对象特别有用。不可变并不代表深层不可变，如果字段里包含 list 或 dict，它们仍然是可变对象，这一点面试经常拿来追问。工程里如果你需要真正的不可变，字段应当选择不可变类型，或者在构造时把可变结构转换成不可变表示。

dataclass 还有两个非常实用的工程点。一个是默认值的安全写法，针对 list/dict 这类可变字段必须使用 `default_factory`，避免共享默认值污染。另一个是字段参与比较与 repr 的控制，你可以通过 `repr=False` 或 `compare=False` 控制敏感字段不出现在日志或不参与等价判断。订单系统里如果你把原始支付回调 payload 放进 dataclass，又让它出现在 repr 里，日志就会被污染，还可能带来隐私风险，这种取舍要有意识。

下面用订单事件对象演示 frozen 与 default_factory，同时展示 repr 的控制。示例里事件是快照，适合作为消息与幂等键的一部分。

```python
# ordersys/dataclass_demo.py
from dataclasses import dataclass, field

@dataclass(frozen=True)
class OrderEvent:
    order_id: int
    status: str
    amount_cents: int
    tags: tuple[str, ...] = ()

@dataclass
class OrderDraft:
    user_id: int
    items: list[str] = field(default_factory=list)

d = OrderDraft(user_id=7)
d.items.append("apple")
e = OrderEvent(order_id=1001, status="PAID", amount_cents=3000, tags=("vip",))
print(d, e)

```
面试里你可以这样说：dataclass 是减少样板并强化字段表达的工具，适合数据模型与 DTO；需要封装与复杂不变量时仍然用普通类加 property 或方法控制；可变字段用 default_factory；frozen 提供对外不可变，但要注意深层可变性；敏感字段要控制 repr 与比较行为。

#### slots 与内存直觉
`__slots__` 往往是面试里用来区分“懂运行时细节”的点。Python 默认每个实例都有 `__dict__` 来存储属性，这带来很强的动态性，也带来额外的内存开销。订单系统里如果你有大量短生命周期对象，例如导入文件时每一行生成一个订单项对象，或者消息消费时生成大量事件对象，内存与 GC 压力可能会变得明显，这时 `__slots__` 可能成为优化手段之一。

使用 `__slots__` 的直接效果是限制实例可以拥有的属性集合，并通常去掉实例的 `__dict__`，从而减少内存。它的代价是动态加属性变难，一些依赖 `__dict__` 的机制也会受影响。继承关系里 slots 也会带来额外约束，例如子类需要显式声明自己的 slots 才能新增字段。工程里是否使用 slots 取决于对象数量与性能瓶颈，不应该为了“看起来高级”而用。面试里如果问你 slots 的作用，你回答“省内存、限制属性、减少实例字典”就够了，同时补一句“有代价，需权衡”会更像工程人。

下面用一个订单项对象示例展示 slots 的写法，并用 `hasattr` 观察实例是否还有 `__dict__`。这个例子不追求跑分，而是固定你的认知：slots 是约束与优化手段，不是日常默认。

```python
# ordersys/slots_demo.py
class OrderItem:
    __slots__ = ("sku", "qty")

    def __init__(self, sku: str, qty: int) -> None:
        self.sku = sku
        self.qty = qty

item = OrderItem("A", 1)
print(hasattr(item, "__dict__"))
print(item.sku, item.qty)

```

```

```
如果你在面试里想再加一点深度，可以提到 slots 对于内存敏感场景很有用，但它并不是免费的午餐，真正是否值得要用剖析数据说话。工程里多数优化都应当先确认瓶颈，再选择手段，而不是先上技巧。

### 设计取舍
#### 组合优于继承与边界划分
组合优于继承这句话在 Python 工程里尤其重要，因为 Python 的继承很灵活，灵活到你很容易用它去做本不该用继承做的事情。订单系统里最常见的错误设计是用继承堆出一棵订单类型树，把不同业务差异塞进不同子类里，最后导致状态迁移与规则散落在各个类里，新增一种订单类型就要改很多地方，测试也变得困难。

组合的思路是把变化点抽出来，作为可替换的组件注入到稳定的主体里。订单系统里主体往往是 OrderService 或 OrderProcessor，变化点可能是支付渠道、风控策略、计费规则、通知方式。你用组合把变化点变成接口或可调用对象，主体只依赖抽象，这样新增渠道只需要新增一个实现，并在组装时替换即可。面试里你把这个思路讲清楚，比背设计模式名字更有用。

下面用一个处理器把支付网关作为组合组件注入。代码很短，但它表达了核心：服务依赖的是能力，而不是具体子类。你如果用继承去做这个，会把依赖隐藏在父类里，调试与测试都会更痛苦。

```python
# ordersys/compose_demo.py
from typing import Protocol

class PaymentGateway(Protocol):
    def pay(self, order_id: int, amount_cents: int) -> str: ...

class OrderProcessor:
    def __init__(self, gateway: PaymentGateway) -> None:
        self._gateway = gateway

    def pay_order(self, order_id: int, amount_cents: int) -> str:
        return self._gateway.pay(order_id, amount_cents)

class DummyGateway:
    def pay(self, order_id: int, amount_cents: int) -> str:
        return f"dummy pay {order_id} {amount_cents}"

p = OrderProcessor(DummyGateway())
print(p.pay_order(1001, 3000))

```

```

组合不仅适用于外部依赖，也适用于业务规则。订单系统里常见的规则变化是折扣、税费、分摊。把规则做成可调用对象注入到处理器里，会比用继承派生出一堆 Processor 子类更稳定。你在面试里如果能把“规则是策略，策略是可替换组件”讲出来，会很加分。

```python

```python
# ordersys/strategy_demo.py
from typing import Callable

DiscountPolicy = Callable[[int], int]

def no_discount(amount_cents: int) -> int:
    return amount_cents

def vip_discount(amount_cents: int) -> int:
    return amount_cents * 95 // 100

class PricingService:
    def __init__(self, policy: DiscountPolicy) -> None:
        self._policy = policy

    def final_amount(self, amount_cents: int) -> int:
        return self._policy(amount_cents)

print(PricingService(no_discount).final_amount(10000))
print(PricingService(vip_discount).final_amount(10000))

```

```

```
这节面试的最佳回答通常是把边界说清楚：继承适合表达“是一个”的稳定关系，组合适合表达“有一个”的可替换能力；订单系统里变化多，组合更稳；继承可以用，但要浅、要清晰、要避免把状态与行为散到难以追踪的层级里。

## Python 特性

### 数据模型
#### 魔术方法总览（repr/比较/容器/可调用）
Python 的数据模型可以理解成一套协议：对象只要实现某些魔术方法，就能“像内置类型一样”参与运算、打印、比较、容器访问、函数调用。面试问魔术方法，往往不是让你背全名单，而是看你是否理解它们在真实工程里解决什么问题。订单系统里最常见的场景是日志与调试输出、排序与去重、把业务对象放进容器里当键、以及让对象在某些上下文里“看起来像字典或像函数”。

一个很实用的切入点是输出语义。`__repr__` 面向开发者，应该尽量准确、可复现地描述对象；`__str__` 面向用户或展示，强调可读性。订单系统里你在排查线上问题时，日志里打印出的对象表示经常是第一手证据，如果 `__repr__` 写得敷衍，你会在排查时丢掉大量信息。另一方面，过度把大字段塞进 repr 又会污染日志，所以 repr 的信息密度需要权衡，这一点会在工程化章节的日志规范里继续落地。

另一个常见点是比较与排序。Python 的排序依赖 `key` 函数或比较协议，工程里多数情况下用 `key` 更清晰也更稳定；当你实现 `__lt__` 等比较方法时，你是在把对象的“排序规则”写死到类型里，这对通用模型未必是好事。订单系统里如果只在一个页面要按金额排序，用 `sorted(orders, key=...)` 就够了；只有当整个系统都把某个对象定义为“天然按某字段排序”时，才考虑实现比较方法。

下面的表把数据模型里最常见、且在面试里最容易被问到的一组协议按用途归类。你不需要背每一个名字，但你要能把“某个行为对应一类方法”的关系说清楚。

| 类别 | 典型魔术方法 | 触发时机 | 订单系统里的例子 |
| --- | --- | --- | --- |
| 输出 | `__repr__`, `__str__` | `print`, 日志, 调试器 | 订单对象打印、异常上下文 |
| 比较 | `__eq__`, `__lt__` | `==`, `sorted` | 判重、排序展示 |
| 容器 | `__len__`, `__iter__`, `__contains__` | `len`, `for`, `in` | 订单明细遍历、成员判断 |
| 可调用 | `__call__` | `obj(...)` | 把策略对象当函数用 |
| 上下文 | `__enter__`, `__exit__` | `with` | 连接、锁、文件资源 |
| 属性兜底 | `__getattr__` | 属性不存在时 | DTO 兼容旧字段 |

示例用订单对象实现一个合理的 `__repr__` 与 `__str__`，并展示它们在日志与 print 场景下的差别。你在面试里可以用这段代码说明：repr 用来给开发者看，str 用来给业务展示看；工程里优先保证 repr 有用。

```python
# ordersys/model_repr.py
class Order:
    def __init__(self, order_id: int, status: str, amount_cents: int) -> None:
        self.id = order_id
        self.status = status
        self.amount_cents = amount_cents

    def __repr__(self) -> str:
        return f"Order(id={self.id}, status={self.status!r}, amount_cents={self.amount_cents})"

    def __str__(self) -> str:
        return f"订单#{self.id} 状态={self.status} 金额={self.amount_cents/100:.2f}"

o = Order(1001, "PAID", 1990)
print(repr(o))
print(str(o))

```
魔术方法的核心心智模型是“协议驱动行为”。面试里如果你不确定某个方法名，反而可以把重点放在协议类别上，说清楚你知道输出、比较、容器、可调用、上下文这些行为在 Python 里是可定制的，并且你知道在订单系统里应该在哪些边界用它们，而不是到处上魔法。

#### hash、可变性与字典行为
`hash`、可变性与字典行为是一组很容易被问到、也很容易踩坑的内容。订单系统里你经常需要把对象放进 dict 或 set 里做缓存、做索引、做去重，这时你就会碰到两个问题：对象是否可哈希，以及等价判断与哈希是否一致。面试喜欢问这一块，是因为它直接关系到“缓存键是否稳定”“去重是否正确”，属于线上事故高发区。

在 Python 里，一个对象能否当 dict 的键，取决于它是否可哈希。默认情况下，自定义对象如果没有定义 `__eq__`，它的等价就是身份等价，并且通常也是可哈希的；一旦你定义了 `__eq__`，Python 通常会把 `__hash__` 置为不可用，避免你写出“等价改变但哈希不变”导致的容器行为不一致。工程里如果你真的需要把自定义对象当键，你必须明确对象的等价语义，并且保证等价字段在作为键期间不会变化。最稳的做法通常是用不可变表示做键，例如用 `(order_id, channel)` 这样的 tuple，或者用 frozen dataclass。

下面这张表把“可哈希的基本规则”写成工程语言。你在面试里不需要背 Python 规范，但你要能解释“为什么可变对象不能当键”，答案是哈希表要求键的哈希稳定，否则你放进去以后就找不回来了。

| 对象类型 | 是否可哈希 | 原因 | 订单系统里的建议用法 |
| --- | --- | --- | --- |
| `int`, `str` | 是 | 不可变，哈希稳定 | 订单号、渠道名当键 |
| `tuple` | 条件成立 | 元素都可哈希才稳定 | (order_id, channel) |
| `list`, `dict` | 否 | 可变，哈希不稳定 | 作为值，不做键 |
| 自定义类 | 视实现而定 | 取决于 eq/hash 语义 | 用不可变键或 frozen 模型 |

示例用“缓存订单查询结果”演示稳定键的写法，并展示“把可变对象当键”会直接失败。工程里你不需要纠结怎么让 list 可哈希，而是要选择正确的键表示。

```python
# ordersys/cache_key_demo.py
cache: dict[tuple[int, str], dict] = {}

def get_order(order_id: int, channel: str) -> dict:
    key = (order_id, channel)
    if key in cache:
        return cache[key]
    order = {"id": order_id, "channel": channel, "status": "NEW"}
    cache[key] = order
    return order

print(get_order(1001, "A"))

```

```

```
这一节面试常见的延伸问题是“如果对象可变但我又想当键怎么办”。工程答案通常是不要让它当键，转成不可变快照当键，或者只用它的不变标识字段作为键。你把这个取舍讲清楚，比讲技巧更像工程经验。

### 迭代与生成
#### 迭代器与生成器（含推导式）
迭代协议是 Python 面试的高频点，也是很多“看起来高级”的写法背后的基础。订单系统里你会大量遍历订单、遍历明细、遍历分页结果，如果你理解迭代器与可迭代对象的差别，就能写出更省内存、更适合流式处理的代码，也能更容易读懂别人写的生成器与管道式处理。

可迭代对象提供 `__iter__`，每次调用返回一个迭代器；迭代器提供 `__next__`，不断产出元素，直到抛出 `StopIteration`。`for` 循环会自动调用 `iter()` 得到迭代器，再不断调用 `next()`。面试里最常见的误解是把“能 for 的东西”都当成迭代器，或者把迭代器当成可以重复遍历的容器。迭代器往往是一次性的，消费完就没了，订单系统里如果你把迭代器传进两个处理函数，第二个函数可能拿不到任何数据，这类 bug 也很真实。

下面用一个“分页读取订单”的例子解释迭代协议。我们用一个生成器函数模拟分页接口，它每次 yield 一页订单。你会看到生成器既实现了迭代器语义，也让你能以流式方式处理数据，而不用一次性把所有订单读进内存。

```python

生成器里还有一个常见语法是 `yield from`，它用于把“子迭代器/子生成器”直接委托出去，让外层生成器像扁平化一样逐个产出元素。订单系统里做分页、做批处理流水线时，`yield from` 可以让你把“分页获取”和“逐条消费”写得更干净。面试里你不一定会被问到，但你能讲出来通常是加分项。

```python

```python
# ordersys/yield_from_demo.py
from typing import Iterator

def pages() -> Iterator[list[int]]:
    yield [1001, 1002]
    yield [1003]

def stream_order_ids() -> Iterator[int]:
    for page in pages():
        yield from page

print(list(stream_order_ids()))

```

```
# ordersys/paging_iter.py
from typing import Iterator

def fetch_order_pages() -> Iterator[list[dict]]:
    yield [{"id": 1001}, {"id": 1002}]
    yield [{"id": 1003}]

for page in fetch_order_pages():
    for o in page:
        print(o["id"])

```
迭代协议的工程价值在于把“数据来源”与“数据消费”解耦。订单系统里数据来源可能是数据库游标、文件流、网络分页接口，数据消费可能是校验、转换、落库、统计。把来源做成可迭代对象，你就能在不改消费逻辑的前提下替换来源。面试里如果被追问，你可以强调：迭代器通常一次性，容器通常可重复遍历；写代码时要明确自己传的是哪一种。

#### 惰性求值与性能直觉
生成器与推导式看起来是语法糖，但它们背后的核心是惰性求值与内存友好。订单系统里非常常见的工作是批量处理与报表导出，如果你把所有中间结果都堆进列表，内存会很快成为瓶颈。惰性求值的价值是把计算推迟到真正需要的时候，并且让你能以流式方式处理大数据集。

推导式会立即构造一个列表、集合或字典，而生成器表达式只会生成一个可迭代对象，元素按需产生。面试里通常会问“生成器和列表推导式有什么区别”，你可以从两点回答：内存与一次性消费。列表推导式适合数据量可控、需要复用结果的场景；生成器适合数据量大、一次性处理的流水线场景。订单系统的导出任务通常更适合生成器，后台页面的小列表通常更适合列表推导式。

下面用订单过滤与统计示例展示差异。你会看到生成器表达式把数据按需提供给 sum，这样中间不会构造额外列表。示例里不追求跑分，而是让你形成写法习惯。

```python

推导式还有一个容易被追问的细节是变量作用域。在 Python 3 里，列表推导式的循环变量有自己的局部作用域，不会像早期版本那样“泄露”到外层作用域，这能减少一些意外覆盖。工程里你不应该依赖推导式变量名在外层是否存在，而是用清晰命名避免遮蔽；面试里你只要知道 Python 3 的推导式变量不会泄露这一点就够了。
# ordersys/lazy_demo.py
orders = [{"id": 1001, "amount_cents": 100}, {"id": 1002, "amount_cents": 200}, {"id": 1003, "amount_cents": 0}]
total = sum(o["amount_cents"] for o in orders if o["amount_cents"] > 0)
print(total)

positive = [o for o in orders if o["amount_cents"] > 0]
print(len(positive))

```

```

```
惰性并不是永远更好。工程上你要看是否需要重复遍历、是否需要随机访问、是否需要多次消费。生成器一旦被消费就会耗尽，如果你后面还要用同一批数据做第二次处理，你就应该把它 materialize 成列表，或者让数据源本身支持重复遍历。面试里把“惰性是工具，不是信仰”这句话说出来，会更稳。

### 函数增强
#### 装饰器与 functools
装饰器是 Python 面试的必考点之一，因为它同时考闭包、可调用对象、函数签名与工程实践。订单系统里装饰器最常见的用途是横切关注点，例如记录耗时、统一异常转换、打审计日志、做幂等控制。装饰器的核心语义是把一个可调用对象作为输入，返回一个新的可调用对象，从而在不修改原函数调用点的情况下增加行为。

理解装饰器，最好从调用关系入手。`@decorator` 等价于 `func = decorator(func)`。装饰器内部通常会定义一个 wrapper，wrapper 捕获外部变量形成闭包，然后在 wrapper 里调用原函数。面试里经常会追问“为什么装饰器会导致函数名变了”，这是因为 wrapper 替换了原函数对象；工程里用 `functools.wraps` 把原函数的元信息拷回 wrapper，避免调试与文档生成混乱。

下面用订单服务的耗时记录装饰器做示例，并用 wraps 保留函数名。你会看到调用点完全不变，但行为增加了耗时日志，这是装饰器在工程里最直接的价值。

```python
# ordersys/decorator_timing.py
import time
import functools

def timed(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        try:
            return func(*args, **kwargs)
        finally:
            cost_ms = (time.perf_counter() - start) * 1000
            print(f"{func.__name__} cost={cost_ms:.2f}ms")
    return wrapper

@timed
def load_order(order_id: int) -> dict:
    time.sleep(0.01)
    return {"id": order_id, "status": "NEW"}

print(load_order(1001))

```
装饰器在订单系统里常被滥用的点是把业务逻辑也塞进去，导致调用路径难以追踪。工程上更稳的原则是装饰器只做横切关注点，并且保持行为可预测、可测试。面试里你把语义讲清楚，再补一句“工程上要注意可读性与调试成本”，就很像写过真实项目。

#### 上下文管理器与 contextlib
上下文管理器是 Python 在资源管理上最重要的协议之一，也是面试高频。订单系统里你会打开文件、持有锁、使用连接、进入临界区，这些都需要保证退出时释放资源。`with` 的价值是把获取与释放语义固定成一对，无论中间是否抛异常，退出逻辑都会执行，从而减少漏释放导致的隐性问题。

上下文管理器协议由 `__enter__` 与 `__exit__` 定义。`with expr as x:` 会先调用 `expr.__enter__()`，把返回值绑定给 x，然后执行块体，最后无论正常结束还是异常结束都会调用 `__exit__`。`__exit__` 接收异常信息，你可以选择吞掉异常或让异常继续抛出。工程里吞异常要非常谨慎，订单系统更常见的是记录并继续抛出，让上层统一处理。

下面示例用一个“订单处理锁”模拟上下文管理器。它不依赖真实线程锁，只表达协议语义。你在面试里能把 enter/exit 说清楚，再说清楚异常路径也会走 exit，基本就能过这一题。

```python
# ordersys/context_demo.py
class OrderLock:
    def __init__(self, order_id: int) -> None:
        self.order_id = order_id
        self.locked = False

    def __enter__(self) -> "OrderLock":
        self.locked = True
        print("lock", self.order_id)
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        self.locked = False
        print("unlock", self.order_id)

with OrderLock(1001):
    print("process order")

```

```

```
工程上上下文管理器还常用于“临时切换上下文”，例如临时设置某个配置、临时切换当前用户、临时打补丁，这类场景通常用标准库 `contextlib` 来写更轻。我们会在这一章的同名小节里继续用订单系统示例把它落地，但你先把协议语义记牢：with 不是语法糖，而是资源边界的保证。

### 模块与导入
#### import 机制与包结构
导入机制是面试里很容易被问到、但又常常被低估的部分，因为它直接影响项目结构与线上可运行性。订单系统一旦从单文件长成包，你就会遇到相对导入、循环导入、入口副作用、以及导入路径依赖工作目录等问题。工程里很多启动失败并不是业务逻辑错，而是导入方式不稳定导致的。

导入的过程可以简化理解为三步：先看模块缓存是否已存在，再根据导入路径定位模块文件，找到后执行模块顶层代码并把模块对象缓存起来。面试常问的点是导入会执行模块代码吗，答案是会执行一次；再次导入默认复用缓存，不会重复执行。这个机制解释了为什么模块顶层不应该写重业务副作用，例如连接数据库或执行订单处理，否则导入时机一变就会产生不可控行为。

循环导入是导入机制里最常见的工程痛点。它往往来自两个模块互相依赖对方的顶层对象，例如 `service.py` 顶层 import `repo.py`，同时 `repo.py` 顶层又 import `service.py`，结果某个模块在执行到一半时就被另一个模块引用，得到的是不完整对象。解决思路通常不是靠技巧绕开，而是重新划分边界，例如把共享的类型与常量抽到第三个模块，把依赖方向单向化，或者把某些 import 延迟到函数内部，但延迟 import 只是止血，长期仍然要靠边界拆分。

下面用一段“共享类型抽离”的伪结构表达拆分方式。你面试时不需要把它跑起来，但要能说清楚：循环导入不是 Python 神秘 bug，它是依赖方向混乱导致的，拆分共享层让依赖单向化是更稳的解决方式。

```python

你也可能会被问到 `importlib.reload`。它确实可以强制重新执行模块顶层代码，但工程里很少把 reload 当成常规手段，因为它会让模块状态与依赖关系变得难以推断，容易引入更隐蔽的问题。真正的解决方案通常仍然是入口重启、边界拆分、以及减少模块顶层副作用。
# ordersys/contracts.py
from dataclasses import dataclass

@dataclass(frozen=True)
class OrderKey:
    order_id: int
    channel: str

```

```

```python

```python
# ordersys/service.py
from ordersys.contracts import OrderKey

def load_order(key: OrderKey) -> dict:
    return {"id": key.order_id, "channel": key.channel}

```

```

```
工程里更稳的运行方式仍然是模块方式启动，保持包上下文稳定，这样相对导入也更可靠。你在面试里把“导入执行一次并缓存”“顶层不要做副作用”“循环导入靠边界拆分解决”这三点讲清楚，导入机制这一题就稳了。

```python
# ordersys/runtime_entry.py
def bootstrap() -> None:
    print("wire dependencies")

def main() -> None:
    bootstrap()
    print("start server")

if __name__ == "__main__":
    main()

```
循环导入是导入机制里最常见的工程痛点。它往往来自两个模块互相依赖对方的顶层对象。解决思路通常不是用技巧绕开，而是重新划分边界，例如把共享的类型与常量抽到第三个模块，把依赖方向单向化。面试里你能把“导入执行一次并缓存”“顶层不要做副作用”“循环导入靠边界拆分解决”这三点讲清楚，基本就够了。

### 并发模型
#### GIL 与并发选型
GIL 是 Python 并发面试里绕不过去的概念，但它也最容易被误解。你不需要把它讲成解释器实现细节课，你只需要把工程结论讲清楚：GIL 会限制 CPython 在同一进程内同一时刻只有一个线程执行 Python 字节码，所以 CPU 密集型任务用多线程通常得不到线性加速；但 IO 密集型任务可以用多线程提高吞吐，因为线程在等待 IO 时会释放 GIL；多进程可以绕开 GIL 利用多核；asyncio 通过单线程事件循环在 IO 场景下提升并发。

订单系统里典型的 CPU 密集型任务不多，但也不是没有，例如大批量签名计算、复杂压缩、图片处理或某些加密操作。典型的 IO 密集型任务很多，例如数据库访问、网络请求、文件读写。面试问 GIL，本质是在看你能不能选对并发模型。你如果能把“CPU 用进程、IO 用线程或异步”说清楚，并说明选择取决于瓶颈，就算回答得很工程。

下面的表把 GIL 相关的选型直觉写清楚。它不是绝对规则，但足够覆盖多数订单系统场景。

| 任务类型 | 主要瓶颈 | 更常用的并发方案 | 订单系统例子 |
| --- | --- | --- | --- |
| CPU 密集 | 计算 | 多进程或下沉到原生库 | 大批量加密、压缩 |
| IO 密集 | 等待 | 多线程或 asyncio | 调第三方、查 DB、读写文件 |
| 混合 | 两者都有 | 分层拆分 | 先 IO 拉数据，再 CPU 计算 |

这节不放跑分代码，因为面试更在意你能不能把选型讲清楚。后面两节线程/进程与 asyncio 会给出可运行的最小示例，你把它们串起来，就能回答大多数并发相关问题。

还有一个容易被追问的细节是“为什么有些多线程程序看起来也能跑得快”。原因通常不是 GIL 消失了，而是线程在等待 IO 时会让出执行权，或者底层调用的 C 扩展在执行耗时工作时释放了 GIL，让别的线程有机会运行。工程上的结论仍然按瓶颈选型：CPU 密集型优先多进程或下沉到原生库，IO 密集型可以用线程或 asyncio 提升吞吐。
#### 线程与进程
线程与进程在订单系统里都是常用工具，但它们解决的问题不同。线程共享同一进程内存，创建与切换成本低，适合 IO 并发；进程有独立内存空间，隔离性强，适合 CPU 并行或需要隔离的任务。面试里问线程与进程，通常会追问共享状态与通信方式，也会追问为什么多线程要加锁，以及如何避免死锁与竞态。

线程的核心风险来自共享可变状态。订单系统里最常见的是共享缓存、共享计数器、共享连接对象。如果多个线程同时修改同一个对象，结果取决于调度时机，会出现偶发错误。工程里最稳的策略是减少共享，让数据尽量不可变或线程内私有；确实要共享时，用锁保护临界区，或者使用线程安全的数据结构。进程的共享问题更少，因为内存隔离，但代价是进程间通信与序列化开销更大，且对象必须可序列化才能跨进程传输。

下面用线程池模拟“并发拉取订单状态”，并用进程池模拟“并行计算一批签名”。示例非常小，只强调使用方式与语义。真实工程里你还需要加超时、重试与限流，这些会在工程化章节统一处理。

```python
# ordersys/pool_demo.py
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor

def fetch_status(order_id: int) -> str:
    return f"{order_id}:NEW"

def heavy_sign(order_id: int) -> str:
    s = 0
    for i in range(200000):
        s += (order_id * 31 + i) % 97
    return f"{order_id}:{s}"

with ThreadPoolExecutor(max_workers=4) as tp:
    results = list(tp.map(fetch_status, [1001, 1002, 1003, 1004]))
    print(results)

with ProcessPoolExecutor(max_workers=2) as pp:
    results = list(pp.map(heavy_sign, [1001, 1002, 1003, 1004]))
    print(results[:2])

```
面试里你可以把结论讲得很直接：线程适合 IO 并发，进程适合 CPU 并行；线程有共享状态风险，需要锁或减少共享；进程有序列化与 IPC 成本，适合边界清晰的大任务。把这套取舍讲清楚，就已经达到了“能上生产”的水平。

#### asyncio（协程/任务/取消/超时）
asyncio 在订单系统里通常用在高并发 IO 场景，例如大量并发调用第三方接口、并发拉取状态、并发写入缓存。它的核心模型是单线程事件循环，协程在遇到 await 的 IO 操作时把控制权交回事件循环，从而让同一线程能“同时处理很多等待中的任务”。面试问 asyncio，最常见的追问是协程与线程的区别、任务调度、取消与超时语义。

协程不是线程，它不会在多个 CPU 核上并行执行 Python 字节码，它依赖 await 点进行协作式切换。你如果在协程里写 CPU 密集型循环，不仅不会更快，还会阻塞整个事件循环，让所有并发任务都卡住。工程上 asyncio 的正确用法是把 IO 操作做成 await，把 CPU 重活下沉到线程池或进程池，或者交给原生库执行。取消与超时也是必须讲清楚的点。任务取消是通过抛出 `CancelledError` 实现的，代码需要在合适的 await 点响应取消；超时通常用 `asyncio.wait_for` 包裹 await，这会在超时后取消底层任务并抛异常。

下面用一个最小示例模拟并发拉取订单状态，并展示超时包装。示例里用 `asyncio.sleep` 模拟 IO 等待，结构与真实网络请求非常接近。你在面试里把“await 让出控制权”“取消通过异常传播”“超时通过 wait_for 包裹”讲清楚，基本就够了。

```python

取消相关的一个工程要点是清理资源。协程的取消通过抛出异常传播，如果你在协程里持有资源或需要做收尾，就应该把清理放在 `try/finally`，或者使用异步上下文管理器来保证退出时释放。面试里你把“取消=异常传播、清理=finally/上下文管理器”说清楚，就能应对大多数追问。
# ordersys/async_demo.py
import asyncio

async def fetch_status(order_id: int) -> str:
    await asyncio.sleep(0.01)
    return f"{order_id}:PAID"

async def main() -> None:
    tasks = [asyncio.create_task(fetch_status(i)) for i in [1001, 1002, 1003]]
    results = await asyncio.gather(*tasks)
    print(results)

async def main_with_timeout() -> None:
    try:
        r = await asyncio.wait_for(fetch_status(1001), timeout=0.001)
        print(r)
    except asyncio.TimeoutError:
        print("timeout")

asyncio.run(main())
asyncio.run(main_with_timeout())

```
工程里是否选择 asyncio，取决于你的栈与团队习惯。很多 Web 框架已经提供异步能力，但异步会引入新的复杂度，例如资源池的异步版、上下文传递、调试难度。面试里最稳的回答是：asyncio 适合 IO 并发，能够在单线程下提升吞吐；要注意不要在协程里做 CPU 重活；要把取消与超时作为一等公民处理，不然高并发下会出现任务泄漏。

### 类型与序列化
#### typing 与注解实践
类型标注在国内面试里越来越常见，因为它直接影响可维护性与团队协作。Python 的类型标注不是强制的，它更多是文档与工具链的契约，配合 mypy 或 pyright 能在开发阶段发现大量低级错误。订单系统里类型标注的价值尤其明显：字段很多、数据形态多、边界复杂，写清楚输入输出类型能减少误用，也能让 IDE 提示更可靠。

工程上最实用的标注通常集中在函数签名与领域模型上。服务层方法的参数与返回值写清楚，调用点就不容易传错；模型字段写清楚，序列化与反序列化时就能有更明确的边界。你不需要在面试里把 typing 的所有高级玩法背出来，但你需要掌握最常用的一组：`list[str]`、`dict[str, int]`、`Optional[T]` 或 `T | None`、`Callable`、以及用 `Protocol` 表达能力约束。订单系统里尤其推荐用 `TypedDict` 表达字典形态的结构数据，让你在保留 dict 灵活性的同时获得结构约束。

下面的表把最常见的标注形态按订单系统场景对照一下。面试里你按“我会在边界处标注，让调用方不容易传错”去讲，比背语法更像工程实践。

| 标注形态 | 表达的意思 | 订单系统里的例子 |
| --- | --- | --- |
| `list[Order]` | 列表元素类型 | 查询结果列表 |
| `dict[str, int]` | 映射键值类型 | 状态计数映射 |
| `Order | None` | 可缺省 | 未找到订单返回 None |
| `Callable[[int], int]` | 策略函数 | 折扣策略 |
| `Protocol` | 能力接口 | 支付网关能力 |

示例用 `TypedDict` 定义订单结构，并写一个带返回类型的查询函数。这样写的直接好处是你在使用 `order["status"]` 时能得到类型提示，减少拼错字段名的低级 bug。

```python

类型标注写法和 Python 版本有关。`list[str]`、`dict[str, int]` 这种内置泛型写法通常要求 3.9+；`T | None` 这种联合类型写法要求 3.10+。如果团队还在更低版本，常见等价写法是使用 `typing.List`、`typing.Dict`、`typing.Optional[T]`。面试里如果对方问线上版本，你可以顺势说明你会按版本选择写法，并让工具链（mypy/pyright）在 CI 里把接口契约卡住。
# ordersys/typing_demo.py
from typing import TypedDict

class OrderDict(TypedDict):
    id: int
    status: str
    amount_cents: int

def find_order(order_id: int) -> OrderDict | None:
    if order_id == 1001:
        return {"id": 1001, "status": "NEW", "amount_cents": 3000}
    return None

o = find_order(1001)
print(o["status"] if o is not None else "missing")

```
类型标注不是为了让 Python 变成 Java，而是为了让边界更清晰，让工具帮你挡住一部分错误。面试里你只要把这个定位说清楚，并能写出常见标注，就已经是“工程向熟练”。

#### json/pickle/copy 边界
序列化与拷贝是订单系统里非常实际的一块内容。你要做 API 响应、消息投递、缓存落盘，就要把对象变成可传输的表示；你要避免共享引用带来的联动修改，就要明确拷贝策略。面试在这一节通常会追问 json 与 pickle 的差别，以及浅拷贝与深拷贝的边界。

JSON 的定位是跨语言的数据交换格式，它只支持有限的数据类型，强调可读与可互操作。订单系统的对外 API 与消息体通常都用 JSON。pickle 的定位是 Python 对象的序列化，它几乎什么都能序列化，但它是 Python 专用，并且反序列化是不安全的，不能对不可信数据使用。工程里 pickle 更多用于进程间传输或内部缓存，不用于跨服务边界。面试里你只要明确说出“pickle 不要反序列化不可信输入”，这一点非常关键。

拷贝方面，浅拷贝只复制外壳，深拷贝复制对象图。订单系统里你更常用的是显式重建关键字段，而不是无脑 deepcopy，因为 deepcopy 的成本高，也可能复制到不该复制的资源对象。基础章节里已经用订单对象演示过拷贝边界，这里把它放回“序列化与边界”的语境里，强调为什么序列化常常也是一种“隔离策略”，例如把对象 dump 成 JSON 再 load 回来，你得到的是一份新对象图，但这种隔离也有成本与类型损失。

下面用表把 json 与 pickle 的取舍写出来，再用一个最小示例展示 json 的常见用法。示例仍然围绕订单对象，保持语境一致。

| 方案 | 适用边界 | 优点 | 风险/代价 | 订单系统建议 |
| --- | --- | --- | --- | --- |
| json | 跨语言/对外 | 通用、可读 | 类型受限 | API 与消息体首选 |
| pickle | Python 内部 | 表达能力强 | 不安全、不可互操作 | 仅内部可信数据 |
| copy/deepcopy | 进程内 | 保留类型 | 成本可高 | 优先显式重建 |

```python
# ordersys/json_demo.py
import json

order = {"id": 1001, "status": "PAID", "amount_cents": 3000}
payload = json.dumps(order, ensure_ascii=False)
print(payload)

decoded = json.loads(payload)
print(decoded["status"])

```
面试里把这一节的结论讲清楚就够了：对外用 JSON；pickle 只用于可信内部并谨慎使用；拷贝优先显式重建关键字段，deepcopy 不是默认选项。你能把这些边界说清楚，基本就不会在这一块翻车。

## Python 工程化

### 项目形态
#### 项目组织与入口约定
当订单系统从“能跑的脚本”长成“能长期维护的项目”，项目结构就不再是审美问题，而是可测试、可部署、可协作的基础。面试问项目结构，通常想确认你是否知道入口该放哪里、业务代码该放哪里、测试怎么组织、以及导入路径是否稳定。工程上最常见的目标是让任何人拿到仓库后，用同一套命令就能运行、测试、打包，而不是依赖某个人本地的工作目录与隐含配置。

结构的核心是把边界分开。入口负责启动与装配依赖，不承载业务逻辑。业务逻辑放在可导入模块里，便于复用与测试。脚本与工具与服务入口分离，避免把一次性工具与服务生命周期绑在一起。测试与代码同层组织，能够明确地从公共 API 进入，而不是直接 import 私有实现细节。订单系统里常见的落地是 `ordersys/` 作为包，`ordersys/app.py` 或 `ordersys/__main__.py` 作为入口，`tests/` 放测试。

下面用一张表把“目录里该放什么”说清楚。它不追求唯一正确，但它体现了稳定的工程意图：让导入、运行、测试三件事都不依赖工作目录。

| 目录/文件 | 主要职责 | 订单系统里放什么 | 常见误区 |
| --- | --- | --- | --- |
| `ordersys/` | 业务包 | 模型、服务、适配器、工具 | 把启动逻辑塞进导入阶段 |
| `ordersys/app.py` | 入口 | 组装依赖、启动服务/任务 | 入口里写大段业务 |
| `ordersys/__main__.py` | 模块入口 | 支持 `python -m ordersys` | 依赖工作目录运行 |
| `tests/` | 测试 | 单测、集成测试 | 测试直接改全局状态 |
| `pyproject.toml` | 配置中心 | 依赖、工具配置 | 工具配置分散难同步 |

示例展示一个最小入口文件的形态。入口只做装配与调用，不在导入时做副作用。你在面试里可以把它说成一句工程原则：入口薄、模块厚，模块可导入可测试。

```python
# ordersys/app.py
from ordersys.service import create_order

def main() -> None:
    order = create_order(7, 3000, source="web")
    print(order)

if __name__ == "__main__":
    main()

```
项目结构这块最容易踩的坑是导入路径与运行方式不一致。工程上更稳的做法是统一用 `python -m ordersys.app` 或让入口在包内并通过模块方式启动，这样相对导入与包上下文都稳定。基础章节已经解释过脚本与模块执行的差异，这里把它落到工程组织上，你就能回答“为什么我的代码在本地能跑上线不行”这类真实问题。

#### 配置与环境区分
配置管理是订单系统工程化里最容易被低估的一块。面试问配置，通常会追问你如何区分开发与生产、如何避免把密钥写进代码、如何让配置变更可追踪可回滚。工程里最稳的策略是把配置分层：代码里只放默认值与结构，环境变量与配置文件提供运行时差异，敏感信息只从安全渠道注入，最终在启动时汇总成一个明确的配置对象供业务层使用。

分层的意义是减少偶发差异。你不希望某个同事本地能跑只是因为他机器上恰好有某个文件。你也不希望线上行为改变是因为某个模块 import 时偷偷读取了环境变量。配置应该在入口处统一加载，形成一个显式对象，然后注入到依赖中。订单系统里这通常体现为数据库连接串、第三方渠道密钥、超时与重试参数、日志级别等。

下面用表把常见配置来源与优先级写清楚。面试里你把“优先级与敏感信息处理”讲清楚，比背工具名称更像工程经验。

| 配置来源 | 是否进仓库 | 典型内容 | 建议优先级 |
| --- | --- | --- | --- |
| 代码默认 | 是 | 默认超时、默认开关 | 最低 |
| 配置文件 | 视情况 | 本地开发参数 | 中 |
| 环境变量 | 否 | 运行环境差异、密钥引用 | 高 |
| 密钥管理 | 否 | 真实密钥与证书 | 最高 |

示例用一个简单的配置对象把环境变量与默认值汇总起来，并在入口处完成加载。示例不依赖第三方库，只表达工程结构；真实项目可以引入更成熟的配置库，但原则不变：集中加载、显式注入、敏感信息不落盘。

```python
# ordersys/config.py
import os
from dataclasses import dataclass

@dataclass(frozen=True)
class Settings:
    db_url: str
    log_level: str
    request_timeout_s: float

def load_settings() -> Settings:
    return Settings(
        db_url=os.getenv("ORDERSYS_DB_URL", "sqlite:///orders.db"),
        log_level=os.getenv("ORDERSYS_LOG_LEVEL", "INFO"),
        request_timeout_s=float(os.getenv("ORDERSYS_TIMEOUT_S", "2.0")),
    )

```

```

```python

```python
# ordersys/app.py
from ordersys.config import load_settings

def main() -> None:
    settings = load_settings()
    print(settings)

if __name__ == "__main__":
    main()

```
配置这块面试常见的进一步追问是“如何做环境分层与回滚”。工程答案通常是把配置变更当成发布的一部分，线上配置可追踪，回滚时配置也能回滚；同时避免把业务逻辑依赖在“某个字符串值”上，把配置解析成明确的类型与枚举语义，减少运行时错误。

### 依赖与构建
#### 依赖管理与锁定策略
依赖管理这件事在订单系统里直接决定了可复现性。面试问 pip/锁定策略，通常想确认你是否理解“声明依赖”和“锁定依赖”的区别。声明依赖是告诉别人你需要哪些库，锁定依赖是告诉别人你需要这些库的哪些具体版本。没有锁定，今天装出来能跑，过两周同样的命令可能就跑不起来，线上故障很难复现。

虚拟环境负责隔离，依赖声明负责表达，锁定负责稳定。工程里最重要的实践是让 CI 成为“可复现性裁判”：CI 用干净环境安装依赖并跑测试，通过就说明依赖集合在当前锁定下可用。订单系统里如果你有多个组件，例如 API 服务与离线任务，它们可以共用一套依赖也可以拆分，但无论如何，依赖版本应该在仓库里有清晰来源，避免“某个人电脑上装了什么”决定系统行为。

下面的表把常见依赖文件与锁定思路放在一起。不同团队工具链不同，但面试里你把“声明与锁定分别解决什么”讲清楚就够了。

| 形式 | 作用 | 优点 | 代价 | 订单系统里常见用法 |
| --- | --- | --- | --- | --- |
| requirements.txt | 声明/固定依赖 | 简单直接 | 工具生态分散 | 传统项目与脚本 |
| constraints.txt | 约束版本上限 | 与声明分离 | 维护成本 | 多项目共享约束 |
| pyproject.toml | 统一配置 | 现代、集中 | 需要工具链 | 新项目主流 |

示例展示如何在代码里打印依赖版本以辅助排查“线上与本地不一致”。你不需要在面试里展示命令，但你需要知道：版本不一致是问题的一大来源，排查时要能快速确认依赖版本。

```python
# ordersys/version_probe.py
import importlib.metadata as md

def show(pkg: str) -> None:
    try:
        print(pkg, md.version(pkg))
    except md.PackageNotFoundError:
        print(pkg, "not installed")

show("requests")
show("pytest")

```
依赖管理的工程底线是可复现。你在面试里如果能把“隔离 + 声明 + 锁定 + CI 验证”串成一条链路，通常就会被认为具备工程化能力。

#### 构建与发布（pyproject 工具链）
打包与发布听起来像偏运维，但在 Python 工程里它和“如何交付一个可运行组件”直接相关。订单系统可能需要被打成一个可安装包，供多个服务复用；也可能需要生成一个可执行入口，供容器或部署脚本直接启动。面试问 pyproject 与打包，通常会追问你如何组织元数据、如何暴露命令行入口、以及如何让构建可复现。

`pyproject.toml` 的价值是把项目元数据、依赖与工具配置集中到一个位置。构建系统与安装工具会读取它，从而知道如何构建与安装。对订单系统来说，最实用的一点是入口点。你可以声明一个命令行命令，例如 `ordersys`，它指向 `ordersys.app:main`，这样用户安装后就能直接运行，而不需要记住 python -m 的模块路径。工程上这也让容器启动命令更稳定。

下面用一段最小的 pyproject 片段表达“可安装包 + 入口点”的形态。你不需要在笔记里把每个字段背下来，但你要知道入口点能把运行方式固定下来，这会显著减少部署差异。

`pyproject.toml` 片段（示例）

```toml
[project]
name = "ordersys"
version = "0.1.0"
dependencies = []

[project.scripts]
ordersys = "ordersys.app:main"

```

打包发布这块的工程结论是：发布物要可安装、入口要稳定、版本要可追踪。面试里如果追问“如何做版本号”，你可以说遵循语义化版本或团队规范，重要的是版本与变更日志可追踪；如果追问“如何保证构建一致”，你可以说锁定依赖、在 CI 里构建、用干净环境验证安装与运行。

### 测试与质量
#### 测试体系（pytest 与策略）
测试是订单系统工程化里最直接的质量门槛。面试问 pytest，通常不只是问你会不会写断言，而是看你是否理解测试的组织方式、隔离方式，以及如何让测试稳定可维护。pytest 的心智模型可以非常简单：测试函数是入口，fixture 提供依赖，参数化扩展覆盖面，标记与插件扩展测试类型。你不需要把它讲成框架教程，但你要能把“测试边界”讲清楚。

订单系统里最值得优先测试的是业务规则与边界条件，例如金额校验、状态迁移、幂等行为、异常转换。测试不应该依赖真实外部网络或真实数据库，除非你明确写的是集成测试并在 CI 里有对应环境。单元测试强调快与确定性，所以依赖应当被替换或隔离。你在面试里把“单测不碰外部依赖”“用 fixture 管理依赖”讲清楚，就很稳。

下面的示例用订单状态迁移做一个最小测试，并演示 pytest 的断言风格。示例不追求花哨，但它体现了工程上的目标：把规则写成可测试的函数或方法。

在订单系统里，fixture 的价值是把依赖与测试数据的构造集中起来，保证测试之间相互隔离。参数化的价值是用同一套断言覆盖更多边界条件，尤其适合金额、状态迁移、输入校验这种规则类逻辑。mock 的价值是把外部依赖替换掉，让单测不触网、不连真实数据库，保持快与确定性。

下面的示例把三件事放在一起：fixture 提供一个最小 Order 对象，参数化覆盖不同输入，mock 替换掉外部支付网关调用。示例仍然保持 ordersys 语境，但为了让 pytest 能直接运行，这里写成 tests 里的测试文件形态。

```python

mock 最适合放在外部边界，例如支付网关、HTTP 请求、数据库访问，这样单测可以保持快与确定性。核心业务规则尽量写成纯函数或模型方法直接测，避免把大量逻辑藏在 mock 交互里，否则测试会变脆，重构成本很高。
# tests/test_payment_service.py
import pytest
from unittest.mock import Mock

class Order:
    STATUS_NEW = "NEW"
    STATUS_PAID = "PAID"

    def __init__(self, order_id: int, amount_cents: int) -> None:
        self.id = order_id
        self.amount_cents = amount_cents
        self.status = Order.STATUS_NEW

def pay_order(order: Order, gateway) -> str:
    if order.amount_cents <= 0:
        raise ValueError("amount must be positive")
    resp = gateway.pay(order.id, order.amount_cents)
    order.status = Order.STATUS_PAID
    return resp

@pytest.fixture
def order() -> Order:
    return Order(order_id=1001, amount_cents=3000)

@pytest.mark.parametrize("amount_cents", [1, 3000, 999999])
def test_pay_order_ok(order: Order, amount_cents: int):
    order.amount_cents = amount_cents
    gateway = Mock()
    gateway.pay.return_value = "ok"
    r = pay_order(order, gateway)
    assert r == "ok"
    assert order.status == Order.STATUS_PAID
    gateway.pay.assert_called_once_with(order.id, amount_cents)

@pytest.mark.parametrize("amount_cents", [0, -1])
def test_pay_order_bad_amount(order: Order, amount_cents: int):
    order.amount_cents = amount_cents
    gateway = Mock()
    with pytest.raises(ValueError):
        pay_order(order, gateway)
    gateway.pay.assert_not_called()

```
面试里你可以把这套说成一句话：fixture 管构造与隔离，参数化管覆盖，mock 管外部依赖替换；单测优先覆盖规则与边界，不去触碰不稳定依赖，集成测试再单独跑在可控环境里。
`tests/test_order_status.py`

```python
import pytest

class Order:
    STATUS_NEW = "NEW"
    STATUS_PAID = "PAID"

    def __init__(self) -> None:
        self.status = Order.STATUS_NEW

    def mark_paid(self) -> None:
        if self.status != Order.STATUS_NEW:
            raise RuntimeError("illegal transition")
        self.status = Order.STATUS_PAID

def test_mark_paid_ok():
    o = Order()
    o.mark_paid()
    assert o.status == Order.STATUS_PAID

def test_mark_paid_illegal():
    o = Order()
    o.status = Order.STATUS_PAID
    with pytest.raises(RuntimeError):
        o.mark_paid()

pytest 这一节的工程落点是让测试成为日常开发的一部分。你在面试里如果能说清楚“我优先测规则与边界，外部依赖用替身，测试要稳定可重复”，基本就能证明你具备工程交付意识。

```

#### 代码质量（格式化/lint/类型检查）
代码质量工具链在 Python 工程里越来越像标配，它解决的是一致性与提前发现问题。面试问 black、ruff、类型检查，通常是在确认你是否理解它们各自负责的层面，以及如何在团队里把它们变成自动化而不是手工约束。最稳的做法是把格式化、lint、类型检查放进 CI，让代码在合并前就通过质量门槛，而不是靠代码评审时人工挑格式问题。

格式化工具关注代码外观一致性，它减少争论，提升可读性。lint 工具关注潜在错误与坏味道，例如未使用变量、可疑比较、可能的 bug 模式。类型检查关注接口契约，尤其在订单系统这种边界复杂的项目里，它能提前发现某个函数返回 None 却被当成字典使用的错误。三者叠加的效果是让大量低级错误在进入运行时之前就被挡住。

下面用一张表把这三类工具的职责边界写清楚。面试里你把“它们解决不同问题，放进 CI 自动执行”讲出来就够了。

| 工具类别 | 解决的问题 | 订单系统里的收益 | 常见误区 |
| --- | --- | --- | --- |
| 格式化 | 风格统一 | 代码评审更聚焦逻辑 | 人工争论缩进与引号 |
| lint | 发现坏味道 | 提前发现潜在 bug | 规则太多导致全员忽略 |
| 类型检查 | 接口契约 | 边界更清晰、重构更稳 | 试图标注一切导致负担 |

工程里你不需要在笔记里写具体命令，但你要知道它们应当被自动化执行。面试里如果追问“你怎么落地”，你可以说在 pre-commit 与 CI 里跑格式化与 lint，类型检查按模块逐步引入，先覆盖核心边界与公共接口，再扩展到更多模块。

### 运行保障
#### 日志、错误边界与可观测
日志、异常边界与可观测性决定了订单系统出问题时你能不能快速止血。面试问这一块，通常会追问你怎么打日志、怎么关联请求、怎么把异常变成可定位的信号。工程里最实用的目标是让任何一次失败都能被关联到业务标识与上下文，例如订单号、用户 id、渠道、请求 id，并且在日志里保留异常堆栈，而不是只留一句失败描述。

异常边界的含义是哪里负责把底层异常转换成业务语义。订单系统里典型分层是适配器层做语义转换并保留根因，服务层做业务策略，入口层做对外返回。适配器层不应该吞异常，它应该把底层细节折叠成业务异常，并把根因挂在异常链上；服务层拿到业务异常后决定是否重试、是否降级、是否落库补偿；入口层决定如何映射到 HTTP 响应或任务失败状态。

为了让这条链路更具体，这里把订单系统里最常见的一组错误边界拉成表。你面试时按“边界在哪里、谁负责什么”去回答，会非常工程。

| 层级 | 责任 | 该做的事 | 不该做的事 |
| --- | --- | --- | --- |
| 适配器 | 语义转换 | `raise ... from e`，补上下文 | 吞异常只打日志 |
| 服务层 | 策略控制 | 重试/降级/补偿/幂等 | 把底层异常直接抛给入口 |
| 入口层 | 对外返回 | 统一错误码/失败状态 | 逐个 try/except 堆在入口 |

示例展示一个带业务上下文的异常转换，并把异常链保留下来。示例不追求真实网络调用，只表达工程结构：记录业务标识，保留堆栈，转换语义，继续抛出让上层决定策略。

为了让团队沟通一致，这里我统一用 adapter/service/entry 三层术语：adapter 负责把外部世界的失败转换成业务语义并保留根因，service 负责业务策略与补偿，entry 负责对外返回与协议映射。你在面试里按这三层去讲，表达会更收敛。

```

面试里你不需要背 contextvars 的 API，但你要能讲清楚目标：给每条日志加上可关联的请求标识，让一次请求在多个模块间可追踪；同步框架通常用中间件实现，异步框架用 contextvars 能更自然地贯穿协程上下文。
# ordersys/errors.py
class PaymentError(Exception):
    pass

```

```

```python

```python
# ordersys/payment_adapter.py
import logging
from ordersys.errors import PaymentError

logger = logging.getLogger("ordersys.payment")

def call_gateway(order_id: int) -> str:
    try:
        raise TimeoutError("gateway timeout")
    except Exception as e:
        logger.exception("gateway failed", extra={"order_id": order_id})
        raise PaymentError(f"payment failed: order_id={order_id}") from e

```

```

可观测性除了日志还包括指标与追踪，但这份笔记以语言与标准库为主，所以把指标与追踪当成概念点到即可。面试里你可以这样说：日志用来定位单次问题，指标用来观察趋势与告警，追踪用来串联跨服务链路。只要你能把日志与异常边界这块讲清楚，就已经具备线上排障的基本能力。

```python

```python
# ordersys/errors.py
class PaymentError(Exception):
    pass

```

```

```
这一节的面试回答重点是分层：底层负责保留细节并转换语义，上层负责策略与对外返回。你能把“异常链 + 业务上下文 + 不吞异常”讲清楚，就已经具备线上排障的基本能力。

#### 性能剖析与优化
性能剖析与优化在订单系统里属于“该懂但不必炫”的能力。面试问性能，通常会追问你如何定位瓶颈，以及你是否理解 IO 与 CPU 的区别。工程上最稳的流程是先测量再优化，避免凭感觉改代码。Python 的性能问题很多时候不是算法题，而是数据表示、无谓拷贝、过度日志、错误的并发模型选择导致的吞吐下降。

剖析的目标是把时间花在哪儿变成事实。你可以用 `cProfile` 这类剖析工具看函数级热点，用 `time.perf_counter` 做局部计时，用采样器在生产环境观察。优化路径往往从减少无谓工作开始，例如避免重复序列化、避免循环里做字符串拼接、避免把大列表反复切片、避免在热路径里做过度日志。订单系统里最常见的性能改善也来自 IO 层，例如减少数据库往返、合理使用批量接口、减少外部调用次数。

下面给出一个最小的局部计时代码，模拟批量处理订单时记录耗时。它体现的是工程习惯：先量化，再决定是否值得优化。更深入的剖析工具属于扩展内容，但面试里你能讲出“我先用剖析定位热点”，通常就足够了。

```python
# ordersys/perf_demo.py
import time

def process_orders(n: int) -> int:
    s = 0
    for i in range(n):
        s += (i * 31) % 97
    return s

start = time.perf_counter()
r = process_orders(200000)
cost_ms = (time.perf_counter() - start) * 1000
print(r, f"{cost_ms:.2f}ms")

```

```

```
性能这一节的工程落点是方法论：先测量、找热点、最小改动验证收益、再决定是否继续。面试里你把这个流程讲出来，比给出某个微优化技巧更像靠谱工程师。

#### 稳定性策略（超时/重试/幂等/限流）
超时、重试、幂等与限流是订单系统“跑得稳”的核心。面试问这一块，往往是在确认你是否知道外部依赖是不可靠的，以及你是否能把失败控制在可预期范围内。订单系统里外部调用很多，支付、风控、库存、通知任何一个环节都可能超时或偶发失败。如果你不设置超时，请求会无限等待，线程或协程会被占住，最终把整个服务拖死。设置超时是底线，重试是策略，幂等是前提，限流是保护。

重试并不是万能的。你必须区分可重试与不可重试，例如网络超时可能可重试，参数错误不可重试。你也必须控制重试的次数与间隔，避免雪崩式放大。幂等的意义是让同一请求重复执行不会造成重复扣款或重复发货，订单系统里通常用幂等键或状态机保证。限流则是在高压下保护系统，让请求以可控速度进入，避免把下游压垮。

下面用一个最小的“带超时与重试”的调用示例表达工程结构。示例不依赖第三方网络库，用 sleep 模拟等待，并演示指数退避。你在面试里不需要背公式，但要能说清楚：超时必设，重试要有边界，幂等是重试的前提，限流是系统保护。

```python

重试之前要先做错误分类。网络抖动、超时、连接重置这类通常可重试，参数错误、权限错误、余额不足这类不可重试；对于下游返回的 5xx 或限流错误是否重试，要结合协议与业务语义。重试次数与间隔要有上限，退避与抖动是为了避免同一时间集中重试造成雪崩放大。

幂等可以用非常朴素的方式落地，例如用幂等键把“已经处理过的请求”记录下来。订单系统里最常见的幂等键是 `(order_id, request_id)` 或 `(order_id, idempotency_key)`，只要这个键稳定，重复请求就可以被安全识别并短路。

```python

```python
# ordersys/idempotency_demo.py
processed: dict[tuple[int, str], str] = {}

def handle_pay(order_id: int, request_id: str) -> str:
    key = (order_id, request_id)
    if key in processed:
        return processed[key]
    result = f"paid:{order_id}"
    processed[key] = result
    return result

print(handle_pay(1001, "req-1"))
print(handle_pay(1001, "req-1"))

```

```

面试里你可以把这段话说成一条链路：超时必设，错误先分类再决定是否重试，重试必须有幂等保证，同时用限流控制并发与入口压力。
# ordersys/retry_demo.py
import time

class RetryableError(Exception):
    pass

def call_remote() -> str:
    raise RetryableError("temporary failure")

def call_with_retry(max_attempts: int, base_sleep_s: float) -> str:
    attempt = 1
    while True:
        try:
            return call_remote()
        except RetryableError:
            if attempt >= max_attempts:
                raise
            time.sleep(base_sleep_s * (2 ** (attempt - 1)))
            attempt += 1

try:
    call_with_retry(3, 0.1)
except Exception as e:
    print("failed", type(e).__name__)

```
这一节的面试回答可以用一条链路来讲：对外调用先设超时，失败按错误类型决定是否重试，重试必须有幂等保证，同时在入口做限流保护服务。你能把这条链路讲清楚，工程稳定性这一关就稳了。

#### 并发与资源治理（池/异步）
并发在工程里的落地不是“线程还是协程”的二选一，而是把并发当成一种资源管理方式。订单系统里你并发的目标通常是提高吞吐与降低尾延迟，但你必须同时考虑限流、超时、取消、以及共享状态的安全。面试问工程并发，通常会追问你如何选型、如何避免线程安全问题、以及如何在并发场景下保证请求可控。

线程池适合 IO 密集型工作，尤其是在大量阻塞调用场景下，它能通过并发等待提高吞吐。进程池适合 CPU 密集型工作，能利用多核。asyncio 适合高并发 IO，并且更容易把超时与取消作为一等公民处理。工程里最常见的落地是把外部调用封装成带超时与重试的函数，然后在上层用线程池或 asyncio 并发执行，同时在入口做并发度控制。你不希望一次性创建几千个线程或几万个任务去打爆下游，工程上需要一个明确的并发上限。

下面示例用线程池并发拉取订单状态，并且在上层显式控制最大并发数。示例的重点不是网络调用，而是工程结构：并发度在入口控制，单个任务本身仍然是可测试的函数。

```python
# ordersys/concurrency_demo.py
from concurrent.futures import ThreadPoolExecutor, as_completed

def fetch_status(order_id: int) -> str:
    return f"{order_id}:NEW"

order_ids = [1001, 1002, 1003, 1004, 1005]
results = []
with ThreadPoolExecutor(max_workers=3) as ex:
    futures = [ex.submit(fetch_status, oid) for oid in order_ids]
    for f in as_completed(futures):
        results.append(f.result())
print(results)

```

```

工程里并发的底线是可控。你能在面试里把“选型依据、并发上限、超时与取消、共享状态最小化”讲清楚，就能证明你不是只会写示例，而是懂得把并发放进真实系统里。

```
