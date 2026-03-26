# Go

## 基础

### 环境

### 数据类型

数据类型指定有效的Go变量可以保存的数据类型。在Go语言中，类型分为以下四类：

* **基本类型：**数字，字符串和布尔值属于此类别。

* **聚合类型：**数组和结构属于此类别。

* **引用类型：**指针，切片，map集合，函数和Channel属于此类别。

* **接口类型**

#### 基本类型

##### 数字类型

在Go语言中，数字分为*三个*子类别：

- **整数：**在Go语言中，有符号和无符号整数都可以使用四种不同的大小，如下表所示。有符号整数使用 `int8`、`int16`、`int32`、`int64` 表示，无符号整数使用 `uint8`、`uint16`、`uint32`、`uint64` 表示。

  | 数据类型    | 描述                                                       |
  | :---------- | :--------------------------------------------------------- |
  | **int8**    | 8位有符号整数                                              |
  | **int16**   | 16位有符号整数                                             |
  | **int32**   | 32位有符号整数                                             |
  | **int64**   | 64位有符号整数                                             |
  | **uint8**   | 8位无符号整数                                              |
  | **uint16**  | 16位无符号整数                                             |
  | **uint32**  | 32位无符号整数                                             |
  | **uint64**  | 64位无符号整数                                             |
  | **int**     | 平台相关的有符号整数，通常为32位或64位。                   |
  | **uint**    | 平台相关的无符号整数，通常为32位或64位。                   |
  | **rune**    | `int32` 的别名，表示一个 Unicode 代码点。                  |
  | **byte**    | `uint8` 的别名。                                           |
  | **uintptr** | 无符号整数类型，专用于存放指针运算，用于存放死的指针地址。 |

- **浮点数：**在Go语言，浮点数被分成2类如示于下表：

  | 数据类型    | 描述               |
  | :---------- | :----------------- |
  | **float32** | 32位IEEE 754浮点数 |
  | **float64** | 64位IEEE 754浮点数 |

- **复数：**将复数分为两部分，如下表所示。float32和float64也是这些复数的一部分。内建函数从它的虚部和实部创建一个复数，内建虚部和实部函数提取这些部分。

  | 数据类型       | 描述                                  |
  | :------------- | :------------------------------------ |
  | **complex64**  | 包含float32作为实数和虚数分量的复数。 |
  | **complex128** | 包含float64作为实数和虚数分量的复数。 |

```go
package main

import "fmt"

func main() {
    var unsignedIntegerValue uint8 = 225
    var signedIntegerValue int16 = 32767
    var floatValue = 20.45
    var complexValue complex128 = complex(6, 2)

    fmt.Println(unsignedIntegerValue)
    fmt.Println(signedIntegerValue)
    fmt.Println(floatValue)
    fmt.Println(complexValue)

    fmt.Printf("%T\n", unsignedIntegerValue) // uint8
    fmt.Printf("%T\n", signedIntegerValue)   // int16
    fmt.Printf("%T\n", floatValue)           // float64，未显式声明时浮点常量默认推导为 float64
    fmt.Printf("%T\n", complexValue)         // complex128

    // **注意**
    // 1. 不同整数类型之间不能直接混用，通常需要显式转换。
    // 2. int 与 uint 的位宽依赖平台。
    // 3. 数值溢出会截断到对应类型的表示范围内。
}
```

##### 布尔类型

布尔数据类型仅表示true或false。布尔类型的值不会隐式或显式转换为任何其他类型。

```go
package main

import "fmt"

func main() {
    var booleanValue bool = true

    comparisonResult := 10 > 5
    logicalResult := true && false

    fmt.Println(booleanValue)      // true
    fmt.Println(comparisonResult)  // true
    fmt.Println(logicalResult)     // false

    fmt.Printf("%T\n", booleanValue)     // bool
    fmt.Printf("%T\n", comparisonResult) // bool
    fmt.Printf("%T\n", logicalResult)    // bool

    // **注意**
    // 1. bool 只有 true 和 false 两个值。
    // 2. 比较表达式和逻辑表达式的结果都是 bool。
    // 3. bool 不会与数值类型互相转换。
}
```

##### 字符串

在Go语言中，字符串不同于其他语言，如Java、c++、Python等。它是一个变宽字符序列，其中每个字符都用UTF-8编码的一个或多个字节表示。或者换句话说，字符串是任意字节(包括值为零的字节)的不可变链，或者字符串是一个只读字节片，字符串的字节可以使用UTF-8编码在Unicode文本中表示。由于采用UTF-8编码，Golang字符串可以包含文本，文本是世界上任何语言的混合，而不会造成页面的混乱和限制。

**注意：**字符串可以为空，但不能为nil。

###### 字符串字面量

在Go语言中，字符串字面量是通过两种不同的方式创建的：

- **使用双引号（""）：**在这里，字符串字面量使用双引号（""）创建。此类字符串支持转义字符，如下表所示，但不跨越多行。

  | 转义符         | 描述                                         |
  | :------------- | :------------------------------------------- |
  | **\\**         | 反斜杠（\）                                  |
  | **\000**       | 具有给定的3位8位八进制代码点的Unicode字符    |
  | **\'**         | 单引号（'）。仅允许在字符文字中使用          |
  | **\"**         | 双引号（"）。仅允许在解释的字符串文字中使用  |
  | **\a**         | ASCII铃声(BEL)                               |
  | **\b**         | ASCII退格键(BS)                              |
  | **\f**         | ASCII换页(FF)                                |
  | **\n**         | ASCII换行符(LF)                              |
  | **\r**         | ASCII回车(CR)                                |
  | **\t**         | ASCII标签(TAB)                               |
  | **\uhhhh**     | 具有给定的4位16位十六进制代码点的Unicode字符 |
  | **\Uhhhhhhhh** | 具有给定的8位32位十六进制代码点的Unicode字符 |
  | **\v**         | ASCII垂直制表符(VT)                          |
  | **\xhh**       | 具有给定的2位8位十六进制代码点的Unicode字符  |

- 使用反引号（\`\`）：使用反引号\`\`创建的，也称为原始文本。原始文本不支持转义字符，可以跨越多行，并且可以包含除反引号之外的任何字符。

```go
package main

import "fmt"

func main() {
    interpretedString := "line1\nline2\tGo"
    rawString := `line1
line2\tGo`

    fmt.Println(interpretedString)
    fmt.Println(rawString)

    // 输出示意:
    // line1
    // line2    Go
    // line1
    // line2\tGo
}
```

###### 字符串包含与索引

- **Contains：**检查给定字符串中是否存在指定子串。

```go
func Contains(str, chstr string) bool
// str: 原始字符串
// chstr: 要检查的子串
// 返回值: 是否包含指定子串
```

- **ContainsAny：**检查给定字符串中是否存在字符集合中的任意 Unicode 字符。

```go
func ContainsAny(str, charstr string) bool
// str: 原始字符串
// charstr: 字符集合
// 返回值: 是否包含任意匹配字符
```

- **Index：**返回指定子串第一次出现的索引值，不存在时返回 `-1`。

```go
func Index(str, sbstr string) int
// str: 原始字符串
// sbstr: 要查找的子串
// 返回值: 第一次出现的字节索引，不存在时返回 -1
```

- **IndexAny：**返回字符集合中任意 Unicode 字符第一次出现的索引值，不存在时返回 `-1`。

```go
func IndexAny(str, charstr string) int
// str: 原始字符串
// charstr: 字符集合
// 返回值: 第一次出现的字节索引，不存在时返回 -1
```

- **IndexByte：**返回指定字节第一次出现的索引值，不存在时返回 `-1`。

```go
func IndexByte(str string, b byte) int
// str: 原始字符串
// b: 要查找的字节
// 返回值: 第一次出现的字节索引，不存在时返回 -1
```

```go
package main

import (
    "fmt"
    "strings"
)

func main() {
    stringValue := "Hello, Go语言"

    containsResult := strings.Contains(stringValue, "Go")
    containsAnyResult := strings.ContainsAny(stringValue, "xyz语")
    indexResult := strings.Index(stringValue, "Go")
    indexAnyResult := strings.IndexAny(stringValue, "xyz语")
    indexByteResult := strings.IndexByte(stringValue, ',')

    fmt.Println(containsResult)    // true
    fmt.Println(containsAnyResult) // true
    fmt.Println(indexResult)       // 7
    fmt.Println(indexAnyResult)    // 9
    fmt.Println(indexByteResult)   // 5

    // **注意**
    // 1. Contains 判断子串。
    // 2. ContainsAny / IndexAny 判断字符集合。
    // 3. Index / IndexAny / IndexByte 返回的都是字节索引。
}
```

* 因为字符串本质是字节序列，其索引操作`str[i]`被设计为返回第 i 个字节，语法上与切片一致，例如访问字符串第一个元素

  ```go
  func main() {
     str := "this is a string"
     fmt.Println(str[0]) // 116
  }
  ```

  输出是字节编码值而不是字符

###### 字符串比较

字符串可以直接使用比较运算符进行比较，也可以使用 `strings.Compare()` 按词法顺序比较。

- **比较运算符：**支持 `==`、`!=`、`>`、`>=`、`<`、`<=`，结果为 `bool`。
- **Compare：**比较两个字符串，返回 `-1`、`0` 或 `1`。

```go
func Compare(str1, str2 string) int
// str1: 第一个字符串
// str2: 第二个字符串
// 返回值:
// -1: str1 < str2
//  0: str1 == str2
//  1: str1 > str2
```

```go
package main

import (
    "fmt"
    "strings"
)

func main() {
    leftString := "Go"
    rightString := "Lang"

    equalResult := leftString == rightString
    greaterResult := leftString > rightString
    compareResult := strings.Compare(leftString, rightString)

    fmt.Println(equalResult)   // false
    fmt.Println(greaterResult) // false
    fmt.Println(compareResult) // -1
}
```

###### 字符串函数

- **Join：**将字符串切片中存在的所有元素连接为单个字符串。

```go
func Join(str []string, sep string) string
// str: 待连接的字符串切片
// sep: 元素之间插入的分隔符
// 返回值: 连接后的字符串
```

- **Trim：**修剪字符串两侧属于指定字符集合的字符。

```go
func Trim(str string, cutstr string) string
// str: 当前字符串
// cutstr: 两侧要修剪的字符集合
// 返回值: 修剪后的字符串
```

- **TrimLeft：**修剪字符串左侧属于指定字符集合的字符。

```go
func TrimLeft(str string, cutstr string) string
// str: 当前字符串
// cutstr: 左侧要修剪的字符集合
// 返回值: 修剪后的字符串
```

- **TrimRight：**修剪字符串右侧属于指定字符集合的字符。

```go
func TrimRight(str string, cutstr string) string
// str: 当前字符串
// cutstr: 右侧要修剪的字符集合
// 返回值: 修剪后的字符串
```

- **TrimSpace：**修剪字符串两侧空白字符。

```go
func TrimSpace(str string) string
// str: 当前字符串
// 返回值: 去除两侧空白后的字符串
```

- **TrimPrefix：**删除固定前缀，未匹配时返回原字符串。

```go
func TrimPrefix(str, prefix string) string
// str: 原始字符串
// prefix: 要删除的前缀
// 返回值: 删除前缀后的字符串
```

- **TrimSuffix：**删除固定后缀，未匹配时返回原字符串。

```go
func TrimSuffix(str, suffix string) string
// str: 原始字符串
// suffix: 要删除的后缀
// 返回值: 删除后缀后的字符串
```

- **Split：**按分隔符拆分字符串，不保留分隔符。

```go
func Split(str, sep string) []string
// str: 原始字符串
// sep: 分隔符
// 返回值: 拆分后的字符串切片
```

- **SplitAfter：**按分隔符拆分字符串，保留分隔符。

```go
func SplitAfter(str, sep string) []string
// str: 原始字符串
// sep: 分隔符
// 返回值: 拆分后的字符串切片，分隔符保留在子串末尾
```

- **SplitAfterN：**按分隔符拆分字符串，并限制返回结果数量。

```go
func SplitAfterN(str, sep string, m int) []string
// str: 原始字符串
// sep: 分隔符
// m: 返回结果数量限制
// 返回值: 拆分后的字符串切片
// m > 0: 最多返回 m 个结果
// m == 0: 返回 nil
// m < 0: 返回全部结果
```

```go
package main

import (
    "bytes"
    "fmt"
    "strings"
)

func main() {
    sourceString := "  prefix_value.go  "
    partSlice := []string{"Go", "Lang"}

    joinResult := strings.Join(partSlice, "-")

    plusResult := "Go" + "-" + "Lang"
    formatResult := fmt.Sprintf("%s-%s", "Go", "Lang")

    var buffer bytes.Buffer
    buffer.WriteString("Go")
    buffer.WriteString("-")
    buffer.WriteString("Lang")
    bufferResult := buffer.String()

    trimResult := strings.Trim(sourceString, " ")
    trimLeftResult := strings.TrimLeft("###value", "#")
    trimRightResult := strings.TrimRight("value***", "*")
    trimSpaceResult := strings.TrimSpace(sourceString)
    trimPrefixResult := strings.TrimPrefix(trimSpaceResult, "prefix_")
    trimSuffixResult := strings.TrimSuffix(trimPrefixResult, ".go")

    splitResult := strings.Split("Go,Java,Python", ",")
    splitAfterResult := strings.SplitAfter("Go,Java,Python", ",")
    splitAfterNResult := strings.SplitAfterN("Go,Java,Python", ",", 2)

    fmt.Println(joinResult)         // Go-Lang
    fmt.Println(plusResult)         // Go-Lang
    fmt.Println(formatResult)       // Go-Lang
    fmt.Println(bufferResult)       // Go-Lang

    fmt.Printf("%q\n", trimResult)       // "prefix_value.go"
    fmt.Printf("%q\n", trimLeftResult)   // "value"
    fmt.Printf("%q\n", trimRightResult)  // "value"
    fmt.Printf("%q\n", trimSpaceResult)  // "prefix_value.go"
    fmt.Printf("%q\n", trimPrefixResult) // "value.go"
    fmt.Printf("%q\n", trimSuffixResult) // "value"

    fmt.Println(splitResult)       // [Go Java Python]
    fmt.Println(splitAfterResult)  // [Go, Java, Python]
    fmt.Println(splitAfterNResult) // [Go, Java,Python]

    // **注意**
    // 1. Trim / TrimLeft / TrimRight 修剪的是字符集合，不是固定子串。
    // 2. TrimPrefix / TrimSuffix 处理固定前后缀。
    // 3. Split 不保留分隔符；SplitAfter 保留分隔符。
}
```

###### 关于字符串的要点

- **字符串是不可变的：**在Go语言中，一旦创建了字符串，则字符串是不可变的，无法更改字符串的值。

- **如何遍历字符串：**可以使用 `for range` 循环按 `rune` 遍历字符串。

```go
for index, chr := range str {
    // index: 当前 rune 的起始字节索引
    // chr: 当前 rune
}
```

- **如何访问字符串的单个字节：**可以使用下标按字节访问字符串内容。

- **如何从切片创建字符串：**允许从 `[]byte` 或 `[]rune` 创建字符串。

- **如何查找字符串的长度：**`len()` 返回字节数，`utf8.RuneCountInString()` 返回 `rune` 数。

```go
package main

import (
    "fmt"
    "unicode/utf8"
)

func main() {
    stringValue := "Go语言"

    fmt.Println(len(stringValue))                     // 8，字节数
    fmt.Println(utf8.RuneCountInString(stringValue)) // 4，rune 数

    for index, runeValue := range stringValue {
        fmt.Printf("%d %c\n", index, runeValue)
    }

    for index := 0; index < len(stringValue); index++ {
        fmt.Printf("%d %v\n", index, stringValue[index])
    }

    byteSlice := []byte{0x47, 0x6f}
    runeSlice := []rune{0x8bed, 0x8a00}

    fmt.Println(string(byteSlice)) // Go
    fmt.Println(string(runeSlice)) // 语言

    // **注意**
    // 1. stringValue[index] 取得的是字节，不一定是完整字符。你可能打印出来的是字节编码。
    // 2. for range 按 rune 遍历，适合处理 Unicode 文本。
    // 3. 字符串不可修改，修改通常需要转为 []byte 或 []rune。
}
```

#### 聚合类型

##### 数组

Go编程语言中的数组与其他编程语言非常相似。由于它们的固定长度，数组不像Go语言中的Slice(切片)这样受欢迎。
在数组中，允许在其中存储零个或零个以上的元素。通过使用[]索引运算符及其从零开始的位置对数组的元素进行索引，这意味着第一个元素的索引为*array [0]*，最后一个元素的索引为*array [len（array）-1]*。

如果事先就知道了要存放数据的长度，且后续使用中不会有扩容的需求，就可以考虑使用数组，Go 中的数组是值类型，而非引用，并不是指向头部元素的指针。数组作为值类型，将数组作为参数传递给函数时，由于 Go 函数是传值传递，所以会将整个数组拷贝。

![Untitled-Diagram33](./assets/Untitled-Diagram33.jpg)

###### 数组声明

在Go语言中，数组可以使用 `var` 关键字或简写声明创建。

- **使用 var 关键字：**适合先声明后赋值，数组长度是类型的一部分。

```go
var arrayName [length]ElementType
// arrayName: 数组变量名
// length: 数组长度，必须是常量
// ElementType: 元素类型
```

```go
var arrayName [length]ElementType{element1, element2, element3}
// arrayName: 数组变量名
// length: 数组长度
// ElementType: 元素类型
// 返回结果: 创建并初始化数组
```

- **使用简写声明：**适合声明时直接初始化。

```go
arrayName := [length]ElementType{element1, element2, element3}
// arrayName: 数组变量名
// length: 数组长度
// ElementType: 元素类型
// 返回结果: 创建并初始化数组
```

```go
arrayName := [...]ElementType{element1, element2, element3}
// ...: 根据初始化元素数量推导数组长度
// 返回结果: 创建长度由元素个数决定的数组
```

- **多维数组：**数组的元素也可以是数组。

```go
var arrayName [length1][length2]ElementType
// length1: 第一维长度
// length2: 第二维长度
// ElementType: 元素类型
```

```go
package main

import "fmt"

func main() {
    var declaredArray [3]string
    declaredArray[0] = "value0"
    declaredArray[1] = "value1"
    declaredArray[2] = "value2"

    initializedArray := [3]int{10, 20, 30}
    inferredArray := [...]int{1, 2, 3, 4}
    matrixValue := [2][2]int{
        {1, 2},
        {3, 4},
    }

    fmt.Println(declaredArray)     // [value0 value1 value2]
    fmt.Println(initializedArray)  // [10 20 30]
    fmt.Println(inferredArray)     // [1 2 3 4]
    fmt.Println(matrixValue)       // [[1 2] [3 4]]

    fmt.Println(declaredArray[0])  // value0
    fmt.Println(matrixValue[1][0]) // 3

    for index, element := range initializedArray {
        fmt.Println(index, element)
    }

    // **注意**
    // 1. 数组长度是类型的一部分，[3]int 和 [4]int 是不同类型。
    // 2. 数组长度固定，创建后不能改变。
    // 3. 未显式初始化的数组元素会取对应类型的零值。
}
```

###### 数组的用法

- **len：**返回数组长度。

```go
len(arrayValue)
// arrayValue: 数组值
// 返回值: 数组长度
```

- **遍历：**可以使用下标循环或 `for range` 遍历数组元素。

```go
for index := 0; index < len(arrayValue); index++ {
    // arrayValue[index]
}
```

```go
for index, element := range arrayValue {
    // index: 当前索引
    // element: 当前元素副本
}
```

- **数组是值类型：**数组赋值会复制全部元素，修改副本不会影响原数组。

```go
copiedArray := sourceArray
// sourceArray: 原数组
// copiedArray: 原数组副本
// 返回结果: 复制后的新数组
```

- **引用复制：**可以通过指针共享同一个数组。

```go
referencedArray := &sourceArray
// sourceArray: 原数组
// referencedArray: 指向原数组的指针
// 返回结果: 通过指针访问原数组
```

- **数组可比较：**如果元素类型可比较，则数组也可比较，可以直接使用 `==`。

```go
leftArray == rightArray
// leftArray: 左侧数组
// rightArray: 右侧数组
// 返回值: 两个数组是否相等
```

```go
package main

import "fmt"

func main() {
    zeroValueArray := [3]int{}
    inferredArray := [...]int{9, 7, 6, 4}
    sourceArray := [...]int{100, 200, 300}
    copiedArray := sourceArray
    referencedArray := &sourceArray

    copiedArray[0] = 999
    referencedArray[1] = 888

    fmt.Println(zeroValueArray)      // [0 0 0]
    fmt.Println(len(inferredArray))  // 4

    for index := 0; index < len(inferredArray); index++ {
        fmt.Println(index, inferredArray[index])
    }

    fmt.Println(sourceArray)       // [100 888 300]
    fmt.Println(copiedArray)       // [999 200 300]
    fmt.Println(*referencedArray)  // [100 888 300]

    equalResult1 := [3]int{1, 2, 3} == [3]int{1, 2, 3}
    equalResult2 := [3]int{1, 2, 3} == [3]int{1, 2, 4}

    fmt.Println(equalResult1) // true
    fmt.Println(equalResult2) // false

    // **注意**
    // 1. copiedArray := sourceArray 是值复制。
    // 2. referencedArray := &sourceArray 是指针引用，同步修改原数组。
    // 3. 不同长度的数组类型不同，不能直接比较或赋值。
}
```

###### 数组作为参数

在Go语言中，可以将数组或数组指针作为函数参数传递。数组参数会复制全部元素，切片参数不属于数组类型。

- **固定长度数组参数：**形参类型必须包含数组长度。

```go
func functionName(arrayValue [size]ElementType) ReturnType {
    statement
}
// arrayValue: 数组参数
// size: 数组长度
// ElementType: 元素类型
```

- **数组指针参数：**适合避免复制整个数组，或在函数内修改原数组。

```go
func functionName(arrayPointer *[size]ElementType) ReturnType {
    statement
}
// arrayPointer: 指向数组的指针参数
// size: 数组长度
// ElementType: 元素类型
```

```go
package main

import "fmt"

func averageValue(scoreArray [6]int) int {
    totalValue := 0

    for _, element := range scoreArray {
        totalValue += element
    }

    return totalValue / len(scoreArray)
}

func updateFirstElement(arrayPointer *[3]int) {
    arrayPointer[0] = 500
}

func main() {
    scoreArray := [6]int{67, 59, 29, 35, 4, 34}
    dataArray := [3]int{100, 200, 300}

    averageResult := averageValue(scoreArray)
    updateFirstElement(&dataArray)

    fmt.Println(averageResult) // 38
    fmt.Println(dataArray)     // [500 200 300]

    // **注意**
    // 1. 函数参数写成 [6]int 时，只能接收长度为 6 的数组。
    // 2. 传递数组会复制全部元素。
    // 3. 传递 *[size]type 可以避免复制，并允许修改原数组。
}
```



##### 结构体

Go 语言中数组可以存储同一类型的数据，但在结构体中我们可以为不同项定义不同的数据类型。结构体是由一系列具有相同类型或不同类型的数据构成的数据集合。**结构体的内容将在第二章详细描述。**

#### 引用类型

##### 指针

###### 指针的声明和初始化

在开始之前，我们将在指针中使用两个重要的运算符，即

`*` 运算符也称为解引用运算符，用于声明指针变量并访问存储在地址中的值。

`&` 运算符称为地址运算符，用于返回变量的地址或将变量的地址赋给指针。

- **声明一个指针：**

```go
var pointerName *DataType
// pointerName: 指针变量名
// DataType: 指针指向的数据类型
```

```go
var stringPointer *string
// stringPointer: 只能保存 string 类型变量的地址
```

- **初始化指针：**需要使用地址运算符 `&` 获取变量地址。

```go
var value = 45
var pointerValue *int = &value
// value: 普通变量
// &value: 变量 value 的地址
// pointerValue: 保存 value 地址的指针变量
```

- **简写声明：**可以直接通过地址初始化，由编译器推导指针类型。

```go
value := 45
pointerValue := &value
// pointerValue 的类型会被推导为 *int
```

- **使用 `new` 初始化：**`new(Type)` 会分配对应类型的内存，并返回该类型的指针，指向该类型的零值。

```go
new(Type) *Type
// Type: 要分配内存的类型
// 返回值: 指向该类型零值的指针
```

```go
package main

import "fmt"

func main() {
    var integerValue = 45
    var pointerValue *int = &integerValue
    shorthandPointer := &integerValue

    newIntegerPointer := new(int)
    newStringPointer := new(string)
    newArrayPointer := new([3]int)
    newSlicePointer := new([]float64)

    fmt.Println(integerValue)       // 45
    fmt.Println(pointerValue)       // 变量地址
    fmt.Println(shorthandPointer)   // 变量地址

    fmt.Println(*newIntegerPointer) // 0
    fmt.Println(*newStringPointer)  // ""
    fmt.Println(*newArrayPointer)   // [0 0 0]
    fmt.Println(*newSlicePointer)   // []

    // **注意**
    // 1. 指针的零值是 nil。
    // 2. *T 只能保存 T 类型变量的地址。
    // 3. pointerValue := &integerValue 会由编译器推导出指针类型。
    // 4. new(Type) 返回 *Type，且指向该类型的零值。
}
```

###### 指针解引用

`*` 运算符不仅用于声明指针变量，也用于访问指针所指向的变量中存储的值。

```go
*pointerValue
// pointerValue: 指针变量
// 返回值: 指针指向的变量值
```

```go
package main

import "fmt"

func main() {
    var integerValue = 458
    var pointerValue = &integerValue

    fmt.Println(integerValue)   // 458
    fmt.Println(&integerValue)  // 变量地址
    fmt.Println(pointerValue)   // 变量地址
    fmt.Println(*pointerValue)  // 458

    *pointerValue = 500
    fmt.Println(integerValue)   // 500

    // **注意**
    // 1. *pointerValue 读取的是指针指向的值。
    // 2. *pointerValue = newValue 可以通过指针修改原变量。
}
```

###### 指针比较

在Go语言中，允许比较两个指针。两个指针值只有在它们指向内存中的相同变量或者它们都为 `nil` 时才相等。

- **== 运算符：**如果两个指针指向同一个变量，则返回 `true`。
- **!= 运算符：**如果两个指针指向不同变量，则返回 `true`。

```go
leftPointer == rightPointer
// leftPointer: 左侧指针
// rightPointer: 右侧指针
// 返回值: 两个指针是否相等
```

```go
leftPointer != rightPointer
// leftPointer: 左侧指针
// rightPointer: 右侧指针
// 返回值: 两个指针是否不相等
```

```go
package main

import "fmt"

func main() {
    firstValue := 10
    secondValue := 10

    firstPointer := &firstValue
    samePointer := &firstValue
    secondPointer := &secondValue

    fmt.Println(firstPointer == samePointer)   // true
    fmt.Println(firstPointer == secondPointer) // false
    fmt.Println(firstPointer != secondPointer) // true

    var nilPointer1 *int
    var nilPointer2 *int

    fmt.Println(nilPointer1 == nilPointer2) // true
}
```

###### 指针运算

在Go语言中，不支持普通指针的算术运算，指针不能像某些语言中那样进行偏移。

```go
pointerValue++
// pointerValue: 普通指针
// 结果: 非法，无法通过编译
```

```go
package main

func main() {
    arrayValue := [5]int{0, 1, 2, 3, 4}
    arrayPointer := &arrayValue

    println(&arrayValue[0])
    println(arrayPointer)

    // arrayPointer++
    // invalid operation: arrayPointer++ (non-numeric type *[5]int)

    _ = arrayPointer
}
```

**补充**：标准库 unsafe 提供了低级指针操作能力，包括指针运算。日常 Go 代码通常不依赖这类写法。

###### 指向数组的指针长度与容量

对于**指向数组的指针**，可以使用 `len()` 和 `cap()` 获取它所指向数组的长度与容量。

```go
len(arrayPointer)
cap(arrayPointer)
// arrayPointer: 指向数组的指针
// 返回值: 指向数组的长度或容量
```

```go
package main

import "fmt"

func main() {
    arrayValue := [4]int{10, 20, 30, 40}
    arrayPointer := &arrayValue

    fmt.Println(len(arrayPointer)) // 4
    fmt.Println(cap(arrayPointer)) // 4

    // **注意**
    // 1. 这里的 len 和 cap 适用于指向数组的指针。
    // 2. 普通指针的使用重点通常是取地址和解引用。
}
```

###### 指针作为参数或返回值

在Go语言中，可以将指针作为参数传递给函数，也可以将指针作为返回值返回。

- **指针作为参数：**适合在函数内部修改外部变量。

```go
func functionName(pointerValue *DataType) ReturnType {
    statement
}
// pointerValue: 指针参数
// DataType: 指针指向的数据类型
```

- **指针作为返回值：**函数可以返回某个值的地址。

```go
func functionName() *DataType {
    statement
}
// 返回值: 指向 DataType 的指针
```

```go
package main

import "fmt"

func updateValue(pointerValue *int) {
    *pointerValue = 748
}

func createPointer() *int {
    localValue := 100
    return &localValue
}

func main() {
    integerValue := 100

    fmt.Println(integerValue) // 100
    updateValue(&integerValue)
    fmt.Println(integerValue) // 748

    returnedPointer := createPointer()
    fmt.Println(*returnedPointer) // 100

    // **注意**
    // 1. 指针参数常用于在函数内部修改外部变量。
    // 2. 返回局部变量地址是合法的，Go 会处理其生命周期。
}
```

###### new 和 make

`new` 和 `make` 都用于内存分配，但用途不同。

- **new：**接收一个类型，返回该类型的指针，常用于指针初始化。
- **make：**返回值本身，不返回指针，只用于 `slice`、`map`、`chan`。

```go
new(Type) *Type
// Type: 要分配内存的类型
// 返回值: 指向该类型零值的指针
```

```go
make(Type, size ...IntegerType) Type
// Type: slice、map 或 chan 类型
// size: 长度、容量或缓冲区大小
// 返回值: 初始化后的值
```

```go
package main

import "fmt"

func main() {
    integerPointer := new(int)
    stringPointer := new(string)
    slicePointer := new([]int)

    sliceValue := make([]int, 3, 5)
    mapValue := make(map[string]int, 2)
    channelValue := make(chan int, 2)

    fmt.Println(integerPointer) // *int
    fmt.Println(stringPointer)  // *string
    fmt.Println(slicePointer)   // *[]int

    fmt.Println(sliceValue)     // [0 0 0]
    fmt.Println(len(sliceValue), cap(sliceValue)) // 3 5
    fmt.Println(mapValue)       // map[]
    fmt.Println(channelValue)   // chan

    // **注意**
    // 1. new 返回指针；make 返回值本身。
    // 2. new 可用于任意类型；make 只用于 slice、map、chan。
    // 3. new([]int) 得到的是 *[]int；make([]int, 3, 5) 得到的是 []int。
}
```

##### 切片

在Go语言中，切片比数组更强大，灵活，方便，并且是轻量级的数据结构。slice是一个可变长度序列，用于存储相同类型的元素，不允许在同一slice中存储不同类型的元素。就像具有索引值和长度的数组一样，但是切片的大小可以调整，切片不像数组那样处于固定大小。在内部，切片和数组相互连接，切片是对基础数组的引用。允许在切片中存储重复元素。***切片中的第一个索引位置始终为0，而最后一个索引位置将为（切片的长度– 1）***。

###### 声明与初始化

1. 切片声明时不写长度，零值为 `nil`。

```go
var sliceValue []int
// sliceValue: int 类型切片
// 返回结果: 零值切片，值为 nil
```

2. 可以直接使用切片字面量初始化。

```go
sliceValue := []int{1, 2, 3}
// sliceValue: 切片变量
// 1, 2, 3: 初始化元素
// 返回结果: 长度为 3 的切片
```

3. `make` 常用于创建可用切片，返回值是切片本身。

```go
make([]T, len, cap)
// T: 元素类型
// len: 切片长度
// cap: 切片容量，可选
// 返回结果: []T
```

4. `new` 返回的是切片指针，较少作为常规初始化手段。

```go
new([]T)
// T: 元素类型
// 返回值: *[]T
// 说明: 指向零值切片的指针
```

```go
package main

import "fmt"

func main() {
    var nilSlice []int
    literalSlice := []int{1, 2, 3}
    madeSlice := make([]int, 0, 5)
    pointerSlice := new([]int)

    fmt.Println(nilSlice == nil)           // true
    fmt.Println(literalSlice)              // [1 2 3]
    fmt.Println(madeSlice)                 // []
    fmt.Println(len(madeSlice), cap(madeSlice)) // 0 5
    fmt.Println(*pointerSlice == nil)      // true

    // **注意**
    // 1. var slice []T 的零值是 nil。
    // 2. make 返回 []T；new 返回 *[]T。
    // 3. 通常更常用 make 来创建可用切片。
}
```

###### 切割与共享

1. 切片可以从数组创建，也可以从已有切片继续切割。

```go
source[low:high]
// source: 数组或切片
// low: 起始下标，默认值为 0
// high: 结束下标，默认值为 len(source)
// 返回结果: [low, high) 范围的新切片
```

2. 普通切割通常共享底层数组。

```go
subSlice := sourceSlice[1:4]
// subSlice: 与 sourceSlice 共享底层数组的新切片
```

3. 三下标表达式可以限制新切片容量。

```go
subSlice := sourceSlice[low:high:max]
// low: 起始下标
// high: 结束下标
// max: 容量上界
// 返回结果: 容量为 max - low 的新切片
```

```go
package main

import "fmt"

func main() {
    sourceSlice := []int{1, 2, 3, 4, 5, 6, 7, 8, 9}

    sharedSlice := sourceSlice[3:4]
    sharedSlice = append(sharedSlice, 100)

    limitedSlice := sourceSlice[3:4:4]
    limitedSlice = append(limitedSlice, 200)

    fmt.Println(sharedSlice)  // [4 100]
    fmt.Println(limitedSlice) // [4 200]
    fmt.Println(sourceSlice)  // [1 2 3 4 100 6 7 8 9]

    // **注意**
    // 1. 普通切割后的 append 可能改写原底层数组。
    // 2. 三下标表达式可限制容量，减少覆盖原切片后续元素的风险。
}
```

###### append

1. `append` 用于向切片尾部追加元素，返回追加后的新切片。

```go
append(slice []Type, elems ...Type) []Type
// slice: 目标切片
// elems: 要追加的元素
// 返回值: 追加后的新切片
```

2. `append(slice, otherSlice...)` 会把另一个切片展开后逐个追加。

```go
resultSlice := append(leftSlice, rightSlice...)
// leftSlice: 目标切片
// rightSlice: 待展开追加的切片
// 返回值: 追加后的新切片
```

3. `append` 也是插入、删除、连接等操作的基础手段。

```go
package main

import "fmt"

func main() {
    nums := make([]int, 0, 0)
    nums = append(nums, 1, 2, 3, 4, 5)
    nums = append(nums, []int{6, 7}...)
    fmt.Println(nums)                 // [1 2 3 4 5 6 7]
    fmt.Println(len(nums), cap(nums)) // 长度与容量可能不同

    insertSource := []int{1, 2, 3, 4, 5}
    insertIndex := 2
    insertSource = append(insertSource[:insertIndex], append([]int{999, 1000}, insertSource[insertIndex:]...)...)
    fmt.Println(insertSource) // [1 2 999 1000 3 4 5]

    deleteSource := []int{1, 2, 3, 4, 5, 6}
    deleteSource = deleteSource[2:]
    fmt.Println(deleteSource) // [3 4 5 6]

    deleteSource = deleteSource[:len(deleteSource)-1]
    fmt.Println(deleteSource) // [3 4 5]

    deleteSource = append(deleteSource[:1], deleteSource[2:]...)
    fmt.Println(deleteSource) // [3 5]

    // **注意**
    // 1. append 本质上返回一个新的切片值，通常要接回原变量。
    // 2. 插入、删除、连接本质上都可以通过 append 组合实现。
    // 3. 容量不足时，append 会分配新的底层数组。
}
```

###### 遍历

1. 可以使用普通 `for` 循环遍历切片。

```go
for index := 0; index < len(sliceValue); index++ {
    // sliceValue[index]
}
```

2. 可以使用 `for range` 获取索引和值。

```go
for index, element := range sliceValue {
    // index: 当前索引
    // element: 当前元素副本
}
```

3. 只需要值时，可以使用空白标识符 `_` 忽略索引。

```go
for _, element := range sliceValue {
    // element: 当前元素副本
}
```

```go
package main

import "fmt"

func main() {
    sliceValue := []int{10, 20, 30}

    for index := 0; index < len(sliceValue); index++ {
        fmt.Println(index, sliceValue[index])
    }

    for index, element := range sliceValue {
        fmt.Println(index, element)
    }

    for _, element := range sliceValue {
        fmt.Println(element)
    }

    // **注意**
    // range 返回的 element 是元素副本。
}
```

###### 其他用法

1. `copy` 复制元素，复制数量取目标长度和源长度的较小值。

```go
copy(dst, src []Type) int
// dst: 目标切片
// src: 源切片
// 返回值: 实际复制的元素数量
```

2. `bytes.Compare`、`bytes.Split` 只适用于 `[]byte`。

```go
Compare(slice1, slice2 []byte) int
// slice1: 第一个字节切片
// slice2: 第二个字节切片
// 返回值: -1 / 0 / 1
```

```go
Split(oSlice, sep []byte) [][]byte
// oSlice: 原始字节切片
// sep: 分隔符
// 返回值: 拆分后的 [][]byte
```

3. `sort.Ints` 和 `sort.IntsAreSorted` 处理 `[]int`。

```go
Ints(slc []int)
// slc: 待排序的 int 切片
// 返回结果: 原地升序排序
```

```go
IntsAreSorted(slc []int) bool
// slc: 待检查的 int 切片
// 返回值: 是否已按升序排列
```

4. `clear` 会将切片中的元素重置为零值，但不会改变长度和容量。

```go
clear(sliceValue)
// sliceValue: 切片
// 返回结果: 将所有元素置为零值
```

5. `sliceValue = sliceValue[:0]` 或 `sliceValue = sliceValue[:0:0]` 常用于清空切片。

```go
package main

import (
    "bytes"
    "fmt"
    "sort"
)

func main() {
    sourceSlice := []int{10, 20, 30, 40, 50}
    targetSlice := make([]int, 3)
    copiedCount := copy(targetSlice, sourceSlice)
    fmt.Println(targetSlice) // [10 20 30]
    fmt.Println(copiedCount) // 3

    sortableSlice := []int{400, 600, 100, 300, 500, 200}
    fmt.Println(sort.IntsAreSorted(sortableSlice)) // false
    sort.Ints(sortableSlice)
    fmt.Println(sortableSlice)                     // [100 200 300 400 500 600]
    fmt.Println(sort.IntsAreSorted(sortableSlice)) // true

    leftByteSlice := []byte("Go")
    rightByteSlice := []byte("Lang")
    compareResult := bytes.Compare(leftByteSlice, rightByteSlice)
    splitResult := bytes.Split([]byte("Go,Java,Python"), []byte(","))
    fmt.Println(compareResult) // 1
    fmt.Println(splitResult)   // [[71 111] [74 97 118 97] [80 121 116 104 111 110]]

    clearSlice := []int{1, 2, 3, 4}
    clear(clearSlice)
    fmt.Println(clearSlice) // [0 0 0 0]

    clearSlice = clearSlice[:0]
    fmt.Println(clearSlice) // []

    limitedClearSlice := []int{1, 2, 3, 4}
    limitedClearSlice = limitedClearSlice[:0:0]
    fmt.Println(limitedClearSlice, len(limitedClearSlice), cap(limitedClearSlice)) // [] 0 0

    // **注意**
    // 1. copy 不会复制底层数组关系，只复制元素。
    // 2. 切片不能直接比较元素内容，通常只与 nil 比较。
    // 3. bytes.Compare 和 bytes.Split 处理的是 []byte。
    // 4. clear 只清零元素，不改变长度和容量。
}
```

###### 多维切片

1. `make([][]T, n)` 只创建外层切片。

```go
make([][]T, n)
// T: 元素类型
// n: 外层长度
// 返回结果: 外层已初始化、内层仍为 nil 的二维切片
```

2. 内层切片通常需要单独初始化。

```go
innerSlice := make([]T, length)
// T: 元素类型
// length: 内层切片长度
// 返回结果: 初始化后的内层切片
```

```go
package main

import "fmt"

func main() {
    matrixSlice := make([][]int, 3)

    for index := 0; index < len(matrixSlice); index++ {
        matrixSlice[index] = make([]int, 2)
    }

    matrixSlice[0][0] = 1
    matrixSlice[1][1] = 2

    fmt.Println(matrixSlice) // [[1 0] [0 2] [0 0]]

    // **注意**
    // 1. make([][]int, 3) 只创建外层切片。
    // 2. 内层切片通常需要单独初始化。
}
```

##### 映射表

Map 是一种无序的键值对集合，通过键快速访问值。Map 的键类型必须可比较，值类型没有此限制。Map 是引用类型，赋值或作为参数传递时会共享同一个底层数据结构。遍历 Map 时，键值对顺序不确定。访问不存在的键时，会返回值类型的零值。

###### 初始化

1. 可以使用字面量创建 Map。

```go
map[keyType]valueType{}
// keyType: 键类型，必须可比较
// valueType: 值类型
// 返回结果: map 字面量
```

2. 可以使用 `make` 创建 Map，并可指定初始容量。

```go
make(map[keyType]valueType, capacity)
// keyType: 键类型
// valueType: 值类型
// capacity: 初始容量，可选
// 返回结果: 初始化后的 map
```

3. nil map 可以读取，但不能写入。

```go
package main

import "fmt"

func main() {
    literalMap := map[string]int{
        "apple":  1,
        "banana": 2,
        "orange": 3,
    }

    madeMap := make(map[string][]int, 8)

    var nilMap map[string]int

    fmt.Println(literalMap)       // map[apple:1 banana:2 orange:3]
    fmt.Println(madeMap)          // map[]
    fmt.Println(nilMap == nil)    // true

    // nilMap["a"] = 1
    // panic: assignment to entry in nil map

    // **注意**
    // 1. nil map 可以读，但不能写。
    // 2. 初始化时给出合理容量可以减少扩容次数。
}
```

###### 访问与存取

1. 通过 `mapValue[key]` 访问值，不存在的键会返回零值。

```go
mapValue[key]
// mapValue: 目标 map
// key: 键
// 返回值: 对应值；若键不存在，返回值类型零值
```

2. 通过双返回值形式可以判断键是否存在。

```go
value, exists := mapValue[key]
// value: 对应值
// exists: 键是否存在
```

3. 使用已存在的键赋值会覆盖原值。

```go
mapValue[key] = newValue
// key: 已存在或新写入的键
// newValue: 要写入的值
// 返回结果: 若 key 已存在则覆盖原值
```

4. `len(mapValue)` 返回当前键值对数量。

```go
len(mapValue)
// mapValue: 目标 map
// 返回值: 键值对数量
```

```go
package main

import (
    "fmt"
    "math"
)

func main() {
    mapValue := make(map[string]int, 10)

    mapValue["a"] = 1
    mapValue["b"] = 2
    mapValue["b"] = 3

    fmt.Println(mapValue["a"]) // 1
    fmt.Println(mapValue["f"]) // 0
    fmt.Println(len(mapValue)) // 2

    if value, exists := mapValue["f"]; exists {
        fmt.Println(value)
    } else {
        fmt.Println("key不存在")
    }

    nanMap := make(map[float64]string, 10)
    nanMap[math.NaN()] = "a"
    nanMap[math.NaN()] = "b"
    nanMap[math.NaN()] = "c"

    _, exists := nanMap[math.NaN()]
    fmt.Println(exists) // false
    fmt.Println(nanMap) // map 中可能同时出现多个 NaN 键

    // **注意**
    // 1. 对不存在的键取值会返回零值。
    // 2. 双返回值形式更适合判断键是否存在。
    // 3. 应尽量避免使用 NaN 作为 map 的键。
}
```

###### 删除、清空与遍历

1. `delete` 删除指定键值对，删除不存在的键不会报错。

```go
delete(mapValue, key)
// mapValue: 目标 map
// key: 要删除的键
// 返回结果: 删除对应键值对
```

2. `clear` 会清空 Map 中所有键值对。

```go
clear(mapValue)
// mapValue: 目标 map
// 返回结果: 清空 map 中所有键值对
```

3. `for range` 可以遍历 Map，但顺序不固定。

```go
for key, value := range mapValue {
    // key: 当前键
    // value: 当前值
}
```

```go
package main

import "fmt"

func main() {
    mapValue := map[string]int{
        "a": 0,
        "b": 1,
        "c": 2,
        "d": 3,
    }

    fmt.Println(mapValue) // map[a:0 b:1 c:2 d:3]

    delete(mapValue, "a")
    fmt.Println(mapValue) // map[b:1 c:2 d:3]

    for key, value := range mapValue {
        fmt.Println(key, value)
    }

    clear(mapValue)
    fmt.Println(mapValue) // map[]

    // **注意**
    // 1. Map 遍历顺序不保证稳定。
    // 2. clear 不会把 map 重新变成 nil。
}
```

###### 引用语义与并发

1. Map 是引用类型，赋值后多个变量会共享同一个底层数据结构。

```go
sharedMap := sourceMap
// sourceMap: 原 map
// sharedMap: 与原 map 共享底层数据的新变量
```

2. Map 不是并发安全的数据结构，并发读写可能触发运行时错误。

```go
concurrentMap["key"] = value
fmt.Println(concurrentMap["key"])
// 结果: 并发读写 map 可能触发 fatal error
```

3. 并发场景通常需要额外同步，或改用 `sync.Map`。

```go
package main

import (
    "fmt"
    "sync"
)

func main() {
    sourceMap := map[string]int{
        "a": 1,
        "b": 2,
    }

    sharedMap := sourceMap
    sharedMap["a"] = 100

    fmt.Println(sourceMap) // map[a:100 b:2]
    fmt.Println(sharedMap) // map[a:100 b:2]

    var group sync.WaitGroup
    concurrentMap := make(map[string]int, 10)

    group.Add(2)

    go func() {
        defer group.Done()
        for index := 0; index < 100; index++ {
            concurrentMap["hello"] = index
        }
    }()

    go func() {
        defer group.Done()
        for index := 0; index < 100; index++ {
            fmt.Println(concurrentMap["hello"])
        }
    }()

    group.Wait()

    // **注意**
    // 1. Map 赋值不会复制底层数据。
    // 2. 上述并发读写 map 的写法可能触发 fatal error。
    // 3. 并发场景下通常需要加锁，或改用 sync.Map。
}
```

###### Set

Go 没有内建的 Set 类型，但可以使用 `map[T]struct{}` 或 `map[T]bool` 模拟。由于 Map 的键不能重复，因此非常适合表示无序且不重复的集合。

**初始化与存取**

1. `map[T]struct{}` 是最常见的 Set 写法。

```go
make(map[ElementType]struct{}, capacity)
// ElementType: 集合元素类型
// capacity: 初始容量，可选
// 返回结果: 使用 map 模拟的 set
```

2. 空结构体 `struct{}` 不占用额外存储空间。

```go
setValue[element] = struct{}{}
// setValue: 集合
// element: 要加入的元素
// 返回结果: 将元素加入集合
```

3. 判断元素是否存在时，通常使用双返回值形式。

```go
_, exists := setValue[element]
// exists: 元素是否存在于集合中
```

```go
package main

import "fmt"

func main() {
    setValue := make(map[int]struct{}, 10)

    setValue[1] = struct{}{}
    setValue[2] = struct{}{}
    setValue[2] = struct{}{}

    _, exists1 := setValue[1]
    _, exists2 := setValue[3]

    fmt.Println(setValue) // map[1:{} 2:{}]
    fmt.Println(exists1)  // true
    fmt.Println(exists2)  // false

    // **注意**
    // 1. 重复加入相同元素不会增加新的键。
    // 2. struct{} 适合用来表示“只关心键是否存在”。
}
```

**删除、遍历与清空**

1. 删除 Set 元素本质上是删除 Map 键。

```go
delete(setValue, element)
// setValue: 集合
// element: 要删除的元素
// 返回结果: 删除指定元素
```

2. 遍历 Set 本质上是遍历 Map 的键。

```go
for element := range setValue {
    // element: 当前集合元素
}
```

3. `clear` 也可以直接用于 Set。

```go
clear(setValue)
// setValue: 集合
// 返回结果: 清空集合
```

```go
package main

import "fmt"

func main() {
    setValue := map[string]struct{}{
        "go":   {},
        "java": {},
        "rust": {},
    }

    delete(setValue, "java")

    for element := range setValue {
        fmt.Println(element)
    }

    clear(setValue)
    fmt.Println(setValue) // map[]

    // **注意**
    // 1. Set 遍历顺序同样不固定。
    // 2. Set 的底层仍然是 Map，因此也不具备并发安全性。
}
```



##### 接口

接口（interface）是 Go 语言中的一种类型，用于定义行为的集合，它通过描述类型必须实现的方法，规定了类型的行为契约。**接口的内容将在第二章详细描述。**

##### 管道

**提前说明，管道的笔记部分可能需要第三章知识的支持。**

Channel 是 Go 中的一个核心类型，可以看成一个用于发送和接收数据的管道，通过它可以在 goroutine 之间进行通信。它的操作符是箭头 `<-`，箭头指向数据的流向。

###### 创建与方向

1. Channel 需要先创建再使用，通常使用 `make` 初始化。

```go
make(chan ElementType, capacity)
// ElementType: 管道中传输的数据类型
// capacity: 缓冲区大小，可选
// 返回结果: 对应类型的 channel
```

2. Channel 可以是双向、只发送、只接收三种方向。

```go
chan T
// 返回结果: 可发送也可接收的双向 channel
```

```go
chan<- T
// 返回结果: 只发送 channel
```

```go
<-chan T
// 返回结果: 只接收 channel
```

3. 如果容量为 0 或未指定容量，则为无缓冲管道；如果容量大于 0，则为有缓冲管道。

```go
package main

import "fmt"

func main() {
    bidirectionalChannel := make(chan int)
    bufferedChannel := make(chan int, 3)

    var sendOnlyChannel chan<- int = bufferedChannel
    var receiveOnlyChannel <-chan int = bufferedChannel

    fmt.Println(bidirectionalChannel) // channel 地址
    fmt.Println(bufferedChannel)      // channel 地址
    fmt.Println(sendOnlyChannel)      // channel 地址
    fmt.Println(receiveOnlyChannel)   // channel 地址

    // **注意**
    // 1. 无缓冲管道只有在发送方和接收方都准备好时才会完成通信。
    // 2. 有缓冲管道在缓冲区未满时发送通常不会阻塞，在缓冲区非空时接收通常不会阻塞。
    // 3. nil channel 不能正常通信。
}
```

###### 发送接收与关闭

1. 发送操作使用 `channel <- value`。

```go
channelValue <- value
// channelValue: 目标 channel
// value: 要发送的数据
// 返回结果: 将数据发送到 channel
```

2. 接收操作使用 `<-channelValue`。

```go
value := <-channelValue
// channelValue: 目标 channel
// 返回值: 从 channel 中接收到的数据
```

3. 接收支持双返回值形式，可用于判断 channel 是否已关闭。

```go
value, ok := <-channelValue
// value: 接收到的数据
// ok: channel 是否仍然打开
// 若 ok 为 false，则 value 为元素类型零值
```

4. `close(channelValue)` 用于关闭 channel，关闭后不能继续发送数据。

```go
close(channelValue)
// channelValue: 要关闭的 channel
// 返回结果: 关闭 channel
```

```go
package main

import "fmt"

func main() {
    channelValue := make(chan int, 2)

    channelValue <- 1
    channelValue <- 2
    close(channelValue)

    firstValue := <-channelValue
    secondValue := <-channelValue
    thirdValue, ok := <-channelValue

    fmt.Println(firstValue)  // 1
    fmt.Println(secondValue) // 2
    fmt.Println(thirdValue)  // 0
    fmt.Println(ok)          // false

    // channelValue <- 3
    // panic: send on closed channel

    // **注意**
    // 1. 关闭后的 channel 仍可继续接收已发送的数据。
    // 2. 已关闭且已读空的 channel 再接收会得到零值。
    // 3. 向已关闭的 channel 发送数据会 panic。
}
```

###### 阻塞与缓存

默认情况下，发送和接收会阻塞，直到另一方准备好。无缓冲 channel 常用于同步。有缓冲 channel 可以在一定程度上减少阻塞。

```go
package main

import "fmt"

func sumValue(partSlice []int, resultChannel chan int) {
    totalValue := 0
    for _, element := range partSlice {
        totalValue += element
    }
    resultChannel <- totalValue
}

func main() {
    sourceSlice := []int{7, 2, 8, -9, 4, 0}
    resultChannel := make(chan int)

    go sumValue(sourceSlice[:len(sourceSlice)/2], resultChannel)
    go sumValue(sourceSlice[len(sourceSlice)/2:], resultChannel)

    leftValue, rightValue := <-resultChannel, <-resultChannel
    fmt.Println(leftValue, rightValue, leftValue+rightValue)

    // **注意**
    // 1. 上面的接收操作会一直等待，直到对应结果被发送到 channel。
    // 2. 这种阻塞机制可用于 goroutine 之间的同步。
}
```

###### 可迭代

`for range` 可以持续接收 channel 中的数据。只有在 channel 被关闭后，`range` 才会结束。如果发送结束后不关闭 channel，`range` 可能一直阻塞。

```go
for value := range channelValue {
    // value: 当前接收到的元素
}
```

```go
package main

import "fmt"

func main() {
    channelValue := make(chan int)

    go func() {
        for index := 0; index < 5; index++ {
            channelValue <- index
        }
        close(channelValue)
    }()

    for value := range channelValue {
        fmt.Println(value)
    }

    fmt.Println("Finished")

    // **注意**
    // 1. range 读取的是发送到 channel 中的值。
    // 2. 若不关闭 channel，range 可能会一直阻塞。
}
```

###### select

`select` 用于在多个发送或接收操作之间选择一个可执行的分支。如果多个 case 同时满足，Go 会伪随机选择一个。如果没有可执行分支且存在 `default`，则会执行 `default`；否则会阻塞。

```go
select {
case value := <-receiveChannel:
    statement
case sendChannel <- value:
    statement
default:
    statement
}
```

4. `select` 本身不是循环，若需要持续监听，通常要配合 `for` 使用。

```go
package main

import (
    "fmt"
    "time"
)

func fibonacci(outputChannel, quitChannel chan int) {
    leftValue, rightValue := 0, 1

    for {
        select {
        case outputChannel <- leftValue:
            leftValue, rightValue = rightValue, leftValue+rightValue
        case <-quitChannel:
            fmt.Println("quit")
            return
        }
    }
}

func main() {
    outputChannel := make(chan int)
    quitChannel := make(chan int)

    go func() {
        for index := 0; index < 5; index++ {
            fmt.Println(<-outputChannel)
        }
        quitChannel <- 0
    }()

    fibonacci(outputChannel, quitChannel)

    timeoutChannel := make(chan string, 1)
    go func() {
        time.Sleep(2 * time.Second)
        timeoutChannel <- "result"
    }()

    select {
    case result := <-timeoutChannel:
        fmt.Println(result)
    case <-time.After(1 * time.Second):
        fmt.Println("timeout")
    }

    // **注意**
    // 1. nil channel 上的 send / receive 会一直阻塞。
    // 2. 只有 nil channel 且没有 default 的 select 会一直阻塞。
    // 3. time.After 常用于超时控制。
}
```

###### 同步

Channel 可以直接用于 goroutine 之间的同步。常见方式是一个 goroutine 完成工作后向 channel 发送信号，另一个 goroutine 等待接收。

```go
package main

import (
    "fmt"
    "time"
)

func worker(done chan bool) {
    time.Sleep(time.Second)
    done <- true
}

func main() {
    done := make(chan bool, 1)

    go worker(done)

    <-done
    fmt.Println("finished")

    // **注意**
    // 1. 这里只关心同步时，channel 中传递的值本身往往不重要。
    // 2. 这种写法常用于等待任务完成。
}
```

###### Timer 和 Ticker

`time.NewTimer` 返回一个定时器，它会在未来某个时间点向 `Timer.C` 发送一次时间值。`time.NewTicker` 返回一个周期性计时器，它会按固定间隔持续向 `Ticker.C` 发送时间值。两者都可以通过 `Stop` 停止。

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    timerValue := time.NewTimer(2 * time.Second)
    <-timerValue.C
    fmt.Println("Timer expired")

    secondTimer := time.NewTimer(time.Second)
    stopResult := secondTimer.Stop()
    fmt.Println(stopResult) // true 或 false

    tickerValue := time.NewTicker(500 * time.Millisecond)
    defer tickerValue.Stop()

    done := make(chan bool, 1)

    go func() {
        time.Sleep(1600 * time.Millisecond)
        done <- true
    }()

    for {
        select {
        case tickTime := <-tickerValue.C:
            fmt.Println("Tick at", tickTime)
        case <-done:
            fmt.Println("Finished")
            return
        }
    }

    // **注意**
    // 1. Timer 对应单次事件，Ticker 对应周期性事件。
    // 2. Timer.C 和 Ticker.C 本质上都是 channel。
}
```

#### 别名类型

##### byte

`byte` 是 `uint8` 的别名。在语言层面，它与 `uint8` 完全等价；但在实际书写中，`byte` 更强调“字节”语义，通常用于原始二进制数据、文件内容、网络数据、ASCII 字符等场景。Go 官方内建定义中明确说明：`byte` 用来区分字节值与普通的 8 位无符号整数值。

```go
type byte = uint8
// byte: uint8 的别名
// 用途: 表示单个字节
```

1. 处理字符串底层字节时，经常会转成 `[]byte`。
2. 对 ASCII 字符，`byte` 往往足够直接。
3. 标准库中很多 I/O、编码、网络接口都大量使用 `[]byte`。

```go
package main

import "fmt"

func main() {
    stringValue := "Go语言"

    byteValue := stringValue[0]
    byteSlice := []byte(stringValue)

    fmt.Println(byteValue) // 71，'G' 的字节值
    fmt.Println(byteSlice) // UTF-8 字节序列

    // **示例**
    // stringValue[0] 取到的是第 1 个字节，不一定是完整字符。
    // []byte(stringValue) 常用于处理原始字节数据。
    //
    // **注意**
    // 1. byte 更强调“字节”语义，而不是整数语义。
    // 2. 处理文件、网络、编码、ASCII 时常用 []byte。
    // 3. 多字节字符不适合按 byte 直接理解为“一个字符”。
}
```

##### rune

`rune` 是 `int32` 的别名。在语言层面，它与 `int32` 完全等价；但在实际书写中，`rune` 更强调“字符 / Unicode 码点”语义。Go 官方内建定义中明确说明：`rune` 用来区分字符值与普通整数值。Go 字符串底层是 UTF-8 字节序列，而一个字符并不一定只占一个字节，因此在处理中文、多语言文本、按字符遍历字符串、统计字符数、按字符截取字符串时，`rune` 往往比按字节处理更合适。

```go
type rune = int32
// rune: int32 的别名
// 用途: 表示一个 Unicode 码点
```

1. `len(stringValue)` 统计的是字节数，不是字符数。
2. `[]rune(stringValue)` 适合按字符处理字符串。
3. `for range` 遍历字符串时，拿到的是 `rune`。
4. 字符字面量如 `'语'` 的类型本质上就是字符常量，常与 `rune` 语义对应。

```go
package main

import (
    "fmt"
    "unicode/utf8"
)

func main() {
    stringValue := "Go语言编程"

    runeValue := '语'
    runeSlice := []rune(stringValue)

    fmt.Println(runeValue)                        // 35821，对应 Unicode 码点值
    fmt.Println(len(stringValue))                 // 14，字节数
    fmt.Println(len(runeSlice))                   // 6，字符数
    fmt.Println(utf8.RuneCountInString(stringValue)) // 6

    fmt.Println(string(runeSlice[:4])) // Go语言

    for index, runeElement := range stringValue {
        fmt.Println(index, runeElement)
        // index: 当前 rune 的起始字节下标
        // runeElement: 当前字符对应的 rune
    }

    // **示例**
    // 统计中文字符串长度时，rune 比直接用 len 更符合“字符数”语义。
    // 截取中文字符串时，先转成 []rune 再切片，能避免按字节切割导致的乱码。
    //
    // **注意**
    // 1. rune 更强调“字符 / 码点”语义，而不是整数语义。
    // 2. len(stringValue) 统计字节数；len([]rune(stringValue)) 统计字符数。
    // 3. 处理中文或其他多字节字符时，常使用 []rune。
    // 4. for range 遍历字符串时，比按 byte 下标访问更适合文本处理。
}
```

##### any

`any` 是 `interface{}` 的别名。它在语言层面与 `interface{}` 完全等价，Go 1.18 将它加入为预声明标识符。它的意义主要不在于提供新能力，而在于让代码表达更直观：当你想表示“任意类型”时，`any` 比 `interface{}` 更短，也更符合阅读直觉。它尤其常见于泛型类型参数、需要接收任意值的函数参数、通用容器或工具函数中。

```go
type any = interface{}
// any: interface{} 的别名
// 用途: 表示任意类型
```

1. `any` 常用于泛型代码中表示“类型参数不做额外约束”。
2. `any` 也可用于普通函数参数，表示可接收任意类型。
3. 它只是别名，不会改变接口本身的行为。

```go
package main

import "fmt"

func printValue(value any) {
    fmt.Println(value)
}

func firstElement[T any](sliceValue []T) T {
    return sliceValue[0]
}

func main() {
    var firstValue any = 100
    var secondValue any = "Go"
    var thirdValue any = []int{1, 2, 3}

    printValue(firstValue)
    printValue(secondValue)
    printValue(thirdValue)

    fmt.Println(firstElement([]int{10, 20, 30}))       // 10
    fmt.Println(firstElement([]string{"Go", "Rust"}))  // Go

    // **示例**
    // any 在普通代码里可表示“任意类型参数”。
    // 在泛型里，T any 表示 T 不附加额外约束。
    //
    // **注意**
    // 1. any 只是 interface{} 的简写形式，语义更直观。
    // 2. any 不会带来新的运行时能力，本质仍然是空接口。
    // 3. 泛型代码中，any 的出现频率通常高于 interface{}。
}
```

### 变量

变量是用于保存一个值的存储位置，允许其存储的值在运行时动态变化。每声明一个变量，都会为其分配一块内存以存储对应类型的值。变量声明后可以被访问、修改，也可以参与表达式和函数调用。

#### 声明

在 Go 中，类型声明是后置的，变量声明通常使用 `var` 关键字，格式为 `var 变量名 类型名`。变量名需要遵守标识符命名规则：必须以字母或下划线开头，区分大小写，不能与关键字冲突。

1. 声明单个变量时，可以只写变量名和类型。

```go
var intNum int
var str string
var char byte
```

2. 声明多个相同类型变量时，可以只写一次类型。

```go
var numA, numB, numC int
```

3. 声明多个不同类型变量时，可以用 `()` 分组。

```go
var (
    name    string
    age     int
    address string
)

var (
    school string
    class  int
)
```

4. 如果变量只声明不赋值，则会自动使用该类型的零值。

```go
var variableName Type
// variableName: 变量名
// Type: 变量类型
// 返回结果: 声明变量并使用零值初始化
```

5. 也可以在声明时直接由右侧表达式推导类型。

```go
var variableName = expression
// variableName: 变量名
// expression: 初始化表达式
// 返回结果: 声明变量并由表达式推导类型
```

```go
package main

import "fmt"

func main() {
    var integerValue int
    var stringValue string
    var boolValue bool

    var inferredInteger = 20
    var inferredString = "Go"

    var leftValue, rightValue int = 10, 20

    var (
        userName string = "Jack"
        userAge  int    = 18
    )

    fmt.Println(integerValue, stringValue, boolValue) // 0 "" false
    fmt.Println(inferredInteger, inferredString)      // 20 Go
    fmt.Println(leftValue, rightValue)                // 10 20
    fmt.Println(userName, userAge)                    // Jack 18

    // **注意**
    // 1. Go 中不存在“声明了但没有零值”的普通变量。
    // 2. 使用 var 时，类型和表达式可以省略其一，但不能同时省略。
}
```

#### 赋值

赋值使用 `=` 运算符。变量声明之后可以单独赋值，也可以在声明时直接初始化。

1. 单个变量赋值使用 `=`。

```go
var name string
name = "jack"
```

2. 声明时也可以直接赋值。

```go
var name string = "jack"
```

3. 多个变量可以同时赋值。

```go
var name string
var age int
name, age = "jack", 1
```

4. Go 提供了短变量声明 `:=`，用于在函数内部声明并初始化局部变量。`:=` 会根据右侧表达式自动推导类型。

```go
variableName := expression
// variableName: 变量名
// expression: 初始化表达式
// 返回结果: 声明并初始化局部变量
```

5. 短变量声明支持批量初始化。

```go
name, age := "jack", 1
```

6. `:=` 不能用于包级变量，也不能在左侧全是旧变量时重复使用。若左侧至少有一个新变量，则可以在同一作用域中“旧变量 + 新变量”混合使用。`:=` 不能直接用于 `nil`，因为 `nil` 本身不属于具体类型，编译器无法推导其类型。

```go
package main

import "fmt"

func main() {
    name := "jack"
    age := 1

    name, score := "tom", 100 // name 是旧变量，score 是新变量

    var city string
    city = "beijing"

    fmt.Println(name, age)   // tom 1
    fmt.Println(score)       // 100
    fmt.Println(city)        // beijing

    // a := nil
    // 非法：nil 没有独立类型，无法推导

    // **注意**
    // 1. := 是声明，= 是赋值。
    // 2. := 只能用于函数内部。
    // 3. 后续重新赋值时，类型必须保持一致。
}
```

7. 在 Go 中，函数内部声明的局部变量必须被使用，否则无法通过编译；包级变量没有这个限制。

```go
package main

var packageValue = 1

func main() {
    localValue := 1
    _ = localValue

    // 若 localValue 声明后不使用，则会报错：
    // localValue declared and not used
}
```

#### 匿名

下划线 `_` 称为空白标识符，用来表示某个值不需要使用。它最常见的场景是忽略函数返回值，或者在 `for range` 中忽略索引或元素。

不需要某个返回值时，可以使用 `_` 丢弃它。 它也常用于占位，避免“声明了但未使用”的编译错误。

```go
value, _ := functionCall()
// value: 保留的返回值
// _: 丢弃的返回值
```

```go
package main

import "fmt"

func openFile(name string) (string, error) {
    return name, nil
}

func main() {
    fileName, _ := openFile("readme.txt")
    fmt.Println(fileName) // readme.txt

    // **注意**
    // 1. _ 不会分配可访问的变量。
    // 2. 当返回值不需要时，可使用 _ 忽略。
}
```

#### 交换

Go 支持多变量同时赋值，因此交换变量时不需要像某些语言那样借助临时变量或指针。

两个变量可以直接交换。三个及以上变量同样可以同时交换。多变量赋值时是“先统一计算右侧，再统一赋值”，不是从左到右逐个立即生效。

```go
leftValue, rightValue = rightValue, leftValue
```

```go
package main

import "fmt"

func main() {
    firstValue, secondValue := 25, 36
    firstValue, secondValue = secondValue, firstValue
    fmt.Println(firstValue, secondValue) // 36 25

    leftValue, middleValue, rightValue := 0, 1, 1
    leftValue, middleValue, rightValue = middleValue, rightValue, leftValue+middleValue
    fmt.Println(leftValue, middleValue, rightValue) // 1 1 1

    // **注意**
    // 1. 多变量赋值会先计算右侧所有表达式，再统一写回左侧变量。
    // 2. 因此 a, b, c = b, c, a+b 的结果与逐行赋值不同。
}
```

#### 比较

变量之间能否比较，前提是类型兼容。Go 不支持隐式类型转换，因此不同类型的变量通常不能直接比较。

类型不同的变量不能直接比较。如有需要，必须显式转换类型。
Go 1.21 起内建 `min`、`max` 支持更多场景。标准库 `cmp` 可用于有序类型的比较。

```go
leftValue == rightValue
// leftValue: 左侧变量
// rightValue: 右侧变量
// 返回值: 比较结果
```

```go
int64(a) == b
// a: 待转换值
// b: 目标比较值
// 返回值: 显式转换后再比较
```

```go
min(value1, value2, value3)
max(value1, value2, value3)
// 返回值: 最小值或最大值
```

```go
package main

import (
    "cmp"
    "fmt"
)

func main() {
    var unsignedValue uint64 = 10
    var signedValue int64 = 10

    fmt.Println(int64(unsignedValue) == signedValue) // true

    minValue := min(1, 2, -1, 3)
    maxValue := max(100, 22, -1, 12)

    fmt.Println(minValue) // -1
    fmt.Println(maxValue) // 100

    fmt.Println(cmp.Compare(1, 2)) // -1
    fmt.Println(cmp.Less(1, 2))    // true

    // **注意**
    // 1. Go 中不存在隐式类型转换。
    // 2. 比较前若类型不同，必须先显式转换。
    // 3. 切片不可比较；数组、结构体是否可比较取决于其元素或字段是否可比较。
}
```

#### 代码块

在函数内部，可以通过花括号建立新的代码块。不同代码块之间的变量作用域彼此独立，内部代码块可以重新声明与外层同名的变量，这会形成遮蔽。

块内变量默认只在该块内可见。内层块可以访问外层块中的变量。内层块重新声明同名变量时，会遮蔽外层变量。

```go
package main

import "fmt"

func main() {
    value := 1

    {
        value := 2
        fmt.Println(value) // 2
    }

    {
        fmt.Println(value) // 1
    }

    fmt.Println(value) // 1

    // **注意**
    // 1. 内层块重新声明同名变量，不会修改外层变量。
    // 2. 块与块之间的局部变量彼此独立。
}
```

### 常量

常量的值无法在运行时改变，一旦赋值后就不能修改。常量的值只能来源于字面量、其他常量标识符、常量表达式、或结果仍为常量的类型转换。常量只能是基本数据类型，不能是切片、映射、结构体、函数返回值等非常量值。

#### 初始化

常量使用 `const` 声明，并且在声明时必须初始化。常量可以省略类型，也可以显式指定类型。但是常量不能只声明不赋值。常量适合表示不会变化的配置值、数学值、状态值等。

```go
const constantName = expression
// constantName: 常量名
// expression: 常量表达式
```

```go
const constantName Type = expression
// constantName: 常量名
// Type: 常量类型
// expression: 常量表达式
```

批量声明常量时，可以使用 `()` 分组。在同一个分组中，如果后续常量不写值，则会默认重复前一个常量的表达式。

```go
package main

import "fmt"

const Pi = 3.14

const (
    Count = 1
    Name  = "Jack"
)

const (
    A = 1
    B
    C
)

func main() {
    const message = "hello world"
    const numberExpression = (1+2+3)/2%100 + 1

    fmt.Println(Pi)               // 3.14
    fmt.Println(Count, Name)      // 1 Jack
    fmt.Println(A, B, C)          // 1 1 1
    fmt.Println(message)          // hello world
    fmt.Println(numberExpression) // 3
}
```

#### iota

`iota` 是一个内置常量标识符，通常用于 `const` 分组中表示递增的无类型整数序号。它在每个新的 `const` 分组中都会从 `0` 开始重新计数。

同一分组中，`iota` 会按行递增。后续常量若省略表达式，会复用上一行表达式，但 `iota` 的值仍会继续变化。`_` 也会占用一行，因此也会影响 `iota` 的序号递增。

```go
package main

import "fmt"

const (
    Num0 = iota
    Num1
    Num2
    Num3
)

const (
    Even0 = iota * 2
    Even1
    Even2
    Even3
)

const (
    A0 = iota<<2*3 + 1
    A1
    _
    A3
    A4 = iota
    _
    A6
)

func main() {
    fmt.Println(Num0, Num1, Num2, Num3)   // 0 1 2 3
    fmt.Println(Even0, Even1, Even2, Even3) // 0 2 4 6
    fmt.Println(A0, A1, A3, A4, A6)       // 1 13 37 4 6

    // **注意**
    // 1. iota 的值本质上与当前 const 分组中的相对行号有关。
    // 2. 每个新的 const 分组都会重置 iota。
}
```

#### 枚举

Go 没有内建的枚举类型，通常通过“自定义类型 + const + iota”来实现枚举效果。这也是 Go 中最常见的枚举写法。

先定义一个具名类型。再使用 `const` 和 `iota` 声明一组常量。若需要更好的打印效果，可以为该类型实现 `String()` 方法。

```go
package main

import "fmt"

type Season uint8

const (
    Spring Season = iota
    Summer
    Autumn
    Winter
)

func (s Season) String() string {
    switch s {
    case Spring:
        return "spring"
    case Summer:
        return "summer"
    case Autumn:
        return "autumn"
    case Winter:
        return "winter"
    }
    return ""
}

func main() {
    var seasonValue Season = Autumn

    fmt.Println(Spring, Summer, Autumn, Winter) // spring summer autumn winter
    fmt.Println(seasonValue)                    // autumn
    fmt.Println(Season(6))                      // 空字符串，对应未覆盖值

    // **注意**
    // 1. 这种枚举本质上仍然是数字常量。
    // 2. Go 不会自动限制非法枚举值，因此 Season(6) 仍然是合法转换。
    // 3. 若需要字符串表现形式，通常需要手动实现 String() 方法。
}
```

### 运算符

运算符用于在程序运行时执行数学或逻辑运算。

Go 语言内置的运算符有：

- 算术运算符
- 关系运算符
- 逻辑运算符
- 位运算符
- 赋值运算符
- 其他运算符

#### 运算符分类

1. 算术、关系、逻辑、位、赋值运算符都属于基础表达式运算。
2. `&`、`*`、`<-` 这类运算符分别与指针和通道相关。
3. 不同运算符之间存在优先级，必要时应使用括号明确运算顺序。

**算术运算符**

下表列出了所有Go语言的算术运算符。假定 A 值为 10，B 值为 20。

| 运算符 | 描述 | 实例               |
| :----- | :--- | :----------------- |
| +      | 相加 | A + B 输出结果 30  |
| -      | 相减 | A - B 输出结果 -10 |
| *      | 相乘 | A * B 输出结果 200 |
| /      | 相除 | B / A 输出结果 2   |
| %      | 求余 | B % A 输出结果 0   |
| ++     | 自增 | A++ 输出结果 11    |
| --     | 自减 | A-- 输出结果 9     |

**关系运算符**

下表列出了所有Go语言的关系运算符。假定 A 值为 10，B 值为 20。

| 运算符 | 描述                                                         | 实例              |
| :----- | :----------------------------------------------------------- | :---------------- |
| ==     | 检查两个值是否相等，如果相等返回 True 否则返回 False。       | (A == B) 为 False |
| !=     | 检查两个值是否不相等，如果不相等返回 True 否则返回 False。   | (A != B) 为 True  |
| >      | 检查左边值是否大于右边值，如果是返回 True 否则返回 False。   | (A > B) 为 False  |
| <      | 检查左边值是否小于右边值，如果是返回 True 否则返回 False。   | (A < B) 为 True   |
| >=     | 检查左边值是否大于等于右边值，如果是返回 True 否则返回 False。 | (A >= B) 为 False |
| <=     | 检查左边值是否小于等于右边值，如果是返回 True 否则返回 False。 | (A <= B) 为 True  |

**逻辑运算符**

下表列出了所有Go语言的逻辑运算符。假定 A 值为 True，B 值为 False。

| 运算符 | 描述                                                         | 实例               |
| :----- | :----------------------------------------------------------- | :----------------- |
| &&     | 逻辑 AND 运算符。 如果两边的操作数都是 True，则条件 True，否则为 False。 | (A && B) 为 False  |
| \|\|   | 逻辑 OR 运算符。 如果两边的操作数有一个 True，则条件 True，否则为 False。 | (A \|\| B) 为 True |
| !      | 逻辑 NOT 运算符。 如果条件为 True，则逻辑 NOT 条件 False，否则为 True。 | !(A && B) 为 True  |

**位运算符**

位运算符对整数在内存中的二进制位进行操作。

下表列出了位运算符 &, |, 和 ^ 的计算：

| p    | q    | p & q | p \| q | p ^ q |
| :--- | :--- | :---- | :----- | :---- |
| 0    | 0    | 0     | 0      | 0     |
| 0    | 1    | 0     | 1      | 1     |
| 1    | 1    | 1     | 1      | 0     |
| 1    | 0    | 0     | 1      | 1     |

Go 语言支持的位运算符如下表所示。假定 A 为60，B 为13：

| 运算符 | 描述                                                         | 实例                                   |
| :----- | :----------------------------------------------------------- | :------------------------------------- |
| &      | 按位与运算符"&"是双目运算符。 其功能是参与运算的两数各对应的二进位相与。 | (A & B) 结果为 12, 二进制为 0000 1100  |
| \|     | 按位或运算符"\|"是双目运算符。 其功能是参与运算的两数各对应的二进位相或 | (A \| B) 结果为 61, 二进制为 0011 1101 |
| ^      | 按位异或运算符"^"是双目运算符。 其功能是参与运算的两数各对应的二进位相异或，当两对应的二进位相异时，结果为1。 | (A ^ B) 结果为 49, 二进制为 0011 0001  |
| <<     | 左移运算符"<<"是双目运算符。左移n位就是乘以2的n次方。 其功能把"<<"左边的运算数的各二进位全部左移若干位，由"<<"右边的数指定移动的位数，高位丢弃，低位补0。 | A << 2 结果为 240 ，二进制为 1111 0000 |
| >>     | 右移运算符">>"是双目运算符。右移n位就是除以2的n次方。 其功能是把">>"左边的运算数的各二进位全部右移若干位，">>"右边的数指定移动的位数。 | A >> 2 结果为 15 ，二进制为 0000 1111  |

**赋值运算符**

下表列出了所有Go语言的赋值运算符。

| 运算符 | 描述                                           | 实例                                  |
| :----- | :--------------------------------------------- | :------------------------------------ |
| =      | 简单的赋值运算符，将一个表达式的值赋给一个左值 | C = A + B 将 A + B 表达式结果赋值给 C |
| +=     | 相加后再赋值                                   | C += A 等于 C = C + A                 |
| -=     | 相减后再赋值                                   | C -= A 等于 C = C - A                 |
| *=     | 相乘后再赋值                                   | C *= A 等于 C = C * A                 |
| /=     | 相除后再赋值                                   | C /= A 等于 C = C / A                 |
| %=     | 求余后再赋值                                   | C %= A 等于 C = C % A                 |
| <<=    | 左移后赋值                                     | C <<= 2 等于 C = C << 2               |
| >>=    | 右移后赋值                                     | C >>= 2 等于 C = C >> 2               |
| &=     | 按位与后赋值                                   | C &= 2 等于 C = C & 2                 |
| ^=     | 按位异或后赋值                                 | C ^= 2 等于 C = C ^ 2                 |
| \|=    | 按位或后赋值                                   | C \|= 2 等于 C = C \| 2               |

**其他运算符**

下表列出了Go语言的其他运算符。

| 运算符 | 描述                                       | 实例                       |
| :----- | :----------------------------------------- | :------------------------- |
| &      | 返回变量存储地址                           | &a; 将给出变量的实际地址。 |
| *      | 指针变量。                                 | *a; 是一个指针变量         |
| <-     | 该运算符的名称为接收。它用于从通道接收值。 |                            |

```go
package main

import "fmt"

func main() {
    leftValue, rightValue := 10, 20
    leftBool, rightBool := true, false
    bitLeftValue, bitRightValue := 60, 13

    fmt.Println(leftValue+rightValue) // 30
    fmt.Println(leftValue-rightValue) // -10
    fmt.Println(leftValue*rightValue) // 200
    fmt.Println(rightValue/leftValue) // 2
    fmt.Println(rightValue%leftValue) // 0

    leftValue++
    rightValue--
    fmt.Println(leftValue, rightValue) // 11 19

    fmt.Println(leftValue == rightValue) // false
    fmt.Println(leftValue != rightValue) // true
    fmt.Println(leftValue > rightValue)  // false
    fmt.Println(leftValue < rightValue)  // true

    fmt.Println(leftBool && rightBool) // false
    fmt.Println(leftBool || rightBool) // true
    fmt.Println(!leftBool)             // false

    fmt.Println(bitLeftValue & bitRightValue)  // 12
    fmt.Println(bitLeftValue | bitRightValue)  // 61
    fmt.Println(bitLeftValue ^ bitRightValue)  // 49
    fmt.Println(bitLeftValue << 2)             // 240
    fmt.Println(bitLeftValue >> 2)             // 15

    assignValue := 10
    assignValue += 2
    assignValue *= 3
    assignValue >>= 1
    fmt.Println(assignValue) // 18

    channelValue := make(chan int, 1)
    channelValue <- 100
    fmt.Println(<-channelValue) // 100

    pointerSource := 3
    pointerValue := &pointerSource
    fmt.Println(pointerSource, *pointerValue, pointerValue)

    // **注意**
    // 1. ++ 和 -- 在 Go 中是语句，不是表达式。
    // 2. 位运算只适用于整数类型。
    // 3. <- 同时可用于发送和接收，方向由位置决定。
}
```

#### 运算符优先级

1. 二元运算符的运算方向均是从左至右。
2. 当表达式较复杂时，建议使用括号明确优先级。
3. `* / % << >> & &^` 的优先级高于 `+ - | ^`，关系运算高于逻辑运算。

有些运算符拥有较高的优先级，二元运算符的运算方向均是从左至右。下表列出了所有运算符以及它们的优先级，由上至下代表优先级由高到低：

| 优先级 | 运算符           |
| :----- | :--------------- |
| 5      | * / % << >> & &^ |
| 4      | + - \| ^         |
| 3      | == != < <= > >=  |
| 2      | &&               |
| 1      | \|\|             |

```go
package main

import "fmt"

func main() {
    firstResult := 2 + 3*4
    secondResult := (2 + 3) * 4
    thirdResult := 1 < 2 && 3 < 4 || false
    fourthResult := 1 < 2 && (3 < 4 || false)

    fmt.Println(firstResult)  // 14
    fmt.Println(secondResult) // 20
    fmt.Println(thirdResult)  // true
    fmt.Println(fourthResult) // true
}
```

#### * 和 &

1. `&variableValue` 表示取地址，得到变量的指针。
2. `*pointerValue` 表示解引用，访问指针指向的值。
3. 在声明中，`*Type` 表示“指向 Type 的指针类型”。

```go
package main

import "fmt"

func main() {
    var integerValue int = 3
    var pointerValue *int

    pointerValue = &integerValue

    fmt.Println(integerValue, *pointerValue, pointerValue)

    // **注意**
    // 1. & 用于取地址。
    // 2. * 用于解引用或声明指针类型。
    // 3. *pointerValue 读取的是指针指向的实际值。
}
```

### 类型转换

类型转换用于将一种数据类型的变量转换为另外一种类型的变量。Go 不支持隐式类型转换，若类型不同，通常需要显式转换。

#### 基本格式

Go 语言类型转换的基本格式为 `TypeName(expression)`。转换前后类型必须兼容，否则无法通过编译。

```go
TypeName(expression)
// TypeName: 目标类型
// expression: 待转换的值或表达式
// 返回结果: 转换后的值
```

#### 数值与字符串转换

数值类型之间转换时，应注意精度、范围和截断问题。字符串转整数常使用 `strconv.Atoi`。

`strconv.Atoi` 返回两个值：转换结果与错误值。

```go
package main

import (
    "fmt"
    "strconv"
)

func main() {
    var integer64Value int64 = 3
    var integer32Value int32

    integer32Value = int32(integer64Value)
    fmt.Println(integer32Value) // 3

    stringValue := "10"
    integerValue, err := strconv.Atoi(stringValue)
    fmt.Println(integerValue, err) // 10 <nil>

    // **注意**
    // 1. Go 不支持隐式数值类型转换。
    // 2. 字符串转数字时通常需要处理 error。
}
```

#### 接口断言与接口值处理

类型断言用于从接口值中取出具体类型。常见写法是 `value.(T)` 或 `value, ok := interfaceValue.(T)`。当接口需要处理多种具体类型时，常结合 `switch` 使用。

```go
value, ok := interfaceValue.(TargetType)
// interfaceValue: 接口值
// TargetType: 目标具体类型
// value: 断言后的值
// ok: 断言是否成功
```

```go
package main

import "fmt"

type Writer interface {
    Write([]byte) (int, error)
}

type StringWriter struct {
    str string
}

func (sw *StringWriter) Write(data []byte) (int, error) {
    sw.str += string(data)
    return len(data), nil
}

func printValue(value interface{}) {
    switch convertedValue := value.(type) {
    case int:
        fmt.Println("Integer:", convertedValue)
    case string:
        fmt.Println("String:", convertedValue)
    default:
        fmt.Println("Unknown type")
    }
}

func main() {
    var interfaceValue interface{} = "Hello, World"
    stringValue, ok := interfaceValue.(string)
    if ok {
        fmt.Printf("%q is a string
", stringValue)
    }

    var writerValue Writer = &StringWriter{}
    stringWriterValue := writerValue.(*StringWriter)
    stringWriterValue.str = "Go"
    fmt.Println(stringWriterValue.str) // Go

    printValue(42)
    printValue("hello")
    printValue(3.14)

    // **注意**
    // 1. 类型断言失败时，双返回值写法不会 panic。
    // 2. 单返回值断言失败会 panic。
    // 3. interface{} 可以持有任意类型的值。
}
```

#### 不支持隐式转换

Go 不支持类似 `int32 = int64` 这样的隐式转换。比较、赋值、函数传参时，只要类型不同，就可能需要显式转换。

```go
package main

import "fmt"

func main() {
    var leftValue int64 = 3
    var rightValue int32

    rightValue = int32(leftValue)
    fmt.Printf("rightValue = %d", rightValue)

    // **注意**
    // 1. cannot use leftValue (type int64) as type int32 in assignment
    //    这类报错通常意味着需要显式类型转换。
}
```

### 控制流与函数

#### 分支与循环

##### 条件控制

**If 语句**：`if` 用于条件判断，当条件为 `true` 时执行对应代码块，否则执行 `else` 或 `else if` 分支。`if` 也可以先写一个简单语句，再判断条件，这种形式常用于局部变量只在判断内部生效的场景。

流程图如下：

![Go 语言 if 语句](./assets/bTaq6OdDxlnPXWDv.png)

```go
if condition {
    statement
} else {
    statement
}
```

```go
if initStatement; condition {
    statement
} else {
    statement
}
```

```go
package main

import "fmt"

func main() {
    integerValue := 10

    if integerValue > 0 {
        fmt.Println("integerValue > 0")
    } else {
        fmt.Println("integerValue <= 0")
    }

    if comparedValue := integerValue - 5; comparedValue > 0 {
        fmt.Println("comparedValue > 0")
    } else if comparedValue == 0 {
        fmt.Println("comparedValue == 0")
    } else {
        fmt.Println("comparedValue < 0")
    }
}
```

**switch 语句**：`switch` 用于在多个分支之间做匹配选择。它可以基于一个表达式逐个匹配 `case`，也可以省略表达式直接写条件判断。`case` 支持多值匹配，`default` 用作兜底分支。与很多语言不同，Go 的 `switch` 在命中一个 `case` 后默认不会继续向下执行，因此通常不需要手动写 `break`。如果确实需要继续进入下一个分支，可以使用 `fallthrough`，但它不会再次判断下一条 `case` 的条件。

流程图：

![img](./assets/JhOEChInS6HWjqCV.png)

```go
switch expression {
case value1:
    statement
case value2, value3:
    statement
default:
    statement
}
```

```go
switch {
case condition1:
    statement
case condition2:
    statement
default:
    statement
}
```

`switch` 还可以写成 `type-switch`，用于判断接口值内部保存的具体类型：

```go
switch interfaceValue.(type) {
case targetType:
    statement
default:
    statement
}
```

```go
package main

import "fmt"

func main() {
    integerValue := 10

    switch integerValue {
    case 1, 2, 3:
        fmt.Println("small")
    case 10:
        fmt.Println("ten")
    default:
        fmt.Println("other")
    }

    switch {
    case integerValue > 0:
        fmt.Println("integerValue > 0")
        fallthrough
    case integerValue > 5:
        fmt.Println("integerValue > 5")
    default:
        fmt.Println("default")
    }

    var interfaceValue any = "Go"

    switch convertedValue := interfaceValue.(type) {
    case string:
        fmt.Println("string:", convertedValue)
    case int:
        fmt.Println("int:", convertedValue)
    default:
        fmt.Println("unknown")
    }

    // **注意**
    // 1. switch 默认命中一个 case 后就结束。
    // 2. fallthrough 直接进入下一个 case，不再判断条件。
    // 3. default 不论写在什么位置，逻辑上都作为最后的兜底分支。
}
```

**select 语句**：`select` 是专门处理通道操作的控制结构，形式上类似 `switch`，但每个 `case` 都必须是一次通道发送或接收。它会监听所有分支，一旦某个通道可以通信，就执行对应分支；如果多个分支同时满足，会伪随机选择一个；如果所有分支都不能执行，则进入 `default`，若没有 `default` 则阻塞。因此它经常与 `for` 组合，形成 `for-select` 循环，用来持续管理任务、连接或消息流。

```go
select {
case <-channel1:
    statement
case value := <-channel2:
    statement
case channel3 <- value:
    statement
default:
    statement
}
```

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    firstChannel := make(chan string, 1)
    secondChannel := make(chan string, 1)

    firstChannel <- "first"

    select {
    case value := <-firstChannel:
        fmt.Println(value)
    case value := <-secondChannel:
        fmt.Println(value)
    default:
        fmt.Println("default")
    }

    timeoutChannel := make(chan string, 1)

    go func() {
        time.Sleep(2 * time.Second)
        timeoutChannel <- "result"
    }()

    select {
    case result := <-timeoutChannel:
        fmt.Println(result)
    case <-time.After(1 * time.Second):
        fmt.Println("timeout")
    }

    // **注意**
    // 1. 若没有 default 且没有可执行分支，select 会阻塞。
    // 2. nil channel 上的操作会一直阻塞。
    // 3. time.After 常用于超时控制。
}
```

##### 循环

**for 循环**：`for` 是 Go 中唯一的循环语句。它可以表达传统的三段式循环、类似 `while` 的条件循环、无限循环，以及通过 `range` 完成的遍历循环。

for 语句语法流程如下图所示：

![img](./assets/PVFUw4TZATYSimWQ.png)

最接近传统写法的是三段式 `for`，分别对应初始化语句、循环条件和每轮结束后的更新语句：

```go
for init; condition; post {
    statement
}
```

如果只保留条件部分，就形成了类似 `while` 的风格：

```go
for condition {
    statement
}
```

如果三部分都省略，就会形成无限循环：

```go
for {
    statement
}
```

`range` 形式则常用于遍历数组、切片、字符串、映射和通道：

```go
for key, value := range collectionValue {
    statement
}
```

其中 `key` 和 `value` 都可以按需省略：

```go
for key := range collectionValue {
    statement
}
```

```go
for _, value := range collectionValue {
    statement
}
```

**break 语句**：`break` 用于终止当前循环或 `switch`。

**continue 语句**：`continue` 用于结束当前轮次，进入下一轮循环。

**goto 语句**：`goto` 可以无条件跳转到指定标签，通常与条件语句配合使用，可用于跳出复杂流程、构造循环等，但在普通代码中应谨慎使用，以免破坏可读性。

```go
goto label
...
label:
    statement
```

goto 语句流程图如下：

![img](./assets/xsTjcmiTVayxBjYe.png)

```go
package main

import "fmt"

func main() {
    for index := 0; index < 3; index++ {
        fmt.Println("for:", index)
    }

    counterValue := 0
    for counterValue < 3 {
        fmt.Println("while-style:", counterValue)
        counterValue++
    }

    mapValue := map[string]int{
        "a": 1,
        "b": 2,
    }
    for key, value := range mapValue {
        fmt.Println(key, value)
    }

    for numberValue := 0; numberValue < 5; numberValue++ {
        if numberValue == 1 {
            continue
        }
        if numberValue == 3 {
            break
        }
        fmt.Println("loop:", numberValue)
    }

    goto labelValue

labelValue:
    fmt.Println("goto label reached")

    // **注意**
    // 1. Go 只有 for，没有独立的 while 和 do-while。
    // 2. range 的 key、value 都可以按需省略。
    // 3. continue 进入下一轮循环，break 结束当前循环或 switch。
    // 4. goto 可用但应谨慎使用。
}
```

#### 函数

函数是基本的代码块，用于执行一个任务。Go 语言最少有一个 `main()` 函数。函数声明告诉编译器函数的名称、参数和返回类型。Go 语言标准库提供了多种内置函数，例如 `len()` 可以接受不同类型的参数并返回对应长度：传入字符串时返回字符串长度，传入数组时返回数组中元素个数。

##### 定义

Go 语言函数定义格式如下：

```go
func functionName(parameterList) returnTypes {
    statement
}
```

函数定义说明：

- `func`：函数声明关键字。
- `functionName`：函数名称，参数列表和返回值类型共同构成函数签名。
- `parameterList`：参数列表。参数相当于函数内部可用的局部变量，用于接收调用时传入的实际参数。参数列表规定参数的类型、顺序和数量。参数可以省略，也就是说函数可以没有参数。
- `returnTypes`：返回类型。函数可以返回一个值，也可以返回多个值；如果函数不需要返回值，这部分可以省略。
- 函数体：函数定义中的代码集合。

```go
func functionName(parameterName Type, anotherParameter Type) ReturnType {
    statement
}
```

```go
func functionName(parameterName Type) (ReturnType1, ReturnType2) {
    statement
}
```

##### 调用

当创建函数时，你定义了函数需要完成的任务；通过调用该函数来执行对应逻辑。调用函数时可以传递参数，并接收返回值。Go 函数支持多值返回。

```go
package main

import "fmt"

func swapValue(leftValue, rightValue string) (string, string) {
    return rightValue, leftValue
}

func main() {
    firstValue, secondValue := swapValue("Google", "Runoob")
    fmt.Println(firstValue, secondValue)
}
```

##### 参数

函数如果使用参数，这些参数可以看作函数的形参。形参就像定义在函数体内部的局部变量。调用函数时，参数传递方式通常分为值传递和通过指针达到“引用传递”的效果。

**值传递**：调用函数时会把实参复制一份传入函数，因此在函数内部修改形参，不会影响原变量。**默认情况下，Go 使用值传递。这里一定一定需要注意，所有类型除非你主动使用&来传递地址，否则均是按值传递，即使是引用类型的切片，传递时也是传递副本而非本身。** 

```go
func swapValue(leftValue, rightValue int) int {
    tempValue := leftValue
    leftValue = rightValue
    rightValue = tempValue
    return tempValue
}
// 调用完毕后并不会使得传递的 leftValue、rightValue 交换值
```

**指针参数**：将变量地址传入函数后，函数内部通过解引用修改值，会影响原变量。

```go
package main

import "fmt"

func swapValue(leftPointer *int, rightPointer *int) {
    tempValue := *leftPointer
    *leftPointer = *rightPointer
    *rightPointer = tempValue
}

func main() {
    leftValue := 100
    rightValue := 200

    fmt.Printf("交换前，leftValue 的值: %d
", leftValue)
    fmt.Printf("交换前，rightValue 的值: %d
", rightValue)

    swapValue(&leftValue, &rightValue)

    fmt.Printf("交换后，leftValue 的值: %d
", leftValue)
    fmt.Printf("交换后，rightValue 的值: %d
", rightValue)
}
```

##### 变参

使用不同数量参数调用的函数称为可变参数函数。换句话说，允许用户在可变参数函数中传递零个或多个参数。`fmt.Printf` 就是典型示例：它前面有固定参数，后面可以接受任意数量的参数。

在可变参数函数声明中，最后一个参数的类型前面带有省略号 `...`，表示该函数可以接收任意数量的该类型参数。

```go
func functionName(parameterName ...Type) ReturnType {
    statement
}
```

可变参数在函数内部的行为类似切片。也可以将一个已有切片通过 `sliceValue...` 形式传入可变参数函数。当不传递任何参数时，函数内部接收到的可变参数切片为 `nil`。

```go
package main

import (
    "fmt"
    "strings"
)

func joinString(element ...string) string {
    return strings.Join(element, "-")
}

func main() {
    elementSlice := []string{"geeks", "FOR", "geeks"}
    fmt.Println(joinString(elementSlice...))
}
```

##### 匿名函数与闭包

Go 语言支持匿名函数，也支持闭包。匿名函数是一个内联函数表达式，可以直接定义并使用。它的优点是可以直接访问当前作用域中的变量，而不必额外声明命名函数。匿名函数可以赋值给变量、作为参数传递给其他函数，也可以作为返回值从函数中返回。

```go
func(parameterList) returnType {
    statement
}
```

直接调用的形式通常写作：

```go
func(parameterList) returnType {
    statement
}(argumentList)
```

```go
package main

import "fmt"

func showResult(callback func(leftValue, rightValue string) string) {
    fmt.Println(callback("Geeks", "for"))
}

func getMessageFunc() func(firstValue, secondValue string) string {
    messageFunc := func(firstValue, secondValue string) string {
        return firstValue + secondValue + "cainiaojc"
    }
    return messageFunc
}

func main() {
    printer := func() {
        fmt.Println("Welcome! to (cainiaojc.com)")
    }
    printer()

    func(element string) {
        fmt.Println(element)
    }("cainiaojc")

    joinValue := func(leftValue, rightValue string) string {
        return leftValue + rightValue + "Geeks"
    }
    showResult(joinValue)

    messageFunc := getMessageFunc()
    fmt.Println(messageFunc("Welcome ", "to "))
}
```

##### 多值返回与命名返回

在 Go 语言中，允许使用 `return` 语句从一个函数返回多个值。返回值的类型写在参数列表之后，语法形式与参数列表类似。

```go
func functionName(parameterList) (returnTypeList) {
    statement
}
```

Go 也允许为返回值提供名称。命名返回值本质上是函数体内预先声明好的局部变量。函数中可以直接对这些变量赋值，然后使用裸返回 `return` 返回。

```go
func functionName(parameterName Type) (resultName1 Type, resultName2 Type) {
    statement
    return
}
```

```go
package main

import "fmt"

func calculateArea(lengthValue, widthValue int) (rectangleArea int, squareArea int) {
    rectangleArea = lengthValue * widthValue
    squareArea = lengthValue * lengthValue
    return
}

func main() {
    areaValue1, areaValue2 := calculateArea(2, 4)

    fmt.Printf("矩形面积为: %d", areaValue1)
    fmt.Printf("
正方形面积为: %d", areaValue2)
}
```

使用命名返回参数后，`return` 语句通常称为“裸返回”。默认情况下，Go 会用零值初始化所有命名返回值。如果函数体内没有为它们重新赋值，则返回的就是零值。命名返回值已经在函数签名中声明，因此不能再用 `:=` 重新声明，否则会报错。

```go
func calculator(leftValue, rightValue int) (mul int, div int) {
    // mul := leftValue * rightValue // 非法：mul 已在函数签名中声明
    // div := leftValue / rightValue // 非法：div 已在函数签名中声明

    mul = leftValue * rightValue
    div = leftValue / rightValue
    return
}
```

##### 特殊函数

**main 函数**

在 Go 语言中，`main` 包是一个特殊包，与可执行程序一起使用，并且该包中必须包含 `main()` 函数。`main()` 函数是一种特殊类型的函数，它是可执行程序的入口点。它不带任何参数，也不返回任何内容。由于 `main()` 会被自动调用，因此无需显式调用。

**init 函数**

`init()` 函数与 `main()` 一样，不带任何参数，也不返回任何值。每个包中都可以存在一个或多个 `init()` 函数，它们会在包初始化时自动调用，并且先于 `main()` 执行。`init()` 常用于初始化无法在全局上下文中直接初始化的全局变量。

```go
package main

import "fmt"

func init() {
    fmt.Println("init called")
}

func main() {
    fmt.Println("main called")
}
```

##### 特殊用法

###### 空白标识符

Golang 中的 `_`（下划线）称为空白标识符。它通常用于忽略不需要的值，最常见的场景是函数返回多个值时，只接收其中一部分。Go 不允许在函数内部声明未使用的局部变量，因此空白标识符也常用于满足语法而明确表示“这个值不需要”。

```go
package main

import "fmt"

func multiplyAndDivide(leftValue int, rightValue int) (int, int) {
    return leftValue * rightValue, leftValue / rightValue
}

func main() {
    multipliedValue, _ := multiplyAndDivide(105, 7)
    fmt.Println("105 x 7 =", multipliedValue)
}
```

###### defer 关键字

在 Go 语言中，`defer` 语句会将函数、方法或匿名函数的执行延迟到当前函数返回之前。也就是说，`defer` 后面的调用参数会立即求值，但真正执行发生在外围函数即将结束时。

`defer` 常用于资源释放、关闭文件、关闭通道、解锁、记录退出日志等场景。多个 `defer` 会按 LIFO（后进先出）的顺序执行。

```go
defer functionCall(argumentList)
```

```go
package main

import "fmt"

func multiplyValue(leftValue, rightValue int) int {
    resultValue := leftValue * rightValue
    fmt.Println("Result:", resultValue)
    return resultValue
}

func showMessage() {
    fmt.Println("Hello!, www.cainiaojc.com Go语言菜鸟教程")
}

func main() {
    multiplyValue(23, 45)

    defer multiplyValue(23, 56)
    defer fmt.Println("defer 1")
    defer fmt.Println("defer 2")

    showMessage()

    // **注意**
    // 1. defer 的参数会在声明 defer 时立即求值。
    // 2. 多个 defer 按后进先出顺序执行。
}
```

###### 函数作为参数

Go 语言可以将函数作为另一个函数的参数传入，也可以先声明函数类型，再使用该类型约束参数。这种写法常见于回调、策略函数和高阶函数场景。

```go
package main

import "fmt"

type callback func(int) int

func main() {
    testCallback(1, callBack)
    testCallback(2, func(value int) int {
        fmt.Printf("我是回调，value：%d
", value)
        return value
    })
}

func testCallback(value int, functionValue callback) {
    functionValue(value)
}

func callBack(value int) int {
    fmt.Printf("我是回调，value：%d
", value)
    return value
}
```

#### 变量作用域

变量的作用域可以理解为：程序中哪些位置可以访问某个变量。在 Go 中，标识符采用词法作用域（静态作用域），也就是说，一个变量能否被访问，可以在编译阶段根据它所在的代码块确定。换句话说，变量通常只能在定义它的作用域内部使用。

Golang 变量的作用域规则通常可以分为两类，具体取决于声明变量的位置：

- **局部变量**：在函数或代码块内部声明。
- **全局变量**：在函数或代码块外部声明。

##### 局部变量

在函数或代码块中声明的变量称为局部变量。局部变量只能在声明它的函数或代码块内部访问，不能在外部直接使用。它们也可以在 `if`、`switch`、`for` 等语句内部声明，因此也常被称为块变量。

局部变量有几个典型特点：

1. 局部变量在所属函数执行结束后就不再存在。
2. 在外层代码块中声明的局部变量，可以被内层嵌套代码块访问。
3. 在循环体或条件块内部声明的变量，对块外不可见。
4. 同一作用域内不能重复声明同名变量，否则会产生编译错误。

```go
package main

import "fmt"

func main() {
    outerValue := 10

    if outerValue > 0 {
        innerValue := 20
        fmt.Println(outerValue) // 10
        fmt.Println(innerValue) // 20
    }

    for index := 0; index < 1; index++ {
        loopValue := 30
        fmt.Println(index, loopValue) // 0 30
    }

    // fmt.Println(innerValue) // 非法：innerValue 超出作用域
    // fmt.Println(loopValue)  // 非法：loopValue 超出作用域

    {
        fmt.Println(outerValue) // 10，内层代码块可以访问外层变量
    }

    // **注意**
    // 1. 局部变量只在所属代码块内有效。
    // 2. 外层局部变量可被内层访问，但反过来不行。
}
```

##### 全局变量

在函数或代码块之外定义的变量称为全局变量。全局变量在程序整个运行期间都存在，通常定义在包作用域中，可以被同一包中的多个函数访问。

全局变量的特点如下：

1. 定义在函数外部。
2. 生命周期贯穿整个程序运行过程。
3. 可以被多个函数共享访问。
4. 若函数内部存在同名局部变量，则局部变量会遮蔽全局变量。

```go
package main

import "fmt"

var globalValue = 100

func showGlobal() {
    fmt.Println(globalValue) // 100
}

func main() {
    fmt.Println(globalValue) // 100
    showGlobal()

    localValue := 200
    fmt.Println(localValue) // 200

    // **注意**
    // 1. 包级变量通常就是这里所说的全局变量。
    // 2. 全局变量可以被同一包中的函数直接访问。
}
```

##### 同名变量与遮蔽

如果函数中存在与全局变量同名的局部变量，编译器会优先选择局部变量。一般来说，在同一作用域中重复声明同名变量会报错；但如果它们位于不同作用域，则这是合法的。此时，内层同名变量会遮蔽外层变量。

```go
package main

import "fmt"

var value = 1

func main() {
    fmt.Println(value) // 1

    value := 2
    fmt.Println(value) // 2

    {
        value := 3
        fmt.Println(value) // 3
    }

    fmt.Println(value) // 2

    // **注意**
    // 1. 内层同名变量会遮蔽外层变量。
    // 2. 这种情况不是修改外层变量，而是重新声明了一个新的局部变量。
}
```

##### 形式参数

函数的形式参数本质上也属于局部变量。它们在函数调用时接收实参，在函数体内部可直接使用，作用域仅限于该函数内部。

```go
package main

import "fmt"

func addValue(leftValue int, rightValue int) int {
    return leftValue + rightValue
}

func main() {
    resultValue := addValue(10, 20)
    fmt.Println(resultValue) // 30
}
```

##### 初始化局部和全局变量

无论是局部变量还是全局变量，只要声明后没有显式赋值，Go 都会自动赋予它们对应类型的零值。因此，在 Go 中不存在“未初始化但无值可用”的普通变量。

| 数据类型 | 初始化默认值 |
| -------- | ------------ |
| int      | 0            |
| float32  | 0            |
| bool     | false        |
| string   | ""           |
| pointer  | nil          |

```go
package main

import "fmt"

var globalInteger int
var globalPointer *int

func main() {
    var localInteger int
    var localString string
    var localBool bool

    fmt.Println(globalInteger) // 0
    fmt.Println(globalPointer) // <nil>

    fmt.Println(localInteger) // 0
    fmt.Println(localString)  // ""
    fmt.Println(localBool)    // false
}
```

### 错误处理

在 Go 中，严格来说并没有传统意义上的“异常系统”，也没有 `try-catch-finally` 这样的语法。Go 更强调通过返回值来显式处理错误，因此错误通常是可见、可传递、可检查的，而不是隐藏在控制流之外。

从严重程度上看，Go 中的异常情况通常可以分为三类：`error`、`panic`、`fatal`。其中，`error` 属于正常流程中的错误，通常不会立刻导致程序崩溃；`panic` 表示非常严重的问题，程序应当在完成必要善后后退出，或在边界处被恢复；`fatal` 则表示极其致命的问题，程序应立即终止，通常不会执行任何清理逻辑。

Go 创始人并不希望开发者在普通逻辑里到处嵌套 `try-catch`，因此大多数情况下，错误会作为函数返回值返回。下面这个例子就很典型：

```go
package main

import (
    "fmt"
    "os"
)

func main() {
    if file, err := os.Open("README.txt"); err != nil {
        fmt.Println(err)
        return
    } else {
        fmt.Println(file.Name())
    }
}
```

这段代码的意图很直接：尝试打开文件，如果失败则输出错误并返回；如果错误为 `nil`，则表示打开成功，继续处理后续逻辑。

当然，这种写法的代价也很明显：一旦函数调用较多，代码里就会频繁出现 `if err != nil` 这样的判断。正因如此，外界对 Go 的错误处理一直有很多讨论。它的优点和缺点都很明显。

优点在于心智负担小：有错误就处理，不处理就返回；同时可读性通常较强，因为处理方式很统一，大多数情况下容易看懂控制流；此外也相对容易调试，因为错误沿调用链逐层返回，通常能较清楚地追溯来源。缺点则在于默认没有堆栈信息，`if err != nil` 容易导致重复代码较多，自定义错误通常通过 `var` 声明而不是常量，也容易出现变量遮蔽问题。

#### error

`error` 属于正常流程错误。它的出现是可以被接受的，大多数情况下应该显式处理；当然也可以忽略，但严重程度通常不足以立刻终止整个程序。

`error` 本身是一个预定义接口，定义如下：

```go
type error interface {
    Error() string
}
```

也就是说，只要某个类型实现了 `Error() string` 方法，它就可以作为错误类型使用。

error 在历史上也有过重要改进。自 Go 1.13 起，标准库引入了链式错误机制，并提供了更完善的错误检查函数，这也是当前 Go 错误处理的重要基础。

##### 创建

创建一个 `error` 最常见的方式有两种。第一种是使用 `errors.New` 创建一个简单错误；第二种是使用 `fmt.Errorf` 创建一个支持格式化的错误。

```go
package main

import (
    "errors"
    "fmt"
)

func sumPositive(leftValue, rightValue int) (int, error) {
    if leftValue <= 0 || rightValue <= 0 {
        return -1, errors.New("必须是正整数")
    }
    return leftValue + rightValue, nil
}

func main() {
    simpleErr := errors.New("这是一个错误")
    formatErr := fmt.Errorf("这是 %d 个格式化参数的错误", 1)

    fmt.Println(simpleErr)
    fmt.Println(formatErr)

    resultValue, err := sumPositive(1, 2)
    fmt.Println(resultValue, err) // 3 <nil>

    resultValue, err = sumPositive(-1, 2)
    fmt.Println(resultValue, err) // -1 必须是正整数
}
```

大多数情况下，为了更好的可维护性，一般不会在很多位置临时散落创建错误，而是会把常用错误定义成包级变量。标准库中也有大量这种写法：

```go
var (
    ErrInvalid    = errors.New("invalid argument")
    ErrPermission = errors.New("permission denied")
    ErrExist      = errors.New("file already exists")
    ErrNotExist   = errors.New("file does not exist")
)
```

##### 自定义错误

通过实现 `Error()` 方法，可以很容易地自定义错误类型。标准库 `errors.New` 的底层其实就是一个非常简单的错误类型实现，只不过它的表达能力有限。实际项目中，很多库和标准库本身都会定义自己的错误类型，以便携带更多上下文信息。

```go
package main

import "fmt"

type DivideError struct {
    dividee int
    divider int
}

func (de *DivideError) Error() string {
    return fmt.Sprintf("cannot divide %d by %d", de.dividee, de.divider)
}

func divide(dividee int, divider int) (int, error) {
    if divider == 0 {
        return 0, &DivideError{
            dividee: dividee,
            divider: divider,
        }
    }
    return dividee / divider, nil
}

func main() {
    resultValue, err := divide(100, 10)
    fmt.Println(resultValue, err) // 10 <nil>

    _, err = divide(100, 0)
    if err != nil {
        fmt.Println(err)
    }
}
```

##### 传递与包装

在很多情况下，当前函数拿到了一个错误，但它本身不负责最终处理，于是会把这个错误继续返回给上层调用者。这个过程就是错误的传递。

错误在传递过程中可能会被一层层包装。为了支持这种场景，Go 1.13 引入了标准的链式错误机制。一个包装错误通常除了实现 `Error()` 外，还会通过 `Unwrap()` 暴露它内部引用的原始错误。虽然这个类型本身不需要手写，实际开发中更常见的做法是通过 `fmt.Errorf` 和 `%w` 来包装错误：

```go
err := errors.New("这是一个原始错误")
wrapErr := fmt.Errorf("包装后的错误: %w", err)
```

这里必须使用 `%w`，并且参数只能是一个有效的 `error`。

##### 处理

错误处理中的最后一步是检查和判断错误。标准库 `errors` 包提供了几个很重要的函数。

`errors.Unwrap()` 用于解包错误链，返回当前错误包装的下一层错误。如果一个错误没有实现 `Unwrap() error`，那么 `errors.Unwrap(err)` 会返回 `nil`。

```go
package main

import (
    "errors"
    "fmt"
)

func main() {
    originalErr := errors.New("original")
    wrappedErr := fmt.Errorf("wrapped: %w", originalErr)

    fmt.Println(errors.Unwrap(wrappedErr)) // original
}
```

`errors.Is()` 用于判断错误链中是否包含某个指定错误。因此在判断错误时，不应该优先使用 `==`，而应该优先考虑 `errors.Is()`。

```go
package main

import (
    "errors"
    "fmt"
)

var originalErr = errors.New("this is an error")

func wrapLevel1() error {
    return fmt.Errorf("wrap level 1: %w", wrapLevel2())
}

func wrapLevel2() error {
    return originalErr
}

func main() {
    err := wrapLevel1()

    if errors.Is(err, originalErr) {
        fmt.Println("original")
    }
}
```

`errors.As()` 用于在错误链中查找第一个类型匹配的错误，并把它赋值给目标变量。它适合用于把 `error` 转换为某个具体错误类型，以便读取更详细的信息。

```go
package main

import (
    "errors"
    "fmt"
    "time"
)

type TimeError struct {
    Msg  string
    Time time.Time
}

func (e *TimeError) Error() string {
    return e.Msg
}

func newTimeError(msg string) error {
    return &TimeError{
        Msg:  msg,
        Time: time.Now(),
    }
}

func wrapLevel1() error {
    return fmt.Errorf("wrap level 1: %w", wrapLevel2())
}

func wrapLevel2() error {
    return newTimeError("original error")
}

func main() {
    var timeErr *TimeError
    err := wrapLevel1()

    if errors.As(err, &timeErr) {
        fmt.Println("original", timeErr.Time)
    }
}
```

需要注意的是：`target` 必须是“指向目标类型变量的指针”。如果具体错误本身是 `*TimeError`，那么传给 `errors.As` 的就应是 `&timeErr`。

##### 堆栈信息

标准库 `errors` 本身并不会自动提供堆栈信息。在一些需要定位错误来源的场景里，很多项目会使用第三方包进行增强，常见选择之一是 `github.com/pkg/errors`。

```go
package main

import (
    "fmt"

    "github.com/pkg/errors"
)

func do() error {
    return errors.New("error")
}

func main() {
    if err := do(); err != nil {
        fmt.Printf("%+v", err)
    }
}
```

通过格式化输出，可以看到更详细的调用位置信息。对于大型项目来说，这类增强错误信息在排查问题时会更方便。

#### panic 与 recover

`panic` 中文通常译为“恐慌”，表示十分严重的程序问题。它属于运行时异常的表达形式，通常意味着程序当前状态已经不适合继续正常执行。为了避免造成更严重的后果，程序会停止当前正常流程，并开始执行退出前的善后逻辑。

例如，向一个 `nil map` 写入值就会触发 `panic`：

```go
package main

func main() {
    var dictionary map[string]int
    dictionary["a"] = 'a'
}
```

```go
panic: assignment to entry in nil map
```

需要特别注意的是：当程序中存在多个 goroutine 时，只要任意一个 goroutine 发生 `panic` 且没有被恢复，整个程序最终都会崩溃。

##### 创建

显式创建 `panic` 很简单，使用内置函数 `panic` 即可：

```go
func panic(v any)
```

`panic` 接收一个 `any` 类型参数，这个值会在崩溃输出时一并打印出来。

```go
package main

func main() {
    initDataBase("", 0)
}

func initDataBase(host string, port int) {
    if len(host) == 0 || port == 0 {
        panic("非法的数据库连接参数")
    }
}
```

当初始化数据库连接失败时，程序就不应继续启动，因为失去关键依赖后继续运行没有意义。这类情况通常可以视为 `panic` 场景。

##### 善后

程序因为 `panic` 退出之前，会执行已经注册的 `defer` 语句。并且这种善后工作不仅会发生在当前函数中，还会沿调用链逐层向上执行。如果 `panic` 发生在下层函数中，上层函数的 `defer` 也会继续执行：

```go
package main

import "fmt"

func main() {
    defer fmt.Println("A")
    defer fmt.Println("B")
    fmt.Println("C")
    dangerOperation()
}

func dangerOperation() {
    defer fmt.Println(1)
    defer fmt.Println(2)
    panic("panic")
}
```

```go
C
2
1
B
A
panic: panic
```

如果 `defer` 中又发生了新的 `panic`，那么会形成新的 `panic` 叠加；后续正常逻辑不会继续执行。总的来说，当发生 `panic` 时，会立即退出所在函数，并执行当前函数的 `defer`；随后逐层上抛，上层函数也会执行自己的善后逻辑，直到程序停止运行或被 `recover` 捕获。

##### 恢复

当发生 `panic` 时，可以使用内置函数 `recover()` 进行恢复，从而阻止程序继续崩溃。`recover()` 必须在 `defer` 中直接调用，才能生效。

```go
package main

import "fmt"

func main() {
    dangerOperation()
    fmt.Println("程序正常退出")
}

func dangerOperation() {
    defer func() {
        if err := recover(); err != nil {
            fmt.Println(err)
            fmt.Println("panic恢复")
        }
    }()

    panic("发生panic")
}
```

```go
发生panic
panic恢复
程序正常退出
```

调用者完全不知道 `dangerOperation()` 内部发生过 `panic`，程序在恢复后仍然可以继续向下执行。

不过，`recover()` 有几个很容易踩坑的地方。它必须在 `defer` 中直接使用；即使多次使用，也只有真正命中的那个 `recover()` 能恢复本次 `panic`；在 `defer` 中再嵌套闭包去调用 `recover()`，通常无法恢复外层函数的 `panic`；`panic(nil)` 虽然也可以被恢复，但恢复时拿不到有效错误值，因此不推荐这样写。

例如，下面这种“在 defer 中再套一层闭包”的写法就无法恢复外层 `panic`：

```go
package main

func main() {
    dangerOperation()
}

func dangerOperation() {
    defer func() {
        func() {
            recover()
        }()
    }()

    panic("发生panic")
}
```

而 `panic(nil)` 也应该避免：

```go
package main

import "fmt"

func main() {
    dangerOperation()
    fmt.Println("程序正常退出")
}

func dangerOperation() {
    defer func() {
        if err := recover(); err != nil {
            fmt.Println(err)
            fmt.Println("panic恢复")
        }
    }()

    panic(nil)
}
```

```go
程序正常退出
```

可以看出，`panic` 确实被恢复了，但恢复时没有任何错误信息。

还需要注意 goroutine 场景：如果子 goroutine 发生 `panic`，它不会自动触发父 goroutine 的 `defer` 善后逻辑；如果直到子 goroutine 退出都没有恢复该 `panic`，程序会直接停止运行。

#### fatal

`fatal` 是一种极其严重的问题。当发生 `fatal` 时，程序需要立刻停止运行，并且通常不会执行任何善后工作。最典型的实现方式就是调用 `os.Exit()` 直接退出程序。

```go
package main

import (
    "fmt"
    "os"
)

func main() {
    dangerOperation("")
}

func dangerOperation(stringValue string) {
    if len(stringValue) == 0 {
        fmt.Println("fatal")
        os.Exit(1)
    }
    fmt.Println("正常逻辑")
}
```

```go
fatal
```

与 `panic` 不同，`fatal` 通常不会给程序留下恢复机会，也不会执行后续 `defer`。因此它更适合用于那些已经没有继续运行意义的致命状态。大多数情况下，`fatal` 并不是业务逻辑里主动设计的常规控制流，而是极端失败场景下的最后手段。

### 文件 I/O

Go 语言中文件处理常用的标准库主要有三个：`os` 负责和操作系统文件系统交互，`io` 提供读写 IO 的抽象接口，`fs` 提供文件系统抽象层。这一部分不按教程式展开，而按“文件”和“文件夹”两部分整理常见操作。

#### 文件

1. 打开文件：`os.Open` 以只读方式打开文件；它本质上是对 `OpenFile` 的简单封装。

```go
file, err := os.Open(filePath)
// filePath: 文件路径
// file: 打开的文件对象
// err: 打开失败时返回错误

func Open(name string) (*File, error)
```

2. 按指定模式打开或创建文件：`os.OpenFile` 能控制打开模式和权限。

```go
file, err := os.OpenFile(filePath, flag, perm)
// filePath: 文件路径
// flag: 打开模式
// perm: 文件权限
// file: 打开的文件对象
// err: 操作失败时返回错误

func OpenFile(name string, flag int, perm FileMode) (*File, error)
```

常见打开模式：必须在 `O_RDONLY`、`O_WRONLY`、`O_RDWR` 中指定一种，其余标志用于控制行为。

```go
os.O_RDONLY  // 只读
os.O_WRONLY  // 只写
os.O_RDWR    // 读写
os.O_APPEND  // 追加写入
os.O_CREATE  // 文件不存在则创建
os.O_EXCL    // 配合 O_CREATE，要求文件必须不存在
os.O_SYNC    // 同步 IO
os.O_TRUNC   // 打开时清空可写文件
```

常见权限位：最常见的是 Unix 风格权限位，如 `0644`、`0666`、`0755`。

```go
0644 // 所有者可读写，其他人只读
0666 // 所有人可读写
0755 // 所有者可读写执行，其他人可读执行
os.ModePerm // 0o777，权限位掩码
```

3. 判断文件是否存在或访问异常：打开失败后可结合 `os.IsNotExist` 判断。

```go
if os.IsNotExist(err) {
    // 文件不存在
} else if err != nil {
    // 文件访问异常
}
```

4. 获取文件信息：若只想获取文件信息而不读取内容，可使用 `os.Stat`。

```go
info, err := os.Stat(filePath)
// filePath: 文件路径
// info: 文件信息对象
// err: 获取失败时返回错误

func Stat(name string) (FileInfo, error)
```

5. 读取文件内容：可以使用 `(*os.File).Read`、`os.ReadFile` 或 `io.ReadAll`。

```go
n, err := file.Read(buffer)
// file: 已打开文件
// buffer: 目标字节切片
// n: 实际读取字节数
// err: 读取失败或读到末尾时返回错误

func (f *File) Read(b []byte) (n int, err error)
```

```go
data, err := os.ReadFile(filePath)
// filePath: 文件路径
// data: 文件内容字节切片
// err: 读取失败时返回错误

func ReadFile(name string) ([]byte, error)
```

```go
data, err := io.ReadAll(reader)
// reader: 实现 io.Reader 的对象
// data: 读取到的全部内容
// err: 读取失败时返回错误

func ReadAll(r Reader) ([]byte, error)
```

6. 写入文件内容：可以使用 `(*os.File).Write`、`(*os.File).WriteString`、`os.WriteFile`、`io.WriteString`。

```go
n, err := file.Write(data)
// file: 已打开文件
// data: 要写入的字节切片
// n: 实际写入字节数
// err: 写入失败时返回错误

func (f *File) Write(b []byte) (n int, err error)
```

```go
n, err := file.WriteString(text)
// file: 已打开文件
// text: 要写入的字符串
// n: 实际写入字节数
// err: 写入失败时返回错误

func (f *File) WriteString(s string) (n int, err error)
```

```go
err := os.WriteFile(filePath, data, perm)
// filePath: 文件路径
// data: 要写入的字节切片
// perm: 文件权限
// err: 写入失败时返回错误

func WriteFile(name string, data []byte, perm FileMode) error
```

```go
n, err := io.WriteString(writer, text)
// writer: 实现 io.Writer 的对象
// text: 要写入的字符串
// n: 实际写入字节数
// err: 写入失败时返回错误

func WriteString(w Writer, s string) (n int, err error)
```

7. 创建文件：`os.Create` 本质上也是对 `OpenFile` 的封装，等价于以 `O_RDWR|O_CREATE|O_TRUNC` 模式打开。

```go
file, err := os.Create(filePath)
// filePath: 文件路径
// file: 创建后的文件对象
// err: 创建失败时返回错误

func Create(name string) (*File, error)
```

8. 复制文件：可以使用“读出再写入”的方式，也可以用 `io.Copy` 边读边写；后者更常用。

```go
written, err := io.Copy(dst, src)
// dst: 目标 Writer
// src: 源 Reader
// written: 实际复制字节数
// err: 复制失败时返回错误

func Copy(dst Writer, src Reader) (written int64, err error)
```

9. 重命名或移动文件：使用 `os.Rename`。

```go
err := os.Rename(oldPath, newPath)
// oldPath: 原路径
// newPath: 新路径
// err: 操作失败时返回错误

func Rename(oldpath, newpath string) error
```

10. 删除文件：删除单个文件使用 `os.Remove`。

```go
err := os.Remove(filePath)
// filePath: 文件路径
// err: 删除失败时返回错误

func Remove(name string) error
```

11. 刷新到磁盘：调用 `file.Sync()` 将缓存写入磁盘。

```go
err := file.Sync()
// file: 已打开文件
// err: 刷盘失败时返回错误

func (f *File) Sync() error
```

12. 关闭文件：打开文件后通常应在第一时间写 `defer file.Close()`。

```go
defer file.Close()
// file: 已打开的文件对象
// 返回结果: 在当前函数结束前关闭文件
```

**示例**：打开或创建文件、判断错误、写入、追加、读取、查看信息、复制、重命名、刷盘并删除。

```go
package main

import (
    "fmt"
    "io"
    "os"
)

func main() {
    filePath := "README.txt"
    copyPath := "README_copy.txt"
    renamedPath := "README_done.txt"

    file, err := os.OpenFile(filePath, os.O_RDWR|os.O_CREATE|os.O_TRUNC, 0666)
    if os.IsNotExist(err) {
        fmt.Println("文件不存在")
        return
    } else if err != nil {
        fmt.Println("文件访问异常")
        return
    }
    defer file.Close()

    _, err = file.WriteString("hello world!
")
    if err != nil {
        fmt.Println(err)
        return
    }

    _, err = io.WriteString(file, "go file io
")
    if err != nil {
        fmt.Println(err)
        return
    }

    err = file.Sync()
    if err != nil {
        fmt.Println(err)
        return
    }

    data, err := os.ReadFile(filePath)
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Println(string(data))

    info, err := os.Stat(filePath)
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Println(info.Name(), info.Size())

    sourceFile, err := os.Open(filePath)
    if err != nil {
        fmt.Println(err)
        return
    }
    defer sourceFile.Close()

    targetFile, err := os.OpenFile(copyPath, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0666)
    if err != nil {
        fmt.Println(err)
        return
    }
    defer targetFile.Close()

    _, err = io.Copy(targetFile, sourceFile)
    if err != nil {
        fmt.Println(err)
        return
    }

    err = os.Rename(filePath, renamedPath)
    if err != nil {
        fmt.Println(err)
        return
    }

    err = os.Remove(copyPath)
    if err != nil {
        fmt.Println(err)
        return
    }

    err = os.Remove(renamedPath)
    if err != nil {
        fmt.Println(err)
        return
    }
}
```

#### 文件夹

1. 读取文件夹内容：可以直接使用 `os.ReadDir`，也可以先打开目录再调用 `(*os.File).ReadDir`。

```go
entries, err := os.ReadDir(dirPath)
// dirPath: 文件夹路径
// entries: 目录项列表
// err: 读取失败时返回错误

func ReadDir(name string) ([]DirEntry, error)
```

```go
entries, err := dir.ReadDir(n)
// dir: 已打开目录
// n: 读取数量，n < 0 时表示读取全部
// entries: 目录项列表
// err: 读取失败时返回错误

func (f *File) ReadDir(n int) ([]DirEntry, error)
```

2. 创建单个文件夹：使用 `os.Mkdir`。

```go
err := os.Mkdir(dirPath, perm)
// dirPath: 文件夹路径
// perm: 权限，如 0755
// err: 创建失败时返回错误

func Mkdir(name string, perm FileMode) error
```

3. 递归创建文件夹：使用 `os.MkdirAll`，会自动创建必要的父目录。

```go
err := os.MkdirAll(dirPath, perm)
// dirPath: 文件夹路径
// perm: 权限，如 0755
// err: 创建失败时返回错误

func MkdirAll(path string, perm FileMode) error
```

4. 获取文件夹信息：使用 `os.Stat` 判断路径是否存在、是否为目录。

```go
info, err := os.Stat(dirPath)
// dirPath: 文件夹路径
// info: 路径信息对象
// err: 获取失败时返回错误
```

5. 删除空文件夹：使用 `os.Remove`。

```go
err := os.Remove(dirPath)
// dirPath: 文件夹路径
// err: 删除失败时返回错误
```

6. 递归删除文件夹：使用 `os.RemoveAll`，会删除目录及其全部内容。

```go
err := os.RemoveAll(dirPath)
// dirPath: 文件夹路径
// err: 删除失败时返回错误

func RemoveAll(path string) error
```

7. 复制文件夹：标准库没有直接提供单个函数，通常使用 `filepath.Walk` 或 `filepath.WalkDir` 递归遍历目录，再结合 `os.MkdirAll` 和 `io.Copy` 完成复制。

```go
err := filepath.Walk(srcPath, walkFunc)
// srcPath: 源目录路径
// walkFunc: 遍历回调函数
// err: 遍历或复制失败时返回错误
```

**示例**：创建目录、读取目录内容、判断目录信息、在目录中创建文件、再次读取目录并递归删除目录。

```go
package main

import (
    "fmt"
    "os"
)

func main() {
    dirPath := "demo_dir/sub_dir"
    filePath := "demo_dir/sub_dir/demo.txt"

    err := os.MkdirAll(dirPath, 0755)
    if err != nil {
        fmt.Println(err)
        return
    }

    file, err := os.Create(filePath)
    if err != nil {
        fmt.Println(err)
        return
    }
    file.Close()

    entries, err := os.ReadDir("demo_dir")
    if err != nil {
        fmt.Println(err)
        return
    }

    for _, entry := range entries {
        fmt.Println(entry.Name(), entry.IsDir())
    }

    info, err := os.Stat("demo_dir")
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Println(info.Name(), info.IsDir())

    dir, err := os.Open("demo_dir")
    if err != nil {
        fmt.Println(err)
        return
    }
    defer dir.Close()

    subEntries, err := dir.ReadDir(-1)
    if err != nil {
        fmt.Println(err)
        return
    }

    for _, entry := range subEntries {
        fmt.Println(entry.Name(), entry.IsDir())
    }

    err = os.RemoveAll("demo_dir")
    if err != nil {
        fmt.Println(err)
        return
    }
}
```







## 类型系统与抽象设计

### 结构体

Golang 中的结构体（`struct`）是一种用户定义的类型，允许将多个可能不同类型的字段组合成一个整体。任何现实世界中具有一组属性的实体，都可以用结构体表示。这个概念通常会与面向对象语言中的类进行类比，但 Go 的结构体本身不支持继承，更强调组合。

例如，一个地址通常具有 `name`、`street`、`city`、`state`、`pincode` 等属性，把这些字段组合成一个结构体就很自然。

#### 定义与初始化

结构体定义的基本格式如下：

```go
type StructName struct {
    fieldName Type
}
```

相同类型的字段也可以合并书写：

```go
type Address struct {
    name, street, city, state string
    pincode                   int
}
```

结构体变量可以先声明，再使用零值初始化：

```go
var structValue StructName
// structValue: 结构体变量
// 返回结果: 所有字段都使用各自类型的零值初始化
```

也可以直接使用结构体字面量初始化：

```go
structValue := StructName{fieldValue1, fieldValue2, fieldValue3}
// 返回结果: 按字段声明顺序初始化结构体
```

还可以使用 `fieldName: fieldValue` 的形式按名称初始化字段。使用这种写法时，字段顺序无关紧要，也允许只初始化部分字段，其余字段会保留零值。

```go
structValue := StructName{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}
// 返回结果: 按字段名初始化结构体
```

访问结构体字段使用点运算符 `.`。如果持有的是结构体指针，也同样可以直接通过点运算符访问字段，Go 会自动完成解引用。

```go
structValue.fieldName = fieldValue
resultValue := structValue.fieldName
```

```go
structPointer := &StructName{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}
resultValue := structPointer.fieldName
```

**示例**：声明结构体、使用顺序字面量和命名字面量初始化、通过结构体值和结构体指针访问字段。

```go
type Address struct {
    name, street, city, state string
    pincode                   int
}

type Employee struct {
    firstName string
    lastName  string
    age       int
    salary    int
}

var defaultAddress Address

orderedAddress := Address{
    fieldValue1,
    fieldValue2,
    fieldValue3,
    fieldValue4,
    fieldValue5,
}

namedAddress := Address{
    name:    fieldValue1,
    city:    fieldValue2,
    pincode: fieldValue3,
}

employeePointer := &Employee{
    firstName: fieldValue1,
    lastName:  fieldValue2,
    age:       fieldValue3,
    salary:    fieldValue4,
}

defaultAddress.name = fieldValue1
resultValue1 := orderedAddress.city
resultValue2 := namedAddress.pincode
resultValue3 := employeePointer.firstName
resultValue4 := (*employeePointer).age
```

#### 比较

在 Go 中，两个相同类型的结构体如果所有字段都可比较，就可以直接使用 `==` 比较。若结构体中包含切片、映射、函数等不可比较字段，则不能直接使用 `==`，此时通常需要借助 `reflect.DeepEqual()`。

```go
leftStruct == rightStruct
// leftStruct: 左侧结构体值
// rightStruct: 右侧结构体值
// 返回结果: 所有字段都可比较且值相等时返回 true
```

```go
reflect.DeepEqual(leftValue, rightValue)
// leftValue: 左侧值
// rightValue: 右侧值
// 返回结果: 深度比较结果
```

**示例**：比较可比较结构体，以及包含不可比较字段的结构体。

```go
type ComparableStruct struct {
    fieldName1 Type1
    fieldName2 Type2
}

type NonComparableStruct struct {
    fieldName1 Type1
    fieldName2 []ElementType
}

comparableValue1 := ComparableStruct{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}
comparableValue2 := ComparableStruct{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}
comparableValue3 := ComparableStruct{
    fieldName1: anotherFieldValue1,
    fieldName2: fieldValue2,
}

resultValue1 := comparableValue1 == comparableValue2
resultValue2 := comparableValue1 == comparableValue3
resultValue3 := reflect.DeepEqual(comparableValue1, comparableValue2)

nonComparableValue1 := NonComparableStruct{
    fieldName1: fieldValue1,
    fieldName2: []ElementType{elementValue1, elementValue2},
}
nonComparableValue2 := NonComparableStruct{
    fieldName1: fieldValue1,
    fieldName2: []ElementType{elementValue1, elementValue2},
}

// nonComparableValue1 == nonComparableValue2 // 非法：字段不可比较
resultValue4 := reflect.DeepEqual(nonComparableValue1, nonComparableValue2)
```

#### 嵌套

Go 允许一个结构体作为另一个结构体的字段，这种形式通常称为结构体嵌套。换句话说，一个结构体可以把另一个结构体作为自己的字段来组织数据。

```go
type InnerStruct struct {
    fieldName Type
}

type OuterStruct struct {
    innerField InnerStruct
}
```

嵌套结构体通常用于表达更清晰的数据层级关系。

**示例**：将一个结构体作为另一个结构体的字段。

```go
type Address struct {
    city    string
    pincode int
}

type User struct {
    name    string
    address Address
}

userValue := User{
    name: fieldValue1,
    address: Address{
        city:    fieldValue2,
        pincode: fieldValue3,
    },
}

resultValue1 := userValue.name
resultValue2 := userValue.address.city
resultValue3 := userValue.address.pincode
```

#### 匿名结构

##### 匿名结构体

Go 支持匿名结构体。匿名结构体没有独立的类型名，适合只使用一次的临时结构。

```go
structValue := struct {
    fieldName1 Type1
    fieldName2 Type2
}{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}
```

##### 匿名字段

此外，结构体还支持匿名字段。匿名字段只写类型，不写字段名，Go 会自动把类型名作为字段名。匿名字段常用于组合。需要注意，同一个结构体中不能出现两个同类型匿名字段。

```go
type StructName struct {
    Type1
    Type2
}
```

匿名字段也可以和普通命名字段一起使用。

```go
type StructName struct {
    fieldName Type1
    Type2
}
```

**示例**：匿名结构体与匿名字段。

```go
type AnonymousFieldStruct struct {
    int
    string
    float64
}

anonymousStructValue := struct {
    fieldName1 Type1
    fieldName2 Type2
}{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}

anonymousFieldValue := AnonymousFieldStruct{
    fieldValue1,
    fieldValue2,
    fieldValue3,
}

resultValue1 := anonymousStructValue.fieldName1
resultValue2 := anonymousStructValue.fieldName2
resultValue3 := anonymousFieldValue.int
resultValue4 := anonymousFieldValue.string
resultValue5 := anonymousFieldValue.float64
```

#### 函数字段

在 Go 中，函数本身也是一种类型，因此结构体字段也可以是函数类型。这样可以把“数据”和“某个可替换的行为”放在同一个结构体里。

```go
type FunctionType func(parameterList) returnType

type StructName struct {
    fieldName FunctionType
}
```

也可以直接把匿名函数赋给结构体中的函数字段。

```go
structValue := StructName{
    fieldName: func(parameterName Type) ReturnType {
        statement
        return returnValue
    },
}
```

**示例**：定义函数字段并通过结构体字段调用该函数。

```go
type FunctionType func(parameterName1 Type1, parameterName2 Type2) ReturnType

type StructName struct {
    fieldName1    Type1
    fieldName2    Type2
    functionField FunctionType
}

structValue := StructName{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
    functionField: func(parameterName1 Type1, parameterName2 Type2) ReturnType {
        statement
        return returnValue
    },
}

resultValue := structValue.functionField(argumentValue1, argumentValue2)
```

### 方法

Go 语言支持方法。Go 方法与 Go 函数相似，但有一个重要区别：方法包含接收者参数。借助接收者，方法可以访问接收者对应的属性或行为。接收者既可以是结构类型，也可以是非结构类型。需要注意的是，方法和接收者类型必须定义在同一个包中，因此不能直接给 `int`、`string` 等内建类型添加方法。

方法的基本格式如下：

```go
func (receiverName ReceiverType) methodName(parameterList) returnType {
    statement
}
```

#### 结构类型接收器的方法

当接收者是结构体类型时，方法通常用于访问结构体字段，或围绕结构体组织相关行为。

```go
type StructName struct {
    fieldName1 Type1
    fieldName2 Type2
    fieldName3 Type3
}

func (receiverValue StructName) methodName() {
    statement
    resultValue1 := receiverValue.fieldName1
    resultValue2 := receiverValue.fieldName2
    resultValue3 := receiverValue.fieldName3
}
```

上面这种写法中，方法接收的是结构体值，因此方法内部拿到的是接收者的一个副本。适合读取数据、格式化输出、做不修改原值的计算。

```go
type Author struct {
    name         string
    branch       string
    articleCount int
    salary       int
}

func (authorValue Author) show() {
    outputName := authorValue.name
    outputBranch := authorValue.branch
    outputArticleCount := authorValue.articleCount
    outputSalary := authorValue.salary

    _, _, _, _ = outputName, outputBranch, outputArticleCount, outputSalary
    // 输出:
    // Author's Name: fieldValue1
    // Branch Name: fieldValue2
    // Published articles: fieldValue3
    // Salary: fieldValue4
}

authorValue := Author{
    name:         fieldValue1,
    branch:       fieldValue2,
    articleCount: fieldValue3,
    salary:       fieldValue4,
}

authorValue.show()
```

#### 非结构类型接收器的方法

在 Go 中，只要类型定义和方法定义位于同一包中，就可以为非结构类型定义方法。常见做法是先基于某个基础类型定义一个新的自定义类型，再为它添加方法。也正因为如此，不能直接给 `int`、`string` 这些内建类型本身定义方法。

```go
type DefinedType BaseType

func (receiverValue DefinedType) methodName(parameterName DefinedType) ReturnType {
    statement
    return returnValue
}
```

```go
type Data int

func (leftValue Data) multiply(rightValue Data) Data {
    return leftValue * rightValue
}

// 非法写法:
// func (leftValue int) multiply(rightValue int) int {
//     return leftValue * rightValue
// }

value1 := Data(expression1)
value2 := Data(expression2)
resultValue := value1.multiply(value2)
// 输出:
// resultValue = expressionResult
```

#### 指针接收器的方法

在 Go 中，方法也可以使用指针接收器。指针接收器最重要的特点是：方法内部对接收者所做的修改，会直接作用到原对象上。这一点是值接收器做不到的。

```go
func (receiverPointer *ReceiverType) methodName(parameterList) returnType {
    statement
}
```

```go
type StructName struct {
    fieldName1 Type1
    fieldName2 Type2
}

func (receiverPointer *StructName) methodName(parameterName Type) {
    receiverPointer.fieldName2 = parameterName
}

structValue := StructName{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}

structPointer := &structValue
structPointer.methodName(argumentValue)

// 调用前:
// fieldName2 = fieldValue2
// 调用后:
// fieldName2 = argumentValue
```

#### 值接收器与指针接收器的自动转换

众所周知，在 Go 中，普通函数如果参数类型是值，就不能直接传入指针；如果参数类型是指针，也不能直接传入值。但方法调用在这点上更灵活：Go 会在满足条件时自动完成值和指针之间的转换。

也就是说：

- 值变量可以调用指针接收器方法
- 指针变量也可以调用值接收器方法

不过它们的语义仍然不同：  值接收器拿到的是副本，修改不会影响原值；指针接收器拿到的是原对象地址，修改会反映到原值上。

```go
type StructName struct {
    fieldName1 Type1
    fieldName2 Type2
}

func (receiverPointer *StructName) pointerMethod(parameterName Type2) {
    receiverPointer.fieldName2 = parameterName
}

func (receiverValue StructName) valueMethod() {
    receiverValue.fieldName1 = anotherFieldValue
    temporaryValue := receiverValue.fieldName1
    _ = temporaryValue
    // 输出:
    // fieldName1 在方法内部已修改
}

structValue := StructName{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}

structValue.pointerMethod(argumentValue)
(&structValue).valueMethod()

// 调用前:
// fieldName2 = fieldValue2
// 调用后:
// fieldName2 = argumentValue
// fieldName1 在原对象中保持不变
```

#### 同名方法

在 Go 语言中，允许在同一包中创建两个或多个同名方法，但它们的接收者必须是不同类型。这个特性对函数不成立，也就是说，普通函数不能仅通过参数不同就在同一包中重名。

```go
func (receiverValue1 ReceiverType1) methodName(parameterList) returnType {
    statement
}

func (receiverValue2 ReceiverType2) methodName(parameterList) returnType {
    statement
}
```

```go
type StructType1 struct{}
type StructType2 struct{}

func (receiverValue StructType1) show() {
    statement
}

func (receiverValue StructType2) show() {
    statement
}

value1 := StructType1{}
value2 := StructType2{}

value1.show()
value2.show()
```

### 接口

Go 语言中的接口不同于很多传统面向对象语言中的接口。接口在 Go 中是一种自定义类型，用于描述一组方法签名。接口本身是抽象的，不能直接创建实例，但可以声明接口类型变量，并把实现了该接口全部方法的具体类型值赋给它。换句话说，接口既是一组方法的约定，也是一种类型。

#### 接口创建

接口的基本格式如下：

```go
type InterfaceName interface {
    methodName1(parameterList) returnType
    methodName2(parameterList) returnType
}
```

接口中只写方法签名，不写方法实现。一个接口中可以声明一个或多个方法签名，也可以不声明任何方法。

```go
type InterfaceName interface {
    methodName1() ReturnType1
    methodName2() ReturnType2
}
```

当接口中一个方法都没有时，这种接口通常称为空接口。空接口可以接收任意类型的值，因此它常用于需要接收不同类型参数的场景。旧写法常见为 `interface{}`，在较新的代码中也常见 `any`。

```go
var emptyInterfaceValue interface{}
var anyValue any

emptyInterfaceValue = expression1
anyValue = expression2
```

#### 接口实现

一个具体类型若想实现某个接口，就必须实现接口中声明的全部方法。Go 的接口实现是隐式的，不需要专门写 `implements` 之类的关键字。

```go
type InterfaceName interface {
    methodName1() ReturnType1
    methodName2() ReturnType2
}

type StructName struct {
    fieldName1 Type1
    fieldName2 Type2
}

func (receiverValue StructName) methodName1() ReturnType1 {
    statement
    return returnValue1
}

func (receiverValue StructName) methodName2() ReturnType2 {
    statement
    return returnValue2
}

var interfaceValue InterfaceName
interfaceValue = StructName{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
}
```

**示例**：定义接口、由结构体实现接口、再通过接口变量调用方法。

```go
type Tank interface {
    area() float64
    volume() float64
}

type Cylinder struct {
    radius float64
    height float64
}

func (receiverValue Cylinder) area() float64 {
    expression := 2*receiverValue.radius*receiverValue.height + 2*3.14*receiverValue.radius*receiverValue.radius
    return expression
}

func (receiverValue Cylinder) volume() float64 {
    expression := 3.14 * receiverValue.radius * receiverValue.radius * receiverValue.height
    return expression
}

var tankValue Tank
tankValue = Cylinder{
    radius: fieldValue1,
    height: fieldValue2,
}

resultValue1 := tankValue.area()
resultValue2 := tankValue.volume()

// 输出:
// resultValue1 = expressionResult1
// resultValue2 = expressionResult2
```

#### 多接口实现

一个具体类型可以同时实现多个接口。只要它实现了某个接口要求的全部方法，就可以赋值给该接口类型变量。因此，同一个结构体往往可以在不同接口语义下被复用。

```go
type InterfaceName1 interface {
    methodName1()
}

type InterfaceName2 interface {
    methodName2()
}

type StructName struct {
    fieldName Type
}

func (receiverValue StructName) methodName1() {
    statement
}

func (receiverValue StructName) methodName2() {
    statement
}

var interfaceValue1 InterfaceName1 = StructName{}
var interfaceValue2 InterfaceName2 = StructName{}
```

接口也支持嵌套。一个接口可以把其他接口直接写进自己的定义中，也可以把那些方法重新展开写一遍。两种写法表达的效果是一样的：最终接口的方法集是这些方法的并集。

```go
type InterfaceName1 interface {
    methodName1()
}

type InterfaceName2 interface {
    methodName2()
}

type FinalInterfaceName interface {
    InterfaceName1
    InterfaceName2
    methodName3()
}
```

**示例**：同一个结构体实现多个接口，并实现嵌套后的最终接口。

```go
type AuthorDetails interface {
    details()
}

type AuthorArticles interface {
    articles()
    picked()
}

type FinalDetails interface {
    AuthorDetails
    AuthorArticles
    extraDetails()
}

type Author struct {
    fieldName1 Type1
    fieldName2 Type2
    fieldName3 Type3
    fieldName4 Type4
}

func (receiverValue Author) details() {
    statement
}

func (receiverValue Author) articles() {
    statement
}

func (receiverValue Author) picked() {
    statement
}

func (receiverValue Author) extraDetails() {
    statement
}

authorValue := Author{
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
    fieldName3: fieldValue3,
    fieldName4: fieldValue4,
}

var detailsValue AuthorDetails = authorValue
var articlesValue AuthorArticles = authorValue
var finalValue FinalDetails = authorValue

detailsValue.details()
articlesValue.articles()
finalValue.details()
finalValue.articles()
finalValue.picked()
finalValue.extraDetails()

// 输出:
// authorValue 可以分别作为不同接口类型使用
// finalValue 可以访问嵌套接口的方法和当前接口新增的方法
```

#### 接口值

接口值可以理解为“动态类型 + 动态值”的组合。接口本身是静态类型，而接口变量中真正保存的是某个具体类型的具体值。若一个接口变量没有保存任何具体值，那么它的零值就是 `nil`。

```go
var interfaceValue InterfaceName
// interfaceValue: 接口变量
// 零值: nil
```

接口值内部可以近似理解为一个 `(dynamicType, dynamicValue)` 的组合。  
其中：

- `dynamicType` 表示当前接口内部保存的具体类型
- `dynamicValue` 表示当前接口内部保存的具体值

当接口变量没有绑定任何具体值时，这两个部分都可以看作是 `nil`。一旦把某个具体值赋给接口变量，接口的静态类型不会变，但它内部保存的动态类型和动态值会发生变化。

```go
var interfaceValue InterfaceName
interfaceValue = concreteValue
// interfaceValue: 静态类型仍然是 InterfaceName
// dynamicType: concreteType
// dynamicValue: concreteValue
```

空接口同样遵循这个规则，只不过由于空接口没有方法约束，因此几乎所有类型都可以赋值给它。

```go
var emptyInterfaceValue interface{}
var anyValue any

emptyInterfaceValue = expression1
emptyInterfaceValue = expression2
anyValue = expression3
```

在比较接口值时，比较的是它们内部保存的具体类型和值，而不是只比较表面上的接口变量名。也就是说：

- 先比较动态类型是否一致
- 再比较动态值是否相等

```go
leftValue == rightValue
// leftValue: 左侧接口值
// rightValue: 右侧接口值
// 返回结果: 动态类型相同且动态值相等时返回 true
```

如果接口内部保存的是不可比较类型，例如切片、映射等，那么直接比较会触发 `panic`。

```go
var leftValue interface{}
var rightValue interface{}

leftValue = expression1
rightValue = expression2

resultValue := leftValue == rightValue
// 当底层具体类型不可比较时，该操作会 panic
```

接口值还有一个很容易混淆的点：  
“接口值为 `nil`” 和 “接口里装着一个底层为 `nil` 的具体值” 不是一回事。前者表示接口本身没有动态类型和动态值；后者表示接口已经有动态类型，只是它内部保存的具体值是 `nil`。

```go
var interfaceValue1 interface{}
var pointerValue *TargetType = nil
var interfaceValue2 interface{} = pointerValue

resultValue1 := interfaceValue1 == nil
resultValue2 := interfaceValue2 == nil

// 输出:
// resultValue1 = true
// resultValue2 = false
// 因为 interfaceValue2 已经保存了动态类型 *TargetType
```

对于 Go 而言，内置数据类型是否可比较，大致可以整理为下表：

| 类型       | 可比较 | 依据                     |
| ---------- | ------ | ------------------------ |
| 数字类型   | 是     | 值是否相等               |
| 字符串类型 | 是     | 值是否相等               |
| 数组类型   | 是     | 数组全部元素是否相等     |
| 切片类型   | 否     | 不可比较                 |
| 结构体     | 是     | 字段值是否全部相等       |
| map 类型   | 否     | 不可比较                 |
| 通道       | 是     | 地址是否相等             |
| 指针       | 是     | 指针存储的地址是否相等   |
| 接口       | 是     | 底层所存储的数据是否相等 |

不过这里有一个前提：  像结构体、数组、接口这类“表面上可比较”的类型，前提都是其内部实际参与比较的值本身也必须可比较。否则在比较时仍然会触发 `panic`。

```go
type StructName struct {
    fieldName1 Type1
    fieldName2 Type2
}

leftValue == rightValue
// 只有当 Type1 和 Type2 都可比较时，这样的结构体才可比较
```

在 Go 中还有一个专门的预声明接口类型，用于表示“所有可比较类型”，即 `comparable`。它主要出现在泛型约束中，用来限制类型参数必须支持 `==` 和 `!=`。

```go
type comparable interface{ comparable }
// 含义: 代表所有可比较类型
```

**示例**：接口零值、空接口、接口比较、`nil` 接口与底层 `nil`、以及比较规则。

```go
type InterfaceName interface {
    methodName() ReturnType
}

var interfaceValue InterfaceName
var emptyInterfaceValue interface{}
var pointerValue *TargetType = nil
var wrappedNilValue interface{} = pointerValue

emptyInterfaceValue = expression1

resultValue1 := interfaceValue == nil
resultValue2 := wrappedNilValue == nil

compareValue1 := interface{}(expression2)
compareValue2 := interface{}(expression3)
compareResult := compareValue1 == compareValue2

// 如果底层具体值不可比较，则下面这种写法会 panic
// panicResult := interface{}(expression4) == interface{}(expression5)

// 输出:
// resultValue1 = true
// resultValue2 = false
// compareResult 取决于底层具体类型和值
// 当底层具体值不可比较时，接口比较会 panic
```

#### 接口用途

接口常用于以下场景：一是希望函数或方法能够接收不同类型的参数；二是多个具体类型共享同一组行为时，希望以统一方式处理它们；三是通过接口隔离具体实现，从而降低耦合。

当一个函数只关心“能做什么”，而不关心“具体是什么类型”时，接口就很适合。例如，一个函数只要参数实现了指定方法，就可以处理这个参数，而无需关心它背后到底是哪个结构体类型。

```go
type InterfaceName interface {
    methodName()
}

func functionName(interfaceValue InterfaceName) {
    interfaceValue.methodName()
}
```

类型断言也是接口的常见用途之一。它用于从接口值中提取具体值。基本格式为 `value.(T)`。如果断言失败，直接使用这种写法会触发 `panic`；为了更安全，通常使用双返回值形式 `value, ok := interfaceValue.(T)`。

```go
resultValue := interfaceValue.(TargetType)
// interfaceValue: 接口值
// TargetType: 目标类型
// 返回结果: 断言成功时返回具体值，失败时 panic
```

```go
resultValue, ok := interfaceValue.(TargetType)
// resultValue: 断言成功时得到具体值，失败时得到零值
// ok: 断言是否成功
```

当需要一次判断多个可能的具体类型时，通常使用类型判断，也就是 `switch interfaceValue.(type)`。

```go
switch interfaceValue.(type) {
case TargetType1:
    statement
case TargetType2:
    statement
case TargetType3:
    statement
default:
    statement
}
```

**示例**：统一处理实现同一接口的类型，并配合断言或类型判断提取具体值。

```go
type Reader interface {
    read()
}

type Type1 struct{}
type Type2 struct{}

func (receiverValue Type1) read() {
    statement
}

func (receiverValue Type2) read() {
    statement
}

func process(readerValue Reader) {
    readerValue.read()
}

var interfaceValue interface{}
interfaceValue = expression1

assertValue, ok := interfaceValue.(TargetType)

switch interfaceValue.(type) {
case TargetType:
    statement
default:
    statement
}

process(Type1{})
process(Type2{})

// 输出:
// process 可以统一处理所有实现 Reader 的类型
// 断言和类型判断可以进一步取出接口内部的具体值
```

### 泛型

泛型是 Go 语言在 1.18 版本中引入的重要特性，它让开发者能够编写更加灵活、可复用的代码。泛型的核心目标是：在不固定具体类型的前提下，先描述“这类类型都能做什么”，再基于这些约束编写统一逻辑。

泛型主要围绕两个核心概念展开：

- **类型参数（Type Parameters）**：允许在函数、结构体、接口等定义中引入待定类型。
- **类型约束（Type Constraints）**：限制类型参数必须满足的条件，从而保证泛型代码中的操作是安全的。

| 概念         | 作用                           | 示例                          |
| ------------ | ------------------------------ | ----------------------------- |
| 类型参数     | 在函数名或类型名后声明待定类型 | `[T any]`                     |
| 类型约束     | 限制类型参数必须满足的条件     | `comparable`、`int | float64` |
| `any`        | 表示任意类型                   | `[T any]`                     |
| `comparable` | 表示支持 `==`、`!=` 比较的类型 | `[K comparable]`              |

在引入泛型之前，如果想分别处理 `int`、`string`、`float64` 等多种类型，通常需要写多份逻辑相似的代码；而泛型的意义就在于把这种重复抽象掉。

#### 类型参数

泛型函数和泛型类型都通过类型参数列表声明，类型参数写在函数名或类型名后面的方括号中。

```go
func functionName[T Constraint](parameterName T) ReturnType {
    statement
}

type TypeName[T Constraint] struct {
    fieldName T
}
```

类型参数通常使用简短的大写字母命名，例如：

- `T`：Type
- `K`：Key
- `V`：Value
- `E`：Element

这些命名本身不是语法要求，只是一种常见约定。

```go
func functionName[T any](parameterName T) T {
    return parameterName
}

type Pair[K any, V any] struct {
    key   K
    value V
}
```

**示例**：定义泛型函数与泛型结构体。

```go
func identity[T any](parameterValue T) T {
    return parameterValue
}

type Pair[K any, V any] struct {
    key   K
    value V
}

resultValue1 := identity(expression1)
resultValue2 := identity(expression2)

pairValue := Pair[KeyType, ValueType]{
    key:   keyValue,
    value: valueValue,
}

// 输出:
// resultValue1 = expression1
// resultValue2 = expression2
// pairValue 保存一组不同类型的键和值
```

#### 类型约束

约束定义了类型参数必须满足的条件，它是泛型的核心。只有在约束允许的前提下，泛型函数内部才能安全地执行某些操作。

最常见的内置约束有两个：

- `any`：表示任意类型，本质上是 `interface{}` 的别名
- `comparable`：表示支持 `==` 与 `!=` 的类型

```go
func functionName[T any](parameterName T) {
    statement
}
```

```go
func functionName[T comparable](leftValue T, rightValue T) bool {
    return leftValue == rightValue
}
```

除了内置约束，也可以通过联合类型来定义约束，即使用 `|` 把多个类型组合在一起。这样定义出来的约束，表示类型参数只能从这些类型中取值。

```go
type ConstraintName interface {
    Type1 | Type2 | Type3
}
```

```go
type Number interface {
    int | int8 | int16 | int32 | int64 |
    uint | uint8 | uint16 | uint32 | uint64 |
    float32 | float64
}
```

有时约束不仅要求“底层类型属于某个集合”，还要求“实现某些方法”。这种约束可以把类型集合和方法集合组合在一起。

```go
type ConstraintName interface {
    Type1 | Type2
    methodName() ReturnType
}
```

**示例**：`any`、`comparable`、联合约束与方法约束。

```go
func printValue[T any](parameterValue T) {
    statement
}

func equalValue[T comparable](leftValue T, rightValue T) bool {
    return leftValue == rightValue
}

type Number interface {
    int | int64 | float32 | float64
}

func add[T Number](leftValue T, rightValue T) T {
    return leftValue + rightValue
}

type Stringer interface {
    String() string
}

func printString[T Stringer](parameterValue T) string {
    return parameterValue.String()
}

resultValue1 := equalValue(expression1, expression2)
resultValue2 := add(expression3, expression4)
resultValue3 := printString(expression5)

// 输出:
// resultValue1 = 比较结果
// resultValue2 = 数值求和结果
// resultValue3 = String() 返回结果
```

#### 通用接口

在 Go 1.18 引入泛型之后，接口的含义可以从“方法集合”进一步理解为“类型集合”。这时接口可以分成两类：

- **基本接口（Basic Interface）**：只包含方法集合
- **通用接口（General Interface）**：除了方法，还包含类型集合

也就是说，只要接口中出现了类型元素、联合类型、`~` 底层类型约束等内容，它就不再只是传统意义上的“方法接口”，而是泛型语境下的通用接口。

```go
type BasicInterface interface {
    methodName()
}
```

```go
type GeneralInterface interface {
    Type1 | Type2
}
```

```go
type GeneralInterface interface {
    ~int | ~int64
}
```

通用接口主要用于**约束类型参数**，而不是像普通接口那样拿来声明接口值变量。也就是说，这类接口更多是“泛型约束工具”，而不是“多态对象容器”。

```go
type Integer interface {
    ~int | ~int8 | ~int16 | ~int32 | ~int64
}

func sum[T Integer](leftValue T, rightValue T) T {
    return leftValue + rightValue
}
```

这里的 `~int` 表示“底层类型是 `int` 的类型”，因此不仅 `int` 本身可以满足约束，像 `type MyInt int` 这样的自定义类型也能满足。

**示例**：使用通用接口约束底层类型。

```go
type Integer interface {
    ~int | ~int32 | ~int64
}

type MyInt int

func addInteger[T Integer](leftValue T, rightValue T) T {
    return leftValue + rightValue
}

resultValue1 := addInteger(expression1, expression2)
resultValue2 := addInteger(MyInt(expression3), MyInt(expression4))

// 输出:
// resultValue1 = expression1 + expression2
// resultValue2 = MyInt(expression3 + expression4)
```

#### 泛型类型

泛型不仅可以用于函数，也可以用于结构体、切片包装器、映射包装器等类型定义。这样就能把“数据结构”和“适用类型”一起抽象出来。

泛型结构体的基本形式如下：

```go
type TypeName[T Constraint] struct {
    fieldName []T
}
```

常见场景是把某种容器写成泛型结构，例如栈、队列、集合、缓存等。此时类型参数决定容器里保存什么元素，而方法逻辑本身不需要为每种元素类型重复写一遍。

```go
type Stack[T any] struct {
    elements []T
}

func (receiverPointer *Stack[T]) Push(elementValue T) {
    receiverPointer.elements = append(receiverPointer.elements, elementValue)
}

func (receiverPointer *Stack[T]) Pop() (T, bool) {
    if len(receiverPointer.elements) == 0 {
        var zeroValue T
        return zeroValue, false
    }

    lastIndex := len(receiverPointer.elements) - 1
    resultValue := receiverPointer.elements[lastIndex]
    receiverPointer.elements = receiverPointer.elements[:lastIndex]
    return resultValue, true
}
```

映射类型在泛型中也很常见，尤其是键通常会约束为 `comparable`，因为底层 `map` 的键本身就必须可比较。

```go
type MapType[K comparable, V any] struct {
    data map[K]V
}
```

**示例**：泛型栈与泛型映射的典型形式。

```go
type Stack[T any] struct {
    elements []T
}

func (receiverPointer *Stack[T]) Push(elementValue T) {
    receiverPointer.elements = append(receiverPointer.elements, elementValue)
}

func (receiverPointer *Stack[T]) Pop() (T, bool) {
    if len(receiverPointer.elements) == 0 {
        var zeroValue T
        return zeroValue, false
    }

    lastIndex := len(receiverPointer.elements) - 1
    resultValue := receiverPointer.elements[lastIndex]
    receiverPointer.elements = receiverPointer.elements[:lastIndex]
    return resultValue, true
}

type SafeMap[K comparable, V any] struct {
    data map[K]V
}

func newSafeMap[K comparable, V any]() *SafeMap[K, V] {
    return &SafeMap[K, V]{
        data: make(map[K]V),
    }
}

func (receiverPointer *SafeMap[K, V]) Set(keyValue K, value V) {
    receiverPointer.data[keyValue] = value
}

func (receiverPointer *SafeMap[K, V]) Get(keyValue K) (V, bool) {
    resultValue, ok := receiverPointer.data[keyValue]
    return resultValue, ok
}

stackValue := Stack[ElementType]{}
stackValue.Push(elementValue1)
stackValue.Push(elementValue2)
popValue, popOK := stackValue.Pop()

mapValue := newSafeMap[KeyType, ValueType]()
mapValue.Set(keyValue, valueValue)
getValue, getOK := mapValue.Get(keyValue)

// 输出:
// popValue = 最近一次压入的元素
// popOK = 是否成功弹出
// getValue = 指定键对应的值
// getOK = 键是否存在
```



## 并发与网络编程

### 并发

#### 协程

协程（coroutine）是一种轻量级的线程，或者说是用户态的线程，不受操作系统直接调度，由 Go 语言自身的调度器进行运行时调度，因此上下文切换开销非常小，这也是为什么 Go 的并发性能很不错的原因之一。协程这一概念并非 Go 首次提出，Go 也不是第一个支持协程的语言，但 Go 是第一个能够将协程和并发支持的相当简洁和优雅的语言。

在 Go 中，创建一个协程十分的简单，仅需要一个 `go` 关键字，就能够快速开启一个协程，`go` 关键字后面必须是一个函数调用。

1. **创建协程**：`go` 后面必须跟函数调用表达式。

```go
go functionName(argumentList)
// functionName(argumentList): 函数调用表达式
// 返回结果: 启动一个新的 goroutine 执行该调用
```

2. **使用匿名函数创建协程**：适合在当前上下文中直接封装任务逻辑。

```go
go func(parameterList) {
    statement
}(argumentList)
// parameterList: 匿名函数参数列表
// statement: 协程中要执行的逻辑
// 返回结果: 启动一个执行匿名函数的 goroutine
```

**注意**：具有返回值的内置函数不允许跟随在 `go` 关键字后面，例如下面的错误示范：

```go
go make([]int, 10)
// 错误原因: go 后必须是函数调用，且返回值会被直接丢弃
// 编译错误: go discards result of make([]int, 10) (value of type []int)
```

下面这三种开启协程的方式都是可以的：

```go
func hello() {
    fmt.Println("hello world!")
}

go fmt.Println("hello world!")
go hello()
go func() {
    fmt.Println("hello world!")
}()
```

以上三种开启协程的方式都是可以的，但是其实这个例子执行过后在大部分情况下什么都不会输出，协程是并发执行的，系统创建协程需要时间，而在此之前，主协程早已运行结束，一旦主线程退出，其他子协程也就自然退出了。并且协程的执行顺序也是不确定的，无法预判的。

例如下面的例子：

```go
func main() {
    fmt.Println("start")

    for indexValue := 0; indexValue < 10; indexValue++ {
        go fmt.Println(indexValue)
    }

    fmt.Println("end")
}

// 输出可能为:
// start
// end
//
// 也可能为:
// start
// 0
// 1
// 5
// 3
// 4
// 6
// 7
// end
```

这是一个在循环体中开启协程的例子，永远也无法精准地预判到它到底会输出什么。可能子协程还没开始运行，主协程就已经结束了；也可能只有一部分子协程在主协程退出前成功运行。

最简单的做法就是让主协程等一会儿，需要使用到 `time` 包下的 `Sleep` 函数，可以使当前协程暂停一段时间。

1. **暂停当前协程**：`time.Sleep` 只会暂停当前 goroutine。

```go
time.Sleep(durationValue)
// durationValue: 暂停时间
// 返回结果: 当前 goroutine 暂停指定时长
```

例子如下：

```go
func main() {
    fmt.Println("start")

    for indexValue := 0; indexValue < 10; indexValue++ {
        go fmt.Println(indexValue)
    }

    time.Sleep(time.Millisecond)
    fmt.Println("end")
}

// 输出可能为:
// start
// 0
// 1
// 5
// 2
// 3
// 4
// 6
// 8
// 9
// 7
// end
```

再次执行可以看到所有的数字都完整输出了，没有遗漏，但是顺序还是乱的，因此让每次循环都稍微地等一下。例子如下：

```go
func main() {
    fmt.Println("start")

    for indexValue := 0; indexValue < 10; indexValue++ {
        go fmt.Println(indexValue)
        time.Sleep(time.Millisecond)
    }

    time.Sleep(time.Millisecond)
    fmt.Println("end")
}

// 输出可能为:
// start
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// 9
// end
```

现在的输出已经是正常的顺序了。

但是上面的例子中结果输出很完美，那么并发的问题解决了吗？不，一点也没有。对于并发的程序而言，不可控的因素非常多，执行的时机、先后顺序、执行过程的耗时等等，倘若循环中子协程的工作不只是一个简单的输出数字，而是一个非常巨大复杂的任务，耗时是不确定的，那么依旧会重现之前的问题。例如下方代码：

```go
func main() {
    fmt.Println("start")

    for indexValue := 0; indexValue < 10; indexValue++ {
        go hello(indexValue)
        time.Sleep(time.Millisecond)
    }

    time.Sleep(time.Millisecond)
    fmt.Println("end")
}

func hello(indexValue int) {
    time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
    fmt.Println(indexValue)
}

// 输出可能为:
// start
// 0
// 3
// 4
// end
```

这段代码的输出依旧是不确定的。因此 `time.Sleep` 并不是一种良好的解决办法，幸运的是 Go 提供了非常多的并发控制手段，常用的并发控制方法有三种：

- `channel`：管道
- `WaitGroup`：信号量
- `Context`：上下文

三种方法有着不同的适用情况，`WaitGroup` 可以动态地控制一组指定数量的协程，`Context` 更适合子孙协程嵌套层级更深的情况，管道更适合协程间通信。对于较为传统的锁控制，Go 也对此提供了支持：

- `Mutex`：互斥锁
- `RWMutex`：读写互斥锁

#### [管道](https://golang.halfiisland.com/essential/senior/110.concurrency.html#管道)

`channel`，译为管道，Go 对于管道的作用如下解释：

> Do not communicate by sharing memory; instead, share memory by communicating.

即通过消息来进行内存共享，`channel` 就是为此而生，它是一种在协程间通信的解决方案，同时也可以用于并发控制。先来认识下 `channel` 的基本语法。Go 中通过关键字 `chan` 来代表管道类型，同时也必须声明管道的存储类型，来指定其存储的数据是什么类型，下面的例子是一个普通管道的模样。

```go
var channelValue chan ElementType
// channelValue: 管道变量
// ElementType: 管道中存储的数据类型
// 零值: nil
```

这是一个管道的声明语句，此时管道还未初始化，其值为 `nil`，不可以直接使用。

##### 管道创建

在创建管道时，有且只有一种方法，那就是使用内置函数 `make`。对于管道而言，`make` 函数接收两个参数，第一个是管道的类型，第二个是可选参数，为管道的缓冲大小。

1. **创建无缓冲管道**：缓冲区大小为 0，发送与接收必须同步配对。

```go
make(chan ElementType)
// ElementType: 管道元素类型
// 返回结果: 无缓冲管道
```

2. **创建有缓冲管道**：额外指定缓冲区大小。

```go
make(chan ElementType, bufferSize)
// ElementType: 管道元素类型
// bufferSize: 缓冲区大小
// 返回结果: 有缓冲管道
```

3. **关闭管道**：使用完一个管道后要记得关闭，通常由发送方关闭。

```go
close(channelValue)
// channelValue: 待关闭管道
// 返回结果: 关闭该管道
```

一个关闭管道的例子如下：

```go
channelValue := make(chan ElementType)
// do something
close(channelValue)
// 说明:
// 1. 管道创建后才能使用
// 2. nil 管道不可直接读写
// 3. 有些时候使用 defer 关闭管道会更方便
```

##### 管道读写

对于一个管道而言，Go 使用了两种很形象的操作符来表示读写操作：

- `channelValue <- elementValue`：表示对一个管道写入数据
- `<-channelValue`：表示对一个管道读取数据

`<-` 很生动地表示了数据的流动方向。

1. **发送数据**：向管道写入一个值。

```go
channelValue <- elementValue
// channelValue: 目标管道
// elementValue: 要发送的数据
// 返回结果: 向管道中写入一个值
```

2. **接收数据**：从管道中读取一个值。

```go
resultValue := <-channelValue
// resultValue: 读取到的数据
// 返回结果: 从管道中取出一个值
```

3. **安全接收**：读取时可以取得第二个返回值，用于判断是否读取成功。

```go
resultValue, ok := <-channelValue
// resultValue: 读取到的数据；若失败则为零值
// ok: 是否成功读取到有效数据
```

4. **遍历读取**：通过 `for range` 可以不断从管道中读取数据。

```go
for elementValue := range channelValue {
    statement
}
// elementValue: 每次从管道读取到的值
// 说明:
// 1. 管道 range 只有一个返回值
// 2. 若管道未关闭，且后续没有新数据，会阻塞等待
```

管道中的数据流动方式与队列一样，即先进先出（FIFO）。协程对于管道的操作是同步的，在某一个时刻，只有一个协程能够对其写入数据，同时也只有一个协程能够读取管道中的数据。

**示例**：创建一个管道，发送数据、接收数据，使用双返回值读取，并通过 `for range` 消费直到关闭。

```go
channelValue := make(chan int, bufferSize)

channelValue <- elementValue1
channelValue <- elementValue2

resultValue1 := <-channelValue
resultValue2, ok := <-channelValue

go func() {
    for indexValue := 0; indexValue < countValue; indexValue++ {
        channelValue <- indexValue
    }
    close(channelValue)
}()

for elementValue := range channelValue {
    statement
}

// 输出示意:
// resultValue1 = elementValue1
// resultValue2 = elementValue2
// ok = true
// range 会持续读取，直到发送方关闭管道且数据读完后退出
```

##### 缓冲管道

缓冲管道可以继续分为无缓冲和有缓冲两种，它们的差别主要体现在发送和接收的阻塞条件上。

1. **无缓冲管道**：由于缓冲区容量为 0，不会临时存放任何数据，因此发送数据时必须立刻有其他协程接收，否则就会阻塞；接收也是同理。

```go
channelValue := make(chan ElementType)
// 返回结果: 无缓冲管道
```

这也解释了为什么下面看起来很正常的代码会发生死锁：

```go
channelValue := make(chan int)
channelValue <- elementValue
resultValue := <-channelValue

// 说明:
// 1. 这是同步地对无缓冲管道先写后读
// 2. 发送时没有其他协程接收，因此当前协程会阻塞
// 3. 结果是死锁
```

无缓冲管道不应该同步地使用，正确来说应该开启一个新的协程来发送数据：

```go
channelValue := make(chan int)

go func() {
    channelValue <- elementValue
}()

resultValue := <-channelValue

// 输出示意:
// resultValue = elementValue
```

2. **有缓冲管道**：当管道有了缓冲区，就像是一个阻塞队列一样。发送时会先将数据放入缓冲区中，只有当缓冲区满了才会阻塞；读取时会先从缓冲区中取数据，直到缓冲区为空才会阻塞。

```go
channelValue := make(chan ElementType, bufferSize)
// bufferSize: 缓冲区大小
// 返回结果: 有缓冲管道
```

因此，无缓冲管道中会造成死锁的同步读写例子，在这里可以顺利运行：

```go
channelValue := make(chan int, 1)

channelValue <- elementValue
resultValue := <-channelValue

// 输出示意:
// resultValue = elementValue
```

尽管可以顺利运行，但这种同步读写的方式依旧是非常危险的，一旦管道缓冲区空了或者满了，将会永远阻塞下去，因为没有其他协程来向管道中写入或读取数据。

3. **查看缓冲区状态**：通过内置函数 `len` 可以访问管道缓冲区中数据的个数，通过 `cap` 可以访问管道缓冲区的大小。

```go
len(channelValue)
cap(channelValue)
// len(channelValue): 当前缓冲区中的元素数量
// cap(channelValue): 管道缓冲区容量
```

4. **利用阻塞进行同步**：利用无缓冲管道“发送/接收必须配对”的特点，可以实现一个简单的同步等待。

```go
syncChannel := make(chan struct{})

go func() {
    statement
    syncChannel <- struct{}{}
}()

<-syncChannel
// 说明:
// 1. 主协程会阻塞等待子协程发出信号
// 2. struct{} 常用于这种“只传递事件，不传递数据”的场景
```

5. **利用有缓冲管道实现简单互斥**：缓冲区大小为 1 时，可以在某些场景下起到互斥控制作用。

```go
var lockChannel = make(chan struct{}, 1)

lockChannel <- struct{}{}
statement
<-lockChannel

// 说明:
// 1. 缓冲区大小为 1，表示同一时刻最多只能有一个占用者
// 2. 写入可视为加锁，读取可视为解锁
```

**阻塞场景**：

*  同步读写无缓冲管道
* 读取空缓冲区的管道
* 写入满缓冲区的管道
* 对 nil 管道读写

**panic 场景**：

* close(nilChannel)
* 向已关闭的管道写入数据
* 重复关闭同一个管道

**提示**：关于管道阻塞的条件需要好好掌握和熟悉，大多数情况下这些问题隐藏得十分隐蔽，并不会像例子中那样直观。关于管道关闭的时机，应该尽量在向管道发送数据的那一方关闭管道，而不要在接收方关闭管道，因为大多数情况下接收方只知道接收数据，并不知道该在什么时候关闭管道。

##### 单向 / 双向管道

双向管道指的是既可以写，也可以读，即可以在管道两边进行操作。单向管道指的是只读或只写的管道，即只能在管道的一边进行操作。手动创建一个只读或只写的管道本身意义不大，因为不能对管道完整读写就失去了其存在的作用。单向管道通常用来限制通道的行为，一般会出现在函数的形参和返回值中。

1. **双向管道**：既可读也可写。

```go
var channelValue chan ElementType
// chan ElementType: 双向管道
```

2. **只读管道**：箭头符号 `<-` 在前。

```go
var receiveOnlyValue <-chan ElementType
// <-chan ElementType: 只读管道
```

3. **只写管道**：箭头符号 `<-` 在后。

```go
var sendOnlyValue chan<- ElementType
// chan<- ElementType: 只写管道
```

4. **典型内置函数中的单向管道**：例如 `close` 和 `time.After`。

```go
func close(c chan<- Type)
// c: 只写通道参数
// 含义: 调用者只需要拥有发送/关闭一侧的权限
```

```go
func After(d Duration) <-chan Time
// d: 等待时间
// 返回结果: 一个只读通道
```

当尝试对只读的管道写入数据时，将无法通过编译；对只写管道读取数据也是同理。双向管道可以转换为单向管道，反过来则不可以。通常情况下，将双向管道传给某个协程或函数，并且不希望它读取或发送数据，就可以用单向管道来限制另一方的行为。

**示例**：使用双向管道配合只写参数和只读接收方。

```go
func write(sendOnlyValue chan<- int) {
    sendOnlyValue <- elementValue
}

channelValue := make(chan int, 1)
go write(channelValue)

resultValue := <-channelValue

// 输出示意:
// resultValue = elementValue
// 说明:
// 1. write 只能发送，不能读取
// 2. 双向管道可以传给只写参数
```

**提示**`chan` 是引用类型，即便 Go 的函数参数是值传递，但其引用依旧是同一个。

#### Select

`select` 在 Linux 系统中，是一种 IO 多路复用的解决方案。类似地，在 Go 中，`select` 是一种管道多路复用的控制结构。什么是多路复用，简单地用一句话概括：在某一时刻，同时监测多个元素是否可用，被监测的可以是网络请求、文件 IO 等；而在 Go 中，`select` 监测的元素就是管道，且只能是管道。`select` 的语法与 `switch` 语句类似。

1. **基本结构**：由多个 `case` 和一个可选的 `default` 组成，每个 `case` 只能操作一个管道，且只能进行一种操作，要么读要么写。

```go
select {
case resultValue1 := <-channelValue1:
    statement
case channelValue2 <- elementValue:
    statement
default:
    statement
}
// resultValue1 := <-channelValue1: 从管道读取
// channelValue2 <- elementValue: 向管道写入
// default: 所有 case 当前都不可用时执行，可省略
```

2. **执行规则**：当有多个 `case` 可用时，`select` 会伪随机地选择一个分支执行；如果所有 `case` 都不可用，就会执行 `default` 分支；若没有 `default`，则会阻塞等待直到至少有一个 `case` 可用。

```go
select {
case statement1:
    statement
case statement2:
    statement
default:
    statement
}
// 说明:
// 1. 多个可用 case 同时存在时，select 不保证固定顺序
// 2. 无 default 时，select 会阻塞
// 3. 有 default 时，可以形成非阻塞收发
```

先看一个最基本的 `select` 结构：

```go
channelValueA := make(chan int)
channelValueB := make(chan int)
channelValueC := make(chan int)

defer func() {
    close(channelValueA)
    close(channelValueB)
    close(channelValueC)
}()

select {
case resultValue, ok := <-channelValueA:
    fmt.Println(resultValue, ok)
case resultValue, ok := <-channelValueB:
    fmt.Println(resultValue, ok)
case resultValue, ok := <-channelValueC:
    fmt.Println(resultValue, ok)
default:
    fmt.Println("所有管道都不可用")
}

// 输出:
// 所有管道都不可用
```

由于上例中没有对任何管道写入数据，自然所有 `case` 都不可用，所以最终输出为 `default` 分支的执行结果。稍微修改后如下：

```go
channelValueA := make(chan int)
channelValueB := make(chan int)
channelValueC := make(chan int)

defer func() {
    close(channelValueA)
    close(channelValueB)
    close(channelValueC)
}()

go func() {
    channelValueA <- 1
}()

select {
case resultValue, ok := <-channelValueA:
    fmt.Println(resultValue, ok)
case resultValue, ok := <-channelValueB:
    fmt.Println(resultValue, ok)
case resultValue, ok := <-channelValueC:
    fmt.Println(resultValue, ok)
}

// 输出:
// 1 true
```

上例开启了一个新的协程来向管道 A 写入数据，`select` 由于没有默认分支，所以会一直阻塞等待直到有 `case` 可用。当管道 A 可用时，执行完对应分支后主协程就直接退出了。

3. **持续监测**：如果想一直监测多个管道，通常会把 `select` 放进 `for` 循环中。

```go
for {
    select {
    case resultValue := <-channelValue1:
        statement
    case resultValue := <-channelValue2:
        statement
    case resultValue := <-channelValue3:
        statement
    }
}
// 说明:
// 1. for + select 常用于持续监听多个管道
// 2. 若没有退出条件，可能导致永久阻塞
```

例如：

```go
channelValueA := make(chan int)
channelValueB := make(chan int)
channelValueC := make(chan int)

defer func() {
    close(channelValueA)
    close(channelValueB)
    close(channelValueC)
}()

go send(channelValueA)
go send(channelValueB)
go send(channelValueC)

for {
    select {
    case resultValue, ok := <-channelValueA:
        fmt.Println("A", resultValue, ok)
    case resultValue, ok := <-channelValueB:
        fmt.Println("B", resultValue, ok)
    case resultValue, ok := <-channelValueC:
        fmt.Println("C", resultValue, ok)
    }
}
```

这样确实三个管道都能用上了，但是死循环配合 `select` 会导致主协程永久阻塞，所以通常会加上额外的退出机制，例如超时、取消信号或完成信号。

4. **超时控制**：`select` 常与 `time.After` 一起使用来实现超时机制。

```go
time.After(durationValue)
// durationValue: 超时时长
// 返回结果: 一个只读管道，到期后会收到一个时间值
```

把它放进 `select` 中，就可以在“等到结果”和“等到超时”之间二选一：

```go
channelValue := make(chan int)
defer close(channelValue)

go func() {
    time.Sleep(time.Second * 2)
    channelValue <- 1
}()

select {
case resultValue := <-channelValue:
    fmt.Println(resultValue)
case <-time.After(time.Second):
    fmt.Println("超时")
}

// 输出:
// 超时
```

如果把 `for`、`select` 和 `time.After` 结合起来，就能实现“持续监听一段时间，超时后退出”的模式。例如：

```go
channelValueA := make(chan int)
channelValueB := make(chan int)
channelValueC := make(chan int)
doneChannel := make(chan struct{})

defer func() {
    close(channelValueA)
    close(channelValueB)
    close(channelValueC)
    close(doneChannel)
}()

go send(channelValueA)
go send(channelValueB)
go send(channelValueC)

go func() {
Loop:
    for {
        select {
        case resultValue, ok := <-channelValueA:
            fmt.Println("A", resultValue, ok)
        case resultValue, ok := <-channelValueB:
            fmt.Println("B", resultValue, ok)
        case resultValue, ok := <-channelValueC:
            fmt.Println("C", resultValue, ok)
        case <-time.After(time.Second):
            break Loop
        }
    }

    doneChannel <- struct{}{}
}()

<-doneChannel

// 输出示意:
// C 0 true
// A 0 true
// B 0 true
// ...
// 超时后退出循环
```

5. **永久阻塞**：当 `select` 语句中什么都没有时，就会永久阻塞。

```go
select {}
// 返回结果: 永久阻塞当前 goroutine
```

例如：

```go
fmt.Println("start")
select {}
fmt.Println("end")

// 输出:
// start
// end 永远不会输出
```

这种情况一般是有特殊用途，否则很容易形成死锁。

6. **nil 管道行为**：在 `select` 的 `case` 中对值为 `nil` 的管道进行操作时，并不会导致整个 `select` 立即阻塞，而是该 `case` 会被忽略，永远不会被执行。

```go
var nilChannel chan int

select {
case <-nilChannel:
    statement
case nilChannel <- elementValue:
    statement
case <-time.After(time.Second):
    statement
}
// 说明:
// nil 管道相关 case 永远不可用，因此会被忽略
```

例如：

```go
var nilChannel chan int

select {
case <-nilChannel:
    fmt.Println("read")
case nilChannel <- 1:
    fmt.Println("write")
case <-time.After(time.Second):
    fmt.Println("timeout")
}

// 输出:
// timeout
```

7. **非阻塞收发**：通过 `default` 分支配合管道，可以实现非阻塞的发送与接收。

```go
select {
case channelValue <- elementValue:
    statement
default:
    statement
}
// 说明:
// 若发送不能立即完成，则走 default
```

```go
select {
case resultValue, ok := <-channelValue:
    statement
default:
    statement
}
// 说明:
// 若读取不能立即完成，则走 default
```

例如：

```go
func trySend(channelValue chan int, elementValue int) bool {
    select {
    case channelValue <- elementValue:
        return true
    default:
        return false
    }
}

func tryRecv(channelValue chan int) (int, bool) {
    select {
    case elementValue, ok := <-channelValue:
        return elementValue, ok
    default:
        return 0, false
    }
}
```

同理，也可以用同样的方式非阻塞地判断一个 `context` 是否已经结束：

```go
func isDone(contextValue context.Context) bool {
    select {
    case <-contextValue.Done():
        return true
    default:
        return false
    }
}
```

提示

`select` 本身不是循环，它一次只会选中一个可用分支并执行。若想持续监听多个管道，通常需要与 `for` 一起使用。`select` 也不会保证多个可用分支之间的固定顺序，因此它适合做并发控制，而不适合用来表达严格顺序。

#### WaitGroup

`sync.WaitGroup` 是 `sync` 包下提供的一个结构体，`WaitGroup` 即等待执行，使用它可以很轻易地实现等待一组协程的效果。它的核心用途是：在主协程中等待多个子协程执行完成后再继续往下执行。该结构体只对外暴露三个方法。

1. **Add**：用于指明还要等待多少个协程或任务。

```go
func (waitGroupPointer *WaitGroup) Add(deltaValue int)
// waitGroupPointer: WaitGroup 指针
// deltaValue: 计数变化量
// 返回结果: 调整等待计数
```

2. **Done**：表示当前协程已经执行完毕，本质上等价于 `Add(-1)`。

```go
func (waitGroupPointer *WaitGroup) Done()
// waitGroupPointer: WaitGroup 指针
// 返回结果: 当前任务完成，计数减 1
```

3. **Wait**：等待全部子协程结束，否则就阻塞。

```go
func (waitGroupPointer *WaitGroup) Wait()
// waitGroupPointer: WaitGroup 指针
// 返回结果: 阻塞直到计数归零
```

`WaitGroup` 使用起来十分简单，属于开箱即用。其内部的实现可以理解为“计数器 + 唤醒机制”：程序开始时调用 `Add` 初始化计数，每当一个协程执行完毕时调用 `Done`，计数就减 1，直到减为 0，而在此期间，主协程调用 `Wait` 会一直阻塞直到全部计数减为 0，然后才会被唤醒。

**示例**：等待一个子协程执行完毕。

```go
var waitGroupValue sync.WaitGroup

waitGroupValue.Add(1)

go func() {
    fmt.Println(1)
    waitGroupValue.Done()
}()

waitGroupValue.Wait()
fmt.Println(2)

// 输出:
// 1
// 2
```

这段代码永远都是先输出 `1` 再输出 `2`，主协程会等待子协程执行完毕后再退出。

针对协程介绍中最开始的例子，可以使用 `sync.WaitGroup` 替代原先的 `time.Sleep`。这样做的重点不是“让主协程等一会儿”，而是“明确等待这些子协程执行结束”。

如果只是想等待一组协程全部执行完成，通常可以直接给总协程数计数，然后每个子协程结束时各自 `Done` 一次。

```go
var waitGroupValue sync.WaitGroup

waitGroupValue.Add(taskCountValue)

for indexValue := 0; indexValue < taskCountValue; indexValue++ {
    currentValue := indexValue

    go func() {
        defer waitGroupValue.Done()
        fmt.Println(currentValue)
    }()
}

waitGroupValue.Wait()
fmt.Println("end")

// 输出示意:
// 会等待全部 goroutine 结束后再输出 end
// 若任务内部执行顺序不受控制，数字顺序依旧可能不固定
```

如果希望像原例那样在循环中把顺序也控制住，可以在每轮中额外等待当前那一个协程先执行完毕，再进入下一轮。

**示例**：替代 `time.Sleep`，并让输出顺序保持可控。

```go
var totalWaitGroup sync.WaitGroup
var currentWaitGroup sync.WaitGroup

totalWaitGroup.Add(10)

fmt.Println("start")

for indexValue := 0; indexValue < 10; indexValue++ {
    currentValue := indexValue

    currentWaitGroup.Add(1)

    go func() {
        fmt.Println(currentValue)
        currentWaitGroup.Done()
        totalWaitGroup.Done()
    }()

    currentWaitGroup.Wait()
}

totalWaitGroup.Wait()
fmt.Println("end")

// 输出:
// start
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// 9
// end
```

这里使用了 `sync.WaitGroup` 替代了原先的 `time.Sleep`，协程并发执行的顺序更加可控，不管执行多少次，输出都可以保持一致。

`WaitGroup` 通常适用于可动态调整协程数量的时候，例如事先知晓协程的数量，又或者在运行过程中需要动态调整。它最常见的场景就是：主协程等待一组子协程执行完毕。

需要特别注意的是：`WaitGroup` 的值不应该被复制，复制后的值也不应该继续使用。尤其是将其作为函数参数传递时，应该传递指针而不是值。倘若使用复制的值，计数完全无法作用到真正的 `WaitGroup` 上，这可能会导致主协程一直阻塞等待，程序将无法正常运行。

1. **错误传值**：按值传递会复制 `WaitGroup`，导致 `Done` 不作用于原对象。

```go
func functionName(waitGroupValue sync.WaitGroup) {
    statement
}
// 错误原因:
// waitGroupValue 是复制品
// 在复制品上 Done 不会影响原来的 WaitGroup
```

2. **正确传指针**：应当传递 `*sync.WaitGroup`。

```go
func functionName(waitGroupPointer *sync.WaitGroup) {
    statement
}
// 正确原因:
// waitGroupPointer 指向原 WaitGroup
// Done 会作用到真正的计数对象
```

**示例**：按值传递导致死锁，按指针传递才正确。

```go
func helloWrong(waitGroupValue sync.WaitGroup) {
    fmt.Println("hello")
    waitGroupValue.Done()
    // 输出:
    // hello
    // 但不会真正减少外部 WaitGroup 的计数
}

func helloRight(waitGroupPointer *sync.WaitGroup) {
    fmt.Println("hello")
    waitGroupPointer.Done()
    // 输出:
    // hello
    // 会正确减少外部 WaitGroup 的计数
}

var waitGroupValue sync.WaitGroup
waitGroupValue.Add(1)

go helloRight(&waitGroupValue)
// 如果改为 go helloWrong(waitGroupValue)
// 则主协程会一直阻塞等待，最终形成死锁

waitGroupValue.Wait()
fmt.Println("end")

// 正确输出:
// hello
// end
//
// 错误写法可能导致:
// hello
// fatal error: all goroutines are asleep - deadlock!
```

**提示**当计数变为负数，或者计数数量大于实际能够完成 `Done` 的协程数量时，将会引发 `panic`。因此 `Add`、`Done`、`Wait` 三者之间的对应关系一定要保持准确。

#### Context

`Context` 来自标准库 `context` 包，是 Go 提供的一种并发控制与流程管理机制。它主要用于在多个协程之间传递取消信号、超时截止时间以及请求范围内的数据，尤其适合管理父子协程、孙协程这类层级更深的并发流程。相比单纯使用管道或 `WaitGroup`，`Context` 更强调“由上向下”地统一控制一组相关任务的生命周期。

从使用方式上看，`Context` 一般不是拿来直接“同步计数”的，而是更常用于**通知、取消、超时控制、请求链路传值**。在实际代码里，通常会把 `ctx.Done()` 返回的只读管道放进 `select` 中，通过阻塞等待它被关闭，从而得知“当前任务该结束了”。因此，`Context` 可以理解为一种面向并发流程的上下文机制：它不负责具体业务逻辑，但负责告诉各层协程“什么时候该停、为什么停、还携带了哪些上下文数据”。

`Context` 译为上下文，是 Go 提供的一种并发控制的解决方案。相比于管道和 `WaitGroup`，它可以更好地控制子孙协程以及层级更深的协程。`Context` 本身是一个接口，只要实现了该接口都可以称之为上下文，例如著名 Web 框架 `Gin` 中的 `gin.Context`。`context` 标准库也提供了几个实现，分别是：

- `emptyCtx`
- `cancelCtx`
- `timerCtx`
- `valueCtx`

##### Context 接口

先来看 `Context` 接口的定义，再去了解它的具体实现。

```go
type Context interface {
    Deadline() (deadline time.Time, ok bool)
    Done() <-chan struct{}
    Err() error
    Value(key any) any
}
```

1. **Deadline**：返回截止时间以及是否设置了截止时间。

```go
Deadline() (deadline time.Time, ok bool)
// deadline: 上下文取消的截止时间
// ok: 是否设置了 deadline
// 返回结果: 若未设置截止时间，则 ok 为 false
```

2. **Done**：返回一个只读管道，用于通知当前上下文应当结束。

```go
Done() <-chan struct{}
// 返回结果: 只读通知管道
// 说明:
// 1. 管道关闭表示当前上下文应当结束
// 2. 不传递实际数据，只起通知作用
// 3. 对于不支持取消的上下文，可能返回 nil
```

3. **Err**：返回上下文结束的原因。

```go
Err() error
// 返回结果:
// 1. Done 未关闭时返回 nil
// 2. 上下文结束后返回对应错误
```

4. **Value**：根据键获取上下文中携带的值。

```go
Value(key any) any
// key: 查找键
// 返回结果:
// 1. 找到时返回对应值
// 2. 不存在或不支持时返回 nil
```

![](D:\Learn\Learn\Note\Go\assets\context_1.png)

##### emptyCtx

顾名思义，`emptyCtx` 就是空的上下文。`context` 包下所有的具体实现都不对外暴露，但是提供了对应函数来创建上下文。`emptyCtx` 可以通过 `context.Background` 和 `context.TODO` 创建。

1. **Background**：通常作为最顶层的根上下文。

```go
func Background() Context
// 返回结果: 根上下文
```

2. **TODO**：用于暂时不知道该传什么上下文时占位使用。

```go
func TODO() Context
// 返回结果: 占位上下文
```

可以看到它们本质上都是返回 `emptyCtx`。`emptyCtx` 没法被取消，没有 `deadline`，也不能取值，实现的方法基本都是返回零值。

```go
type emptyCtx int

func (*emptyCtx) Deadline() (deadline time.Time, ok bool) {
    return
}

func (*emptyCtx) Done() <-chan struct{} {
    return nil
}

func (*emptyCtx) Err() error {
    return nil
}

func (*emptyCtx) Value(key any) any {
    return nil
}
```

`emptyCtx` 通常是用来当作最顶层的上下文，在创建其他三种上下文时作为父上下文传入。

##### valueCtx

`valueCtx` 的作用是携带键值对，常用于在多级协程中向下传递一些请求范围内的数据。它的实现比较简单，内部只包含一对键值对，以及一个内嵌的父上下文字段。

1. **创建带值上下文**：通过 `WithValue` 创建。

```go
func WithValue(parent Context, key any, value any) Context
// parent: 父上下文
// key: 键
// value: 值
// 返回结果: 新的 valueCtx
```

2. **读取上下文值**：通过 `Value` 逐层向上查找。

```go
ctx.Value(key)
// key: 查找键
// 返回结果:
// 1. 当前上下文命中则直接返回
// 2. 否则继续向父上下文查找
```

`valueCtx` 多用于在多级协程中传递一些数据，无法被取消，因此 `ctx.Done()` 往往不会触发，若父级也是不可取消上下文，则它返回的通知通道也没有实际取消效果。

**示例**：在协程中读取上下文值。

```go
ctx := context.WithValue(context.Background(), keyValue, valueValue)

go func(contextValue context.Context) {
    for {
        select {
        case <-contextValue.Done():
            return
        default:
            fmt.Println(contextValue.Value(keyValue))
        }
        time.Sleep(time.Millisecond * 100)
    }
}(ctx)

// 输出示意:
// valueValue
// valueValue
// valueValue
// ...
// 说明:
// 1. valueCtx 主要用于传值
// 2. 若父级不可取消，则 Done 分支通常不会执行
```

##### cancelCtx

`cancelCtx` 是可取消的上下文。它可以在外部主动调用取消函数，从而通知当前上下文以及它的子上下文全部结束。相比 `valueCtx`，它更适合做取消传播。

1. **创建可取消上下文**：通过 `WithCancel` 创建。

```go
func WithCancel(parent Context) (ctx Context, cancel CancelFunc)
// parent: 父上下文
// ctx: 新的 cancelCtx
// cancel: 取消函数
// 返回结果: 一个可取消上下文和对应取消函数
```

`cancelCtx` 的核心特点是：一旦调用 `cancel()`，当前上下文的 `Done` 管道会被关闭，它的任何子级上下文也会随之取消。

**示例**：手动取消一个上下文。

```go
var waitGroupValue sync.WaitGroup

parentContext := context.Background()
cancelContext, cancelFunc := context.WithCancel(parentContext)

waitGroupValue.Add(1)

go func(contextValue context.Context) {
    defer waitGroupValue.Done()

    for {
        select {
        case <-contextValue.Done():
            fmt.Println(contextValue.Err())
            return
        default:
            fmt.Println("等待取消中...")
        }
        time.Sleep(time.Millisecond * 200)
    }
}(cancelContext)

time.Sleep(time.Second)
cancelFunc()
waitGroupValue.Wait()

// 输出示意:
// 等待取消中...
// 等待取消中...
// ...
// context canceled
```

再来一个层级嵌套深一点的示例。父上下文一旦取消，子上下文也会随之取消，因此它很适合控制一整棵协程树。

```go
func httpHandler(contextValue context.Context) {
    authContext, cancelAuth := context.WithCancel(contextValue)
    mailContext, cancelMail := context.WithCancel(contextValue)

    defer cancelAuth()
    defer cancelMail()

    go authService(authContext)
    go mailService(mailContext)

    for {
        select {
        case <-contextValue.Done():
            return
        default:
            statement
        }
    }
}
```

例子中创建了多个 `cancelCtx`。尽管父级 `cancelCtx` 在取消的同时会取消它的子上下文，但是保险起见，如果创建了一个 `cancelCtx`，在相应流程结束后最好仍然调用对应的 `cancel` 函数。

##### timerCtx

`timerCtx` 在 `cancelCtx` 的基础之上增加了超时机制。`context` 包下提供了两种创建函数，分别是 `WithDeadline` 和 `WithTimeout`，两者功能类似：前者指定一个具体截止时间，后者指定一个持续时长。

1. **指定截止时间**：通过 `WithDeadline` 创建。

```go
func WithDeadline(parent Context, deadline time.Time) (Context, CancelFunc)
// parent: 父上下文
// deadline: 具体截止时间
// 返回结果: 带 deadline 的上下文和取消函数
```

2. **指定超时时长**：通过 `WithTimeout` 创建。

```go
func WithTimeout(parent Context, timeout time.Duration) (Context, CancelFunc)
// parent: 父上下文
// timeout: 超时时长
// 返回结果: 带 timeout 的上下文和取消函数
```

`timerCtx` 会在时间到期后自动取消当前上下文，取消流程除了要额外处理内部定时器之外，整体逻辑与 `cancelCtx` 相近。

**示例**：使用 `WithDeadline` 创建超时上下文。

```go
var waitGroupValue sync.WaitGroup

deadlineContext, cancelFunc := context.WithDeadline(
    context.Background(),
    time.Now().Add(time.Second),
)
defer cancelFunc()

waitGroupValue.Add(1)

go func(contextValue context.Context) {
    defer waitGroupValue.Done()

    for {
        select {
        case <-contextValue.Done():
            fmt.Println("上下文取消", contextValue.Err())
            return
        default:
            fmt.Println("等待取消中...")
        }
        time.Sleep(time.Millisecond * 200)
    }
}(deadlineContext)

waitGroupValue.Wait()

// 输出示意:
// 等待取消中...
// 等待取消中...
// ...
// 上下文取消 context deadline exceeded
```

`WithTimeout` 与 `WithDeadline` 用法基本一致，它的实现也只是稍微封装了一下并调用 `WithDeadline`。

```go
func WithTimeout(parent Context, timeout time.Duration) (Context, CancelFunc) {
    return WithDeadline(parent, time.Now().Add(timeout))
}
```

提示

尽管上下文到期会自动取消，但是为了保险起见，在相关流程结束后，最好手动调用取消函数。就跟内存分配后不回收会造成内存泄漏一样，上下文也是一种资源，如果创建了但从来不取消，一样会造成上下文泄露，所以最好避免此种情况的发生。

#### 锁

Go 中 `sync` 包下的 `Mutex` 与 `RWMutex` 提供了互斥锁与读写锁两种实现，且提供了非常简单易用的 API。加锁只需要 `Lock()`，解锁也只需要 `Unlock()`。需要注意的是，Go 所提供的锁都是非递归锁，也就是不可重入锁，所以重复加锁或重复解锁都会导致 `fatal`。锁的意义在于保护不变量，加锁是希望数据不会被其他协程修改，如下：

```go
lockValue.Lock()
// 在这个过程中，数据不会被其他协程修改
lockValue.Unlock()
```

倘若是递归锁的话，就可能会发生如下情况：

```go
func doSomething() {
    lockValue.Lock()
    doOther()
    lockValue.Unlock()
}

func doOther() {
    lockValue.Lock()
    statement
    lockValue.Unlock()
}
```

`DoSomthing` 函数显然不知道 `DoOther` 函数可能会对数据做点什么，从而修改了数据，比如再开几个子协程破坏了不变量。这在 Go 中是行不通的，一旦加锁以后就必须保证不变量的不变性，此时重复加锁解锁都会导致死锁。所以在编写代码时应该避免上述情况，必要时在加锁的同时立即使用 `defer` 语句解锁。

##### 互斥锁

`sync.Mutex` 是 Go 提供的互斥锁实现，其实现了 `sync.Locker` 接口。

1. **通用加锁接口**：`Locker` 只规定了加锁与解锁两个操作。

```go
type Locker interface {
    Lock()
    Unlock()
}
```

2. **互斥锁加锁**：同一时刻只允许一个协程进入临界区。

```go
mutexValue.Lock()
// mutexValue: 互斥锁
// 返回结果: 获取互斥锁；若已被占用则阻塞等待
```

3. **互斥锁解锁**：释放临界区访问权限。

```go
mutexValue.Unlock()
// mutexValue: 互斥锁
// 返回结果: 释放互斥锁
```

使用互斥锁可以非常完美地解决上述问题，例子如下：

```go
var waitGroupValue sync.WaitGroup
var sharedValue = 0
var mutexValue sync.Mutex

func main() {
    waitGroupValue.Add(10)

    for indexValue := 0; indexValue < 10; indexValue++ {
        go func(dataPointer *int) {
            mutexValue.Lock()
            defer mutexValue.Unlock()

            time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))

            tempValue := *dataPointer

            time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))

            answerValue := 1
            *dataPointer = tempValue + answerValue

            fmt.Println(*dataPointer)
            waitGroupValue.Done()
        }(&sharedValue)
    }

    waitGroupValue.Wait()
    fmt.Println("最终结果", sharedValue)
}

// 输出示意:
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
最终结果 10
```

每一个协程在访问数据前，都先上锁，更新完成后再解锁，其他协程想要访问就必须要先获得锁，否则就阻塞等待。如此一来，就不存在上述问题了。

##### 读写锁

互斥锁适合读操作与写操作频率都差不多的情况。对于一些读多写少的数据，如果使用互斥锁，会造成大量不必要的协程竞争锁，这会消耗很多系统资源，这时候就需要用到读写锁，即读写互斥锁。对于一个协程而言：

- 如果获得了读锁，其他协程进行写操作时会阻塞，其他协程进行读操作时不会阻塞
- 如果获得了写锁，其他协程进行写操作时会阻塞，其他协程进行读操作时也会阻塞

Go 中读写互斥锁的实现是 `sync.RWMutex`，它也同样实现了 `Locker` 接口，但它提供了更多可用的方法，如下：

1. **加读锁**：允许多个读协程同时进入。

```go
func (rw *RWMutex) RLock()
// 返回结果: 获取读锁
```

2. **尝试加读锁**：非阻塞地尝试获取读锁。

```go
func (rw *RWMutex) TryRLock() bool
// 返回结果: 成功获取读锁返回 true，否则返回 false
```

3. **解读锁**：释放读锁。

```go
func (rw *RWMutex) RUnlock()
// 返回结果: 释放读锁
```

4. **加写锁**：独占锁，阻塞其他读写操作。

```go
func (rw *RWMutex) Lock()
// 返回结果: 获取写锁
```

5. **尝试加写锁**：非阻塞地尝试获取写锁。

```go
func (rw *RWMutex) TryLock() bool
// 返回结果: 成功获取写锁返回 true，否则返回 false
```

6. **解写锁**：释放写锁。

```go
func (rw *RWMutex) Unlock()
// 返回结果: 释放写锁
```

其中 `TryRLock` 与 `TryLock` 两个尝试加锁的操作是非阻塞式的，成功加锁会返回 `true`，无法获得锁时并不会阻塞而是返回 `false`。读写互斥锁内部实现依旧是互斥锁，并不是说分读锁和写锁就有两个锁，从始至终都只有一个锁。

下面来看一个读写互斥锁的使用案例：

```go
var waitGroupValue sync.WaitGroup
var sharedValue = 0
var readWriteMutex sync.RWMutex

func main() {
    waitGroupValue.Add(12)

    go func() {
        for indexValue := 0; indexValue < 3; indexValue++ {
            go writeValue(&sharedValue)
        }
        waitGroupValue.Done()
    }()

    go func() {
        for indexValue := 0; indexValue < 7; indexValue++ {
            go readValue(&sharedValue)
        }
        waitGroupValue.Done()
    }()

    waitGroupValue.Wait()
    fmt.Println("最终结果", sharedValue)
}

func readValue(dataPointer *int) {
    time.Sleep(time.Millisecond * time.Duration(rand.Intn(500)))

    readWriteMutex.RLock()
    fmt.Println("拿到读锁")

    time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
    fmt.Println("释放读锁", *dataPointer)

    readWriteMutex.RUnlock()
    waitGroupValue.Done()
}

func writeValue(dataPointer *int) {
    time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))

    readWriteMutex.Lock()
    fmt.Println("拿到写锁")

    tempValue := *dataPointer
    time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
    *dataPointer = tempValue + 1

    fmt.Println("释放写锁", *dataPointer)
    readWriteMutex.Unlock()
    waitGroupValue.Done()
}

// 输出示意:
拿到读锁
拿到读锁
拿到读锁
拿到读锁
释放读锁 0
释放读锁 0
释放读锁 0
释放读锁 0
拿到写锁
释放写锁 1
拿到读锁
拿到读锁
拿到读锁
释放读锁 1
释放读锁 1
释放读锁 1
拿到写锁
释放写锁 2
拿到写锁
释放写锁 3
最终结果 3
```

该例开启了 3 个写协程，7 个读协程。在读数据的时候都会先获得读锁，读协程之间可以同时获得读锁，但是会阻塞写协程；获得写锁的时候，则会同时阻塞读协程和写协程，直到释放写锁。如此一来实现了读协程与写协程互斥，保证了数据的正确性。

**注意：对于锁而言，不应该将其作为值传递和存储，应该永远使用指针。**

##### 条件变量

条件变量与互斥锁一同出现和使用，所以有些人可能会误称为条件锁，但它并不是锁，而是一种通信机制。Go 中的 `sync.Cond` 对此提供了实现，而创建条件变量的函数签名如下：

1. **创建条件变量**：必须基于一个 `Locker`。

```go
func NewCond(lockerValue Locker) *Cond
// lockerValue: 条件变量依赖的锁
// 返回结果: 条件变量指针
```

`sync.Cond` 提供了如下的方法以供使用：

2. **Wait**：阻塞等待条件生效，直到被唤醒。

```go
func (condPointer *Cond) Wait()
// 返回结果: 当前协程阻塞等待条件
```

3. **Signal**：唤醒一个因条件阻塞的协程。

```go
func (condPointer *Cond) Signal()
// 返回结果: 唤醒一个等待中的协程
```

4. **Broadcast**：唤醒所有因条件阻塞的协程。

```go
func (condPointer *Cond) Broadcast()
// 返回结果: 唤醒全部等待中的协程
```

条件变量使用起来非常简单，将上面的读写互斥锁例子稍微修改即可：

```go
var waitGroupValue sync.WaitGroup
var sharedValue = 0
var readWriteMutex sync.RWMutex
var condValue = sync.NewCond(readWriteMutex.RLocker())

func main() {
    waitGroupValue.Add(12)

    go func() {
        for indexValue := 0; indexValue < 3; indexValue++ {
            go writeValue(&sharedValue)
        }
        waitGroupValue.Done()
    }()

    go func() {
        for indexValue := 0; indexValue < 7; indexValue++ {
            go readValue(&sharedValue)
        }
        waitGroupValue.Done()
    }()

    waitGroupValue.Wait()
    fmt.Println("最终结果", sharedValue)
}

func readValue(dataPointer *int) {
    time.Sleep(time.Millisecond * time.Duration(rand.Intn(500)))

    readWriteMutex.RLock()
    fmt.Println("拿到读锁")

    for *dataPointer < 3 {
        condValue.Wait()
    }

    time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
    fmt.Println("释放读锁", *dataPointer)

    readWriteMutex.RUnlock()
    waitGroupValue.Done()
}

func writeValue(dataPointer *int) {
    time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))

    readWriteMutex.Lock()
    fmt.Println("拿到写锁")

    tempValue := *dataPointer
    time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
    *dataPointer = tempValue + 1

    fmt.Println("释放写锁", *dataPointer)
    readWriteMutex.Unlock()

    condValue.Broadcast()
    waitGroupValue.Done()
}

// 输出示意:
拿到读锁
拿到读锁
拿到读锁
拿到读锁
拿到写锁
释放写锁 1
拿到读锁
拿到写锁
释放写锁 2
拿到读锁
拿到读锁
拿到写锁
释放写锁 3
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
最终结果 3
```

在创建条件变量时，因为这里条件变量作用的是读协程，所以将读锁作为 `Locker` 传入。如果直接传入读写互斥锁，会导致写协程重复解锁的问题。这里传入的是 `sync.RLocker`，通过 `RWMutex.RLocker` 方法获得。

```go
func (rw *RWMutex) RLocker() Locker {
    return (*rlocker)(rw)
}

type rlocker RWMutex

func (receiverPointer *rlocker) Lock() {
    (*RWMutex)(receiverPointer).RLock()
}

func (receiverPointer *rlocker) Unlock() {
    (*RWMutex)(receiverPointer).RUnlock()
}
```

可以看到 `rlocker` 也只是把读写互斥锁的读锁操作封装了一下，实际上是同一个引用，依旧是同一个锁。读协程读取数据时，如果小于 3 就会一直阻塞等待，直到数据大于等于 3，而写协程在更新数据后都会尝试唤醒所有因条件变量而阻塞的协程，所以最后所有读协程都恢复了运行。

**提示：**对于条件变量，应该使用 `for` 而不是 `if`，应该使用循环来判断条件是否满足，因为协程被唤醒时并不能保证当前条件就已经满足了。

```go
for !conditionValue {
    condPointer.Wait()
}
```

#### Once

`Once` 来自标准库 `sync` 包，用于保证某段初始化逻辑在并发条件下只执行一次。

当在使用一些数据结构时，如果这些数据结构太过庞大，可以考虑采用懒加载的方式，即真正要用到它的时候才会初始化该数据结构。顾名思义，`Once` 译为一次，`sync.Once` 保证了在并发条件下指定操作只会执行一次。它的使用非常简单，只对外暴露了一个 `Do` 方法。

1. **Do**：保证传入的初始化逻辑在并发条件下只执行一次。

```go
func (oncePointer *Once) Do(functionValue func())
// oncePointer: Once 指针
// functionValue: 只允许执行一次的函数
// 返回结果: 保证 functionValue 只执行一次
```

在使用时，只需要将初始化操作传入 `Do` 方法即可，如下：

```go
var waitGroupValue sync.WaitGroup

type MySlice struct {
    sliceValue []int
    onceValue  sync.Once
}

func (receiverPointer *MySlice) Get(indexValue int) (int, bool) {
    if receiverPointer.sliceValue == nil {
        return 0, false
    }
    return receiverPointer.sliceValue[indexValue], true
}

func (receiverPointer *MySlice) Add(elementValue int) {
    receiverPointer.onceValue.Do(func() {
        fmt.Println("初始化")
        if receiverPointer.sliceValue == nil {
            receiverPointer.sliceValue = make([]int, 0, 10)
        }
    })

    receiverPointer.sliceValue = append(receiverPointer.sliceValue, elementValue)
}

func (receiverPointer *MySlice) Len() int {
    return len(receiverPointer.sliceValue)
}

func main() {
    var sliceValue MySlice

    waitGroupValue.Add(4)
    for indexValue := 0; indexValue < 4; indexValue++ {
        go func() {
            sliceValue.Add(1)
            waitGroupValue.Done()
        }()
    }

    waitGroupValue.Wait()
    fmt.Println(sliceValue.Len())
}

// 输出:
// 初始化
// 4
```

从输出结果中可以看到，所有的数据都正常添加进切片，初始化操作只执行了一次。其实 `sync.Once` 的实现相当简单，其原理就是锁加原子操作。

```go
type Once struct {
    doneValue uint32
    mutexValue Mutex
}

func (receiverPointer *Once) Do(functionValue func()) {
    if atomic.LoadUint32(&receiverPointer.doneValue) == 0 {
        receiverPointer.doSlow(functionValue)
    }
}

func (receiverPointer *Once) doSlow(functionValue func()) {
    receiverPointer.mutexValue.Lock()
    defer receiverPointer.mutexValue.Unlock()

    if receiverPointer.doneValue == 0 {
        defer atomic.StoreUint32(&receiverPointer.doneValue, 1)
        functionValue()
    }
}
```

#### Pool

`Pool` 来自标准库 `sync` 包，用于缓存和复用临时对象，减少频繁分配与回收带来的开销。

`sync.Pool` 的设计目的是用于存储临时对象以便后续复用，是一个临时的并发安全对象池。将暂时用不到的对象放入池中，在后续使用中就不需要再额外创建对象，可以直接复用，从而减少内存的分配与释放频率，最重要的一点就是降低 GC 压力。

`sync.Pool` 总共只有两个方法，并且有一个对外暴露的 `New` 字段。

1. **Get**：从对象池中申请一个对象。

```go
func (poolPointer *Pool) Get() any
// poolPointer: Pool 指针
// 返回结果: 申请到的对象
```

2. **Put**：将对象放回对象池。

```go
func (poolPointer *Pool) Put(objectValue any)
// poolPointer: Pool 指针
// objectValue: 待回收对象
// 返回结果: 将对象放回对象池
```

3. **New**：当池中没有可复用对象时，用于创建一个新对象。

```go
New func() any
// 返回结果: 创建一个新的池对象
```

下面用一个例子演示：

```go
var waitGroupValue sync.WaitGroup
var poolValue sync.Pool
var objectCountValue atomic.Int64

type BigMemData struct {
    messageValue string
}

func main() {
    poolValue.New = func() any {
        objectCountValue.Add(1)
        return BigMemData{messageValue: "大内存"}
    }

    waitGroupValue.Add(1000)

    for indexValue := 0; indexValue < 1000; indexValue++ {
        go func() {
            objectValue := poolValue.Get()
            _ = objectValue.(BigMemData)
            poolValue.Put(objectValue)
            waitGroupValue.Done()
        }()
    }

    waitGroupValue.Wait()
    fmt.Println(objectCountValue.Load())
}

// 输出示意:
// 5
```

例子中开启了 1000 个协程不断地在池中申请和释放对象。如果不采用对象池，那么 1000 个协程都需要各自实例化对象，并且这些对象在使用完毕后都需要由 GC 来释放内存。如果有几十万个协程，或者创建该对象的成本十分高昂，这种情况下就会占用很大的内存并且给 GC 带来非常大的压力。

采用对象池后，可以复用对象减少实例化的频率，比如上述例子里，即便开启了 1000 个协程，整个过程中也可能只创建了 5 个对象。如果不采用对象池的话，1000 个协程将会创建 1000 个对象，这种优化带来的提升是显而易见的，尤其是在并发量特别大和实例化对象成本特别高的时候更能体现出优势。

在使用 `sync.Pool` 时需要注意几个点：

- 临时对象：`sync.Pool` 只适合存放临时对象，池中的对象可能会在没有任何通知的情况下被 GC 移除，所以并不建议将网络连接、数据库连接这类对象存入 `sync.Pool` 中。
- 不可预知：`sync.Pool` 在申请对象时，无法预知这个对象是新创建的还是复用的，也无法知晓池中有几个对象。
- 并发安全：官方保证 `sync.Pool` 一定是并发安全，但并不保证用于创建对象的 `New` 函数就一定是并发安全的，`New` 函数是由使用者传入的，所以 `New` 函数的并发安全性要由使用者自己来维护，这也是为什么上例中对象计数要用到原子值的原因。

**提示：最后需要注意的是，当使用完对象后，一定要释放回池中，如果用了不释放，那么对象池的使用将毫无意义。**

标准库 `fmt` 包下就有一个对象池的使用案例，在 `fmt.Fprintf` 函数中：

```go
func Fprintf(writerValue io.Writer, formatValue string, argumentList ...any) (writtenValue int, err error) {
    printerValue := newPrinter()
    printerValue.doPrintf(formatValue, argumentList)
    writtenValue, err = writerValue.Write(printerValue.buf)
    printerValue.free()
    return
}
```

其中 `newPrinter` 函数和 `free` 方法的实现如下：

```go
func newPrinter() *pp {
    printerValue := ppFree.Get().(*pp)
    printerValue.panicking = false
    printerValue.erroring = false
    printerValue.wrapErrs = false
    printerValue.fmt.init(&printerValue.buf)
    return printerValue
}

func (receiverPointer *pp) free() {
    if cap(receiverPointer.buf) > 64<<10 {
        return
    }

    receiverPointer.buf = receiverPointer.buf[:0]
    receiverPointer.arg = nil
    receiverPointer.value = reflect.Value{}
    receiverPointer.wrappedErr = nil
    ppFree.Put(receiverPointer)
}
```

#### sync.Map

`sync.Map` 来自标准库 `sync` 包，用于在并发场景下安全地存取键值对。

`sync.Map` 是官方提供的一种并发安全 Map 的实现，开箱即用，使用起来十分简单。下面是该结构体对外暴露的方法：

1. **Load**：根据一个 key 读取值，并返回值是否存在。

```go
func (mapPointer *Map) Load(key any) (value any, ok bool)
// key: 键
// value: 读取到的值
// ok: 键是否存在
```

2. **Store**：存储一个键值对。

```go
func (mapPointer *Map) Store(key, value any)
// key: 键
// value: 值
// 返回结果: 存入一个键值对
```

3. **Delete**：删除一个键值对。

```go
func (mapPointer *Map) Delete(key any)
// key: 键
// 返回结果: 删除对应键值对
```

4. **LoadOrStore**：如果 key 已存在，就返回原有值；否则将新值存入并返回。

```go
func (mapPointer *Map) LoadOrStore(key, value any) (actual any, loaded bool)
// actual: 原值或新值
// loaded: 是否读取到了已有值
```

5. **LoadAndDelete**：删除一个键值对，并返回其原有值。

```go
func (mapPointer *Map) LoadAndDelete(key any) (value any, loaded bool)
// value: 删除前的值
// loaded: 键是否存在
```

6. **Range**：遍历 Map，当回调函数返回 `false` 时停止遍历。

```go
func (mapPointer *Map) Range(functionValue func(key, value any) bool)
// functionValue: 遍历回调
// 返回结果: 遍历 map
```

下面用一个简单的示例来演示 `sync.Map` 的基本使用：

```go
func main() {
    var syncMapValue sync.Map

    syncMapValue.Store("a", 1)
    syncMapValue.Store("a", "a")

    fmt.Println(syncMapValue.Load("a"))
    fmt.Println(syncMapValue.LoadAndDelete("a"))
    fmt.Println(syncMapValue.LoadOrStore("a", "hello world"))

    syncMapValue.Store("b", "goodbye world")

    syncMapValue.Range(func(keyValue, valueValue any) bool {
        fmt.Println(keyValue, valueValue)
        return true
    })
}

// 输出示意:
// a true
// a true
// hello world false
// a hello world
// b goodbye world
```

为了并发安全肯定需要做出一定的牺牲，`sync.Map` 的性能通常会比普通 `map` 更低，因此它更适合明确需要并发安全且使用模式合适的场景。

#### 原子

原子操作来自标准库 `sync/atomic` 包，用于在并发环境下对某些基础数据执行不可再分割的读写、交换、比较与更新操作。在计算机学科中，原子或原语操作，通常用于表述一些不可再细化分割的操作。由于这些操作无法再细化为更小的步骤，在执行完毕前，不会被其他任何协程打断，所以执行结果要么成功要么失败，没有第三种情况可言；如果出现了其他情况，那么它就不是原子操作。

##### 原子类型

好在大多数情况下并不需要自行编写汇编，Go 标准库 `sync/atomic` 包下已经提供了原子操作相关的 API。它提供了以下几种类型以供进行原子操作：

```go
atomic.Bool{}
atomic.Pointer[ElementType]{}
atomic.Int32{}
atomic.Int64{}
atomic.Uint32{}
atomic.Uint64{}
atomic.Uintptr{}
atomic.Value{}

// 说明:
// 1. Pointer 原子类型支持泛型
// 2. Value 可以存储任意类型
// 3. 原子操作更适合处理粒度较小的基础数据
```

其中 `Pointer` 原子类型支持泛型，`Value` 类型支持存储任何类型，除此之外，还提供了许多函数来方便操作。因为原子操作的粒度过细，在大多数情况下，更适合处理这些基础的数据类型。

`atomic` 包下很多原子操作的底层实现依赖更底层机制，使用时通常只需要关注其对外提供的 API。

##### 基本使用

每一个原子类型通常都会提供以下几类常见方法：

1. **Load**：原子地获取值。

```go
atomicValue.Load()
// atomicValue: 原子变量
// 返回结果: 当前值
```

2. **Store**：原子地存储值。

```go
atomicValue.Store(newValue)
// newValue: 新值
// 返回结果: 原子写入
```

3. **Swap**：原子地交换值，并返回旧值。

```go
atomicValue.Swap(newValue)
// newValue: 新值
// 返回结果: 旧值
```

4. **Add**：整型原子类型通常还会提供 `Add` 方法，用于原子加减。

```go
atomicIntegerValue.Add(deltaValue)
// deltaValue: 增量或减量
// 返回结果: 修改后的值
```

下面以一个整型原子类型演示：

```go
var atomicIntegerValue atomic.Int64

atomicIntegerValue.Store(64)
oldValue := atomicIntegerValue.Swap(128)
newValue := atomicIntegerValue.Add(112)
currentValue := atomicIntegerValue.Load()

fmt.Println(oldValue, newValue, currentValue)

// 输出:
// 64 240 240
```

除了原子类型的方法，也可以直接使用函数形式：

```go
var integerValue int64

atomic.StoreInt64(&integerValue, 64)
oldValue := atomic.SwapInt64(&integerValue, 128)
newValue := atomic.AddInt64(&integerValue, 112)
currentValue := atomic.LoadInt64(&integerValue)

fmt.Println(oldValue, newValue, currentValue)

// 输出:
// 64 240 240
```

其他类型的使用方式也是类似的。函数式 API 与原子类型方法本质上解决的是同一类问题，只是写法不同。

##### CAS

`atomic` 包还提供了 `CompareAndSwap` 操作，也就是 `CAS`。它是实现乐观锁和无锁数据结构的核心。乐观锁本身并不是锁，而是一种并发条件下无锁化的并发控制方式：协程在修改数据前，不会先加锁，而是先读取数据，进行计算，然后在提交修改时使用 `CAS` 来判断在此期间是否有其他协程修改过该数据。如果没有，也就是值仍等于之前读取的值，则修改成功；否则失败并重试。因此之所以被称作乐观锁，是因为它总是假设共享数据大概率不会被修改，仅在提交时做校验。而前面提到的互斥量则更接近悲观锁，会先假设共享数据一定会被别人改动，所以直接加锁保护。

对于 `CAS` 而言，有三个核心部分：内存值、期望值、新值。执行时，`CAS` 会将期望值与当前内存值进行比较，如果内存值与期望值相同，就会执行后续替换，否则什么也不做。对于 Go 中 `atomic` 包下的原子操作，`CAS` 相关函数需要传入地址、期望值、新值，并返回是否成功替换的布尔值。例如 `int64` 类型的函数签名如下：

```go
func CompareAndSwapInt64(addressPointer *int64, oldValue, newValue int64) (swapped bool)
// addressPointer: 目标地址
// oldValue: 期望值
// newValue: 新值
// swapped: 是否替换成功
```



先看一个互斥锁版本的加法：

```go
var mutexValue sync.Mutex
var countValue int

func add(numValue int) {
    mutexValue.Lock()
    countValue += numValue
    mutexValue.Unlock()
}
```

接下来使用 `CAS` 改造一下：

```go
var countValue int64

func add(numValue int64) {
    for {
        expectedValue := atomic.LoadInt64(&countValue)

        if atomic.CompareAndSwapInt64(&countValue, expectedValue, expectedValue+numValue) {
            break
        }
    }
}
```

在上面的 `CAS` 示例中，首先通过 `LoadInt64` 获取期望值，随后使用 `CompareAndSwapInt64` 来进行比较交换。如果不成功的话就不断循环，直到成功。这样无锁化的操作虽然不会导致协程阻塞，但是不断循环对于 CPU 而言依旧是一个不小的开销，所以在一些实现中失败达到了一定次数可能会放弃操作。不过对于这种简单的数字相加场景，完全可以考虑无锁化实现。大多数情况下，仅仅只是比较值并不足以保证复杂场景下的并发安全。例如 `CAS` 经典的 ABA 问题，就往往需要额外引入版本号等机制来解决。

##### Value

`atomic.Value` 结构体来自标准库 `sync/atomic` 包，可以存储任意类型的值。结构体如下：

```go
type Value struct {
    value any
}
```

尽管它可以存储任意类型，但是它不能存储 `nil`，并且前后存储的值类型应当保持一致。

1. **不能存储 nil**：向 `atomic.Value` 存储 `nil` 会触发 panic。

```go
var atomicValue atomic.Value
atomicValue.Store(nil)
fmt.Println(atomicValue.Load())

// 结果:
// panic: sync/atomic: store of nil value into Value
```

2. **类型必须一致**：第一次存的是什么类型，后面就必须继续存同类型值，否则也会 panic。

```go
var atomicValue atomic.Value

atomicValue.Store("hello world")
atomicValue.Store("another string")
fmt.Println(atomicValue.Load())

// 输出:
// another string
```

如果前后类型不一致，例如先存字符串再存整数，就会触发类型不一致的 panic。

其适合原子地替换某个整体配置、快照或共享只读对象。

```go
var configValue atomic.Value

configValue.Store(map[string]int{
    "port": 8080,
})

loadedValue := configValue.Load()
fmt.Println(loadedValue)

// 输出:
// map[port:8080]
```

除此之外，它的使用与其他原子类型并无太大的差别。需要注意的是，所有原子类型一般都不应该随意复制值，而应围绕同一个原子对象进行操作，实际使用中通常以变量本身或其地址为中心来共享。

### 网络编程

#### net

Go 语言的 `net` 标准库是一个非常强大的库，它来自标准库 `net` 包，提供了处理网络通信、IP 地址、DNS 解析、TCP/UDP 协议、Unix 域套接字等常见任务的功能。由于 Go 语言本身的并发特性，得益于此，Go 在处理网络 IO 的时候非常简洁高效。

##### 地址解析

Go 提供了多个函数来解析不同类型的网络地址，常见的包括 MAC 地址、CIDR、IP 地址、TCP 地址、UDP 地址、Unix 地址。

1. **解析 MAC 地址**：用于把字符串形式的 MAC 地址解析为 `HardwareAddr`。

```go
func ParseMAC(addressString string) (hardwareAddress HardwareAddr, err error)
// addressString: MAC 地址字符串
// hardwareAddress: 解析后的 MAC 地址
// err: 解析错误
```

2. **解析 CIDR**：用于解析 IP 网段。

```go
func ParseCIDR(cidrString string) (ipValue IP, ipNetValue *IPNet, err error)
// cidrString: CIDR 字符串
// ipValue: IP 地址
// ipNetValue: IP 网段
// err: 解析错误
```

3. **解析 IP 地址**：支持 `ip4`、`ip6`。

```go
func ResolveIPAddr(networkName, addressString string) (*IPAddr, error)
// networkName: 网络类型，如 ip4、ip6
// addressString: IP 地址字符串
// 返回结果: IP 地址对象
```

4. **解析 TCP 地址**：支持 `tcp4`、`tcp6`。

```go
func ResolveTCPAddr(networkName, addressString string) (*TCPAddr, error)
// networkName: 网络类型，如 tcp4、tcp6
// addressString: TCP 地址字符串
// 返回结果: TCP 地址对象
```

5. **解析 UDP 地址**：支持 `udp4`、`udp6`。

```go
func ResolveUDPAddr(networkName, addressString string) (*UDPAddr, error)
// networkName: 网络类型，如 udp4、udp6
// addressString: UDP 地址字符串
// 返回结果: UDP 地址对象
```

6. **解析 Unix 地址**：支持 `unix`、`unixgram`、`unixpacket`。

```go
func ResolveUnixAddr(networkName, addressString string) (*UnixAddr, error)
// networkName: 网络类型
// addressString: Unix Socket 地址
// 返回结果: Unix 地址对象
```

**示例**：统一演示地址解析。

```go
package main

import (
    "fmt"
    "net"
)

func main() {
    macAddressValue, _ := net.ParseMAC("00:1A:2B:3C:4D:5E")
    fmt.Println(macAddressValue)

    ipValue, ipNetValue, _ := net.ParseCIDR("192.0.2.1/24")
    fmt.Println(ipValue)
    fmt.Println(ipNetValue)

    ipv4AddressValue, _ := net.ResolveIPAddr("ip4", "192.168.2.1")
    ipv6AddressValue, _ := net.ResolveIPAddr("ip6", "2001:0db8:85a3:0000:0000:8a2e:0370:7334")
    fmt.Println(ipv4AddressValue)
    fmt.Println(ipv6AddressValue)

    tcp4AddressValue, _ := net.ResolveTCPAddr("tcp4", "0.0.0.0:2020")
    tcp6AddressValue, _ := net.ResolveTCPAddr("tcp6", "[::1]:8080")
    fmt.Println(tcp4AddressValue)
    fmt.Println(tcp6AddressValue)

    udp4AddressValue, _ := net.ResolveUDPAddr("udp4", "0.0.0.0:2020")
    udp6AddressValue, _ := net.ResolveUDPAddr("udp6", "[::1]:8080")
    fmt.Println(udp4AddressValue)
    fmt.Println(udp6AddressValue)

    unixAddressValue, _ := net.ResolveUnixAddr("unix", "/tmp/mysocket")
    fmt.Println(unixAddressValue)

    // 输出示意:
    // 00:1a:2b:3c:4d:5e
    // 192.0.2.1
    // 192.0.2.0/24
    // 192.168.2.1
    // 2001:db8:85a3::8a2e:370:7334
    // 0.0.0.0:2020
    // [::1]:8080
    // 0.0.0.0:2020
    // [::1]:8080
    // /tmp/mysocket
}
```

##### 域名解析

`net` 包还提供了很多函数用于 DNS 查询，例如域名解析、MX 记录查询等。

1. **查询主机地址**：根据域名查询 IP 地址列表。

```go
func LookupHost(hostName string) (addressList []string, err error)
// hostName: 域名
// addressList: 解析到的地址列表
// err: 查询错误
```

2. **查询 MX 记录**：根据域名查询邮件交换记录。

```go
func LookupMX(domainName string) (mxList []*MX, err error)
// domainName: 域名
// mxList: MX 记录列表
// err: 查询错误
```

**示例**：统一演示常见 DNS 查询。

```go
package main

import (
    "fmt"
    "net"
)

func main() {
    hostAddressList, _ := net.LookupHost("github.com")
    fmt.Println(hostAddressList)

    mxRecordList, _ := net.LookupMX("github.com")
    fmt.Println(mxRecordList)

    // 输出示意:
    // [140.82.113.4 ...]
    // [recordValue1 recordValue2 ...]
}
```

##### [网络编程](https://golang.halfiisland.com/essential/std/net.html#网络编程)

网络编程部分主要还是围绕 `net` 包中的连接、监听、读写这些能力展开。对于 TCP 而言，通常会区分客户端与服务端；对于 UDP 而言，因为它本身是无连接的，所以写法会和 TCP 略有不同。

###### TCP 网络编程

TCP 编程的逻辑十分简单。对于客户端而言就是：

* 建立连接
* 发送数据或读取数据
* 退出

对于服务端而言就是：

* 监听地址
* 获取连接
* 新建一个协程去处理该连接

1. **建立连接**：客户端常用 `Dial` 建立网络连接。

```go
func Dial(networkName, addressString string) (connectionValue Conn, err error)
// networkName: 网络类型，如 tcp、udp
// addressString: 目标地址
// connectionValue: 建立好的连接
// err: 连接错误
```

2. **监听地址**：服务端常用 `Listen` 监听端口。

```go
func Listen(networkName, addressString string) (listenerValue Listener, err error)
// networkName: 网络类型，如 tcp
// addressString: 监听地址
// listenerValue: 监听器
// err: 监听错误
```

3. **接受连接**：服务端通过 `Accept` 获取新连接。

```go
func (listenerValue Listener) Accept() (connectionValue Conn, err error)
// connectionValue: 新连接
// err: 接收错误
```

4. **读取数据**：连接通常通过 `Read` 读取字节流。

```go
func (connectionValue Conn) Read(bufferValue []byte) (readCountValue int, err error)
// bufferValue: 读取缓冲区
// readCountValue: 实际读取的字节数
// err: 读取错误
```

5. **写入数据**：连接通常通过 `Write` 写入字节流。

```go
func (connectionValue Conn) Write(dataValue []byte) (writeCountValue int, err error)
// dataValue: 待写入数据
// writeCountValue: 实际写入的字节数
// err: 写入错误
```

6. **关闭连接**：连接使用完毕后应关闭。

```go
func (connectionValue Conn) Close() error
// 返回结果: 关闭连接
```

**示例**：TCP 客户端发送数据。

```go
package main

import "net"

func main() {
    connectionValue, err := net.Dial("tcp", "0.0.0.0:1234")
    if err != nil {
        panic(err)
    }
    defer connectionValue.Close()

    for indexValue := 0; indexValue < 5; indexValue++ {
        _, err = connectionValue.Write([]byte("hello"))
        if err != nil {
            panic(err)
        }
    }

    // 作用:
    // 1. 建立 TCP 连接
    // 2. 连续向服务端写入数据
}
```

**示例**：TCP 服务端接收数据。

```go
package main

import (
    "errors"
    "fmt"
    "io"
    "net"
)

func main() {
    listenerValue, err := net.Listen("tcp", "0.0.0.0:1234")
    if err != nil {
        panic(err)
    }
    defer listenerValue.Close()

    for {
        connectionValue, err := listenerValue.Accept()
        if err != nil {
            panic(err)
        }

        go func() {
            defer connectionValue.Close()

            bufferValue := make([]byte, 4096)

            for {
                readCountValue, err := connectionValue.Read(bufferValue)
                if errors.Is(err, io.EOF) {
                    break
                }
                if err != nil {
                    panic(err)
                }

                dataValue := string(bufferValue[:readCountValue])
                fmt.Println(dataValue)
            }
        }()
    }

    // 作用:
    // 1. 监听 TCP 地址
    // 2. 每接收到一个连接就开一个协程处理
    // 3. 从连接中持续读取数据直到连接关闭
}
```

###### UDP 网络编程

UDP 是无连接协议，因此没有像 TCP 那样明显的“建立连接后持续收发”的过程。常见写法是：

* 服务端绑定一个 UDP 地址
* 客户端向该地址发送数据报
* 服务端读取数据报并获知发送方地址
* 如有需要，再把响应写回发送方

1. **解析 UDP 地址**：通常先通过 `ResolveUDPAddr` 获取地址对象。

```go
func ResolveUDPAddr(networkName, addressString string) (*UDPAddr, error)
// networkName: 网络类型，如 udp、udp4、udp6
// addressString: UDP 地址字符串
// 返回结果: UDP 地址对象
```

2. **监听 UDP**：服务端通过 `ListenUDP` 绑定本地 UDP 地址。

```go
func ListenUDP(networkName string, localAddressValue *UDPAddr) (*UDPConn, error)
// networkName: 网络类型，如 udp
// localAddressValue: 本地 UDP 地址
// 返回结果: UDP 连接对象
```

3. **读取 UDP 数据**：服务端通过 `ReadFromUDP` 读取数据报与来源地址。

```go
func (udpConnectionValue *UDPConn) ReadFromUDP(bufferValue []byte) (readCountValue int, remoteAddressValue *UDPAddr, err error)
// bufferValue: 读取缓冲区
// readCountValue: 实际读取字节数
// remoteAddressValue: 发送方地址
// err: 读取错误
```

4. **写入 UDP 数据**：可以通过 `WriteToUDP` 向指定地址发送数据报。

```go
func (udpConnectionValue *UDPConn) WriteToUDP(dataValue []byte, remoteAddressValue *UDPAddr) (writeCountValue int, err error)
// dataValue: 待发送数据
// remoteAddressValue: 目标地址
// writeCountValue: 实际写入字节数
// err: 写入错误
```

5. **客户端快捷发送**：客户端也可以通过 `DialUDP` 获得一个面向目标地址的 UDP 连接。

```go
func DialUDP(networkName string, localAddressValue, remoteAddressValue *UDPAddr) (*UDPConn, error)
// localAddressValue: 本地地址，可为 nil
// remoteAddressValue: 远端地址
// 返回结果: UDP 连接对象
```

**示例**：UDP 客户端发送数据。

```go
package main

import "net"

func main() {
    remoteAddressValue, err := net.ResolveUDPAddr("udp", "127.0.0.1:2345")
    if err != nil {
        panic(err)
    }

    udpConnectionValue, err := net.DialUDP("udp", nil, remoteAddressValue)
    if err != nil {
        panic(err)
    }
    defer udpConnectionValue.Close()

    _, err = udpConnectionValue.Write([]byte("hello udp"))
    if err != nil {
        panic(err)
    }

    // 作用:
    // 1. 解析远端 UDP 地址
    // 2. 建立一个面向该地址的 UDPConn
    // 3. 直接发送数据报
}
```

**示例**：UDP 服务端接收数据并回写。

```go
package main

import (
    "fmt"
    "net"
)

func main() {
    localAddressValue, err := net.ResolveUDPAddr("udp", "0.0.0.0:2345")
    if err != nil {
        panic(err)
    }

    udpConnectionValue, err := net.ListenUDP("udp", localAddressValue)
    if err != nil {
        panic(err)
    }
    defer udpConnectionValue.Close()

    bufferValue := make([]byte, 4096)

    for {
        readCountValue, remoteAddressValue, err := udpConnectionValue.ReadFromUDP(bufferValue)
        if err != nil {
            panic(err)
        }

        dataValue := string(bufferValue[:readCountValue])
        fmt.Println(dataValue)

        _, err = udpConnectionValue.WriteToUDP([]byte("received"), remoteAddressValue)
        if err != nil {
            panic(err)
        }
    }

    // 作用:
    // 1. 服务端绑定 UDP 地址
    // 2. 读取客户端发来的数据报
    // 3. 根据来源地址回写响应
}
```

客户端发送数据，服务端接收数据，这类例子本身都不复杂。TCP 更强调连接、读写流和并发处理连接；UDP 更强调数据报、来源地址和按报文收发。二者在 Go 中的 API 风格是一致的，都是围绕“解析地址、建立或监听、读写、关闭”这几个步骤展开。

##### http

Go 语言标准库中的 `net/http` 包十分优秀，提供了非常完善的 HTTP 客户端与服务端实现，仅通过几行代码就可以搭建一个非常简单的 HTTP 服务器。

几乎所有 Go 语言中的 Web 框架，都是对已有的 `net/http` 包做的封装与修改，因此十分建议学习其他框架前先掌握 `http` 包。

###### http基础

`http` 相关能力主要来自标准库 `net/http` 包。它既提供了客户端请求能力，也提供了服务端启动能力，因此很多最常见的 HTTP 操作都可以直接从这个包开始。

**客户端**

对于客户端而言，最常见的需求就是发起请求并读取响应。`net/http` 已经提供了一组开箱即用的快捷函数。

1. **GET 请求**：用于获取资源。

```go
func Get(urlValue string) (responseValue *Response, err error)
// urlValue: 请求地址
// responseValue: 响应对象
// err: 请求错误
```

2. **POST 请求**：用于提交资源，通常带请求体。

```go
func Post(
    urlValue string,
    contentTypeValue string,
    bodyValue io.Reader,
) (responseValue *Response, err error)
// urlValue: 请求地址
// contentTypeValue: 请求体类型
// bodyValue: 请求体
// responseValue: 响应对象
// err: 请求错误
```

3. **POST 表单请求**：用于发送表单数据。

```go
func PostForm(urlValue string, dataValue url.Values) (responseValue *Response, err error)
// urlValue: 请求地址
// dataValue: 表单数据
// responseValue: 响应对象
// err: 请求错误
```

4. **HEAD 请求**：用于只获取响应头，不读取响应体内容。

```go
func Head(urlValue string) (responseValue *Response, err error)
// urlValue: 请求地址
// responseValue: 响应对象
// err: 请求错误
```

5. **关闭响应体**：响应体使用完后应及时关闭。

```go
defer responseValue.Body.Close()
// responseValue.Body: 响应体
// 返回结果: 在当前函数结束前关闭响应体
```

6. **读取响应体**：通常使用 `io.ReadAll` 读取完整响应数据。

```go
io.ReadAll(responseValue.Body)
// responseValue.Body: 响应体
// 返回结果: 响应体字节内容
```

**服务端**

对于服务端而言，最常见的需求就是监听地址并处理请求。`net/http` 也提供了开箱即用的启动方式。

1. **快速启动服务**：直接使用 `http.ListenAndServe`。

```go
func ListenAndServe(addressValue string, handlerValue Handler) error
// addressValue: 监听地址
// handlerValue: 处理器，为 nil 时使用默认处理器
// 返回结果: 启动错误
```

2. **请求对象**：服务端处理请求时会接收到 `*http.Request`。

```go
type Request struct {
    Method string
    URL    *url.URL
    Header Header
    Body   io.ReadCloser
}
// Method: 请求方法
// URL: 请求地址信息
// Header: 请求头
// Body: 请求体
```

3. **响应写入器**：服务端通过 `http.ResponseWriter` 写入响应。

```go
type ResponseWriter interface {
    Header() Header
    Write(dataValue []byte) (writeCountValue int, err error)
    WriteHeader(statusCodeValue int)
}
// Header(): 设置响应头
// Write(): 写入响应体
// WriteHeader(): 写入状态码
```

4. **写入响应体**：最常见的响应方式。

```go
responseWriterValue.Write(dataValue)
// responseWriterValue: 响应写入器
// dataValue: 响应数据
// 返回结果: 实际写入字节数与错误
```

5. **写入状态码**：在写入响应体前可先设置状态码。

```go
responseWriterValue.WriteHeader(statusCodeValue)
// statusCodeValue: HTTP 状态码
// 返回结果: 写入响应状态码
```

**示例**：统一演示客户端与服务端基础能力。

```go
package main

import (
    "fmt"
    "io"
    "net/http"
)

func main() {
    go func() {
        http.HandleFunc("/", func(
            responseWriterValue http.ResponseWriter,
            requestValue *http.Request,
        ) {
            fmt.Println(requestValue.Method)
            responseWriterValue.WriteHeader(http.StatusOK)
            responseWriterValue.Write([]byte("hello http"))
        })

        http.ListenAndServe(":8080", nil)
    }()

    responseValue, err := http.Get("http://127.0.0.1:8080/")
    if err != nil {
        return
    }
    defer responseValue.Body.Close()

    bodyValue, err := io.ReadAll(responseValue.Body)
    if err != nil {
        return
    }

    fmt.Println(responseValue.StatusCode)
    fmt.Println(string(bodyValue))

    // 输出示意:
    // GET
    // 200
    // hello http
}
```

###### 自定义请求

一般情况下，我们并不会只使用 `http.Get`、`http.Post` 这些快捷函数，而是会自己配置一个客户端来达到更加细致化的需求。这将会用到 `http.Client{}` 结构体。

`http.Client` 常见可配置项包括：

- `Transport`：配置 HTTP 客户端数据传输相关选项，没有就采用默认策略
- `Timeout`：请求超时时间配置
- `Jar`：Cookie 相关配置
- `CheckRedirect`：重定向配置

1. **自定义客户端**：通过 `http.Client` 控制请求行为。

```go
type Client struct {
    Transport     RoundTripper
    CheckRedirect func(requestValue *Request, viaValue []*Request) error
    Jar           CookieJar
    Timeout       time.Duration
}
```

2. **创建请求对象**：使用 `http.NewRequest` 构造任意方法的请求。

```go
func NewRequest(
    methodValue string,
    urlValue string,
    bodyValue io.Reader,
) (requestValue *Request, err error)
// methodValue: 请求方法，如 GET、POST、PUT、DELETE、PATCH、OPTIONS
// urlValue: 请求地址
// bodyValue: 请求体
// requestValue: 请求对象
// err: 创建错误
```

3. **发送请求**：客户端通过 `Do` 执行请求。

```go
func (clientValue *Client) Do(requestValue *Request) (responseValue *Response, err error)
// requestValue: 请求对象
// responseValue: 响应对象
// err: 执行错误
```

4. **设置请求头**：常用于认证、内容类型、用户标识等。

```go
requestValue.Header.Add(keyValue, valueValue)
// keyValue: 请求头名称
// valueValue: 请求头值
```

因为 `NewRequest` 可以指定任意请求方法，所以除了 GET、POST 外，也可以自然支持 PUT、DELETE、PATCH、OPTIONS 等方法。

**示例**：统一演示自定义请求。

```go
clientValue := &http.Client{
    Timeout: 5 * time.Second,
}

getRequestValue, _ := http.NewRequest("GET", "https://example.com/users", nil)
getRequestValue.Header.Add("Authorization", "Bearer token")
getResponseValue, _ := clientValue.Do(getRequestValue)
defer getResponseValue.Body.Close()

putBodyValue := bytes.NewReader([]byte(`{"name":"new-name"}`))
putRequestValue, _ := http.NewRequest("PUT", "https://example.com/users/1", putBodyValue)
putRequestValue.Header.Add("Content-Type", "application/json")
putResponseValue, _ := clientValue.Do(putRequestValue)
defer putResponseValue.Body.Close()

deleteRequestValue, _ := http.NewRequest("DELETE", "https://example.com/users/1", nil)
deleteResponseValue, _ := clientValue.Do(deleteRequestValue)
defer deleteResponseValue.Body.Close()

patchBodyValue := bytes.NewReader([]byte(`{"age":20}`))
patchRequestValue, _ := http.NewRequest("PATCH", "https://example.com/users/1", patchBodyValue)
patchRequestValue.Header.Add("Content-Type", "application/json")
patchResponseValue, _ := clientValue.Do(patchRequestValue)
defer patchResponseValue.Body.Close()

optionsRequestValue, _ := http.NewRequest("OPTIONS", "https://example.com/users", nil)
optionsResponseValue, _ := clientValue.Do(optionsRequestValue)
defer optionsResponseValue.Body.Close()

// 作用:
// 1. 通过 NewRequest 支持任意 HTTP 方法
// 2. 通过 Header 自定义请求头
// 3. 通过 Client 控制超时等行为
```

一些更细致的配置，如自定义 `Transport`、TLS、代理、Cookie Jar 等，这里不做过多展开。

###### 路由与处理器

对于服务端而言，请求到达以后到底由谁处理、如何分发到不同路径，这部分主要由处理器与路由机制负责。

首先需要理解 `Handler` 接口。只要实现了 `ServeHTTP(ResponseWriter, *Request)` 方法，就可以作为一个 HTTP 处理器。

1. **Handler 接口**：HTTP 处理器的核心接口。

```go
type Handler interface {
    ServeHTTP(responseWriterValue ResponseWriter, requestValue *Request)
}
```

2. **注册处理器**：通过 `http.Handle` 绑定一个实现了 `Handler` 的对象。

```go
func Handle(patternValue string, handlerValue Handler)
// patternValue: 路由模式
// handlerValue: 处理器对象
```

3. **函数式处理器**：通过 `http.HandleFunc` 直接注册函数。

```go
func HandleFunc(
    patternValue string,
    handlerFuncValue func(ResponseWriter, *Request),
)
// patternValue: 路由模式
// handlerFuncValue: 处理函数
```

4. **默认路由器**：`DefaultServeMux` 是默认使用的多路复用器。

```go
var DefaultServeMux *ServeMux
// 说明:
// ListenAndServe(address, nil) 时会使用默认路由器
```

**示例**：统一演示结构体处理器与函数处理器。

```go
type MyHandler struct {
}

func (receiverPointer *MyHandler) ServeHTTP(
    responseWriterValue http.ResponseWriter,
    requestValue *http.Request,
) {
    responseWriterValue.Write([]byte("custom handler"))
}

func main() {
    http.Handle("/custom", &MyHandler{})

    http.HandleFunc("/index", func(
        responseWriterValue http.ResponseWriter,
        requestValue *http.Request,
    ) {
        responseWriterValue.Write([]byte("index"))
    })

    http.HandleFunc("/method", func(
        responseWriterValue http.ResponseWriter,
        requestValue *http.Request,
    ) {
        responseWriterValue.Write([]byte(requestValue.Method))
    })

    http.ListenAndServe(":8080", nil)

    // 效果:
    // 1. /custom 由结构体处理器处理
    // 2. /index 由函数处理器处理
    // 3. /method 返回请求方法
}
```

`ServeMux` 是核心结构体，实现了基本的路由分发能力，而 `DefaultServeMux` 是它的默认实例。大多数基础场景下使用默认实例即可。

###### 反向代理

`http` 相关能力还可以配合 `net/http/httputil` 包提供开箱即用的反向代理功能。反向代理的核心思想是：客户端请求先到本地服务，再由本地服务代替客户端去请求真正的目标服务，然后把结果返回给客户端。

1. **反向代理结构体**：常用入口是 `httputil.ReverseProxy`。

```go
type ReverseProxy struct {
    Director func(requestValue *http.Request)
}
```

2. **转发请求**：代理最终仍然通过 `ServeHTTP` 来处理请求。

```go
func (proxyValue *ReverseProxy) ServeHTTP(
    responseWriterValue http.ResponseWriter,
    requestValue *http.Request,
)
// responseWriterValue: 响应写入器
// requestValue: 原始请求
```

**示例**：

```go
http.HandleFunc("/forward", func(
    responseWriterValue http.ResponseWriter,
    requestValue *http.Request,
) {
    directorValue := func(requestValue *http.Request) {
        requestValue.URL.Scheme = "https"
        requestValue.URL.Host = "golang.org"
        requestValue.URL.Path = "/"
    }

    proxyValue := httputil.ReverseProxy{
        Director: directorValue,
    }

    proxyValue.ServeHTTP(responseWriterValue, requestValue)
})

http.ListenAndServe(":8080", nil)

// 作用:
// 访问本地 /forward 时，实际会把请求转发到 https://golang.org/
```

上述代码会将请求转发到指定目标地址。实际项目中，反向代理通常还会配合 Header 修改、Host 重写、错误处理、日志记录等能力一起使用。



## 语言特性

### 范围

Go 语言中 `range` 关键字用于 `for` 循环中迭代数组、切片、字符串、映射、通道等数据。它最大的特点是：**同一个关键字，可以针对不同数据类型返回不同含义的结果**。

一般来说，`range` 最常见的形式如下：

1. **同时获取索引 / 键 与值**：这是最完整的写法。

```go
for keyValue, elementValue := range targetValue {
    statement
}
// keyValue: 索引或键
// elementValue: 元素值
// targetValue: 被遍历对象
```

2. **只获取索引 / 键**：当只关心位置或键时，可以省略值。

```go
for keyValue := range targetValue {
    statement
}
// keyValue: 索引或键
// targetValue: 被遍历对象
```

也可以显式忽略值：

```go
for keyValue, _ := range targetValue {
    statement
}
// keyValue: 索引或键
// _: 忽略值
```

3. **只获取值**：当只关心元素值时，可以忽略索引或键。

```go
for _, elementValue := range targetValue {
    statement
}
// _: 忽略索引或键
// elementValue: 元素值
```

#### 常见数据类型

`range` 针对不同数据类型时，返回结果略有区别：

- 对数组、切片：返回索引和值
- 对字符串：返回字符起始字节索引和 `rune`
- 对映射：返回键和值
- 对通道：只返回接收到的值，直到通道关闭

1. **数组与切片**：返回索引和值。

```go
for indexValue, elementValue := range sliceValue {
    statement
}
// indexValue: 元素索引
// elementValue: 元素值
// sliceValue: 数组或切片
```

如果只需要值：

```go
for _, elementValue := range sliceValue {
    statement
}
// elementValue: 元素值
```

如果只需要索引：

```go
for indexValue := range sliceValue {
    statement
}
// indexValue: 元素索引
```

2. **字符串**：返回字符起始字节索引和 `rune`。

```go
for indexValue, runeValue := range stringValue {
    statement
}
// indexValue: 当前字符的起始字节索引
// runeValue: 当前字符对应的 Unicode 码点
// stringValue: 字符串
```

需要注意的是，字符串和数组、切片并不完全一样。`range` 遍历字符串时，返回的不是“每个字节”，而是**字符起始位置的字节索引**和对应的 `rune`。因此在包含中文等多字节字符时，索引值可能不是连续加一的。

3. **映射（Map）**：返回键和值。

```go
for keyValue, elementValue := range mapValue {
    statement
}
// keyValue: 键
// elementValue: 值
// mapValue: 映射
```

如果只需要键：

```go
for keyValue := range mapValue {
    statement
}
// keyValue: 键
```

如果只需要值：

```go
for _, elementValue := range mapValue {
    statement
}
// elementValue: 值
```

4. **通道（Channel）**：只返回接收到的值，直到通道关闭。

```go
for elementValue := range channelValue {
    statement
}
// elementValue: 从通道中接收到的值
// channelValue: 通道
```

`range` 遍历通道时不会返回索引，它只会不断接收值；当通道关闭并且数据读完后，循环才会结束。这也是它和数组、切片、映射最明显的不同之一。

```go
package main

import "fmt"

func main() {
    sliceValue := []int{2, 3, 4}
    stringValue := "go语言"
    mapValue := map[string]string{
        "a": "apple",
        "b": "banana",
    }

    channelValue := make(chan int, 2)
    channelValue <- 1
    channelValue <- 2
    close(channelValue)

    // 1. 数组 / 切片: 返回索引和值
    for indexValue, elementValue := range sliceValue {
        fmt.Println("slice:", indexValue, elementValue)
    }

    // 2. 只读取值
    for _, elementValue := range sliceValue {
        fmt.Println("slice value:", elementValue)
    }

    // 3. 只读取索引
    for indexValue := range sliceValue {
        fmt.Println("slice index:", indexValue)
    }

    // 4. 字符串: 返回字符起始字节索引和 rune
    for indexValue, runeValue := range stringValue {
        fmt.Printf("string: index=%d rune=%c\n", indexValue, runeValue)
    }

    // 5. map: 返回 key 和 value
    for keyValue, elementValue := range mapValue {
        fmt.Printf("map: %s -> %s\n", keyValue, elementValue)
    }

    // 6. map 只读取 key
    for keyValue := range mapValue {
        fmt.Println("map key:", keyValue)
    }

    // 7. map 只读取 value
    for _, elementValue := range mapValue {
        fmt.Println("map value:", elementValue)
    }

    // 8. channel: 只返回值，直到通道关闭
    for elementValue := range channelValue {
        fmt.Println("channel:", elementValue)
    }

    // 9. 一个常见用途: 求切片元素和
    sumValue := 0
    for _, elementValue := range sliceValue {
        sumValue += elementValue
    }
    fmt.Println("sum:", sumValue)

    // 输出示意:
    // slice: 0 2
    // slice: 1 3
    // slice: 2 4
    // slice value: 2
    // slice value: 3
    // slice value: 4
    // slice index: 0
    // slice index: 1
    // slice index: 2
    // string: index=0 rune=g
    // string: index=1 rune=o
    // string: index=2 rune=语
    // string: index=5 rune=言
    // map: a -> apple
    // map: b -> banana
    // map key: a
    // map key: b
    // map value: apple
    // map value: banana
    // channel: 1
    // channel: 2
    // sum: 9
}
```

### 迭代器

在 Go 中，过去 `for range` 只能直接作用于语言内置的一些数据结构，例如数组、切片、字符串、`map`、`chan` 以及整型值。这样虽然简单，但对自定义类型几乎没有扩展性。好在 Go 1.23 之后，`for range` 支持了 `range over func`，这样一来自定义迭代器就成为了可能。

Go 的迭代器本质上就是一个函数，它接受一个回调函数作为参数，并在迭代过程中把元素逐个传给这个回调。这里的 `yield` 只是一个惯用命名，并不是关键字。它和其他语言里的生成器、回调式遍历比较类似，只是 Go 没有为此新增新的语法关键字。

#### 推送式迭代器

关于迭代器的定义，可以在 `iter` 标准库中看到一个非常直接的描述：**迭代器是一个函数，它将序列中的元素逐个传递给回调函数，通常称为 `yield`**。这种由迭代器主动把值“推送”给调用方的模式，一般就称为推送式迭代器。

标准库 `iter` 包中定义了两种常见的迭代器类型：

1. **单值迭代器**：每次推送一个值。

```go
type Seq[ValueType any] func(yieldValue func(ValueType) bool)
// ValueType: 迭代值类型
// yieldValue: 每轮迭代接收一个值，返回是否继续
```

2. **双值迭代器**：每次推送两个值，通常对应键值对或索引和值。

```go
type Seq2[KeyType, ValueType any] func(yieldValue func(KeyType, ValueType) bool)
// KeyType: 第一个返回值类型
// ValueType: 第二个返回值类型
// yieldValue: 每轮迭代接收两个值，返回是否继续
```

如果是 `iter.Seq`，使用起来就是一个返回值：

```go
for elementValue := range iteratorValue {
    statement
}
// elementValue: 每轮迭代得到的值
```

如果是 `iter.Seq2`，使用起来就是两个返回值：

```go
for keyValue, elementValue := range iteratorValue {
    statement
}
// keyValue: 第一个值
// elementValue: 第二个值
```

理论上也允许 0 参数形式的迭代器，它大致等价于：

```go
func(yieldValue func() bool)
// yieldValue: 不接收任何值，只负责决定是否继续
```

使用时也就是：

```go
for range iteratorValue {
    statement
}
```

不过回调函数的参数个数只能是 0 到 2 个，再多就无法通过编译。

换句话说，`for range` 中的循环体，其实就相当于迭代器里的 `yield` 回调函数。每一轮迭代，迭代器都会调用一次 `yield`，也就相当于执行了一次循环体中的代码。因此下面这两种写法，本质上是等价的：

```go
for fibonacciValue := range Fibonacci(countValue) {
    fmt.Println(fibonacciValue)
}
// fibonacciValue: 每轮迭代得到的斐波那契数
```

```go
Fibonacci(countValue)(func(fibonacciValue int) bool {
    fmt.Println(fibonacciValue)
    return true
})
// fibonacciValue: 当前被推送出来的值
// 返回 true: 继续迭代
// 返回 false: 停止迭代
```

循环体里的 `return`、`break`、`continue`、`goto`、`defer` 等关键字在 `range over func` 中依旧会表现得像普通循环一样，这是编译器额外帮我们处理好的，因此使用时不需要手动改写这些控制流。

#### 拉取式迭代器

推送式迭代器是由迭代器控制迭代过程，调用方被动接收元素；相反，拉取式迭代器则是由调用方主动控制，每次自己决定何时获取下一个元素。一般来说，拉取式迭代器往往会暴露出类似 `next()`、`stop()` 这样的操作接口。

标准库 `iter` 包提供了 `Pull` 和 `Pull2`，用于把标准的推送式迭代器转换为拉取式迭代器：

1. **单值拉取转换**：

```go
func Pull[ValueType any](seqValue Seq[ValueType]) (
    nextValue func() (ValueType, bool),
    stopValue func(),
)
// seqValue: 推送式迭代器
// nextValue: 每次调用获取一个值和是否有效
// stopValue: 提前结束迭代
```

2. **双值拉取转换**：

```go
func Pull2[KeyType, ValueType any](seqValue Seq2[KeyType, ValueType]) (
    nextValue func() (KeyType, ValueType, bool),
    stopValue func(),
)
// seqValue: 推送式迭代器
// nextValue: 每次调用获取两个值和是否有效
// stopValue: 提前结束迭代
```

其中 `next()` 会返回当前迭代值以及一个布尔值；当布尔值为 `false` 时，说明迭代已经结束。`stop()` 用来主动停止迭代，一旦调用方决定不再继续使用这个迭代器，就应该调用它。需要注意的是，同一个拉取式迭代器的 `next` 不是并发安全的，不应在多个协程中同时调用。

例如，把前面的斐波那契推送式迭代器改造成拉取式后，可以写成这样：

```go
nextValue, stopValue := iter.Pull(Fibonacci(countValue))
defer stopValue()

for {
    fibonacciValue, okValue := nextValue()
    if !okValue {
        break
    }

    fmt.Println(fibonacciValue)
}
// nextValue: 主动拉取下一个元素
// stopValue: 结束迭代
```

这样一来，调用方就可以完全掌控迭代节奏，而不是由迭代器主动往外推值。

#### 执行模型

在使用推送式迭代器时，一个比较容易让人困惑的问题是：`yield` 回调函数是从哪里来的。代码中我们通常只定义了迭代器函数本身，却没有显式写出那个回调函数，但它依然能够正常工作。

关键点在于：这个回调函数并不是我们手动写出来的，而是**由编译器根据 `for range` 的循环体自动生成的**。

例如下面这段代码：

```go
for elementValue := range iteratorValue {
    fmt.Println(elementValue)
}
// elementValue: 每轮迭代得到的值
```

从语义上看，它大致等价于：

```go
iteratorValue(func(elementValue int) bool {
    fmt.Println(elementValue)
    return true
})
// elementValue: 当前被推送出来的值
// 返回 true: 继续迭代
// 返回 false: 停止迭代
```

也就是说，整个执行过程可以理解为下面这样：

- 迭代器函数本身的类型类似 `func(func(T) bool)`
- `for range` 会把循环体转换成一个回调函数
- 然后把这个回调函数作为参数传给迭代器执行

换句话说，**循环体本身就相当于 `yield` 回调函数**。

从执行流程来看，可以把它理解为：先调用 `iteratorValue` 得到一个可执行的迭代器函数，然后编译器把 `for` 循环体包装成回调函数，再由迭代器内部不断调用这个回调。每调用一次回调，就相当于执行了一次循环体。

因此，迭代器中很常见的这段代码：

```go
if !yieldValue(elementValue) {
    return
}
```

并不是一种随意的写法，而是用来承接循环控制流的必要模式。它的作用就是：**一旦循环体要求停止，迭代器也必须随之停止继续推送元素**。

例如：

```go
for elementValue := range iteratorValue {
    if elementValue > 3 {
        break
    }
}
```

从语义上看，大致等价于：

```go
iteratorValue(func(elementValue int) bool {
    if elementValue > 3 {
        return false
    }
    return true
})
```

也就是说：

- `yieldValue(...) == true`：继续迭代
- `yieldValue(...) == false`：停止迭代，可以对应 `break` 这样的行为

需要特别注意的是，这是一种**同步调用模型**。它不会自动引入 `goroutine`，也不会经过 `channel`。本质上，迭代器函数仍然只是普通函数调用，因此它的执行特征更接近普通的 `for` 循环，而不是并发流水线。

可以用一句话来概括这一机制：**`range over func` 的本质，就是把 `for` 循环体包装成回调函数，并交给迭代器驱动执行。**

标准库 `iter` 包中定义了两种常见的迭代器类型：

1. **单值迭代器**：每次推送一个值。

```go
type Seq[ValueType any] func(yieldValue func(ValueType) bool)
// ValueType: 迭代值类型
// yieldValue: 每轮迭代接收一个值，返回是否继续
```

2. **双值迭代器**：每次推送两个值，通常对应键值对或索引和值。

```go
type Seq2[KeyType, ValueType any] func(yieldValue func(KeyType, ValueType) bool)
// KeyType: 第一个返回值类型
// ValueType: 第二个返回值类型
// yieldValue: 每轮迭代接收两个值，返回是否继续
```

如果是 `iter.Seq`，使用起来就是一个返回值：

```go
for elementValue := range iteratorValue {
    statement
}
// elementValue: 每轮迭代得到的值
```

如果是 `iter.Seq2`，使用起来就是两个返回值：

```go
for keyValue, elementValue := range iteratorValue {
    statement
}
// keyValue: 第一个值
// elementValue: 第二个值
```

理论上也允许 0 参数形式的迭代器，它大致等价于：

```go
func(yieldValue func() bool)
// yieldValue: 不接收任何值，只负责决定是否继续
```

使用时也就是：

```go
for range iteratorValue {
    statement
}
```

不过回调函数的参数个数只能是 0 到 2 个，再多就无法通过编译。

换句话说，`for range` 中的循环体，其实就相当于迭代器里的 `yield` 回调函数。每一轮迭代，迭代器都会调用一次 `yield`，也就相当于执行了一次循环体中的代码。因此下面这两种写法，本质上是等价的：

```go
for fibonacciValue := range Fibonacci(countValue) {
    fmt.Println(fibonacciValue)
}
// fibonacciValue: 每轮迭代得到的斐波那契数
```

```go
Fibonacci(countValue)(func(fibonacciValue int) bool {
    fmt.Println(fibonacciValue)
    return true
})
// fibonacciValue: 当前被推送出来的值
// 返回 true: 继续迭代
// 返回 false: 停止迭代
```

循环体里的 `return`、`break`、`continue`、`goto`、`defer` 等关键字在 `range over func` 中依旧会表现得像普通循环一样，这是编译器额外帮我们处理好的，因此使用时不需要手动改写这些控制流。

#### 错误处理

如果在迭代过程中可能出现错误，最直接的办法就是把错误也作为迭代值的一部分返回。最常见的方式是使用 `iter.Seq2`，把第二个返回值设计成 `error`。

例如，一个按行扫描输入流的迭代器可以这样定义：

```go
func ScanLines(readerValue io.Reader) iter.Seq2[string, error] {
    scannerValue := bufio.NewScanner(readerValue)

    return func(yieldValue func(string, error) bool) {
        for scannerValue.Scan() {
            if !yieldValue(scannerValue.Text(), scannerValue.Err()) {
                return
            }
        }
    }
}
// readerValue: 输入源
// 返回结果: 每次迭代返回一行文本和一个错误
```

使用推送式迭代器时，可以这样处理错误：

```go
for lineValue, errValue := range ScanLines(readerValue) {
    if errValue != nil {
        fmt.Println(errValue)
        break
    }

    fmt.Println(lineValue)
}
// lineValue: 当前行内容
// errValue: 当前错误
```

使用拉取式迭代器时，也可以同样处理：

```go
nextValue, stopValue := iter.Pull2(ScanLines(readerValue))
defer stopValue()

for {
    lineValue, errValue, okValue := nextValue()

    if errValue != nil {
        fmt.Println(errValue)
        break
    }

    if !okValue {
        break
    }

    fmt.Println(lineValue)
}
// lineValue: 当前行内容
// errValue: 当前错误
// okValue: 当前值是否有效
```

如果在迭代过程中发生 `panic`，处理方式和普通 Go 代码没有区别，仍然是通过 `recover` 来兜底即可。

#### 标准库

Go 1.23 之后，很多标准库也开始支持迭代器，最常用的就是 `slices`、`maps` 和 `iter` 这些包。下面列几个比较常用的工具。

1. **slices.All**：把切片转换为带索引和值的迭代器。

```go
func All[SliceType ~[]ElementType, ElementType any](
    sliceValue SliceType,
) iter.Seq2[int, ElementType]
// sliceValue: 切片
// 返回结果: 返回索引和值的迭代器
```

2. **slices.Values**：把切片转换为只返回值的迭代器。

```go
func Values[SliceType ~[]ElementType, ElementType any](
    sliceValue SliceType,
) iter.Seq[ElementType]
// sliceValue: 切片
// 返回结果: 只返回值的迭代器
```

3. **slices.Chunk**：按固定大小分块返回子切片。

```go
func Chunk[SliceType ~[]ElementType, ElementType any](
    sliceValue SliceType,
    sizeValue int,
) iter.Seq[SliceType]
// sliceValue: 原切片
// sizeValue: 每块大小
// 返回结果: 分块后的切片迭代器
```

4. **slices.Collect**：把切片迭代器重新收集成切片。

```go
func Collect[ElementType any](
    seqValue iter.Seq[ElementType],
) []ElementType
// seqValue: 迭代器
// 返回结果: 收集后的切片
```

5. **maps.Keys**：返回 map 所有键的迭代器。

```go
func Keys[
    MapType ~map[KeyType]ValueType,
    KeyType comparable,
    ValueType any,
](mapValue MapType) iter.Seq[KeyType]
// mapValue: 原 map
// 返回结果: 键迭代器
```

6. **maps.Values**：返回 map 所有值的迭代器。

```go
func Values[
    MapType ~map[KeyType]ValueType,
    KeyType comparable,
    ValueType any,
](mapValue MapType) iter.Seq[ValueType]
// mapValue: 原 map
// 返回结果: 值迭代器
```

7. **maps.All**：返回 map 的键值对迭代器。

```go
func All[
    MapType ~map[KeyType]ValueType,
    KeyType comparable,
    ValueType any,
](mapValue MapType) iter.Seq2[KeyType, ValueType]
// mapValue: 原 map
// 返回结果: 键值对迭代器
```

8. **maps.Collect**：把 map 迭代器重新收集成 map。

```go
func Collect[KeyType comparable, ValueType any](
    seqValue iter.Seq2[KeyType, ValueType],
) map[KeyType]ValueType
// seqValue: map 迭代器
// 返回结果: 收集后的 map
```

这些函数通常作为数据流处理的中间环节或终结环节使用，例如把一个切片转成迭代器、再做筛选、排序、收集等操作。

#### 链式调用

标准库里的这些函数虽然可以组合起来处理数据流，但 Go 的迭代器采用的是闭包函数风格，本身只能通过函数嵌套来组合，调用链一长以后可读性会比较差，例如：

```go
sortedValues := slices.Sorted(slices.Values(sliceValue))
// sliceValue: 原切片
// 返回结果: 排序后的新切片
```

因此，如果希望写出更直观的链式调用风格，通常就需要自己再封装一层结构体，把迭代器保存到结构体中，再通过方法把各种操作串起来。一个简单的封装大致如下：

```go
type SliceSeq[ElementType any] struct {
    seqValue iter.Seq2[int, ElementType]
}
// seqValue: 底层切片迭代器
```

1. **返回原始迭代器**：

```go
func (receiverValue SliceSeq[ElementType]) All() iter.Seq2[int, ElementType]
// 返回结果: 原始索引和值迭代器
```

2. **过滤元素**：

```go
func (receiverValue SliceSeq[ElementType]) Filter(
    filterValue func(int, ElementType) bool,
) SliceSeq[ElementType]
// filterValue: 过滤条件
// 返回结果: 过滤后的迭代器包装
```

3. **映射元素**：

```go
func (receiverValue SliceSeq[ElementType]) Map(
    mapValue func(ElementType) ElementType,
) SliceSeq[ElementType]
// mapValue: 映射函数
// 返回结果: 映射后的迭代器包装
```

4. **查找元素**：

```go
func (receiverValue SliceSeq[ElementType]) Find(
    matchValue func(int, ElementType) bool,
) (resultValue ElementType)
// matchValue: 查找条件
// resultValue: 第一个匹配到的值
```

5. **收集结果**：

```go
func (receiverValue SliceSeq[ElementType]) Collect() []ElementType
// 返回结果: 收集后的切片
```

6. **排序结果**：

```go
func (receiverValue SliceSeq[ElementType]) Sort(
    compareValue func(leftValue, rightValue ElementType) int,
) []ElementType
// compareValue: 比较函数
// 返回结果: 排序后的切片
```

7. **入口函数**：把普通切片包装成链式可用的对象。

```go
func Slice[SliceType ~[]ElementType, ElementType any](
    sliceValue SliceType,
) SliceSeq[ElementType]
// sliceValue: 原切片
// 返回结果: 可链式调用的包装对象
```

有了这一层封装后，就可以写出类似下面这样的调用方式：

```go
upperValues := iterx.Slice(stringSliceValue).
    Map(strings.ToUpper).
    Collect()
// stringSliceValue: 原字符串切片
// 返回结果: 转大写后的切片
```

```go
resultValue := iterx.Slice(intSliceValue).
    Filter(func(indexValue int, elementValue int) bool {
        return elementValue%2 == 0
    }).
    Collect()
// intSliceValue: 原整型切片
// 返回结果: 过滤后的切片
```

这种方式本质上并不是 Go 原生语法支持的链式迭代器，而是通过结构体方法把推送式迭代器包装成了更接近数据流处理风格的接口。比较可惜的是，Go 目前还不支持更简短的匿名函数写法，因此链式调用虽然可行，但在表达上通常还是不如一些函数式语言或脚本语言简洁。

```go
package main

import (
	"fmt"
	"iter"
	"slices"
)

// SortedValuesIterator 接收一个切片，返回一个“排序后的值迭代器”。
// 它不会修改原切片，而是先拷贝一份，再排序，然后按顺序 yield。
func SortedValuesIterator(sliceValue []int) iter.Seq[int] {
	copiedValue := slices.Clone(sliceValue)
	slices.Sort(copiedValue)

	return func(yieldValue func(int) bool) {
		for _, elementValue := range copiedValue {
			if !yieldValue(elementValue) {
				return
			}
		}
	}
}

func main() {
	numberSliceValue := []int{5, 1, 4, 2, 3, 9, 7, 6, 8}

	for elementValue := range SortedValuesIterator(numberSliceValue) {
		fmt.Println(elementValue)
	}

	// 输出:
	// 1
	// 2
	// 3
	// 4
	// 5
	// 6
	// 7
	// 8
	// 9
}

```

**Go 的推送式迭代器相对于原生 `for range` 会有一些额外开销，但通常还在可接受范围内；而拉取式迭代器由于要额外做转换和状态管理，性能往往会明显差于前两者。** 因此在实际使用时，一般更适合优先考虑可读性、统一性和抽象能力，而不是把它当成原生循环的性能替代品。

### 反射

反射是一种在运行时检查语言自身结构的机制，它可以很灵活地去应对一些问题，但同时带来的弊端也很明显，例如性能问题、可读性下降、类型安全变弱等。在 Go 中，反射与 `any` 密切相关，很大程度上，只要有 `any` 出现的地方，就会有反射。Go 中的反射 API 主要由标准库 `reflect` 包提供。

#### 实现机制

在 Go 中，接口在运行时并不是一个抽象概念，而是会被表示成具体的数据结构。Go 运行时大体上把接口分成两类：一类是**没有方法集的接口**，另一类是**有方法集的接口**。

对于带方法集的接口，在运行时大致可以表示为：

```go
type iface struct {
    tab  *itab
    data unsafe.Pointer
}
// tab: 保存接口类型、具体类型、方法集等信息
// data: 指向真实值的指针
```

对于空接口，也就是没有方法集的接口，在运行时大致可以表示为：

```go
type eface struct {
    _type *_type
    data  unsafe.Pointer
}
// _type: 具体类型信息
// data: 指向真实值的指针
```

而在 `reflect` 包内部，也存在与它们对应的表示。对于普通接口，内部有类似这样的结构：

```go
type nonEmptyInterface struct {
    itab *struct {
        ityp *rtype
        typ  *rtype
        hash uint32
        _    [4]byte
        fun  [100000]unsafe.Pointer
    }
    word unsafe.Pointer
}
// ityp: 静态接口类型
// typ: 动态具体类型
// word: 指向具体值
```

对于空接口，则对应类似这样的结构：

```go
type emptyInterface struct {
    typ  *rtype
    word unsafe.Pointer
}
// typ: 动态具体类型
// word: 指向具体值
```

这里经常会提到“动态具体类型”这一说法。需要注意，Go 依然是静态类型语言；这里所谓的“动态”，并不是说语言本身变成了动态类型，而是说：**接口对外暴露的抽象类型不变，但它内部实际存放的具体值类型可以变化。**

理解这一点以后，就可以自然过渡到反射。因为在 `reflect` 包中，最核心的两个类型正是：

```go
type Type interface {
    Name() string
    PkgPath() string
    Size() uintptr
    String() string
    Kind() Kind
}
```

```go
type Value struct {
    typ *rtype
    ptr unsafe.Pointer
    flag
}
```

`reflect.Type` 用来表示 Go 中的**类型**，`reflect.Value` 用来表示 Go 中的**值**。Go 中几乎所有反射相关的操作，最终都围绕这两个类型展开。

而要把普通 Go 值转换成这两类反射对象，就需要使用下面两个函数：

1. **获取类型对象**

```go
func TypeOf(i any) Type
// i: 任意值
// 返回结果: 对应的反射类型
```

2. **获取值对象**

```go
func ValueOf(i any) Value
// i: 任意值
// 返回结果: 对应的反射值
```

之所以它们的参数都是 `any`，本质上就是因为：**空接口是 Go 类型系统与反射系统之间的桥梁。** 普通 Go 值先进入 `any`，随后再由 `reflect.TypeOf` 或 `reflect.ValueOf` 转换成反射对象，这就是反射最基本的入口。

也正因为如此，Go 反射里有三个非常经典的定律，基本可以看作反射的核心：

第一，反射可以把 `any` 类型变量转换成反射对象。  
第二，反射也可以把反射对象再还原成 `any` 类型变量。  
第三，如果想通过反射修改值，那么这个值必须是可设置的。

所以在实际使用时，通常就是：

- 想访问类型相关信息时，使用 `reflect.TypeOf`
- 想读取值、修改值、调用函数或方法时，使用 `reflect.ValueOf`

到这里，其实就已经把接口、桥梁和核心三部分串起来了：**接口是运行时承载值与类型信息的容器，`any` 是普通值进入反射系统的桥梁，而 `Type` / `Value` 与三条反射定律则构成了反射的核心。**

#### 类型

`reflect.Type` 代表着 Go 中的类型，使用 `reflect.TypeOf()` 函数可以将变量转换成 `reflect.Type`。代码示例如下：

```go
reflect.TypeOf(targetValue)
// targetValue: 任意 Go 值
// 返回结果: reflect.Type
```

例如：

```go
stringValue := "hello world"
typeValue := reflect.TypeOf(stringValue)
fmt.Println(typeValue)
// 输出: string
```

##### Kind

对于 `Type` 而言，Go 内部使用 `reflect.Kind` 来表示 Go 中的基础类型，其本质上是无符号整型 `uint`。

```go
type Kind uint
```

`reflect` 包使用 `Kind` 枚举出了 Go 中所有的基础类型，如下所示：

```go
const (
    Invalid Kind = iota
    Bool
    Int
    Int8
    Int16
    Int32
    Int64
    Uint
    Uint8
    Uint16
    Uint32
    Uint64
    Uintptr
    Float32
    Float64
    Complex64
    Complex128
    Array
    Chan
    Func
    Interface
    Map
    Pointer
    Slice
    String
    Struct
    UnsafePointer
)
```

通过 `Kind`，可以知晓空接口存储的值究竟是什么基础类型，例如：

```go
var anyValue any
anyValue = 100

fmt.Println(reflect.TypeOf(anyValue).Kind())
// 输出: int
```

##### Elem

```go
typeValue.Elem()
// typeValue: 指针、切片、数组、通道、映射等类型
// 返回结果: 元素类型对应的 reflect.Type
```

使用 `Type.Elem()` 方法，可以判断类型为 `any` 的数据结构所存储的元素类型。对于 `map` 而言，还可以结合 `Key()` 一起使用。

```go
var anyValue any
anyValue = map[string]int{}

typeValue := reflect.TypeOf(anyValue)

fmt.Println(typeValue.Key().Kind())
fmt.Println(typeValue.Elem().Kind())
// 输出:
// string
// int
```

指针也可以理解为是一个容器，对于指针使用 `Elem()` 会获得其指向元素的反射类型，代码示例如下：

```go
var anyValue any
anyValue = new(strings.Builder)

typeValue := reflect.TypeOf(anyValue)
elementTypeValue := typeValue.Elem()

fmt.Println(elementTypeValue.PkgPath())
fmt.Println(elementTypeValue.Name())
// 输出:
// strings
// Builder
```

对于数组、切片、通道，使用起来都是类似的。

##### Size

```go
typeValue.Size()
// typeValue: reflect.Type
// 返回结果: 类型所占字节数
```

通过 `Size` 方法可以获取对应类型所占的字节大小，示例如下：

```go
fmt.Println(reflect.TypeOf(0).Size())
fmt.Println(reflect.TypeOf("").Size())
fmt.Println(reflect.TypeOf(complex(0, 0)).Size())
fmt.Println(reflect.TypeOf(0.1).Size())
fmt.Println(reflect.TypeOf([]string{}).Size())
// 输出:
// 8
// 16
// 16
// 8
// 24
```

提示：使用 `unsafe.Sizeof()` 也可以达到类似效果。

##### Comparable

```go
typeValue.Comparable()
// typeValue: reflect.Type
// 返回结果: 是否可比较
```

通过 `Comparable` 方法可以判断一个类型是否可以被比较，例子如下：

```go
fmt.Println(reflect.TypeOf("hello world").Comparable())
fmt.Println(reflect.TypeOf(1024).Comparable())
fmt.Println(reflect.TypeOf([]int{}).Comparable())
fmt.Println(reflect.TypeOf(struct{}{}).Comparable())
// 输出:
// true
// true
// false
// true
```

##### Implements

```go
typeValue.Implements(interfaceTypeValue)
// typeValue: 某个具体类型
// interfaceTypeValue: 某个接口类型
// 返回结果: 是否实现该接口
```

通过 `Implements` 方法可以判断一个类型是否实现了某一接口。

```go
type MyInterface interface {
    My() string
}

type MyStruct struct {
}

func (receiverValue MyStruct) My() string {
    return "my"
}

type HisStruct struct {
}

func (receiverValue HisStruct) String() string {
    return "his"
}

interfaceTypeValue := reflect.TypeOf(new(MyInterface)).Elem()

fmt.Println(reflect.TypeOf(new(MyStruct)).Elem().Implements(interfaceTypeValue))
fmt.Println(reflect.TypeOf(new(HisStruct)).Elem().Implements(interfaceTypeValue))
// 输出:
// true
// false
```

##### ConvertibleTo

```go
typeValue.ConvertibleTo(targetTypeValue)
// typeValue: 原类型
// targetTypeValue: 目标类型
// 返回结果: 是否可转换
```

使用 `ConvertibleTo` 方法可以判断一个类型是否可以被转换为另一个指定的类型。

```go
type MyInt int
type YourInt int

sourceTypeValue := reflect.TypeOf(MyInt(0))
targetTypeValue := reflect.TypeOf(YourInt(0))

fmt.Println(sourceTypeValue.ConvertibleTo(targetTypeValue))
// 输出: true
```

#### 值

`reflect.Value` 代表着反射接口的值，使用 `reflect.ValueOf()` 函数可以将变量转换成 `reflect.Value`。

```go
reflect.ValueOf(targetValue)
// targetValue: 任意 Go 值
// 返回结果: reflect.Value
```

例如：

```go
stringValue := "hello world"
valueValue := reflect.ValueOf(stringValue)
fmt.Println(valueValue)
// 输出: hello world
```

##### Type

```go
valueValue.Type()
// valueValue: reflect.Value
// 返回结果: reflect.Type
```

`Type` 方法可以获取一个反射值的类型。

```go
numberValue := 114514
valueValue := reflect.ValueOf(numberValue)

fmt.Println(valueValue.Type())
// 输出: int
```

##### Elem

```go
valueValue.Elem()
// valueValue: 指针、接口等包装值
// 返回结果: 内部元素的 reflect.Value
```

获取一个反射值的元素反射值。

```go
numberPointerValue := new(int)
*numberPointerValue = 114514

valueValue := reflect.ValueOf(numberPointerValue).Elem()
fmt.Println(valueValue.Interface())
// 输出: 114514
```

##### 指针

获取一个反射值的指针方式有几种：

1. **获取地址形式的反射值**

```go
valueValue.Addr()
// valueValue: 可取址的 reflect.Value
// 返回结果: 表示地址的 reflect.Value
```

2. **获取原始地址**

```go
valueValue.UnsafeAddr()
// valueValue: 可取址的 reflect.Value
// 返回结果: uintptr 形式的地址
```

3. **获取某些引用类型的底层地址**

```go
valueValue.Pointer()
// valueValue: Chan、Func、Map、Pointer、Slice、UnsafePointer 等
// 返回结果: uintptr 形式的地址
```

4. **获取 unsafe.Pointer**

```go
valueValue.UnsafePointer()
// valueValue: Chan、Func、Map、Pointer、Slice、UnsafePointer 等
// 返回结果: unsafe.Pointer
```

示例如下：

```go
numberValue := 1024
elementValue := reflect.ValueOf(&numberValue).Elem()

fmt.Println("&numberValue", &numberValue)
fmt.Println("Addr", elementValue.Addr())
fmt.Println("UnsafeAddr", unsafe.Pointer(elementValue.UnsafeAddr()))
fmt.Println("Pointer", unsafe.Pointer(elementValue.Addr().Pointer()))
fmt.Println("UnsafePointer", elementValue.Addr().UnsafePointer())
// 输出示意:
// &numberValue 0xc0000...
// Addr 0xc0000...
// UnsafeAddr 0xc0000...
// Pointer 0xc0000...
// UnsafePointer 0xc0000...
```

提示：`fmt.Println` 会反射获取参数的类型，如果是 `reflect.Value` 类型的话，会自动调用 `Value.Interface()` 来获取其原始值。

##### 设置值

```go
valueValue.Set(newValueValue)
// valueValue: 可设置的 reflect.Value
// newValueValue: 新 reflect.Value
```

倘若通过反射来修改反射值，那么其值必须是可取址、可设置的，这时应该通过指针来修改其元素值，而不是直接尝试修改值本身。

```go
numberPointerValue := new(int)
*numberPointerValue = 114514

valueValue := reflect.ValueOf(numberPointerValue)
elementValue := valueValue.Elem()

fmt.Println(elementValue.Interface())

elementValue.SetInt(11)

fmt.Println(elementValue.Interface())
// 输出:
// 114514
// 11
```

##### 获取值

```go
valueValue.Interface()
// valueValue: reflect.Value
// 返回结果: any
```

通过 `Interface()` 方法可以获取反射值原有的值。

```go
stringValue := "hello"
valueValue := reflect.ValueOf(stringValue)

if resultValue, okValue := valueValue.Interface().(string); okValue {
    fmt.Println(resultValue)
}
// 输出: hello
```

#### 函数

通过反射可以获取函数的一切信息，也可以反射调用函数。

##### 信息

通过反射类型来获取函数的信息。

```go
func Max(leftValue, rightValue int) int {
    if leftValue > rightValue {
        return leftValue
    }
    return rightValue
}
```

```go
typeValue := reflect.TypeOf(Max)

fmt.Println(typeValue.Name())
fmt.Println(typeValue.NumIn(), typeValue.NumOut())

parameterTypeValue := typeValue.In(0)
resultTypeValue := typeValue.Out(0)

fmt.Println(parameterTypeValue.Kind())
fmt.Println(resultTypeValue.Kind())
// 输出:
// 2 1
// int
// int
```

##### 调用

```go
valueValue.Call(argumentValues)
// valueValue: 函数对应的 reflect.Value
// argumentValues: 参数 reflect.Value 列表
// 返回结果: 返回值 reflect.Value 列表
```

通过反射值来调用函数。

```go
functionValue := reflect.ValueOf(Max)

resultValues := functionValue.Call([]reflect.Value{
    reflect.ValueOf(18),
    reflect.ValueOf(50),
})

for _, resultValue := range resultValues {
    fmt.Println(resultValue.Interface())
}
// 输出: 50
```

#### 结构体

假设有如下结构体：

```go
type Person struct {
    Name    string `json:"name"`
    Age     int    `json:"age"`
    Address string `json:"address"`
    money   int
}

func (receiverValue Person) Talk(messageValue string) string {
    return messageValue
}
```

##### 访问字段

`reflect.StructField` 结构如下：

```go
type StructField struct {
    Name      string
    PkgPath   string
    Type      Type
    Tag       StructTag
    Offset    uintptr
    Index     []int
    Anonymous bool
}
```

访问结构体字段的方法有两种，一种是通过索引来访问，另一种是通过名称。

1. **按索引访问字段**

```go
typeValue.Field(indexValue)
// typeValue: 结构体对应的 reflect.Type
// indexValue: 字段下标
// 返回结果: StructField
```

```go
typeValue := reflect.TypeOf(new(Person)).Elem()

fmt.Println(typeValue.NumField())

for indexValue := 0; indexValue < typeValue.NumField(); indexValue++ {
    fieldValue := typeValue.Field(indexValue)
    fmt.Println(
        fieldValue.Index,
        fieldValue.Name,
        fieldValue.Type,
        fieldValue.Offset,
        fieldValue.IsExported(),
    )
}
// 输出示意:
// 4
// [0] Name string 0 true
// [1] Age int 16 true
// [2] Address string 24 true
// [3] money int 40 false
```

2. **按名称访问字段**

```go
typeValue.FieldByName(fieldNameValue)
// fieldNameValue: 字段名
// 返回结果: StructField, bool
```

```go
typeValue := reflect.TypeOf(new(Person)).Elem()

fmt.Println(typeValue.NumField())

if fieldValue, okValue := typeValue.FieldByName("money"); okValue {
    fmt.Println(fieldValue.Name, fieldValue.Type, fieldValue.IsExported())
}
// 输出:
// 4
// money int false
```

##### 修改字段

倘若要修改结构体字段值，则必须传入一个结构体指针。

```go
valueValue := reflect.ValueOf(&Person{
    Name:    "",
    Age:     0,
    Address: "",
    money:   0,
}).Elem()

nameFieldValue := valueValue.FieldByName("Name")

if nameFieldValue != (reflect.Value{}) {
    nameFieldValue.SetString("jack")
}

fmt.Println(valueValue.Interface())
// 输出: {jack 0  0}
```

对于修改结构体私有字段而言，需要进行一些额外的操作，例如借助 `reflect.NewAt` 和 `unsafe`：

```go
valueValue := reflect.ValueOf(&Person{
    Name:    "",
    Age:     0,
    Address: "",
    money:   0,
}).Elem()

moneyFieldValue := valueValue.FieldByName("money")

if moneyFieldValue != (reflect.Value{}) {
    pointerValue := reflect.NewAt(
        moneyFieldValue.Type(),
        moneyFieldValue.Addr().UnsafePointer(),
    )

    fieldValue := pointerValue.Elem()
    fieldValue.SetInt(164)
}

fmt.Printf("%+v
", valueValue.Interface())
// 输出示意:
// {Name: Age:0 Address: money:164}
```

##### 访问 Tag

获取到 `StructField` 后，便可以直接访问其 Tag。

1. **查找标签并区分是否存在**

```go
fieldValue.Tag.Lookup(tagKeyValue)
// tagKeyValue: 标签名
// 返回结果: 标签值, 是否存在
```

2. **直接获取标签值**

```go
fieldValue.Tag.Get(tagKeyValue)
// tagKeyValue: 标签名
// 返回结果: 标签值，不存在时为空字符串
```

示例如下：

```go
typeValue := reflect.TypeOf(new(Person)).Elem()

nameFieldValue, okValue := typeValue.FieldByName("Name")
if okValue {
    fmt.Println(nameFieldValue.Tag.Lookup("json"))
    fmt.Println(nameFieldValue.Tag.Get("json"))
}
// 输出:
// name true
// name
```

##### 访问方法

访问方法与访问字段的过程很相似。`reflect.Method` 结构如下：

```go
type Method struct {
    Name    string
    PkgPath string
    Type    Type
    Func    Value
    Index   int
}
```

访问方法信息示例如下：

```go
typeValue := reflect.TypeOf(new(Person)).Elem()

fmt.Println(typeValue.NumMethod())

for indexValue := 0; indexValue < typeValue.NumMethod(); indexValue++ {
    methodValue := typeValue.Method(indexValue)
    fmt.Println(
        methodValue.Index,
        methodValue.Name,
        methodValue.Type,
        methodValue.IsExported(),
    )
}
// 输出示意:
// 1
// 0 Talk func(main.Person, string) string true
```

如果想要获取方法的参数和返回值细节，可以通过 `Method.Func.Type()` 来获取，过程与访问函数信息一致。需要注意，第一个参数是接收者类型。

```go
typeValue := reflect.TypeOf(new(Person)).Elem()

fmt.Println(typeValue.NumMethod())

for indexValue := 0; indexValue < typeValue.NumMethod(); indexValue++ {
    methodValue := typeValue.Method(indexValue)

    fmt.Println(
        methodValue.Index,
        methodValue.Name,
        methodValue.Type,
        methodValue.IsExported(),
    )

    fmt.Println("方法参数")
    for parameterIndexValue := 0; parameterIndexValue < methodValue.Func.Type().NumIn(); parameterIndexValue++ {
        fmt.Println(methodValue.Func.Type().In(parameterIndexValue).String())
    }

    fmt.Println("方法返回值")
    for resultIndexValue := 0; resultIndexValue < methodValue.Func.Type().NumOut(); resultIndexValue++ {
        fmt.Println(methodValue.Func.Type().Out(resultIndexValue).String())
    }
}
// 输出示意:
// 1
// 0 Talk func(main.Person, string) string true
// 方法参数
// main.Person
// string
// 方法返回值
// string
```

##### 调用方法

调用方法与调用函数的过程相似，而且并不需要手动传入接收者。

```go
valueValue := reflect.ValueOf(new(Person)).Elem()

fmt.Println(valueValue.NumMethod())

talkMethodValue := valueValue.MethodByName("Talk")

if talkMethodValue != (reflect.Value{}) {
    resultValues := talkMethodValue.Call([]reflect.Value{
        reflect.ValueOf("hello,reflect!"),
    })

    for _, resultValue := range resultValues {
        fmt.Println(resultValue.Interface())
    }
}
// 输出:
// 1
// hello,reflect!
```

#### 创建

通过反射可以构造新的值，`reflect` 包同时根据一些特殊的类型提供了不同的更为方便的函数。

##### 基本类型

```go
reflect.New(typeValue)
// typeValue: reflect.Type
// 返回结果: 指向该类型零值的 reflect.Value
```

以 `string` 为例：

```go
valueValue := reflect.New(reflect.TypeOf(*new(string)))
valueValue.Elem().SetString("hello world!")

fmt.Println(valueValue.Elem().Interface())
// 输出: hello world!
```

##### 结构体

结构体的创建同样用到 `reflect.New` 函数。

```go
typeValue := reflect.TypeOf(new(Person)).Elem()
personValue := reflect.New(typeValue).Elem()

fmt.Println(personValue.Interface())
// 输出示意:
// { 0  0}
```

##### 切片

```go
reflect.MakeSlice(typeValue, lengthValue, capacityValue)
// typeValue: 切片类型
// lengthValue: 长度
// capacityValue: 容量
// 返回结果: reflect.Value
```

```go
sliceValue := reflect.MakeSlice(
    reflect.TypeOf(*new([]int)),
    10,
    10,
)

for indexValue := 0; indexValue < 10; indexValue++ {
    sliceValue.Index(indexValue).SetInt(int64(indexValue))
}

fmt.Println(sliceValue.Interface())
// 输出:
// [0 1 2 3 4 5 6 7 8 9]
```

##### Map

```go
reflect.MakeMapWithSize(typeValue, sizeValue)
// typeValue: map 类型
// sizeValue: 初始容量
// 返回结果: reflect.Value
```

```go
mapValue := reflect.MakeMapWithSize(
    reflect.TypeOf(*new(map[string]int)),
    10,
)

mapValue.SetMapIndex(
    reflect.ValueOf("a"),
    reflect.ValueOf(1),
)

fmt.Println(mapValue.Interface())
// 输出:
// map[a:1]
```

##### 管道

```go
reflect.MakeChan(typeValue, bufferValue)
// typeValue: chan 类型
// bufferValue: 缓冲区大小
// 返回结果: reflect.Value
```

```go
chanValue := reflect.MakeChan(
    reflect.TypeOf(new(chan int)).Elem(),
    0,
)

fmt.Println(chanValue.Interface())
```

##### 函数

```go
reflect.MakeFunc(typeValue, functionBodyValue)
// typeValue: 函数类型
// functionBodyValue: 用反射值切片接收参数并返回结果
// 返回结果: reflect.Value
```

```go
functionValue := reflect.MakeFunc(
    reflect.TypeOf(new(func(int))).Elem(),
    func(argumentValues []reflect.Value) (resultValues []reflect.Value) {
        for _, argumentValue := range argumentValues {
            fmt.Println(argumentValue.Interface())
        }
        return nil
    },
)

fmt.Println(functionValue.Type())

functionValue.Call([]reflect.Value{
    reflect.ValueOf(1024),
})
// 输出:
// func(int)
// 1024
```

#### 完全相等

`reflect.DeepEqual` 是反射包下提供的一个用于判断两个变量是否完全相等的函数。

```go
reflect.DeepEqual(leftValue, rightValue)
// leftValue: 任意值
// rightValue: 任意值
// 返回结果: 是否完全相等
```

该函数对于每一种基础类型都做了处理，大致规则如下：

- 数组：数组中的每一个元素都完全相等
- 切片：都为 `nil` 时判为完全相等，或者都不为空且长度范围内元素完全相等
- 结构体：所有字段都完全相等
- 映射表：都为 `nil` 时为完全相等，都不为 `nil` 时每一个键所映射的值都完全相等
- 指针：指向同一个元素或指向的元素完全相等
- 接口：接口的具体类型和值都完全相等
- 函数：只有两者都为 `nil` 时才是完全相等，否则就不是完全相等

下面是一些例子。

**切片**

```go
leftValue := make([]int, 100)
rightValue := make([]int, 100)

fmt.Println(reflect.DeepEqual(leftValue, rightValue))
// 输出: true
```

**结构体**

```go
type PersonNode struct {
    Name   string
    Age    int
    Father *PersonNode
}

mikeValue := PersonNode{
    Name:   "mike",
    Age:    39,
    Father: nil,
}

jackValue := PersonNode{
    Name:   "jack",
    Age:    18,
    Father: &mikeValue,
}

tomValue := PersonNode{
    Name:   "tom",
    Age:    18,
    Father: &mikeValue,
}

fmt.Println(reflect.DeepEqual(mikeValue, jackValue))
fmt.Println(reflect.DeepEqual(tomValue, jackValue))
fmt.Println(reflect.DeepEqual(jackValue, jackValue))
// 输出:
// false
// false
// true
```

## 工程化

### 模块

每一个现代语言都会有属于自己的一个成熟的依赖管理工具，例如 Java 的 Gradle，Python 的 Pip，NodeJs 的 Npm 等，一个好的依赖管理工具可以为开发者省去不少时间并且可以提升开发效率。然而 Go 在早期并没有一个成熟的依赖管理解决方案，那时所有的代码都存放在 GOPATH 目录下，对于工程项目而言十分的不友好，版本混乱，依赖难以管理，为了解决这个问题，各大社区开发者百家争鸣，局面一时间混乱了起来，期间也不乏出现了一些佼佼者例如 Vendor，直到 Go1.11 官方终于推出了 Go Mod 这款官方的依赖管理工具，结束了先前的混乱局面，并在后续的更新中不断完善，淘汰掉了曾经老旧的工具。时至今日，在撰写本文时，Go 发行版本已经到了 1.20，在今天几乎所有的 Go 项目都在采用 Go Mod，所以在本文也只会介绍 Go Mod，官方对于 Go 模块也编写了非常细致的文档：[Go Modules Reference](https://go.dev/ref/mod)。

#### [编写模块](https://golang.halfiisland.com/essential/senior/115.module.html#编写模块)

Go Module 本质上是基于 VCS（版本控制系统），当你在下载依赖时，实际上执行的是 VCS 命令，比如`git`，所以如果你想要分享你编写的库，只需要做到以下三点：

- 源代码仓库可公开访问，且 VCS 属于以下的其中之一
  - git
  - hg (Mercurial)
  - bzr (Bazaar)
  - svn
  - fossil
- 是一个符合规范的 go mod 项目
- 符合语义化版本规范

所以你只需要正常使用 VCS 开发，并为你的特定版本打上符合标准的 Tag，其它人就可以通过模块名来下载你所编写的库，下面将通过示例来演示进行模块开发的几个步骤。

示例仓库：[246859/hello: say hello (github.com)](https://github.com/246859/hello)

在开始之前确保你的版本足以完全支持 go mod（go >= 1.17），并且启用了 Go Module，通过如下命令来查看是否开启

```
$ go env GO111MODULE
```

如果未开启，通过如下命令开启用 Go Module

```
$ go env -w GO111MODULE=on
```

[创建](https://golang.halfiisland.com/essential/senior/115.module.html#创建)

首先你需要一个可公网访问的源代码仓库，这个有很多选择，我比较推荐 Github。在上面创建一个新项目，将其取名为 hello，仓库名虽然没有什么特别限制，但建议还是不要使用特殊字符，因为这会影响到模块名。

![img](./assets/202404071341749.png)

创建完成后，可以看到仓库的 URL 是`https://github.com/246859/hello`，对应的 go 模块名就是`github.com/246859/hello`。

![img](./assets/md_1.png)

然后将其克隆到本地，通过`go mod init`命令初始化模块。



```
$ git clone git@github.com:246859/hello.git
Cloning into 'hello'...
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 5 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (5/5), done.

$ cd hello && go mod init github.com/246859/hello
go: creating new go.mod: module github.com/246859/hello
```

##### [编写](https://golang.halfiisland.com/essential/senior/115.module.html#编写)

然后就可以进行开发工作了，它的功能非常简单，只有一个函数



```
// hello.go
package hello

import "fmt"

// Hello returns hello message
func Hello(name string) string {
        if name == "" {
                name = "world"
        }
        return fmt.Sprintf("hello %s!", name)
}
```

顺便写一个测试文件进行单元测试



```
// hello_test.go
package hello_test

import (
        "testing"
        "fmt"
        "github.com/246859/hello"
)

func TestHello(t *testing.T) {
        data := "jack"
        expected := fmt.Sprintf("hello %s!", data)
        result := hello.Hello(data)

        if result != expected {
                t.Fatalf("expected result %s, but got %s", expected, result)
        }

}
```

接下来继续编写一个命令行程序用于输出 hello，它的功能同样非常简单。对于命令行程序而言，按照规范是在项目`cmd/app_name/`中进行创建，所以 hello 命令行程序的文件存放在`cmd/hello/`目录下，然后在其中编写相关代码。



```
// cmd/hello/main.go
package main

import (
  "flag"
  "github.com/246859/hello"
  "os"
)

var name string

func init() {
  flag.StringVar(&name, "name", "world", "name to say hello")
}

func main() {
  flag.Parse()
  msg := hello.Hello(name)
  _, err := os.Stdout.WriteString(msg)
  if err != nil {
    os.Stderr.WriteString(err.Error())
  }
}
```

##### [测试](https://golang.halfiisland.com/essential/senior/115.module.html#测试)

编写完后对源代码格式化并测试



```
$ go fmt && go vet ./...

$ go test -v .
=== RUN   TestHello
--- PASS: TestHello (0.00s)
PASS
ok      github.com/246859/hello 0.023s
```

运行命令行程序



```
$ go run ./cmd/hello -name jack
hello jack!
```

##### [文档](https://golang.halfiisland.com/essential/senior/115.module.html#文档)

最后的最后，需要为这个库编写简洁明了的`README`，让其它开发者看一眼就知道怎么使用



````
# hello

just say hello

## Install

import code

```bash
go get github.com/246859/hello@latest
```

install cmd

```bash
go install github.com/246859/hello/cmd/hello@latest
```

## Example

Here's a simple example as follows:

```go
package main

import (
  "fmt"
  "github.com/246859/hello"
)

func main() {
  result := hello.Hello("jack")
  fmt.Println(result)
}
```
````

这是一个很简单的 README 文档，你也可以自己进行丰富。

##### [上传](https://golang.halfiisland.com/essential/senior/115.module.html#上传)

当一切代码都编写并测试完毕过后，就可以将修改提交并推送到远程仓库。



```
$ git add go.mod hello.go hello_test.go cmd/ example/ README.md

$ git commit -m "chore(mod): mod init" go.mod
[main 5087fa2] chore(mod): mod init
 1 file changed, 3 insertions(+)
 create mode 100644 go.mod

$ git commit -m "feat(hello): complete Hello func" hello.go
[main 099a8bf] feat(hello): complete Hello func
 1 file changed, 11 insertions(+)
 create mode 100644 hello.go

$ git commit -m "test(hello): complete hello testcase" hello_test.go
[main 76e8c1e] test(hello): complete hello testcase
 1 file changed, 17 insertions(+)
 create mode 100644 hello_test.go

$ git commit -m "feat(hello): complete hello cmd" cmd/hello/
[main a62a605] feat(hello): complete hello cmd
 1 file changed, 22 insertions(+)
 create mode 100644 cmd/hello/main.go

$ git commit -m "docs(example): add hello example" example/
[main 5c51ce4] docs(example): add hello example
 1 file changed, 11 insertions(+)
 create mode 100644 example/main.go

$ git commit -m "docs(README): update README" README.md
[main e6fbc62] docs(README): update README
 1 file changed, 27 insertions(+), 1 deletion(-)
```

总共六个提交并不多，提交完毕后为最新提交创建一个 tag



```
$ git tag v1.0.0

$ git tag -l
v1.0.0

$ git log --oneline
e6fbc62 (HEAD -> main, tag: v1.0.0, origin/main, origin/HEAD) docs(README): update README
5c51ce4 docs(example): add hello example
a62a605 feat(hello): complete hello cmd
76e8c1e test(hello): complete hello testcase
099a8bf feat(hello): complete Hello func
5087fa2 chore(mod): mod init
1f422d1 Initial commit
```

最后再推送到远程仓库



```
$ git push --tags
Enumerating objects: 23, done.
Counting objects: 100% (23/23), done.
Delta compression using up to 16 threads
Compressing objects: 100% (17/17), done.
Writing objects: 100% (21/21), 2.43 KiB | 1.22 MiB/s, done.
Total 21 (delta 5), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (5/5), done.
To github.com:246859/hello.git
   1f422d1..e6fbc62    main -> main
  * [new tag]         v1.0.0 -> v1.0.0
```

推送完毕后，再为其创建一个 release（有一个 tag 就足矣，release 只是符合 github 规范）

![img](./assets/md_2.png)

如此一来，模块的编写就完成了，以上就是模块开发的一个基本流程，其它开发者便可以通过模块名来引入代码或安装命令行工具。

##### [引用](https://golang.halfiisland.com/essential/senior/115.module.html#引用)

通过`go get`引用库



```
$ go get github.com/246859/hello@latest
go: downloading github.com/246859/hello v1.0.0
go: added github.com/246859/hello v1.0.0
```

通过`go intall`安装命令行程序



```
$ go install github.com/246859/hello/cmd/hello@latest && hello -name jack
hello jack!
```

或者使用`go run`直接运行



```
$ go run -mod=mod github.com/246859/hello/cmd/hello -name jack
hello jack!
```

当一个库被引用过后，[Go Package](https://pkg.go.dev/)便会为其创建一个页面，这个过程是自动完成的，不需要开发者做什么工作，比如 hello 库就有一个专属的文档页面，如下图所示。

![img](./assets/md_3.png)

关于上传模块的更多详细信息，前往[Add a package](https://pkg.go.dev/about#adding-a-package)。

关于如何删除模块的信息，前往[Removing a package](https://pkg.go.dev/about#removing-a-package)。

#### [设置代理](https://golang.halfiisland.com/essential/senior/115.module.html#设置代理)

Go 虽然没有像 Maven Repo，PyPi，NPM 这样类似的中央仓库，但是有一个官方的代理仓库：[Go modules services (golang.org)](https://proxy.golang.org/)，它会根据版本及模块名缓存开发者下载过的模块。不过由于其服务器部署在国外，访问速度对于国内的用户不甚友好，所以我们需要修改默认的模块代理地址，目前国内做的比较好的有以下几家：

- [GOPROXY.IO - 一个全球代理 为 Go 模块而生](https://goproxy.io/zh/)
- [七牛云 - Goproxy.cn](https://goproxy.cn/)

![img](./assets/md_4.png)

这里选择七牛云的代理，执行如下命令来修改 Go 代理，其中的`direct`表示代理下载失败后绕过代理缓存直接访问源代码仓库。



```
$ go env -w GOPROXY=https://goproxy.cn,direct
```

代理修改成功后，日后下载依赖就会非常的迅速。

#### [下载依赖](https://golang.halfiisland.com/essential/senior/115.module.html#下载依赖)

修改完代理后，接下来安装一个第三方依赖试试，Go 官方有专门的依赖查询网站：[Go Packages](https://pkg.go.dev/)。

##### [代码引用](https://golang.halfiisland.com/essential/senior/115.module.html#代码引用)

在里面搜索著名的 Web 框架`Gin`。

![img](./assets/md_5.png)

这里会出现很多搜索结果，在使用第三方依赖时，需要结合引用次数和更新时间来决定是否采用该依赖，这里直接选择第一个

![img](./assets/md_6.png)

进入对应的页面后，可以看出这是该依赖的一个文档页面，有着非常多关于它的详细信息，后续查阅文档时也可以来这里。

![img](./assets/md_7.png)

这里只需要将它的地址复制下来，然后在之前创建的项目下使用`go get`命令，命令如下



```
$ go get github.com/gin-gonic/gin
```

过程中会下载很多的依赖，只要没有报错就说明下载成功。



```
$ go get github.com/gin-gonic/gin
go: added github.com/bytedance/sonic v1.8.0
go: added github.com/chenzhuoyu/base64x v0.0.0-20221115062448-fe3a3abad311
go: added github.com/gin-contrib/sse v0.1.0
go: added github.com/gin-gonic/gin v1.9.0
go: added github.com/go-playground/locales v0.14.1
go: added github.com/go-playground/universal-translator v0.18.1
go: added github.com/go-playground/validator/v10 v10.11.2
go: added github.com/goccy/go-json v0.10.0
go: added github.com/json-iterator/go v1.1.12
go: added github.com/klauspost/cpuid/v2 v2.0.9
go: added github.com/leodido/go-urn v1.2.1
go: added github.com/mattn/go-isatty v0.0.17
go: added github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421
go: added github.com/modern-go/reflect2 v1.0.2
go: added github.com/pelletier/go-toml/v2 v2.0.6
go: added github.com/twitchyliquid64/golang-asm v0.15.1
go: added github.com/ugorji/go/codec v1.2.9
go: added golang.org/x/arch v0.0.0-20210923205945-b76863e36670
go: added golang.org/x/crypto v0.5.0
go: added golang.org/x/net v0.7.0
go: added golang.org/x/sys v0.5.0
go: added golang.org/x/text v0.7.0
go: added google.golang.org/protobuf v1.28.1
go: added gopkg.in/yaml.v3 v3.0.1
```

完成后查看`go.mod`文件



```
$ cat go.mod
module golearn

go 1.20

require github.com/gin-gonic/gin v1.9.0

require (
  github.com/bytedance/sonic v1.8.0 // indirect
  github.com/chenzhuoyu/base64x v0.0.0-20221115062448-fe3a3abad311 // indirect
  github.com/gin-contrib/sse v0.1.0 // indirect
  github.com/go-playground/locales v0.14.1 // indirect
  github.com/go-playground/universal-translator v0.18.1 // indirect
  github.com/go-playground/validator/v10 v10.11.2 // indirect
  github.com/goccy/go-json v0.10.0 // indirect
  github.com/json-iterator/go v1.1.12 // indirect
  github.com/klauspost/cpuid/v2 v2.0.9 // indirect
  github.com/leodido/go-urn v1.2.1 // indirect
  github.com/mattn/go-isatty v0.0.17 // indirect
  github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421 // indirect
  github.com/modern-go/reflect2 v1.0.2 // indirect
  github.com/pelletier/go-toml/v2 v2.0.6 // indirect
  github.com/twitchyliquid64/golang-asm v0.15.1 // indirect
  github.com/ugorji/go/codec v1.2.9 // indirect
  golang.org/x/arch v0.0.0-20210923205945-b76863e36670 // indirect
  golang.org/x/crypto v0.5.0 // indirect
  golang.org/x/net v0.7.0 // indirect
  golang.org/x/sys v0.5.0 // indirect
  golang.org/x/text v0.7.0 // indirect
  google.golang.org/protobuf v1.28.1 // indirect
  gopkg.in/yaml.v3 v3.0.1 // indirect
)
```

可以发现相较于之前多了很多东西，同时也会发现目录下多了一个名为`go.sum`的文件



```
$ ls
go.mod  go.sum  main.go
```

这里先按下不表，修改`main.go`文件如下代码：



```
package main

import (
  "github.com/gin-gonic/gin"
)

func main() {
  gin.Default().Run()
}
```

再次运行项目



```
$ go run golearn
[GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.

[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:   export GIN_MODE=release
 - using code:  gin.SetMode(gin.ReleaseMode)

[GIN-debug] [WARNING] You trusted all proxies, this is NOT safe. We recommend you to set a value.
Please check https://pkg.go.dev/github.com/gin-gonic/gin#readme-don-t-trust-all-proxies for details.
[GIN-debug] Environment variable PORT is undefined. Using port :8080 by default
[GIN-debug] Listening and serving HTTP on :8080
```

于是，通过一行代码就运行起了一个最简单的 Web 服务器。当不再需要某一个依赖时，也可以使用`go get`命令来删除该依赖，这里以删除 Gin 为例子



```
$ go get github.com/gin-gonic/gin@none
go: removed github.com/gin-gonic/gin v1.9.0
```

在依赖地址后面加上`@none`即可删除该依赖，结果也提示了删除成功，此时再次查看`go.mod`文件会发现没有了 Gin 依赖。



```
$ cat go.mod | grep github.com/gin-gonic/gin
```

当需要升级最新版本时，可以加上`@latest`后缀，或者可以自行查询可用的 Release 版本号



```
$ go get -u github.com/gin-gonic/gin@latest
```

##### [安装命令行](https://golang.halfiisland.com/essential/senior/115.module.html#安装命令行)

`go install`命令会将第三方依赖下载到本地并编译成二进制文件，得益于 go 的编译速度，这一过程通常不会花费太多时间，然后 go 会将其存放在`$GOPATH/bin`或者`$GOBIN`目录下，以便在全局可以执行该二进制文件（前提是你将这些路径添加到了环境变量中）。

提示

在使用`install`命令时，必须指定版本号。

例如下载由 go 语言编写的调试器`delve`



```
$ go install github.com/go-delve/delve/cmd/dlv@latest
go: downloading github.com/go-delve/delve v1.22.1
go: downloading github.com/cosiner/argv v0.1.0
go: downloading github.com/derekparker/trie v0.0.0-20230829180723-39f4de51ef7d
go: downloading github.com/go-delve/liner v1.2.3-0.20231231155935-4726ab1d7f62
go: downloading github.com/google/go-dap v0.11.0
go: downloading github.com/hashicorp/golang-lru v1.0.2
go: downloading golang.org/x/arch v0.6.0
go: downloading github.com/cpuguy83/go-md2man/v2 v2.0.2
go: downloading go.starlark.net v0.0.0-20231101134539-556fd59b42f6
go: downloading github.com/cilium/ebpf v0.11.0
go: downloading github.com/mattn/go-runewidth v0.0.13
go: downloading github.com/russross/blackfriday/v2 v2.1.0
go: downloading github.com/rivo/uniseg v0.2.0
go: downloading golang.org/x/exp v0.0.0-20230224173230-c95f2b4c22f2

$ dlv -v
Error: unknown shorthand flag: 'v' in -v
Usage:
  dlv [command]

Available Commands:
  attach      Attach to running process and begin debugging.
  completion  Generate the autocompletion script for the specified shell
  connect     Connect to a headless debug server with a terminal client.
  core        Examine a core dump.
  dap         Starts a headless TCP server communicating via Debug Adaptor Protocol (DAP).
  debug       Compile and begin debugging main package in current directory, or the package specified.
  exec        Execute a precompiled binary, and begin a debug session.
  help        Help about any command
  test        Compile test binary and begin debugging program.
  trace       Compile and begin tracing program.
  version     Prints version.

Additional help topics:
  dlv backend    Help about the --backend flag.
  dlv log        Help about logging flags.
  dlv redirect   Help about file redirection.

Use "dlv [command] --help" for more information about a command.
```

#### [模块管理](https://golang.halfiisland.com/essential/senior/115.module.html#模块管理)

上述所有的内容都只是在讲述 Go Mod 的基本使用，但事实上要学会 Go Mod 仅仅只有这些是完全不够的。官方对于模块的定义为：一组被版本标记的包集合。上述定义中，包应该是再熟悉不过的概念了，而版本则是要遵循语义化版本号，定义为：`v(major).(minor).(patch)`的格式，例如 Go 的版本号`v1.20.1`，主版本号是 1，小版本号是 20，补丁版本是 1，合起来就是`v1.20.1`，下面是详细些的解释：

- `major`：当 major 版本变化时，说明项目发生了不兼容的改动，老版本的项目升级到新版本大概率没法正常运行。
- `minor`：当`minor`版本变化时，说明项目增加了新的特性，只是先前版本的基础只是增加了新的功能。
- `patch`：当`patch`版本发生变化时，说明只是有 bug 被修复了，没有增加任何新功能。

##### [常用命令](https://golang.halfiisland.com/essential/senior/115.module.html#常用命令)

| 命令                 | 说明                       |
| -------------------- | -------------------------- |
| `go mod download`    | 下载当前项目的依赖包       |
| `go mod edit`        | 编辑 go.mod 文件           |
| `go mod graph`       | 输出模块依赖图             |
| `go mod init`        | 在当前目录初始化 go mod    |
| `go mod tidy`        | 清理项目模块               |
| `go mod verify`      | 验证项目的依赖合法性       |
| `go mod why`         | 解释项目哪些地方用到了依赖 |
| `go clean -modcache` | 用于删除项目模块依赖缓存   |
| `go list -m`         | 列出模块                   |

前往[go mod cmd](https://golang.halfiisland.com/cmd.html#mod)了解命令的更多有关信息

##### [模块存储](https://golang.halfiisland.com/essential/senior/115.module.html#模块存储)

当使用 Go Mod 进行项目管理时，模块缓存默认存放在`$GOPATH/pkg/mod`目录下，也可以修改`$GOMODCACHE`来指定存放在另外一个位置。



```
$ go env -w GOMODCACHE=你的模块缓存路径
```

同一个机器上的所有 Go Module 项目共享该目录下的缓存，缓存没有大小限制且不会自动删除，在缓存中解压的依赖源文件都是只读的，想要清空缓存可以执行如下命令。



```
$ go clean -modcache
```

在`$GOMODCACHE/cache/download`目录下存放着依赖的原始文件，包括哈希文件，原始压缩包等，如下例：



```
$ ls $(go env GOMODCACHE)/cache/download/github.com/246859/hello/@v -1
list
v1.0.0.info
v1.0.0.lock
v1.0.0.mod
v1.0.0.zip
v1.0.0.ziphash
```

解压过后的依赖组织形式如下所示，就是指定模块的源代码。



```
$ ls $(go env GOMODCACHE)/github.com/246859/hello@v1.0.0 -1
LICENSE
README.md
cmd/
example/
go.mod
hello.go
hello_test.go
```

##### [版本选择](https://golang.halfiisland.com/essential/senior/115.module.html#版本选择)

Go 在依赖版本选择时，遵循**最小版本选择原则**。下面是一个官网给的例子，主模块引用了模块 A 的 1.2 版本和模块 B 的 1.2 版本，同时模块 A 的 1.2 版本引用了模块 C 的 1.3 版本，模块 B 的 1.2 版本引用了模块 C 的 1.4 版本，并且模块 C 的 1.3 和 1.4 版本都同时引用了模块 D 的 1.2 版本，根据最小可用版本原则，Go 最终会选择的版本是 A1.2，B1.2，C1.4 和 D1.2。其中淡蓝色的表示`go.mod`文件加载的，框选的表示最终选择的版本。

![img](./assets/md_8.svg)

官网中还给出了[其他几个例子](https://go.dev/ref/mod#minimal-version-selection)，大体意思都差不多。

##### [go.mod](https://golang.halfiisland.com/essential/senior/115.module.html#go-mod)

每创建一个 Go Mod 项目都会生成一个`go.mod`文件，因此熟悉`go.mod`文件是非常有必要的，不过大部分情况并不需要手动的修改`go.mod`文件。



```
module golearn

go 1.20

require github.com/gin-gonic/gin v1.9.0

require (
   github.com/bytedance/sonic v1.8.0 // indirect
   github.com/chenzhuoyu/base64x v0.0.0-20221115062448-fe3a3abad311 // indirect
   github.com/gin-contrib/sse v0.1.0 // indirect
   github.com/go-playground/locales v0.14.1 // indirect
   github.com/go-playground/universal-translator v0.18.1 // indirect
   github.com/go-playground/validator/v10 v10.11.2 // indirect
   github.com/goccy/go-json v0.10.0 // indirect
   github.com/json-iterator/go v1.1.12 // indirect
   github.com/klauspost/cpuid/v2 v2.0.9 // indirect
   github.com/leodido/go-urn v1.2.1 // indirect
   github.com/mattn/go-isatty v0.0.17 // indirect
   github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421 // indirect
   github.com/modern-go/reflect2 v1.0.2 // indirect
   github.com/pelletier/go-toml/v2 v2.0.6 // indirect
   github.com/twitchyliquid64/golang-asm v0.15.1 // indirect
   github.com/ugorji/go/codec v1.2.9 // indirect
   golang.org/x/arch v0.0.0-20210923205945-b76863e36670 // indirect
   golang.org/x/crypto v0.5.0 // indirect
   golang.org/x/net v0.7.0 // indirect
   golang.org/x/sys v0.5.0 // indirect
   golang.org/x/text v0.7.0 // indirect
   google.golang.org/protobuf v1.28.1 // indirect
   gopkg.in/yaml.v3 v3.0.1 // indirect
)
```

在文件中可以发现绝大多数的依赖地址都带有`github`等字眼，这是因为 Go 并没有一个公共的依赖仓库，大部分开源项目都是在托管在 Gitub 上的，也有部分的是自行搭建仓库，例如`google.golang.org/protobuf`，`golang.org/x/crypto`。通常情况下，这一串网址同时也是 Go 项目的模块名称，这就会出现一个问题，URL 是不分大小写的，但是存储依赖的文件夹是分大小写的，所以`go get github.com/gin-gonic/gin`和`go get github.com/gin-gonic/Gin`两个引用的是同一个依赖但是本地存放的路径不同。发生这种情况时，Go 并不会直接把大写字母当作存放路径，而是会将其转义为`!小写字母`，比如`github.com\BurntSushi`最终会转义为`github.com\!burnt!sushi`。

**module**

`module`关键字声明了当前项目的模块名，一个`go.mod`文件中只能出现一个`module`关键字。例子中的



```
module golearn
```

代表着当前模块名为`golearn`，例如打开 Gin 依赖的`go.mod`文件可以发现它的`module`名



```
module github.com/gin-gonic/gin
```

Gin 的模块名就是下载依赖时使用的地址，这也是通常而言推荐模块名格式，`域名/用户/仓库名`。

提示

有一个需要注意的点是，当主版本大于 1 时，主版本号要体现在模块名中，例如



```
github.com/my/example
```

如果版本升级到了 v2.0.0，那么模块名就需要修改成如下



```
github.com/my/example/v2
```

如果原有项目引用了老版本，且新版本不加以区分的话，在引用依赖时由于路径都一致，所以使用者并不能区分主版本变化所带来的不兼容变动，这样就可能会造成程序错误。

**Deprecation**

在`module`的上一行开头注释`Deprecated`来表示该模块已弃用，例如



```
// Deprecated: use example.com/mod/v2 instead.
module example.com/mod
```

**go**

`go`关键字表示了当前编写当前项目所用到的 Go 版本，版本号必须遵循语义化规则，根据 go 版本的不同，Go Mod 会表现出不同的行为，下方是一个简单示例，关于 Go 可用的版本号自行前往官方查阅。



```
go 1.20
```

**require**

`require`关键字表示引用了一个外部依赖，例如



```
require github.com/gin-gonic/gin v1.9.0
```

格式是`require 模块名 版本号`，有多个引用时可以使用括号括起来



```
require (
   github.com/bytedance/sonic v1.8.0 // indirect
)
```

带有`// indirect`注释的表示该依赖没有被当前项目直接引用，可能是项目直接引用的依赖引用了该依赖，所以对于当前项目而言就是间接引用。前面提到过主板变化时要体现在模块名上，如果不遵循此规则的模块被称为不规范模块，在`require`时，就会加上 incompatible 注释。



```
require example.com/m v4.1.2+incompatible
```

**伪版本**

在上面的`go.mod`文件中，可以发现有一些依赖包的版本并不是语义化的版本号，而是一串不知所云的字符串，这其实是对应版本的 CommitID，语义化版本通常指的是某一个 Release。伪版本号则可以细化到指定某一个 Commit，通常格式为`vx.y.z-yyyyMMddHHmmss-CommitId`，由于其`vx.y.z`并不一定真实存在，所以称为伪版本，例如下面例子中的`v0.0.0`并不存在，真正有效的是其后的 12 位 CommitID。



```
// CommitID一般取前12位
github.com/chenzhuoyu/base64x v0.0.0-20221115062448-fe3a3abad311 // indirect
```

同理，在下载依赖时也可以指定 CommitID 替换语义化版本号



```
go get github.com/chenzhuoyu/base64x@fe3a3abad311
```

**exclude**

`exclude`关键字表示了不加载指定版本的依赖，如果同时有`require`引用了相同版本的依赖，也会被忽略掉。该关键字仅在主模块中才生效。例如



```
exclude golang.org/x/net v1.2.3

exclude (
    golang.org/x/crypto v1.4.5
    golang.org/x/text v1.6.7
)
```

**replace**

`replace`将会替换掉指定版本的依赖，可以使用模块路径和版本替换又或者是其他平台指定的文件路径，例子



```
replace golang.org/x/net v1.2.3 => example.com/fork/net v1.4.5

replace (
    golang.org/x/net v1.2.3 => example.com/fork/net v1.4.5
    golang.org/x/net => example.com/fork/net v1.4.5
    golang.org/x/net v1.2.3 => ./fork/net
    golang.org/x/net => ./fork/net
)
```

仅`=>`左边的版本被替换，其他版本的同一个依赖照样可以正常访问，无论是使用本地路径还是模块路径指定替换，如果替换模块具有 `go.mod `文件，则其`module`指令必须与所替换的模块路径匹配。

**retract**

`retract`指令表示，不应该依赖`retract`所指定依赖的版本或版本范围。例如在一个新的版本发布后发现了一个重大问题，这个时候就可以使用`retract`指令。

撤回一些版本



```
retract (
    v1.0.0 // Published accidentally.
    v1.0.1 // Contains retractions only.
)
```

撤回版本范围



```
retract v1.0.0
retract [v1.0.0, v1.9.9]
retract (
    v1.0.0
    [v1.0.0, v1.9.9]
)
```

##### [go.sum](https://golang.halfiisland.com/essential/senior/115.module.html#go-sum)

`go.sum`文件在创建项目之初并不会存在，只有在真正引用了外部依赖后，才会生成该文件，`go.sum`文件并不适合人类阅读，也不建议手动修改该文件。它的作用主要是解决一致性构建问题，即不同的人在不同的环境中使用同一个的项目构建时所引用的依赖包必须是完全相同的，这单单靠一个`go.mod`文件是无法保证的。

接下来看看下载一个依赖时，Go 从头到尾都做了些什么事，首先使用如下命令下载一个依赖



```
go get github.com/bytedance/sonic v1.8.0
```

go get 命令首先会将依赖包下载到本地的缓存目录中，通常该目录为`$GOMODCACHE/cache/download/`，该目录根据域名来划分不同网站的依赖包，所以你可能会看到如下的目录结构



```
$ ls
cloud.google.com/      go.opencensus.io/     gopkg.in/          nhooyr.io/
dmitri.shuralyov.com/  go.opentelemetry.io/  gorm.io/           rsc.io/
github.com/            go.uber.org/          honnef.co/         sumdb/
go.etcd.io/            golang.org/           lukechampine.com/
go.mongodb.org/        google.golang.org/    modernc.org/
```

那么上例中下载的依赖包存放的路径就位于



```
$GOMODCACHE/cache/download/github.com/bytedance/sonic/@v/
```

可能的目录结构如下，会有好几个版本命名的文件



```
$ ls
list         v1.8.0.lock  v1.8.0.ziphash  v1.8.3.mod
v1.5.0.mod   v1.8.0.mod   v1.8.3.info     v1.8.3.zip
v1.8.0.info  v1.8.0.zip   v1.8.3.lock     v1.8.3.ziphash
```

通常情况下，该目录下一定有一个`list`文件，用于记录该依赖已知的版本号，而对于每一个版本而言，都会有如下的文件：

- `zip`：依赖的源码压缩包
- `ziphash`：根据依赖压缩包所计算出的哈希值
- `info`：json 格式的版本元数据
- `mod`：该版本的`go.mod`文件
- `lock`：临时文件，官方也没说干什么用的

一般情况下，Go 会计算压缩包和`go.mod`两个文件的哈希值，然后再根据 GOSUMDB 所指定的服务器（默认是 sum.golang.org）查询该依赖包的哈希值，如果本地计算出的哈希值与查询得到的结果不一致，那么就不会再向下执行。如果一致的话，就会更新`go.mod`文件，并向`go.sum`文件插入两条记录，大致如下：



```
github.com/bytedance/sonic v1.8.0 h1:ea0Xadu+sHlu7x5O3gKhRpQ1IKiMrSiHttPF0ybECuA=
github.com/bytedance/sonic v1.8.0/go.mod h1:i736AoUSYt75HyZLoJW9ERYxcy6eaN6h4BZXU064P/U=
```

提示

假如禁用了 GOSUMDB，Go 会直接将本地计算得到的哈希值写入`go.sum`文件中，一般不建议这么做。

正常情况下每一个依赖都会有两条记录，第一个是压缩包的哈希值，第二个是依赖包的`go.mod`文件的哈希值，记录格式为`模块名 版本号 算法名称:哈希值`，有些比较古老的依赖包可能没有`go.mod`文件，所以就不会有第二条哈希记录。当这个项目在另一个人的环境中构建时，Go 会根据`go.mod`中指定的本地依赖计算哈希值，再与`go.sum`中记录的哈希值进行比对，如果哈希值不一致，则说明依赖版本不同，就会拒绝构建。发生这种情况时，本地依赖和`go.sum`文件都有可能被修改过，但是由于`go.sum`是经过 GOSUMDB 查询记录的，所以会倾向于更相信`go.sum`文件。

#### [私有模块](https://golang.halfiisland.com/essential/senior/115.module.html#私有模块)

Go Mod 大多数工具都是针对开源项目而言的，不过 Go 也对私有模块进行了支持。对于私有项目而言，通常情况下需要配置以下几个环境配置来进行模块私有处理

- `GOPROXY` ：依赖的代理服务器集合
- `GOPRIVATE` ：私有模块的模块路径前缀的通用模式列表，如果模块名符合规则表示该模块为私有模块，具体行为与 GONOPROXY 和 GONOSUMDB 一致。
- `GONOPROXY` ：不从代理中下载的模块路径前缀的通用模式列表，如果符合规则在下载模块时不会走 GOPROXY，尝试直接从版本控制系统中下载。
- `GONOSUMDB` ：不进行 GOSUMDB 公共校验的模块路径前缀的通用模式列表，如果符合在下载模块校验时不会走 checksum 的公共数据库。
- `GOINSECURE` ：可以通过 HTTP 和其他不安全协议检索的模块路径前缀的通用模式列表。

#### [工作区](https://golang.halfiisland.com/essential/senior/115.module.html#工作区)

前面提到了`go.mod`文件支持`replace`指令，这使得我们可以暂时使用一些本地来不及发版的修改，如下所示



```
replace (
  github.com/246859/hello v1.0.1 => ./hello
)
```

在编译时，go 就会使用本地的 hello 模块，在日后发布新版本后再将其去掉。

但如果使用了 `replace`指令的话会修改`go.mod`文件的内容，并且该修改可能会被误提交到远程仓库中，这一点是我们不希望看到的，因为`replace`指令所指定的 target 是一个文件路径而非网络 URL，这台机器上能用的路径可能到另一台机器上就不能用了，文件路径在跨平台方面也会是一个大问题。为了解决这类问题，工作区便应运而生。

工作区(workspace)，是 Go 在 1.18 引入的关于多模块管理的一个新的解决方案，旨在更好的进行本地的多模块开发工作，下面将通过一个示例进行讲解。

示例仓库：[246859/work: go work example (github.com)](https://github.com/246859/work)

##### [示例](https://golang.halfiisland.com/essential/senior/115.module.html#示例)

首先项目下有两个独立的 go 模块，分别是`auth`，`user`



```
$ ls -1
LICENSE
README.md
auth
go.work
user
```

`auth`模块依赖于`user`模块的结构体`User`，内容如下



```
package auth

import (
  "errors"
  "github.com/246859/work/user"
)

// Verify user credentials if is ok
func Verify(user user.User) (bool, error) {
  password, err := query(user.Name)
  if err != nil {
    return false, err
  }
  if password != user.Password {
    return false, errors.New("authentication failed")
  }
  return true, nil
}

func query(username string) (string, error) {
  if username == "jack" {
    return "jack123456", nil
  }
  return "", errors.New("user not found")
}
```

user 模块内容如下



```
package user

type User struct {
  Name     string
  Password string
  Age      int
}
```

在这个项目中，我们可以这样编写`go.work`文件



```
go 1.22

use (
  ./auth
  ./user
)
```

其内容非常容易理解，使用`use`指令，指定哪些模块参与编译，接下来运行 auth 模块中的代码



```
// auth/example/main.go
package main

import (
  "fmt"
  "github.com/246859/work/auth"
  "github.com/246859/work/user"
)

func main() {
  ok, err := auth.Verify(user.User{Name: "jack", Password: "jack123456"})
  if err != nil {
    panic(err)
  }
  fmt.Printf("%v", ok)
}
```

运行如下命令，通过结果得知成功导入了模块。



```
$ go run ./auth/example
true
```

在以前的版本，对于这两个独立的模块，如果 auth 模块想要使用 user 模块中的代码只有两种办法

1. 提交 user 模块的修改并推送到远程仓库，发布新版本，然后修改`go.mod`文件为指定版本
2. 修改`go.mod`文件将依赖重定向到本地文件

两种方法都需要修改`go.mod`文件，而工作区的存在就是为了能够在不修改`go.mod`文件的情况下导入其它模块。不过需要明白的一点是，`go.work`文件仅用在开发过程中，它的存在只是为了更加方便的进行本地开发，而不是进行依赖管理，它只是暂时让你略过了提交到发版的这一过程，可以让你马上使用 user 模块的新修改而无需进行等待，当 user 模块测试完毕后，最后依旧需要发布新版本，并且 auth 模块最后仍然要修改`go.mod`文件引用最新版本（这一过程可以用`go work sync`命令来完成），因此在正常的 go 开发过程中，`go.work`也不应该提交到 VCS 中（示例仓库中的`go.work`仅用于演示），因为其内容都是依赖于本地的文件，且其功能也仅限于本地开发。

##### [命令](https://golang.halfiisland.com/essential/senior/115.module.html#命令)

下面是一些工作区的命令

| 命令   | 介绍                           |
| ------ | ------------------------------ |
| edit   | 编辑`go.work`                  |
| init   | 初始化一个新的工作区           |
| sync   | 同步工作区的模块依赖           |
| use    | 往`go.work`中添加一个新模块    |
| vendor | 将依赖按照 vendor 格式进行复制 |

前往[go work cmd](https://golang.halfiisland.com/cmd.html#work)了解命令的更多有关信息

##### [指令](https://golang.halfiisland.com/essential/senior/115.module.html#指令)

`go.work`文件的内容很简单，只有三个指令

- `go`，指定 go 版本
- `use`，指定使用的模块
- `replace`，指定替换的模块

除了`use`指令外，其它两个基本上等同于`go.mod`中的指令，只不过`go.work`中的的`replace`指令会作用于所有的模块，一个完整的`go.work`如下所示。

```
go 1.22

use(
  ./auth
  ./user
)

repalce github.com/246859/hello v1.0.0 => /home/jack/code/hello
```

### Go 工具链

Go 自带了一套完整的工具链，用来完成**运行、构建、安装、格式化、检查、查看文档、列出包信息**等工作。  
这些工具通常都通过 `go` 命令统一调用。

常见命令包括：`go run`、`go build`、`go install`、`go clean`、`go fmt`、`go vet`、`go doc`、`go list`

####  `go run`

`go run` 用于**直接运行 Go 程序**。  
它会先临时编译代码，再立即执行，但通常不会把最终可执行文件保留下来。

```bash
go run main.go
```

如果当前目录下是一个完整的 Go 模块项目，也常见这样写：

```bash
go run .
```

这里的 `.` 表示当前包。

`go run` 更强调“运行”，不是“产出构建结果”。  
如果你需要得到一个真正的可执行文件，应该使用 `go build`。

#### `go build`

`go build` 用于**编译 Go 程序**。  
它会把源码编译成可执行文件或编译结果，但不会像 `go run` 那样直接执行。

```bash
go build
```

或者：

```bash
go build main.go
```

也可以指定输出文件名：

```bash
go build -o app
```

如果当前目录是 `main` 包，执行后通常会生成一个可执行文件。  
如果不是 `main` 包，则主要是检查和生成编译结果，而不会得到可直接运行的程序。

---

#### `go install`

`go install` 用于**编译并安装 Go 程序**。  
它会把生成的可执行文件安装到 Go 的可执行目录中，方便以后直接在命令行使用。

```bash
go install
```

也可以安装指定路径的包：

```bash
go install 包路径
```

例如：

```bash
go install github.com/example/tool
```

安装自己写的命令行程序安装第三方 Go 工具。让可执行文件进入统一的安装位置

安装后，可执行文件通常会进入：

- `GOBIN` 指定的目录
- 如果未设置 `GOBIN`，则通常进入 `GOPATH/bin`

####  `go clean`

`go clean` 用于**清理构建过程中产生的文件**。

```bash
go clean
```

删除编译生成的目标文件；清理缓存结果；清理模块缓存中的内容

```bash
go clean -cache
```

清理构建缓存。

```bash
go clean -modcache
```

清理模块下载缓存。

```bash
go clean -testcache
```

清理测试缓存。

当你怀疑缓存导致结果异常，或者想让项目回到较干净的状态时，可以使用 `go clean`。

#### `go fmt`

`go fmt` 用于**格式化 Go 代码**。  
它会按照 Go 官方统一的代码风格自动调整源码格式。

```bash
go fmt
```

也可以格式化当前项目下的多个包：

```bash
go fmt ./...
```

自动整理缩进；调整空格与换行；统一代码风格；减少风格争议

Go 非常强调统一代码风格，`go fmt` 是 Go 开发中的基础工具之一。  
通常写完代码后都应该运行一次格式化。

Go 社区普遍遵循同一套格式规则，因此很多时候不需要花太多时间讨论代码排版问题。

#### `go vet`

`go vet` 用于**检查代码中可疑的写法**。  
它不是编译器，也不是传统意义上的语法检查器，而是一个更偏向“静态分析”的工具。

```bash
go vet
```

也可以检查整个项目：

```bash
go vet ./...
```

它会帮助发现一些虽然能编译通过，但可能存在问题的代码，例如：

- `Printf` 格式化参数与占位符不匹配
- 某些结构体标签写法异常
- 不合理的代码模式
- 一些潜在逻辑问题

`go vet` 不保证找出所有错误，但它能帮助提前发现一部分隐藏问题。  
因此在工程实践中，`go vet` 常作为基础检查步骤之一。

####  `go doc`

`go doc` 用于**查看 Go 包、类型、函数、方法等的文档信息**。

查看某个包：

```bash
go doc fmt
```

查看某个函数：

```bash
go doc fmt.Println
```

查看某个类型：

```bash
go doc time.Time
```

快速查看标准库文档；查询函数用途；查看类型定义；查看方法列表

学习 Go 标准库时，`go doc` 非常实用。  
它可以直接在命令行中查看文档，不必每次都打开网页。

#### `go list`

`go list` 用于**列出包、模块或依赖的相关信息**。

```bash
go list
```

列出当前包：

```bash
go list .
```

列出当前模块下所有包：

```bash
go list ./...
```

查看当前项目有哪些包；获取依赖信息；配合脚本或自动化工具使用；查询模块和包的路径信息

`go list` 更偏向“查询信息”的工具。  
在日常手动开发中，它不如 `go run`、`go build` 那么常用，但在工程自动化、脚本处理、依赖分析中很有价值。

### 测试

对于开发者而言，良好的测试可以提前发现程序的中错误，避免后续因维护不及时产生 Bug 而造成的心智负担，所以写好测试非常有必要。Go 在测试这一方面提供了非常简便实用的命令行工具`go test`，在标准库和许多开源框架都能看到测试的身影，该工具使用起来十分方便，目前支持以下几种测试：

- 示例测试
- 单元测试
- 基准测试
- 模糊测试

在 Go 中大部分的 API 都是由标准库`testing`提供。

提示

在命令行中执行`go help testfunc`命令，可看 Go 官方对于上面四种测试类型的解释。

#### [编写规范](https://golang.halfiisland.com/essential/senior/120.test.html#编写规范)

在开始编写测试之前，首先需要注意几点规范，这样在后续的学习中会更加方便。

- 测试包：测试文件最好单独放在一个包中，这个包通常命名为`test`。
- 测试文件：测试文件通常以`_test.go`结尾，例如要测试某一个功能，就将其命名为`function_test.go`，如果想根据测试类型再划分的更细一些也可以将测试类型为作为文件前缀，例如`benchmark_marshaling_test.go`，或者`example_marshaling_test.go`。
- 测试函数：每一个测试文件中都会有若干个测试函数用于不同的测试。对于不同的测试类型，测试函数的命名的风格也不同。例如示例测试是`ExampleXXXX`，单元测试是`TestXXXX`，基准测试是`BenchmarkXXXX`，模糊测试是`FuzzXXXX`，这样一来即便不需要注释也可以知晓这是什么类型的测试。

提示

当包名为`testdata`时，该包通常是为了存储用于测试的辅助数据，在执行测试时，Go 会忽略名为`testdata`的包。

遵循上述的规范，养成良好的测试风格，可以为日后的维护省去不少的麻烦。

#### [执行测试](https://golang.halfiisland.com/essential/senior/120.test.html#执行测试)

执行测试主要会用到`go test`命令，下面拿实际的代码举例，现在有待测试文件`/say/hello.go`代码如下



```
package say

import "fmt"

func Hello() {
  fmt.Println("hello")
}

func GoodBye() {
  fmt.Println("bye")
}
```

和测试文件`/test/example_test.go`代码如下



```
package test

import (
  "golearn/say"
)

func ExampleHello() {
  say.Hello()
  // Output:
  // hello
}

func ExampleGoodBye() {
  say.GoodBye()
  // Output:
  // bye
}

func ExampleSay() {
  say.Hello()
  say.GoodBye()
  // Output:
  // hello
  // bye
}
```

执行这些测试有多种方法，比如想要执行`test`包下所有的测试用例，就可以直接在`test`目录下执行如下命令



```
$ go test ./
PASS
ok      golearn/test    0.422s
```

`./`表示当前目录，Go 会将`test`目录下的所有测试文件重新编译后，然后再将所有测试用例全都执行，从结果可以看出所有的测试用例都通过了。其后的参数也可以跟多个目录，例如下方的命令，显然项目的主目录并没有测试文件可供执行。



```
$ go test ./ ../
ok      golearn/test
?       golearn [no test files]
```

提示

当执行的参数有多个包时，Go 并不会再次执行已经成功通过的测试用例，在执行时会行尾添加`(cached)`以表示输出结果是上一次的缓存。当测试的标志参数位于以下集合中时，Go 就会缓存测试结果，否则就不会。



```
-benchtime, -cpu,-list, -parallel, -run, -short, -timeout, -failfast, -v
```

如果想要禁用缓存，可以加上参数` -count=1`。

当然也可以单独指定某一个测试文件来执行。



```
$ go test example_test.go
ok      command-line-arguments  0.457s
```

或者可以单独指定某一个测试文件的某一个测试用例，例如



```
$ go test -run ExampleSay
PASS
ok      golearn/test    0.038s
```

上面三种情况虽然都完成了测试，但是输出结果太简洁了，这时可以加上参数`-v`，来使输出结果更加详细一点，例如



```
$ go test ./ -v
=== RUN   ExampleHello
--- PASS: ExampleHello (0.00s)
=== RUN   ExampleGoodBye
--- PASS: ExampleGoodBye (0.00s)
=== RUN   ExampleSay
--- PASS: ExampleSay (0.00s)
PASS
ok      golearn/test    0.040s
```

这下可以很清楚的看到每一个测试用例的执行顺序，耗时，执行情况，以及总体的耗时。

提示

`go test`命令默认运行所有的单元测试，示例测试，模糊测试，如果加上了`-bench`参数则会运行所有类型的测试，例如下方的命令



```
$ go test -bench .
```

所以需要使用`-run`参数来指定，例如只运行所有的基准测试的命令如下



```
$ go test -bench . -run ^$
```

##### [常用参数](https://golang.halfiisland.com/essential/senior/120.test.html#常用参数)

Go 测试有着非常多的标志参数，下面只会介绍常用的参数，想要了解更多细节建议使用`go help testflag`命令自行查阅。

| 参数                          | 释义                                                         |
| ----------------------------- | ------------------------------------------------------------ |
| `-o file`                     | 指定编译后的二进制文件名称                                   |
| `-c`                          | 只编译测试文件，但不运行                                     |
| `-json`                       | 以 json 格式输出测试日志                                     |
| `-exec xprog`                 | 使用`xprog`运行测试，等价于`go run`                          |
| `-bench regexp`               | 选中`regexp`匹配的基准测试                                   |
| `-fuzz regexp`                | 选中`regexp`匹配的模糊测试                                   |
| `-fuzztime t`                 | 模糊测试自动结束的时间，`t`为时间间隔，当单位为`x`时，表示次数，例如`200x` |
| `-fuzzminimizetime t`         | 模式测试运行的最小时间，规则同上                             |
| `-count n`                    | 运行测试 n 次，默认 1 次                                     |
| `-cover`                      | 开启测试覆盖率分析                                           |
| `-covermode set,count,atomic` | 设置覆盖率分析的模式                                         |
| `-cpu`                        | 为测试执行`GOMAXPROCS`                                       |
| `-failfast`                   | 第一次测试失败后，不会开始新的测试                           |
| `-list regexp`                | 列出`regexp`匹配的测试用例                                   |
| `-parallel n`                 | 允许调用了`t.Parallel`的测试用例并行运行，`n`值为并行的最大数量 |
| `-run regexp`                 | 只运行`regexp`匹配的测试用例                                 |
| `-skip regexp`                | 跳过`regexp`匹配的测试用例                                   |
| `-timeout d`                  | 如果单次测试执行时间超过了时间间隔`d`，就会`panic`。`d`为时间间隔，例 1s,1ms,1ns 等 |
| `-shuffle off,on,N`           | 打乱测试的执行顺序，`N`为随机种子，默认种子为系统时间        |
| `-v`                          | 输出更详细的测试日志                                         |
| `-benchmem`                   | 统计基准测试的内存分配                                       |
| `-blockprofile block.out`     | 统计测试中协程阻塞情况并写入文件                             |
| `-blockprofilerate n`         | 控制协程阻塞统计频率，通过命令`go doc runtime.SetBlockProfileRate`查看更多细节 |
| `-coverprofile cover.out`     | 统计覆盖率测试的情况并写入文件                               |
| `-cpuprofile cpu.out`         | 统计 cpu 情况并写入文件                                      |
| `-memprofile mem.out`         | 统计内存分配情况并写入文件                                   |
| `-memprofilerate n`           | 控制内存分配统计的频率，通过命令`go doc runtime.MemProfileRate`查看更多细节 |
| `-mutexprofile mutex.out`     | 统计锁竞争情况并写入文件                                     |
| `-mutexprofilefraction n`     | 设置统计`n`个协程竞争一个互斥锁的情况                        |
| `-trace trace.out`            | 将执行追踪情况写入文件                                       |
| `-outputdir directory`        | 指定上述的统计文件的输出目录，默认为`go test`的运行目录      |

#### [示例测试](https://golang.halfiisland.com/essential/senior/120.test.html#示例测试)

示例测试并不像其他三种测试一样是为了发现程序的问题所在，它更多的是为了展示某一个功能的使用方法，起到文档作用。示例测试并不是一个官方定义的概念，也不是一个硬性的规范，更像是一种工程上的约定俗成，是否遵守只取决于开发者。示例测试在标准库中出现的非常多，通常是官方所编写的标准库代码示例，例如标准库`context/example_test.go`中的`ExampleWithDeadline`测试函数，该函数中展现了`DeadlineContext`的基本使用方法：



```
// This example passes a context with an arbitrary deadline to tell a blocking
// function that it should abandon its work as soon as it gets to it.
func ExampleWithDeadline() {
   d := time.Now().Add(shortDuration)
   ctx, cancel := context.WithDeadline(context.Background(), d)

   // Even though ctx will be expired, it is good practice to call its
   // cancellation function in any case. Failure to do so may keep the
   // context and its parent alive longer than necessary.
   defer cancel()

   select {
   case <-time.After(1 * time.Second):
      fmt.Println("overslept")
   case <-ctx.Done():
      fmt.Println(ctx.Err())
   }

   // Output:
   // context deadline exceeded
}
```

表面上看该测试函数就是一个普通的函数，不过示例测试主要是由`Output`注释来体现的，待测试函数只有一行输出时，使用`Output`注释来检测输出。首先创建一个名为`hello.go`的文件，写入如下代码



```
package say

import "fmt"

func Hello() {
  fmt.Println("hello")
}

func GoodBye() {
  fmt.Println("bye")
}
```

`SayHello`函数就是待测函数，然后创建测试文件`example_test.go`，写入如下代码



```
package test

import (
  "golearn/say"
)

func ExampleHello() {
  say.Hello()
  // Output:
  // hello
}

func ExampleGoodBye() {
  say.GoodBye()
  // Output:
  // bye
}

func ExampleSay() {
  say.Hello()
  say.GoodBye()
  // Output:
  // hello
  // bye
}
```

函数中`Output`注释表明了检测函数输出是否为`hello`，接下来执行测试命令看看结果。



```
$ go test -v
=== RUN   ExampleHello
--- PASS: ExampleHello (0.00s)
=== RUN   ExampleGoodBye
--- PASS: ExampleGoodBye (0.00s)
=== RUN   ExampleSay
--- PASS: ExampleSay (0.00s)
PASS
ok      golearn/test    0.448s
```

从结果可以看出全部测试都已经通过，关于`Output`有以下几种写法，第一种是只有一行输出，意为检测该函数的输出是不是 hello



```
// Output:
// hello
```

第二种是多行输出，即按顺序检测输出是否匹配



```
// Output:
// hello
// bye
```

第三种是无序输出，即不按照顺序多行输出匹配



```
// Unordered output:
// bye
// hello
```

需要注意的是，对于测试函数而言，仅当最后几行为`Output`注释才会被视为示例测试，否则就只是一个普通的函数，不会被 Go 执行。

#### [单元测试](https://golang.halfiisland.com/essential/senior/120.test.html#单元测试)

单元测试就是对软件中的最小可测试单元进行测试，单元的大小定义取决于开发者，可能是一个结构体，或者是一个包，也可能是一个函数，或者是一个类型。下面依旧通过例子来演示，首先创建`/tool/math.go`文件，写入如下代码



```
package tool

type Number interface {
  ~int8 | ~int16 | ~int32 | ~int64 | ~int
}

func SumInt[T Number](a, b T) T {
  return a + b
}

func Equal[T Number](a, b T) bool {
  return a == b
}
```

然后创建测试文件`/tool_test/unit_test.go`，对于单元测试而言，命名可以为`unit_test`或者是想要测试的包或者功能作为文件前缀。



```
package test_test

import (
  "golearn/tool"
  "testing"
)

func TestSum(t *testing.T) {
  a, b := 10, 101
  expected := 111

  actual := tool.SumInt(a, b)
  if actual != expected {
    t.Errorf("Sum(%d,%d) expected %d,actual is %d", a, b, expected, actual)
  }
}

func TestEqual(t *testing.T) {
  a, b := 10, 101
  expected := false

  actual := tool.Equal(a, b)
  if actual != expected {
    t.Errorf("Sum(%d,%d) expected %t,actual is %t", a, b, expected, actual)
  }
}
```

对于单元测试而言，每一个测试用例的命名风格为`TestXXXX`，且函数的入参必须是`t *testing.T`，`testing.T`是`testing`包提供的用于方便测试的结构体，提供了许多可用的方法，例子中的`t.Errorf`等同于`t.Logf`，用于格式化输出测试失败的日志信息，其他常用的还有`t.Fail`用于将当前用例标记为测试失败，功能类似的还有`t.FailNow`同样会标记为测试失败，但是前者失败后还会继续执行，后者则会直接停止执行，如下方的例子，将预期结果修改为错误的结果：



```
package tool_test

import (
  "golearn/tool"
  "testing"
)

func TestSum(t *testing.T) {
  a, b := 10, 101
  expected := 110

  actual := tool.SumInt(a, b)
  if actual != expected {
        // Errorf内部使用的是t.Fail()
    t.Errorf("Sum(%d,%d) expected %d,actual is %d", a, b, expected, actual)
  }
  t.Log("test finished")
}

func TestEqual(t *testing.T) {
  a, b := 10, 101
  expected := true

  actual := tool.Equal(a, b)
  if actual != expected {
        // Fatalf内部使用的是t.FailNow()
    t.Fatalf("Sum(%d,%d) expected %t,actual is %t", a, b, expected, actual)
  }
  t.Log("test finished")
}
```

执行上述测试输出如下



```
$ go test tool_test.go -v
=== RUN   TestSum
    tool_test.go:14: Sum(10,101) expected 110,actual is 111
    tool_test.go:16: test finished
--- FAIL: TestSum (0.00s)
=== RUN   TestEqual
    tool_test.go:25: Sum(10,101) expected true,actual is false
--- FAIL: TestEqual (0.00s)
FAIL    command-line-arguments  0.037s
```

从测试日志中可以看出`TestSum`用例尽管失败了还是输出了 test finished，而`TestEqual`则没有，同样的还有`t.SkipNow`，会将当前用例标记为`SKIP`，然后停止执行，在下一轮测试中会继续执行。



```
package tool_test

import (
   "golearn/tool"
   "testing"
)

func TestSum(t *testing.T) {
   a, b := 10, 101
   expected := 110

   actual := tool.SumInt(a, b)
   if actual != expected {
      t.Skipf("Sum(%d,%d) expected %d,actual is %d", a, b, expected, actual)
   }
   t.Log("test finished")
}

func TestEqual(t *testing.T) {
   a, b := 10, 101
   expected := true

   actual := tool.Equal(a, b)
   if actual != expected {
      t.Fatalf("Sum(%d,%d) expected %t,actual is %t", a, b, expected, actual)
   }
   t.Log("test finished")
}
```

在执行测试时，修改测试次数为 2



```
$ go test tool_test.go -v -count=2
=== RUN   TestSum
    tool_test.go:14: Sum(10,101) expected 110,actual is 111
--- SKIP: TestSum (0.00s)
=== RUN   TestEqual
    tool_test.go:25: Sum(10,101) expected true,actual is false
--- FAIL: TestEqual (0.00s)
=== RUN   TestSum
    tool_test.go:14: Sum(10,101) expected 110,actual is 111
--- SKIP: TestSum (0.00s)
=== RUN   TestEqual
    tool_test.go:25: Sum(10,101) expected true,actual is false
--- FAIL: TestEqual (0.00s)
FAIL    command-line-arguments  0.468s
```

上数的例子中在最后一行输出了 test finished，用于表示测试完毕，其实可以使用`t.Cleanup`来注册一个收尾函数专门做此事，该函数会在测试用例结束时执行，如下。



```
package tool_test

import (
  "golearn/tool"
  "testing"
)

func finished(t *testing.T) {
  t.Log("test finished")
}

func TestSum(t *testing.T) {
  t.Cleanup(func() {
    finished(t)
  })

  a, b := 10, 101
  expected := 111

  actual := tool.SumInt(a, b)
  if actual != expected {
    t.Skipf("Sum(%d,%d) expected %d,actual is %d", a, b, expected, actual)
  }

}

func TestEqual(t *testing.T) {
  t.Cleanup(func() {
    finished(t)
  })

  a, b := 10, 101
  expected := false

  actual := tool.Equal(a, b)
  if actual != expected {
    t.Fatalf("Sum(%d,%d) expected %t,actual is %t", a, b, expected, actual)
  }
}
```

执行测试后输出如下



```
$ go test tool_test.go -v
=== RUN   TestSum
    tool_test.go:9: test finished
--- PASS: TestSum (0.00s)
=== RUN   TestEqual
    tool_test.go:9: test finished
--- PASS: TestEqual (0.00s)
PASS
ok      command-line-arguments  0.462s
```

##### [Helper](https://golang.halfiisland.com/essential/senior/120.test.html#helper)

通过`t.Helper()`可以将当前函数标记为帮助函数，帮助函数不会单独作为一个测试用例用于执行，在记录日志时输出的行号也是帮助函数的调用者的行号，这样可以使得分析日志时定位更准确，避免的冗杂的其他信息。比如上述`t.Cleanup`的例子就可以修改为帮助函数，如下。



```
package tool_test

import (
   "golearn/tool"
   "testing"
)

func CleanupHelper(t *testing.T) {
   t.Helper()
   t.Log("test finished")
}

func TestSum(t *testing.T) {
   t.Cleanup(func() {
      CleanupHelper(t)
   })

   a, b := 10, 101
   expected := 111

   actual := tool.SumInt(a, b)
   if actual != expected {
      t.Skipf("Sum(%d,%d) expected %d,actual is %d", a, b, expected, actual)
   }

}

func TestEqual(t *testing.T) {
   t.Cleanup(func() {
      CleanupHelper(t)
   })

   a, b := 10, 101
   expected := false

   t.Helper()
   actual := tool.Equal(a, b)
   if actual != expected {
      t.Fatalf("Sum(%d,%d) expected %t,actual is %t", a, b, expected, actual)
   }
}
```

执行测试后输出信息如下，与之前的区别在于 test finished 的行号变成了调用者的行号。



```
$ go test tool_test.go -v
=== RUN   TestSum
    tool_test.go:15: test finished
--- PASS: TestSum (0.00s)
=== RUN   TestEqual
    tool_test.go:30: test finished
--- PASS: TestEqual (0.00s)
PASS
ok      command-line-arguments  0.464s
```

提示

上述操作都只能在主测试中进行，即直接执行的测试用例，如果是子测试中使用将会`panic`。

##### [子测试](https://golang.halfiisland.com/essential/senior/120.test.html#子测试)

在一些情况下，会需要用到在一个测试用例中测试另外测试用例，这种嵌套的测试用例一般称为子测试，通过`t.Run()`方法，该方法签名如下



```
// Run方法会开启一个新的协程用于运行子测试，阻塞等待函数f执行完毕后才会返回
// 返回值为是否通过测试
func (t *T) Run(name string, f func(t *T)) bool
```

下面是一个例子



```
func TestTool(t *testing.T) {
  t.Run("tool.Sum(10,101)", TestSum)
  t.Run("tool.Equal(10,101)", TestEqual)
}
```

执行后结果如下



```
$ go test -run TestTool -v
=== RUN   TestTool
=== RUN   TestTool/tool.Sum(10,101)
    tool_test.go:15: test finished
=== RUN   TestTool/tool.Equal(10,101)
    tool_test.go:30: test finished
--- PASS: TestTool (0.00s)
    --- PASS: TestTool/tool.Sum(10,101) (0.00s)
    --- PASS: TestTool/tool.Equal(10,101) (0.00s)
PASS
ok      golearn/tool_test       0.449s
```

通过输出可以很清晰的看到父子的层级结构，在上述的例子中第一个子测试未执行完毕第二个子测试是不会执行的，可以使用`t.Parallel()`将测试用例标记为可并行运行，如此一来输出的顺序将会无法确定。



```
package tool_test

import (
  "golearn/tool"
  "testing"
)

func CleanupHelper(t *testing.T) {
  t.Helper()
  t.Log("test finished")
}

func TestSum(t *testing.T) {
  t.Parallel()
  t.Cleanup(func() {
    CleanupHelper(t)
  })

  a, b := 10, 101
  expected := 111

  actual := tool.SumInt(a, b)
  if actual != expected {
    t.Skipf("Sum(%d,%d) expected %d,actual is %d", a, b, expected, actual)
  }

}

func TestEqual(t *testing.T) {
  t.Parallel()
  t.Cleanup(func() {
    CleanupHelper(t)
  })

  a, b := 10, 101
  expected := false

  actual := tool.Equal(a, b)
  if actual != expected {
    t.Fatalf("Sum(%d,%d) expected %t,actual is %t", a, b, expected, actual)
  }
}

func TestToolParallel(t *testing.T) {
  t.Log("setup")
  t.Run("tool.Sum(10,101)", TestSum)
  t.Run("tool.Equal(10,101)", TestEqual)
  t.Log("teardown")
}
```

执行测试后输出如下



```
$ go test -run TestTool -v
=== RUN   TestToolParallel
    tool_test.go:46: setup
=== RUN   TestToolParallel/tool.Sum(10,101)
=== PAUSE TestToolParallel/tool.Sum(10,101)
=== RUN   TestToolParallel/tool.Equal(10,101)
=== PAUSE TestToolParallel/tool.Equal(10,101)
=== NAME  TestToolParallel
    tool_test.go:49: teardown
=== CONT  TestToolParallel/tool.Sum(10,101)
=== CONT  TestToolParallel/tool.Equal(10,101)
=== NAME  TestToolParallel/tool.Sum(10,101)
    tool_test.go:16: test finished
=== NAME  TestToolParallel/tool.Equal(10,101)
    tool_test.go:32: test finished
--- PASS: TestToolParallel (0.00s)
    --- PASS: TestToolParallel/tool.Sum(10,101) (0.00s)
    --- PASS: TestToolParallel/tool.Equal(10,101) (0.00s)
PASS
ok      golearn/tool_test       0.444s
```

从测试结果中就可以很明显的看出有一个阻塞等待的过程，在并发执行测试用例时，像上述的例子肯定是无法正常进行的，因为后续的代码无法保证同步运行，这时可以选择再嵌套一层`t.Run()`，如下



```
func TestToolParallel(t *testing.T) {
  t.Log("setup")
  t.Run("process", func(t *testing.T) {
    t.Run("tool.Sum(10,101)", TestSum)
    t.Run("tool.Equal(10,101)", TestEqual)
  })
  t.Log("teardown")
}
```

再次执行，就可以看到正常的执行结果了。



```
$ go test -run TestTool -v
=== RUN   TestToolParallel
    tool_test.go:46: setup
=== RUN   TestToolParallel/process
=== RUN   TestToolParallel/process/tool.Sum(10,101)
=== PAUSE TestToolParallel/process/tool.Sum(10,101)
=== RUN   TestToolParallel/process/tool.Equal(10,101)
=== PAUSE TestToolParallel/process/tool.Equal(10,101)
=== CONT  TestToolParallel/process/tool.Sum(10,101)
=== CONT  TestToolParallel/process/tool.Equal(10,101)
=== NAME  TestToolParallel/process/tool.Sum(10,101)
    tool_test.go:16: test finished
=== NAME  TestToolParallel/process/tool.Equal(10,101)
    tool_test.go:32: test finished
=== NAME  TestToolParallel
    tool_test.go:51: teardown
--- PASS: TestToolParallel (0.00s)
    --- PASS: TestToolParallel/process (0.00s)
        --- PASS: TestToolParallel/process/tool.Sum(10,101) (0.00s)
        --- PASS: TestToolParallel/process/tool.Equal(10,101) (0.00s)
PASS
ok      golearn/tool_test       0.450s
```

##### [表格风格](https://golang.halfiisland.com/essential/senior/120.test.html#表格风格)

在上述的单元测试中，测试的输入数据都是手动声明的一个个变量，当数据量小的时候无伤大雅，但如果想要测试多组数据时，就不太可能再去声明变量来创建测试数据，所以一般情况下都是尽量采用结构体切片的形式，结构体是临时声明的匿名结构体，因为这样的编码风格看起来就跟表格一样，所以称为`table-driven`。下面举个例子，这是一个手动声明多个变量来创建测试数据的例子，如果有多组数据看起来就不是很直观，所以将其修改为表格风格



```
func TestEqual(t *testing.T) {
  t.Cleanup(func() {
    CleanupHelper(t)
  })

  a, b := 10, 101
  expected := false
  actual := tool.Equal(a, b)
  if actual != expected {
    t.Fatalf("Sum(%d,%d) expected %t,actual is %t", a, b, expected, actual)
  }
}
```

修改后的代码如下



```
func TestEqual(t *testing.T) {
  t.Cleanup(func() {
    CleanupHelper(t)
  })

  // table driven style
  testData := []struct {
    a, b int
    exp  bool
  }{
    {10, 101, false},
    {5, 5, true},
    {30, 32, false},
    {100, 101, false},
    {2, 3, false},
    {4, 4, true},
  }

  for _, data := range testData {
    if actual := tool.Equal(data.a, data.b); actual != data.exp {
      t.Fatalf("Sum(%d,%d) expected %t,actual is %t", data.a, data.b, data.exp, actual)
    }
  }
}
```

这样的测试数据看起来就要直观很多。

#### [基准测试](https://golang.halfiisland.com/essential/senior/120.test.html#基准测试)

基准测试又称为性能测试，通常用于测试程序的内存占用，CPU 使用情况，执行耗时等等性能指标。对于基准测试而言，测试文件通常以`bench_test.go`结尾，而测试用例的函数必须为`BenchmarkXXXX`格式。

下面以一个字符串拼接的例子的性能比较来当作基准测试的例子。首先创建文件`/tool/strConcat.go`文件，众所周知直接使用字符串进行`+`拼接性能是很低的，而使用`strings.Builder`则要好很多，在`/tool/strings.go`文件分别创建两个函数进行两种方式的字符串拼接。



```
package tool

import "strings"


func ConcatStringDirect(longString string) {
   res := ""
   for i := 0; i < 100_000.; i++ {
      res += longString
   }
}

func ConcatStringWithBuilder(longString string) {
   var res strings.Builder
   for i := 0; i < 100_000.; i++ {
      res.WriteString(longString)
   }
}
```

然后创建测试文件`/tool_test/bench_tool_test.go `，代码如下



```
package tool_test

import (
  "golearn/tool"
  "testing"
)

var longString = "longStringlongStringlongStringlongStringlongStringlongStringlongStringlongString"

func BenchmarkConcatDirect(b *testing.B) {
  for i := 0; i < b.N; i++ {
    tool.ConcatStringDirect(longString)
  }
}

func BenchmarkConcatBuilder(b *testing.B) {
  for i := 0; i < b.N; i++ {
    tool.ConcatStringWithBuilder(longString)
  }
}
```

执行测试命令，命令中开启了详细日志和内存分析，指定了使用的 CPU 核数列表，且每个测试用例执行两轮，输出如下



```
$ go test -v -benchmem -bench . -run bench_tool_test.go -cpu=2,4,8 -count=2
goos: windows
goarch: amd64
pkg: golearn/tool_test
cpu: 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
BenchmarkConcatDirect
BenchmarkConcatDirect-2                4         277771375 ns/op        4040056736 B/op    10000 allocs/op
BenchmarkConcatDirect-2                4         278500125 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-4                1        1153796000 ns/op        4040068784 B/op    10126 allocs/op
BenchmarkConcatDirect-4                1        1211017600 ns/op        4040073104 B/op    10171 allocs/op
BenchmarkConcatDirect-8                2         665460800 ns/op        4040077760 B/op    10219 allocs/op
BenchmarkConcatDirect-8                2         679774450 ns/op        4040080064 B/op    10243 allocs/op
BenchmarkConcatBuilder
BenchmarkConcatBuilder-2            3428            344530 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            3579            351858 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-4            2448            736177 ns/op         4128185 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1688            662993 ns/op         4128185 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1958            550333 ns/op         4128199 B/op         29 allocs/op
BenchmarkConcatBuilder-8            2174            552113 ns/op         4128196 B/op         29 allocs/op
PASS
ok      golearn/tool_test       21.381s
```

下面解释一下基准测试的输出结果，`goos`代表是运行的操作系统，`goarh`代表的是 CPU 架构，`pkg`为测试所在的包，`cpu`是一些关于 CPU 的信息。下面的每一个测试用例的结果由每一个基准测试的名称分隔，第一列`BenchmarkConcatDirect-2`中的 2 代表了使用的 CPU 核数，第二列的 4 代表了代码中`b.N`的大小，也就是基准测试中的循环次数，第三列`277771375 ns/op`代表了每一次循环所消耗的时间，ns 为纳秒，第四列`4040056736 B/op`表示每一次循环所分配内存的字节大小，第五列`10000 allocs/op`表示每一次循环内存分配的次数。

很显然，根据测试的结果看来，使用`strings.Builder`的性能要远远高于使用`+`拼接字符串，通过直观的数据对比性能正是基准测试的目的所在。

##### [benchstat](https://golang.halfiisland.com/essential/senior/120.test.html#benchstat)

benchstat 是一个开源的性能测试分析工具，上述性能测试的样本数只有两组，一旦样本多了起来人工分析就会十分的费时费力，该工具便是为了解决性能分析问题而生。

首先需要下载该工具



```
$ go install golang.org/x/perf/benchstat
```

分两次执行基准测试，这次将样本数修改为 5 个，并且分别输出到`old.txt`和`new.txt`文件以做对比，第一次执行结果



```
$ go test -v -benchmem -bench . -run bench_tool_test.go -cpu=2,4,8 -count=5 | tee -a old.txt
goos: windows
goarch: amd64
pkg: golearn/tool_test
cpu: 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
BenchmarkConcatDirect
BenchmarkConcatDirect-2                4         290535650 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-2                4         298974625 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-2                4         299637800 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-2                4         276487000 ns/op        4040056784 B/op    10001 allocs/op
BenchmarkConcatDirect-2                4         356465275 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-4                2         894723200 ns/op        4040077424 B/op    10216 allocs/op
BenchmarkConcatDirect-4                2         785830400 ns/op        4040078288 B/op    10225 allocs/op
BenchmarkConcatDirect-4                2         743634000 ns/op        4040077568 B/op    10217 allocs/op
BenchmarkConcatDirect-4                2         953802700 ns/op        4040075408 B/op    10195 allocs/op
BenchmarkConcatDirect-4                2         953028750 ns/op        4040077520 B/op    10217 allocs/op
BenchmarkConcatDirect-8                2         684023150 ns/op        4040086784 B/op    10313 allocs/op
BenchmarkConcatDirect-8                2         634380250 ns/op        4040090528 B/op    10352 allocs/op
BenchmarkConcatDirect-8                2         685030600 ns/op        4040090768 B/op    10355 allocs/op
BenchmarkConcatDirect-8                2         817909650 ns/op        4040089808 B/op    10345 allocs/op
BenchmarkConcatDirect-8                2         600078100 ns/op        4040095664 B/op    10406 allocs/op
BenchmarkConcatBuilder
BenchmarkConcatBuilder-2            2925            419651 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            2961            423899 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            2714            422275 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            2848            452255 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            2612            454452 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-4             974           1158000 ns/op         4128189 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1098           1068682 ns/op         4128192 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1042           1056570 ns/op         4128194 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1280            978213 ns/op         4128191 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1538           1162108 ns/op         4128190 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1744            700824 ns/op         4128203 B/op         29 allocs/op
BenchmarkConcatBuilder-8            2235            759537 ns/op         4128201 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1556            736455 ns/op         4128204 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1592            825794 ns/op         4128201 B/op         29 allocs/op
BenchmarkConcatBuilder-8            2263            717285 ns/op         4128203 B/op         29 allocs/op
PASS
ok      golearn/tool_test       56.742s
```

第二次执行结果



```
$ go test -v -benchmem -bench . -run bench_tool_test.go -cpu=2,4,8 -count=5 | tee -a new.txt
goos: windows
goarch: amd64
pkg: golearn/tool_test
cpu: 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
BenchmarkConcatDirect
BenchmarkConcatDirect-2                4         285074900 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-2                4         291517150 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-2                4         281901975 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-2                4         292320625 ns/op        4040056592 B/op     9999 allocs/op
BenchmarkConcatDirect-2                4         286723000 ns/op        4040056952 B/op    10002 allocs/op
BenchmarkConcatDirect-4                1        1188983000 ns/op        4040071856 B/op    10158 allocs/op
BenchmarkConcatDirect-4                1        1080713900 ns/op        4040070800 B/op    10147 allocs/op
BenchmarkConcatDirect-4                1        1203622300 ns/op        4040067344 B/op    10111 allocs/op
BenchmarkConcatDirect-4                1        1045291300 ns/op        4040070224 B/op    10141 allocs/op
BenchmarkConcatDirect-4                1        1123163300 ns/op        4040070032 B/op    10139 allocs/op
BenchmarkConcatDirect-8                2         790421300 ns/op        4040076656 B/op    10208 allocs/op
BenchmarkConcatDirect-8                2         659047300 ns/op        4040079488 B/op    10237 allocs/op
BenchmarkConcatDirect-8                2         712991800 ns/op        4040077184 B/op    10213 allocs/op
BenchmarkConcatDirect-8                2         706605350 ns/op        4040078000 B/op    10222 allocs/op
BenchmarkConcatDirect-8                2         656195700 ns/op        4040085248 B/op    10297 allocs/op
BenchmarkConcatBuilder
BenchmarkConcatBuilder-2            2726            386412 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            3439            335358 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            3376            338957 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            3870            326301 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-2            4285            339596 ns/op         4128176 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1663            671535 ns/op         4128187 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1507            744885 ns/op         4128191 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1353           1097800 ns/op         4128187 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1388           1006019 ns/op         4128189 B/op         29 allocs/op
BenchmarkConcatBuilder-4            1635            993764 ns/op         4128189 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1332            783599 ns/op         4128198 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1818            729821 ns/op         4128202 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1398            780614 ns/op         4128202 B/op         29 allocs/op
BenchmarkConcatBuilder-8            1526            750513 ns/op         4128204 B/op         29 allocs/op
BenchmarkConcatBuilder-8            2164            704798 ns/op         4128204 B/op         29 allocs/op
PASS
ok      golearn/tool_test       50.387s
```

再使用 benchstat 进行对比



```
$ benchstat old.txt new.txt
goos: windows
goarch: amd64
pkg: golearn/tool_test
cpu: 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
                │    old.txt    │               new.txt                │
                │    sec/op     │    sec/op      vs base               │
ConcatDirect-2     299.0m ± ∞ ¹    286.7m ± ∞ ¹        ~ (p=0.310 n=5)
ConcatDirect-4     894.7m ± ∞ ¹   1123.2m ± ∞ ¹  +25.53% (p=0.008 n=5)
ConcatDirect-8     684.0m ± ∞ ¹    706.6m ± ∞ ¹        ~ (p=0.548 n=5)
ConcatBuilder-2    423.9µ ± ∞ ¹    339.0µ ± ∞ ¹  -20.04% (p=0.008 n=5)
ConcatBuilder-4   1068.7µ ± ∞ ¹    993.8µ ± ∞ ¹        ~ (p=0.151 n=5)
ConcatBuilder-8    736.5µ ± ∞ ¹    750.5µ ± ∞ ¹        ~ (p=0.841 n=5)
geomean            19.84m          19.65m         -0.98%
¹ need >= 6 samples for confidence interval at level 0.95

                │    old.txt    │                new.txt                │
                │     B/op      │     B/op       vs base                │
ConcatDirect-2    3.763Gi ± ∞ ¹   3.763Gi ± ∞ ¹       ~ (p=1.000 n=5)
ConcatDirect-4    3.763Gi ± ∞ ¹   3.763Gi ± ∞ ¹  -0.00% (p=0.008 n=5)
ConcatDirect-8    3.763Gi ± ∞ ¹   3.763Gi ± ∞ ¹  -0.00% (p=0.008 n=5)
ConcatBuilder-2   3.937Mi ± ∞ ¹   3.937Mi ± ∞ ¹       ~ (p=1.000 n=5) ²
ConcatBuilder-4   3.937Mi ± ∞ ¹   3.937Mi ± ∞ ¹       ~ (p=0.079 n=5)
ConcatBuilder-8   3.937Mi ± ∞ ¹   3.937Mi ± ∞ ¹       ~ (p=0.952 n=5)
geomean           123.2Mi         123.2Mi        -0.00%
¹ need >= 6 samples for confidence interval at level 0.95
² all samples are equal

                │   old.txt    │               new.txt                │
                │  allocs/op   │  allocs/op    vs base                │
ConcatDirect-2    9.999k ± ∞ ¹   9.999k ± ∞ ¹       ~ (p=1.000 n=5)
ConcatDirect-4    10.22k ± ∞ ¹   10.14k ± ∞ ¹  -0.74% (p=0.008 n=5)
ConcatDirect-8    10.35k ± ∞ ¹   10.22k ± ∞ ¹  -1.26% (p=0.008 n=5)
ConcatBuilder-2    29.00 ± ∞ ¹    29.00 ± ∞ ¹       ~ (p=1.000 n=5) ²
ConcatBuilder-4    29.00 ± ∞ ¹    29.00 ± ∞ ¹       ~ (p=1.000 n=5) ²
ConcatBuilder-8    29.00 ± ∞ ¹    29.00 ± ∞ ¹       ~ (p=1.000 n=5) ²
geomean            543.6          541.7        -0.33%
¹ need >= 6 samples for confidence interval at level 0.95
² all samples are equal
```

从结果中可以看出 benchstat 将其分为了三组，分别是耗时，内存占用和内存分配次数，其中`geomean`为平均值，`p`为样本的显著性水平，临界区间通常为0.05，高于0.05就不太可信，取其中一条数据如下：



```
          │    sec/op     │    sec/op      vs base               │
ConcatDirect-4     894.7m ± ∞ ¹   1123.2m ± ∞ ¹  +25.53% (p=0.008 n=5)
```

可以看到`old`执行耗时为 894.7ms，`new`执行耗时 1123.2ms，相比之下还增加了 25.53%的耗时。

#### [模糊测试](https://golang.halfiisland.com/essential/senior/120.test.html#模糊测试)

模糊测试是 GO1.18 推出的一个新功能，属于是单元测试和基准测试的一种增强，区别在于前两者的测试数据都需要开发者手动编写，而模糊测试可以通过语料库来生成随机的测试数据，关于 Go 中的模糊测试可以前往[Go Fuzzing](https://go.dev/security/fuzz/)来了解更多概念。模糊测试的好处在于，相比于固定的测试数据，随机数据可以更好的测试程序的边界条件。下面拿官方教程的例子来讲解，这次需要测试的是一个反转字符串的函数，首先创建文件`/tool/strings.go`，写入如下代码



```
package tool

func Reverse(s string) string {
  b := []byte(s)
  for i, j := 0, len(b)-1; i < len(b)/2; i, j = i+1, j-1 {
    b[i], b[j] = b[j], b[i]
  }
  return string(b)
}
```

创建模糊测试文件`/tool_test/fuzz_tool_test.go`，写入如下代码



```
package tool

import (
  "golearn/tool"
  "testing"
  "unicode/utf8"
)

func FuzzReverse(f *testing.F) {
  testdata := []string{"hello world!", "nice to meet you", "good bye!"}
  for _, data := range testdata {
    f.Add(data)
  }

  f.Fuzz(func(t *testing.T, str string) {
    first := tool.Reverse(str)
    second := tool.Reverse(first)
    t.Logf("str:%q,first:%q,second:%q", str, first, second)
    if str != second {
      t.Errorf("before: %q, after: %q", str, second)
    }
    if utf8.ValidString(str) && !utf8.ValidString(first) {
      t.Errorf("Reverse produced invalid UTF-8 string %q %q", str, first)
    }
  })
}
```

在模糊测试中，首先需要给语料种子库添加数据，示例中使用`f.Add()`来添加，有助于后续生成随机的测试数据。然后使用`f.Fuzz(fn)`来进行测试，函数签名如下：



```
func (f *F) Fuzz(ff any)

func (f *F) Add(args ...any)
```

`fn`就类似于一个单元测试函数的逻辑，函数的第一个入参必须是`t *testing.T`，其后跟想要生成的参数。由于传入的字符串是不可预知的，这里采用反转两次的方法来进行验证。执行如下命令



```
$ go test -run Fuzz -v
=== RUN   FuzzReverse
=== RUN   FuzzReverse/seed#0
    fuzz_tool_test.go:18: str:"hello world!",first:"!dlrow olleh",second:"hello world!"
=== RUN   FuzzReverse/seed#1
    fuzz_tool_test.go:18: str:"nice to meet you",first:"uoy teem ot ecin",second:"nice to meet you"
=== RUN   FuzzReverse/seed#2
    fuzz_tool_test.go:18: str:"good bye!",first:"!eyb doog",second:"good bye!"
--- PASS: FuzzReverse (0.00s)
    --- PASS: FuzzReverse/seed#0 (0.00s)
    --- PASS: FuzzReverse/seed#1 (0.00s)
    --- PASS: FuzzReverse/seed#2 (0.00s)
PASS
ok      golearn/tool_test       0.539s
```

当参数不带`-fuzz`时，将不会生成随机的测试数据，只会给测试函数传入语料库中的数据，可以从结果中看到测试全部通过了，这样使用就等同于单元测试，但其实是有问题的，下面加上`-fuzz`参数再次执行。



```
$ go test -fuzz . -fuzztime 30s -run Fuzz -v
=== RUN   FuzzReverse
fuzz: elapsed: 0s, gathering baseline coverage: 0/217 completed
fuzz: minimizing 91-byte failing input file
fuzz: elapsed: 0s, gathering baseline coverage: 15/217 completed
--- FAIL: FuzzReverse (0.13s)
    --- FAIL: FuzzReverse (0.00s)
        fuzz_tool_test.go:18: str:"𐑄",first:"\x84\x91\x90\xf0",second:"𐑄"
        fuzz_tool_test.go:23: Reverse produced invalid UTF-8 string "𐑄" "\x84\x91\x90\xf0"

    Failing input written to testdata\fuzz\FuzzReverse\d856c981b6266ba2
    To re-run:
    go test -run=FuzzReverse/d856c981b6266ba2
=== NAME
FAIL
exit status 1
FAIL    golearn/tool_test       0.697s
```

提示

模糊测试中失败的用例会输出到当前测试文件夹下的`testdata`目录下的某个语料文件中，例如上述例子中的



```
Failing input written to testdata\fuzz\FuzzReverse\d856c981b6266ba2
To re-run:
go test -run=FuzzReverse/d856c981b6266ba2
```

`testdata\fuzz\FuzzReverse\d856c981b6266ba2`便是输出的语料文件路径，文件的内容如下



```
go test fuzz v1
string("𐑄")
```

可以看到这一次并没有通过，原因是字符串反转后变成了非`utf8`格式，所以通过模糊测试就发现了这个问题所在。由于一些字符占用并不止一个字节，如果将其以字节为单位反转后肯定是乱码，所以将待测试的源代码修改为如下，将字符串转换为`[]rune`，这样就可以避免出现上述问题。



```
func Reverse(s string) string {
    r := []rune(s)
    for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
        r[i], r[j] = r[j], r[i]
    }
    return string(r)
}
```

接下来直接运行根据上次模糊测试失败的用例



```
$ go test -run=FuzzReverse/d856c981b6266ba2 -v
=== RUN   FuzzReverse
=== RUN   FuzzReverse/d856c981b6266ba2
    fuzz_tool_test.go:18: str:"𐑄",first:"𐑄",second:"𐑄"
--- PASS: FuzzReverse (0.00s)
    --- PASS: FuzzReverse/d856c981b6266ba2 (0.00s)
PASS
ok      golearn/tool_test       0.033s
```

可以看到这一次通过了测试，再次执行模糊测试看看还有没有问题



```
$ go test -fuzz . -fuzztime 30s -run Fuzz -v
=== RUN   FuzzReverse
fuzz: elapsed: 0s, gathering baseline coverage: 0/219 completed
fuzz: minimizing 70-byte failing input file
failure while testing seed corpus entry: FuzzReverse/d97214ce235bfcf5
fuzz: elapsed: 0s, gathering baseline coverage: 2/219 completed
--- FAIL: FuzzReverse (0.15s)
    --- FAIL: FuzzReverse (0.00s)
        fuzz_tool_test.go:18: str:"\xe4",first:"�",second:"�"
        fuzz_tool_test.go:20: before: "\xe4", after: "�"

=== NAME
FAIL
exit status 1
FAIL    golearn/tool_test       0.184s
```

可以发现又出错了，这次的问题是对字符串做了两次反转后不相等，原字符为`\xe4`，期望的结果是`4ex\` ，但结果是乱码，如下



```
func main() {
  fmt.Println("\xe4")
  fmt.Println([]byte("\xe4"))
  fmt.Println([]rune("\xe4"))
  fmt.Printf("%q\n", "\xe4")
  fmt.Printf("%x\n", "\xe4")
}
```

它的执行结果是



```
�
[65533]
"\xe4"
e4
```

究其原因在于`\xe4`代表一个字节，但并不是一个有效的UTF-8序列（UTF-8编码中`\xe4`是一个三字节字符的开始，但后面缺少两个字节）.转换成`[]rune`时，Golang自动将它变成含单个Unicode字符的`[]rune{"\uFFFD"}`,其反转后仍是`[]rune{"\uFFFD"}`，转换回`string`时该Unicode字符又被替换为其UTF-8编码`\xef\xbf\xbd`。因此一个解决办法是如果传入的是非 utf8 字符串，直接返回错误：



```
func Reverse(s string) (string, error) {
    if !utf8.ValidString(s) {
        return s, errors.New("input is not valid UTF-8")
    }
    r := []rune(s)
    for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
        r[i], r[j] = r[j], r[i]
    }
    return string(r), nil
}
```

测试代码也需要稍作修改



```
func FuzzReverse(f *testing.F) {
  testdata := []string{"hello world!", "nice to meet you", "good bye!"}
  for _, data := range testdata {
    f.Add(data)
  }

  f.Fuzz(func(t *testing.T, str string) {
    first, err := tool.Reverse(str)
    if err != nil {
      t.Skip()
    }
    second, err := tool.Reverse(first)
    if err != nil {
      t.Skip()
    }
    t.Logf("str:%q,first:%q,second:%q", str, first, second)
    if str != second {
      t.Errorf("before: %q, after: %q", str, second)
    }
    if utf8.ValidString(str) && !utf8.ValidString(first) {
      t.Errorf("Reverse produced invalid UTF-8 string %q %q", str, first)
    }
  })
}
```

当反转函数返回`error`时，就跳过测试，再来进行模糊测试



```
$ go test -fuzz . -fuzztime 30s -run Fuzz -v
=== RUN   FuzzReverse
fuzz: elapsed: 0s, gathering baseline coverage: 0/219 completed
fuzz: elapsed: 0s, gathering baseline coverage: 219/219 completed, now fuzzing with 16 workers
fuzz: elapsed: 3s, execs: 895571 (297796/sec), new interesting: 32 (total: 251)
fuzz: elapsed: 6s, execs: 1985543 (363120/sec), new interesting: 37 (total: 256)
fuzz: elapsed: 9s, execs: 3087837 (367225/sec), new interesting: 38 (total: 257)
fuzz: elapsed: 12s, execs: 4090817 (335167/sec), new interesting: 40 (total: 259)
fuzz: elapsed: 15s, execs: 5132580 (346408/sec), new interesting: 44 (total: 263)
fuzz: elapsed: 18s, execs: 6248486 (372185/sec), new interesting: 45 (total: 264)
fuzz: elapsed: 21s, execs: 7366827 (373305/sec), new interesting: 46 (total: 265)
fuzz: elapsed: 24s, execs: 8439803 (358059/sec), new interesting: 47 (total: 266)
fuzz: elapsed: 27s, execs: 9527671 (361408/sec), new interesting: 47 (total: 266)
fuzz: elapsed: 30s, execs: 10569473 (348056/sec), new interesting: 48 (total: 267)
fuzz: elapsed: 30s, execs: 10569473 (0/sec), new interesting: 48 (total: 267)
--- PASS: FuzzReverse (30.16s)
=== NAME
PASS
ok      golearn/tool_test       30.789s
```

然后这次就可以得到一个比较完整的模糊测试输出日志，其中一些概念的解释如下：

- elapsed: 一个轮次完成后已经流逝的时间
- execs: 运行的输入总数，297796/sec 表示多少个输入每秒
- new interesting: 在测试中，已经添加语料库中的”有趣“输入的总数。（有趣的输入指的是该输入能够将代码覆盖率扩大到现有语料库所能覆盖的范围之外，随着覆盖范围的不断扩大，它的增长趋势总体上而言会持续变缓）

提示

如果没有`-fuzztime`参数限制时间，模糊测试将会永远的运行下去。

##### [类型支持](https://golang.halfiisland.com/essential/senior/120.test.html#类型支持)

Go Fuzz 中的支持的类型如下：

- `string`, `[]byte`
- `int`, `int8`, `int16`, `int32`/`rune`, `int64`
- `uint`, `uint8`/`byte`, `uint16`, `uint32`, `uint64`
- `float32`, `float64`
- `bool`

### 构建

#### Cobra

Cobra 是 Go 的 CLI 框架。它包含一个用于创建功能强大的现代 CLI 应用程序的库，以及一个用于快速生成基于 Cobra 的应用程序和命令文件的工具。

Cobra 由 Go 项目成员和 hugo 作者 [spf13](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fspf13) 创建，已经被许多流行的 Go 项目采用，比如 [GitHub CLI](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fcli%2Fcli) 和 [Docker CLI](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fdocker%2Fcli)。

- 简单的基于子命令的 CLIs：`app server`、`app fetch` 等；
- 完全兼容 [POSIX（可移植操作系统接口）](https://link.juejin.cn?target=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%E5%8F%AF%E7%A7%BB%E6%A4%8D%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%E6%8E%A5%E5%8F%A3) 的标志（包括短版和长版）
- 嵌套子命令
- 全局、局部和级联的标志
- 使用 `cobra init appname` 和 `cobra add cmdname` 轻松生成应用程序和命令
- 智能提示（`app srver` ...did you mean `app server`）
- 自动生成命令和标志的帮助
- 自动识别 `-h`、`--help` 等帮助标识
- 自动为你的应用程序生成的 bash 自动完成
- 自动为你的应用程序生成 man 手册
- 命令别名，以便你可以更改内容而不会破坏它们
- 定义自己的帮助，用法等的灵活性。
- 可选与 [viper](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fspf13%2Fviper) 紧密集成，可用于 [12factor](https://link.juejin.cn?target=https%3A%2F%2F12factor.net%2Fzh_cn%2F) 应用程序

##### 安装

Cobra 非常易用，首先使用 `go get` 命令安装最新版本。此命令将安装 `cobra` generator 的可执行文件及其依赖项：

```sh
sh

 体验AI代码助手
 代码解读
复制代码$ go get -u github.com/spf13/cobra/cobra
```

##### 概念

Cobra 构建在命令（commands）、参数（arguments）和 标志（flags）上。

**Commands** 代表动作，**Args** 是事物，**Flags** 是这些动作的修饰符。

最好的应用程序在使用时会像句子一样读起来。用户将知道如何使用该应用程序，因为他们将自然地了解如何使用它。

遵循的模式是 `APPNAME VERB NOUN --ADJECTIVE`。 或 `APPNAME COMMAND ARG --FLAG`

一些真实的例子可以更好地说明这一点。

在以下示例中，`server` 是命令，`port` 是标志：

```sh
sh

 体验AI代码助手
 代码解读
复制代码hugo server --port=1313
```

在此命令中，我们告诉 Git 克隆 url 的内容：

```sh
sh

 体验AI代码助手
 代码解读
复制代码git clone URL --bare
```

###### 命令（Command）

命令是应用程序的核心。应用程序提供的每一个交互都包含在 Command 中。一个命令可以有子命令和可选的运行一个动作。

在上面的示例中，`server` 是命令。

[cobra.Command API](https://link.juejin.cn?target=https%3A%2F%2Fgodoc.org%2Fgithub.com%2Fspf13%2Fcobra%23Command)

###### 标志（Flags）

一个标志是一种修饰命令行为的方式。Cobra 支持完全符合 [POSIX（可移植操作系统接口）](https://link.juejin.cn?target=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%E5%8F%AF%E7%A7%BB%E6%A4%8D%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%E6%8E%A5%E5%8F%A3) 的标志和 Go [flag](https://link.juejin.cn?target=https%3A%2F%2Fgolang.org%2Fpkg%2Fflag%2F) 包。

Cobra 命令可以定义一直保留到子命令的标志和仅可用于该命令的标志。

在上面的例子中，`port` 是标志。

标志的功能是 [pflag](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fspf13%2Fpflag) 库提供的，该库是一个标准库的 fork，在维护相同接口的基础上兼容了 [POSIX（可移植操作系统接口）](https://link.juejin.cn?target=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%E5%8F%AF%E7%A7%BB%E6%A4%8D%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%E6%8E%A5%E5%8F%A3)。

##### 入门

欢迎大家提供自己的项目组织结构，但是通常基于 Cobra 的应用程序将遵循以下组织结构

- ​      cmd      放置命令的文件夹      
  - add.go
  - your.go
  - commands.go
  - here.go
- ​      main.go      应用程序入口    

在 Cobra 应用程序中，通常 `main.go` 文件非常。它有一个目的：初始化 Cobra。

```go
go 体验AI代码助手 代码解读复制代码package main

import (
  "{pathToYourApp}/cmd"
)

func main() {
  cmd.Execute()
}
```

###### 使用 Cobra 生成器

Cobra 提供了 CLI 来创建您的应用程序和添加任意你想要的命令。这是将 Cobra 集成到您的应用程序中的最简单方法。

[这里](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fspf13%2Fcobra%2Fblob%2Fmaster%2Fcobra%2FREADME.md) 你可以查看更多关于生成器的资料。

###### 使用 Cobra 库

要手动接入 Cobra，您需要创建一个 `main.go` 文件和 `rootCmd` 文件。您可以选择提供合适的其他命令。

**创建 rootCmd**

Cobra 不需要任何特殊的构造函数。只需创建您的命令。

理想情况下，将其放置在 `/cmd/root.go` 中：

```go
go 体验AI代码助手 代码解读复制代码// rootCmd 代表没有调用子命令时的基础命令
var rootCmd = &cobra.Command{
	Use:   "hugo",
	Short: "Hugo is a very fast static site generator",
  Long: `A Fast and Flexible Static Site Generator built with
                love by spf13 and friends in Go.
                Complete documentation is available at http://hugo.spf13.com`,
  // 如果有相关的 action 要执行，请取消下面这行代码的注释
  // Run: func(cmd *cobra.Command, args []string) { },
}

// Execute 将所有子命令添加到root命令并适当设置标志。
// 这由 main.main() 调用。它只需要对 rootCmd 调用一次。
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
```

您还将在 `init()` 函数中定义标志并处理配置。例子如下：

```go
go 体验AI代码助手 代码解读复制代码// cmd/root.go
package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"

	homedir "github.com/mitchellh/go-homedir"
	"github.com/spf13/viper"
)

var cfgFile string
var projectBase string
var userLicense string

// rootCmd 代表没有调用子命令时的基础命令
var rootCmd = &cobra.Command{
	Use:   "hugo",
	Short: "Hugo is a very fast static site generator",
  Long: `A Fast and Flexible Static Site Generator built with
                love by spf13 and friends in Go.
                Complete documentation is available at http://hugo.spf13.com`,
  // 如果有相关的 action 要执行，请取消下面这行代码的注释
  // Run: func(cmd *cobra.Command, args []string) { },
}

// Execute 将所有子命令添加到root命令并适当设置标志。会被 main.main() 调用一次。
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)
	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.cobra.yaml)")
	rootCmd.PersistentFlags().StringVarP(&projectBase, "projectbase", "b", "", "base project directory eg. github.com/spf13/")
	rootCmd.PersistentFlags().StringP("author", "a", "YOUR NAME", "Author name for copyright attribution")
	rootCmd.PersistentFlags().StringVarP(&userLicense, "license", "l", "", "Name of license for the project (can provide `licensetext` in config)")
	rootCmd.PersistentFlags().Bool("viper", true, "Use Viper for configuration")
	viper.BindPFlag("author", rootCmd.PersistentFlags().Lookup("author"))
	viper.BindPFlag("projectbase", rootCmd.PersistentFlags().Lookup("projectbase"))
	viper.BindPFlag("useViper", rootCmd.PersistentFlags().Lookup("viper"))
	viper.SetDefault("author", "NAME HERE <EMAIL ADDRESS>")
	viper.SetDefault("license", "apache")
}

func initConfig() {
	// Don't forget to read config either from cfgFile or from home directory!
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
	} else {
		// Find home directory.
		home, err := homedir.Dir()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		// Search config in home directory with name ".cobra" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigName(".cobra")
	}

	if err := viper.ReadInConfig(); err != nil {
		fmt.Println("Can't read config:", err)
		os.Exit(1)
	}
}
```

**创建 main.go**

有了根命令，你需要一个 main 函数去执行它。为了清晰起见，`Execute` 应该在根目录上运行，尽管可以在任何命令上调用它。

在 Cobra 应用中，`main.go` 是非常简单的。它只有一个作用——初始化 Cobra。

```go
go 体验AI代码助手 代码解读复制代码// main.go
package main

import (
  "{pathToYourApp}/cmd"
)

func main() {
  cmd.Execute()
}
```

**创建额外的命令**

可以定义其他命令，并且通常在 `cmd/` 目录中为每个命令提供自己的文件。

如果要创建 `version` 命令，则可以创建 `cmd/version.go` 并使用以下命令进行填充：

```go
go 体验AI代码助手 代码解读复制代码// cmd/version.go
package cmd

import (
  "fmt"

  "github.com/spf13/cobra"
)

func init() {
  rootCmd.AddCommand(versionCmd)
}

var versionCmd = &cobra.Command{
  Use:   "version",
  Short: "Print the version number of Hugo",
  Long:  `All software has versions. This is Hugo's`,
  Run: func(cmd *cobra.Command, args []string) {
    fmt.Println("Hugo Static Site Generator v0.9 -- HEAD")
  },
}
```

##### 使用标志

标志提供修饰符以控制命令的操作方式。

由于标志是在不同位置定义和使用的，我们需要在外部定义一个具有正确作用域的变量，以分配要使用的标志。

```go
go 体验AI代码助手 代码解读复制代码var verbose bool
var source string
```

这里有两种不同分配标志的方法。

###### 持久标志

标志可以是 "persistent" 的，这意味着该标志将可用于分配给它的命令以及该命令下的每个命令。对于全局标志，将标志分配为根上的持久标志。

```go
go

 体验AI代码助手
 代码解读
复制代码rootCmd.PersistentFlags().BoolVarP(&verbose, "verbose", "v", false, "verbose output")
```

###### 本地标志

也可以在本地分配一个标志，该标志仅适用于该特定命令。

```go
go

 体验AI代码助手
 代码解读
复制代码rootCmd.Flags().StringVarP(&source, "source", "s", "", "Source directory to read from")
```

###### 父命令上的本地标志

默认情况下，Cobra 仅解析目标命令上的本地标志，而忽略父命令上的任何本地标志。通过启用 `Command.TraverseChildren`，Cobra 将在执行目标命令之前解析每个命令上的本地标志

```go
go 体验AI代码助手 代码解读复制代码command := cobra.Command{
  Use: "print [OPTIONS] [COMMANDS]",
  TraverseChildren: true,
}
```

###### 用配置绑定标志

您还可以将标志与 [viper](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fspf13%2Fviper) 绑定：

```go
go 体验AI代码助手 代码解读复制代码var author string

func init() {
  rootCmd.PersistentFlags().StringVar(&author, "author", "YOUR NAME", "Author name for copyright attribution")
  viper.BindPFlag("author", rootCmd.PersistentFlags().Lookup("author"))
}
```

在此示例中，持久标记 `author` 与 viper 绑定。请注意，当用户未提供 `--author` 标志时，变量 `author` 不会设置为 `config` 中的值。

更多信息请查看 [viper](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fspf13%2Fviper)。

###### 必需标志

标志默认是可选的。如果你想在缺少标志时命令报错，请设置该标志为必需：

```go
go 体验AI代码助手 代码解读复制代码var region string

rootCmd.Flags().StringVarP(&region, "region", "r", "", "AWS region (required)")
rootCmd.MarkFlagRequired("region")
```

##### 位置和自定义参数

可以使用 Command 的 Args 字段指定位置参数的验证。

下面的验证符是内置的：

- `NoArgs` - 如果有任何位置参数，该命令将报告错误。
- `ArbitraryArgs` - 命令将接受任意参数
- `OnlyValidArgs` - 如果 Command 的 `ValidArgs` 字段中不存在该位置参数，则该命令将报告错误。
- `MinimumNArgs(int)` - 如果不存在至少 N 个位置参数，则该命令将报告错误。
- `MaximumNArgs(int)` - 如果存在超过 N 个位置参数，则该命令将报告错误。
- `ExactArgs(int)` - 如果不存在 N 个位置参数，则该命令将报告错误。
- `ExactValidArgs(int)` - 如果没有确切的 N 个位置参数，或者如果 Command 的 ValidArgs 字段中不存在该位置参数，则该命令将报告并出错。
- `RangeArgs(min, max)` - 如果 args 的数目不在期望的 args 的最小和最大数目之间，则该命令将报告并出错。

内置验证符使用实例：

```go
go 体验AI代码助手 代码解读复制代码var cmd = &cobra.Command{
	Use:   "hello",
	Short: "hello",
	Args:  cobra.MinimumNArgs(2),
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Hello, World!")
	},
}
```

> 如果只传递一个位置参数会报 `Error: requires at least 2 arg(s), only received 1` 的警告。

设置自定义验证器的示例：

```go
go 体验AI代码助手 代码解读复制代码var cmd = &cobra.Command{
  Short: "hello",
  Args: func(cmd *cobra.Command, args []string) error {
    if len(args) < 1 {
      return errors.New("requires at least one arg")
    }
    if myapp.IsValidColor(args[0]) {
      return nil
    }
    return fmt.Errorf("invalid color specified: %s", args[0])
  },
  Run: func(cmd *cobra.Command, args []string) {
    fmt.Println("Hello, World!")
  },
}
```

###### 示例

在下面的例子中，我们定义了三个命令。两个在顶层，一个（`cmdTimes`）是子命令。在这种情况下，根目录不可执行，这意味着需要一个子命令。通过不为 `rootCmd` 提供 `Run` 来实现。

我们只为一个命令定义了一个标志。

关于标志的文档在 [pflag][github.com/spf13/pflag…](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fspf13%2Fpflag)%E3%80%82)

```go
go 体验AI代码助手 代码解读复制代码package main

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"
)

func main() {
	var echoTimes int

	var cmdPrint = &cobra.Command{
		Use:   "Print [string to print]",
		Short: "Print anything to the screen",
		Long: `print is for printing anything back to the screen.
For many years people have printed back to the screen.`,
		Args: cobra.MinimumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println("Print: " + strings.Join(args, " "))
		},
	}

	var cmdEcho = &cobra.Command{
		Use:   "echo [string to echo]",
		Short: "Echo anything to the screen",
		Long: `echo is for echoing anything back.
Echo works a lot like print, except it has a child command.`,
		Args: cobra.MinimumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println("Print: " + strings.Join(args, " "))
		},
	}

	var cmdTimes = &cobra.Command{
		Use:   "times [# times] [string to echo]",
		Short: "Echo anyting to the screen more times",
		Long: `echo things multiple times back to the user y providing
		a count and a string.`,
		Args: cobra.MinimumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			for i := 0; i < echoTimes; i++ {
				fmt.Println("Echo: " + strings.Join(args, " "))
			}
		},
	}

	cmdTimes.Flags().IntVarP(&echoTimes, "times", "t", 1, "times to echo the input")

	// 设置根命令
	var rootCmd = &cobra.Command{Use: "app"}
	rootCmd.AddCommand(cmdPrint, cmdEcho)
	cmdEcho.AddCommand(cmdTimes)

	// 初始化应用
	rootCmd.Execute()
}
```

更复杂的应用，请参考 [Hugo](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fgohugoio%2Fhugo) 或者 [GitHub CLI](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fcli%2Fcli)。

###### 帮助命令

当你添加了子命令，Cobra 会自动添加一些帮助命令。当你执行 `app help` 命令时会显示帮助信息。另外，`help` 还支持其他命令作为输入参数。举例来说，你有一个没有额外配置的 `create` 命令，`app help create` 是有效的。每一个命令还会自动获取一个 `--help` 标志。

###### 示例

以下输出由 Cobra 自动生成。 除了命令和标志定义外，什么都不需要。

![img](./assets/4ab343af6ed24362b1926bb8fd0a23b0tplv-k3u1fbpfcp-zoom-in-crop-mark1512000.webp)

`help` 就像其他命令一样。并没有特殊的逻辑或行为。实际上，你可以根据需要提供自己的服务。

###### 定义你自己的 help

你可以使用下面的方法提供你自己的 Help 命令或模板。

```go
go 体验AI代码助手 代码解读复制代码cmd.SetHelpCommand(cmd *Command)
cmd.setHelpCommand(f func(*Command, []string))
cmd.setHelpTemplate(s string)
```

后两者也适用于所有子命令。

##### 使用信息

当用户提供无效的标志或无效的命令时，Cobra 会通过向用户显示 `usage` 进行响应。

![img](./assets/0f1975f1c578418ebd37e81b682e69ddtplv-k3u1fbpfcp-zoom-in-crop-mark1512000.webp)

###### 定义你自己的使用信息

你可以提供你自己的 usage 函数或模板。像 `help` 一样，函数和模板可通过公共方法重写：

```go
go 体验AI代码助手 代码解读复制代码cmd.SetUsageFunc(f func(*Command) error)
cmd.SetUsageTemplate(s string)
```

可以参考 [GitHub CLI](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fcli%2Fcli%2Fblob%2Fdcf5a27f5343ea0e9b3ef71ca37a4c3948102667%2Fpkg%2Fcmd%2Froot%2Froot.go%23L63) 的写法。

##### 版本标志

如果给根命令设置了 `Version` 字段，Cobra 会添加一个顶级的 `--version` 标志。运行带有 `–version` 标志的应用程序，将使用版本模板将版本打印到 stdout。模板可以使用 `cmd.SetVersionTemplate(s string)` 函数自定义。

> `SetVersionTemplate` 的使用可以参考 [GitHub CLI](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fcli%2Fcli%2Fblob%2Fdcf5a27f5343ea0e9b3ef71ca37a4c3948102667%2Fpkg%2Fcmd%2Froot%2Froot.go%23L67)

##### PreRun 和 PostRun Hooks

可以在执行命令之前和之后运行一个函数。`PersistentPreRun` 和 `PreRun` 函数将在 `Run` 之前执行。`PersistentPostRun` 和 `PostRun` 会在 `Run` 之后运行。如果子级未声明自己的 `Persistent * Run` 函数，则子级将继承父级的。这些函数的执行顺续如下：

- PersistentPreRun
- PreRun
- Run
- PostRun
- PersistentPostRun

下面这个包含了两个命令的例子使用了这些特性。当子命令执行时，它会运行根命令的 `PersistentPreRun`，但是不会运行根命令的 `PersistentPostRun`：

```go
go 体验AI代码助手 代码解读复制代码package main

import (
	"fmt"

	"github.com/spf13/cobra"
)

func main() {
	var rootCmd = &cobra.Command{
		Use:   "root [sub]",
		Short: "My root command",
		PersistentPreRun: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside rootCmd PersistentPreRun with args: %v\n", args)
		},
		PreRun: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside rootCmd PreRun with args: %v\n", args)
		},
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside rootCmd Run with args: %v\n", args)
		},
		PostRun: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside rootCmd PostRun with args: %v\n", args)
		},
		PersistentPostRun: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside rootCmd PersistentPostRun with args: %v\n", args)
		},
	}

	subCmd := &cobra.Command{
		Use:   "sub [no options!]",
		Short: "My subcommand",
		PreRun: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside subCmd PreRun with args: %v\n", args)
		},
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside subCmd Run with args: %v\n", args)
		},
		PostRun: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside subCmd PostRun with args: %v\n", args)
		},
		PersistentPostRun: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Inside subCmd PersistentPostRun with args: %v\n", args)
		},
	}

	rootCmd.AddCommand(subCmd)

	rootCmd.SetArgs([]string{""})
	rootCmd.Execute()
	fmt.Println()
	rootCmd.SetArgs([]string{"sub", "arg1", "arg2"})
	rootCmd.Execute()
}
```

输出：

```sh
sh 体验AI代码助手 代码解读复制代码Inside rootCmd PersistentPreRun with args: []
Inside rootCmd PreRun with args: []
Inside rootCmd Run with args: []
Inside rootCmd PostRun with args: []
Inside rootCmd PersistentPostRun with args: []

Inside rootCmd PersistentPreRun with args: [arg1 arg2]
Inside subCmd PreRun with args: [arg1 arg2]
Inside subCmd Run with args: [arg1 arg2]
Inside subCmd PostRun with args: [arg1 arg2]
Inside subCmd PersistentPostRun with args: [arg1 arg2]
```

##### "unknown command" 时的提示

当 `"unknown command"` 错误发生时，Cobra 会自动打印提示。这和 git 命令的行为一致。比如

```sh
sh 体验AI代码助手 代码解读复制代码$ hugo srever
Error: unknown command "srever" for "hugo"

Did you mean this?
        server

Run 'hugo --help' for usage.
```

系统会根据注册的每个子命令自动生成建议，并使用[萊文斯坦距離](https://link.juejin.cn?target=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%E8%90%8A%E6%96%87%E6%96%AF%E5%9D%A6%E8%B7%9D%E9%9B%A2)的实现。每个匹配最小距离 2（忽略大小写）的注册命令都将显示为建议。

如果需要禁用建议或在命令中调整字符串距离，请使用：

```go
go

 体验AI代码助手
 代码解读
复制代码cmd.DisableSuggestions = true
```

或

```go
go

 体验AI代码助手
 代码解读
复制代码cmd.SuggestionsMinimumDistance = 1
```

您还可以使用 `SuggestFor` 属性显式为给定命令设置建议的名称。这样就可以针对不是距离很近的字符串提出建议，但是对于您的命令集和不希望使用别名的命令来说，它们都是有意义的。比如：

```sh
sh 体验AI代码助手 代码解读复制代码$ kubectl remove
Error: unknown command "remove" for "kubectl"

Did you mean this?
        delete

Run 'kubectl help' for usage.
```

###### 为你的命令生成文档

Cobra 可以基于子命令、标志等生成文档。可用格式如下：

- [Markdown](https://link.juejin.cn?target=https%3A%2F%2Fyoungjuning.js.org%2Fcobra%2Fmd_docs)
- [ReStructured Text](https://link.juejin.cn?target=https%3A%2F%2Fyoungjuning.js.org%2Fcobra%2Frest_docs)
- [Man Page](https://link.juejin.cn?target=https%3A%2F%2Fyoungjuning.js.org%2Fcobra%2Fman_docs)

###### 为你的命令生成 Bash Completions

Cobra 可以生成 bash-completion 文件。如果你给你的命令添加了更多的信息，这些自动提示的分析会非常强大和灵活。更是信息请阅读[Bash Completions](https://link.juejin.cn?target=https%3A%2F%2Fyoungjuning.js.org%2Fcobra%2Fbash_completions)

### ORM



在 go 社区中，对于数据库交互这一块，有两派人，一派人更喜欢简洁的`sqlx`这一类的库，功能并不那么强大但是自己可以时时刻刻把控 sql，性能优化到极致。另一派人喜欢为了开发效率而生的 ORM，可以省去开发过程中许多不必要的麻烦。而提到 ORM，在 go 语言社区中就绝对绕不开`gorm`，它是一个非常老牌的 ORM，与之类似的还有相对比较年轻的`xorm`，`ent`等。这篇文章讲的就是关于 gorm 的内容，本文只是对它的基础入门内容做一个讲解，权当是抛砖引玉，想要了解更深的细节可以阅读官方文档，它的中文文档已经相当完善了，并且笔者也是 gorm 文档的翻译人员之一。

#### [特点](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#特点)

- 全功能 ORM
- 关联 (拥有一个，拥有多个，属于，多对多，多态，单表继承)
- Create，Save，Update，Delete，Find 中钩子方法
- 支持 Preload、Joins 的预加载
- 事务，嵌套事务，Save Point，Rollback To to Saved Point
- Context、预编译模式、DryRun 模式
- 批量插入，FindInBatches，Find/Create with Map，使用 SQL 表达式、Context Valuer 进行 CRUD
- SQL 构建器，Upsert，锁，Optimizer/Index/Comment Hint，命名参数，子查询
- 复合主键，索引，约束
- 自动迁移
- 自定义 Logger
- 灵活的可扩展插件 API：Database Resolver（多数据库，读写分离）、Prometheus…
- 每个特性都经过了测试的重重考验
- 开发者友好

gorm 当然也有一些缺点，比如几乎所有的方法参数都是空接口类型，不去看文档恐怕根本就不知道到底该传什么参数，有时候可以传结构体，有时候可以传字符串，有时候可以传 map，有时候可以传切片，语义比较模糊，并且很多情况还是需要自己手写 SQL。

作为替代的有两个 orm 可以试一试，第一个是`aorm`，刚开源不久，它不再需要去自己手写表的字段名，大多情况下都是链式操作，基于反射实现，由于 star 数目不多，可以再观望下。第二个就是`ent`，是`facebook`开源的 orm，它同样支持链式操作，并且大多数情况下不需要自己去手写 SQL，它的设计理念上是基于图（数据结构里面的那个图），实现上基于代码生成而非反射（比较认同这个），但是文档是全英文的，有一定的上手门槛。

#### [安装](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#安装)

安装 gorm 库



```
$ go get -u gorm.io/gorm
```

#### [连接](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#连接)

gorm 目前支持以下几种数据库

- MySQL ：`"gorm.io/driver/mysql"`
- PostgreSQL： `"gorm.io/driver/postgres"`
- SQLite：`"gorm.io/driver/sqlite"`
- SQL Server：`"gorm.io/driver/sqlserver"`
- TIDB：`"gorm.io/driver/mysql"`，TIDB 兼容 mysql 协议
- ClickHouse：`"gorm.io/driver/clickhouse"`

除此之外，还有一些其它的数据库驱动是由第三方开发者提供的，比如 oracle 的驱动[CengSin/oracle](https://github.com/CengSin/oracle)。本文接下来将使用 MySQL 来进行演示，使用的什么数据库，就需要安装什么驱动，这里安装 Mysql 的 gorm 驱动。



```
$ go get -u gorm.io/driver/mysql
```

然后使用 dsn（data source name）连接到数据库，驱动库会自行将 dsn 解析为对应的配置



```
package main

import (
  "gorm.io/driver/mysql"
  "gorm.io/gorm"
  "log/slog"
)

func main() {
  dsn := "root:123456@tcp(192.168.48.138:3306)/hello?charset=utf8mb4&parseTime=True&loc=Local"
  db, err := gorm.Open(mysql.Open(dsn))
  if err != nil {
    slog.Error("db connect error", err)
  }
  slog.Info("db connect success")
}
```

或者手动传入配置



```
package main

import (
  "gorm.io/driver/mysql"
  "gorm.io/gorm"
  "log/slog"
)

func main() {
  db, err := gorm.Open(mysql.New(mysql.Config{}))
  if err != nil {
    slog.Error("db connect error", err)
  }
  slog.Info("db connect success")
}
```

两种方法都是等价的，看自己使用习惯。

##### [连接配置](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#连接配置)

通过传入`gorm.Config`配置结构体，我们可以控制 gorm 的一些行为



```
db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
```

下面是一些简单的解释，使用时可以根据自己的需求来进行配置。



```
type Config struct {
  // 禁用默认事务，gorm在单个创建和更新时都会开启事务以保持数据一致性
  SkipDefaultTransaction bool
  // 自定义的命名策略
  NamingStrategy schema.Namer
  // 保存完整的关联
  FullSaveAssociations bool
  // 自定义logger
  Logger logger.Interface
  // 自定义nowfunc，用于注入CreatedAt和UpdatedAt字段
  NowFunc func() time.Time
  // 只生成sql不执行
  DryRun bool
  // 使用预编译语句
  PrepareStmt bool
  // 建立连接后，ping一下数据库
  DisableAutomaticPing bool
  // 在迁移数据库时忽略外键
  DisableForeignKeyConstraintWhenMigrating bool
  // 在迁移数据库时忽略关联引用
  IgnoreRelationshipsWhenMigrating bool
  // 禁用嵌套事务
  DisableNestedTransaction bool
  // 运行全局更新，就是不加where的update
  AllowGlobalUpdate bool
  // 对表的所有字段进行查询
  QueryFields bool
  // 批量创建的size
  CreateBatchSize int
  // 启用错误转换
  TranslateError bool

  // ClauseBuilders clause builder
  ClauseBuilders map[string]clause.ClauseBuilder
  // ConnPool db conn pool
  ConnPool ConnPool
  // Dialector database dialector
  Dialector
  // Plugins registered plugins
  Plugins map[string]Plugin

  callbacks  *callbacks
  cacheStore *sync.Map
}
```

#### [模型](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#模型)

在 gorm 中，模型与数据库表相对应，它通常由结构体的方式展现，例如下面的结构体。



```
type Person struct {
  Id      uint
  Name    string
  Address string
  Mom     string
  Dad     string
}
```

结构体的内部可以由基本数据类型与实现了`sql.Scanner`和 `sql.Valuer`接口的类型组成。在默认情况下，`Person`结构体所映射的表名为`perons`，其为蛇形复数风格，以下划线分隔。列名同样是以蛇形风格，比如`Id`对应列名`id`，gorm 同样也提供了一些方式来对其进行配置。

##### [指定列名](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#指定列名)

通过结构体标签，我们可以对结构体字段指定列名，这样在实体映射的时候，gorm 就会使用指定的列名。



```
type Person struct {
  Id      uint   `gorm:"column:ID;"`
  Name    string `gorm:"column:Name;"`
  Address string
  Mom     string
  Dad     string
}
```

##### [指定表名](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#指定表名)

通过实现`Table`接口，就可以指定表明，它只有一个方法，就是返回表名。



```
type Tabler interface {
  TableName() string
}
```

在实现的方法中，它返回了字符串`person`，在数据库迁移的时候，gorm 会创建名为`person`的表。



```
type Person struct {
  Id      uint   `gorm:"column:ID;"`
  Name    string `gorm:"column:Name;"`
  Address string
  Mom     string
  Dad     string
}

func (p Person) TableName() string {
  return "person"
}
```

对于命名策略，也可以在创建连接时传入自己的策略实现来达到自定义的效果。

##### [时间追踪](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#时间追踪)



```
type Person struct {
  Id      uint
  Name    string
  Address string
  Mom     string
  Dad     string

  CreatedAt sql.NullTime
  UpdatedAt sql.NullTime
}

func (p Person) TableName() string {
  return "person"
}
```

当包含`CreatedAt`或`UpdatedAt`字段时，在创建或更新记录时，如果其为零值，那么 gorm 会自动使用`time.Now()`来设置时间。



```
db.Create(&Person{
    Name:    "jack",
    Address: "usa",
    Mom:     "lili",
    Dad:     "tom",
  })

// INSERT INTO `person` (`name`,`address`,`mom`,`dad`,`created_at`,`updated_at`) VALUES ('jack','usa','lili','tom','2023-10-25 14:43:57.16','2023-10-25 14:43:57.16')
```

gorm 也支持时间戳追踪



```
type Person struct {
  Id      uint   `gorm:"primaryKey;"`
  Name    string `gorm:"primaryKey;"`
  Address string
  Mom     string
  Dad     string

  // nanoseconds
  CreatedAt uint64 `gorm:"autoCreateTime:nano;"`
  // milliseconds
  UpdatedAt uint64 `gorm:"autoUpdateTime;milli;"`
}
```

那么在`Create`执行时，等价于下面的 SQL



```
INSERT INTO `person` (`name`,`address`,`mom`,`dad`,`created_at`,`updated_at`) VALUES ('jack','usa','lili','tom',1698216540519000000,1698216540)
```

在实际情况中，如果有时间追踪的需要，我更推荐后端存储时间戳，在跨时区的情况下，处理更为简单。

##### [Model](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#model)

gorm 提供了一个预设的`Model`结构体，它包含 ID 主键，以及两个时间追踪字段，和一个软删除记录字段。



```
type Model struct {
    ID        uint `gorm:"primarykey"`
    CreatedAt time.Time
    UpdatedAt time.Time
    DeletedAt DeletedAt `gorm:"index"`
}
```

在使用时只需要将其嵌入到你的实体模型中即可。



```
type Order struct {
  gorm.Model
  Name string
}
```

这样它就会自动具备`gorm.Model`所有的特性。

##### [主键](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#主键)

在默认情况下，名为`Id`的字段就是主键，使用结构体标签可以指定主键字段



```
type Person struct {
  Id      uint `gorm:"primaryKey;"`
  Name    string
  Address string
  Mom     string
  Dad     string

  CreatedAt sql.NullTime
  UpdatedAt sql.NullTime
}
```

多个字段形成联合主键



```
type Person struct {
  Id      uint `gorm:"primaryKey;"`
  Name    string `gorm:"primaryKey;"`
  Address string
  Mom     string
  Dad     string

  CreatedAt sql.NullTime
  UpdatedAt sql.NullTime
}
```

##### [索引](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#索引)

通过`index`结构体标签可以指定列索引



```
type Person struct {
  Id      uint   `gorm:"primaryKey;"`
  Name    string `gorm:"primaryKey;"`
    Address string `gorm:"index:idx_addr,unique,sort:desc;"`
  Mom     string
  Dad     string

  // nanoseconds
  CreatedAt uint64 `gorm:"autoCreateTime:nano;"`
  // milliseconds
  UpdatedAt uint64 `gorm:"autoUpdateTime;milli;"`
}
```

在上面的结构体中，对`Address`字段建立了唯一索引。两个字段使用同一个名字的索引就会创建复合索引



```
type Person struct {
    Id      uint   `gorm:"primaryKey;"`
    Name    string `gorm:"primaryKey;"`
    Address string `gorm:"index:idx_addr,unique;"`
    School  string `gorm:"index:idx_addr,unique;"`
    Mom     string
    Dad     string

    // nanoseconds
    CreatedAt uint64 `gorm:"autoCreateTime:nano;"`
    // milliseconds
    UpdatedAt uint64 `gorm:"autoUpdateTime;milli;"`
}
```

##### [外键](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#外键)

在结构体中定义外键关系，是通过嵌入结构体的方式来进行的，比如



```
type Person struct {
  Id   uint `gorm:"primaryKey;"`
  Name string

  MomId uint
  Mom   Mom `gorm:"foreignKey:MomId;"`

  DadId uint
  Dad   Dad `gorm:"foreignKey:DadId;"`
}

type Mom struct {
  Id   uint
  Name string

  Persons []Person `gorm:"foreignKey:MomId;"`
}

type Dad struct {
  Id   uint
  Name string

  Persons []Person `gorm:"foreignKey:DadId;"`
}
```

例子中，`Person`结构体有两个外键，分别引用了`Dad`和`Mom`两个结构体的主键，默认引用也就是主键。`Person`对于`Dad`和`Mom`是一对一的关系，一个人只能有一个爸爸和妈妈。`Dad`和`Mom`对于`Person`是一对多的关系，因为爸爸和妈妈可以有多个孩子。



```
Mom   Mom `gorm:"foreignKey:MomId;"`
```

嵌入结构体的作用是为了方便指定外键和引用，在默认情况下，外键字段名格式是`被引用类型名+Id`，比如`MomId`。默认情况下是引用的主键，通过结构体标签可以指定引用某一个字段



```
type Person struct {
  Id   uint `gorm:"primaryKey;"`
  Name string

  MomId uint
  Mom   Mom `gorm:"foreignKey:MomId;references:Sid;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`

  DadId uint
  Dad   Dad `gorm:"foreignKey:DadId;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
}

type Mom struct {
  Id   uint
  Sid  uint `gorm:"uniqueIndex;"`
  Name string

  Persons []Person `gorm:"foreignKey:MomId;"`
}
```

其中`constraint:OnUpdate:CASCADE,OnDelete:SET NULL;`便是定义的外键约束。

##### [钩子](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#钩子)

一个实体模型可以自定义钩子

- 创建
- 更新
- 删除
- 查询

对应的接口分别如下



```
// 创建前触发
type BeforeCreateInterface interface {
    BeforeCreate(*gorm.DB) error
}

// 创建后触发
type AfterCreateInterface interface {
    AfterCreate(*gorm.DB) error
}

// 更新前触发
type BeforeUpdateInterface interface {
    BeforeUpdate(*gorm.DB) error
}

// 更新后触发
type AfterUpdateInterface interface {
    AfterUpdate(*gorm.DB) error
}

// 保存前触发
type BeforeSaveInterface interface {
    BeforeSave(*gorm.DB) error
}

// 保存后触发
type AfterSaveInterface interface {
    AfterSave(*gorm.DB) error
}

// 删除前触发
type BeforeDeleteInterface interface {
    BeforeDelete(*gorm.DB) error
}

// 删除后触发
type AfterDeleteInterface interface {
    AfterDelete(*gorm.DB) error
}

// 查询后触发
type AfterFindInterface interface {
    AfterFind(*gorm.DB) error
}
```

结构体通过实现这些接口，可以自定义一些行为。

##### [标签](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#标签)

下面是 gorm 支持的一些标签

| 标签名                   | 说明                                                         |
| :----------------------- | :----------------------------------------------------------- |
| `column`                 | 指定 db 列名                                                 |
| `type`                   | 列数据类型，推荐使用兼容性好的通用类型，例如：所有数据库都支持 bool、int、uint、float、string、time、bytes 并且可以和其他标签一起使用，例如：`not null`、`size`, `autoIncrement`… 像 `varbinary(8)` 这样指定数据库数据类型也是支持的。在使用指定数据库数据类型时，它需要是完整的数据库数据类型，如：`MEDIUMINT UNSIGNED not NULL AUTO_INCREMENT` |
| `serializer`             | 指定将数据序列化或反序列化到数据库中的序列化器, 例如: `serializer:json/gob/unixtime` |
| `size`                   | 定义列数据类型的大小或长度，例如 `size: 256`                 |
| `primaryKey`             | 将列定义为主键                                               |
| `unique`                 | 将列定义为唯一键                                             |
| `default`                | 定义列的默认值                                               |
| `precision`              | 指定列的精度                                                 |
| `scale`                  | 指定列大小                                                   |
| `not null`               | 指定列为 NOT NULL                                            |
| `autoIncrement`          | 指定列为自动增长                                             |
| `autoIncrementIncrement` | 自动步长，控制连续记录之间的间隔                             |
| `embedded`               | 嵌套字段                                                     |
| `embeddedPrefix`         | 嵌入字段的列名前缀                                           |
| `autoCreateTime`         | 创建时追踪当前时间，对于 `int` 字段，它会追踪时间戳秒数，您可以使用 `nano`/`milli` 来追踪纳秒、毫秒时间戳，例如：`autoCreateTime:nano` |
| `autoUpdateTime`         | 创建/更新时追踪当前时间，对于 `int` 字段，它会追踪时间戳秒数，您可以使用 `nano`/`milli` 来追踪纳秒、毫秒时间戳，例如：`autoUpdateTime:milli` |
| `index`                  | 根据参数创建索引，多个字段使用相同的名称则创建复合索引，查看 [索引 open in new window](https://gorm.io/zh_CN/docs/indexes.html) 获取详情 |
| `uniqueIndex`            | 与 `index` 相同，但创建的是唯一索引                          |
| `check`                  | 创建检查约束，例如 `check:age > 13`，查看 [约束 open in new window](https://gorm.io/zh_CN/docs/constraints.html) 获取详情 |
| `<-`                     | 设置字段写入的权限， `<-:create` 只创建、`<-:update` 只更新、`<-:false` 无写入权限、`<-` 创建和更新权限 |
| `->`                     | 设置字段读的权限，`->:false` 无读权限                        |
| `-`                      | 忽略该字段，`-` 表示无读写，`-:migration` 表示无迁移权限，`-:all` 表示无读写迁移权限 |
| `comment`                | 迁移时为字段添加注释                                         |
| `foreignKey`             | 指定当前模型的列作为连接表的外键                             |
| `references`             | 指定引用表的列名，其将被映射为连接表外键                     |
| `polymorphic`            | 指定多态类型，比如模型名                                     |
| `polymorphicValue`       | 指定多态值、默认表名                                         |
| `many2many`              | 指定连接表表名                                               |
| `joinForeignKey`         | 指定连接表的外键列名，其将被映射到当前表                     |
| `joinReferences`         | 指定连接表的外键列名，其将被映射到引用表                     |
| `constraint`             | 关系约束，例如：`OnUpdate`、`OnDelete`                       |

##### [迁移](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#迁移)

`AutoMigrate`方法会帮助我们进行自动迁移，它会创建表，约束，索引，外键等等。



```
func (db *DB) AutoMigrate(dst ...interface{}) error
```

例如



```
type Person struct {
  Id      uint   `gorm:"primaryKey;"`
  Name    string `gorm:"type:varchar(100);uniqueIndex;"`
  Address string
}

type Order struct {
  Id   uint
  Name string
}

db.AutoMigrate(Person{}, Order{})
// CREATE TABLE `person` (`id` bigint unsigned AUTO_INCREMENT,`name` varchar(100),`address` longtext,PRIMARY KEY (`id`),UNIQUE INDEX `idx_person_name` (`name`))
// CREATE TABLE `orders` (`id` bigint unsigned AUTO_INCREMENT,`name` longtext,PRIMARY KEY (`id`))
```

或者也可以我们手动来操作，通过`Migrator`方法访问`Migrator`接口



```
func (db *DB) Migrator() Migrator
```

它支持以下接口方法



```
type Migrator interface {
  // AutoMigrate
  AutoMigrate(dst ...interface{}) error

  // Database
  CurrentDatabase() string
  FullDataTypeOf(*schema.Field) clause.Expr
  GetTypeAliases(databaseTypeName string) []string

  // Tables
  CreateTable(dst ...interface{}) error
  DropTable(dst ...interface{}) error
  HasTable(dst interface{}) bool
  RenameTable(oldName, newName interface{}) error
  GetTables() (tableList []string, err error)
  TableType(dst interface{}) (TableType, error)

  // Columns
  AddColumn(dst interface{}, field string) error
  DropColumn(dst interface{}, field string) error
  AlterColumn(dst interface{}, field string) error
  MigrateColumn(dst interface{}, field *schema.Field, columnType ColumnType) error
  HasColumn(dst interface{}, field string) bool
  RenameColumn(dst interface{}, oldName, field string) error
  ColumnTypes(dst interface{}) ([]ColumnType, error)

  // Views
  CreateView(name string, option ViewOption) error
  DropView(name string) error

  // Constraints
  CreateConstraint(dst interface{}, name string) error
  DropConstraint(dst interface{}, name string) error
  HasConstraint(dst interface{}, name string) bool

  // Indexes
  CreateIndex(dst interface{}, name string) error
  DropIndex(dst interface{}, name string) error
  HasIndex(dst interface{}, name string) bool
  RenameIndex(dst interface{}, oldName, newName string) error
  GetIndexes(dst interface{}) ([]Index, error)
}
```

方法列表中涉及到了数据库，表，列，视图，索引，约束多个维度，对需要自定义的用户来说可以更加精细化的操作。

##### [指定表注释](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#指定表注释)

在迁移时，如果想要添加表注释，可以按照如下方法来设置



```
db.Set("gorm:table_options", " comment 'person table'").Migrator().CreateTable(Person{})
```

需要注意的是如果使用的是`AutoMigrate()`方法来进行迁移，且结构体之间具引用关系，gorm 会进行递归先创建引用表，这就会导致被引用表和引用表的注释都是重复的，所以推荐使用`CreateTable`方法来创建。

提示

在创建表时`CreateTable`方法需要保证被引用表比引用表先创建，否则会报错，而`AutoMigrate`方法则不需要，因为它会顺着关系引用关系递归创建。

#### [创建](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#创建)

##### [Create](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#create)

在创建新的记录时，大多数情况都会用到`Create`方法



```
func (db *DB) Create(value interface{}) (tx *DB)
```

现有如下的结构体



```
type Person struct {
  Id   uint `gorm:"primaryKey;"`
  Name string
}
```

创建一条记录



```
user := Person{
    Name: "jack",
}

// 必须传入引用
db = db.Create(&user)

// 执行过程中发生的错误
err = db.Error
// 创建的数目
affected := db.RowsAffected
```

创建完成后，gorm 会将主键写入 user 结构体中，所以这也是为什么必须得传入指针。如果传入的是一个切片，就会批量创建



```
user := []Person{
    {Name: "jack"},
    {Name: "mike"},
    {Name: "lili"},
}

db = db.Create(&user)
```

同样的，gorm 也会将主键写入切片中。当数据量过大时，也可以使用`CreateInBatches`方法分批次创建，因为生成的`INSERT INTO table VALUES (),()`这样的 SQL 语句会变的很长，每个数据库对 SQL 长度是有限制的，所以必要的时候可以选择分批次创建。



```
db = db.CreateInBatches(&user, 50)
```

除此之外，`Save`方法也可以创建记录，它的作用是当主键匹配时就更新记录，否则就插入。



```
func (db *DB) Save(value interface{}) (tx *DB)
```



```
user := []Person{
    {Name: "jack"},
    {Name: "mike"},
    {Name: "lili"},
}

db = db.Save(&user)
```

##### [Upsert](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#upsert)

`Save`方法只能是匹配主键，我们可以通过构建`Clause`来完成更加自定义的 upsert。比如下面这行代码



```
db.Clauses(clause.OnConflict{
    Columns:   []clause.Column{{Name: "name"}},
    DoNothing: false,
    DoUpdates: clause.AssignmentColumns([]string{"address"}),
    UpdateAll: false,
}).Create(&p)
```

它的作用是当字段`name`冲突后，更新字段`address`的值，不冲突的话就会创建一个新的记录。也可以在冲突的时候什么都不做



```
db.Clauses(clause.OnConflict{
    Columns:   []clause.Column{{Name: "name"}},
    DoNothing: true,
}).Create(&p)
```

或者直接更新所有字段



```
db.Clauses(clause.OnConflict{
    Columns:   []clause.Column{{Name: "name"}},
    UpdateAll: true,
}).Create(&p)
```

在使用 upsert 之前，记得给冲突字段添加索引。

#### [查询](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#查询)

##### [First](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#first)

gorm 对于查询而言，提供了相当多的方法可用，第一个就是`First`方法



```
func (db *DB) First(dest interface{}, conds ...interface{}) (tx *DB)
```

它的作用是按照主键升序查找第一条记录，例如



```
var person Person
result := db.First(&person)
err := result.Error
affected := result.RowsAffected
```

传入`dest`指针方便让 gorm 将查询到的数据映射到结构体中。

或者使用`Table`和`Model`方法可以指定查询表，前者接收字符串表名，后者接收实体模型。



```
db.Table("person").Find(&p)
db.Model(Person{}).Find(&p)
```

提示

如果传入的指针元素包含实体模型比如说结构体指针，或者是结构体切片的指针，那么就不需要手动使用指定查哪个表，这个规则适用于所有的增删改查操作。

[Take](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#take)

`Take`方法与`First`类似，区别就是不会根据主键排序。



```
func (db *DB) Take(dest interface{}, conds ...interface{}) (tx *DB)
```



```
var person Person
result := db.Take(&person)
err := result.Error
affected := result.RowsAffected
```

##### [Pluck](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#pluck)

`Pluck`方法用于批量查询一个表的单列，查询的结果可以收集到一个指定类型的切片中，不一定非得是实体类型的切片。



```
func (db *DB) Pluck(column string, dest interface{}) (tx *DB)
```

比如将所有人的地址搜集到一个字符串切片中



```
var adds []string

// SELECT `address` FROM `person` WHERE name IN ('jack','lili')
db.Model(Person{}).Where("name IN ?", []string{"jack", "lili"}).Pluck("address", &adds)
```

其实就等同于



```
db.Select("address").Where("name IN ?", []string{"jack", "lili"}).Find(&adds)
```

##### [Count](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#count)

`Count`方法用于统计实体记录的数量



```
func (db *DB) Count(count *int64) (tx *DB)
```

看一个使用示例



```
var count int64

// SELECT count(*) FROM `person`
db.Model(Person{}).Count(&count)
```

##### [Find](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#find)

批量查询最常用的是`Find`方法



```
func (db *DB) Find(dest interface{}, conds ...interface{}) (tx *DB)
```

它会根据给定的条件查找出所有符合的记录



```
// SELECT * FROM `person`
var ps []Person
db.Find(&ps)
```

##### [Select](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#select)

gorm 在默认情况下是查询所有字段，我们可以通过`Select`方法来指定字段



```
func (db *DB) Select(query interface{}, args ...interface{}) (tx *DB)
```

比如



```
// SELECT `address`,`name` FROM `person` ORDER BY `person`.`id` LIMIT 1
db.Select("address", "name").First(&p)
```

等同于



```
db.Select([]string{"address", "name"}).First(&p)
```

同时，还可以使用`Omit`方法来忽略字段



```
func (db *DB) Omit(columns ...string) (tx *DB)
```

比如



```
// SELECT `person`.`id`,`person`.`name` FROM `person` WHERE id IN (1,2,3,4)
db.Omit("address").Where("id IN ?", []int{1, 2, 3, 4}).Find(&ps)``
```

由`Select`和`Omit`选择或忽略的字段，在创建更新查询的时候都会起作用。

##### [Where](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#where)

条件查询会用到`Where`方法



```
func (db *DB) Where(query interface{}, args ...interface{}) (tx *DB)
```

下面是一个简单的示例



```
var p Person

db.Where("id = ?", 1).First(&p)
```

在链式操作中使用多个`Where`会构建多个`AND`语句，比如



```
// SELECT * FROM `person` WHERE id = 1 AND name = 'jack' ORDER BY `person`.`id` LIMIT 1
db.Where("id = ?", 1).Where("name = ?", "jack").First(&p)
```

或者使用`Or`方法来构建`OR`语句



```
func (db *DB) Or(query interface{}, args ...interface{}) (tx *DB)
```



```
// SELECT * FROM `person` WHERE id = 1 OR name = 'jack' AND address = 'usa' ORDER BY `person`.`id` LIMIT 1
db.Where("id = ?", 1).
    Or("name = ?", "jack").
    Where("address = ?", "usa").
    First(&p)
```

还有`Not`方法，都是类似的



```
func (db *DB) Not(query interface{}, args ...interface{}) (tx *DB)
```



```
// SELECT * FROM `person` WHERE id = 1 OR name = 'jack' AND NOT name = 'mike' AND address = 'usa' ORDER BY `person`.`id` LIMIT 1
db.Where("id = ?", 1).
    Or("name = ?", "jack").
    Not("name = ?", "mike").
    Where("address = ?", "usa").
    First(&p)
```

对于`IN`条件，可以直接在`Where`方法里面传入切片。



```
db.Where("address IN ?", []string{"cn", "us"}).Find(&ps)
```

或者多列`IN`条件，需要用`[][]any`类型来承载参数



```
// SELECT * FROM `person` WHERE (id, name, address) IN ((1,'jack','uk'),(2,'mike','usa'))
db.Where("(id, name, address) IN ?", [][]any{{1, "jack", "uk"}, {2, "mike", "usa"}}).Find(&ps)
```

gorm 支持 where 分组使用，就是将上述几个语句结合起来



```
db.Where(
    db.Where("name IN ?", []string{"cn", "uk"}).Where("id IN ?", []uint{1, 2}),
  ).Or(
    db.Where("name IN ?", []string{"usa", "jp"}).Where("id IN ?", []uint{3, 4}),
  ).Find(&ps)
// SELECT * FROM `person` WHERE (name IN ('cn','uk') AND id IN (1,2)) OR (name IN ('usa','jp') AND id IN (3,4))
```

##### [Order](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#order)

排序会用到`Order`方法



```
func (db *DB) Order(value interface{}) (tx *DB)
```

来看个使用的例子



```
var ps []Person

// SELECT * FROM `person` ORDER BY name ASC, id DESC
db.Order("name ASC, id DESC").Find(&ps)
```

也可以多次调用



```
// SELECT * FROM `person` ORDER BY name ASC, id DESC,address
db.Order("name ASC, id DESC").Order("address").Find(&ps)
```

##### [Limit](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#limit)

`Limit`和`Offset`方法常常用于分页查询



```
func (db *DB) Limit(limit int) (tx *DB)

func (db *DB) Offset(offset int) (tx *DB)
```

下面是一个简单的分页示例



```
var (
    ps   []Person
    page = 2
    size = 10
)

// SELECT * FROM `person` LIMIT 10 OFFSET 10
db.Offset((page - 1) * size).Limit(size).Find(&ps)
```

##### [Group](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#group)

`Group`和`Having`方法多用于分组操作



```
func (db *DB) Group(name string) (tx *DB)

func (db *DB) Having(query interface{}, args ...interface{}) (tx *DB)
```

下面看个例子



```
var (
    ps []Person
)

// SELECT `address` FROM `person` GROUP BY `address` HAVING address IN ('cn','us')
db.Select("address").Group("address").Having("address IN ?", []string{"cn", "us"}).Find(&ps)
```

##### [Distinct](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#distinct)

`Distinct`方法多用于去重



```
func (db *DB) Distinct(args ...interface{}) (tx *DB)
```

看一个示例



```
// SELECT DISTINCT `name` FROM `person` WHERE address IN ('cn','us')
db.Where("address IN ?", []string{"cn", "us"}).Distinct("name").Find(&ps)
```

##### [子查询](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#子查询)

子查询就是嵌套查询，例如想要查询出所有`id`值大于平均值的人



```
// SELECT * FROM `person` WHERE id > (SELECT AVG(id) FROM `person`
db.Where("id > (?)", db.Model(Person{}).Select("AVG(id)")).Find(&ps)
```

from 子查询



```
// SELECT * FROM (SELECT * FROM `person` WHERE address IN ('cn','uk')) as p
db.Table("(?) as p", db.Model(Person{}).Where("address IN ?", []string{"cn", "uk"})).Find(&ps)
```

#### [锁](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#锁)

gorm 使用`clause.Locking`子句来提供锁的支持



```
// SELECT * FROM `person` FOR UPDATE
db.Clauses(clause.Locking{Strength: "UPDATE"}).Find(&ps)

// SELECT * FROM `person` FOR SHARE NOWAIT
db.Clauses(clause.Locking{Strength: "SHARE", Options: "NOWAIT"}).Find(&ps)
```

#### [迭代](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#迭代)

通过`Rows`方法可以获取一个迭代器



```
func (db *DB) Rows() (*sql.Rows, error)
```

通过遍历迭代器，使用`ScanRows`方法可以将每一行的结果扫描到结构体中。



```
rows, err := db.Model(Person{}).Rows()
if err != nil {
    return
}
defer rows.Close()

for rows.Next() {
    var p Person
    err := db.ScanRows(rows, &p)
    if err != nil {
        return
    }
}
```

#### [修改](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#修改)

##### [save](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#save)

在创建的时候提到过`Save`方法，它也可以用来更新记录，并且它会更新所有字段，**即便有些结构体的字段是零值**，不过如果主键匹配不到的话就会进行插入操作了。



```
var p Person

db.First(&p)

p.Address = "poland"
// UPDATE `person` SET `name`='json',`address`='poland' WHERE `id` = 2
db.Save(&p)
```

可以看到它把除了主键以外的字段全都添到了`SET`语句中。

##### [update](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#update)

所以大多数情况下，建议使用`Update`方法



```
func (db *DB) Update(column string, value interface{}) (tx *DB)
```

它主要是用来更新单列字段



```
var p Person

db.First(&p)

// UPDATE `person` SET `address`='poland' WHERE id = 2
db.Model(Person{}).Where("id = ?", p.Id).Update("address", "poland")
```

##### [updates](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#updates)

`Updates`方法用于更新多列，接收结构体和 map 作为参数，并且当结构体字段为零值时，会忽略该字段，但在 map 中不会。



```
func (db *DB) Updates(values interface{}) (tx *DB)
```

下面是一个例子



```
var p Person

db.First(&p)

// UPDATE `person` SET `name`='jojo',`address`='poland' WHERE `id` = 2
db.Model(p).Updates(Person{Name: "jojo", Address: "poland"})

// UPDATE `person` SET `address`='poland',`name`='jojo' WHERE `id` = 2
db.Model(p).Updates(map[string]any{"name": "jojo", "address": "poland"})
```

##### [SQL 表达式](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#sql-表达式)

有些时候，常常会会需要对字段进行一些自增或者自减等与自身进行运算的操作，一般是先查再计算然后更新，或者是使用 SQL 表达式。



```
func Expr(expr string, args ...interface{}) clause.Expr
```

看下面的一个例子



```
// UPDATE `person` SET `age`=age + age,`name`='jojo' WHERE `id` = 2
db.Model(p).Updates(map[string]any{"name": "jojo", "age": gorm.Expr("age + age")})

// UPDATE `person` SET `age`=age * 2 + age,`name`='jojo' WHERE `id` = 2
db.Model(p).Updates(map[string]any{"name": "jojo", "age": gorm.Expr("age * 2 + age")})
```

#### [删除](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#删除)

在 gorm 中，删除记录会用到`Delete`方法，它可以直接传实体结构，也可以传条件。



```
func (db *DB) Delete(value interface{}, conds ...interface{}) (tx *DB)
```

例如直接传结构体



```
var p Person

db.First(&p)

// // DELETE FROM `person` WHERE `person`.`id` = 2
db.Delete(&p)
```

或者



```
var p Person

db.First(&p)

// DELETE FROM `person` WHERE `person`.`id` = 2
db.Model(p).Delete(nil)
```

或者指定条件



```
// DELETE FROM `person` WHERE id = 2
db.Model(Person{}).Where("id = ?", p.Id).Delete(nil)
```

也可以简写成



```
var p Person

db.First(&p)

// DELETE FROM `person` WHERE id = 2
db.Delete(&Person{}, "id = ?", 2)

// DELETE FROM `person` WHERE `person`.`id` = 2
db.Delete(&Person{}, 2)
```

批量删除的话就是传入切片



```
// DELETE FROM `person` WHERE id IN (1,2,3)
db.Delete(&Person{}, "id IN ?", []uint{1, 2, 3})
// DELETE FROM `person` WHERE `person`.`id` IN (1,2,3)
db.Delete(&Person{}, []uint{1, 2, 3})
```

##### [软删除](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#软删除)

假如你的实体模型使用了软删除，那么在删除时，默认进行更新操作，若要永久删除的话可以使用`Unscope`方法



```
db.Unscoped().Delete(&Person{}, []uint{1, 2, 3})
```

#### [关联定义](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#关联定义)

gorm 提供了表关联的交互能力，通过嵌入结构体和字段的形式来定义结构体与结构体之间的关联。

##### [一对一](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#一对一)

一对一关系是最简单的，正常情况下一个人只能有一个母亲，看下面的结构体



```
type Person struct {
  Id      uint
  Name    string
  Address string
  Age     uint

  MomId sql.NullInt64
  Mom   Mom `gorm:"foreignKey:MomId;"`
}

type Mom struct {
  Id   uint
  Name string
}
```

`Person`结构体通过嵌入`Mom`结构体，实现了对`Mom`类型的引用，其中`Person.MomId`就是引用字段，主键`Mom.Id`就是被引用字段，这样就完成了一对一关系的关联。如何自定义外键以及引用和约束还有默认的外键规则这些已经在[外键定义](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#外键)中已经讲到过，就不再赘述

提示

对于外键字段，推荐使用`sql`包提供的类型，因为外键默认可以为`NULL`，在使用`Create`创建记录时，如果使用普通类型，零值`0`也会被创建，不存在的外键被创建显然是不被允许的。

##### [一对多](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#一对多)

下面加一个学校结构体，学校与学生是一对多的关系，一个学校有多个学生，但是一个学生只能在一个学校上学。



```
type Person struct {
    Id      uint
    Name    string
    Address string
    Age     uint

    MomId sql.NullInt64
    Mom   Mom `gorm:"foreignKey:MomId;"`

    SchoolId sql.NullInt64
    School   School `gorm:"foreignKey:SchoolId;"`
}

type Mom struct {
    Id   uint
    Name string
}


type School struct {
    Id   uint
    Name string

    Persons []Person `gorm:"foreignKey:SchoolId;"`
}
```

`school.Persons`是`[]person`类型，表示着可以拥有多个学生，而`Person`则必须要有包含引用`School`的外键，也就是`Person.SchoolId`。

##### [多对多](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#多对多)

一个人可以拥有很多房子，一个房子也可以住很多人，这就是一个多对多的关系。



```
type Person struct {
  Id      uint
  Name    string
  Address string
  Age     uint

  MomId sql.NullInt64
  Mom   Mom `gorm:"foreignKey:MomId;"`

  SchoolId sql.NullInt64
  School   School `gorm:"foreignKey:SchoolId;"`

  Houses []House `gorm:"many2many:person_house;"`
}

type Mom struct {
  Id   uint
  Name string
}

type School struct {
  Id   uint
  Name string

  Persons []Person
}

type House struct {
  Id   uint
  Name string

  Persons []Person `gorm:"many2many:person_house;"`
}

type PersonHouse struct {
  PersonId sql.NullInt64
  Person   Person `gorm:"foreignKey:PersonId;"`
  HouseId  sql.NullInt64
  House    House `gorm:"foreignKey:HouseId;"`
}
```

`Person`和`House`互相持有对方的切片类型表示多对多的关系，多对多关系一般需要创建连接表，通过`many2many`来指定连接表，连接表的外键必须要指定正确。

创建完结构体后让 gorm 自动迁移到数据库中



```
tables := []any{
    School{},
    Mom{},
    Person{},
    House{},
    PersonHouse{},
}
for _, table := range tables {
    db.Migrator().CreateTable(&table)
}
```

注意引用表与被引用表的先后创建顺序。

#### [关联操作](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#关联操作)

在创建完上述三种关联关系后，接下来就是如何使用关联来进行增删改查。这主要会用到`Association`方法



```
func (db *DB) Association(column string) *Association
```

它接收一个关联参数，它的值应该是嵌入引用结构体中的被引用类型的字段名。



```
db.Model(&person).Association("Mom").Find(&mom)
```

比如关联查找一个人的母亲，`Association`的参数就是`Mom`，也就是`Person.Mom`字段名。

##### [创建关联](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#创建关联)



```
// 定义好数据
jenny := Mom{
    Name: "jenny",
}

mit := School{
    Name:    "MIT",
    Persons: nil,
}

h1 := House{
    Id:      0,
    Name:    "h1",
    Persons: nil,
}

h2 := House{
    Name:    "h2",
    Persons: nil,
}

jack := Person{
    Name:    "jack",
    Address: "usa",
    Age:     18,
}

mike := Person{
    Name:    "mike",
    Address: "uk",
    Age:     20,
}

// INSERT INTO `people` (`name`,`address`,`age`,`mom_id`,`school_id`) VALUES ('jack','usa',18,NULL,NULL)
db.Create(&jack)
// INSERT INTO `schools` (`name`) VALUES ('MIT')
db.Create(&mit)

// 添加Person与Mom的关联，一对一关联
// INSERT INTO `moms` (`name`) VALUES ('jenny') ON DUPLICATE KEY UPDATE `id`=`id`
// UPDATE `people` SET `mom_id`=1 WHERE `id` = 1
db.Model(&jack).Association("Mom").Append(&jenny)

// 添加school与Person的关联，一对多关联
// INSERT INTO `people` (`name`,`address`,`age`,`mom_id`,`school_id`,`id`) VALUES ('jack','usa',18,1,1,1),('mike','uk',20,NULL,1,DEFAULT) ON DUPLICATE KEY UPDATE `school_id`=VALUES(`school_id`)
db.Model(&mit).Association("Persons").Append([]Person{jack, mike})

// 添加Person与Houses的关联，多对多关联
// INSERT INTO `houses` (`name`) VALUES ('h1'),('h2') ON DUPLICATE KEY UPDATE `id`=`id`
// INSERT INTO `person_house` (`person_id`,`house_id`) VALUES (1,1),(1,2) ON DUPLICATE KEY UPDATE `person_id`=`person_id`
db.Model(&jack).Association("Houses").Append([]House{h1, h2})
```

假如所有的记录都不存在，在进行关联创建时，也会先创建记录再创建关联。

##### [查找关5联](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#查找关联)

下面演示如何进行查找关联。



```
// 一对一关联查找
var person Person
var mom Mom

// SELECT * FROM `people` ORDER BY `people`.`id` LIMIT 1
db.First(&person)
// SELECT * FROM `moms` WHERE `moms`.`id` = 1
db.Model(person).Association("Mom").Find(&mom)

// 一对多关联查找
var school School
var persons []Person

// SELECT * FROM `schools` ORDER BY `schools`.`id` LIMIT 1
db.First(&school)
// SELECT * FROM `people` WHERE `people`.`school_id` = 1
db.Model(&school).Association("Persons").Find(&persons)

// 多对多关联查找
var houses []House

// SELECT `houses`.`id`,`houses`.`name` FROM `houses` JOIN `person_house` ON `person_house`.`house_id` = `houses`.`id` AND `person_house`.`person_id` IN (1,2)
db.Model(&persons).Association("Houses").Find(&houses)
```

关联查找会根据已有的数据，去引用表中查找符合条件的记录，对于多对多关系而言，gorm 会自动完成表连接这一过程。

##### [更新关联](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#更新关联)

下面演示如何进行更新关联



```
// 一对一关联更新
var jack Person

lili := Mom{
    Name: "lili",
}

// SELECT * FROM `people` WHERE name = 'jack' ORDER BY `people`.`id` LIMIT 1
db.Where("name = ?", "jack").First(&jack)

// INSERT INTO `moms` (`name`) VALUES ('lili')
db.Create(&lili)

// INSERT INTO `moms` (`name`,`id`) VALUES ('lili',2) ON DUPLICATE KEY UPDATE `id`=`id`
// UPDATE `people` SET `mom_id`=2 WHERE `id` = 1
db.Model(&jack).Association("Mom").Replace(&lili)

// 一对多关联更新

var mit School
newPerson := []Person{{Name: "bob"}, {Name: "jojo"}}
// INSERT INTO `people` (`name`,`address`,`age`,`mom_id`,`school_id`) VALUES ('bob','',0,NULL,NULL),('jojo','',0,NULL,NULL)
db.Create(&newPerson)

//  SELECT * FROM `schools` WHERE name = 'mit' ORDER BY `schools`.`id` LIMIT 1
db.Where("name = ?", "mit").First(&mit)

// INSERT INTO `people` (`name`,`address`,`age`,`mom_id`,`school_id`,`id`) VALUES ('bob','',0,NULL,1,4),('jojo','',0,NULL,1,5) ON DUPLICATE KEY UPDATE `school_id`=VALUES(`school_id`)
//  UPDATE `people` SET `school_id`=NULL WHERE `people`.`id` NOT IN (4,5) AND `people`.`school_id` = 1
db.Model(&mit).Association("Persons").Replace(newPerson)

// 多对多关联更新

// INSERT INTO `houses` (`name`) VALUES ('h3'),('h4'),('h5') ON DUPLICATE KEY UPDATE `id`=`id`
// INSERT INTO `person_house` (`person_id`,`house_id`) VALUES (1,3),(1,4),(1,5) ON DUPLICATE KEY UPDATE `person_id`=`person_id`
// DELETE FROM `person_house` WHERE `person_house`.`person_id` = 1 AND `person_house`.`house_id` NOT IN (3,4,5)
db.Model(&jack).Association("Houses").Replace([]House{{Name: "h3"}, {Name: "h4"}, {Name: "h5"}})
```

在关联更新时，如果被引用数据和引用数据都不存在，gorm 会尝试创建它们。

##### [删除关联](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#删除关联)

下面演示如何删除关联



```
// 一对一关联删除
var (
    jack Person
    lili Mom
)

// SELECT * FROM `people` WHERE name = 'jack' ORDER BY `people`.`id` LIMIT 1
db.Where("name = ?", "jack").First(&jack)

//  SELECT * FROM `moms` WHERE name = 'lili' ORDER BY `moms`.`id` LIMIT 1
db.Where("name = ?", "lili").First(&lili)

// UPDATE `people` SET `mom_id`=NULL WHERE `people`.`id` = 1 AND `people`.`mom_id` = 2
db.Model(&jack).Association("Mom").Delete(&lili)

// 一对多关联删除

var (
    mit     School
    persons []Person
)

// SELECT * FROM `schools` WHERE name = 'mit' ORDER BY `schools`.`id` LIMIT 1
db.Where("name = ?", "mit").First(&mit)
// SELECT * FROM `people` WHERE name IN ('jack','mike')
db.Where("name IN ?", []string{"jack", "mike"}).Find(&persons)

// UPDATE `people` SET `school_id`=NULL WHERE `people`.`school_id` = 1 AND `people`.`id` IN (1,2)
db.Model(&mit).Association("Persons").Delete(&persons)

// 多对多关联删除
var houses []House

// SELECT * FROM `houses` WHERE name IN ('h3','h4')
db.Where("name IN ?", []string{"h3", "h4"}).Find(&houses)

// DELETE FROM `person_house` WHERE `person_house`.`person_id` = 1 AND `person_house`.`house_id` IN (3,4)
db.Model(&jack).Association("Houses").Delete(&houses)
```

关联删除时只会删除它们之间的引用关系，并不会删除实体记录。我们还可以使用`Clear`方法来直接清空关联



```
db.Model(&jack).Association("Houses").Clear()
```

如果想要删除对应的实体记录，可以在`Association`操作后面加上`Unscoped`操作（不会影响 many2many）



```
db.Model(&jack).Association("Houses").Unscoped().Delete(&houses)
```

对于一对多和多对多而言，可以使用`Select`操作来删除记录



```
var (
    mit     School
)
db.Where("name = ?", "mit").First(&mit)

db.Select("Persons").Delete(&mit)
```

#### [预加载](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#预加载)

预加载用于查询关联数据，对于具有关联关系的实体而言，它会先预先加载被关联引用的实体。之前提到的关联查询是对关联关系进行查询，预加载是直接对实体记录进行查询，包括所有的关联关系。**从语法上来说**，关联查询需要先查询指定的`[]Person`，然后再根据`[]Person` 去查询关联的`[]Mom`，预加载从语法上直接查询`[]Person`，并且也会将所有的关联关系顺带都加载了，不过实际上它们执行的 SQL 都是差不多的。下面看一个例子



```
var users []Person

// SELECT * FROM `moms` WHERE `moms`.`id` = 1
// SELECT * FROM `people`
db.Preload("Mom").Find(&users)
```

这是一个一对一关联查询的例子，它的输出



```
[{Id:1 Name:jack Address:usa Age:18 MomId:{Int64:1 Valid:true} Mom:{Id:1 Name:jenny} SchoolId:{Int64:1 Valid:true} School:{Id:0 Name: Persons:[]} Houses:[]} {Id:2 Name:mike Address:uk Age:20 MomId:{Int64:0 Valid:false} Mom:{Id:0 Name:} SchoolId:{Int64:1 Valid:true} School:{Id:0 Name: Persons:[]} Houses:[]}]
```

可以看到将关联的`Mom`一并查询出来了，但是没有预加载学校关系，所有`School`结构体都是零值。还可以使用`clause.Associations`表示预加载全部的关系，除了嵌套的关系。



```
db.Preload(clause.Associations).Find(&users)
```

下面来看一个嵌套预加载的例子，它的作用是查询出所有学校关联的所有学生以及每一个学生所关联的母亲和每一个学生所拥有的房子，而且还要查询出每一个房子的主人集合，学校->学生->房子->学生。



```
var schools []School

db.Preload("Persons").
    Preload("Persons.Mom").
    Preload("Persons.Houses").
    Preload("Persons.Houses.Persons").Find(&schools)

// 输出代码，逻辑可以忽略
for _, school := range schools {
    fmt.Println("school", school.Name)
    for _, person := range school.Persons {
        fmt.Println("person", person.Name)
        fmt.Println("mom", person.Mom.Name)
        for _, house := range person.Houses {
            var persons []string
            for _, p := range house.Persons {
                persons = append(persons, p.Name)
            }
            fmt.Println("house", house.Name, "owner", persons)
        }
        fmt.Println()
    }
}
```

输出为



```
school MIT
person jack
mom jenny
house h1 owner [jack]
house h2 owner [jack]

person mike
mom
```

可以看到输出了每一个学校的每一个学生的母亲以及它们的房子，还有房子的所有主人。

#### [事务](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#事务)

gorm 默认开启事务，任何插入和更新操作失败后都会回滚，可以在[连接配置](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#连接配置)中关闭，性能大概会提升 30%左右。gorm 中事务的使用有多种方法，下面简单介绍下。

##### [自动](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#自动)

闭包事务，通过`Transaction`方法，传入一个闭包函数，如果函数返回值不为 nil，那么就会自动回滚。



```
func (db *DB) Transaction(fc func(tx *DB) error, opts ...*sql.TxOptions) (err error)
```

下面看一个例子，闭包中的操作应该使用参数`tx`，而非外部的`db`。



```
var ps []Person

db.Transaction(func(tx *gorm.DB) error {
    err := tx.Create(&ps).Error
    if err != nil {
        return err
    }

    err = tx.Create(&ps).Error
    if err != nil {
        return err
    }

    err = tx.Model(Person{}).Where("id = ?", 1).Update("name", "jack").Error
    if err != nil {
        return err
    }

    return nil
})
```

##### [手动](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#手动)

比较推荐使用手动事务，由我们自己来控制何时回滚，何时提交。手动事务会用到下面三个方法



```
// Begin方法用于开启事务
func (db *DB) Begin(opts ...*sql.TxOptions) *DB

// Rollback方法用于回滚事务
func (db *DB) Rollback() *DB

// Commit方法用于提交事务
func (db *DB) Commit() *DB
```

下面看一个例子，开启事务后，就应该使用`tx`来操作 orm。



```
var ps []Person

tx := db.Begin()

err := tx.Create(&ps).Error
if err != nil {
    tx.Rollback()
    return
}

err = tx.Create(&ps).Error
if err != nil {
    tx.Rollback()
    return
}

err = tx.Model(Person{}).Where("id = ?", 1).Update("name", "jack").Error
if err != nil {
    tx.Rollback()
    return
}

tx.Commit()
```

可以指定回滚点



```
var ps []Person

tx := db.Begin()

err := tx.Create(&ps).Error
if err != nil {
    tx.Rollback()
    return
}

tx.SavePoint("createBatch")

err = tx.Create(&ps).Error
if err != nil {
    tx.Rollback()
    return
}

err = tx.Model(Person{}).Where("id = ?", 1).Update("name", "jack").Error
if err != nil {
    tx.RollbackTo("createBatch")
    return
}

tx.Commit()
```

#### [总结](https://golang.halfiisland.com/community/pkgs/orm/gorm.html#总结)

如果你阅读完了上面的所有内容，并动手敲了代码，那么你就可以使用 gorm 进行对数据库进行增删改查了，gorm 除了这些操作以外，还有其它许多功能，更多细节可以前往官方文档了解。

### Web开发

#### Gin

Gin 是一个用 Go (Golang) 编写的 Web 框架。 它具有类似 martini 的 API，性能要好得多，多亏了 `httprouter`，速度提高了 40 倍。 如果您需要性能和良好的生产力，您一定会喜欢 Gin。Gin 相比于 Iris 和 Beego 而言，更倾向于轻量化的框架，只负责 Web 部分，追求极致的路由性能，功能或许没那么全，胜在轻量易拓展，这也是它的优点。因此，在所有的 Web 框架中，Gin 是最容易上手和学习的。

- **快速**：基于 Radix 树的路由，小内存占用。没有反射。可预测的 API 性能。
- **支持中间件**：传入的 HTTP 请求可以由一系列中间件和最终操作来处理。 例如：Logger，Authorization，GZIP，最终操作 DB。
- **Crash 处理**：Gin 可以 catch 一个发生在 HTTP 请求中的 panic 并 recover 它。这样，你的服务器将始终可用。
- **JSON 验证**：Gin 可以解析并验证请求的 JSON，例如检查所需值的存在。
- **路由组**：更好地组织路由。是否需要授权，不同的 API 版本…… 此外，这些组可以无限制地嵌套而不会降低性能。
- **错误管理**：Gin 提供了一种方便的方法来收集 HTTP 请求期间发生的所有错误。最终，中间件可以将它们写入日志文件，数据库并通过网络发送。
- **内置渲染**：Gin 为 JSON，XML 和 HTML 渲染提供了易于使用的 API。
- **可扩展性**：新建一个中间件非常简单

##### [安装](https://golang.halfiisland.com/community/pkgs/web/gin.html#安装)

截止目前`2022/11/22`，gin 支持的 go 最低版本为`1.16`，建议使用`go mod`来管理项目依赖。



```
go get -u github.com/gin-gonic/gin
```

导入



```
import "github.com/gin-gonic/gin"
```

##### [快速开始](https://golang.halfiisland.com/community/pkgs/web/gin.html#快速开始)



```
package main

import (
   "github.com/gin-gonic/gin"
   "net/http"
)

func main() {
   engine := gin.Default() //创建gin引擎
   engine.GET("/ping", func(context *gin.Context) {
      context.JSON(http.StatusOK, gin.H{
         "message": "pong",
      })
   })
   engine.Run() //开启服务器，默认监听localhost:8080
}
```

请求 URL



```
GET localhost:8080/ping
```

返回



```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Date: Tue, 22 Nov 2022 08:47:11 GMT
Content-Length: 18

{
  "message": "pong"
}
Response file saved.
> 2022-11-22T164711.200.json
```

##### [文档](https://golang.halfiisland.com/community/pkgs/web/gin.html#文档)

其实`Gin`官方文档里面并没有多少教程，大多数只是一些介绍和基本使用和一些例子，但是`gin-gonic/` 组织下，有一个`gin-gonic/examples`仓库，这是一个由社区共同维护的`gin`示例仓库。都是全英文，更新时间并不是特别频繁，笔者也是从这里慢慢学习的`gin`框架。

示例仓库地址：[gin-gonic/examples: A repository to host examples and tutorials for Gin. (github.com)](https://github.com/gin-gonic/examples)

提示

开始之前建议可以阅读一下`HttpRouter`:[HttpRouter](https://golang.halfiisland.com/community/pkgs/web/HttpRouter.html)

##### [参数解析](https://golang.halfiisland.com/community/pkgs/web/gin.html#参数解析)

`gin`中的参数解析总共支持三种方式:`路由参数`，`URL参数`，`表单参数`，下面逐一讲解并结合代码示例，比较简单易懂。

###### [路由参数](https://golang.halfiisland.com/community/pkgs/web/gin.html#路由参数)

路由参数其实是封装了`HttpRouter`的参数解析功能，使用方法基本上与`HttpRouter`一致。



```
package main

import (
   "github.com/gin-gonic/gin"
   "log"
   "net/http"
)

func main() {
   e := gin.Default()
   e.GET("/findUser/:username/:userid", FindUser)
   e.GET("/downloadFile/*filepath", UserPage)

   log.Fatalln(e.Run(":8080"))
}

// 命名参数示例
func FindUser(c *gin.Context) {
   username := c.Param("username")
   userid := c.Param("userid")
   c.String(http.StatusOK, "username is %s\n userid is %s", username, userid)
}

// 路径参数示例
func UserPage(c *gin.Context) {
   filepath := c.Param("filepath")
   c.String(http.StatusOK, "filepath is  %s", filepath)
}
```

示例一



```
curl --location --request GET '127.0.0.1:8080/findUser/jack/001'
```



```
username is jack
 userid is 001
```

示例二



```
curl --location --request GET '127.0.0.1:8080/downloadFile/img/fruit.png'
```



```
filepath is  /img/fruit.png
```

###### [URL 参数](https://golang.halfiisland.com/community/pkgs/web/gin.html#url-参数)

传统的 URL 参数，格式就是`/url?key=val&key1=val1&key2=val2`。



```
package main

import (
   "github.com/gin-gonic/gin"
   "log"
   "net/http"
)

func main() {
   e := gin.Default()
   e.GET("/findUser", FindUser)
   log.Fatalln(e.Run(":8080"))
}

func FindUser(c *gin.Context) {
   username := c.DefaultQuery("username", "defaultUser")
   userid := c.Query("userid")
   c.String(http.StatusOK, "username is %s\nuserid is %s", username, userid)
}
```

示例一



```
curl --location --request GET '127.0.0.1:8080/findUser?username=jack&userid=001'
```



```
username is jack
userid is 001
```

示例二



```
curl --location --request GET '127.0.0.1:8080/findUser'
```



```
username is defaultUser
userid is
```

###### [表单参数](https://golang.halfiisland.com/community/pkgs/web/gin.html#表单参数)

表单的内容类型一般有`application/json`，`application/x-www-form-urlencoded`，`application/xml`，`multipart/form-data`。



```
package main

import (
  "github.com/gin-gonic/gin"
  "net/http"
)

func main() {
  e := gin.Default()
  e.POST("/register", RegisterUser)
  e.POST("/update", UpdateUser)
  e.Run(":8080")
}

func RegisterUser(c *gin.Context) {
  username := c.PostForm("username")
  password := c.PostForm("password")
  c.String(http.StatusOK, "successfully registered,your username is [%s],password is [%s]", username, password)
}

func UpdateUser(c *gin.Context) {
  var form map[string]string
  c.ShouldBind(&form)
  c.String(http.StatusOK, "successfully update,your username is [%s],password is [%s]", form["username"], form["password"])
}
```

示例一：使用`form-data`



```
curl --location --request POST '127.0.0.1:8080/register' \
--form 'username="jack"' \
--form 'password="123456"'
```



```
successfully registered,your username is [jack],password is [123456]
```

`PostForm`方法默认解析`application/x-www-form-urlencoded`和`multipart/form-data`类型的表单。

示例二：使用`json`



```
curl --location --request POST '127.0.0.1:8080/update' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"username",
    "password":"123456"
}'
```



```
successfully update,your username is [username],password is [123456]
```

##### [数据解析](https://golang.halfiisland.com/community/pkgs/web/gin.html#数据解析)

在大多数情况下，我们都会使用结构体来承载数据，而不是直接解析参数。在`gin`中，用于数据绑定的方法主要是`Bind()`和`ShouldBind()`，两者的区别在于前者内部也是直接调用的`ShouldBind()`，当然返回`err`时，会直接进行 400 响应，后者则不会。如果想要更加灵活的进行错误处理，建议选择后者。这两个函数会自动根据请求的`content-type`来进行推断用什么方式解析。



```
func (c *Context) MustBindWith(obj any, b binding.Binding) error {
    // 调用了ShouldBindWith()
  if err := c.ShouldBindWith(obj, b); err != nil {
    c.AbortWithError(http.StatusBadRequest, err).SetType(ErrorTypeBind) // 直接响应400 badrequest
    return err
  }
  return nil
}
```

如果想要自行选择可以使用`BindWith()`和`ShouldBindWith()`，例如



```
c.MustBindWith(obj, binding.JSON) //json
c.MustBindWith(obj, binding.XML) //xml
```

gin 支持的绑定类型有如下几种实现：



```
var (
   JSON          = jsonBinding{}
   XML           = xmlBinding{}
   Form          = formBinding{}
   Query         = queryBinding{}
   FormPost      = formPostBinding{}
   FormMultipart = formMultipartBinding{}
   ProtoBuf      = protobufBinding{}
   MsgPack       = msgpackBinding{}
   YAML          = yamlBinding{}
   Uri           = uriBinding{}
   Header        = headerBinding{}
   TOML          = tomlBinding{}
)
```

示例



```
package main

import (
  "fmt"
  "github.com/gin-gonic/gin"
  "net/http"
)

type LoginUser struct {
  Username string `binding:"required" json:"username" form:"username" uri:"username"`
  Password string `binding:"required" json:"password" form:"password" uri:"password"`
}

func main() {
  e := gin.Default()
  e.POST("/loginWithJSON", Login)
  e.POST("/loginWithForm", Login)
  e.GET("/loginWithQuery/:username/:password", Login)
  e.Run(":8080")
}

func Login(c *gin.Context) {
  var login LoginUser
    // 使用ShouldBind来让gin自动推断
  if c.ShouldBind(&login) == nil && login.Password != "" && login.Username != "" {
    c.String(http.StatusOK, "login successfully !")
  } else {
    c.String(http.StatusBadRequest, "login failed !")
  }
  fmt.Println(login)
}
```

###### [Json 数据绑定](https://golang.halfiisland.com/community/pkgs/web/gin.html#json-数据绑定)



```
curl --location --request POST '127.0.0.1:8080/loginWithJSON' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"root",
    "password":"root"
}'
```



```
login successfully !
```

###### [表单数据绑定](https://golang.halfiisland.com/community/pkgs/web/gin.html#表单数据绑定)



```
curl --location --request POST '127.0.0.1:8080/loginWithForm' \
--form 'username="root"' \
--form 'password="root"'
```



```
login successfully !
```

###### [URL 数据绑定](https://golang.halfiisland.com/community/pkgs/web/gin.html#url-数据绑定)



```
curl --location --request GET '127.0.0.1:8080/loginWithQuery/root/root'
```



```
login failed !
```

到了这里就会发生错误了，因为这里输出的`content-type`是空字符串，无法推断到底是要如何进行数据解析。所以当使用 URL 参数时，我们应该手动指定解析方式，例如：



```
if err := c.ShouldBindUri(&login); err == nil && login.Password != "" && login.Username != "" {
   c.String(http.StatusOK, "login successfully !")
} else {
   fmt.Println(err)
   c.String(http.StatusBadRequest, "login failed !")
}
```

###### [多次绑定](https://golang.halfiisland.com/community/pkgs/web/gin.html#多次绑定)

一般方法都是通过调用 `c.Request.Body` 方法绑定数据，但不能多次调用这个方法，例如`c.ShouldBind`，不可重用，如果想要多次绑定的话，可以使用

`c.ShouldBindBodyWith`。



```
func SomeHandler(c *gin.Context) {
  objA := formA{}
  objB := formB{}
  // 读取 c.Request.Body 并将结果存入上下文。
  if errA := c.ShouldBindBodyWith(&objA, binding.JSON); errA == nil {
    c.String(http.StatusOK, `the body should be formA`)
  // 这时, 复用存储在上下文中的 body。
  }
  if errB := c.ShouldBindBodyWith(&objB, binding.JSON); errB == nil {
    c.String(http.StatusOK, `the body should be formB JSON`)
  // 可以接受其他格式
  }
  if errB2 := c.ShouldBindBodyWith(&objB, binding.XML); errB2 == nil {
    c.String(http.StatusOK, `the body should be formB XML`)
  }
}
```

提示

`c.ShouldBindBodyWith` 会在绑定之前将 body 存储到上下文中。 这会对性能造成轻微影响，如果调用一次就能完成绑定的话，那就不要用这个方法。只有某些格式需要此功能，如 `JSON`, `XML`, `MsgPack`, `ProtoBuf`。 对于其他格式, 如 `Query`, `Form`, `FormPost`, `FormMultipart` 可以多次调用`c.ShouldBind()` 而不会造成任何性能损失 。

##### [数据校验](https://golang.halfiisland.com/community/pkgs/web/gin.html#数据校验)

`gin`内置的校验工具其实是`github.com/go-playground/validator/v10`，使用方法也几乎没有什么差别，[Validator](https://golang.halfiisland.com/community/pkgs/validate/Validator.html)

###### [简单示例](https://golang.halfiisland.com/community/pkgs/web/gin.html#简单示例)



```
type LoginUser struct {
   Username string `binding:"required"  json:"username" form:"username" uri:"username"`
   Password string `binding:"required" json:"password" form:"password" uri:"password"`
}

func main() {
   e := gin.Default()
   e.POST("/register", Register)
   log.Fatalln(e.Run(":8080"))
}

func Register(ctx *gin.Context) {
   newUser := &LoginUser{}
   if err := ctx.ShouldBind(newUser); err == nil {
      ctx.String(http.StatusOK, "user%+v", *newUser)
   } else {
      ctx.String(http.StatusBadRequest, "invalid user,%v", err)
   }
}
```

测试



```
curl --location --request POST 'http://localhost:8080/register' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"jack1"

}'
```

输出



```
invalid user,Key: 'LoginUser.Password' Error:Field validation for 'Password' failed on the 'required' tag
```

提示

需要注意的一点是，gin 中 validator 的校验 tag 是`binding`，而单独使用`validator`的的校验 tag 是`validator`

##### [数据响应](https://golang.halfiisland.com/community/pkgs/web/gin.html#数据响应)

数据响应是接口处理中最后一步要做的事情，后端将所有数据处理完成后，通过 HTTP 协议返回给调用者，gin 对于数据响应提供了丰富的内置支持，用法简洁明了，上手十分容易。

###### [简单示例](https://golang.halfiisland.com/community/pkgs/web/gin.html#简单示例-1)



```
func Hello(c *gin.Context) {
    // 返回纯字符串格式的数据，http.StatusOK代表着200状态码，数据为"Hello world !"
  c.String(http.StatusOK, "Hello world !")
}
```

###### [HTML 渲染](https://golang.halfiisland.com/community/pkgs/web/gin.html#html-渲染)

提示

文件加载的时候，默认根路径是项目路径，也就是`go.mod`文件所在的路径，下面例子中的`index.html`即位于根路径下的`index.html`，不过一般情况下这些模板文件都不会放在根路径，而是会存放在静态资源文件夹中



```
func main() {
   e := gin.Default()
    // 加载HTML文件，也可以使用Engine.LoadHTMLGlob()
   e.LoadHTMLFiles("index.html")
   e.GET("/", Index)
   log.Fatalln(e.Run(":8080"))
}

func Index(c *gin.Context) {
   c.HTML(http.StatusOK, "index.html", gin.H{})
}
```

测试



```
curl --location --request GET 'http://localhost:8080/'
```

返回



```
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>GinLearn</title>
  </head>

  <body>
    <h1>Hello World!</h1>
    <h1>This is a HTML Template Render Example</h1>
  </body>
</html>
```

###### [快速响应](https://golang.halfiisland.com/community/pkgs/web/gin.html#快速响应)

前面经常用到`context.String()`方法来进行数据响应，这是最原始的响应方法，直接返回一个字符串，`gin`中其实还内置了许多了快速响应的方法例如:



```
// 使用Render写入响应头，并进行数据渲染
func (c *Context) Render(code int, r render.Render)

// 渲染一个HTML模板，name是html路径，obj是内容
func (c *Context) HTML(code int, name string, obj any)

// 以美化了的缩进JSON字符串进行数据渲染，通常不建议使用这个方法，因为会造成更多的传输消耗。
func (c *Context) IndentedJSON(code int, obj any)

// 安全的JSON，可以防止JSON劫持，详情了解：https://www.cnblogs.com/xusion/articles/3107788.html
func (c *Context) SecureJSON(code int, obj any)

// JSONP方式进行渲染
func (c *Context) JSONP(code int, obj any)

// JSON方式进行渲染
func (c *Context) JSON(code int, obj any)

// JSON方式进行渲染，会将unicode码转换为ASCII码
func (c *Context) AsciiJSON(code int, obj any)

// JSON方式进行渲染，不会对HTML特殊字符串进行转义
func (c *Context) PureJSON(code int, obj any)

// XML方式进行渲染
func (c *Context) XML(code int, obj any)

// YML方式进行渲染
func (c *Context) YAML(code int, obj any)

// TOML方式进行渲染
func (c *Context) TOML(code int, obj interface{})

// ProtoBuf方式进行渲染
func (c *Context) ProtoBuf(code int, obj any)

// String方式进行渲染
func (c *Context) String(code int, format string, values ...any)

// 重定向到特定的位置
func (c *Context) Redirect(code int, location string)

// 将data写入响应流中
func (c *Context) Data(code int, contentType string, data []byte)

// 通过reader读取流并写入响应流中
func (c *Context) DataFromReader(code int, contentLength int64, contentType string, reader io.Reader, extraHeaders map[string]string)

// 高效的将文件写入响应流
func (c *Context) File(filepath string)

// 以一种高效的方式将fs中的文件流写入响应流
func (c *Context) FileFromFS(filepath string, fs http.FileSystem)

// 以一种高效的方式将fs中的文件流写入响应流，并且在客户端会以指定的文件名进行下载
func (c *Context) FileAttachment(filepath, filename string)

// 将服务端推送流写入响应流中
func (c *Context) SSEvent(name string, message any)

// 发送一个流响应并返回一个布尔值，以此来判断客户端是否在流中间断开
func (c *Context) Stream(step func(w io.Writer) bool) bool
```

对于大多数应用而言，用的最多的还是`context.JSON`，其他的相对而言要少一些，这里就不举例子演示了，因为都比较简单易懂，差不多都是直接调用的事情。

###### [异步处理](https://golang.halfiisland.com/community/pkgs/web/gin.html#异步处理)

在 gin 中，异步处理需要结合 goroutine 使用，使用起来十分简单。



```
// copy返回一个当前Context的副本以便在当前Context作用范围外安全的使用，可以用于传递给一个goroutine
func (c *Context) Copy() *Context
```



```
func main() {
  e := gin.Default()
  e.GET("/hello", Hello)
  log.Fatalln(e.Run(":8080"))
}

func Hello(c *gin.Context) {
  ctx := c.Copy()
  go func() {
    // 子协程应该使用Context的副本，不应该使用原始Context
    log.Println("异步处理函数: ", ctx.HandlerNames())
  }()
  log.Println("接口处理函数: ", c.HandlerNames())
  c.String(http.StatusOK, "hello")
}
```

测试



```
curl --location --request GET 'http://localhost:8080/hello'
```

输出



```
2022/12/21 13:33:47 异步处理函数:  []
2022/12/21 13:33:47 接口处理函数:  [github.com/gin-gonic/gin.LoggerWithConfig.func1 github.com/gin-gonic/gin.CustomRecoveryWithWriter.func1 main.Hello]
[GIN] 2022/12/21 - 13:33:47 | 200 |     11.1927ms |             ::1 | GET      "/hello"
```

可以看到两者输出不同，副本在复制时，为了安全考虑，删掉了许多元素的值。

##### [文件传输](https://golang.halfiisland.com/community/pkgs/web/gin.html#文件传输)

文件传输是 Web 应用的一个不可或缺的功能，gin 对于此的支持也是封装的十分简单，但其实本质上和用原生的`net/http`的流程都差不多。流程都是从请求体中读取文件流，然后再保存到本地。

###### [单文件上传](https://golang.halfiisland.com/community/pkgs/web/gin.html#单文件上传)



```
func main() {
  e := gin.Default()
  e.POST("/upload", uploadFile)
  log.Fatalln(e.Run(":8080"))
}

func uploadFile(ctx *gin.Context) {
  // 获取文件
  file, err := ctx.FormFile("file")
  if err != nil {
    ctx.String(http.StatusBadRequest, "%+v", err)
    return
  }
  // 保存在本地
  err = ctx.SaveUploadedFile(file, "./"+file.Filename)
  if err != nil {
    ctx.String(http.StatusBadRequest, "%+v", err)
    return
  }
  // 返回结果
  ctx.String(http.StatusOK, "upload %s size:%d byte successfully!", file.Filename, file.Size)
}
```

测试



```
curl --location --request POST 'http://localhost:8080/upload' \
--form 'file=@"/C:/Users/user/Pictures/Camera Roll/a.jpg"'
```

结果



```
upload a.jpg size:1424 byte successfully!
```

提示

一般情况下，上传文件的`Method`都会指定用`POST`，一些公司可能会倾向于使用`PUT`，前者是简单 HTTP 请求，后者是复杂 HTTP 请求，具体区别不作赘述，如果使用后者的话，尤其是前后端分离的项目时，需要进行相应的跨域处理，而 Gin 默认的配置是不支持跨域的[跨域配置](https://golang.halfiisland.com/community/pkgs/web/gin.html#跨域配置)。

###### [多文件上传](https://golang.halfiisland.com/community/pkgs/web/gin.html#多文件上传)



```
func main() {
   e := gin.Default()
   e.POST("/upload", uploadFile)
   e.POST("/uploadFiles", uploadFiles)
   log.Fatalln(e.Run(":8080"))
}

func uploadFiles(ctx *gin.Context) {
  // 获取gin解析好的multipart表单
  form, _ := ctx.MultipartForm()
  // 根据键值取得对应的文件列表
  files := form.File["files"]
  // 遍历文件列表，保存到本地
  for _, file := range files {
    err := ctx.SaveUploadedFile(file, "./"+file.Filename)
    if err != nil {
      ctx.String(http.StatusBadRequest, "upload failed")
      return
    }
  }
  // 返回结果
  ctx.String(http.StatusOK, "upload %d files successfully!", len(files))
}
```

测试



```
curl --location --request POST 'http://localhost:8080/uploadFiles' \
--form 'files=@"/C:/Users/Stranger/Pictures/Camera Roll/a.jpg"' \
--form 'files=@"/C:/Users/Stranger/Pictures/Camera Roll/123.jpg"' \
--form 'files=@"/C:/Users/Stranger/Pictures/Camera Roll/girl.jpg"'
```

输出



```
upload 3 files successfully!
```

###### [文件下载](https://golang.halfiisland.com/community/pkgs/web/gin.html#文件下载)

关于文件下载的部分 Gin 对于原有标准库的 API 再一次封装，使得文件下载异常简单。



```
func main() {
  e := gin.Default()
  e.POST("/upload", uploadFile)
  e.POST("/uploadFiles", uploadFiles)
  e.GET("/download/:filename", download)
  log.Fatalln(e.Run(":8080"))
}

func download(ctx *gin.Context) {
    // 获取文件名
  filename := ctx.Param("filename")
    // 返回对应文件
  ctx.FileAttachment(filename, filename)
}
```

测试



```
curl --location --request GET 'http://localhost:8080/download/a.jpg'
```

结果



```
Content-Disposition: attachment; filename="a.jpg"
Date: Wed, 21 Dec 2022 08:04:17 GMT
Last-Modified: Wed, 21 Dec 2022 07:50:44 GMT
```

是不是觉得简单过头了，不妨不用框架的方法，自行编写一遍过程



```
func download(ctx *gin.Context) {
   // 获取参数
   filename := ctx.Param("filename")

   // 请求响应对象和请求对象
   response, request := ctx.Writer, ctx.Request
   // 写入响应头
   // response.Header().Set("Content-Type", "application/octet-stream") 以二进制流传输文件
   response.Header().Set("Content-Disposition", `attachment; filename*=UTF-8''`+url.QueryEscape(filename)) // 对文件名进行安全转义
   response.Header().Set("Content-Transfer-Encoding", "binary")                                            // 传输编码
   http.ServeFile(response, request, filename)
}
```

其实`net/http`也已经封装的足够好了

提示

可以通过`Engine.MaxMultipartMemory`来设置文件传输的最大内存，默认为`32 << 20 // 32 MB`

##### [路由管理](https://golang.halfiisland.com/community/pkgs/web/gin.html#路由管理)

路由管理是一个系统中非常重要的部分，需要确保每一个请求都能被正确的映射到对应的函数上。

###### [路由组](https://golang.halfiisland.com/community/pkgs/web/gin.html#路由组)

创建一个路由组是将接口分类，不同类别的接口对应不同的功能，也更易于管理。



```
func Hello(c *gin.Context) {

}

func Login(c *gin.Context) {

}

func Update(c *gin.Context) {

}

func Delete(c *gin.Context) {

}
```

假设我们有以上四个接口，暂时不管其内部实现，`Hello`，`Login`是一组，`Update`，`Delete`是一组。



```
func (group *RouterGroup) Group(relativePath string, handlers ...HandlerFunc) *RouterGroup
```

在创建分组的时候，我们也可以给分组的根路由注册处理器，不过大多数时候并不会这么做。



```
func main() {
  e := gin.Default()
  v1 := e.Group("v1")
  {
    v1.GET("/hello", Hello)
    v1.GET("/login", Login)
  }
  v2 := e.Group("v2")
  {
    v2.POST("/update", Update)
    v2.DELETE("/delete", Delete)
  }
}
```

我们将其分成了`v1`，`v2`两个分组，其中的花括号`{}`仅仅只是为了规范，表名花括号内注册的处理器是属于同一个路由分组，在功能上没有任何作用。同样的，gin 也支持嵌套分组，方法与上例一致，这里就不再演示。

###### [404 路由](https://golang.halfiisland.com/community/pkgs/web/gin.html#_404-路由)

gin 中的`Engine`结构体提供了一个方法`NoRoute`，来设置当访问的 URL 不存在时如何处理，开发者可以将逻辑写入此方法中，以便路由未找到时自动调用，默认会返回 404 状态码



```
func (engine *Engine) NoRoute(handlers ...HandlerFunc)
```

我们拿上个例子举例



```
func main() {
   e := gin.Default()
   v1 := e.Group("v1")
   {
      v1.GET("/hello", Hello)
      v1.GET("/login", Login)
   }
   v2 := e.Group("v2")
   {
      v2.POST("/update", Update)
      v2.DELETE("/delete", Delete)
   }
   // 注册处理器
   e.NoRoute(func(context *gin.Context) { // 这里只是演示，不要在生产环境中直接返回HTML代码
      context.String(http.StatusNotFound, "<h1>404 Page Not Found</h1>")
   })
   log.Fatalln(e.Run(":8080"))
}
```

随便发一个请求



```
curl --location --request GET 'http://localhost:8080/'
```



```
<h1>404 Page Not Found</h1>
```

###### [405 路由](https://golang.halfiisland.com/community/pkgs/web/gin.html#_405-路由)

Http 状态码中，405 代表着当前请求的方法类型是不允许的，gin 中提供了如下方法



```
func (engine *Engine) NoMethod(handlers ...HandlerFunc)
```

来注册一个处理器，以便在发生时自动调用，前提是设置`Engine.HandleMethodNotAllowed = true`。



```
func main() {
   e := gin.Default()
   // 需要将其设置为true
   e.HandleMethodNotAllowed = true
   v1 := e.Group("/v1")
   {
      v1.GET("/hello", Hello)
      v1.GET("/login", Login)
   }
   v2 := e.Group("/v2")
   {
      v2.POST("/update", Update)
      v2.DELETE("/delete", Delete)
   }
   e.NoRoute(func(context *gin.Context) {
      context.String(http.StatusNotFound, "<h1>404 Page Not Found</h1>")
   })
   // 注册处理器
   e.NoMethod(func(context *gin.Context) {
      context.String(http.StatusMethodNotAllowed, "method not allowed")
   })
   log.Fatalln(e.Run(":8080"))
}
```

配置好后，gin 默认的 header 是不支持`OPTION`请求的，测试一下



```
curl --location --request OPTIONS 'http://localhost:8080/v2/delete'
```



```
method not allowed
```

至此配置成功

###### [重定向](https://golang.halfiisland.com/community/pkgs/web/gin.html#重定向)

gin 中的重定向十分简单，调用`gin.Context.Redirect()`方法即可。



```
func main() {
  e := gin.Default()
  e.GET("/", Index)
  e.GET("/hello", Hello)
  log.Fatalln(e.Run(":8080"))
}

func Index(c *gin.Context) {
  c.Redirect(http.StatusMovedPermanently, "/hello")
}

func Hello(c *gin.Context) {
  c.String(http.StatusOK, "hello")
}
```

测试



```
curl --location --request GET 'http://localhost:8080/'
```

输出



```
hello
```

##### [中间件](https://golang.halfiisland.com/community/pkgs/web/gin.html#中间件)

gin 十分轻便灵活，拓展性非常高，对于中间件的支持也非常友好。在 Gin 中，所有的接口请求都要经过中间件，通过中间件，开发者可以自定义实现很多功能和逻辑，gin 虽然本身自带的功能很少，但是由第三方社区开发的 gin 拓展中间件十分丰富。

中间件本质上其实还是一个接口处理器



```
// HandlerFunc defines the handler used by gin middleware as return value.
type HandlerFunc func(*Context)
```

从某种意义上来说，每一个请求对应的处理器也是中间件，只不过是作用范围非常小的局部中间件。



```
func Default() *Engine {
   debugPrintWARNINGDefault()
   engine := New()
   engine.Use(Logger(), Recovery())
   return engine
}
```

查看 gin 的源代码，`Default`函数中，返回的默认`Engine`就使用两个默认中间件`Logger()`，`Recovery()`，如果不想使用默认的中间件也可以使用`gin.New()`来代替。

###### [全局中间件](https://golang.halfiisland.com/community/pkgs/web/gin.html#全局中间件)

全局中间件即作用范围为全局，整个系统所有的请求都会经过此中间件。



```
func GlobalMiddleware() gin.HandlerFunc {
   return func(ctx *gin.Context) {
      fmt.Println("全局中间件被执行...")
   }
}
```

先创建一个闭包函数来创建中间件，再通过`Engine.Use()`来注册全局中间件。



```
func main() {
   e := gin.Default()
   // 注册全局中间件
   e.Use(GlobalMiddleware())
   v1 := e.Group("/v1")
   {
      v1.GET("/hello", Hello)
      v1.GET("/login", Login)
   }
   v2 := e.Group("/v2")
   {
      v2.POST("/update", Update)
      v2.DELETE("/delete", Delete)
   }
   log.Fatalln(e.Run(":8080"))
}
```

测试



```
curl --location --request GET 'http://localhost:8080/v1/hello'
```

输出



```
[GIN-debug] Listening and serving HTTP on :8080
全局中间件被执行...
[GIN] 2022/12/21 - 11:57:52 | 200 |       538.9µs |             ::1 | GET      "/v1/hello"
```

###### [局部中间件](https://golang.halfiisland.com/community/pkgs/web/gin.html#局部中间件)

局部中间件即作用范围为局部，系统中局部的请求会经过此中间件。局部中间件可以注册到单个路由上，不过更多时候是注册到路由组上。



```
func main() {
   e := gin.Default()
   // 注册全局中间件
   e.Use(GlobalMiddleware())
   // 注册路由组局部中间件
   v1 := e.Group("/v1", LocalMiddleware())
   {
      v1.GET("/hello", Hello)
      v1.GET("/login", Login)
   }
   v2 := e.Group("/v2")
   {
      // 注册单个路由局部中间件
      v2.POST("/update", LocalMiddleware(), Update)
      v2.DELETE("/delete", Delete)
   }
   log.Fatalln(e.Run(":8080"))
}
```

测试



```
curl --location --request POST 'http://localhost:8080/v2/update'
```

输出



```
全局中间件被执行...
局部中间件被执行
[GIN] 2022/12/21 - 12:05:03 | 200 |       999.9µs |             ::1 | POST     "/v2/update"
```

###### [中间件原理](https://golang.halfiisland.com/community/pkgs/web/gin.html#中间件原理)

Gin 中间的使用和自定义非常容易，其内部的原理也比较简单，为了后续的学习，需要简单的了解下内部原理。Gin 中的中间件其实用到了责任链模式，`Context`中维护着一个`HandlersChain`，本质上是一个`[]HandlerFunc`，和一个`index`，其数据类型为`int8`。在`Engine.handlerHTTPRequest(c *Context)`方法中，有一段代码表明了调用过程：gin 在路由树中找到了对应的路由后，便调用了`Next()`方法。



```
if value.handlers != nil {
   // 将调用链赋值给Context
   c.handlers = value.handlers
   c.fullPath = value.fullPath
   // 调用中间件
   c.Next()
   c.writermem.WriteHeaderNow()
   return
}
```

`Next()`的调用才是关键，`Next()`会遍历路由的`handlers`中的`HandlerFunc` 并执行，此时可以看到`index`的作用就是记录中间件的调用位置。其中，给对应路由注册的接口函数也在`handlers`内，这也就是为什么前面会说接口也是一个中间件。



```
func (c *Context) Next() {
   // 一进来就+1是为了避免陷入递归死循环，默认值是-1
   c.index++
   for c.index < int8(len(c.handlers)) {
      // 执行HandlerFunc
      c.handlers[c.index](c)
      // 执行完毕，index+1
      c.index++
   }
}
```

修改一下`Hello()`的逻辑，来验证是否果真如此



```
func Hello(c *gin.Context) {
   fmt.Println(c.HandlerNames())
}
```

输出结果为



```
[github.com/gin-gonic/gin.LoggerWithConfig.func1 github.com/gin-gonic/gin.CustomRecoveryWithWriter.func1 main.GlobalMiddleware.func1 main.LocalMiddleware.func1 main.Hello]
```

可以看到中间件调用链的顺序为：`Logger -> Recovery -> GlobalMiddleware -> LocalMiddleWare -> Hello`，调用链的最后一个元素才是真正要执行的接口函数，前面的都是中间件。

提示

在注册局部路由时，有如下一个断言



```
finalSize := len(group.Handlers) + len(handlers) //中间件总数
assert1(finalSize < int(abortIndex), "too many handlers")
```

其中`abortIndex int8 = math.MaxInt8 >> 1`值为 63，即使用系统时路由注册数量不要超过 63 个。

###### [计时器中间件](https://golang.halfiisland.com/community/pkgs/web/gin.html#计时器中间件)

在知晓了上述的中间件原理后，就可以编写一个简单的请求时间统计中间件。



```
func TimeMiddleware() gin.HandlerFunc {
   return func(context *gin.Context) {
      // 记录开始时间
      start := time.Now()
      // 执行后续调用链
      context.Next()
      // 计算时间间隔
      duration := time.Since(start)
      // 输出纳秒，以便观测结果
      fmt.Println("请求用时: ", duration.Nanoseconds())
   }
}

func main() {
  e := gin.Default()
  // 注册全局中间件，计时中间件
  e.Use(GlobalMiddleware(), TimeMiddleware())
  // 注册路由组局部中间件
  v1 := e.Group("/v1", LocalMiddleware())
  {
    v1.GET("/hello", Hello)
    v1.GET("/login", Login)
  }
  v2 := e.Group("/v2")
  {
    // 注册单个路由局部中间件
    v2.POST("/update", LocalMiddleware(), Update)
    v2.DELETE("/delete", Delete)
  }
  log.Fatalln(e.Run(":8080"))
}
```

测试



```
curl --location --request GET 'http://localhost:8080/v1/hello'
```

输出



```
请求用时:  517600
```

一个简单的计时器中间件就已经编写完毕了，后续可以凭借自己的摸索编写一些功能更实用的中间件。

##### [服务配置](https://golang.halfiisland.com/community/pkgs/web/gin.html#服务配置)

光是使用默认的配置是远远不够的，大多数情况下都需求修改很多的服务配置才能达到需求。

###### [Http 配置](https://golang.halfiisland.com/community/pkgs/web/gin.html#http-配置)

可以通过`net/http`创建 Server 来配置，Gin 本身也支持像原生 API 一样使用 Gin。



```
func main() {
   router := gin.Default()
   server := &http.Server{
      Addr:           ":8080",
      Handler:        router,
      ReadTimeout:    10 * time.Second,
      WriteTimeout:   10 * time.Second,
      MaxHeaderBytes: 1 << 20,
   }
   log.Fatal(server.ListenAndServe())
}
```

###### [静态资源配置](https://golang.halfiisland.com/community/pkgs/web/gin.html#静态资源配置)

静态资源在以往基本上是服务端不可或缺的一部分，尽管在现在使用占比正在逐渐减少，但仍旧有大量的系统还是使用单体架构的情况。

Gin 提供了三个方法来加载静态资源



```
// 加载某一静态文件夹
func (group *RouterGroup) Static(relativePath, root string) IRoutes

// 加载某一个fs
func (group *RouterGroup) StaticFS(relativePath string, fs http.FileSystem) IRoutes

// 加载某一个静态文件
func (group *RouterGroup) StaticFile(relativePath, filepath string) IRoutes
```

提示

relativePath 是映射到网页 URL 上的相对路径，root 是文件在项目中的实际路径

假设项目的目录如下



```
root
|
|-- static
|  |
|  |-- a.jpg
|  |
|  |-- favicon.ico
|
|-- view
  |
  |-- html
```



```
func main() {
   router := gin.Default()
   // 加载静态文件目录
   router.Static("/static", "./static")
   // 加载静态文件目录
   router.StaticFS("/view", http.Dir("view"))
   // 加载静态文件
   router.StaticFile("/favicon", "./static/favicon.ico")

   router.Run(":8080")
}
```

###### [跨域配置](https://golang.halfiisland.com/community/pkgs/web/gin.html#跨域配置)

Gin 本身是没有对于跨域配置做出任何处理，需要自行编写中间件来进行实现相应的需求，其实难度也不大，稍微熟悉 HTTP 协议的人一般都能写出来，逻辑基本上都是那一套。



```
func CorsMiddle() gin.HandlerFunc {
   return func(c *gin.Context) {
      method := c.Request.Method
      origin := c.Request.Header.Get("Origin")
      if origin != "" {
         // 生产环境中的服务端通常都不会填 *，应当填写指定域名
         c.Header("Access-Control-Allow-Origin", origin)
         // 允许使用的HTTP METHOD
         c.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, UPDATE")
         // 允许使用的请求头
         c.Header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization")
         // 允许客户端访问的响应头
         c.Header("Access-Control-Expose-Headers", "Content-Length, Access-Control-Allow-Origin, Access-Control-Allow-Headers, Cache-Control, Content-Language, Content-Type")
         // 是否需要携带认证信息 Credentials 可以是 cookies、authorization headers 或 TLS client certificates
         // 设置为true时，Access-Control-Allow-Origin不能为 *
         c.Header("Access-Control-Allow-Credentials", "true")
      }
      // 放行OPTION请求，但不执行后续方法
      if method == "OPTIONS" {
         c.AbortWithStatus(http.StatusNoContent)
      }
      // 放行
      c.Next()
   }
}
```

将中间件注册为全局中间件即可

##### [会话控制](https://golang.halfiisland.com/community/pkgs/web/gin.html#会话控制)

在目前的时代中，流行的三种 Web 会话控制总共有三种，`cookie`，`session`，`JWT`。

###### [Cookie](https://golang.halfiisland.com/community/pkgs/web/gin.html#cookie)

ookie 中的信息是以键值对的形式储存在浏览器中，而且在浏览器中可以直接看到数据

优点：

- 结构简单
- 数据持久

缺点：

- 大小受限
- 明文存储
- 容易受到 CSRF 攻击



```
import (
    "fmt"

    "github.com/gin-gonic/gin"
)

func main() {

    router := gin.Default()

    router.GET("/cookie", func(c *gin.Context) {

         // 获取对应的cookie
        cookie, err := c.Cookie("gin_cookie")

        if err != nil {
            cookie = "NotSet"
            // 设置cookie 参数：key，val，存在时间，目录，域名，是否允许他人通过js访问cookie，仅http
            c.SetCookie("gin_cookie", "test", 3600, "/", "localhost", false, true)
        }

        fmt.Printf("Cookie value: %s \n", cookie)
    })

    router.Run()
}
```

单纯的 cookie 在五六年前用的比较多，不过作者一般很少使用单纯的 cookie 来做会话控制，这样做确实不太安全。

###### [Session](https://golang.halfiisland.com/community/pkgs/web/gin.html#session)

session 存储在服务器中，然后发送一个 cookie 存储在浏览器中，cookie 中存储的是 session_id，之后每次请求服务器通过 session_id 可以获取对应的 session 信息

优点：

- 存储在服务端，增加安全性，便于管理

缺点：

- 存储在服务端，增大服务器开销，降低性能
- 基于 cookie 识别，不安全
- 认证信息在分布式情况下不同步

Session 与 Cookie 是不分家的，每次要用到 Session，默认就是要用到 Cookie 了。Gin 默认是不支持 Session 的，因为 Cookie 是 Http 协议里面的内容，但 Session 不是，不过有第三方中间件支持，安装依赖即可，仓库地址：[gin-contrib/sessions: Gin middleware for session management (github.com)](https://github.com/gin-contrib/sessions#sessions)



```
go get github.com/gin-contrib/sessions
```

支持 cookie，Redis，MongoDB，GORM，PostgreSQL



```
func main() {
   r := gin.Default()
   // 创建基于Cookie的存储引擎
   store := cookie.NewStore([]byte("secret"))
   // 设置Session中间件，mysession即session名称，也是cookie的名称
   r.Use(sessions.Sessions("mysession", store))
   r.GET("/incr", func(c *gin.Context) {
      // 初始化session
      session := sessions.Default(c)
      var count int
      // 获取值
      v := session.Get("count")
      if v == nil {
         count = 0
      } else {
         count = v.(int)
         count++
      }
      // 设置
      session.Set("count", count)
      // 保存
      session.Save()
      c.JSON(200, gin.H{"count": count})
   })
   r.Run(":8000")
}
```

一般不推荐通过 Cookie 存储 Sesison，推荐使用 Redis，其他例子还请自行去官方仓库了解。

###### [JWT](https://golang.halfiisland.com/community/pkgs/web/gin.html#jwt)

优点：

- 基于 JSON，多语言通用
- 可以存储非敏感信息
- 占用很小，便于传输
- 服务端无需存储，利于分布式拓展

缺点：

- Token 刷新问题
- 一旦签发则无法主动控制

自从前端革命以来，前端程序员不再只是一个“写页面的”，前后端分离的趋势愈演愈烈，JWT 是最适合前后端分离和分布式系统来做会话控制的，具有很大的天然优势。考虑到 JWT 已经完全脱离 Gin 的内容，且没有任何中间件支持，因为 JWT 本身就是不局限于任何框架任何语言，在这里就不作细致的讲解，可以前往另一篇文档：[JWT](https://golang.halfiisland.com/community/pkgs/auth/jwt.html)

##### [日志管理](https://golang.halfiisland.com/community/pkgs/web/gin.html#日志管理)

Gin 默认使用的日志中间件采用的是`os.Stdout`，只有最基本的功能，毕竟 Gin 只专注于 Web 服务，大多数情况下应该使用更加成熟的日志框架，不过这并不在本章的讨论范围内，而且 Gin 的拓展性很高，可以很轻易的整合其他框架，这里只讨论其自带的日志服务。

###### [控制台颜色](https://golang.halfiisland.com/community/pkgs/web/gin.html#控制台颜色)



```
gin.DisableConsoleColor() // 关闭控制台日志颜色
```

除了在开发的时候，大多数时候都不建议开启此项

###### [日志写入文件](https://golang.halfiisland.com/community/pkgs/web/gin.html#日志写入文件)



```
func main() {
  e := gin.Default()
    // 关掉控制台颜色
  gin.DisableConsoleColor()
    // 创建两个日志文件
  log1, _ := os.Create("info1.log")
  log2, _ := os.Create("info2.log")
    // 同时记录进两个日志文件
  gin.DefaultWriter = io.MultiWriter(log1, log2)
  e.GET("/hello", Hello)
  log.Fatalln(e.Run(":8080"))
}
```

gin 自带的日志支持写入多个文件，但内容是相同的，使用起来不太方便，并且不会将请求日志写入文件中。



```
func main() {
  router := gin.New()
  // LoggerWithFormatter 中间件会写入日志到 gin.DefaultWriter
  // 默认 gin.DefaultWriter = os.Stdout
  router.Use(gin.LoggerWithFormatter(func(param gin.LogFormatterParams) string {
        //TODO 写入对应文件的逻辑
        ......
    // 输出自定义格式
    return fmt.Sprintf("%s - [%s] \"%s %s %s %d %s \"%s\" %s\"\n",
        param.ClientIP,
        param.TimeStamp.Format(time.RFC1123),
        param.Method,
        param.Path,
        param.Request.Proto,
        param.StatusCode,
        param.Latency,
        param.Request.UserAgent(),
        param.ErrorMessage,
    )
  }))
  router.Use(gin.Recovery())
  router.GET("/ping", func(c *gin.Context) {
    c.String(200, "pong")
  })
  router.Run(":8080")
}
```

通过自定义中间件，可以实现日志写入文件中

###### [路由调试日志格式](https://golang.halfiisland.com/community/pkgs/web/gin.html#路由调试日志格式)

这里修改的只是启动时输出路由信息的的日志



```
func main() {
   e := gin.Default()
   gin.SetMode(gin.DebugMode)
   gin.DebugPrintRouteFunc = func(httpMethod, absolutePath, handlerName string, nuHandlers int) {
      if gin.IsDebugging() {
         log.Printf("路由 %v %v %v %v\n", httpMethod, absolutePath, handlerName, nuHandlers)
      }
   }
   e.GET("/hello", Hello)
   log.Fatalln(e.Run(":8080"))
}
```

输出



```
2022/12/21 17:19:13 路由 GET /hello main.Hello 3
```

**结语**：Gin 算是 Go 语言 Web 框架中最易学习的一种，因为 Gin 真正做到了职责最小化，只是单纯的负责 Web 服务，其他的认证逻辑，数据缓存等等功能都交给开发者自行完成，相比于那些大而全的框架，轻量简洁的 Gin 对于初学者而言更适合也更应该去学习，因为 Gin 并没有强制使用某一种规范，项目该如何构建，采用什么结构都需要自行斟酌，对于初学者而言更能锻炼能力。

#### gRPC

远程过程调用 rpc 应该是微服务当中必须要学习的一个点了，在学习的过程中会遇到各式各样的 rpc 框架，不过在 go 这个领域，几乎所有的 rpc 框架都是基于 gRPC 的，并且它还成为了云原生领域的一个基础协议，为什么选择它，官方如下回答：

> gRPC 是一个现代化的开源高性能远程过程调用(Remote Process Call，RPC) 框架，可以在任何环境中运行。它可以通过可插拔的负载平衡、跟踪、健康检查和身份验证支持，有效地连接数据中心内和数据中心之间的服务。它还适用于连接设备、移动应用程序和浏览器到后端服务的最后一英里分布式计算。

官方网址：[gRPC](https://grpc.io/)

官方文档：[Documentation | gRPC](https://grpc.io/docs/)

gRPC 技术教程：[Basics tutorial | Go | gRPC](https://grpc.io/docs/languages/go/basics/)

ProtocBuf 官网：[Reference Guides | Protocol Buffers Documentation (protobuf.dev)](https://protobuf.dev/reference/)

它也是 CNCF 基金会下一个的开源项目，CNCF 全名 CLOUD NATIVE COMPUTING FOUNDATION，译名云原生计算基金会

![img](./assets/title.png)

##### [特点](https://golang.halfiisland.com/community/mirco/grpc.html#特点)

**简单的服务定义**

使用 Protocol Buffers 定义服务，这是一个强大的二进制序列化工具集和语言。

**启动和扩容都十分迅捷**

只需一行代码即可安装运行时和开发环境，仅需几秒钟既可以扩张到每秒数百万个 RPC

**跨语言，跨平台**

根据不同平台不同语言自动生成客户端和服务端的服务存根

**双向流和集成授权**

基于 HTTP/2 的双向流和可插拔的认证授权

虽然 GRPC 是语言无关的，但是本站的内容大部分都是 go 相关的，所以本文也会使用 go 作为主要语言进行讲解，后续用到的 pb 编译器和生成器如果是其他语言的使用者可以自行到 Protobuf 官网查找。为了方便起见，接下来会直接省略项目的创建过程。

提示

本文参考了以下文章的内容：

[写给 go 开发者的 gRPC 教程-protobuf 基础 - 掘金 (juejin.cn)](https://juejin.cn/post/7191008929986379836)

[gRPC 中的 Metadata - 熊喵君的博客 | PANDAYCHEN](https://pandaychen.github.io/2020/02/22/GRPC-METADATA-INTRO/)

[gRPC 系列——grpc 超时传递原理 | 小米信息部技术团队 (xiaomi-info.github.io)](https://xiaomi-info.github.io/2019/12/30/grpc-deadline/)

[gRPC API 设计指南 | Google Cloud](https://cloud.google.com/apis/design?hl=zh-cn)

##### [依赖安装](https://golang.halfiisland.com/community/mirco/grpc.html#依赖安装)

先下载 Protocol Buffer 编译器，下载地址：[Releases · protocolbuffers/protobuf (github.com)](https://github.com/protocolbuffers/protobuf/releases)

![img](./assets/proto_dl.png)

根据自己的情况选择系统和版本即可，下载完成后需要将 bin 目录添加到环境变量中。

然后还要下载代码生成器，编译器是将 proto 文件生成对应语言的序列化代码，生成器是用于生成业务代码。



```
$ go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
$ go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

创建一个空的项目，名字这里取 grpc_learn，然后引入如下依赖



```
$ go get google.golang.org/grpc
```

最后看一下版本，是不是真的安装成功了



```
$ protoc --version
libprotoc 23.4

$ protoc-gen-go --version
protoc-gen-go.exe v1.28.1

$ protoc-gen-go-grpc --version
protoc-gen-go-grpc 1.3.0
```

##### [Hello World](https://golang.halfiisland.com/community/mirco/grpc.html#hello-world)

###### [项目结构](https://golang.halfiisland.com/community/mirco/grpc.html#项目结构)

下面将以一个 Hello World 示例来进行演示，创建如下的项目结构。



```
grpc_learn\helloworld
|
+---client
|       main.go
|
+---hello
|
|
+---pb
|       hello.proto
|
\---server
        main.go
```

###### [定义 protobuf 文件](https://golang.halfiisland.com/community/mirco/grpc.html#定义-protobuf-文件)

其中，在`pb/hello.proto`中，写入如下内容，这是一个相当简单的示例，如果不会 protoc 语法，请移步相关文档。



```
syntax = "proto3";

// .表示就直接生成在输出路径下，hello是包名
option go_package = ".;hello";

// 请求
message HelloReq {
  string name = 1;


  // 响应
  message HelloRep {
    string msg = 1;
  }

  // 定义服务
  service SayHello {
  rpc Hello(HelloReq) returns (HelloRep) {}
}
```

###### [生成代码](https://golang.halfiisland.com/community/mirco/grpc.html#生成代码)

编写完成后，使用 protoc 编译器生成数据序列化相关的代码，使用生成器生成 rpc 相关代码



```
$ protoc -I ./pb \
    --go_out=./hello ./pb/*.proto\
    --go-grpc_out=./hello ./pb/*.proto
```

此时可以发现`hello`文件夹生成了`hello.pb.go`和`hello_grpc.pb.go`文件，浏览`hello.pb.go`可以发现我们定义的 message



```
type HelloReq struct {
  state         protoimpl.MessageState
  sizeCache     protoimpl.SizeCache
  unknownFields protoimpl.UnknownFields

    // 定义的字段
  Name string `protobuf:"bytes,1,opt,name=name,proto3" json:"name,omitempty"`
}

type HelloRep struct {
  state         protoimpl.MessageState
  sizeCache     protoimpl.SizeCache
  unknownFields protoimpl.UnknownFields

     // 定义的字段
  Msg string `protobuf:"bytes,1,opt,name=msg,proto3" json:"msg,omitempty"`
}
```

在`hello_grpc.pb.go`中可以发现我们定义的服务



```
type SayHelloServer interface {
  Hello(context.Context, *HelloReq) (*HelloRep, error)
  mustEmbedUnimplementedSayHelloServer()
}

// 后续如果我们自己实现服务接口，必须要嵌入该结构体，就不用实现mustEmbedUnimplementedSayHelloServer方法
type UnimplementedSayHelloServer struct {
}

// 默认返回nil
func (UnimplementedSayHelloServer) Hello(context.Context, *HelloReq) (*HelloRep, error) {
  return nil, status.Errorf(codes.Unimplemented, "method Hello not implemented")
}

// 接口约束
func (UnimplementedSayHelloServer) mustEmbedUnimplementedSayHelloServer() {}

type UnsafeSayHelloServer interface {
  mustEmbedUnimplementedSayHelloServer()
}
```

###### [编写服务端](https://golang.halfiisland.com/community/mirco/grpc.html#编写服务端)

在`server/main.go`中编写如下代码



```
package main

import (
  "context"
  "fmt"
  "google.golang.org/grpc"
  pb "grpc_learn/server/protoc"
  "log"
  "net"
)

type GrpcServer struct {
  pb.UnimplementedSayHelloServer
}

func (g *GrpcServer) Hello(ctx context.Context, req *pb.HelloReq) (*pb.HelloRep, error) {
  log.Printf("received grpc req: %+v", req.String())
  return &pb.HelloRep{Msg: fmt.Sprintf("hello world! %s", req.Name)}, nil
}

func main() {
  // 监听端口
  listen, err := net.Listen("tcp", ":8080")
  if err != nil {
    panic(err)
  }
  // 创建gprc服务器
  server := grpc.NewServer()
  // 注册服务
  pb.RegisterSayHelloServer(server, &GrpcServer{})
  // 运行
  err = server.Serve(listen)
  if err != nil {
    panic(err)
  }
}
```

###### [编写客户端](https://golang.halfiisland.com/community/mirco/grpc.html#编写客户端)

在`client/main.go`中写入如下代码



```
package main

import (
  "context"
  "google.golang.org/grpc"
  "google.golang.org/grpc/credentials/insecure"
  pb "grpc_learn/server/protoc"
  "log"
)

func main() {
    // 建立连接，没有加密验证
  conn, err := grpc.Dial("localhost:8080", grpc.WithTransportCredentials(insecure.NewCredentials()))
  if err != nil {
    panic(err)
  }
  defer conn.Close()
  // 创建客户端
  client := pb.NewSayHelloClient(conn)
  // 远程调用
  helloRep, err := client.Hello(context.Background(), &pb.HelloReq{Name: "client"})
  if err != nil {
    panic(err)
  }
  log.Printf("received grpc resp: %+v", helloRep.String())
}
```

###### [运行](https://golang.halfiisland.com/community/mirco/grpc.html#运行)

先运行服务端，再运行客户端，服务端输出如下



```
2023/07/16 16:26:51 received grpc req: name:"client"
```

客户端输出如下



```
2023/07/16 16:26:51 received grpc resp: msg:"hello world! client"
```

在本例中，客户端建立好连接后，在调用远程方法时就跟调用本地方法一样，直接访问`client`的`Hello` 方法并获取结果，这就是一个最简单的 GRPC 例子，许多开源的框架也都是对这一个流程进行了封装。

##### [bufbuild](https://golang.halfiisland.com/community/mirco/grpc.html#bufbuild)

在上述例子中，是直接使用命令生成的代码，如果后期插件多了命令会显得相当繁琐，这时可以通过工具来进行管理 protobuf 文件，正好就有这么一个开源的管理工具`bufbuild/buf`。

开源地址：[bufbuild/buf: A new way of working with Protocol Buffers. (github.com)](https://github.com/bufbuild/buf)

文档地址：[Buf - Install the Buf CLI](https://buf.build/docs/installation)

**特点**

- BSR 管理
- Linter
- 代码生成
- 格式化
- 依赖管理

有了这个工具可以相当方便的管理 protobuf 文件。

文档中提供了相当多的安装方式，可以自己选择。如果本地安装了 go 环境的话，直接使用`go install`安装即可



```
$ go install github.com/bufbuild/buf/cmd/buf@latest
```

安装完毕后查看版本



```
$ buf --version
1.24.0
```

来到`helloworld/pb`文件夹，执行如下命令创建一个 module 来管理 pb 文件。



```
$ buf mod init
$ ls
buf.yaml  hello.proto
```

`buf.yaml`文件内容默认如下



```
version: v1
breaking:
  use:
    - FILE
lint:
  use:
    - DEFAULT
```

再来到`helloworld/`目录下，创建`buf.gen.yaml`，写入如下内容



```
version: v1
plugins:
  - plugin: go
    out: hello
    opt:
  - plugin: go-grpc
    out: hello
    opt:
```

再执行命令生成代码



```
$ buf generate
```

完成后就可以看到生成的文件了，当然 buf 不止这点功能，其他的功能可以自己去文档学习。

##### [流式 RPC](https://golang.halfiisland.com/community/mirco/grpc.html#流式-rpc)

grpc 的调用方式有两大类，一元 RPC（Unary RPC）和流式 RPC（Stream RPC）。Hello World 中的示例就是一个典型的一元 RPC。

![img](./assets/unary_rpc.png)

一元 rpc（或者叫普通 rpc 更能理解些，实在不知道怎么翻译这个`unary`了）用起来就跟普通的 http 一样，客户端请求，服务端返回数据，一问一答的方式。而流式 RPC 的请求和响应都 可以是流式的，如下图

![img](./assets/stream.png)

使用流式请求时，只返回一次响应，客户端可以通过流来多次发送参数给服务端，服务端可以不需要像一元 RPC 那样等到所有参数都接收完毕再处理，具体处理逻辑可以由服务端决定。正常情况下，只有客户端可以主动关闭流式请求，一旦流被关闭，当前 RPC 请求也就会结束。

使用流式响应时，只发送一次参数，服务端可以通过流多次发送数据给客户端，客户端不需要像一元 RPC 那样接受完所有数据再处理，具体的处理逻辑可以由客户端自己决定。正常请求下，只有服务端可以主动关闭流式响应，一旦流被关闭，当前 RPC 请求也就会结束。



```
service MessageService {
  rpc getMessage(stream google.protobuf.StringValue) returns (Message);
}
```

也可以是只有响应是流式的（Server-Streaming RPC）



```
service MessageService {
  rpc getMessage(google.protobuf.StringValue) returns (stream Message);
}
```

或者请求和响应都是流式的（Bi-driectional-Streaming RPC）



```
service MessageService {
  rpc getMessage(stream google.protobuf.StringValue) returns (stream Message);
}
```

###### [单向流式](https://golang.halfiisland.com/community/mirco/grpc.html#单向流式)

下面通过一个例子来演示单向流式的操作，首先创建如下的项目结构



```
grpc_learn\server_client_stream
|   buf.gen.yaml
|
+---client
|       main.go
|
+---pb
|       buf.yaml
|       message.proto
|
\---server
        main.go
```

`message.proto`内容如下



```
syntax = "proto3";


option go_package = ".;message";

import "google/protobuf/wrappers.proto";

message Message {
  string from = 1;
  string content = 2;
  string to = 3;
}

service MessageService {
  rpc receiveMessage(google.protobuf.StringValue) returns (stream Message);
  rpc sendMessage(stream Message) returns (google.protobuf.Int64Value);
}
```

通过 buf 生成代码



```
$ buf generate
```

这里演示是消息服务，`receiveMessage`接收一个指定的用户名，类型为字符串，返回消息流，`sendMessage` 接收消息流，返回成功发送的消息数目，类型为 64 位整型。接下来创建`server/message_service.go`，自己实现默认的代码生成的服务



```
package main

import (
  "google.golang.org/grpc/codes"
  "google.golang.org/grpc/status"
  "google.golang.org/protobuf/types/known/wrapperspb"
  "grpc_learn/server_client_stream/message"
)

type MessageService struct {
  message.UnimplementedMessageServiceServer
}

func (m *MessageService) ReceiveMessage(user *wrapperspb.StringValue, recvServer message.MessageService_ReceiveMessageServer) error {
  return status.Errorf(codes.Unimplemented, "method ReceiveMessage not implemented")
}
func (m *MessageService) SendMessage(sendServer message.MessageService_SendMessageServer) error {
  return status.Errorf(codes.Unimplemented, "method SendMessage not implemented")
}
```

可以看到接收消息和发送消息的参数里面都有一个流包装接口



```
type MessageService_ReceiveMessageServer interface {
    // 发送消息
  Send(*Message) error
  grpc.ServerStream
}

type MessageService_SendMessageServer interface {
    // 发送返回值并关闭连接
  SendAndClose(*wrapperspb.StringValue) error
    // 接收消息
  Recv() (*Message, error)
  grpc.ServerStream
}
```

它们都嵌入了`gprc.ServerStream`接口



```
type ServerStream interface {
  SetHeader(metadata.MD) error
  SendHeader(metadata.MD) error
  SetTrailer(metadata.MD)
  Context() context.Context
  SendMsg(m interface{}) error
  RecvMsg(m interface{}) error
}
```

可以看到，流式 RPC 并不像一元 RPC 那样入参和返回值都可以很明确的体现在函数签名上，这些方法乍一看是看不出来入参和返回值是什么类型的，需要调用传入的 Stream 类型完成流式传输，接下来开始编写服务端的具体逻辑。在编写服务端逻辑的时候，用了一个`sync.map` 来模拟消息队列，当客户端发送`ReceiveMessage` 请求时，服务端通过流式响应不断返回客户端想要的消息，直到超时过后断开请求。当客户端请求`SendMessage` 时，通过流式请求不断发送消息过来，服务端不断的将消息放入队列中，直到客户端主动断开请求，并返回给客户端消息发送条数。



```
package main

import (
  "errors"
  "google.golang.org/protobuf/types/known/wrapperspb"
  "grpc_learn/server_client_stream/message"
  "io"
  "log"
  "sync"
  "time"
)

// 一个模拟的消息队列
var messageQueue sync.Map

type MessageService struct {
  message.UnimplementedMessageServiceServer
}

// ReceiveMessage
// param user *wrapperspb.StringValue
// param recvServer message.MessageService_ReceiveMessageServer
// return error
// 接收指定用户的消息
func (m *MessageService) ReceiveMessage(user *wrapperspb.StringValue, recvServer message.MessageService_ReceiveMessageServer) error {
  timer := time.NewTimer(time.Second * 5)
  for {
    time.Sleep(time.Millisecond * 100)
    select {
    case <-timer.C:
      log.Printf("5秒钟内没有收到%s的消息，关闭连接", user.GetValue())
      return nil
    default:
      value, ok := messageQueue.Load(user.GetValue())
      if !ok {
        messageQueue.Store(user.GetValue(), []*message.Message{})
        continue
      }
      queue := value.([]*message.Message)
      if len(queue) < 1 {
        continue
      }

      // 拿到消息
      msg := queue[0]
      // 通过流式传输将消息发送给客户端
      err := recvServer.Send(msg)
      log.Printf("receive %+v\n", msg)
      if err != nil {
        return err
      }

      queue = queue[1:]
      messageQueue.Store(user.GetValue(), queue)
      timer.Reset(time.Second * 5)
    }
  }
}

// SendMessage
// param sendServer message.MessageService_SendMessageServer
// return error
// 发送消息给指定用户
func (m *MessageService) SendMessage(sendServer message.MessageService_SendMessageServer) error {
  count := 0
  for {
    // 从客户端接收消息
    msg, err := sendServer.Recv()
    if errors.Is(err, io.EOF) {
      return sendServer.SendAndClose(wrapperspb.Int64(int64(count)))
    }
    if err != nil {
      return err
    }
    log.Printf("send %+v\n", msg)

    value, ok := messageQueue.Load(msg.From)
    if !ok {
      messageQueue.Store(msg.From, []*message.Message{msg})
      continue
    }
    queue := value.([]*message.Message)
    queue = append(queue, msg)
    // 将消息放入消息队列中
    messageQueue.Store(msg.From, queue)
    count++
  }
}
```

客户端开了两个协程，一个协程用来发送消息，另一个协程用来接收消息，当然也可以一边发送一边接收，代码如下。



```
package main

import (
  "context"
  "errors"
  "github.com/dstgo/task"
  "google.golang.org/grpc"
  "google.golang.org/grpc/credentials/insecure"
  "google.golang.org/protobuf/types/known/wrapperspb"
  "grpc_learn/server_client_stream/message"
  "io"
  "log"
  "time"
)

var Client message.MessageServiceClient

func main() {
  dial, err := grpc.Dial("localhost:9090", grpc.WithTransportCredentials(insecure.NewCredentials()))
  if err != nil {
    log.Panicln(err)
  }
  defer dial.Close()

  Client = message.NewMessageServiceClient(dial)

  log.SetPrefix("client\t")
  msgTask := task.NewTask(func(err error) {
    log.Panicln(err)
  })

  ctx := context.Background()

  // 接收消息请求
  msgTask.AddJobs(func() {
    receiveMessageStream, err := Client.ReceiveMessage(ctx, wrapperspb.String("jack"))
    if err != nil {
      log.Panicln(err)
    }
    for {
      recv, err := receiveMessageStream.Recv()
      if errors.Is(err, io.EOF) {
        log.Println("暂无消息，关闭连接")
        break
      } else if err != nil {
        break
      }
      log.Printf("receive %+v", recv)
    }
  })

  msgTask.AddJobs(func() {
    from := "jack"
    to := "mike"

    sendMessageStream, err := Client.SendMessage(ctx)
    if err != nil {
      log.Panicln(err)
    }
    msgs := []string{
      "在吗",
      "下午有没有时间一起打游戏",
      "那行吧，以后有时间一起约",
      "就这个周末应该可以吧",
      "那就这么定了",
    }
    for _, msg := range msgs {
      time.Sleep(time.Second)
      sendMessageStream.Send(&message.Message{
        From:    from,
        Content: msg,
        To:      to,
      })
    }
    // 消息发送完了，主动关闭请求并获取返回值
    recv, err := sendMessageStream.CloseAndRecv()
    if err != nil {
      log.Println(err)
    } else {
      log.Printf("发送完毕，总共发送了%d条消息\n", recv.GetValue())
    }
  })

  msgTask.Run()
}
```

执行过后服务端输出如下



```
server  2023/07/18 16:28:24 send from:"jack" content:"在吗" to:"mike"
server  2023/07/18 16:28:24 receive from:"jack" content:"在吗" to:"mike"
server  2023/07/18 16:28:25 send from:"jack" content:"下午有没有时间一起打游戏" to:"mike"
server  2023/07/18 16:28:25 receive from:"jack" content:"下午有没有时间一起打游戏" to:"mike"
server  2023/07/18 16:28:26 send from:"jack" content:"那行吧，以后有时间一起约" to:"mike"
server  2023/07/18 16:28:26 receive from:"jack" content:"那行吧，以后有时间一起约" to:"mike"
server  2023/07/18 16:28:27 send from:"jack" content:"就这个周末应该可以吧" to:"mike"
server  2023/07/18 16:28:27 receive from:"jack" content:"就这个周末应该可以吧" to:"mike"
server  2023/07/18 16:28:28 send from:"jack" content:"那就这么定了" to:"mike"
server  2023/07/18 16:28:28 receive from:"jack" content:"那就这么定了" to:"mike"
server  2023/07/18 16:28:33 5秒钟内没有收到jack的消息，关闭连接
```

客户端输出如下



```
client  2023/07/18 16:28:24 receive from:"jack" content:"在吗" to:"mike"
client  2023/07/18 16:28:25 receive from:"jack" content:"下午有没有时间一起打游戏" to:"mike"
client  2023/07/18 16:28:26 receive from:"jack" content:"那行吧，以后有时间一起约" to:"mike"
client  2023/07/18 16:28:27 receive from:"jack" content:"就这个周末应该可以吧" to:"mike"
client  2023/07/18 16:28:28 发送完毕，总共发送了5条消息
client  2023/07/18 16:28:28 receive from:"jack" content:"那就这么定了" to:"mike"
client  2023/07/18 16:28:33 暂无消息，关闭连接
```

通过这个例子可以发现单向流式 RPC 请求处理起来的话不论是客户端还是服务端都要比一元 rpc 复杂，不过双向流式 RPC 比它们还要更复杂些。

###### [双向流式](https://golang.halfiisland.com/community/mirco/grpc.html#双向流式)

双向流式 PRC，即请求和响应都是流式的，就相当于把上例中的两个服务结合成一个。对于流式 RPC 而言，第一个请求肯定是由客户端发起的，随后客户端可以随时通过流来发送请求参数，服务端也可以随时通过流来返回数据，不管哪一方主动关闭流，当前请求都会结束。

提示

后续的内容除非必要，都会直接省略掉 pb 代码生成以及创建 rpc 客户端服务端这些步骤的代码描述

首先创建如下项目结构



```
bi_stream\
|   buf.gen.yaml
|
+---client
|       main.go
|
+---message
|       message.pb.go
|       message_grpc.pb.go
|
+---pb
|       buf.yaml
|       message.proto
|
\---server
        main.go
        message_service.go
```

`message.proto`内容如下



```
syntax = "proto3";


option go_package = ".;message";

import "google/protobuf/wrappers.proto";

message Message {
  string from = 1;
  string content = 2;
  string to = 3;
}

service ChatService {
  rpc chat(stream Message) returns (stream Message);
}
```

服务端逻辑中，建立连接后，开启两个协程，一个协程负责接收消息，一个负责发送消息，具体的处理逻辑与上个例子类似，不过这次去掉了超时的判定逻辑。



```
package main

import (
  "github.com/dstgo/task"
  "google.golang.org/grpc/metadata"
  "grpc_learn/bi_stream/message"
  "log"
  "sync"
  "time"
)

// MessageQueue 模拟的消息队列
var MessageQueue sync.Map

type ChatService struct {
  message.UnimplementedChatServiceServer
}

// Chat
// param chatServer message.ChatService_ChatServer
// return error
// 聊天服务，服务端逻辑我们用多协程来进行处理
func (m *ChatService) Chat(chatServer message.ChatService_ChatServer) error {
  md, _ := metadata.FromIncomingContext(chatServer.Context())
  from := md.Get("from")[0]
  defer log.Println(from, "end chat")

  var chatErr error
  chatCh := make(chan error)

  // 创建两个协程，一个收消息，一个发消息
  chatTask := task.NewTask(func(err error) {
    chatErr = err
  })

  // 接收消息的协程
  chatTask.AddJobs(func() {
    for {
      msg, err := chatServer.Recv()
      log.Printf("receive %+v err %+v\n", msg, err)
      if err != nil {
        chatErr = err
        chatCh <- err
        break
      }

      value, ok := MessageQueue.Load(msg.To)
      if !ok {
        MessageQueue.Store(msg.To, []*message.Message{msg})
      } else {
        queue := value.([]*message.Message)
        queue = append(queue, msg)
        MessageQueue.Store(msg.To, queue)
      }
    }
  })

  // 发送消息的协程
  chatTask.AddJobs(func() {
  Send:
    for {
      time.Sleep(time.Millisecond * 100)
      select {
      case <-chatCh:
        log.Println(from, "close send")
        break Send
      default:
        value, ok := MessageQueue.Load(from)
        if !ok {
          value = []*message.Message{}
          MessageQueue.Store(from, value)
        }

        queue := value.([]*message.Message)
        if len(queue) < 1 {
          continue Send
        }

        msg := queue[0]
        queue = queue[1:]
        MessageQueue.Store(from, queue)
        err := chatServer.Send(msg)
        log.Printf("send %+v\n", msg)
        if err != nil {
          chatErr = err
          break Send
        }
      }
    }
  })

  chatTask.Run()

  return chatErr
}
```

客户端逻辑中，开启了两个子协程来模拟两个人的聊天过程，两个子协程中分别又各有两个孙协程负责收发消息（客户端逻辑中并没有保证两个人聊天的消息收发顺序正确，只是一个简单的双方发送与接收的例子）



```
package main

import (
  "context"
  "github.com/dstgo/task"
  "google.golang.org/grpc"
  "google.golang.org/grpc/credentials/insecure"
  "google.golang.org/grpc/metadata"
  "grpc_learn/bi_stream/message"
  "log"
  "time"
)

var Client message.ChatServiceClient

func main() {
  log.SetPrefix("client ")
  dial, err := grpc.Dial("localhost:9090", grpc.WithTransportCredentials(insecure.NewCredentials()))
  defer dial.Close()

  if err != nil {
    log.Panicln(err)
  }
  Client = message.NewChatServiceClient(dial)

  chatTask := task.NewTask(func(err error) {
    log.Panicln(err)
  })

  chatTask.AddJobs(func() {
    NewChat("jack", "mike", "你好", "有没有时间一起打游戏？", "好吧")
  })

  chatTask.AddJobs(func() {
    NewChat("mike", "jack", "你好", "没有", "没时间，你找别人吧")
  })

  chatTask.Run()
}

func NewChat(from string, to string, contents ...string) {
  ctx := context.Background()
  mdCtx := metadata.AppendToOutgoingContext(ctx, "from", from)
  chat, err := Client.Chat(mdCtx)
  defer log.Println("end chat", from)

  if err != nil {
    log.Panicln(err)
  }

  chatTask := task.NewTask(func(err error) {
    log.Panicln(err)
  })

  chatTask.AddJobs(func() {
    for _, content := range contents {
      time.Sleep(time.Second)
      chat.Send(&message.Message{
        From:    from,
        Content: content,
        To:      to,
      })
    }
    // 消息发完了，就关闭连接
    time.Sleep(time.Second * 5)
    chat.CloseSend()
  })

  // 接收消息的协程
  chatTask.AddJobs(func() {
    for {
      msg, err := chat.Recv()
      log.Printf("receive %+v\n", msg)
      if err != nil {
        log.Println(err)
        break
      }
    }
  })

  chatTask.Run()
}
```

正常情况下，服务端输出



```
server 2023/07/19 17:18:44 server listening on [::]:9090
server 2023/07/19 17:18:49 receive from:"mike" content:"你好" to:"jack" err <nil>
server 2023/07/19 17:18:49 receive from:"jack" content:"你好" to:"mike" err <nil>
server 2023/07/19 17:18:49 send from:"jack" content:"你好" to:"mike"
server 2023/07/19 17:18:49 send from:"mike" content:"你好" to:"jack"
server 2023/07/19 17:18:50 receive from:"jack" content:"有没有时间一起打游戏？" to:"mike" err <nil>
server 2023/07/19 17:18:50 receive from:"mike" content:"没有" to:"jack" err <nil>
server 2023/07/19 17:18:50 send from:"mike" content:"没有" to:"jack"
server 2023/07/19 17:18:50 send from:"jack" content:"有没有时间一起打游戏？" to:"mike"
server 2023/07/19 17:18:51 receive from:"jack" content:"好吧" to:"mike" err <nil>
server 2023/07/19 17:18:51 receive from:"mike" content:"没时间，你找别人吧" to:"jack" err <nil>
server 2023/07/19 17:18:51 send from:"jack" content:"好吧" to:"mike"
server 2023/07/19 17:18:51 send from:"mike" content:"没时间，你找别人吧" to:"jack"
server 2023/07/19 17:18:56 receive <nil> err EOF
server 2023/07/19 17:18:56 receive <nil> err EOF
server 2023/07/19 17:18:56 jack close send
server 2023/07/19 17:18:56 jack end chat
server 2023/07/19 17:18:56 mike close send
server 2023/07/19 17:18:56 mike end chat
```

正常情况下，客户端输出（可以看到消息的顺序逻辑是乱的）



```
client 2023/07/19 17:26:24 receive from:"jack"  content:"你好"  to:"mike"
client 2023/07/19 17:26:24 receive from:"mike"  content:"你好"  to:"jack"
client 2023/07/19 17:26:25 receive from:"mike"  content:"没有"  to:"jack"
client 2023/07/19 17:26:25 receive from:"jack"  content:"有没有时间一起打游戏？"  to:"mike"
client 2023/07/19 17:26:26 receive from:"jack"  content:"好吧"  to:"mike"
client 2023/07/19 17:26:26 receive from:"mike"  content:"没时间，你找别人吧"  to:"jack"
client 2023/07/19 17:26:32 receive <nil>
client 2023/07/19 17:26:32 rpc error: code = Unknown desc = EOF
client 2023/07/19 17:26:32 end chat jack
client 2023/07/19 17:26:32 receive <nil>
client 2023/07/19 17:26:32 rpc error: code = Unknown desc = EOF
client 2023/07/19 17:26:32 end chat mike
```

通过示例可以看到的是，双向流式的处理逻辑无论是客户端还是服务端，都要比单向流式更复杂，需要结合多协程开启异步任务才能更好的处理逻辑。

##### [metadata](https://golang.halfiisland.com/community/mirco/grpc.html#metadata)

metadata 本质上是一个 map，它的 value 是一个字符串切片，就类似 http1 的 header 一样，并且它在 gRPC 中扮演的角色也和 http header 类似，提供一些本次 RPC 调用的一些信息，同时 metadata 的生命周期跟随着一次 rpc 调用的整个过程，调用结束，它的生命周期也就结束了。

它在 gRPC 中主要通过`context`来进行传输和存储，不过 gRPC 提供了`metadata` 包，里面有相当多的方便函数来简化操作，不需要我们去手动操作`context `。metadata 在 gRPC 中对应的类型为`metadata.MD`，如下所示。



```
// MD is a mapping from metadata keys to values. Users should use the following
// two convenience functions New and Pairs to generate MD.
type MD map[string][]string
```

我们可以直接使用`metadata.New`函数来创建，不过在创建之前，有几个点需要注意



```
func New(m map[string]string) MD
```

metadata 对键名有所限制，仅能是以下规则限制的字符：

- ASCII 字符
- 数字：0-9
- 小写字母：a-z
- 大写字母：A-Z
- 特殊字符：-_

提示

在 metadata 中，大写的字母都会被转换为小写，也就是说会占用同一个 key，值也会被覆盖。

提示

以`grpc-`开头的 key 是 grpc 保留使用的内部 key，如果使用这类 key 的话可能会导致一些错误。

###### [手动创建](https://golang.halfiisland.com/community/mirco/grpc.html#手动创建)

创建 metadata 的方式有很多，这里介绍手动创建 metadata 最常用的两种方法，第一种就是使用`metadata.New`函数，直接传入一个 map。



```
func New(m map[string]string) MD
```



```
md := metadata.New(map[string]string{
    "key":  "value",
    "key1": "value1",
    "key2": "value2",
})
```

第二种是`metadata.Pairs`，传入偶数长度的字符串切片，会自动的解析成键值对。



```
func Pairs(kv ...string) MD
```



```
md := metadata.Pairs("k", "v", "k1", "v1", "k2", "v2")
```

还可以使用`metadata.join`来合并多个 metadata



```
func Join(mds ...MD) MD
```



```
md1 := metadata.New(map[string]string{
    "key":  "value",
    "key1": "value1",
    "key2": "value2",
})
md2 := metadata.Pairs("k", "v", "k1", "v1", "k2", "v2")
union := metadata.join(md1,md2)
```

###### [服务端使用](https://golang.halfiisland.com/community/mirco/grpc.html#服务端使用)

**获取 metadata**

服务端获取 metadata 可以使用`metadata.FromIncomingContext`函数来获取



```
func FromIncomingContext(ctx context.Context) (MD, bool)
```

对于一元 rpc 而言，service 的参数里面会带一个`context`参数，直接从里面获取 metadata 即可



```
func (h *HelloWorld) Hello(ctx context.Context, name *wrapperspb.StringValue) (*wrapperspb.StringValue, error) {
  md, b := metadata.FromIncomingContext(ctx)
  ...
}
```

对于流式 rpc，service 的参数里面会有一个流对象，通过它可以获取流的`context`



```
func (m *ChatService) Chat(chatServer message.ChatService_ChatServer) error {
  md, b := metadata.FromIncomingContext(chatServer.Context())
    ...
}
```

**发送 metadata**

发送 metadata 可以使用`grpc.sendHeader`函数



```
func SendHeader(ctx context.Context, md metadata.MD) error
```

该函数最多调用一次，在一些导致 header 被自动发送的事件发生后使用则不会生效。在一些情况下，如果不想直接发送 header，这时可以使用`grpc.SetHeader` 函数。



```
func SetHeader(ctx context.Context, md metadata.MD) error
```

该函数多次调用的话，会将每次传入的 metadata 合并，并在以下几种情况发送给客户端

- `gprc.SendHeader`和`Servertream.SendHeader`被调用时
- 一元 rpc 的 handler 返回时
- 调用流式 rpc 中流对象的`Stream.SendMsg`时
- rpc 请求的状态变为`send out`，这种情况要么是 rpc 请求成功了，要么就是出错了。

对于流式 rpc 而言，建议使用流对象的`SendHeader`方法和`SetHeader`方法。



```
type ServerStream interface {
  SetHeader(metadata.MD) error
  SendHeader(metadata.MD) error
  SetTrailer(metadata.MD)
  ...
}
```

提示

在使用过程中会发现 Header 和 Trailer 两个功能差不多，不过它们的主要区别在于发送的时机，一元 rpc 中可能体会不到，但是这一差别在流式 RPC 中尤为明显，因为流式 RPC 中的 Header 可以不用等待请求结束就可以发送 Header。前面提到过了 Header 会在特定的情况下被发送，而 Trailer 仅仅只会在整个 RPC 请求结束后才会被发送，在此之前，获取到的 trailer 都是空的。

###### [客户端使用](https://golang.halfiisland.com/community/mirco/grpc.html#客户端使用)

**获取 metadata**

客户端想要获取响应的 header，可以通过`grpc.Header`和`grpc.Trailer`来实现



```
func Header(md *metadata.MD) CallOption
```



```
func Trailer(md *metadata.MD) CallOption
```

不过需要注意的是，并不能直接获取，可以看到以上两个函数返回值是`CallOption`，也就是说是在发起 RPC 请求时作为 option 参数传入的。



```
// 声明用于接收值的md
var header, trailer metadata.MD

// 调用rpc请求时传入option
res, err := client.SomeRPC(
    ctx,
    data,
    grpc.Header(&header),
    grpc.Trailer(&trailer)
)
```

在请求完成后，会将值写到传入的 md 中。对于流式 rpc 而言，可以通过发起请求时返回的流对象直接获取



```
type ClientStream interface {
  Header() (metadata.MD, error)
  Trailer() metadata.MD
    ...
}
```



```
stream, err := client.StreamRPC(ctx)
header, err := stream.Header()
trailer := Stream.Trailer()
```

**发送 metadata**

客户端想要发送 metadata 很简单，之前提到过 metadata 的表现形式就是 valueContext，将 metadata 结合到 context 中，然后在请求的时候把 context 传入即可，`metadata` 包提供了两个函数来方便构造 context。



```
func NewOutgoingContext(ctx context.Context, md MD) context.Context
```



```
md := metadata.Pairs("k1", "v1")
ctx := context.Background()
outgoingContext := metadata.NewOutgoingContext(ctx, md)

// 一元rpc
res,err := client.SomeRPC(outgoingContext,data)
// 流式rpc
stream,err := client.StreamRPC(outgoingContext)
```

如果原有的 ctx 已经有 metadata 了的话，再使用`NewOutgoingContext`会将先前的数据直接覆盖掉，为了避免这种情况，可以使用下面这个函数，它不会覆盖，而是会将数据合并。



```
func AppendToOutgoingContext(ctx context.Context, kv ...string) context.Context
```



```
md := metadata.Pairs("k1", "v1")
ctx := context.Background()
outgoingContext := metadata.NewOutgoingContext(ctx, md)

appendContext := metadata.AppendToOutgoingContext(outgoingContext, "k2","v2")

// 一元rpc
res,err := client.SomeRPC(appendContext,data)
// 流式rpc
stream,err := client.StreamRPC(appendContext)
```

##### [拦截器](https://golang.halfiisland.com/community/mirco/grpc.html#拦截器)

gRPC 的拦截器就类似于 gin 中的 Middleware 一样，都是为了在请求前或者请求后做一些特殊的工作并且不影响到本身的业务逻辑。在 gRPC 中，拦截器有两大类，服务端拦截器和客户端拦截器，根据请求类型来分则有一元 RPC 拦截器，和流式 RPC 拦截器，下图

![img](./assets/interceptor.png)

为了能更好的理解拦截器，下面会根据一个非常简单的示例来进行描述。



```
grpc_learn\interceptor
|   buf.gen.yaml
|
+---client
|       main.go
|
+---pb
|       buf.yaml
|       person.proto
|
+---person
|       person.pb.go
|       person_grpc.pb.go
|
\---server
        main.go
```

`person.proto`内容如下



```
syntax = "proto3";

option go_package = ".;person";

import "google/protobuf/wrappers.proto";

message personInfo {
  string name = 1;
  int64  age = 2;
  string address = 3;
}

service person {
  rpc getPersonInfo(google.protobuf.StringValue) returns (personInfo);
  rpc createPersonInfo(stream personInfo) returns (google.protobuf.Int64Value);
}
```

服务端代码如下，逻辑全是之前的内容，比较简单不再赘述。



```
package main

import (
  "context"
  "errors"
  "google.golang.org/protobuf/types/known/wrapperspb"
  "grpc_learn/interceptor/person"
  "io"
  "sync"
)

// 存放数据
var personData sync.Map

type PersonService struct {
  person.UnimplementedPersonServer
}

func (p *PersonService) GetPersonInfo(ctx context.Context, name *wrapperspb.StringValue) (*person.PersonInfo, error) {
  value, ok := personData.Load(name.Value)
  if !ok {
    return nil, person.PersonNotFoundErr
  }
  personInfo := value.(*person.PersonInfo)
  return personInfo, nil
}

func (p *PersonService) CreatePersonInfo(personStream person.Person_CreatePersonInfoServer) error {
  count := 0
  for {
    personInfo, err := personStream.Recv()
    if errors.Is(err, io.EOF) {
      return personStream.SendAndClose(wrapperspb.Int64(int64(count)))
    } else if err != nil {
      return err
    }

    personData.Store(personInfo.Name, personInfo)
    count++
  }
}
```

###### [服务端拦截](https://golang.halfiisland.com/community/mirco/grpc.html#服务端拦截)

拦截服务端 rpc 请求的有`UnaryServerInterceptor`和`StreamServerInterceptor`，具体类型如下所示



```
type UnaryServerInterceptor func(ctx context.Context, req interface{}, info *UnaryServerInfo, handler UnaryHandler) (resp interface{}, err error)

type StreamServerInterceptor func(srv interface{}, ss ServerStream, info *StreamServerInfo, handler StreamHandler) error
```

**一元 RPC**

创建一元 RPC 拦截器，只需要实现`UnaryserverInterceptor`类型即可，下面是一个简单的一元 RPC 拦截器的例子，功能是输出每一次 rpc 的请求和响应。



```
// UnaryPersonLogInterceptor
// param ctx context.Context
// param req interface{} rpc的请求数据
// param info *grpc.UnaryServerInfo 本次一元RPC的一些请求信息
// param unaryHandler grpc.UnaryHandler 具体的handler
// return resp interface{} rpc的响应数据
// return err error
func UnaryPersonLogInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, unaryHandler grpc.UnaryHandler) (resp interface{}, err error) {
  log.Println(fmt.Sprintf("before unary rpc intercept path: %s req: %+v", info.FullMethod, req))
  resp, err = unaryHandler(ctx, req)
  log.Println(fmt.Sprintf("after unary rpc intercept path: %s resp: %+v err: %+v", info.FullMethod, resp, err))
  return resp, err
}
```

对于一元 RPC 而言，拦截器拦截的是每一个 RPC 的请求和响应，即拦截的是 RPC 的请求阶段和响应阶段，如果拦截器返回 error，那么本次请求就会结束。

**流式 rpc**

创建流式 RPC 拦截器，只需要实现`StreamServerInterceptor`类型即可，下面是一个简单的流式 RPC 拦截器的例子。



```
// StreamPersonLogInterceptor
// param srv interface{} 对应服务端实现的server
// param stream grpc.ServerStream 流对象
// param info *grpc.StreamServerInfo 流信息
// param streamHandler grpc.StreamHandler 处理器
// return error
func StreamPersonLogInterceptor(srv interface{}, stream grpc.ServerStream, info *grpc.StreamServerInfo, streamHandler grpc.StreamHandler) error {
  log.Println(fmt.Sprintf("before stream rpc interceptor path: %s srv: %+v clientStream: %t serverStream: %t", info.FullMethod, srv, info.IsClientStream, info.IsServerStream))
  err := streamHandler(srv, stream)
  log.Println(fmt.Sprintf("after stream rpc interceptor path: %s srv: %+v clientStream: %t serverStream: %t err: %+v", info.FullMethod, srv, info.IsClientStream, info.IsServerStream, err))
  return err
}
```

对于流式 RPC 而言，拦截器拦截的是每一个流对象的`Send`和`Recve` 方法被调用的时机，如果拦截器返回 error，并不会导致本次 RPC 请求的结束，仅仅只是代表着本次`send `或`recv`出现了错误。

**使用拦截器**

要想使创建的拦截器生效，需要在创建 gRPC 服务器的时候作为 option 传入，官方也提供了相关的函数以供使用。如下所示，有添加单个拦截器的函数，也有添加链式拦截器的函数。



```
func UnaryInterceptor(i UnaryServerInterceptor) ServerOption

func ChainUnaryInterceptor(interceptors ...UnaryServerInterceptor) ServerOption

func StreamInterceptor(i StreamServerInterceptor) ServerOption

func ChainStreamInterceptor(interceptors ...StreamServerInterceptor) ServerOption
```

提示

重复使用`UnaryInterceptor`会抛出如下 panic



```
panic: The unary server interceptor was already set and may not be reset.
```

`StreamInterceptor`也是同理，而链式拦截器重复调用则会 append 到同一个链上。

使用示例如下



```
package main

import (
  "google.golang.org/grpc"
  "grpc_learn/interceptor/person"
  "log"
  "net"
)

func main() {
  log.SetPrefix("server ")
  listen, err := net.Listen("tcp", "9090")
  if err != nil {
    log.Panicln(err)
  }
  server := grpc.NewServer(
        // 添加链式拦截器
    grpc.ChainUnaryInterceptor(UnaryPersonLogInterceptor),
    grpc.ChainStreamInterceptor(StreamPersonLogInterceptor),
  )
  person.RegisterPersonServer(server, &PersonService{})
  server.Serve(listen)
}
```

###### [客户端拦截](https://golang.halfiisland.com/community/mirco/grpc.html#客户端拦截)

客户端拦截器跟服务端差不多，一个一元拦截器`UnaryClientInterceptor`，一个流式拦截器`StreamClientInterceptor`，具体类型如下所示。



```
type UnaryClientInterceptor func(ctx context.Context, method string, req, reply interface{}, cc *ClientConn, invoker UnaryInvoker, opts ...CallOption) error

type StreamClientInterceptor func(ctx context.Context, desc *StreamDesc, cc *ClientConn, method string, streamer Streamer, opts ...CallOption) (ClientStream, error)
```

**一元 RPC**

创建一元 RPC 客户端拦截器，实现`UnaryClientInterceptor`即可，下面就是一个简单的例子。



```
// UnaryPersonClientInterceptor
// param ctx context.Context
// param method string 方法名
// param req interface{} 请求数据
// param reply interface{} 响应数据
// param cc *grpc.ClientConn 客户端连接对象
// param invoker grpc.UnaryInvoker 被拦截的具体客户端方法
// param opts ...grpc.CallOption 本次请求的配置项
// return error
func UnaryPersonClientInterceptor(ctx context.Context, method string, req, reply interface{}, cc *grpc.ClientConn, invoker grpc.UnaryInvoker, opts ...grpc.CallOption) error {
  log.Println(fmt.Sprintf("before unary request path: %s req: %+v", method, req))
  err := invoker(ctx, method, req, reply, cc, opts...)
  log.Println(fmt.Sprintf("after unary request path: %s req: %+v rep: %+v", method, req, reply))
  return err
}
```

通过客户端的一元 RPC 拦截器，可以获取到本地请求的请求数据和响应数据以及一些其他的请求信息。

**流式 RPC**

创建一个流式 RPC 客户端拦截器，实现`StreamClientInterceptor`即可，下面就是一个例子。



```
// StreamPersonClientInterceptor
// param ctx context.Context
// param desc *grpc.StreamDesc 流对象的描述信息
// param cc *grpc.ClientConn 连接对象
// param method string 方法名
// param streamer grpc.Streamer 用于创建流对象的对象
// param opts ...grpc.CallOption 连接配置项
// return grpc.ClientStream 创建好的客户端流对象
// return error
func StreamPersonClientInterceptor(ctx context.Context, desc *grpc.StreamDesc, cc *grpc.ClientConn, method string, streamer grpc.Streamer, opts ...grpc.CallOption) (grpc.ClientStream, error) {
  log.Println(fmt.Sprintf("before create stream  path: %s name: %+v client: %t server: %t", method, desc.StreamName, desc.ClientStreams, desc.ServerStreams))
  stream, err := streamer(ctx, desc, cc, method, opts...)
  log.Println(fmt.Sprintf("after create stream  path: %s name: %+v client: %t server: %t", method, desc.StreamName, desc.ClientStreams, desc.ServerStreams))
  return stream, err
}
```

通过流式 RPC 客户端拦截器，只能拦截到客户端与服务端建立连接的时候也就是创建流的时机，并不能拦截到客户端流对象每一次收发消息的时候，不过我们把拦截器中创建好的流对象包装一下就可以实现拦截收发消息了，就像下面这样



```
// StreamPersonClientInterceptor
// param ctx context.Context
// param desc *grpc.StreamDesc 流对象的描述信息
// param cc *grpc.ClientConn 连接对象
// param method string 方法名
// param streamer grpc.Streamer 用于创建流对象的对象
// param opts ...grpc.CallOption 连接配置项
// return grpc.ClientStream 创建好的客户端流对象
// return error
func StreamPersonClientInterceptor(ctx context.Context, desc *grpc.StreamDesc, cc *grpc.ClientConn, method string, streamer grpc.Streamer, opts ...grpc.CallOption) (grpc.ClientStream, error) {
  log.Println(fmt.Sprintf("before create stream  path: %stream name: %+v client: %t server: %t", method, desc.StreamName, desc.ClientStreams, desc.ServerStreams))
  stream, err := streamer(ctx, desc, cc, method, opts...)
  log.Println(fmt.Sprintf("after create stream  path: %stream name: %+v client: %t server: %t", method, desc.StreamName, desc.ClientStreams, desc.ServerStreams))
  return &ClientStreamInterceptorWrapper{method, desc, stream}, err
}

type ClientStreamInterceptorWrapper struct {
  method string
  desc   *grpc.StreamDesc
  grpc.ClientStream
}

func (c *ClientStreamInterceptorWrapper) SendMsg(m interface{}) error {
  // 消息发送前
  err := c.ClientStream.SendMsg(m)
  // 消息发送后
  log.Println(fmt.Sprintf("%s send %+v err: %+v", c.method, m, err))
  return err
}

func (c *ClientStreamInterceptorWrapper) RecvMsg(m interface{}) error {
  // 消息接收前
  err := c.ClientStream.RecvMsg(m)
  // 消息接收后
  log.Println(fmt.Sprintf("%s recv %+v err: %+v", c.method, m, err))
  return err
}
```

**使用拦截器**

使用时，与服务端类似也是四个工具函数通过 option 来添加拦截器，分为单个拦截器和链式拦截器。



```
func WithUnaryInterceptor(f UnaryClientInterceptor) DialOption

func WithChainUnaryInterceptor(interceptors ...UnaryClientInterceptor) DialOption

func WithStreamInterceptor(f StreamClientInterceptor) DialOption

func WithChainStreamInterceptor(interceptors ...StreamClientInterceptor) DialOption
```

提示

客户端重复使用`WithUnaryInterceptor`不会抛出 panic，但是仅最后一个会生效。

下面是一个使用案例



```
package main

import (
  "context"
  "fmt"
  "google.golang.org/grpc"
  "google.golang.org/grpc/credentials/insecure"
  "google.golang.org/protobuf/types/known/wrapperspb"
  "grpc_learn/interceptor/person"
  "log"
)

func main() {
  log.SetPrefix("client ")
  dial, err := grpc.Dial("localhost:9090",
    grpc.WithTransportCredentials(insecure.NewCredentials()),
    grpc.WithChainUnaryInterceptor(UnaryPersonClientInterceptor),
    grpc.WithChainStreamInterceptor(StreamPersonClientInterceptor),
  )
  if err != nil {
    log.Panicln(err)
  }

  ctx := context.Background()
  client := person.NewPersonClient(dial)

  personStream, err := client.CreatePersonInfo(ctx)
  personStream.Send(&person.PersonInfo{
    Name:    "jack",
    Age:     18,
    Address: "usa",
  })
  personStream.Send(&person.PersonInfo{
    Name:    "mike",
    Age:     20,
    Address: "cn",
  })
  recv, err := personStream.CloseAndRecv()
  log.Println(recv, err)

  log.Println(client.GetPersonInfo(ctx, wrapperspb.String("jack")))
  log.Println(client.GetPersonInfo(ctx, wrapperspb.String("jenny")))
}
```

到目前为止，整个案例已经编写完毕，是时候来运行一下看看结果是什么样的。服务端输出如下



```
server 2023/07/20 17:27:57 before stream rpc interceptor path: /person/createPersonInfo srv: &{UnimplementedPersonServer:{}} clientStream: true serverStream: false
server 2023/07/20 17:27:57 after stream rpc interceptor path: /person/createPersonInfo srv: &{UnimplementedPersonServer:{}} clientStream: true serverStream: false err: <nil>
server 2023/07/20 17:27:57 before unary rpc intercept path: /person/getPersonInfo req: value:"jack"
server 2023/07/20 17:27:57 after unary rpc intercept path: /person/getPersonInfo resp: name:"jack" age:18 address:"usa" err: <nil>
server 2023/07/20 17:27:57 before unary rpc intercept path: /person/getPersonInfo req: value:"jenny"
server 2023/07/20 17:27:57 after unary rpc intercept path: /person/getPersonInfo resp: <nil> err: person not found
```

客户端输出如下



```
C:\Users\Stranger\AppData\Local\Temp\GoLand\___go_build_grpc_learn_interceptor_client.exe
client 2023/07/20 17:27:57 before create stream  path: /person/createPersonInfotream name: createPersonInfo client: true server: false
client 2023/07/20 17:27:57 after create stream  path: /person/createPersonInfotream name: createPersonInfo client: true server: false
client 2023/07/20 17:27:57 /person/createPersonInfo send name:"jack" age:18 address:"usa" err: <nil>
client 2023/07/20 17:27:57 /person/createPersonInfo send name:"mike" age:20 address:"cn" err: <nil>
client 2023/07/20 17:27:57 /person/createPersonInfo recv value:2 err: <nil>
client 2023/07/20 17:27:57 value:2 <nil>
client 2023/07/20 17:27:57 before unary request path: /person/getPersonInfotream req: value:"jack"
client 2023/07/20 17:27:57 after unary request path: /person/getPersonInfotream req: value:"jack" rep: name:"jack" age:18 address:"usa"
client 2023/07/20 17:27:57 name:"jack" age:18 address:"usa" <nil>
client 2023/07/20 17:27:57 before unary request path: /person/getPersonInfotream req: value:"jenny"
client 2023/07/20 17:27:57 after unary request path: /person/getPersonInfotream req: value:"jenny" rep:
client 2023/07/20 17:27:57 <nil> rpc error: code = Unknown desc = person not found
```

可以看到两边的输出都符合预期，起到了拦截的效果，这个案例只是一个很简单的示例，利用 gRPC 的拦截器可以做很多事情比如授权，日志，监控等等其他功能，可以选择自己造轮子，也可以选择使用开源社区现成的轮子，[gRPC Ecosystem](https://github.com/grpc-ecosystem) 专门收集了一系列开源的 gRPC 拦截器中间件，地址：[grpc-ecosystem/go-grpc-middleware](https://github.com/grpc-ecosystem/go-grpc-middleware)。

##### [错误处理](https://golang.halfiisland.com/community/mirco/grpc.html#错误处理)

在开始之前先来看一个例子，在上一个拦截器案例中，如果用户查询不到，会向客户端返回错误`person not found` ，那么问题来了，客户端能不能根据返回的错误做特殊的处理呢？接下来试一试，在客户端代码中，尝试使用`errors.Is`来判断错误。



```
func main() {
  log.SetPrefix("client ")
  dial, err := grpc.Dial("localhost:9090",
    grpc.WithTransportCredentials(insecure.NewCredentials()),
    grpc.WithChainUnaryInterceptor(UnaryPersonClientInterceptor),
    grpc.WithChainStreamInterceptor(StreamPersonClientInterceptor),
  )
  if err != nil {
    log.Panicln(err)
  }

  ctx := context.Background()
  client := person.NewPersonClient(dial)

  personStream, err := client.CreatePersonInfo(ctx)
  personStream.Send(&person.PersonInfo{
    Name:    "jack",
    Age:     18,
    Address: "usa",
  })
  personStream.Send(&person.PersonInfo{
    Name:    "mike",
    Age:     20,
    Address: "cn",
  })
  recv, err := personStream.CloseAndRecv()
  log.Println(recv, err)

  info, err := client.GetPersonInfo(ctx, wrapperspb.String("john"))
  log.Println(info, err)
  if errors.Is(err, person.PersonNotFoundErr) {
    log.Println("person not found err")
  }
}
```

结果输出如下



```
client 2023/07/21 16:46:10 before create stream  path: /person/createPersonInfotream name: createPersonInfo client: true server: false
client 2023/07/21 16:46:10 after create stream  path: /person/createPersonInfotream name: createPersonInfo client: true server: false
client 2023/07/21 16:46:10 /person/createPersonInfo send name:"jack"  age:18  address:"usa" err: <nil>
client 2023/07/21 16:46:10 /person/createPersonInfo send name:"mike"  age:20  address:"cn" err: <nil>
client 2023/07/21 16:46:10 /person/createPersonInfo recv value:2 err: <nil>
client 2023/07/21 16:46:10 value:2 <nil>
client 2023/07/21 16:46:10 before unary request path: /person/getPersonInfotream req: value:"john"
client 2023/07/21 16:46:10 after unary request path: /person/getPersonInfotream req: value:"john" rep:
client 2023/07/21 16:46:10 <nil> rpc error: code = Unknown desc = person not found
```

可以看到客户端接收的 error 是这样的，会发现服务端返回的 error 在 desc 这个字段里面



```
rpc error: code = Unknown desc = person not found
```

自然`errors.Is`这段逻辑也就没有执行，即便换成`errors.As`也是一样的结果。



```
if errors.Is(err, person.PersonNotFoundErr) {
    log.Println("person not found err")
}
```

为此，gRPC 提供了`status` 包来解决这类问题，这也是为什么客户端接收到的错误会有 code 和 desc 字段的原因，因为 gRPC 实际上返回给客户端的是一个`Status` ，其具体类型如下，可以看出也是一个 protobuf 定义的 message。



```
type Status struct {
   state         protoimpl.MessageState
   sizeCache     protoimpl.SizeCache
   unknownFields protoimpl.UnknownFields

   Code int32 `protobuf:"varint,1,opt,name=code,proto3" json:"code,omitempty"`
   Message string `protobuf:"bytes,2,opt,name=message,proto3" json:"message,omitempty"`
   Details []*anypb.Any `protobuf:"bytes,3,rep,name=details,proto3" json:"details,omitempty"`
}
```



```
message Status {
  // The status code, which should be an enum value of
  // [google.rpc.Code][google.rpc.Code].
  int32 code = 1;

  // A developer-facing error message, which should be in English. Any
  // user-facing error message should be localized and sent in the
  // [google.rpc.Status.details][google.rpc.Status.details] field, or localized
  // by the client.
  string message = 2;

  // A list of messages that carry the error details.  There is a common set of
  // message types for APIs to use.
  repeated google.protobuf.Any details = 3;
}
```

###### [错误码](https://golang.halfiisland.com/community/mirco/grpc.html#错误码)

Status 结构体中的 Code，是一种类似 Http Status 形式的存在，用于表示当前 rpc 请求的状态，gRPC 定义了 16 个 code 位于`grpc/codes` ，涵盖了大部分的场景，分别如下所示



```
// A Code is an unsigned 32-bit error code as defined in the gRPC spec.
type Code uint32

const (
  // 调用成功
  OK Code = 0

  // 请求被取消
  Canceled Code = 1

  // 未知错误
  Unknown Code = 2

  // 参数不合法
  InvalidArgument Code = 3

    // 请求超时
  DeadlineExceeded Code = 4

  // 资源不存在
  NotFound Code = 5

    // 已存在相同的资源（能出现这个我是没想到的）
  AlreadyExists Code = 6

  // 权限不足被拒绝访问
  PermissionDenied Code = 7

  // 资源枯竭，剩下的容量不足以使用，比如磁盘容量不够了之类的情况
  ResourceExhausted Code = 8

  // 执行条件不足，比如使用rm删除一个非空的目录，删除的条件是目录是空的，但条件不满足
  FailedPrecondition Code = 9

  // 请求被打断
  Aborted Code = 10

  // 操作访问超出限制范围
  OutOfRange Code = 11

  // 表示当前服务没有实现
  Unimplemented Code = 12

  // 系统内部错误
  Internal Code = 13

  // 服务不可用
  Unavailable Code = 14

  // 数据丢失
  DataLoss Code = 15

  // 没有通过认证
  Unauthenticated Code = 16

  _maxCode = 17
)
```

`grpc/status`包提供了相当多的函数以方 status 与 error 之间的相互转换。我们可以直接使用`status.New`来创建一个 Status，或者`Newf`



```
func New(c codes.Code, msg string) *Status

func Newf(c codes.Code, format string, a ...interface{}) *Status
```

例如下面的代码



```
success := status.New(codes.OK, "request success")
notFound := status.Newf(codes.NotFound, "person not found: %s", name)
```

通过 status 的 err 方法可以获取到其中的 error，当状态为 ok 的时候 error 为 nil。



```
func (s *Status) Err() error {
  if s.Code() == codes.OK {
    return nil
  }
  return &Error{s: s}
}
```

也可以直接创建 error



```
func Err(c codes.Code, msg string) error

func Errorf(c codes.Code, format string, a ...interface{}) error
```



```
success := status.Error(codes.OK, "request success")
notFound := status.Errorf(codes.InvalidArgument, "person not found: %s", name)
```

于是我们可以将服务代码修改成如下



```
func (p *PersonService) GetPersonInfo(ctx context.Context, name *wrapperspb.StringValue) (*person.PersonInfo, error) {
  value, ok := personData.Load(name.Value)
  if !ok {
    return nil, status.Errorf(codes.NotFound, "person not found: %s", name.String())
  }
  personInfo := value.(*person.PersonInfo)
  return personInfo, status.Errorf(codes.OK, "request success")
}
```

在此之前，服务端返回的所有的 code 都是 unknown，现在经过修改后有了更加明确的语义。于是在客户端就可以通过`status.FromError` 或者使用下面的函数从 error 中获取 status，从而根据不同的 code 来做出响应的处理



```
func FromError(err error) (s *Status, ok bool)

func Convert(err error) *Status

func Code(err error) codes.Code
```

示例如下



```
info, err := client.GetPersonInfo(ctx, wrapperspb.String("john"))
s, ok := status.FromError(err)
switch s.Code() {
case codes.OK:
case codes.InvalidArgument:
    ...
}
```

不过尽管 grpc 的 code 已经尽可能的涵盖了一些通用场景，不过有时候还是无法满足开发人员的需求，这个时候就可以使用 Status 中的 Details 字段，并且它还是一个切片，可以容纳多个信息。通过`Status.WithDetails` 来传入一些自定义的信息



```
func (s *Status) WithDetails(details ...proto.Message) (*Status, error)
```

通过`Status.Details`来获取信息



```
func (s *Status) Details() []interface{}
```

需要注意的是，传入的信息最好是由 protobuf 定义的，这样才能方便服务端客户端两端都能解析，官方给出了几个示例



```
message ErrorInfo {
  // 错误的原因
  string reason = 1;

  // 定义服务的主体
  string domain = 2;

  // 其他信息
  map<string, string> metadata = 3;
}

// 重试信息
message RetryInfo {
  // 同一个请求的等待间隔时间
  google.protobuf.Duration retry_delay = 1;
}

// 调试信息
message DebugInfo {
  // 堆栈
  repeated string stack_entries = 1;

  // 一些细节信息
  string detail = 2;
}

    ...
    ...
```

更多的例子可以前往[googleapis/google/rpc/error_details.proto at master · googleapis/googleapis (github.com)](https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto) 查看。如果需要可以通过下面的代码来引入。



```
import "google.golang.org/genproto/googleapis/rpc/errdetails"
```

使用`ErrorInfo`作为 details



```
notFound := status.Newf(codes.NotFound, "person not found: %s", name)
  notFound.WithDetails(&errdetails.ErrorInfo{
    Reason:   "person not found",
    Domain:   "xxx",
    Metadata: nil,
  })
```

在客户端就可以拿到数据做出处理，不过上述只是 gRPC 推荐使用的一些例子，除此之外，同样也可以自己定义 message，来更好的满足相应的业务需求，如果想做一些统一的错误处理，也可以放到拦截器里面操作。

##### [超时控制](https://golang.halfiisland.com/community/mirco/grpc.html#超时控制)

![img](./assets/chain.png)

在大多数情况下，通常不会只有一个服务，并且可能上游有很多服务，下游也有很多服务。客户端发起一次请求，从最上游的服务到最下游，就形成了一个服务调用链，就像图中那样，或许可能比图中的还要长。

如此长的一个调用链，如果其中一个服务的逻辑处理需要花费很长时间，就会导致上游一直处于等待状态。为了减少不必要的资源浪费，因此有必要引入超时这一机制，这样一来最上游调用时传入的超时时间，便是整个调用链所允许的执行花费最大时间。而 gRPC 可以跨进程跨语言传递超时，它把一些需要跨进程传递的数据放在了 HTTP2 的`HEADERS Frame` 帧中，如下图

![img](./assets/http2.png)

gRPC 请求中的超时数据对应着`HEADERS Frame`中的`grpc-timeout` 字段。需要注意的是，并不是所有的 gRPC 库都实现了这一超时传递机制，不过`gRPC-go`肯定是支持的，如果使用其他语言的库，并且使用了这一特性，则需要额外留意这一点。

###### [连接超时](https://golang.halfiisland.com/community/mirco/grpc.html#连接超时)

gRPC 客户端在向服务端建立连接时，默认是异步建立的，如果连接建立失败只会返回一个空的 Client。如果想要使连接同步进行，则可以使用`grpc.WithBlock()` 来使连接未建立成功时阻塞等待。



```
dial, err := grpc.Dial("localhost:9091",
    grpc.WithBlock(),
    grpc.WithTransportCredentials(insecure.NewCredentials()),
    grpc.WithChainUnaryInterceptor(UnaryPersonClientInterceptor),
    grpc.WithChainStreamInterceptor(StreamPersonClientInterceptor),
)
```

如果想要控制一个超时时间，则只需要传入一个 TimeoutContext，使用`grpc.DialContext`来替代`gprc.Dial`以传入 context。



```
timeout, cancelFunc := context.WithTimeout(context.Background(), time.Second)
defer cancelFunc()
dial, err := grpc.DialContext(timeout, "localhost:9091",
    grpc.WithBlock(),
    grpc.WithTransportCredentials(insecure.NewCredentials()),
    grpc.WithChainUnaryInterceptor(UnaryPersonClientInterceptor),
    grpc.WithChainStreamInterceptor(StreamPersonClientInterceptor),
)
```

如此一来，如果连接建立超时，就会返回 error



```
context deadline exceeded
```

在服务端同样也可以设置连接超时，在与客户端建立新连接的时候设置一个超时时间，默认是 120 秒，如果在规定时间内没有成功建立连接，服务端会主动断开连接。



```
server := grpc.NewServer(
    grpc.ConnectionTimeout(time.Second*3),
)
```

提示

`grpc.ConnectionTimeout`仍处于实验阶段，未来的 API 可能会被修改或删除。

###### [请求超时](https://golang.halfiisland.com/community/mirco/grpc.html#请求超时)

gRPC 客户端在发起请求的时候，第一个参数就是`Context`类型，同样的，要想给 RPC 请求加上一个超时时间，只需要传入一个 TimeoutContext 即可



```
timeout, cancel := context.WithTimeout(ctx, time.Second*3)
defer cancel()
info, err := client.GetPersonInfo(timeout, wrapperspb.String("john"))
switch status.Code(err) {
case codes.DeadlineExceeded:
    // 超时逻辑处理
}
```

经过 gRPC 的处理，超时时间被传递到了服务端，在传输过程中它以在帧字段的形式存在中，在 go 里面它以 context 的形式存在，就此在整个链路中进行传递。在链路传递过程中，不建议去修改超时时间，具体在请求时设置多长的超时时间，这应该是最上游应该考虑的问题。

##### [认证授权](https://golang.halfiisland.com/community/mirco/grpc.html#认证授权)

在微服务领域中，每一个服务都需要对请求验证用户身份和权限，如果和单体应用一样，每个服务都要自己实现一套认证逻辑，这显然是不太现实的。所以需要一个统一的认证与授权服务，而常见的解决方案是使用 OAuth2，分布式 Session，和 JWT，这其中，OAuth2 使用最为广泛，一度已经成为了业界标准，OAuth2 最常用的令牌类型就是是 JWT。下面是一张 OAuth2 授权码模式的流程图，基本流程如图所示。

![img](./assets/auth.png)

##### [安全传输](https://golang.halfiisland.com/community/mirco/grpc.html#安全传输)

##### [服务注册与发现](https://golang.halfiisland.com/community/mirco/grpc.html#服务注册与发现)

客户端调用服务端的指定服务之前，需要知晓服务端的 ip 和 port，在先前的案例中，服务端地址都是写死的。在实际的网络环境中不总是那么稳定，一些服务可能会因故障下线而无法访问，也有可能会因为业务发展进行机器迁移而导致地址变化，在这些情况下就不能使用静态地址访问服务了，而这些动态的问题就是服务发现与注册要解决的，服务发现负责监视服务地址的变化并更新，服务注册负责告诉外界自己的地址。gRPC 中，提供了基础的服务发现功能，并且支持拓展和自定义。

不能用静态地址，可以用一些特定的名称来进行代替，比如浏览器通过 DNS 解析域名来获取地址，同样的，gRPC 默认的服务发现就是通过 DNS 来进行的，修改本地的 host 文件，添加如下映射



```
127.0.0.1 example.grpc.com
```

然后将 helloworld 示例中客户端 Dial 的地址改为对应的域名



```
func main() {
  // 建立连接，没有加密验证
  conn, err := grpc.Dial("example.grpc.com:8080",
    grpc.WithTransportCredentials(insecure.NewCredentials()),
  )
  if err != nil {
    panic(err)
  }
  defer conn.Close()
  // 创建客户端
  client := hello2.NewSayHelloClient(conn)
  // 远程调用
  helloRep, err := client.Hello(context.Background(), &hello2.HelloReq{Name: "client"})
  if err != nil {
    panic(err)
  }
  log.Printf("received grpc resp: %+v", helloRep.String())
}
```

同样能看到正常的输出



```
2023/08/26 15:52:52 received grpc resp: msg:"hello world! client"
```

在 gRPC 中，这类名称必须要遵守 RFC 3986 中定义的 URI 语法，格式为



```
                   hierarchical part
        ┌───────────────────┴─────────────────────┐
                    authority               path
        ┌───────────────┴───────────────┐┌───┴────┐
  abc://username:password@example.com:123/path/data?key=value&key2=value2#fragid1
  └┬┘   └───────┬───────┘ └────┬────┘ └┬┘           └─────────┬─────────┘ └──┬──┘
scheme  user information     host     port                  query         fragment
```

上例中的 URI 就是如下形式，由于默认支持 dns 所以省略掉了前缀的 scheme。



```
dns:example.grpc.com:8080
```

除此之外 gRPC 还默认支持 Unix domain sockets，而对于其他的方式，需要我们根据 gRPC 的拓展来进行自定义实现，为此需要实现一个自定义的解析器`resolver.Resovler` ，resolver 负责监控目标地址和服务配置的更新。



```
type Resolver interface {
    // gRPC将调用ResolveNow来尝试再次解析目标名称。这只是一个提示，如果不需要，解析器可以忽略它，该方法可能被并发的调用
  ResolveNow(ResolveNowOptions)
  Close()
}
```

gRPC 要求我们传入一个 Resolver 构造器，也就是`resolver.Builder`，它负责构造 Resolver 实例。



```
type Builder interface {
  Build(target Target, cc ClientConn, opts BuildOptions) (Resolver, error)
  Scheme() string
}
```

Builder 的 Scheme 方法返回它负责解析的 Scheme 类型，例如默认的 dnsBuilder 它返回的就是`dns` ，构造器在初始化时应该使用`resolver.Register`注册到全局 Builder 中，又或者作为 options，使用`grpc.WithResolver` 传入 ClientConn 内部，后者的优先级高于前者。

![img](./assets/discover.png)

上图简单描述了一下 resolver 的工作流程，接下来就演示如何自定义 resolver

##### [自定义服务解析](https://golang.halfiisland.com/community/mirco/grpc.html#自定义服务解析)

下面编写一个自定义解析器，需要一个自定义的解析构造器来进行构造。



```
package myresolver

import (
  "fmt"
  "google.golang.org/grpc/resolver"
)

func NewBuilder(ads map[string][]string) *MyBuilder {
  return &MyBuilder{ads: ads}
}

type MyBuilder struct {
  ads map[string][]string
}

func (c *MyBuilder) Build(target resolver.Target, cc resolver.ClientConn, opts resolver.BuildOptions) (resolver.Resolver, error) {
  if target.URL.Scheme != c.Scheme() {
    return nil, fmt.Errorf("unsupported scheme: %s", target.URL.Scheme)
  }
  m := &MyResolver{ads: c.ads, t: target, cc: cc}
    // 这里必须要updatestate，否则会死锁
  m.start()
  return m, nil
}

func (c *MyBuilder) Scheme() string {
  return "hello"
}

type MyResolver struct {
  t   resolver.Target
  cc  resolver.ClientConn
  ads map[string][]string
}

func (m *MyResolver) start() {
  addres := make([]resolver.Address, 0)
  for _, ad := range m.ads[m.t.URL.Opaque] {
    addres = append(addres, resolver.Address{Addr: ad})
  }

  err := m.cc.UpdateState(resolver.State{
    Addresses: addres,
        // 配置，loadBalancingPolicy指的是负载均衡策略
    ServiceConfig: m.cc.ParseServiceConfig(
      `{"loadBalancingPolicy":"round_robin"}`),
  })

  if err != nil {
    m.cc.ReportError(err)
  }
}

func (m *MyResolver) ResolveNow(_ resolver.ResolveNowOptions) {}

func (m *MyResolver) Close() {}
```

自定义解析器就是把 map 里面的匹配的地址传入到 updatestate，同时还指定了负载均衡的策略，`round_robin`指的是轮询的意思。



```
// service config 结构如下
type jsonSC struct {
    LoadBalancingPolicy *string
    LoadBalancingConfig *internalserviceconfig.BalancerConfig
    MethodConfig        *[]jsonMC
    RetryThrottling     *retryThrottlingPolicy
    HealthCheckConfig   *healthCheckConfig
}
```

客户端代码如下



```
package main

import (
  "context"
  "google.golang.org/grpc"
  "google.golang.org/grpc/credentials/insecure"
  "google.golang.org/grpc/resolver"
  "grpc_learn/helloworld/client/myresolver"
  hello2 "grpc_learn/helloworld/hello"
  "log"
  "time"
)

func init() {
  // 注册builder
  resolver.Register(myresolver.NewBuilder(map[string][]string{
    "myworld": {"127.0.0.1:8080", "127.0.0.1:8081"},
  }))
}

func main() {

  // 建立连接，没有加密验证
  conn, err := grpc.Dial("hello:myworld",
    grpc.WithTransportCredentials(insecure.NewCredentials()),
  )
  if err != nil {
    panic(err)
  }
  defer conn.Close()
  // 创建客户端
  client := hello2.NewSayHelloClient(conn)
     // 每秒调用一次
  for range time.Tick(time.Second) {
    // 远程调用
    helloRep, err := client.Hello(context.Background(), &hello2.HelloReq{Name: "client"})
    if err != nil {
      panic(err)
    }
    log.Printf("received grpc resp: %+v", helloRep.String())
  }

}
```

正常来说，流程应该是服务端向注册中心注册自身服务，然后客户端从注册中心中获取服务列表然后进行匹配，这里传入的 map 就是一个模拟的注册中心，数据是静态的就省略掉了服务注册这一环节，只剩下服务发现。客户端使用的 target 为`hello:myworld` ，hello 是自定义的 scheme，myworld 就是服务名，经过自定义的解析器解析后，就得到了 127.0.0.1: 8080 的真实地址，在实际情况中，为了做负载均衡，一个服务名可能会匹配多个真实地址，所以这就是为什么服务名对应的是一个切片，这里开两个服务端，占用不同的端口，负载均衡策略为轮询，服务端输出分别如下，通过请求时间可以看到负载均衡策略确实是在起作用的，如果不指定策略的话默认只选取第一个服务。



```
// server01
2023/08/29 17:32:21 received grpc req: name:"client"
2023/08/29 17:32:23 received grpc req: name:"client"
2023/08/29 17:32:25 received grpc req: name:"client"
2023/08/29 17:32:27 received grpc req: name:"client"
2023/08/29 17:32:29 received grpc req: name:"client"

// server02
2023/08/29 17:32:20 received grpc req: name:"client"
2023/08/29 17:32:22 received grpc req: name:"client"
2023/08/29 17:32:24 received grpc req: name:"client"
2023/08/29 17:32:26 received grpc req: name:"client"
2023/08/29 17:32:28 received grpc req: name:"client"
```

注册中心其实就是存放着的就是服务注册名与真实服务地址的映射集合，只要是能够进行数据存储的中间件都可以满足条件，甚至拿 mysql 来做注册中心也不是不可以（应该没有人会这么做）。一般来说注册中心都是 KV 存储的，redis 就是一个很不错的选择，但如果使用 redis 来做注册中心的话，我们就需要自行实现很多逻辑，比如服务的心跳检查，服务下线等，服务调度等等，还是相当麻烦的，虽然 redis 在这方面有一定的应用但是较少。正所谓专业的事情交给专业的人做，这方面做的比较出名的有很多：Zookeeper，Consul，Eureka，ETCD，Nacos 等。

可以前往[注册中心对比和选型：Zookeeper、Eureka、Nacos、Consul 和 ETCD - 掘金 (juejin.cn)](https://juejin.cn/post/7068065361312088095) 来了解这几个中间件的一些区别



### 数据库接入

#### Mysql

Mysql 是当下最流行的开源关系型数据库，具体的 sql 知识这里不会做过多的赘述，如果你不会请先自行学习，本文只是简单讲解如何利用 go 进行 sql 操作。在项目中的话一般不会直接使用驱动来进行数据库操作，而是会使用 ORM 框架，这里使用的是`sqlx`库，是对标准`sql`库的增强，没有 ORM 功能那么丰富但是胜在简洁。如果你想使用 ORM，可以去了解`Gorm`，`Xorm`，`Ent`这些库。

##### [依赖](https://golang.halfiisland.com/community/database/Mysql.html#依赖)

下载`sqlx`库



```
$ go get github.com/jmoiron/sqlx
```

`sqlx`或者说标准库`database/sql`支持的数据库不止 MySQL，任何实现了`driver.Driver`接口的类型都支持，比如：

- PostgreSQL
- Oracle
- MariaDB
- SQLite
- 等其他关系数据库

要使用对应的数据库，就需要实现数据库驱动，驱动可以是你自己写的，也可以是第三方库，在使用之前你就要先使用`sql.Register`注册驱动，然后才能使用。不过一般下载的驱动库都会自动注册驱动，不需要你来手动注册。



```
func Register(name string, driver driver.Driver)
```

由于 MySQL 比较流行，也最为简单，所以本文采用 MySQL 来讲解，其他关系数据库操作起来都是大差不大差的，下载 MySQL 驱动库



```
$ go get github.com/go-sql-driver/mysql
```

##### [连接到数据库](https://golang.halfiisland.com/community/database/Mysql.html#连接到数据库)

通过`sqlx.Open`函数，就可以打开一个数据库连接，它接受两个参数，第一个是驱动名称，第二个就是数据源（一般简称 DSN）。



```
func Open(driverName, dataSourceName string) (*DB, error)
```

驱动名称就是注册驱动时使用的名称，需要保持一致，DSN 就是数据库的连接地址，每种数据库都可能会不一样，对于 MySQL 而言就是下面这样



```
db,err := sqlx.Open("mysql","root:123456@tcp(127.0.0.1:3306)/test")
```

##### [准备数据](https://golang.halfiisland.com/community/database/Mysql.html#准备数据)



```
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `age` tinyint(0) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('12132', '张三', 35, '北京市');
INSERT INTO `user` VALUES ('16162', '王五', 22, '上海市');

SET FOREIGN_KEY_CHECKS = 1;
```

##### [查询](https://golang.halfiisland.com/community/database/Mysql.html#查询)

查询，并将结果映射到结构体中



```
var db *sqlx.DB

type Person struct {
   UserId   string `db:"id"`
   Username string `db:"name"`
   Age      int    `db:"age"`
   Address  string `db:"address"`
}

func init() {
    conn, err := sqlx.Open("mysql", "root:wyh246859@tcp(127.0.0.1:3306)/test")
   if err != nil {
      fmt.Println("Open mysql failed", err)
      return
   }

   db = conn
}

func main() {
   query()
   defer db.Close()
}

func query() {
   var person Person
   //查询一个是Get，多个是Select
   err := db.Get(&person, "select * from user where id = ?", "12132")
   if err != nil {
      fmt.Println("query failed:", err)
      return
   }
   fmt.Printf("query succ:%+v", person)
}

func list() {
  var perons []Person
  err := db.Select(&perons, "select * from user")
  if err != nil {
    fmt.Println("list err", err)
    return
  }
  fmt.Printf("list succ,%+v", perons)
}
```

##### [新增](https://golang.halfiisland.com/community/database/Mysql.html#新增)

新增数据



```
func insert() {
   result, err := db.Exec("insert into user value (?,?,?,?)", "120230", "李四", 12, "广州市")
   if err != nil {
      fmt.Println("insert err:", err)
      return
   }
   id, err := result.LastInsertId()
   if err != nil {
      fmt.Println("insert err:", err)
      return
   }
   fmt.Println("insert succ:", id)
}
```

##### [更新](https://golang.halfiisland.com/community/database/Mysql.html#更新)

更新数据



```
func update() {
   res, err := db.Exec("update user set name = ? where id = ?", "赵六", "120230")
   if err != nil {
      fmt.Println("update err:", err)
      return
   }
   eff, err := res.RowsAffected()
   if err != nil || eff == 0 {
      fmt.Println("update err:", err)
      return
   }
   fmt.Println("Update succ")
}
```

##### [删除](https://golang.halfiisland.com/community/database/Mysql.html#删除)

删除数据



```
func delete() {
   res, err := db.Exec("delete from user where id = ?", "120230")
   if err != nil {
      fmt.Println("delete err:", err)
      return
   }
   eff, err := res.RowsAffected()
   if err != nil || eff == 0 {
      fmt.Println("delete err:", err)
      return
   }
   fmt.Println("delete succ")
}
```

##### [事务](https://golang.halfiisland.com/community/database/Mysql.html#事务)



```
func (db *DB) Begin() (*Tx, error) //开始一个事务
func (tx *Tx) Commit() error //提交一个事务
func (tx *Tx) Rollback() error //回滚一个事务
```

当开启一个事务后，为了保险都会加一句`defer tx.Rollback()`，如果如果过程出错了，就会回滚，要是事务成功提交了，这个回滚自然是无效的。



```
func main() {

  transation, err := db.Begin()
  if err != nil {
    fmt.Println("transation err")
  }
    defer transation.Rollback()

  insert()
  query()
  update()
  query()
  delete()
   transation.Commit()
}
```

### Redis

Redis 是一个开源的使用 ANSI C 语言编写、遵守 BSD 协议、支持网络、可基于内存、分布式、可选持久性的键值对(Key-Value)存储数据库，并提供多种语言的 API，Redis 即可以当作一个 NoSQL 数据库，又可以是当作高速缓存存储，还支持简单的消息队列。

本文仅仅讲解如何使用 Go 语言驱动来操作 Redis 数据库，不会对 Redis 本身做任何讲解。

官方文档：[Golang Redis client (uptrace.dev)](https://redis.uptrace.dev/)

官方仓库：[go-redis/redis: Type-safe Redis client for Golang (github.com)](https://github.com/go-redis/redis)

#### [安装](https://golang.halfiisland.com/community/database/Redis.html#安装)

关于 Redis 的驱动有很多，本文使用的是`github.com/go-redis/redis`。

如果你使用的 Redis 版本号为 6



```
go get github.com/go-redis/redis/v8
```

如果你使用的 Redis 版本号为 7



```
go get github.com/go-redis/redis/v9
```

#### [快速开始](https://golang.halfiisland.com/community/database/Redis.html#快速开始)



```
import (
   "fmt"
   "log"
   "testing"

   "github.com/go-redis/redis"
)

func TestQuickStart(t *testing.T) {
   // 创建Redis连接客户端
   redisClient := redis.NewClient(&redis.Options{
      Addr:     "192.168.48.134:6379",
      Password: "123456",
      DB:       0, // 使用默认DB
   })

   // 设置键值对，0就是永不过期
   redisClient.Set("hello", "world", 0)

   // 读取值
   result, err := redisClient.Get("hello").Result()
   if err == redis.Nil {
      fmt.Println("ket not exist")
   } else if err != nil {
      log.Panic(err)
   }
   fmt.Println(result)
}
```

#### [连接配置](https://golang.halfiisland.com/community/database/Redis.html#连接配置)



```
type Options struct {
  // 网络类型 tcp 或者 unix.
  // 默认是 tcp.
  Network string
  // redis地址，格式 host:port
  Addr string

    // Dialer 创建一个新的网络连接且比Network和Addr有着更高的优先级
  // Network and Addr options.
  Dialer func() (net.Conn, error)

  // 新建一个redis连接的时候，会回调这个函数
  OnConnect func(*Conn) error

  // redis密码，redis server没有设置可以为空。
  Password string

  // redis数据库，序号从0开始，默认是0，可以不用设置
  DB int

  // redis操作失败最大重试次数，默认0。
  MaxRetries int

  // 最小重试时间间隔.
  // 默认是 8ms ; -1 表示关闭.
  MinRetryBackoff time.Duration

  // 最大重试时间间隔
  // 默认是 512ms; -1 表示关闭.
  MaxRetryBackoff time.Duration

  // redis新连接超时时间.
  // 默认是 5 秒.
  DialTimeout time.Duration

  // socket读取超时时间
  // 默认 3 秒.
  ReadTimeout time.Duration

  // socket写超时时间
  WriteTimeout time.Duration

  // redis连接池的最大连接数.
  // 默认连接池大小等于 cpu个数 * 10
  PoolSize int

  // redis连接池最小空闲连接数.
  MinIdleConns int

  // redis连接最大的存活时间，默认不会关闭过时的连接.
  MaxConnAge time.Duration

  // 当你从redis连接池获取一个连接之后，连接池最多等待这个拿出去的连接多长时间。
  // 默认是等待 ReadTimeout + 1 秒.
  PoolTimeout time.Duration

  // redis连接池多久会关闭一个空闲连接.
  // 默认是 5 分钟. -1 则表示关闭这个配置项
  IdleTimeout time.Duration

  // 多长时间检测一下，空闲连接
  // 默认是 1 分钟. -1 表示关闭空闲连接检测
  IdleCheckFrequency time.Duration

  // 只读设置，如果设置为true， 在当前节点实例上，redis只能查询缓存不能更新。
  readOnly bool

    // TLS配置
  TLSConfig *tls.Config
}
```

#### [建立连接](https://golang.halfiisland.com/community/database/Redis.html#建立连接)



```
// 创建Redis连接客户端
redisClient := redis.NewClient(&redis.Options{
    Addr:     "192.168.48.134:6379",
    Password: "123456",
    DB:       0, // 使用默认DB
})
```

#### [关闭连接](https://golang.halfiisland.com/community/database/Redis.html#关闭连接)

驱动内部维护着一个连接池，不需要操作一次就关闭一次连接。



```
defer redisClient.Close()
```

这个 Redis 驱动几乎将所有的操作封装好了，Redis 命令和方法名一一对应，基本上只要知道 Redis 命令怎么用，驱动对应的方法都也差不多会了。

Redis 命令：[redis 命令手册](https://redis.com.cn/commands.html)

#### [基本操作](https://golang.halfiisland.com/community/database/Redis.html#基本操作)

##### [删除键](https://golang.halfiisland.com/community/database/Redis.html#删除键)



```
redisClient.Set("name", "jack", 0)
fmt.Println(redisClient.Del("name").Result())
```

##### [过期时间](https://golang.halfiisland.com/community/database/Redis.html#过期时间)



```
redisClient.Set("name", "jack", 0)
// 设置过期时间
redisClient.Expire("name", time.Second*2)
fmt.Println(redisClient.Get("name").Val())
time.Sleep(time.Second * 3)
fmt.Println(redisClient.Get("name").Val())
```

##### [取消过期时间](https://golang.halfiisland.com/community/database/Redis.html#取消过期时间)



```
redisClient.Set("name", "jack", 2)
// 取消过期时间
redisClient.Persist("name")
time.Sleep(time.Second * 2)
fmt.Println(redisClient.Get("name"))
```

##### [查询过期时间](https://golang.halfiisland.com/community/database/Redis.html#查询过期时间)



```
fmt.Println(redisClient.TTL("name"))
fmt.Println(redisClient.PTTL("name"))
```

##### [重命名](https://golang.halfiisland.com/community/database/Redis.html#重命名)



```
redisClient.Rename("name", "newName")
```

##### [查询类型](https://golang.halfiisland.com/community/database/Redis.html#查询类型)



```
redisClient.Type("name")
```

##### [扫描](https://golang.halfiisland.com/community/database/Redis.html#扫描)



```
fmt.Println(redisClient.Scan(0, "", 4))
```

#### [字符串](https://golang.halfiisland.com/community/database/Redis.html#字符串)

##### [简单存取](https://golang.halfiisland.com/community/database/Redis.html#简单存取)



```
redisClient.Set("token", "abcefghijklmn", 0)
fmt.Println(redisClient.Get("token").Val())
```

##### [批量存取](https://golang.halfiisland.com/community/database/Redis.html#批量存取)



```
redisClient.MSet("cookie", "12345", "token", "abcefg")
fmt.Println(redisClient.MGet("cookie", "token").Val())
```

##### [数字增减](https://golang.halfiisland.com/community/database/Redis.html#数字增减)



```
redisClient.Set("age", "1", 0)
// 自增
redisClient.Incr("age")
fmt.Println(redisClient.Get("age").Val())
// 自减
redisClient.Decr("age")
fmt.Println(redisClient.Get("age").Val())
```

#### [哈希表](https://golang.halfiisland.com/community/database/Redis.html#哈希表)

##### [读写操作](https://golang.halfiisland.com/community/database/Redis.html#读写操作)



```
// 单个设置
redisClient.HSet("map", "name", "jack")
// 批量设置
redisClient.HMSet("map", map[string]interface{}{"a": "b", "c": "d", "e": "f"})
// 单个访问
fmt.Println(redisClient.HGet("map", "a").Val())
// 批量访问
fmt.Println(redisClient.HMGet("map", "a", "b").Val())
// 获取整个map
fmt.Println(redisClient.HGetAll("map").Val())
```

输出



```
b
[b <nil>]
map[a:b c:d e:f name:jack]
```

##### [删除键](https://golang.halfiisland.com/community/database/Redis.html#删除键-1)



```
// 删除map的一个字段
redisClient.HDel("map", "a")
```

##### [判断键是否存在](https://golang.halfiisland.com/community/database/Redis.html#判断键是否存在)



```
// 判断字段是否存在
redisClient.HExists("map", "a")
```

##### [获取所有的键](https://golang.halfiisland.com/community/database/Redis.html#获取所有的键)



```
// 获取所有的map的键
redisClient.HKeys("map")
```

##### [获取哈希表键长度](https://golang.halfiisland.com/community/database/Redis.html#获取哈希表键长度)



```
// 获取map长度
redisClient.HLen("map")
```

##### [遍历哈希表的键值对](https://golang.halfiisland.com/community/database/Redis.html#遍历哈希表的键值对)



```
// 遍历map中的键值对
redisClient.HScan("map", 0, "", 1)
```

#### [列表](https://golang.halfiisland.com/community/database/Redis.html#列表)

##### [修改元素](https://golang.halfiisland.com/community/database/Redis.html#修改元素)



```
// 左边添加
redisClient.LPush("list", "a", "b", "c", "d", "e")
// 右边添加
redisClient.RPush("list", "g", "i", "a")
// 在参考值前面插入值
redisClient.LInsertBefore("list", "a", "aa")
// 在参考值后面插入值
redisClient.LInsertAfter("list", "a", "gg")
// 设置指定下标的元素的值
redisClient.LSet("list", 0, "head")
```

##### [访问长度](https://golang.halfiisland.com/community/database/Redis.html#访问长度)



```
// 访问列表长度
redisClient.LLen("list")
```

##### [访问元素](https://golang.halfiisland.com/community/database/Redis.html#访问元素)



```
// 左边弹出元素
redisClient.LPop("list")
// 右边弹出元素
redisClient.RPop("list")
// 访问指定下标的元素
redisClient.LIndex("list", 1)
// 访问指定范围内的元素
redisClient.LRange("list", 0, 1)
```

##### [删除元素](https://golang.halfiisland.com/community/database/Redis.html#删除元素)



```
// 删除指定元素
redisClient.LRem("list", 0, "a")
// 删除指定范围的元素
redisClient.LTrim("list", 0, 1)
// 保留指定范围的元素
redisClient.LTrim("list", 0, 1)
```

#### [集合](https://golang.halfiisland.com/community/database/Redis.html#集合)

##### [新增元素](https://golang.halfiisland.com/community/database/Redis.html#新增元素)



```
// 往一个集合里面添加元素
redisClient.SAdd("set", "a", "b", "c")
redisClient.SAdd("set2", "c", "d", "e")
```

##### [访问集合元素](https://golang.halfiisland.com/community/database/Redis.html#访问集合元素)



```
// 获取集合中的所有成员
redisClient.SMembers("set")
// 判断一个元素是否属于这个集合
redisClient.SIsMember("set", "a")
// 随机返回count个元素
redisClient.SRandMemberN("set", 1)
// 获取一个集合的元素个数
redisClient.SCard("set")
```

##### [集合操作](https://golang.halfiisland.com/community/database/Redis.html#集合操作)



```
// 返回给定集合的差集
redisClient.SDiff("set", "set2")
// 将给定集合的差集保存在结果集里，返回结果集的长度
redisClient.SDiffStore("store", "set", "se2")
// 返回给定集合的交集
redisClient.SInter("set", "set2")
// 将给定集合的交集保存在结果集里，返回结果集的长度
redisClient.SInterStore("store", "set", "set2")
// 返回给定集合的并集
redisClient.SUnion("set", "set2")
// 将给定集合的并集保存在结果集里，返回结果集的长度
redisClient.SUnionStore("store", "set", "store")
```

##### [删除元素](https://golang.halfiisland.com/community/database/Redis.html#删除元素-1)



```
// 弹出并删除该元素
redisClient.SPop("set")
// 弹出并删除N给元素
redisClient.SPopN("set", 2)
```

##### [移动元素](https://golang.halfiisland.com/community/database/Redis.html#移动元素)



```
// 从源集合移动指定元素刀目标集合
redisClient.SMove("set", "set2", "a")
```

##### [删除元素](https://golang.halfiisland.com/community/database/Redis.html#删除元素-2)



```
// 删除指定元素
redisClient.SRem("set", "a", "b")
```

##### [遍历](https://golang.halfiisland.com/community/database/Redis.html#遍历)



```
// 遍历集合
redisClient.SScan("set", 0, "", 2)
```

#### [有序集合](https://golang.halfiisland.com/community/database/Redis.html#有序集合)

##### [加入元素](https://golang.halfiisland.com/community/database/Redis.html#加入元素)



```
// 往有序集合中加入元素
redisClient.ZAdd("ss", redis.Z{
   Score:  1,
   Member: "a",
}, redis.Z{
   Score:  2,
   Member: "b",
})
```

##### [元素排名](https://golang.halfiisland.com/community/database/Redis.html#元素排名)



```
// 返回有序集合中该元素的排名，从低到高排列
redisClient.ZRank("ss", "1")
// 返回有序集合中该元素的排名，从高到低排列
redisClient.ZRevRank("ss", "1")
```

##### [访问元素](https://golang.halfiisland.com/community/database/Redis.html#访问元素-1)



```
// 返回介于min和max之间的成员数量
redisClient.ZCount("ss", "1", "2")

// 返回对元素的权值
redisClient.ZScore("ss", "a")

// 返回指定区间的元素
redisClient.ZRange("ss", 1, 2)
// 返回介于min和max之间的所有成员列表
redisClient.ZRangeByScore("ss", redis.ZRangeBy{
   Min:    "1",
   Max:    "2",
   Offset: 0,
   Count:  1,
})
```

##### [修改权值](https://golang.halfiisland.com/community/database/Redis.html#修改权值)



```
// 给一个对应的元素增加相应的权值
redisClient.ZIncr("ss", redis.Z{
   Score:  2,
   Member: "b",
})
```

##### [删除元素](https://golang.halfiisland.com/community/database/Redis.html#删除元素-3)



```
// 删除指定元素
redisClient.ZRem("ss", "a")
// 删除指定排名区间的元素
redisClient.ZRemRangeByRank("ss", 1, 2)
// 删除权值在min和max区间的元素
redisClient.ZRemRangeByScore("ss", "1", "2")
```

#### [脚本](https://golang.halfiisland.com/community/database/Redis.html#脚本)



```
// 加载脚本，返回sha值
redisClient.ScriptLoad("return 0")
// 根据sha值执行脚本
redisClient.EvalSha("sha", []string{}, "")
// 直接执行脚本
redisClient.Eval("return 0", []string{}, "")
// 清除脚本缓存
redisClient.ScriptFlush()
// 杀死当前正在运行的脚本
redisClient.ScriptKill()
// 验证对应哈希值的脚本是否存在
redisClient.ScriptExists("")
```

#### [发布订阅](https://golang.halfiisland.com/community/database/Redis.html#发布订阅)

```
// 发送消息到指定频道
redisClient.Publish("channel", "message")
// 订阅指定频道
redisClient.Subscribe("channel")
// 查看订阅状态
redisClient.PubSubNumSub("channel")
```

### 日志

Zap 是一个用 Go 构建的，快速的 ，结构化，级别化的日志组件。

官方仓库：[uber-go/zap: Blazing fast, structured, leveled logging in Go. (github.com)](https://github.com/uber-go/zap)

官方文档：[zap package - go.uber.org/zap - Go Packages](https://pkg.go.dev/go.uber.org/zap)

#### [安装](https://golang.halfiisland.com/community/pkgs/logs/Zap.html#安装)



```
go get -u go.uber.org/zap
```

#### [快速开始](https://golang.halfiisland.com/community/pkgs/logs/Zap.html#快速开始)

官方给出了两个快速开始的示例，两个都是产品级别的日志，第一个是一个支持`printf`风格但是性能相对较低的`Sugar`。



```
logger, _ := zap.NewProduction()
defer logger.Sync() // 在程序结束时将缓存同步到文件中
sugar := logger.Sugar()
sugar.Infow("failed to fetch URL",
  "url", url,
  "attempt", 3,
  "backoff", time.Second,
)
sugar.Infof("Failed to fetch URL: %s", url)
```

第二个是性能比较好，但是仅支持强类型输出的日志·`logger`



```
logger, _ := zap.NewProduction()
defer logger.Sync()
logger.Info("failed to fetch URL",
  // Structured context as strongly typed Field values.
  zap.String("url", url),
  zap.Int("attempt", 3),
  zap.Duration("backoff", time.Second),
)
```

提示

Zap 的使用非常简单，麻烦的点在于配置出一个适合自己项目的日志，官方例子很少，要多读源代码注释。

#### [配置](https://golang.halfiisland.com/community/pkgs/logs/Zap.html#配置)

一般来说日志的配置都是写在配置文件里的，Zap 的配置也支持通过配置文件反序列化，但是仅支持基础的配置，即便是高级配置官方给出的例子也是十分简洁，并不足以投入使用，所以要详细讲一下细节的配置。

首先看一下总体的配置结构体，需要先搞明白里面的每一个字段的含义



```
type Config struct {
    // 最小日志级别
   Level AtomicLevel `json:"level" yaml:"level"`
    // 开发模式，主要影响堆栈跟踪
   Development bool `json:"development" yaml:"development"`
    // 调用者追踪
   DisableCaller bool `json:"disableCaller" yaml:"disableCaller"`
    // 堆栈跟踪
   DisableStacktrace bool `json:"disableStacktrace" yaml:"disableStacktrace"`
    // 采样，在限制日志对性能占用的情况下仅记录部分比较有代表性的日志，等于日志选择性记录
   Sampling *SamplingConfig `json:"sampling" yaml:"sampling"`
    // 编码，分为json和console两种模式
   Encoding string `json:"encoding" yaml:"encoding"`
    // 编码配置，主要是一些输出格式化的配置
   EncoderConfig zapcore.EncoderConfig `json:"encoderConfig" yaml:"encoderConfig"`
    // 日志文件输出路径
   OutputPaths []string `json:"outputPaths" yaml:"outputPaths"`
    // 错误文件输出路径
   ErrorOutputPaths []string `json:"errorOutputPaths" yaml:"errorOutputPaths"`
    // 给日志添加一些默认输出的内容
   InitialFields map[string]interface{} `json:"initialFields" yaml:"initialFields"`
}
```

如下是关于编码配置的细节



```
type EncoderConfig struct {
   // 键值，如果key为空，那么对于的属性将不会输出
   MessageKey     string `json:"messageKey" yaml:"messageKey"`
   LevelKey       string `json:"levelKey" yaml:"levelKey"`
   TimeKey        string `json:"timeKey" yaml:"timeKey"`
   NameKey        string `json:"nameKey" yaml:"nameKey"`
   CallerKey      string `json:"callerKey" yaml:"callerKey"`
   FunctionKey    string `json:"functionKey" yaml:"functionKey"`
   StacktraceKey  string `json:"stacktraceKey" yaml:"stacktraceKey"`
   SkipLineEnding bool   `json:"skipLineEnding" yaml:"skipLineEnding"`
   LineEnding     string `json:"lineEnding" yaml:"lineEnding"`
   // 一些自定义的编码器
   EncodeLevel    LevelEncoder    `json:"levelEncoder" yaml:"levelEncoder"`
   EncodeTime     TimeEncoder     `json:"timeEncoder" yaml:"timeEncoder"`
   EncodeDuration DurationEncoder `json:"durationEncoder" yaml:"durationEncoder"`
   EncodeCaller   CallerEncoder   `json:"callerEncoder" yaml:"callerEncoder"`
   // 日志器名称编码器
   EncodeName NameEncoder `json:"nameEncoder" yaml:"nameEncoder"`
   // 反射编码器，主要是对于interface{}类型，如果没有默认jsonencoder
   NewReflectedEncoder func(io.Writer) ReflectedEncoder `json:"-" yaml:"-"`
   // 控制台输出间隔字符串
   ConsoleSeparator string `json:"consoleSeparator" yaml:"consoleSeparator"`
}
```

`Option`是关于一些配置的开关及应用，有很多实现。



```
type Option interface {
   apply(*Logger)
}

// Option的实现
type optionFunc func(*Logger)

func (f optionFunc) apply(log *Logger) {
  f(log)
}

// 应用
func Development() Option {
  return optionFunc(func(log *Logger) {
    log.development = true
  })
}
```

这是最常用的日志核心，其内部的字段基本上就代表了我们配置的步骤，也可以参考官方在反序列化配置时的步骤，大致都是一样的。



```
type ioCore struct {
   // 日志级别
   LevelEnabler
   // 日志编码
   enc Encoder
   // 日志书写
   out WriteSyncer
}
```

`zap.Encoder` 负责日志的格式化，编码

`zap.WriteSyncer` 负责日志的输出，主要是输出到文件和控制台

`zap.LevelEnabler` 最小日志级别，该级别以下的日志不会再通过`syncer`输出。

##### [日志编码](https://golang.halfiisland.com/community/pkgs/logs/Zap.html#日志编码)

日志编码主要涉及到对于日志的一些细节的格式化，首先看一下直接使用最原始的日志的输出。



```
func TestQuickStart(t *testing.T) {
   rawJSON := []byte(`{
     "level": "debug",
     "encoding": "json",
     "outputPaths": ["stdout"],
     "errorOutputPaths": ["stderr"],
     "initialFields": {"foo": "bar"},
     "encoderConfig": {
       "messageKey": "message",
       "levelKey": "level",
       "levelEncoder": "lowercase"
     }
   }`)

   var cfg zap.Config
   if err := json.Unmarshal(rawJSON, &cfg); err != nil {
      panic(err)
   }
   logger := zap.Must(cfg.Build())
   defer logger.Sync()

   logger.Info("logger construction succeeded")
}
```



```
{"level":"info","message":"logger construction succeeded","foo":"bar"}
```

会发现这行日志有几个问题：

- 没有时间
- 没有调用者的情况，不知道这行日志是哪里输出的，不然到时候发生错误的话都没法排查
- 没有堆栈情况

接下来就一步一步的来解决问题，主要是对`zapcore.EncoderConfig`来进行改造，首先我们要自己书写配置文件，不采用官方的直接反序列化。首先自己创建一个配置文件`config.yml`



```
# Zap日志配置
zap:
  prefix: ZapLogTest
  timeFormat: 2006/01/02 - 15:04:05.00000
  level: debug
  caller: true
  stackTrace: false
  encode: console
  # 日志输出到哪里 file | console | both
  writer: both
  logFile:
    maxSize: 20
    backups: 5
    compress: true
    output:
      - "./log/output.log"
```

映射到的结构体



```
// ZapConfig
// @Date: 2023-01-09 16:37:05
// @Description: zap日志配置结构体
type ZapConfig struct {
  Prefix     string         `yaml:"prefix" mapstructure:""prefix`
  TimeFormat string         `yaml:"timeFormat" mapstructure:"timeFormat"`
  Level      string         `yaml:"level" mapstructure:"level"`
  Caller     bool           `yaml:"caller" mapstructure:"caller"`
  StackTrace bool           `yaml:"stackTrace" mapstructure:"stackTrace"`
  Writer     string         `yaml:"writer" mapstructure:"writer"`
  Encode     string         `yaml:"encode" mapstructure:"encode"`
  LogFile    *LogFileConfig `yaml:"logFile" mapstructure:"logFile"`
}

// LogFileConfig
// @Date: 2023-01-09 16:38:45
// @Description: 日志文件配置结构体
type LogFileConfig struct {
  MaxSize  int      `yaml:"maxSize" mapstructure:"maxSize"`
  BackUps  int      `yaml:"backups" mapstructure:"backups"`
  Compress bool     `yaml:"compress" mapstructure:"compress"`
  Output   []string `yaml:"output" mapstructure:"output"`
  Errput   []string `yaml:"errput" mapstructure:"errput"`
}
```

提示

读取配置使用`Viper`，具体代码省略。



```
type TimeEncoder func(time.Time, PrimitiveArrayEncoder)
```

`TimerEncoder`本质上其实是一个函数，我们可以采用官方提供的其他时间编码器，也可以自行编写。



```
func CustomTimeFormatEncoder(t time.Time, encoder zapcore.PrimitiveArrayEncoder) {
   encoder.AppendString(global.Config.ZapConfig.Prefix + "\t" + t.Format(global.Config.ZapConfig.TimeFormat))
}
```

整体部分如下



```
func zapEncoder(config *ZapConfig) zapcore.Encoder {
   // 新建一个配置
   encoderConfig := zapcore.EncoderConfig{
      TimeKey:       "Time",
      LevelKey:      "Level",
      NameKey:       "Logger",
      CallerKey:     "Caller",
      MessageKey:    "Message",
      StacktraceKey: "StackTrace",
      LineEnding:    zapcore.DefaultLineEnding,
      FunctionKey:   zapcore.OmitKey,
   }
   // 自定义时间格式
   encoderConfig.EncodeTime = CustomTimeFormatEncoder
   // 日志级别大写
   encoderConfig.EncodeLevel = zapcore.CapitalColorLevelEncoder
   // 秒级时间间隔
   encoderConfig.EncodeDuration = zapcore.SecondsDurationEncoder
   // 简短的调用者输出
   encoderConfig.EncodeCaller = zapcore.ShortCallerEncoder
   // 完整的序列化logger名称
   encoderConfig.EncodeName = zapcore.FullNameEncoder
   // 最终的日志编码 json或者console
   switch config.Encode {
   case "json":
      {
         return zapcore.NewJSONEncoder(encoderConfig)
      }
   case "console":
      {
         return zapcore.NewConsoleEncoder(encoderConfig)
      }
   }
   // 默认console
   return zapcore.NewConsoleEncoder(encoderConfig)
}
```

##### [日式输出](https://golang.halfiisland.com/community/pkgs/logs/Zap.html#日式输出)

日志输出分为控制台输出和文件输出，我们可以根据配置文件来进行动态配置，并且如果想要进行日志文件切割的话还需要使用另一个第三方的依赖。



```
go get -u github.com/natefinch/lumberjack
```

最后代码如下



```
 func zapWriteSyncer(cfg *ZapConfig) zapcore.WriteSyncer {
   syncers := make([]zapcore.WriteSyncer, 0, 2)
   // 如果开启了日志控制台输出，就加入控制台书写器
   if cfg.Writer == config.WriteBoth || cfg.Writer == config.WriteConsole {
      syncers = append(syncers, zapcore.AddSync(os.Stdout))
   }

   // 如果开启了日志文件存储，就根据文件路径切片加入书写器
   if cfg.Writer == config.WriteBoth || cfg.Writer == config.WriteFile {
      // 添加日志输出器
      for _, path := range cfg.LogFile.Output {
         logger := &lumberjack.Logger{
            Filename:   path, //文件路径
            MaxSize:    cfg.LogFile.MaxSize, //分割文件的大小
            MaxBackups: cfg.LogFile.BackUps, //备份次数
            Compress:   cfg.LogFile.Compress, // 是否压缩
            LocalTime:  true, //使用本地时间
         }
         syncers = append(syncers, zapcore.Lock(zapcore.AddSync(logger)))
      }
   }
   return zap.CombineWriteSyncers(syncers...)
}
```

##### [日志级别](https://golang.halfiisland.com/community/pkgs/logs/Zap.html#日志级别)

官方有关于日志级别的枚举项，直接使用即可。



```
func zapLevelEnabler(cfg *ZapConfig) zapcore.LevelEnabler {
   switch cfg.Level {
   case config.DebugLevel:
      return zap.DebugLevel
   case config.InfoLevel:
      return zap.InfoLevel
   case config.ErrorLevel:
      return zap.ErrorLevel
   case config.PanicLevel:
      return zap.PanicLevel
   case config.FatalLevel:
      return zap.FatalLevel
   }
   // 默认Debug级别
   return zap.DebugLevel
}
```

##### [最后构建](https://golang.halfiisland.com/community/pkgs/logs/Zap.html#最后构建)



```
func InitZap(config *ZapConfig) *zap.Logger {
   // 构建编码器
   encoder := zapEncoder(config)
   // 构建日志级别
   levelEnabler := zapLevelEnabler(config)
   // 最后获得Core和Options
   subCore, options := tee(config, encoder, levelEnabler)
    // 创建Logger
   return zap.New(subCore, options...)
}

// 将所有合并
func tee(cfg *ZapConfig, encoder zapcore.Encoder, levelEnabler zapcore.LevelEnabler) (core zapcore.Core, options []zap.Option) {
   sink := zapWriteSyncer(cfg)
   return zapcore.NewCore(encoder, sink, levelEnabler), buildOptions(cfg, levelEnabler)
}

// 构建Option
func buildOptions(cfg *ZapConfig, levelEnabler zapcore.LevelEnabler) (options []zap.Option) {
   if cfg.Caller {
      options = append(options, zap.AddCaller())
   }

   if cfg.StackTrace {
      options = append(options, zap.AddStacktrace(levelEnabler))
   }
   return
}
```
