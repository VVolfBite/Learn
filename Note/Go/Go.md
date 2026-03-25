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

  | 数据类型    | 描述                                      |
  | :---------- | :---------------------------------------- |
  | **int8**    | 8位有符号整数                             |
  | **int16**   | 16位有符号整数                            |
  | **int32**   | 32位有符号整数                            |
  | **int64**   | 64位有符号整数                            |
  | **uint8**   | 8位无符号整数                             |
  | **uint16**  | 16位无符号整数                            |
  | **uint32**  | 32位无符号整数                            |
  | **uint64**  | 64位无符号整数                            |
  | **int**     | 平台相关的有符号整数，通常为32位或64位。  |
  | **uint**    | 平台相关的无符号整数，通常为32位或64位。  |
  | **rune**    | `int32` 的别名，表示一个 Unicode 代码点。 |
  | **byte**    | `uint8` 的别名。                          |
  | **uintptr** | 无符号整数类型，可容纳指针值的位模式。    |

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
    // 1. stringValue[index] 取得的是字节，不一定是完整字符。
    // 2. for range 按 rune 遍历，适合处理 Unicode 文本。
    // 3. 字符串不可修改，修改通常需要转为 []byte 或 []rune。
}
```

#### 

#### 聚合类型

##### 数组

Go编程语言中的数组与其他编程语言非常相似。在程序中，有时我们需要存储一组相同类型的数据，例如学生分数列表。这种类型的集合使用数组存储在程序中。数组是固定长度的序列，用于将同类元素存储在内存中。由于它们的固定长度数组不像Go语言中的Slice(切片)这样受欢迎。
在数组中，允许在其中存储零个或零个以上的元素。通过使用[]索引运算符及其从零开始的位置对数组的元素进行索引，这意味着第一个元素的索引为*array [0]*，最后一个元素的索引为*array [len（array）-1]*。

![golang中的数组](./assets/Untitled-Diagram33.jpg)

###### 数组声明

在Go语言中，数组是通过两种不同的方式创建的：

- **使用var关键字：**在Go语言中，使用具有名称，大小和元素的特定类型的var关键字创建数组。

  **语法：**

  ```
  Var array_name[length]Type
  或
  var array_name[length]Typle{item1, item2, item3, ...itemN}
  ```

  **重要事项：**

  - 在Go语言中，数组是可变的，因此您可以在分配的左侧使用array [index]语法在给定索引处设置数组的元素。

    ```
    Var array_name[index] = element[object Object]
    ```

  - 您可以使用索引值或使用for循环来访问数组的元素。

  - 在Go语言中，数组类型是一维的。

  - 数组的长度是固定的，不能更改。

  - 您可以将重复的元素存储在数组中。

  - 示例

    ```
    //使用var关键字创建一个数组
    //使用其索引值访问数组
    package main
    
    import "fmt"
    
    func main() {
    
        //使用var关键字，创建一个字符串类型的数组
        var myarr [3]string
    
        //使用索引分配元素
        myarr[0] = "GFG"
        myarr[1] = "www.cainiaojc.com"
        myarr[2] = "cainiaojc"
    
        //访问数组的元素
        //使用索引值
        fmt.Println("数组的元素:")
        fmt.Println("元素 1: ", myarr[0])
        fmt.Println("元素 2: ", myarr[1])
        fmt.Println("元素 3: ", myarr[2])
    }
    ```

  - **输出：**

  - 数组的元素: 元素 1: GFG 元素 2: www.cainiaojc.com 元素 3: cainiaojc

- **使用简写声明：**在Go语言中，数组也可以使用简写声明进行声明。它比上面的声明更灵活。

  **语法：**

  ```
  array_name:= [length]Type{item1, item2, item3,...itemN}[object Object]
  ```

  示例

  ```
  //使用简写声明的数组
  //使用for循环访问数组
  package main
  
  import "fmt"
  
  func main() {
  
      //数组的简写声明
      arr := [4]string{"cainiaojc", "gfg", "cainiaojcs1231", "www.cainiaojc.com"}
  
      //访问的元素,使用for循环的数组
      fmt.Println("数组的元素:")
  
      for i := 0; i < 3; i++ {
          fmt.Println(arr[i])
      }
  
  }
  ```

  **输出：**

  ```
  数组的元素:
  cainiaojc
  gfg
  cainiaojc$11231
  ```

- 多维数组

- 我们已经知道数组是一维的，但是允许创建多维数组。多维数组是相同类型数组的数组。在Go语言中，您可以使用以下语法创建多维数组:

- Array_name[Length1][Length2]..[LengthN]Type

- 您可以*使用Var关键字*或*使用简写声明*来创建多维数组，如下例所示。

- **注意：**在多维数组中，如果用户未使用某个值初始化单元格，则编译器将自动将其初始化为零。Golang中没有未初始化的概念。

- 示例

  ```
  package main
  
  import "fmt"
  
  func main() {
  
      //创建和初始化
      //二维数组
      //使用简写声明
      //这里需要用（，）逗号
      arr := [3][3]string{{"C#", "C", "Python"},
          {"Java", "Scala", "Perl"},
          {"C++", "Go", "HTML"}}
  
      //访问的值
      //数组使用for循环
      fmt.Println("数组的元素 1")
      for x := 0; x < 3; x++ {
          for y := 0; y < 3; y++ {
              fmt.Println(arr[x][y])
          }
      }
  
      //创建二维数组
      //使用var关键字的数组
      //并初始化一个
      //使用索引的维数组
      var arr1 [2][2]int
      arr1[0][0] = 100
      arr1[0][1] = 200
      arr1[1][0] = 300
      arr1[1][1] = 400
  
      //访问数组的值
      fmt.Println("数组的元素 2")
      for p := 0; p < 2; p++ {
          for q := 0; q < 2; q++ {
              fmt.Println(arr1[p][q])
  
          }
      }
  }
  ```

- **输出：**

- 数组的元素 1 C# C Python Java Scala Perl C++ Go HTML 数组的元素 2 100 200 300 400

- 关于数组的注意事项

- 在数组中，如果未显式初始化数组，则**此数组**的**默认值为0**。

  示例

  ```
  package main 
    
  import "fmt"
    
  func main() { 
    
  //创建一个int类型的数组,存储两个元素
  //在这里，我们不初始化数组，所以数组的值为零
  var myarr[2]int 
  fmt.Println("数组元素 :", myarr) 
    
  }
  ```

  **输出：**

  ```
  数组元素 : [0 0]
  ```

- 在数组中，您可以**使用\*len()方法\*****获取**数组**的长度，**如下所示：

  示例

  ```
  package main
  
  import "fmt"
  
  func main() {
  
      //创建数组
      //使用简写声明
      arr1 := [3]int{9, 7, 6}
      arr2 := [...]int{9, 7, 6, 4, 5, 3, 2, 4}
      arr3 := [3]int{9, 3, 5}
  
      // 使用len方法计算数组大小
      fmt.Println("数组1的长度是:", len(arr1))
      fmt.Println("数组2的长度是:", len(arr2))
      fmt.Println("数组3的长度是:", len(arr3))
  }
  ```

  **输出：**

  ```
  数组1的长度是: 3
  数组2的长度是: 8
  数组3的长度是: 3
  ```

- 在数组中，***如果省略号“ ...”\***在长度位置处可见，则数组的长度由初始化的元素确定。如下例所示：

  示例

  ```
  //数组中省略号的使用方法
  package main
  
  import "fmt"
  
  func main() {
  
      //创建大小已确定的数组
      //根据其中元素的数量
      //使用省略号
      myarray := [...]string{"GFG", "gfg", "cainiaojcs", "www.cainiaojc.com", "cainiaojc"}
  
      fmt.Println("数组元素: ", myarray)
  
      //数组的长度
      //由...决定
      //使用len()方法
      fmt.Println("数组的长度为:", len(myarray))
  }
  ```

  **输出：**

  ```
  数组元素:  [GFG gfg cainiaojcs www.cainiaojc.com cainiaojc]
  数组的长度为: 5
  ```

- 在数组中，**允许您**在array **的元素范围内进行迭代**。如下例所示：

  示例

  ```
  //如何迭代数组
  package main
  
  import "fmt"
  
  func main() {
  
      //创建一个数组，其大小
      //用省略号表示
      myarray := [...]int{29, 79, 49, 39, 20, 49, 48, 49}
  
      //使用for循环迭代数组
      for x := 0; x < len(myarray); x++ {
          fmt.Printf("%d\n", myarray[x])
      }
  }
  ```

  **输出：**

  ```
  29
  79
  49
  39
  20
  49
  48
  49
  ```

- 在Go语言中，**数组的值类型不是引用类型**。因此，当将数组分配给新变量时，在新变量中所做的更改不会影响原始数组。如下例所示：

  示例

  ```
  package main
  
  import "fmt"
  
  func main() {
  
      //创建一个数组，其大小
      //用省略号表示
      my_array := [...]int{100, 200, 300, 400, 500}
      fmt.Println("原始数组(改变前):", my_array)
  
      //创建一个新变量
      //并使用my_array进行初始化
      new_array := my_array
  
      fmt.Println("新数组(改变前):", new_array)
  
      //将索引0处的值更改为500
      new_array[0] = 500
  
      fmt.Println("新数组(改变后):", new_array)
  
      fmt.Println("原始数组(改变后):", my_array)
  }
  ```

  **输出：**

  ```
  原始数组(改变前): [100 200 300 400 500]
  新数组(改变前): [100 200 300 400 500]
  新数组(改变后): [500 200 300 400 500]
  原始数组(改变后): [100 200 300 400 500]
  ```

- 在数组中，如果数组的元素类型是可比较的，则数组类型也是可比较的。因此，**我们可以使用==运算符直接比较两个数组**。如下例所示：

  示例

  ```
  //如何比较两个数组
  package main
  
  import "fmt"
  
  func main() {
  
      arr1 := [3]int{9, 7, 6}
      arr2 := [...]int{9, 7, 6}
      arr3 := [3]int{9, 5, 3}
  
      //使用==运算符比较数组
      fmt.Println(arr1 == arr2)
      fmt.Println(arr2 == arr3)
      fmt.Println(arr1 == arr3)
  
      //这将给出和错误，因为
      // arr1和arr4的类型不匹配
      /*
         arr4:= [4]int{9,7,6}
         fmt.Println(arr1==arr4)
      */
  }
  ```

  **输出：**

  ```
  true
  false
  false
  ```

###### 数组复制

Golang编程语言中的[数组](https://www.cainiaojc.com/golang/go-arrays.html)与其他编程语言非常相似。在程序中，有时我们需要存储一组相同类型的数据，例如学生评分列表。这种类型的集合使用数组存储在程序中。数组是固定长度的序列，用于将同类元素存储在内存中。Golang没有提供将一个数组复制到另一个数组的特定内置函数。但是我们可以通过简单地通过值或引用将数组分配给新变量来创建数组的副本。

如果我们通过值创建数组的副本并在原始数组的值中进行了一些更改，则它不会反映在该数组的副本中。 而且，如果我们通过引用创建数组的副本，并对原始数组的值进行了一些更改，那么它将反映在该数组的副本中。 如以下示例所示：

**语法：**

```
//按值创建数组的副本
arr := arr1

//通过引用创建数组的副本
arr := &arr1
```

o编程语言中的数组与其他编程语言非常相似。在程序中，有时我们需要存储一组相同类型的数据，例如学生评分列表。这种类型的集合使用数组存储在程序中。数组是固定长度的序列，用于将同类元素存储在内存中。
在Go语言中，允许您在函数中传递数组作为参数。为了在函数中将数组作为参数传递，您必须首先使用以下语法创建形式参数：

**语法：**

```
//对于指定大小的数组
func function_name(variable_name [size]type){
// Code
}

//对于无大小的数组
func function_name(variable_name []type){
// Code
}
```

使用这些语法，您可以将1或多维数组传递给该函数。

```go
//数组作为函数的参数
package main

import "fmt"

//此函数接受
//将数组作为参数
func myfun(a [6]int, size int) int {
    var k, val, r int

    for k = 0; k < size; k++ {
        val += a[k]
    }

    r = val / size
    return r
}

func main() {

    //创建和初始化数组
    var arr = [6]int{67, 59, 29, 35, 4, 34}
    var res int

    //将数组作为参数传递
    res = myfun(arr, 6)
    fmt.Printf("最终结果是: %d ", res)
}
```



##### 结构体

Go 语言中数组可以存储同一类型的数据，但在结构体中我们可以为不同项定义不同的数据类型。结构体是由一系列具有相同类型或不同类型的数据构成的数据集合。

#### 引用类型

##### 指针

###### 指针的声明和初始化

在开始之前，我们将在指针中使用两个重要的运算符，即

***运算符** 也称为解引用运算符，用于声明指针变量并访问存储在地址中的值。

**＆运算符** 称为地址运算符，用于返回变量的地址或将变量的地址访问指针。

***声明一个指针\***：

```
var pointer_name *Data_Type
```

*示例：*下面是字符串类型的指针，该指针只能存储*字符串*变量的内存地址。

```
var s *string
```

***指针的初始化：***为此，您需要使用地址运算符使用另一个变量的内存地址初始化指针，如以下示例所示：

```
//正常的变量声明
var a = 45

//用初始化指针s
//变量a的内存地址
var s *int = &a
```

**重要事项：**

- 指针的默认值或零值始终为nil。 或者，您可以说未初始化的指针将始终具有nil值。
- 指针的声明和初始化可以在一行中完成。
- 如果要同时指定数据类型和指针声明，则指针将能够处理该指定数据类型变量的内存地址。例如，如果您使用字符串类型的指针，那么将提供给指针的变量的地址将仅是字符串数据类型变量，而不是其他任何类型。
- 为了克服上述问题，可以使用[var关键字](https://www.cainiaojc.com/golang/go-var-keyword.html)的类型推断概念。声明期间无需指定的数据类型。指针变量的类型也可以像普通变量一样由编译器确定。在这里，我们将不使用*运算符。当我们使用另一个变量的地址初始化变量时，它将由编译器内部确定。
- 您也可以使用*简写（：=）*语法来声明和初始化指针变量。如果我们使用*＆（address）*运算符将变量的地址传递给它，则编译器将在内部确定该变量为指针变量。

###### 指针解引用

众所周知，*运算符也称为解引用运算符。它不仅用于声明指针变量，而且还用于访问指针所指向的变量中存储的值，通常将其称为**间接或取消引用**。**运算符也称为地址处的值*。让我们举个实例来更好地理解这个概念：

示例

```
// Golang程序举例说明
//解除指针引用的概念
package main

import "fmt"

func main() {

    //使用var关键字
    //我们没有定义
    //任何带变量的类型
    var y = 458

    //使用指针变量
    // var关键字，不指定
    //类型
    var p = &y

    fmt.Println("存储在y中的值 = ", y)
    fmt.Println("y的地址= ", &y)
    fmt.Println("存储在指针变量p中的值 = ", p)

    //这是取消引用指针
    //在指针之前使用*运算符
    //变量以访问存储的值
    //指向它所指向的变量
    fmt.Println("存储在y中的值(*p) = ", *p)

}
```

###### 指针比较

在Go语言中，允许比较两个指针。两个指针值只有在它们指向内存中的相同值或者它们是nil时才相等。您可以在Go语言提供的==和!=运算符的帮助下对指针进行比较：

**1. == 运算符：**如果两个指针都指向同一个变量，则此运算符返回true。或如果两个指针都指向不同的变量，则返回false。

**语法：**

```
pointer_1 == pointer_2
```

**2.！= 运算符：**如果两个指针都指向同一个变量，则此运算符返回false。或如果两个指针都指向不同的变量，则返回true。

**语法：**

```
pointer_1 != pointer_2
```

###### 指针容量

在指针中，可以使用**cap()**函数来查找指针的容量。这个函数是一个内置函数，返回指向数组的指针的容量。在Go语言中，容量定义了存储在指向数组的指针中的最大元素数。此函数在内置中定义。

**语法：**

```
func cap(l Type) int
```

在这里，**l**的类型是一个指针。

###### 指针长度

在指针中，您可以借助**len()**函数找到指针的长度。此函数是内置函数，即使指定的指针为nil，也会将指向数组的指针中存在的元素总数返回。此函数在内置中定义。

**语法：**

```
func len(l Type) int
```

在这里，**l**的类型是一个指针。

###### 指针作为参数或返回值

```
package main

import "fmt"

// int类型指针作为参数
func ptf(a *int) {
    *a = 748
}

func main() {

    var x = 100

    fmt.Printf("函数调用前x的值为: %d\n", x)

    //通过调用函数
    //传递地址
    //变量x
    ptf(&x)

    fmt.Printf("函数调用后x的值为: %d\n", x)

}
```

```
//Go 函数返回指针
package main

import "fmt"

func main() {

    //调用函数
    n := rpf()

    //显示值
    fmt.Println("n的值: ", *n)

}

//定义具有整数的函数
//指针作为返回类型
func rpf() *int {

    //局部变量
    //函数内部使用简短运算符声明
    lv := 100

    // 返回lv的地址
    return &lv
}
```



##### 切片

在Go语言中，切片比[数组](https://www.cainiaojc.com/golang/go-arrays.html)更强大，灵活，方便，并且是轻量级的数据结构。slice是一个可变长度序列，用于存储相同类型的元素，不允许在同一slice中存储不同类型的元素。就像具有索引值和长度的数组一样，但是切片的大小可以调整，切片不像数组那样处于固定大小。在内部，切片和数组相互连接，切片是对基础数组的引用。允许在切片中存储重复元素。***切片中的第一个索引位置始终为0，而最后一个索引位置将为（切片的长度– 1）\***。

###### 切片声明

切片的声明就像数组一样，但是不包含切片的大小。因此它可以根据需要增长或缩小。

**语法：**

```
[]T

或

[]T{}

或

[]T{value1, value2, value3, ...value n}
```

在此，T是元素的类型。例如：

```
var my_slice[]int
```

切片包含三个组件：

- **指针：**指针用于指向可通过切片访问的数组的第一个元素。在这里，指向的元素不必是数组的第一个元素。
- **长度：**长度是数组中存在的元素总数。
- **容量：**容量表示可以扩展的最大大小。

在Go语言中，可以使用以下方式创建和初始化切片：

- **使用切片字面量：**您可以**使用切片字面量**创建切片。切片字面量的创建就像数组字面量一样，但是有一个区别，即不允许您在方括号[]中指定切片的大小。如下例所示，该表达式的右侧是切片字面量。

  ```
  var my_slice_1 = []string{"cainiaojcs", "for", "cainiaojcs"}
  ```

  **注意：**切记，当您使用字符串文字创建切片时，它首先创建一个数组，然后返回对其的切片引用。

- **使用数组：**我们已经知道***切片是数组的引用，***因此您可以根据给定的数组创建切片。要从给定数组创建切片，首先需要指定下限和上限，这意味着slice可以从下限到上限开始获取数组中的元素。它不包括上面从上限开始的元素。如下例所示：

  **语法：**

  ```
  array_name[low:high]
  ```

  此语法将返回一个新切片。

  **注意：**下限的默认值为0，上限的默认值为给定数组中存在的元素总数。

- **使用已经存在的切片：**也可以从给定的切片创建切片。要从给定切片创建切片，首先需要指定下限和上限，这意味着slice可以从给定切片中从下限到上限开始获取元素。它不包括上面从上限开始的元素。如下例所示：

  **语法：**

  ```
  slice_name[low:high]
  ```

  此语法将返回一个新切片。

  **注意：**下限的默认值为0，上限的默认值为给定切片中存在的元素总数。

- **使用make()函数：**您还可以使用go库提供的*make()函数*创建切片。此函数采用三个参数，即类型，长度和容量。在此，容量值是可选的。它为底层数组分配的大小等于给定的容量，并返回一个切片，该切片引用底层数组。通常，make()函数用于创建一个空切片。在这里，空切片是包含空数组引用的那些切片。

  **语法：**

  ```
  func make([]T, len, cap) []T
  ```

###### 遍历数组

- **使用for循环：**这是迭代切片的最简单方法
- **在for循环中使用范围：**允许使用for循环中的范围对切片进行迭代。在for循环中使用range，可以获得索引和元素值
- **在for循环中使用空白标识符：在for循环**范围内，如果您不想获取元素的索引值，则可以使用空格（_）代替索引变量

###### 复制

[切片](https://www.cainiaojc.com/golang/go-slices.html)是相似类型的存储元素，则不允许不同类型的元素的存储在同一条带的可变长度序列。在切片中，您可以使用Go语言提供的**copy()函数**将一个切片复制到另一个切片中。换句话说，通过copy()函数可以将一个切片的元素复制到另一切片中。

**语法：**

```
func copy(dst, src []Type) int
```

此处，*dst*表示目标切片，而*src*表示源切片。它将返回要复制的元素数量，该数量应**为\*len（dst）\*或\*len（src）\***的**最小值**。

###### 切片比较

在Go语言中，切片比数组更强大，灵活，方便，并且是轻量级的数据结构。切片是可变长度的序列，用于存储相同类型的元素，不允许在同一切片中存储不同类型的元素。在Go切片中，可以使用**Compare()**函数将两个字节类型的切片彼此进行**比较**。此函数返回一个整数值，该整数值表示这些切片相等或不相等，并且这些值是：

- 如果结果为0，则slice_1 == slice_2。
- 如果结果为-1，则slice_1 <slice_2。
- 如果结果为+1，则slice_1> slice_2。

该函数在bytes包下定义，因此，您必须在程序中导入bytes包才能访问Compare函数。

**语法：**

```
func Compare(slice_1, slice_2 []byte) int
```

###### 切片排序

在Go语言中，[切片](https://www.cainiaojc.com/golang/go-slices.html)比[数组](https://www.cainiaojc.com/golang/go-arrays.html)更强大，灵活，方便，并且是轻量级的数据结构。切片是可变长度的序列，用于存储相似类型的元素，不允许在同一切片中存储不同类型的元素。
Go语言使您可以根据切片的类型对切片的元素进行排序。因此，使用以下函数对int类型切片进行排序。这些函数在sort包下定义，因此，您必须在程序中导入sort包才能访问这些函数：

**1.**整数**：**此函数仅用于对整数切片进行排序，并按升序对切片中的元素进行排序。

**语法：**

```
func Ints(slc []int)
```

在这里，*slc*表示一个整数。让我们借助示例来讨论这个概念：

示例

```
//对整数进行排序
package main 
   
import ( 
    "fmt"
    "sort"
) 
   
// Main function 
func main() { 
       
    //使用简写声明，创建和初始化切片
    scl1 := []int{400, 600, 100, 300, 500, 200, 900} 
    scl2 := []int{-23, 567, -34, 67, 0, 12, -5} 
       
    //显示切片
    fmt.Println("Slices(Before):") 
    fmt.Println("Slice 1: ", scl1) 
    fmt.Println("Slice 2: ", scl2) 
       
    //对整数切片进行排序

//使用Ints函数
    sort.Ints (scl1) 
    sort.Ints (scl2) 
       
    //显示结果
    fmt.Println("\nSlices(After):") 
    fmt.Println("Slice 1 : ", scl1) 
    fmt.Println("Slice 2 : ",scl2) 
}
```

**输出：**

```
Slices(Before):
Slice 1:  [400 600 100 300 500 200 900]
Slice 2:  [-23 567 -34 67 0 12 -5]

Slices(After):
Slice 1 :  [100 200 300 400 500 600 900]
Slice 2 :  [-34 -23 -5 0 12 67 567]
```

**2. IntsAreSorted：**此函数用于检查给定的int切片是否为排序形式（按升序排列）。如果切片为排序形式，则此方法返回true；否则，如果切片未为排序形式，则返回false。

**语法：**

```
func IntsAreSorted(scl []int) bool
```

此处，*scl*表示*ints的一部分*。让我们借助示例来讨论这个概念：

示例

```
//Go程序说明如何检查
//给定的int片是否已排序
package main

import (
    "fmt"
    "sort"
)

func main() {

    //创建和初始化切片

    //使用简写声明
    scl1 := []int{100, 200, 300, 400, 500, 600, 700}
    scl2 := []int{-23, 567, -34, 67, 0, 12, -5}

    //显示切片
    fmt.Println("Slices:")
    fmt.Println("切片1: ", scl1)
    fmt.Println("切片2: ", scl2)

    //检查切片是否为排序形式

    //使用IntsAreSorted函数
    res1 := sort.IntsAreSorted(scl1)
    res2 := sort.IntsAreSorted(scl2)

    //显示结果
    fmt.Println("\nResult:")
    fmt.Println("切片1是否已排序?: ", res1)
    fmt.Println("切片2是否已排序?: ", res2)
}
```

**输出：**

```
Slices:
切片1:  [100 200 300 400 500 600 700]
切片2:  [-23 567 -34 67 0 12 -5]

Result:
切片1是否已排序?:  true
切片2是否已排序?:  false
```

###### 切片分割

在Go字节片段中，允许您使用**Split()**函数分割给定的切片。此函数将字节的切片拆分为由给定分隔符分隔的所有子切片，并返回包含所有这些子切片的切片。它在bytes包下定义，因此，您必须在程序中导入bytes包才能访问Split函数。

**语法：**

```
func Split(o_slice, sep []byte) [][]byte
```

在这里，*o_slice*是字节片，*sep*是分隔符。如果*sep*为空，则它将在每个UTF-8序列之后拆分。



##### 字典

Map 是一种无序的键值对的集合。Map 最重要的一点是通过 key 来快速检索数据，key 类似于索引，指向数据的值。Map 是一种集合，所以我们可以像迭代数组和切片那样迭代它。不过，Map 是无序的，遍历 Map 时返回的键值对的顺序是不确定的。在获取 Map 的值时，如果键不存在，返回该类型的零值，例如 int 类型的零值是 0，string 类型的零值是 ""。Map 是引用类型，如果将一个 Map 传递给一个函数或赋值给另一个变量，它们都指向同一个底层数据结构，因此对 Map 的修改会影响到所有引用它的变量。

可以使用内建函数 make 或使用 map 关键字来定义 Map:

```
/* 使用 make 函数 */
map_variable := make(map[KeyType]ValueType, initialCapacity)
```

其中 KeyType 是键的类型，ValueType 是值的类型，initialCapacity 是可选的参数，用于指定 Map 的初始容量。Map 的容量是指 Map 中可以保存的键值对的数量，当 Map 中的键值对数量达到容量时，Map 会自动扩容。如果不指定 initialCapacity，Go 语言会根据实际情况选择一个合适的值。

也可以使用字面量创建 Map：

```
// 使用字面量创建 Map
m := map[string]int{
    "apple": 1,
    "banana": 2,
    "orange": 3,
}
```

获取元素：

```
// 获取键值对
v1 := m["apple"]
v2, ok := m["pear"]  // 如果键不存在，ok 的值为 false，v2 的值为该类型的零值
```

修改元素：

```
// 修改键值对
m["apple"] = 5
```

获取 Map 的长度：

```
// 获取 Map 的长度
len := len(m)
```

遍历 Map：

```
// 遍历 Map
for k, v := range m {
    fmt.Printf("key=%s, value=%d\n", k, v)
}
```

删除元素：

```
// 删除键值对
delete(m, "banana")
```

**delete() 函数**：delete() 函数用于删除集合的元素, 参数为 map 和其对应的 key。

##### 接口

接口（interface）是 Go 语言中的一种类型，用于定义行为的集合，它通过描述类型必须实现的方法，规定了类型的行为契约。

##### 管道

提前说明，管道的笔记部分可能需要后边知识的支持。

Channel是Go中的一个核心类型，你可以把它看成一个管道，通过它并发核心单元就可以发送或者接收数据进行通讯(communication)。它的操作符是箭头 **<-** 。

```
ch <- v    // 发送值v到Channel ch中
v := <-ch  // 从Channel ch中接收数据，并将数据赋值给v
```

(箭头的指向就是数据的流向)

就像 map 和 slice 数据类型一样, channel必须先创建再使用:

```
ch := make(chan int)
```

Channel类型的定义格式如下：

```
ChannelType = ( "chan" | "chan" "<-" | "<-" "chan" ) ElementType .
```

它包括三种类型的定义。可选的`<-`代表channel的方向。如果没有指定方向，那么Channel就是双向的，既可以接收数据，也可以发送数据。

```
chan T          // 可以接收和发送类型为 T 的数据
chan<- float64  // 只可以用来发送 float64 类型的数据
<-chan int      // 只可以用来接收 int 类型的数据
```

`<-`总是优先和最左边的类型结合。

```
chan<- chan int    // 等价 chan<- (chan int)
chan<- <-chan int  // 等价 chan<- (<-chan int)
<-chan <-chan int  // 等价 <-chan (<-chan int)
chan (<-chan int)
```

使用`make`初始化Channel,并且可以设置容量:

```
make(chan int, 100)
```

容量(capacity)代表Channel容纳的最多的元素的数量，代表Channel的缓存的大小。
如果没有设置容量，或者容量设置为0, 说明Channel没有缓存，只有sender和receiver都准备好了后它们的通讯(communication)才会发生(Blocking)。如果设置了缓存，就有可能不发生阻塞， 只有buffer满了后 send才会阻塞， 而只有缓存空了后receive才会阻塞。一个nil channel不会通信。

可以通过内建的`close`方法可以关闭Channel。

你可以在多个goroutine从/往 一个channel 中 receive/send 数据, 不必考虑额外的同步措施。

Channel可以作为一个先入先出(FIFO)的队列，接收的数据和发送的数据的顺序是一致的。

channel的 receive支持 *multi-valued assignment*，如

```
v, ok := <-ch
```

它可以用来检查Channel是否已经被关闭了。

1. **send语句**
   send语句用来往Channel中发送数据， 如`ch <- 3`。
   它的定义如下:

```
SendStmt = Channel "<-" Expression .
Channel  = Expression .
```

在通讯(communication)开始前channel和expression必选先求值出来(evaluated)，比如下面的(3+4)先计算出7然后再发送给channel。

```
c := make(chan int)
defer close(c)
go func() { c <- 3 + 4 }()
i := <-c
fmt.Println(i)
```

send被执行前(proceed)通讯(communication)一直被阻塞着。如前所言，无缓存的channel只有在receiver准备好后send才被执行。如果有缓存，并且缓存未满，则send会被执行。

往一个已经被close的channel中继续发送数据会导致**run-time panic**。

往nil channel中发送数据会一致被阻塞着。

1. receive 操作符
   `<-ch`用来从channel ch中接收数据，这个表达式会一直被block,直到有数据可以接收。

从一个nil channel中接收数据会一直被block。

从一个被close的channel中接收数据不会被阻塞，而是立即返回，接收完已发送的数据后会返回元素类型的零值(zero value)。

如前所述，你可以使用一个额外的返回参数来检查channel是否关闭。

```
x, ok := <-ch
x, ok = <-ch
var x, ok = <-ch
```

如果OK 是false，表明接收的x是产生的零值，这个channel被关闭了或者为空。

内建的close方法可以用来关闭channel。

总结一下channel关闭后sender的receiver操作。
如果channel c已经被关闭,继续往它发送数据会导致`panic: send on closed channel`:

```
import "time"
func main() {
    go func() {
        time.Sleep(time.Hour)
    }()
    c := make(chan int, 10)
    c <- 1
    c <- 2
    close(c)
    c <- 3
}
```

但是从这个关闭的channel中不但可以读取出已发送的数据，还可以不断的读取零值:

```
c := make(chan int, 10)
c <- 1
c <- 2
close(c)
fmt.Println(<-c) //1
fmt.Println(<-c) //2
fmt.Println(<-c) //0
fmt.Println(<-c) //0
```

但是如果通过`range`读取，channel关闭后for循环会跳出：

```
c := make(chan int, 10)
c <- 1
c <- 2
close(c)
for i := range c {
    fmt.Println(i)
}
```

通过`i, ok := <-c`可以查看Channel的状态，判断值是零值还是正常读取的值。

```
c := make(chan int, 10)
close(c)
i, ok := <-c
fmt.Printf("%d, %t", i, ok) //0, false
```

###### 阻塞

默认情况下，发送和接收会一直阻塞着，直到另一方准备好。这种方式可以用来在gororutine中进行同步，而不必使用显示的锁或者条件变量。

如官方的例子中`x, y := <-c, <-c`这句会一直等待计算结果发送到channel中。

```
import "fmt"
func sum(s []int, c chan int) {
    sum := 0
    for _, v := range s {
        sum += v
    }
    c <- sum // send sum to c
}
func main() {
    s := []int{7, 2, 8, -9, 4, 0}
    c := make(chan int)
    go sum(s[:len(s)/2], c)
    go sum(s[len(s)/2:], c)
    x, y := <-c, <-c // receive from c
    fmt.Println(x, y, x+y)
}
```

###### 缓存管道

make的第二个参数指定缓存的大小：`ch := make(chan int, 100)`。

通过缓存的使用，可以尽量避免阻塞，提供应用的性能。

###### 可迭代

`for …… range`语句可以处理Channel。

```
func main() {
    go func() {
        time.Sleep(1 * time.Hour)
    }()
    c := make(chan int)
    go func() {
        for i := 0; i < 10; i = i + 1 {
            c <- i
        }
        close(c)
    }()
    for i := range c {
        fmt.Println(i)
    }
    fmt.Println("Finished")
}
```

`range c`产生的迭代值为Channel中发送的值，它会一直迭代直到channel被关闭。上面的例子中如果把`close(c)`注释掉，程序会一直阻塞在`for …… range`那一行。

###### 多路选择

`select`语句选择一组可能的send操作和receive操作去处理。它类似`switch`,但是只是用来处理通讯(communication)操作。
它的`case`可以是send语句，也可以是receive语句，亦或者`default`。

`receive`语句可以将值赋值给一个或者两个变量。它必须是一个receive操作。

最多允许有一个`default case`,它可以放在case列表的任何位置，尽管我们大部分会将它放在最后。

```
import "fmt"
func fibonacci(c, quit chan int) {
    x, y := 0, 1
    for {
        select {
        case c <- x:
            x, y = y, x+y
        case <-quit:
            fmt.Println("quit")
            return
        }
    }
}
func main() {
    c := make(chan int)
    quit := make(chan int)
    go func() {
        for i := 0; i < 10; i++ {
            fmt.Println(<-c)
        }
        quit <- 0
    }()
    fibonacci(c, quit)
}
```

如果有同时多个case去处理,比如同时有多个channel可以接收数据，那么Go会伪随机的选择一个case处理(pseudo-random)。如果没有case需要处理，则会选择`default`去处理，如果`default case`存在的情况下。如果没有`default case`，则`select`语句会阻塞，直到某个case需要处理。

需要注意的是，nil channel上的操作会一直被阻塞，如果没有default case,只有nil channel的select会一直被阻塞。

`select`语句和`switch`语句一样，它不是循环，它只会选择一个case来处理，如果想一直处理channel，你可以在外面加一个无限的for循环：

```
for {
    select {
    case c <- x:
        x, y = y, x+y
    case <-quit:
        fmt.Println("quit")
        return
    }
}
```

`select`有很重要的一个应用就是超时处理。 因为上面我们提到，如果没有case需要处理，select语句就会一直阻塞着。这时候我们可能就需要一个超时操作，用来处理超时的情况。
下面这个例子我们会在2秒后往channel c1中发送一个数据，但是`select`设置为1秒超时,因此我们会打印出`timeout 1`,而不是`result 1`。

```
import "time"
import "fmt"
func main() {
    c1 := make(chan string, 1)
    go func() {
        time.Sleep(time.Second * 2)
        c1 <- "result 1"
    }()
    select {
    case res := <-c1:
        fmt.Println(res)
    case <-time.After(time.Second * 1):
        fmt.Println("timeout 1")
    }
}
```

其实它利用的是`time.After`方法，它返回一个类型为`<-chan Time`的单向的channel，在指定的时间发送一个当前时间给返回的channel中。

###### 同步

channel可以用在goroutine之间的同步。
下面的例子中main goroutine通过done channel等待worker完成任务。 worker做完任务后只需往channel发送一个数据就可以通知main goroutine任务完成。

```
import (
    "fmt"
    "time"
)
func worker(done chan bool) {
    time.Sleep(time.Second)
    // 通知任务已完成
    done <- true
}
func main() {
    done := make(chan bool, 1)
    go worker(done)
    // 等待任务完成
    <-done
}
```

###### Timer和Ticker

我们看一下关于时间的两个Channel。
timer是一个定时器，代表未来的一个单一事件，你可以告诉timer你要等待多长时间，它提供一个Channel，在将来的那个时间那个Channel提供了一个时间值。下面的例子中第二行会阻塞2秒钟左右的时间，直到时间到了才会继续执行。

```
timer1 := time.NewTimer(time.Second * 2)
<-timer1.C
fmt.Println("Timer 1 expired")
```

当然如果你只是想单纯的等待的话，可以使用`time.Sleep`来实现。

你还可以使用`timer.Stop`来停止计时器。

```
timer2 := time.NewTimer(time.Second)
go func() {
    <-timer2.C
    fmt.Println("Timer 2 expired")
}()
stop2 := timer2.Stop()
if stop2 {
    fmt.Println("Timer 2 stopped")
}
```

`ticker`是一个定时触发的计时器，它会以一个间隔(interval)往Channel发送一个事件(当前时间)，而Channel的接收者可以以固定的时间间隔从Channel中读取事件。下面的例子中ticker每500毫秒触发一次，你可以观察输出的时间。

```
ticker := time.NewTicker(time.Millisecond * 500)
go func() {
    for t := range ticker.C {
        fmt.Println("Tick at", t)
    }
}()
```

类似timer, ticker也可以通过`Stop`方法来停止。一旦它停止，接收者不再会从channel中接收数据了。

#### 别名类型

##### Rune

`rune` 类型是 Go 语言的一种特殊数字类型。在 `builtin/builtin.go` 文件中，它的定义：`type rune = int32`；官方对它的解释是：`rune` 是类型 `int32` 的别名，在所有方面都等价于它，用来区分字符值跟整数值。使用单引号定义 ，返回采用 UTF-8 编码的 Unicode 码点。Go 语言通过 `rune` 处理中文，支持国际化多语言。

众所周知，Go 语言有两种类型声明方式：一种叫类型定义声明，另一种叫类型别名声明。其中，别名的使用在大型项目重构中作用最为明显，它能解决代码升级或迁移过程中可能存在的类型兼容性问题。而`rune` 跟 `byte` 是 Go 语言中仅有的两个类型别名，专门用来处理字符。当然，我们也可以通过 `type` 关键字加等号的方式声明更多的类型别名。

我们知道，字符串由字符组成，字符的底层由字节组成，而一个字符串在底层的表示是一个字节序列。在 Go 语言中，字符可以被分成两种类型处理：对占 1 个字节的英文类字符，可以使用 `byte`（或者 `unit8` ）；对占 1 ~ 4 个字节的其他字符，可以使用 `rune`（或者 `int32` ），如中文、特殊符号等。

下面，我们通过示例应用来具体感受一下。

- 统计带中文字符串长度

```go
// 使用内置函数 len() 统计字符串长度
fmt.Println(len("Go语言编程"))  // 输出：14  
```

前面说到，字符串在底层的表示是一个字节序列。其中，英文字符占用 1 字节，中文字符占用 3 字节，所以得到的长度 14 显然是底层占用字节长度，而不是字符串长度，这时，便需要用到 `rune` 类型。

```go
// 转换成 rune 数组后统计字符串长度
fmt.Println(len([]rune("Go语言编程")))  // 输出：6
```

这回对了。很容易，我们解锁了 `rune` 类型的第一个功能，即统计字符串长度。

- 截取带中文字符串

如果想要截取字符串中 ”Go语言“ 这一段，考虑到底层是一个字节序列，或者说是一个数组，通常情况下，我们会这样：

```go
s := "Go语言编程"
// 8=2*1+2*3
fmt.Println(s[0:8])  // 输出：Go语言
```

结果符合预期。但是，按照字节的方式进行截取，必须预先计算出需要截取字符串的字节数，如果字节数计算错误，就会显示乱码，比如这样：

```go
s := "Go语言编程"
fmt.Println(s[0:7]) // 输出：Go语�
```

此外，如果截取的字符串较长，那通过字节的方式进行截取显然不是一个高效准确的办法。那有没有不用计算字节数，简单又不会出现乱码的方法呢？不妨试试这样：

```go
s := "Go语言编程"
// 转成 rune 数组，需要几个字符，取几个字符
fmt.Println(string([]rune(s)[:4])) // 输出：Go语言    
```

到这里，我们解锁了 `rune` 类型的第二个功能，即截取字符串。

通过上面的示例，我们发现似乎在处理带中文的字符串时，都需要用到 `rune` 类型，这究竟是为什么呢？除了使用 `rune` 类型，还有其他方法吗？

在深入思考之前，我们需要首先弄清楚 `string` 、`byte`、`rune` 三者间的关系。

字符串在底层的表示是由单个字节组成的一个不可修改的字节序列，字节使用 UTF-8[1] 编码标识 Unicode[2] 文本。Unicode 文本意味着 `.go` 文件内可以包含世界上的任意语言或字符，该文件在任意系统上打开都不会乱码。UTF-8 是 Unicode 的一种实现方式，是一种针对 Unicode 可变长度的字符编码，它定义了字符串具体以何种方式存储在内存中。UFT-8 使用 1 ~ 4 为每个字符编码。

Go 语言把字符分 `byte` 和 `rune` 两种类型处理。`byte` 是类型 `unit8` 的别名，用于存放占 1 字节的 ASCII 字符，如英文字符，返回的是字符原始字节。`rune` 是类型 `int32` 的别名，用于存放多字节字符，如占 3 字节的中文字符，返回的是字符 Unicode 码点值。如下图所示：

```go
s := "Go语言编程"
// byte
fmt.Println([]byte(s)) // 输出：[71 111 232 175 173 232 168 128 231 188 150 231 168 139]
// rune
fmt.Println([]rune(s)) // 输出：[71 111 35821 35328 32534 31243]
```

它们的对应关系如下图：![图片](https://mmbiz.qpic.cn/mmbiz_png/rJDC5vuwJCNoUJI5HH4uiaAYjK4vIgnu7W7h9Y0LezHISIzDTxDCE6FVVxzUb6gefUYo2X5mraBO4p9uiaK0QRuA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)了解了这些，我们再回过来看看，刚才的问题是不是清楚明白很多？接下来，让我们再来看看源码中是如何处理的，以 utf8.RuneCountInString()[3] 函数为例。  

 

示例：

```cpp
// 统计字符串长度
fmt.Println(utf8.RuneCountInString("Go语言编程")) // 输出：6
```

源码：

```go
// RuneCountInString is like RuneCount but its input is a string.
func RuneCountInString(s string) (n int) {
 // 调用 len() 函数得到字节数
 ns := len(s)
 for i := 0; i < ns; n++ {
  c := s[i]
  // 如码点值小于 128，则为占 1 字节的 ASCII 字符（或者说英文字符），长度 + 1
  if c < RuneSelf { // RuneSelf = 128
   // ASCII fast path
   i++
   continue
  }
  // 查询首字节信息表，得到中文占 3 字节，所以这里的 x = 3
  x := first[c]
  // 判断 x = 3,xx = 241（0xF1）
  if x == xx {
   i++ // invalid.
   continue
  }
  // 提取有效的 UTF-8 字节长度编码信息，size = 3
  size := int(x & 7)
  if i+size > ns {
   i++ // Short or invalid.
   continue
  }
  // 提取有效字节范围
  accept := acceptRanges[x>>4]
  // accept.lo，accept.hi，表示 UTF-8 中第二字节的有效范围
  // locb = 0b10000000，表示 UTF-8 编码非首字节的数值下限
  // hicb = 0b10111111，表示 UTF-8 编码非首字节的数值上限
  if c := s[i+1]; c < accept.lo || accept.hi < c {
   size = 1
  } else if size == 2 {
  } else if c := s[i+2]; c < locb || hicb < c {
   size = 1
  } else if size == 3 {
  } else if c := s[i+3]; c < locb || hicb < c {
   size = 1
  }
  i += size
 }
 return n
}
```

调用该函数时，传入一个原始的字符串，代码会根据每个字符的码点大小判断是否为 ASCII 字符，如果是，则算做 1 位；如果不是，则查询首字节表，明确字符占用的字节数，验证有效性后再进行计数。

### 变量

典型的程序使用各种值，这些值在执行过程中可能会发生变化。

*例如*，对用户输入的值执行某些操作的程序。一个用户输入的值可能与另一个用户输入的值不同。因此，这就需要使用变量，因为其他用户可能不会使用相同的值。当一个用户输入一个新值将用于在操作的过程中,可以将暂时存储在计算机的随机存取存储器,这些值在执行这部分内存不同,因此这来的另一个术语称为***变量***。变量是可以在运行时更改的信息的占位符。并且变量允许检索和处理存储的信息。

**变量命名规则：**

变量名称必须以字母或下划线（_）开头。并且名称中可能包含字母“ a-z”或“ A-Z”或数字0-9，以及字符“ _”。变量名称不应以数字开头。变量名称区分大小写。关键字不允许用作变量名。变量名称的长度没有限制，但是建议仅使用4到15个字母的最佳长度。

```
Geeks, geeks, _geeks23  //合法变量
123Geeks, 23geeks      // 非法变量
234geeks  //非法变量
geeks 和Geeks 是两个不同的变量
```

*在Go语言中，变量是通过两种不同的方式创建的：*

* **使用var关键字：**在Go语言中，变量是使用特定类型的*var*关键字创建的，该关键字与变量名关联并赋予其初始值。

**语法：**

```
var variable_name type = expression
```

在上述语法中，*类型（type）* 或*=*表达式可以删除，但不能同时删除变量声明中的两个。如果删除了类型，则变量的类型由表达式中的值初始化确定。

如果删除了表达式，则该变量的类型为零，数字为零，布尔值为false，字符串为**“”**，接口和引用类型为nil。因此，在Go语言中没有这样的未初始化变量的概念。如果使用类型，则可以在单个声明中声明相同类型的多个变量。

如果删除类型，则可以在单个声明中声明不同类型的多个变量。变量的类型由初始化值确定。返回多个值的调用函数允许您初始化一组变量。

```
package main

import "fmt"

func main() {
	// 1. 只写变量名和表达式，类型自动推断
	var a = 20
	var b = "cainiaojc"
	var c = 34.80

	// 2. 写类型但不写初始值，使用零值
	var d int
	var e string
	var f bool

	// 3. 同一行声明多个相同类型变量
	var x, y, z int = 2, 454, 67

	// 4. 同一行声明多个不同类型变量（省略类型，自动推断）
	var m, n, p = 100, "GFG", 67.56

	// 输出值和类型
	fmt.Printf("a = %d, 类型 = %T\n", a, a)
	fmt.Printf("b = %s, 类型 = %T\n", b, b)
	fmt.Printf("c = %f, 类型 = %T\n", c, c)

	fmt.Println()

	fmt.Printf("d = %d, 类型 = %T\n", d, d)
	fmt.Printf("e = %q, 类型 = %T\n", e, e)
	fmt.Printf("f = %t, 类型 = %T\n", f, f)

	fmt.Println()

	fmt.Printf("x = %d, y = %d, z = %d\n", x, y, z)

	fmt.Println()

	fmt.Printf("m = %d, 类型 = %T\n", m, m)
	fmt.Printf("n = %s, 类型 = %T\n", n, n)
	fmt.Printf("p = %f, 类型 = %T\n", p, p)
}

```



**使用短变量声明：使用短变量声明**来声明在函数中声明和初始化的局部变量。

**语法：**

```
variable_name:= expression
```

**注意：**请不要在*：=*和*=*之间混淆，因为*：=* 是声明，而 *=* 是赋值。

在上面的表达式中，变量的类型由表达式的类型确定。

由于它们的简洁性和灵活性，大多数局部变量都是使用短变量声明来声明和初始化的。变量的var声明用于那些需要与初始值设定项表达式不同的显式类型的局部变量，或用于其值稍后分配且初始值不重要的那些变量。使用短变量声明，可以在单个声明中声明多个变量。

在简短的变量声明中，允许返回多个值的调用函数初始化一组变量。

简短的变量声明仅当对于已在同一语法块中声明的那些变量起作用时，才像赋值一样。在外部块中声明的变量将被忽略。如下面的示例所示，这两个变量中至少有一个是新变量。

使用短变量声明，可以在单个声明中声明不同类型的多个变量。这些变量的类型由表达式确定。

借助短变量声明操作符（：=），**您只能声明**仅具有块级作用域**的局部变量**。通常，局部变量在功能块内部声明。如果尝试使用short声明运算符声明全局变量，则会抛出错误消息。

```
package main

import "fmt"

func main() {
	// 1. 使用 := 声明单个变量
	a := 39
	b := "(cainiaojc.com)"
	c := 34.67

	// 2. 使用 := 同时声明多个变量
	x, y, z := 800, "NHOOO", 47.56

	// 3. := 遇到“旧变量 + 新变量”时
	// 只要左边至少有一个新变量，就可以继续使用 :=
	m, n := 39, 45
	p, n := 45, 100 // p 是新变量，n 是已有变量，这里合法

	// 输出值和类型
	fmt.Printf("a = %d, 类型 = %T\n", a, a)
	fmt.Printf("b = %s, 类型 = %T\n", b, b)
	fmt.Printf("c = %f, 类型 = %T\n", c, c)

	fmt.Println()

	fmt.Printf("x = %d, 类型 = %T\n", x, x)
	fmt.Printf("y = %s, 类型 = %T\n", y, y)
	fmt.Printf("z = %f, 类型 = %T\n", z, z)

	fmt.Println()

	fmt.Printf("m = %d, n = %d\n", m, n)
	fmt.Printf("p = %d, n = %d\n", p, n)
}

```

### 常量

正如名称“ **CONSTANTS”所**暗示的意思是固定的，在编程语言中也是如此，即，一旦定义了常量的值，就无法再对其进行修改。常量可以有任何基本数据类型，例如整数常量，浮点常量，字符常量或字符串文字。

常量就像变量一样声明，但是使用***const\*** 关键字作为前缀来声明具有特定类型的常量。不能使用**：=**语法声明。

```
package main

import "fmt"

const PI = 3.14

func main() {
    const GFG = "cainiaojc"
    fmt.Println("Hello", GFG)
    fmt.Println("Happy", PI, "Day")
    const Correct= true
    fmt.Println("Go rules?", Correct)
}

Hello cainiaojc
Happy 3.14 Day
Go rules? true
```

**未类型化和类型化的数字常量：**
类型化常量的工作方式就像不可变变量只能与相同类型互操作，而未类型化常量的工作方式就像文字常量可以与相似类型互操作。可以在Go中使用或不使用类型来声明常量。下面的示例显示已命名和未命名的类型化和未类型化的数字常量。

```
const untypedInteger          = 123
const untypedFloating typed   = 123.12

const typedInteger  int             = 123
const typedFloatingPoint   float64  = 123.12
```

**以下是Go语言中的常量列表：**

- 数值常量（整数常量，浮点常量，复数常量）
- 字符串字面量
- 布尔常量

**数值常量：**
数值常量是***高精度值\***。Go是一种静态类型的语言，不允许混合数字类型的操作。您不能将***float64\***添加到***int\***，甚至不能将***int32添加\*** 到***int\***。虽然，写***1e6 \* time.Second\*** 或***math.Exp（1）\***甚至 ***1 <<（'\ t'+ 2.0）\*** 都是合法的。在Go中，常量与变量不同，其行为类似于常规数字。

数值常量可以是3种，即整数，浮点数，复数

* **整数常量：**前缀指定基数：十六进制为0x或0X，八进制为0，十进制为0。整数字面量也可以具有*后缀*，分别是U（大写）和L（大写）的组合，分别表示无符号和长整数。它可以是*十进制，八进制或十六进制常量*。一个int最多可以存储64位整数，有时更少。

以下是*整数常量的*一些示例*：*

```
85         /* decimal */
0213       /* octal */
0x4b       /* 十六进制 */
30         /* int */
30u        /* unsigned int */
30l        /* long */
30ul       /* unsigned long */
212         /* 合法 */
215u        /* 合法 */
0xFeeL      /* 合法 */
078         /* 非法的:8不是八进制数字 */
032UU       /* 非法的:不能重复后缀 */
```

* **复数常量：**
  复数常量的行为与浮点常量非常相似。它是整数常数（或参数）的*有序对* 或 *实数对*，并且该常数用逗号分隔，并且该对包含在括号之间。第一个常数是实部，第二个常数是虚部。复数常量COMPLEX * 8使用*8个字节*的存储空间。

```
(0.0, 0.0) (-123.456E+30, 987.654E-29)
```

* **浮动类型常量：**浮点型常量具有一个*整数部分，一个小数点，一个小数部分和一个指数部分*。可以用十进制或指数形式表示浮点常量。*虽然*用十进制形式表示，必须包含小数点，指数，或两者兼而有之。并且在使用*指数*形式表示时，必须包括整数部分，小数部分或两者。

以下是浮点类型常量的示例：

```
3.14159       /* 合法 */
314159E-5L    /* 合法 */
510E          /* 非法：不完整的指数 */
210f          /* 非法:没有小数或指数 */
.e55          /* 非法：缺少整数或分数 */
```

* **字符串文字**:Go支持两种类型的字符串文字，即“”（双引号样式）和“”（反引号）。字符串可以*级联*以**+**和**+ =**运算符。字符串包含与字符字面量相似的字符：纯字符，转义序列和通用字符，这是无类型的。字符串类型的零值是空白字符串，可以用或以文字表示。通过使用**==，！=**和（用于比较相同类型）等运算符**，**可比较字符串类型

**语法**

```
type _string struct {
    elements *byte // 底层字节
    len      int   //字节数
}
```

**显示字符串文字的示例：**
"hello, cainiaojc$1quot;

"hello, \

cainiaojc$1quot;

"hello, " "geeks" "forgeeks"

在这里，以上所有三个语句都是相似的，即它们没有任何特定的类型。

```
package main

import "fmt"

func main() {
    const A= "GFG"
    var B = "cainiaojc"
    
    //拼接字符串
    var helloWorld = A+ " " + B
    helloWorld += "!"
    fmt.Println(helloWorld) 
    
    //比较字符串
    fmt.Println(A == "GFG")   
    fmt.Println(B < A) 
}

GFG cainiaojc!
true
false
```

* **布尔常量：**
  布尔常量类似于字符串常量。它应用与字符串常量相同的规则，不同之处仅在于它具有两个未类型化的常量true和false。

```
package main

import "fmt"

const Pi = 3.14

func main() {
    const trueConst = true
    type myBool bool
    var defaultBool = trueConst       // 允许
    var customBool myBool = trueConst // 允许

    //  defaultBool = customBool // 不允许

    fmt.Println(defaultBool)
    fmt.Println(customBool)

}

true
true
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

接下来让我们来详细看看各个运算符的介绍。

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
| **<-*  | 该运算符的名称为接收。它用于从通道接收值。 |                            |

**运算符优先级**

有些运算符拥有较高的优先级，二元运算符的运算方向均是从左至右。下表列出了所有运算符以及它们的优先级，由上至下代表优先级由高到低：

| 优先级 | 运算符           |
| :----- | :--------------- |
| 5      | * / % << >> & &^ |
| 4      | + - \| ^         |
| 3      | == != < <= > >=  |
| 2      | &&               |
| 1      | \|\|             |

当然，你可以通过使用括号来临时提升某个表达式的整体运算优先级。

***和&的使用区别**

```go
package main
import "fmt"

func main() {
	var a int = 3
	var ptr *int
	ptr = &a
	fmt.Println(a,*ptr,ptr)
}
/*
输出 3 3 0xc0000a0090
*/
```

🔺指针变量保存的是一个地址值，会分配独立的内存来分配一个整型数字。当变量前面有*号标识时，才等同于&用法，否则会直接输出一个整型数字。

### 类型转换

类型转换用于将一种数据类型的变量转换为另外一种类型的变量。

Go 语言类型转换基本格式如下：

```
type_name(expression)
```

type_name 为类型，expression 为表达式。

**数值类型转换**

**字符串类型转换**

将一个字符串转换成另一个类型，可以使用以下语法：

```
var str string = "10"
var num int
num, _ = strconv.Atoi(str)
```

以上代码将字符串变量 str 转换为整型变量 num。

注意，**strconv.Atoi** 函数返回两个值，第一个是转换后的整型值，第二个是可能发生的错误，我们可以使用空白标识符 **_** 来忽略这个错误

**接口类型转换**

接口类型转换有两种情况**：类型断言**和**类型转换**。

* **类型断言**

类型断言用于将接口类型转换为指定类型，其语法为：

```
value.(type) 
或者 
value.(T)
```

其中 value 是接口类型的变量，type 或 T 是要转换成的类型。如果类型断言成功，它将返回转换后的值和一个布尔值，表示转换是否成功。

```go
package main

import "fmt"

func main() {
    var i interface{} = "Hello, World"
    str, ok := i.(string)
    if ok {
        fmt.Printf("'%s' is a string\n", str)
    } else {
        fmt.Println("conversion failed")
    }
}
```

* **类型转换**

类型转换用于将一个接口类型的值转换为另一个接口类型，其语法为：

```
T(value)
```

T 是目标接口类型，value 是要转换的值。在类型转换中，我们必须保证要转换的值和目标接口类型之间是兼容的，否则编译器会报错。

```go
package main

import "fmt"

// 定义一个接口 Writer
type Writer interface {
    Write([]byte) (int, error)
}

// 实现 Writer 接口的结构体 StringWriter
type StringWriter struct {
    str string
}

// 实现 Write 方法
func (sw *StringWriter) Write(data []byte) (int, error) {
    sw.str += string(data)
    return len(data), nil
}

func main() {
    // 创建一个 StringWriter 实例并赋值给 Writer 接口变量
    var w Writer = &StringWriter{}
    
    // 将 Writer 接口类型转换为 StringWriter 类型
    sw := w.(*StringWriter)
    
    // 修改 StringWriter 的字段
    sw.str = "Hello, World"
    
    // 打印 StringWriter 的字段值
    fmt.Println(sw.str)
}
```

**空接口类型**

空接口 **interface{}** 可以持有任何类型的值。在实际应用中，空接口经常被用来处理多种类型的值。

```go
package main

import (
    "fmt"
)

func printValue(v interface{}) {
    switch v := v.(type) {
    case int:
        fmt.Println("Integer:", v)
    case string:
        fmt.Println("String:", v)
    default:
        fmt.Println("Unknown type")
    }
}

func main() {
    printValue(42)
    printValue("hello")
    printValue(3.14)
}
```

**不支持隐式转换**

go 不支持隐式转换类型，比如 :

```
package main
import "fmt"

func main() {  
    var a int64 = 3
    var b int32
    b = a
    fmt.Printf("b 为 : %d", b)
}
```

此时会报错

```
cannot use a (type int64) as type int32 in assignment
cannot use b (type int32) as type string in argument to fmt.Printf
```

但是如果改成 **b = int32(a)** 就不会报错了:

```
package main
import "fmt"

func main() {  
    var a int64 = 3
    var b int32
    b = int32(a)
    fmt.Printf("b 为 : %d", b)
}
```



### 控制流与函数

#### 分支与循环

##### 条件控制

**If 语句**：If 在布尔表达式为 true 时，其后紧跟的语句块执行，如果为 false 则执行 else 语句块。

流程图如下：

![Go 语言 if 语句](./assets/bTaq6OdDxlnPXWDv.png)

```go
if 布尔表达式 {
   /* 在布尔表达式为 true 时执行 */
} else {
  /* 在布尔表达式为 false 时执行 */
}

```

**switch 语句**：switch 语句用于基于不同条件执行不同动作，每一个 case 分支都是唯一的，从上至下逐一测试，直到匹配为止。switch 语句执行的过程从上至下，直到找到匹配项，匹配项后面也不需要再加 break。switch 默认情况下 case 最后自带 break 语句，匹配成功后就不会执行其他 case，如果我们需要执行后面的 case，可以使用 **fallthrough** 。其还支持多条件匹配。变量 var1 可以是任何类型，而 val1 和 val2 则可以是同类型的任意值。类型不被局限于常量或整数，但必须是相同的类型；或者最终结果为相同类型的表达式。您可以同时测试多个可能符合条件的值，使用逗号分割它们，例如：case val1, val2, val3。

流程图：

![img](./assets/JhOEChInS6HWjqCV.png)

```go
switch var1 {
    case val1:
        ...
    case val2,val3,val4:
        ...
    default:
        ...
}

```

* switch 语句还可以被用于 type-switch 来判断某个 interface 变量中实际存储的变量类型。

  Type Switch 语法格式如下：

```go
switch x.(type){
    case type:
       statement(s);      
    case type:
       statement(s); 
    /* 你可以定义任意个数的case */
    default: /* 可选 */
       statement(s);
}

```

* **break 与 fallthrough**：不同的 case 之间不使用 break 分隔，默认只会执行一个 case。使用 fallthrough 会强制执行后面的 case 语句，fallthrough 不会判断下一条 case 的表达式结果是否为 true。如果想要执行多个 case，需要使用 fallthrough 关键字，也可用 break 终止。

```go
switch{
    case 1:
    ...
    if(...){
        break
    }

    fallthrough // 此时switch(1)会执行case1和case2，但是如果满足if条件，则只执行case1

    case 2:
    ...
    case 3:
}
```

* **default：**switch 的 default 不论放在哪都是最后执行

```go
a := 10

switch {
   default : {
      fmt.Println("default")
   }
   case a > 0 : {
      fmt.Println("a > 0")
   }
   case a >5 : {
      fmt.Println("a > 5")
   }
}
```

**select 语句**：select 是 Go 中的一个控制结构，类似于 switch 语句。select 语句只能用于通道操作，每个 case 必须是一个通道操作，要么是发送要么是接收。select 语句会监听所有指定的通道上的操作，一旦其中一个通道准备好就会执行相应的代码块。如果多个通道都准备好，那么 select 语句会随机选择一个通道执行。如果所有通道都没有准备好，那么执行 default 块中的代码。也因此for-select常被用于管理连接。

```go
select {
  case <- channel1:
    // 执行的代码
  case value := <- channel2:
    // 执行的代码
  case channel3 <- value:
    // 执行的代码

    // 你可以定义任意数量的 case

  default:
    // 所有通道都没有准备好，执行的代码
}
```

以下描述了 select 语句的语法：

- 每个 case 都必须是一个通道
- 所有 channel 表达式都会被求值
- 所有被发送的表达式都会被求值
- 如果任意某个通道可以进行，它就执行，其他被忽略。
- 如果有多个 case 都可以运行，select 会随机公平地选出一个执行，其他不会执行。
  否则：
  1. 如果有 default 子句，则执行该语句。
  2. 如果没有 default 子句，select 将阻塞，直到某个通道可以运行；Go 不会重新对 channel 或值进行求值。

##### 循环

**for 循环**：for 循环是一个循环控制结构，可以执行指定次数的循环。Go 语言的 For 循环有 4 种形式，只有其中的一种使用分号。for 语句语法流程如下图所示：

![img](./assets/PVFUw4TZATYSimWQ.png)

- 先对表达式 1 赋初值；
- 2、判别赋值表达式 init 是否满足给定条件，若其值为真，满足循环条件，则执行循环体内语句，然后执行 post，进入第二次循环，再判别 condition；否则判断 condition 的值为假，不满足条件，就终止for循环，执行循环体外语句。

* **C语言for循环风格的for循环**

```go
for init; condition; post { }
init： 一般为赋值表达式，给控制变量赋初值；
condition： 关系表达式或逻辑表达式，循环控制条件；
post： 一般为赋值表达式，给控制变量增量或减量。
```

* **C语言while循环风格的for循环**

```go
for condition { }
```

* **无限for循环**

```go
for { }
```

* **for-each-range循环**：for 循环的 range 格式可以对 slice、map、数组、字符串等进行迭代循环。格式如下：

```
for key, value := range oldMap {
    newMap[key] = value
}
```

以上代码中的 key 和 value 是可以省略。

```
for key, _ := range oldMap
for _, value := range oldMap
```

**break语句**：break 语句用于终止当前循环或者 switch 语句的执行，并跳出该循环或者 switch 语句的代码块。

**continue语句**：跳过当前循环执行下一次循环语句。for 循环中，执行 continue 语句会触发 for 增量语句的执行。

**goto语句**：goto 语句可以无条件地转移到过程中指定的行。goto 语句通常与条件语句配合使用。可用来实现条件转移， 构成循环，跳出循环体等功能。goto 语法格式如下：

```
goto label;
..
.
label: statement;
```

goto 语句流程图如下：

![img](./assets/xsTjcmiTVayxBjYe.png)

#### 函数

函数是基本的代码块，用于执行一个任务。Go 语言最少有个 main() 函数。函数声明告诉了编译器函数的名称，返回类型，和参数。Go 语言标准库提供了多种可动用的内置的函数。例如，len() 函数可以接受不同类型参数并返回该类型的长度。如果我们传入的是字符串则返回字符串的长度，如果传入的是数组，则返回数组中包含的元素个数。

##### 函数定义

Go 语言函数定义格式如下：

```
func function_name( [parameter list] ) [return_types] {
   函数体
}
```

函数定义解析：

- func：函数由 func 开始声明
- function_name：函数名称，参数列表和返回值类型构成了函数签名。
- parameter list：参数列表，参数就像一个占位符，当函数被调用时，你可以将值传递给参数，这个值被称为实际参数。参数列表指定的是参数类型、顺序、及参数个数。参数是可选的，也就是说函数也可以不包含参数。
- return_types：返回类型，函数返回一列值。return_types 是该列值的数据类型。有些功能不需要返回值，这种情况下 return_types 不是必须的。
- 函数体：函数定义的代码集合。

##### 函数调用

当创建函数时，你定义了函数需要做什么，通过调用该函数来执行指定任务。调用函数，向函数传递参数，并返回值。Go 函数可以返回多个值。

```go
package main

import "fmt"

func swap(x, y string) (string, string) {
   return y, x
}

func main() {
   a, b := swap("Google", "Runoob")
   fmt.Println(a, b)
}
```

##### 函数参数

函数如果使用参数，该变量可称为函数的形参。形参就像定义在函数体内的局部变量。调用函数，可以通过两种方式来传递参数：

* **值传递**：传递是指在调用函数时将实际参数复制一份传递到函数中，这样在函数中如果对参数进行修改，将不会影响到实际参数。默认情况下，Go 语言使用的是值传递，即在调用过程中不会影响到实际参数。

```go
/* 定义相互交换值的函数 */
func swap(x, y int) int {
   var temp int

   temp = x /* 保存 x 的值 */
   x = y    /* 将 y 值赋给 x */
   y = temp /* 将 temp 值赋给 y*/

   return temp;
}
// 调用完毕后并不会使得传递的x，y交换值
```

* **引用传递**：引用传递是指在调用函数时将实际参数的地址传递到函数中，那么在函数中对参数所进行的修改，将影响到实际参数。

```go
package main

import "fmt"

func main() {
   /* 定义局部变量 */
   var a int = 100
   var b int= 200

   fmt.Printf("交换前，a 的值 : %d\n", a )
   fmt.Printf("交换前，b 的值 : %d\n", b )

   /* 调用 swap() 函数
   * &a 指向 a 指针，a 变量的地址
   * &b 指向 b 指针，b 变量的地址
   */
   swap(&a, &b)

   fmt.Printf("交换后，a 的值 : %d\n", a )
   fmt.Printf("交换后，b 的值 : %d\n", b )
}

func swap(x *int, y *int) {
   var temp int
   temp = *x    /* 保存 x 地址上的值 */
   *x = *y      /* 将 y 值赋给 x */
   *y = temp    /* 将 temp 值赋给 y */
}

```

##### 变参函数

用不同数量的参数调用的函数称为可变参数函数。换句话说，允许用户在可变函数中传递零个或多个参数。*fmt.Printf*是可变参数函数的示例，它在开始时需要一个固定的参数，之后它可以接受任意数量的参数。

在可变参数函数的声明中，最后一个参数的类型前面带有省略号，即（**…**）。它表明该函数可以调用任意数量的这种类型的参数

**语法：**

```
function function_name(para1, para2...type)type{
    // code...
}
```

函数function …type*的*的行为类似于切片（slice）。例如，假设我们有一个函数签名，即add（b…int）int，现在是type [] int的参数。您还可以在可变参数函数中传递现有切片。为此，我们将完整数组的一部分传递给函数，如下面的*示例2*所示。当您在可变参数函数中不传递任何参数时，函数内部的默认为nil。可变参数函数通常用于字符串格式化。您还可以在可变参数函数中传递多个切片。您不能将可变参数用作返回值，但可以将其作为切片返回。

```
package main 
  
import( 
    "fmt"
    "strings"
) 
  
//可变参数函数联接字符串
func joinstr(element...string)string{ 
    return strings.Join(element, "-") 
} 
  
func main() { 
     
   //在可变函数中传递一个切片
   element:= []string{"geeks", "FOR", "geeks"} 
   fmt.Println(joinstr(element...)) 
}

geeks-FOR-geeks
```

##### **匿名函数/闭包**

Go 语言支持匿名函数，可作为闭包。匿名函数是一个"内联"语句或表达式。匿名函数的优越性在于可以直接使用函数内的变量，不必申明。在Go语言中，可以将匿名函数分配给变量。将函数分配给变量时，变量的类型就是函数类型，您可以像调用函数一样调用该变量,您也可以在匿名函数中传递参数。还可以将匿名函数作为参数传递给其他函数。还可以从另一个函数返回匿名函数。

**语法：**

```
    func(parameter_list) return_type {
        //代码
        //如果给定return_type，则使用return语句
        //如果未提供return_type，则不
        //使用return语句
        return
    }()
```

```go
package main

import "fmt"

// 1. 将匿名函数作为参数传递给其他函数
func showResult(fn func(p, q string) string) {
	fmt.Println(fn("Geeks", "for"))
}

// 2. 从另一个函数返回匿名函数
func getMessageFunc() func(i, j string) string {
	myf := func(i, j string) string {
		return i + j + "cainiaojc"
	}
	return myf
}

func main() {
	// 3. 将匿名函数赋值给变量
	value := func() {
		fmt.Println("Welcome! to (cainiaojc.com)")
	}
	value()

	// 4. 直接调用带参数的匿名函数
	func(ele string) {
		fmt.Println(ele)
	}("cainiaojc")

	// 5. 把匿名函数作为参数传递给其他函数
	join := func(p, q string) string {
		return p + q + "Geeks"
	}
	showResult(join)

	// 6. 接收另一个函数返回的匿名函数
	msgFunc := getMessageFunc()
	fmt.Println(msgFunc("Welcome ", "to "))
}

Welcome! to (cainiaojc.com)
cainiaojc
GeeksforGeeks
Welcome to cainiaojc
```

##### 多值返回与命名返回

在Go语言中，允许您使用return语句从一个[函数](https://www.cainiaojc.com/functions-in-go-language/index.html)返回多个值。换句话说，在函数中，单个return语句可以返回多个值。返回值的类型类似于参数列表中定义的参数的类型。

**语法：**

```
func function_name(parameter_list)(return_type_list){
     // code...
}
```

*这里，*

- **function_name：**它是**函数**的名称。
- **parameter-list：**它包含函数参数的名称和类型。
- **return_type_list：**这是可选的，它包含函数返回的值的类型。如果在函数中使用return_type，则必须在函数中使用return语句。

在Go语言中，允许为返回值提供名称。你也可以在代码中使用这些变量名。没有必要用return语句来编写这些名称，因为Go编译器将自动理解这些变量必须被分派回去。这种类型的回报被称为裸回报。简单的返回减少了程序中的重复。

**语法：**

```
func function_name(para1, para2 int)(name1 int, name2 int){
    // code...
}

或

func function_name(para1, para2 int)(name1, name2 int){
   // code...
}
```

这里，*name1*和*name2*是返回值的名称，而para1和para2是函数的参数。

```go
package main

import "fmt"

// myfunc返回2个int类型的值
//这里是返回值名称
//是rectangle and square
func myfunc(p, q int) (rectangle int, square int) {
    rectangle = p * q
    square = p * p
    return
}

func main() {

    //将返回值分配到
    //两个不同的变量
    var area1, area2 = myfunc(2, 4)

    fmt.Printf("矩形面积为: %d", area1)
    fmt.Printf("\n正方形面积为: %d", area2)

}
```

使用命名的返回参数后，return语句通常称为"**裸返**"。默认情况下，Golang用零值定义所有命名变量，函数将能够使用它们。如果函数未修改值，则将自动返回零值。如果您将使用[短声明运算符（：=）](https://www.cainiaojc.com/golang/go-short-variable-declaration-operator.html)初始化命名的返回参数，则将给出错误，因为它们已被Go编译器初始化。因此，您可以使用简单的赋值方式（=）将值分配给命名的返回参数。

```
//具有命名参数的函数
func calculator(a, b int) (mul int, div int) {

    //在这里，它将抛出一个错误
    //因为已经定义了参数
    //在函数签名中
    mul := a * b
    div := a / b

    //这里有return关键字
    //没有任何结果参数
    return
}
```

##### 特殊函数

**main函数**

在Go语言中，**main**包是一个特殊的软件包，与可执行程序一起使用，并且该package包含*main()*函数。在*main()*函数是一种特殊类型的函数，它是可执行程序的入口点。它不带任何参数也不返回任何内容。由于可以自动调用*main()*函数，因此无需显式调用*main()*函数，并且每个可执行程序必须包含一个package main和*main()*函数。

**init()函数**

init()函数就像main函数一样，不带任何参数也不返回任何东西。 每个包中都存在此函数，并且在初始化包时将调用此函数。 该函数是隐式声明的，因此您不能从任何地方引用它，并且可以在同一程序中创建多个init()函数，并且它们将按照创建顺序执行。 您可以在程序中的任何位置创建init()函数，并且它们以词汇文件名顺序（字母顺序）调用。 并允许在init()函数中放置语句，但始终记住要在main()函数调用之前执行init()函数，因此它不依赖于main()函数。  init()函数的主要目的是初始化无法在全局上下文中初始化的全局变量。

##### 函数特殊用法

###### 空白标识符

[Golang中的](https://www.cainiaojc.com/)**_**（下划线）称为空白标识符。[标识符](https://www.cainiaojc.com/golang/go-identifiers.html)是用于识别目的的程序组件的用户定义名称。

Golang有一个特殊的特性，可以使用空白标识符定义和使用未使用的变量。未使用变量是指用户在整个程序中定义但从未使用过的[变量](https://www.cainiaojc.com/golang/go-variables.html)。这些变量使程序几乎不可读。如你所知，Golang是一种更加简洁和可读的编程语言，因此它不允许程序员定义未使用的变量，如果你这样做，编译器将抛出一个错误。
当函数返回多个值时，才真正使用Blank Identifier，但是我们只需要几个值并希望丢弃一些值。 基本上，它告诉编译器不需要此变量，并且将其忽略而没有任何错误。 它隐藏变量的值并使程序可读。 因此，每当您将值分配给Bank Identifier时，它就变得不可用。

您可以在同一程序中使用多个空白标识符。因此，可以说Golang程序可以使用相同的标识符名称（即空白标识符）来包含多个变量。在很多情况下，即使知道这些值将不会在程序中的任何地方使用，也需要分配值来完成语法。就像一个返回多个值的函数。在这种情况下，通常使用空白标识符。您可以将任何类型的任何值与空白标识符一起使用。

```go
package main

import "fmt"

func main() {

    //调用函数
    //函数返回两个值
    //分配给mul和空白标识符
    mul, _ := mul_div(105, 7)

    //只使用mul变量
    fmt.Println("105 x 7 = ", mul)
}

//函数返回两个
//整数类型的值
func mul_div(n1 int, n2 int) (int, int) {
    //返回值
    return n1 * n2, n1 / n2
}
```

###### defer 关键字

在Go语言中，defer语句会延迟[函数](https://www.cainiaojc.com/golang/go-functions.html)或方法或[匿名方法](https://www.cainiaojc.com/404.html)的执行，直到附近的函数返回为止。换句话说，延迟函数或方法调用参数会立即求值，但是它们会执行到附近的函数返回为止。您可以使用defer关键字创建延迟的方法，函数或匿名函数。

**语法：**

```
// 函数
defer func func_name(parameter_list Type) return_type{
    // Code
}

// 方法
defer func (receiver Type) method_name(parameter_list){
    // Code
}

defer func (parameter_list)(return_type){
    // code
}()
```

**注意事项：**

- 在Go语言中，同一程序中允许多个defer语句，并且它们按LIFO（后进先出）顺序执行，如示例2所示。
- 在defer语句中，将在执行defer语句时（而不是在调用它们时）评估参数。
- defer语句通常用于确保在完成文件处理后关闭文件，关闭通道或捕获程序中的紧急情况。

```go
package main

import "fmt"

// 函数
func mul(a1, a2 int) int {
    res := a1 * a2
    fmt.Println("Result: ", res)
    return 0
}

func show() {
    fmt.Println("Hello!, www.cainiaojc.com Go语言菜鸟教程")
}

func main() {

    //调用mul()函数
    //这里mul函数的行为
    //像普通函数一样
    mul(23, 45)

    //调用mul()函数
    //使用defer关键字
    //这里是mul()函数
    //是延迟函数
    defer mul(23, 56)
    //调用show()函数
    show()
}


Result:  1035
Hello!, www.cainiaojc.com Go语言菜鸟教程
Result:  1288
```



###### **函数作为参数**

Go 语言可以很灵活的创建函数，并作为另外一个函数的实参。以下实例中我们在定义的函数中初始化一个变量。

```go
package main
import "fmt"

// 声明一个函数类型
type cb func(int) int

func main() {
	testCallBack(1, callBack)
	testCallBack(2, func(x int) int {
		fmt.Printf("我是回调，x：%d\n", x)
		return x
	})
}

func testCallBack(x int, f cb) {
	f(x)
}

func callBack(x int) int {
	fmt.Printf("我是回调，x：%d\n", x)
	return x
}
/*
我是回调，x：1
我是回调，x：2
*/
```

#### 变量作用域

变量的作用域可以定义为可访问特定变量的程序的一部分。可以在类，方法，循环等中定义变量。像C / [C ++一样](https://www.cainiaojc.com/cpp/index.html)，在Golang中，所有的标识符都是词法(或静态)作用域，即变量的作用域可以在编译时确定。或者你可以说一个变量只能从定义它的代码块中调用。

Golang变量的范围规则可以分为两类，具体取决于声明变量的位置：

- **局部变量**（在块或函数内部声明）
- **全局变量**（在块或函数外部声明）

**局部变量**

在函数或块中声明的变量称为局部变量。这些不能在函数或块之外访问。这些变量也可以在函数内的for，while语句等内部声明。但是，这些变量可以由函数内的嵌套代码块访问。这些变量也称为块变量。如果在同一作用域中用相同的名称声明两次这些变量，则会出现编译时错误。函数执行结束后，这些变量将不存在。在循环外声明的变量也可以在嵌套循环内访问。这意味着方法和所有循环都可以访问全局变量。局部变量可被循环访问，并在该函数内执行函数。在循环体内声明的变量对循环体外不可见。

**全局变量**

在函数或块之外定义的变量称为全局变量。这些在程序的整个生命周期中都可用。这些在所有函数或块之外的程序顶部声明。这些可以从程序的任何部分进行访问。

如果函数中存在与全局变量同名的局部变量，编译器将优先选择局部变量。通常，当定义了两个具有相同名称的变量时，编译器会产生编译时错误。但是，如果变量在不同的范围内定义，则编译器会允许它。只要定义了与全局变量同名的局部变量，编译器就会优先考虑该局部变量。

**形式参数**

形式参数会作为函数的局部变量来使用。

**初始化局部和全局变量**

| 数据类型 | 初始化默认值 |
| -------- | ------------ |
| int      | 0            |
| float32  | 0            |
| pointer  | nil          |

### 错误处理

Go没有像Java中的try / catch这样的异常机制，我们不能在Go中抛出异常。Go使用另一种机制，称为*延迟恐慌和恢复机制。Go通过返回一个错误对象来处理函数和方法的简单错误。错误对象可能是唯一或最后一个返回值。如果函数中没有错误，则错误对象为nil。

无论是否收到错误，我们都应始终在调用语句中检查错误。我们永远不要忽略错误，它可能导致程序崩溃。

Go语言检测和报告错误情况的方法是

- 可能导致错误的函数将返回两个变量：一个值和一个错误代码，如果成功，则为nil；如果错误条件，则为== nil。
- 在函数调用之后检查错误。如果发生错误（ if error != nil），则停止执行实际功能（或必要时整个程序）。

**Go 的错误处理主要围绕以下机制展开：**

1. **`error` 接口**：标准的错误表示。
2. **显式返回值**：通过函数的返回值返回错误。
3. **自定义错误**：可以通过标准库或自定义的方式创建错误。
4. **`panic` 和 `recover`**：处理不可恢复的严重错误。

#### **Error 接口**

Go 标准库定义了一个 error 接口，表示一个错误的抽象。

error 类型是一个接口类型，这是它的定义：

```
type error interface {
    Error() string
}
```

- **实现 `error` 接口**：任何实现了 `Error()` 方法的类型都可以作为错误。
- `Error()` 方法返回一个描述错误的字符串。

我们可以在编码中通过实现 error 接口类型来生成错误信息。

```
func Sqrt(f float64) (float64, error) {
    if f < 0 {
        return 0, errors.New("math: square root of negative number")
    }
    // 实现
}
```

在下面的例子中，我们在调用 Sqrt 的时候传递的一个负数，然后就得到了 non-nil 的 error 对象，将此对象与 nil 比较，结果为 true，所以 fmt.Println(fmt 包在处理 error 时会调用 Error 方法)被调用，以输出错误，请看下面调用的示例代码：

```
result, err:= Sqrt(-1)

if err != nil {
   fmt.Println(err)
}
```

Go 中，错误通常作为函数的返回值返回，开发者需要显式检查并处理。

**自定义错误**

通过定义自定义类型，可以扩展 error 接口。`fmt` 包提供了对错误的格式化输出支持：

- `%v`：默认格式。
- `%+v`：如果支持，显示详细的错误信息。
- `%s`：作为字符串输出。

```
package main

import (
    "fmt"
)

// 定义一个 DivideError 结构
type DivideError struct {
    dividee int
    divider int
}

// 实现 `error` 接口
func (de *DivideError) Error() string {
    strFormat := `
    Cannot proceed, the divider is zero.
    dividee: %d
    divider: 0
`
    return fmt.Sprintf(strFormat, de.dividee)
}

// 定义 `int` 类型除法运算的函数
func Divide(varDividee int, varDivider int) (result int, errorMsg string) {
    if varDivider == 0 {
            dData := DivideError{
                    dividee: varDividee,
                    divider: varDivider,
            }
            errorMsg = dData.Error()
            return
    } else {
            return varDividee / varDivider, ""
    }

}

func main() {

    // 正常情况
    if result, errorMsg := Divide(100, 10); errorMsg == "" {
            fmt.Println("100/10 = ", result)
    }
    // 当除数为零的时候会返回错误信息
    if _, errorMsg := Divide(100, 0); errorMsg != "" {
            fmt.Println("errorMsg is: ", errorMsg)
    }

}
```

**使用 errors.Is 和 errors.As**

从 Go 1.13 开始，`errors` 包引入了 `errors.Is` 和 `errors.As` 用于处理错误链：

* **`errors.Is`**:检查某个错误是否是特定错误或由该错误包装而成。

```
package main

import (
        "errors"
        "fmt"
)

var ErrNotFound = errors.New("not found")

func findItem(id int) error {
        return fmt.Errorf("database error: %w", ErrNotFound)
}

func main() {
        err := findItem(1)
        if errors.Is(err, ErrNotFound) {
                fmt.Println("Item not found")
        } else {
                fmt.Println("Other error:", err)
        }
}
```

* **errors.As**:将错误转换为特定类型以便进一步处理。

```
package main

import (
        "errors"
        "fmt"
)

type MyError struct {
        Code int
        Msg  string
}

func (e *MyError) Error() string {
        return fmt.Sprintf("Code: %d, Msg: %s", e.Code, e.Msg)
}

func getError() error {
        return &MyError{Code: 404, Msg: "Not Found"}
}

func main() {
        err := getError()
        var myErr *MyError
        if errors.As(err, &myErr) {
                fmt.Printf("Custom error - Code: %d, Msg: %s\n", myErr.Code, myErr.Msg)
        }
}
```

#### Panic 与 Recover

panic 与 recover 是 Go 的两个内置函数，这两个内置函数用于处理 Go 运行时的错误，panic 用于主动抛出错误，recover 用来捕获 panic 抛出的错误。

- 引发`panic`有两种情况，一是程序主动调用，二是程序产生运行时错误，由运行时检测并退出。发生`panic`后，程序会从调用`panic`的函数位置或发生`panic`的地方立即返回，逐层向上执行函数的`defer`语句，然后逐层打印函数调用堆栈，直到被`recover`捕获或运行到最外层函数。`panic`不但可以在函数正常流程中抛出，在`defer`逻辑里也可以再次调用`panic`或抛出`panic`。`defer`里面的`panic`能够被后续执行的`defer`捕获。
- `recover`用来捕获`panic`，阻止`panic`继续向上传递。`recover()`和`defer`一起使用，但是`defer`只有在后面的函数体内直接被掉用才能捕获`panic`来终止异常，否则返回`nil`，异常继续向外传递。

##### panic

Panic是一种我们用来处理错误情况的机制。紧急情况可用于中止函数执行。当一个函数调用panic时，它的执行停止，并且控制流程到相关的延迟函数。

这个函数的调用者也会被终止，调用者的延迟函数也会被执行(如果有的话)。这个过程一直持续到程序结束。现在报告错误情况。

这种终止序列称为panic，可以由内置函数recover控制。

```
package main

import "os"

func main() {
	panic("Error Situation")
	_, err := os.Open("/tmp/file")
	if err != nil {
		panic(err)
	}
}
```

输出：

```
panic: Error Situation

goroutine 1 [running]:
main.main()
/Users/pro/GoglandProjects/Panic/panic example1.go:6 +0x39
```

##### recover

恢复用于从紧急情况或错误情况中重新获得对程序的控制。它停止终止序列并恢复正常执行。从延迟函数中调用。它检索通过panic调用传递的错误值。通常，它返回**nil**，没有其他效果。

```
package main
import (
   "fmt"
)
func main() {
   fmt.Println(SaveDivide(10, 0))
   fmt.Println(SaveDivide(10, 10))
}
func SaveDivide(num1, num2 int) int {
   defer func() {
      fmt.Println(recover())
   }()
   quotient := num1 / num2
   return quotient
}
```

输出：

```
runtime error: integer divide by zero
0
<nil>
1
```

#### Fatal

`fatal`是一种极其严重的问题，当发生`fatal`时，程序需要立刻停止运行，不会执行任何善后工作，通常情况下是调用`os`包下的`Exit`函数退出程序，如下所示

```
func main() {
  dangerOp("")
}

func dangerOp(str string) {
  if len(str) == 0 {
    fmt.Println("fatal")
    os.Exit(1)
  }
  fmt.Println("正常逻辑")
}
```

输出

```
fatal
```

`fatal`级别的问题一般很少会显式的去触发，大多数情况都是被动触发。



### 文件与IO

Go 语言提供文件处理的标准库大致以下几个：

- `os`库，负责 OS 文件系统交互的具体实现
- `io`库，读写 IO 的抽象层
- `fs`库，文件系统的抽象层

本文会讲解如何通过 Go 语言来进行基本的文件处理。

#### [打开](https://golang.halfiisland.com/essential/senior/100.io.html#打开)

常见的两种打开文件的方式是使用`os`包提供的两个函数，`Open`函数返回值一个文件指针和一个错误，



```
func Open(name string) (*File, error)
```

后者`OpenFile`能够提供更加细粒度的控制，函数`Open`就是对`OpenFile`函数的一个简单封装。



```
func OpenFile(name string, flag int, perm FileMode) (*File, error)
```

先来介绍第一种使用方法，直接提供对应的文件名即可，代码如下



```
func main() {
   file, err := os.Open("README.txt")
   fmt.Println(file, err)
}
```

文件的查找路径默认为项目`go.mod`文件所在的路径，由于项目下并没有文件`README.txt`，所以自然会返回一个错误。



```
<nil> open README.txt: The system cannot find the file specified.
```

因为 IO 错误的类型有很多，所以需要手动的去判断文件是否存在，同样的`os`包也为此提供了方便函数，修改后的代码如下



```
func main() {
  file, err := os.Open("README.txt")
  if os.IsNotExist(err) {
    fmt.Println("文件不存在")
  } else if err != nil {
    fmt.Println("文件访问异常")
  } else {
    fmt.Println("文件读取成功", file)
  }
}
```

再次运行输出如下



```
文件不存在
```

事实上第一种函数读取的文件仅仅只是只读的，无法被修改



```
func Open(name string) (*File, error) {
  return OpenFile(name, O_RDONLY, 0)
}
```

通过`OpenFile`函数可以控制更多细节，例如修改文件描述符和文件权限，关于文件描述符，`os`包下提供了以下常量以供使用。



```
const (
   // 只读，只写，读写 三种必须指定一个
   O_RDONLY int = syscall.O_RDONLY // 以只读的模式打开文件
   O_WRONLY int = syscall.O_WRONLY // 以只写的模式打开文件
   O_RDWR   int = syscall.O_RDWR   // 以读写的模式打开文件
   // 剩余的值用于控制行为
   O_APPEND int = syscall.O_APPEND // 当写入文件时，将数据添加到文件末尾
   O_CREATE int = syscall.O_CREAT  // 如果文件不存在则创建文件
   O_EXCL   int = syscall.O_EXCL   // 与O_CREATE一起使用, 文件必须不存在
   O_SYNC   int = syscall.O_SYNC   // 以同步IO的方式打开文件
   O_TRUNC  int = syscall.O_TRUNC  // 当打开的时候截断可写的文件
)
```

关于文件权限的则提供了以下常量。



```
const (
   ModeDir        = fs.ModeDir        // d: 目录
   ModeAppend     = fs.ModeAppend     // a: 只能添加
   ModeExclusive  = fs.ModeExclusive  // l: 专用
   ModeTemporary  = fs.ModeTemporary  // T: 临时文件
   ModeSymlink    = fs.ModeSymlink    // L: 符号链接
   ModeDevice     = fs.ModeDevice     // D: 设备文件
   ModeNamedPipe  = fs.ModeNamedPipe  // p: 具名管道 (FIFO)
   ModeSocket     = fs.ModeSocket     // S: Unix 域套接字
   ModeSetuid     = fs.ModeSetuid     // u: setuid
   ModeSetgid     = fs.ModeSetgid     // g: setgid
   ModeCharDevice = fs.ModeCharDevice // c: Unix 字符设备, 前提是设置了 ModeDevice
   ModeSticky     = fs.ModeSticky     // t: 黏滞位
   ModeIrregular  = fs.ModeIrregular  // ?: 非常规文件

   // 类型位的掩码. 对于常规文件而言，什么都不会设置.
   ModeType = fs.ModeType

   ModePerm = fs.ModePerm // Unix 权限位, 0o777
)
```

下面是一个以读写模式打开一个文件的代码例子，权限为`0666`，表示为所有人都可以对该文件进行读写，且不存在时会自动创建。



```
func main() {
  file, err := os.OpenFile("README.txt", os.O_RDWR|os.O_CREATE, 0666)
  if os.IsNotExist(err) {
    fmt.Println("文件不存在")
  } else if err != nil {
    fmt.Println("文件访问异常")
  } else {
    fmt.Println("文件打开成功", file.Name())
    file.Close()
  }
}
```

输出如下



```
文件打开成功 README.txt
```

倘若只是想获取该文件的一些信息，并不想读取该文件，可以使用`os.Stat()`函数进行操作，代码示例如下



```
func main() {
  fileInfo, err := os.Stat("README.txt")
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println(fmt.Sprintf("%+v", fileInfo))
  }
}
```

输出如下



```
&{name:README.txt FileAttributes:32 CreationTime:{LowDateTime:3603459389 HighDateTime:31016791} LastAccessTime:{LowDateTime:3603459389 HighDateTime:31016791} LastWriteTime:{LowDateTime:3603459389 HighDateTime:31016791} FileSizeHigh
:0 FileSizeLow:0 Reserved0:0 filetype:0 Mutex:{state:0 sema:0} path:README.txt vol:0 idxhi:0 idxlo:0 appendNameToPath:false}
```

注意

打开一个文件后永远要记得关闭该文件，通常关闭操作会放在`defer`语句里



```
defer file.Close()
```

#### [读取](https://golang.halfiisland.com/essential/senior/100.io.html#读取)

当成功的打开文件后，便可以进行读取操作了，关于读取文件的操作，`*os.File`类型提供了以下几个公开的方法

```
// 将文件读进传入的字节切片
func (f *File) Read(b []byte) (n int, err error)

// 相较于第一种可以从指定偏移量读取
func (f *File) ReadAt(b []byte, off int64) (n int, err error)
```

大多数情况第一种使用的较多。针对于第一种方法，需要自行编写逻辑来进行读取时切片的动态扩容，代码如下



```
func ReadFile(file *os.File) ([]byte, error) {
  buffer := make([]byte, 0, 512)
  for {
    // 当容量不足时
    if len(buffer) == cap(buffer) {
      // 扩容
      buffer = append(buffer, 0)[:len(buffer)]
    }
    // 继续读取文件
    offset, err := file.Read(buffer[len(buffer):cap(buffer)])
    // 将已写入的数据归入切片
    buffer = buffer[:len(buffer)+offset]
    // 发生错误时
    if err != nil {
      if errors.Is(err, io.EOF) {
        err = nil
      }
      return buffer, err
    }
  }
}
```

剩余逻辑如下



```
func main() {
   file, err := os.OpenFile("README.txt", os.O_RDWR|os.O_CREATE, 0666)
   if err != nil {
      fmt.Println("文件访问异常")
   } else {
      fmt.Println("文件打开成功", file.Name())
      bytes, err := ReadFile(file)
      if err != nil {
         fmt.Println("文件读取异常", err)
      } else {
         fmt.Println(string(bytes))
      }
      file.Close()
   }
}
```

输出为



```
文件打开成功 README.txt
hello world!
```

除此之外，还可以使用两个方便函数来进行文件读取，分别是`os`包下的`ReadFile`函数，以及`io`包下的`ReadAll`函数。对于`os.ReadFile`而言，只需要提供文件路径即可，而对于`io.ReadAll`而言，则需要提供一个`io.Reader`类型的实现，

**os.ReadFile**



```
func ReadFile(name string) ([]byte, error)
```

使用例子如下



```
func main() {
  bytes, err := os.ReadFile("README.txt")
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println(string(bytes))
  }
}
```

输出如下



```
hello world!
```

**io.ReadAll**



```
func ReadAll(r Reader) ([]byte, error)
```

使用例子如下



```
func main() {

   file, err := os.OpenFile("README.txt", os.O_RDWR|os.O_CREATE, 0666)
   if err != nil {
      fmt.Println("文件访问异常")
   } else {
      fmt.Println("文件打开成功", file.Name())
      bytes, err := io.ReadAll(file)
      if err != nil {
         fmt.Println(err)
      } else {
         fmt.Println(string(bytes))
      }
      file.Close()
   }
}
```



```
文件打开成功 README.txt
hello world!
```

#### [写入](https://golang.halfiisland.com/essential/senior/100.io.html#写入)

`os.File`结构体提供了以下几种方法以供写入数据



```
// 写入字节切片
func (f *File) Write(b []byte) (n int, err error)

// 写入字符串
func (f *File) WriteString(s string) (n int, err error)

// 从指定位置开始写，当以os.O_APPEND模式打开时，会返回错误
func (f *File) WriteAt(b []byte, off int64) (n int, err error)
```

如果想要对一个文件写入数据，则必须以`O_WRONLY`或`O_RDWR`的模式打开，否则无法成功写入文件。下面是一个以`os.O_RDWR|os.O_CREATE|os.O_APPEND|os.O_TRUNC`模式打开文件，且权限为`0666`向指定写入数据的例子



```
func main() {
  file, err := os.OpenFile("README.txt", os.O_RDWR|os.O_CREATE|os.O_APPEND|os.O_TRUNC, 0666)
  if err != nil {
    fmt.Println("文件访问异常")
  } else {
    fmt.Println("文件打开成功", file.Name())
    for i := 0; i < 5; i++ {
      offset, err := file.WriteString("hello world!\n")
      if err != nil {
        fmt.Println(offset, err)
      }
    }
    fmt.Println(file.Close())
  }
}
```

由于是以`os.O_APPEND`模式打开的文件，所以在写入文件时会将数据添加到文件尾部，执行完毕后文件内容如下



```
hello world!
hello world!
hello world!
hello world!
hello world!
```

向文件写入字节切片也是类似的操作，就不再赘述。对于写入文件的操作标准库同样提供了方便函数，分别是`os.WriteFile`与`io.WriteString`

**os.WriteFile**



```
func WriteFile(name string, data []byte, perm FileMode) error
```

使用例子如下



```
func main() {
  err := os.WriteFile("README.txt", []byte("hello world!\n"), 0666)
  if err != nil {
    fmt.Println(err)
  }
}
```

此时文件内容如下



```
hello world!
```

**io.WriteString**



```
func WriteString(w Writer, s string) (n int, err error)
```

使用例子如下



```
func main() {
   file, err := os.OpenFile("README.txt", os.O_RDWR|os.O_CREATE|os.O_APPEND|os.O_TRUNC, 0666)
   if err != nil {
      fmt.Println("文件访问异常")
   } else {
      fmt.Println("文件打开成功", file.Name())
      for i := 0; i < 5; i++ {
         offset, err := io.WriteString(file, "hello world!\n")
         if err != nil {
            fmt.Println(offset, err)
         }
      }
      fmt.Println(file.Close())
   }
}
```



```
hello world!
hello world!
hello world!
hello world!
hello world!
```

函数`os.Create`函数用于创建文件，本质上也是对`OpenFile`的封装。



```
func Create(name string) (*File, error) {
   return OpenFile(name, O_RDWR|O_CREATE|O_TRUNC, 0666)
}
```

注意

在创建一个文件时，如果其父目录不存在，将创建失败并会返回错误。

#### [复制](https://golang.halfiisland.com/essential/senior/100.io.html#复制)

对于复制文件而言，需要同时打开两个文件，第一种方法是将原文件中的数据读取出来，然后写入目标文件中，代码示例如下



```
func main() {
    // 从原文件中读取数据
  data, err := os.ReadFile("README.txt")
  if err != nil {
    fmt.Println(err)
    return
  }
    // 写入目标文件
  err = os.WriteFile("README(1).txt", data, 0666)
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println("复制成功")
  }
}
```

***os.File.ReadFrom**

另一种方法是使用`os.File`提供的方法`ReadFrom`，打开文件时，一个只读，一个只写。



```
func (f *File) ReadFrom(r io.Reader) (n int64, err error)
```

使用示例如下



```
func main() {
  // 以只读的方式打开原文件
  origin, err := os.OpenFile("README.txt", os.O_RDONLY, 0666)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer origin.Close()
  // 以只写的方式打开副本文件
  target, err := os.OpenFile("README(1).txt", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0666)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer target.Close()
  // 从原文件中读取数据，然后写入副本文件
  offset, err := target.ReadFrom(origin)
  if err != nil {
    fmt.Println(err)
    return
  }
  fmt.Println("文件复制成功", offset)
}
```

这种复制方式需要先将源文件的全部内容读取到内存中，再写入目标文件，文件特别大的时候不建议这么做。

**io.Copy**

另一种方法就是使用`io.Copy`函数，它则是一边读一边写，先将内容读到缓冲区中，再写入到目标文件中，缓冲区默认大小为 32KB。



```
func Copy(dst Writer, src Reader) (written int64, err error)
```

使用示例如下



```
func main() {
  // 以只读的方式打开原文件
  origin, err := os.OpenFile("README.txt", os.O_RDONLY, 0666)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer origin.Close()
  // 以只写的方式打开副本文件
  target, err := os.OpenFile("README(1).txt", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0666)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer target.Close()
  // 复制
  written, err := io.Copy(target, origin)
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println(written)
  }
}
```

你也可以使用`io.CopyBuffer`来指定缓冲区大小。

#### [重命名](https://golang.halfiisland.com/essential/senior/100.io.html#重命名)

重命名也可以理解为移动文件，会用到`os`包下的`Rename`函数。

```
func Rename(oldpath, newpath string) error
```

示例如下

```
func main() {
  err := os.Rename("README.txt", "readme.txt")
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println("重命名成功")
  }
}
```

该函数对于文件夹也是同样的效果。

#### [删除](https://golang.halfiisland.com/essential/senior/100.io.html#删除)

删除操作相较于其他操作要简单的多，只会用到`os`包下的两个函数



```
// 删除单个文件或者空目录，当目录不为空时会返回错误
func Remove(name string) error

// 删除指定目录的所有文件和目录包括子目录与子文件
func RemoveAll(path string) error
```

使用起来十分的简单，下面是删除目录的例子



```
func main() {
  // 删除当前目录下所有的文件与子目录
  err := os.RemoveAll(".")
  if err != nil {
    fmt.Println(err)
  }else {
    fmt.Println("删除成功")
  }
}
```

下面是删除单个文件的例子



```
func main() {
  // 删除当前目录下所有的文件与子目录
  err := os.Remove("README.txt")
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println("删除成功")
  }
}
```

#### [刷新](https://golang.halfiisland.com/essential/senior/100.io.html#刷新)

`os.Sync`这一个函数封装了底层的系统调用`Fsync`，用于将操作系统中缓存的 IO 写入落实到磁盘上



```
func main() {
  create, err := os.Create("test.txt")
  if err != nil {
    panic(err)
  }
  defer create.Close()

  _, err = create.Write([]byte("hello"))
  if err != nil {
    panic(err)
  }

    // 刷盘
  if err := create.Sync();err != nil {
    return
  }
}
```

#### [文件夹](https://golang.halfiisland.com/essential/senior/100.io.html#文件夹)

文件夹的许多操作都与文件操作类似

##### [读取](https://golang.halfiisland.com/essential/senior/100.io.html#读取-1)

对于文件夹而言，打开方式有两种，

**os.ReadDir**

第一种方式是使用`os.ReadDir`函数



```
func ReadDir(name string) ([]DirEntry, error)
```



```
func main() {
   // 当前目录
   dir, err := os.ReadDir(".")
   if err != nil {
      fmt.Println(err)
   } else {
      for _, entry := range dir {
         fmt.Println(entry.Name())
      }
   }
}
```

***os.File.ReadDir**

第二种方式是使用`*os.File.ReadDir`函数，`os.ReadDir`本质上也只是对`*os.File.ReadDir`的一层简单封装。



```
// n < 0时，则读取文件夹下所有的内容
func (f *File) ReadDir(n int) ([]DirEntry, error)
```



```
func main() {
   // 当前目录
   dir, err := os.Open(".")
   if err != nil {
      fmt.Println(err)
   }
   defer dir.Close()
   dirs, err := dir.ReadDir(-1)
   if err != nil {
      fmt.Println(err)
   } else {
      for _, entry := range dirs {
         fmt.Println(entry.Name())
      }
   }
}
```

##### [创建](https://golang.halfiisland.com/essential/senior/100.io.html#创建)

创建文件夹操作会用到`os`包下的两个函数



```
// 用指定的权限创建指定名称的目录
func Mkdir(name string, perm FileMode) error

// 相较于前者该函数会创建一切必要的父目录
func MkdirAll(path string, perm FileMode) error
```

示例如下



```
func main() {
  err := os.Mkdir("src", 0666)
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println("创建成功")
  }
}
```

##### [复制](https://golang.halfiisland.com/essential/senior/100.io.html#复制-1)

我们可以自己写函数递归遍历整个文件夹，不过`filepath`标准库已经提供了类似功能的函数，所以可以直接使用，一个简单的文件夹复制的代码示例如下。

```
func CopyDir(src, dst string) error {
    // 检查源文件夹的状态
  _, err := os.Stat(src)
  if err != nil {
    return err
  }

  return filepath.Walk(src, func(path string, info fs.FileInfo, err error) error {
    if err != nil {
      return err
    }

        // 计算相对路径
    rel, err := filepath.Rel(src, path)
    if err != nil {
      return err
    }

        // 拼接目标路径
    destpath := filepath.Join(dst, rel)

        // 创建文件夹
    var dirpath string
    var mode os.FileMode = 0755
    if info.IsDir() {
      dirpath = destpath
      mode = info.Mode()
    } else if info.Mode().IsRegular() {
      dirpath = filepath.Dir(destpath)
    }

    if err := os.MkdirAll(dirpath, mode); err != nil {
      return err
    }

        // 创建文件
    if info.Mode().IsRegular() {
      srcfile, err := os.Open(path)
      if err != nil {
        return err
      }
            // 一定要记得关闭文件
      defer srcfile.Close()
      destfile, err := os.OpenFile(destpath, os.O_RDWR|os.O_CREATE|os.O_TRUNC, info.Mode())
      if err != nil {
        return err
      }
      defer destfile.Close()

            // 复制文件内容
      if _, err := io.Copy(destfile, srcfile); err != nil {
        return err
      }
      return nil
    }

    return nil
  })
}
```

`filepath.Walk`会递归遍历整个文件夹，在过程中，遇到文件夹就创建文件夹，遇到文件就创建新文件并复制，代码相比复制文件有点多但算不上复杂。

## 类型系统与抽象设计

### 结构体

Golang中的结构(struct)是一种用户定义的类型，允许将可能不同类型的项分组/组合成单个类型。任何现实世界中拥有一组属性/字段的实体都可以表示为结构。这个概念通常与面向对象编程中的类进行比较。它可以被称为不支持继承但支持组合的轻量级类。

例如，一个地址具有name,street,city,state,Pincode。如下所示，将这三个属性组合为一个结构*Address*是有意义的。

**声明结构：**

```
 type Address struct {
      name string 
      street string
      city string
      state string
      Pincode int
}
```

在上面，***type***关键字引入了一个新类型。其后是类型的名称（*Address*）和关键字*struct，*以说明我们正在定义结构。该结构包含花括号内各个字段的列表。每个字段都有一个名称和类型。

**注意：**我们还可以通过组合相同类型的各个字段来使它们紧凑，如下例所示：

```
type Address struct {
    name, street, city, state string
    Pincode int
}
```

**定义结构：**声明结构的语法：

```
var a Address
```

上面的代码创建一个*Address类型*的变量，默认情况下将其设置为零。对于结构，零表示所有字段均设置为其对应的零值。因此，字段name,street,city,state都设置为“”，而Pincode设置为0。

您还可以*使用结构字面量来初始化结构类型的变量，*如下所示：

```
var a = Address{"Akshay", "PremNagar", "Dehradun", "Uttarakhand", 252636}
```

**注意：**

始终以在结构中声明它们的顺序传递字段值。同样，您不能仅使用上述语法初始化字段的子集。

Go还支持*名称：value*语法，用于初始化结构（使用此语法时字段的顺序无关紧要）。而且，这仅允许您初始化字段的子集。所有未初始化的字段均设置为其相应的零值。

*例如：*

```
var a = Address{"Akshay", "PremNagar", "Dehradun", "Uttarakhand", 252636}
```

要访问*结构的*各个字段，您必须使用点*（.）*运算符。Golang中的指针是一个变量，用于存储另一个变量的内存地址。您还可以创建一个指向结构的指针。

```go
// 指向结构体的指针
package main 
  
import "fmt"
  
// 定义一个结构
type Employee struct { 
    firstName, lastName string 
    age, salary int
} 
  
func main() { 
  
        //传递struct变量的地址
        // emp8是指向Employee结构的指针
    emp8 := &Employee{"Sam", "Anderson", 55, 6000} 
  
        //（* emp8）.firstName是要访问的语法
        // emp8结构的firstName字段
    fmt.Println("First Name:", (*emp8).firstName) 
    fmt.Println("Age:", (*emp8).age) 
}
```

Golang中的结构或struct是用户定义的类型，它允许我们在一个单元中创建一组不同类型的元素。任何具有一组属性或字段的真实实体都可以表示为结构。这个概念通常与面向对象编程中的类进行比较。它可以被称为轻量级类，不支持继承，但支持组合。

在Go语言中，可以通过**==运算符**或**DeeplyEqual()方法**比较两个结构相同的类型并包含相同的字段值的结构。如果结构彼此相等（就其字段值而言），则运算符和方法均返回true；否则，返回false。并且，如果比较的变量属于不同的结构，则编译器将给出错误。让我们借助示例来讨论这个概念：

**注意：** DeeplyEqual()方法在“ reflect”包下定义。

```go
package main

import (
	"fmt"
	"reflect"
)

type Person struct {
	Name string
	Age  int
}

type Student struct {
	Name   string
	Scores []int
}

func main() {
	// ----------------------------
	// 1. 结构体字段都可比较：可以用 ==
	// ----------------------------
	p1 := Person{Name: "Tom", Age: 20}
	p2 := Person{Name: "Tom", Age: 20}
	p3 := Person{Name: "Jack", Age: 20}

	fmt.Println("p1 == p2:", p1 == p2)
	fmt.Println("p1 == p3:", p1 == p3)

	fmt.Println("DeepEqual(p1, p2):", reflect.DeepEqual(p1, p2))
	fmt.Println("DeepEqual(p1, p3):", reflect.DeepEqual(p1, p3))

	fmt.Println()

	// ----------------------------
	// 2. 结构体含有 slice：不能用 ==
	// ----------------------------
	s1 := Student{Name: "Alice", Scores: []int{90, 80, 70}}
	s2 := Student{Name: "Alice", Scores: []int{90, 80, 70}}
	s3 := Student{Name: "Alice", Scores: []int{90, 80}}

	// 下面这句不能写，会报错：
	// fmt.Println(s1 == s2)

	fmt.Println("DeepEqual(s1, s2):", reflect.DeepEqual(s1, s2))
	fmt.Println("DeepEqual(s1, s3):", reflect.DeepEqual(s1, s3))
}

p1 == p2: true
p1 == p3: false
DeepEqual(p1, p2): true
DeepEqual(p1, p3): false

DeepEqual(s1, s2): true
DeepEqual(s1, s3): false

```

#### 结构体嵌套

[结构](https://www.cainiaojc.com/golang/go-structures.html)在Golang中是一个用户定义的类型，它允许我们在一个单元中创建一组不同类型的元素。任何具有一组属性或字段的真实实体都可以表示为结构。Go语言允许嵌套结构。一个结构是另一个结构的字段，称为嵌套结构。换句话说，另一个结构中的结构称为嵌套结构。

**语法：**

```
type struct_name_1 struct{
  // Fields
} 
type struct_name_2 struct{
  variable_name  struct_name_1

}
```

#### 匿名结构

##### 匿名结构体

在Go语言中，允许您创建匿名结构。匿名结构是不包含名称的结构。当您要创建一次性可用结构时，它很有用。您可以使用以下语法创建匿名结构：

```
variable_name := struct{
// fields
}{// Field_values}
```

##### 匿名字段

在Go结构中，允许创建匿名字段。匿名字段是那些不包含任何名称的字段，你只需要提到字段的类型，然后Go就会自动使用该类型作为字段的名称。您可以使用以下语法创建结构的匿名字段:

```
type struct_name struct{
    int
    bool
    float64
}
```

**重要事项：**

- 在结构中，不允许创建两个或多个相同类型的字段，如下所示：

  ```
  type student struct{
  int
  int
  }
  ```

  如果尝试这样做，则编译器将抛出错误。

- 允许将匿名字段与命名字段组合，如下所示：

  ```
  type student struct{
   name int
   price int
   string
  }
  ```

- 让我们借助一个示例来讨论匿名字段概念：

- 示例

  ```
  package main 
    
  import "fmt"
    
  //创建一个结构匿名字段 
  type student struct { 
      int
      string 
      float64 
  } 
    
  // Main function 
  func main() { 
    
      // 将值分配给匿名,学生结构的字段
      value := student{123, "Bud", 8900.23} 
    
      fmt.Println("入学人数 : ", value.int) 
      fmt.Println("学生姓名 : ", value.string) 
      fmt.Println("套餐价格 : ", value.float64) 
  }
  ```

#### 函数字段

Golang中的结构或struct是用户定义的类型，它允许我们在一个单元中创建一组不同类型的元素。任何具有一组属性或字段的真实实体都可以表示为结构。我们知道在Go语言中函数也是用户定义的类型，所以你可以在Go结构中创建一个函数字段。您还可以使用匿名函数在Go结构中创建一个函数字段，如示例2所示。

**语法：**

```
type function_name func()
type strcut_name struct{
  var_name  function_name
}
```

让我们借助示例来讨论这个概念：

示例

```
//作为Go结构中的字段
package main 
  
import "fmt"
  
// Finalsalary函数类型
type Finalsalary func(int, int) int
  
//创建结构
type Author struct { 
    name      string 
    language  string 
    Marticles int
    Pay       int
  
    //函数作为字段
    salary Finalsalary 
} 
  
func main() { 
  
    // 初始化字段结构
    result := Author{ 
        name:      "Sonia", 
        language:  "Java", 
        Marticles: 120, 
        Pay:       500, 
        salary: func(Ma int, pay int) int { 
            return Ma * pay 
        }, 
    } 
  
    fmt.Println("作者姓名: ", result.name) 
    fmt.Println("语言: ", result.language) 
    fmt.Println("五月份发表的文章总数: ", result.Marticles) 
    fmt.Println("每篇报酬: ", result.Pay) 
    fmt.Println("总工资: ", result.salary(result.Marticles, result.Pay)) 
}
```

**输出：**

```
作者姓名:  Sonia
语言:  Java
五月份发表的文章总数:  120
每篇报酬:  500
总工资:  60000
```

### 方法

Go语言支持方法。Go方法与Go函数相似，但有一点不同，就是方法中包含一个接收者参数。在接收者参数的帮助下，该方法可以访问接收者的属性。在这里，接收方可以是结构类型或非结构类型。在代码中创建方法时，接收者和接收者类型必须出现在同一个包中。而且不允许创建一个方法，其中的接收者类型已经在另一个包中定义，包括像int、string等内建类型。如果您尝试这样做，那么编译器将抛出错误。

**语法：**

```
func(reciver_name Type) method_name(parameter_list)(return_type){
    // Code
}
```

在此，可以在方法内访问接收器。

#### 结构类型接收器的方法

在Go语言中，允许您定义其接收者为结构类型的方法。可以在方法内部访问此接收器，如以下示例所示：

示例

```
package main 
  
import "fmt"
  
//Author 结构体
type author struct { 
    name      string 
    branch    string 
    particles int
    salary    int
} 
  
//接收者的方法 
func (a author) show() { 
  
    fmt.Println("Author's Name: ", a.name) 
    fmt.Println("Branch Name: ", a.branch) 
    fmt.Println("Published articles: ", a.particles) 
    fmt.Println("Salary: ", a.salary) 
} 
  
func main() { 
  
    //初始化值
    //Author结构体
    res := author{ 
        name:      "Sona", 
        branch:    "CSE", 
        particles: 203, 
        salary:    34000, 
    } 
  
    //调用方法
    res.show() 
}
```

**输出：**

```
Author's Name:  Sona
Branch Name:  CSE
Published articles:  203
Salary:  34000
```

#### 非结构类型接收器的方法

在Go语言中，只要类型和方法定义存在于同一包中，就可以使用非结构类型接收器创建方法。如果它们存在于int，string等不同的包中，则编译器将抛出错误，因为它们是在不同的包中定义的。

示例

```
package main 
  
import "fmt"
  
//类型定义
type data int

//定义一个方法
//非结构类型的接收器 
func (d1 data) multiply(d2 data) data { 
    return d1 * d2 
} 
  
/* 
//如果您尝试运行此代码，

//然后编译器将抛出错误 
func(d1 int)multiply(d2 int)int{ 
return d1 * d2 
} 
*/
  
func main() { 
    value1 := data(23) 
    value2 := data(20) 
    res := value1.multiply(value2) 
    fmt.Println("最终结果: ", res) 
}
```

**输出：**

```
最终结果:  460
```

#### 带指针接收器的Go方法

在Go语言中，允许您使用**指针**接收器创建方法。在指针接收器的帮助下，如果方法中所做的更改将反映在调用方中，这对于值接收器是不可能的。

**语法：**

```
func (p *Type) method_name(...Type) Type {
    // Code
}
```

示例

```
package main 
  
import "fmt"
  
// Author 结构体
type author struct { 
    name      string 
    branch    string 
    particles int
} 
  
//方法，使用author类型的接收者
func (a *author) show(abranch string) { 
    (*a).branch = abranch 
} 
  
// Main function 
func main() { 
  
    //初始化author结构体
    res := author{ 
        name:   "Sona", 
        branch: "CSE", 
    } 
  
    fmt.Println("Author's name: ", res.name) 
    fmt.Println("Branch Name(Before): ", res.branch) 
  
    //创建一个指针
    p := &res 
  
    //调用show方法
    p.show("ECE") 
    fmt.Println("Author's name: ", res.name) 
    fmt.Println("Branch Name(After): ", res.branch) 
}
```

**输出：**

```
Author's name:  Sona
Branch Name(Before):  CSE
Author's name:  Sona
Branch Name(After):  ECE
```

#### 指针参数与值参数的自动转换

众所周知，在Go中，当一个函数具有值参数时，它将仅接受参数的值，如果您尝试将指针传递给值函数，则它将不接受，反之亦然。但是Go方法可以接受值和指针，无论它是使用指针还是值接收器定义的。如下例所示：

示例

```
package main 
  
import "fmt"
  
// Author 结构体
type author struct { 
    name   string 
    branch string 
} 
  
//带有指针的方法
//author类型的接收者
func (a *author) show_1(abranch string) { 
    (*a).branch = abranch 
} 
  
//带有值的方法
//作者类型的接收者 
func (a author) show_2() { 
    a.name = "Gourav"
    fmt.Println("Author's name(Before) : ", a.name) 
} 
  

func main() { 
  
     //初始化值
     //作者结构体
    res := author{ 
        name:   "Sona", 
        branch: "CSE", 
    } 
  
    fmt.Println("Branch Name(Before): ", res.branch) 
  
     //调用show_1方法
     //（指针方法）带有值
    res.show_1("ECE") 
    fmt.Println("Branch Name(After): ", res.branch) 
  
     //调用show_2方法
     //带有指针的（值方法）
    (&res).show_2() 
    fmt.Println("Author's name(After): ", res.name) 
}
```

**输出：**

```
Branch Name(Before):  CSE
Branch Name(After):  ECE
Author's name(Before) :  Gourav
Author's name(After):  Sona
```

#### 同名方法

在Go语言中，允许在同一包中创建两个或多个具有相同名称的方法，但是这些方法的接收者**必须具有不同的类型**。该功能在Go函数中不可用，这意味着不允许您在同一包中创建相同名称的方法，如果尝试这样做，则编译器将抛出错误。

**语法：**

```
func(reciver_name_1 Type) method_name(parameter_list)(return_type){
    // Code
}

func(reciver_name_2 Type) method_name(parameter_list)(return_type){
    // Code
}
```

### 接口

Go语言接口不同于其他语言。在Go语言中，该接口是一种自定义类型，用于指定一组一个或多个方法签名，并且该接口是抽象的，因此不允许您创建该接口的实例。但是您可以创建接口类型的变量，并且可以为该变量分配具有接口所需方法的具体类型值。换句话说，接口既是方法的集合，也是自定义类型。

#### 接口创建

在Go语言中，您可以使用以下语法创建接口：

```
type interface_name interface{

    //方法签名
}
```

**例如：**

```
//创建一个接口
type myinterface interface{
    // 方法
    fun1() int
    fun2() float64
}
```

此处，接口名称包含在type和interface关键字之间，方法签名包含在花括号之间。

#### 接口实现

在Go语言中，为了实现接口，必须实现接口中声明的所有方法。go语言接口是隐式实现的。与其他语言一样，它不包含实现接口的任何特定关键字。如下例所示:

![img](https://www.cainiaojc.com/run/images/Untitled-Diagram47.jpg)

示例

```
// Golang程序说明如何
//实现接口
package main

import "fmt"

//创建一个接口
type tank interface {

    // 方法
    Tarea() float64
    Volume() float64
}

type myvalue struct {
    radius float64
    height float64
}

//实现方法
//桶的（Tank）接口
func (m myvalue) Tarea() float64 {

    return 2*m.radius*m.height + 2*3.14*m.radius*m.radius
}

func (m myvalue) Volume() float64 {

    return 3.14 * m.radius * m.radius * m.height
}

func main() {

    // 访问使用桶的接口
    var t tank
    t = myvalue{10, 14}
    fmt.Println("桶的面积 :", t.Tarea())
    fmt.Println("桶的容量:", t.Volume())
}
```

**输出：**

```
桶的面积 : 908
桶的容量: 4396
```

**注意事项**

- 接口的零值为nil。

- 当接口包含零个方法时，此类接口称为空接口。因此，所有类型都实现空接口。

  **语法：**

  ```
  interface{}
  ```

- **接口类型：**该接口有两种类型，一种是静态的，另一种是动态的。静态类型是接口本身，例如下面示例中的tank。但是接口没有静态值，所以它总是指向动态值。
  接口类型的变量，其中包含实现接口的类型的值，因此该类型的值称为动态值，而该类型是动态类型。又称具体值和具体类型。

  ```
  //说明Go程序的概念
  //动态值和类型
  package main
  
  import "fmt"
  
  //创建接口
  type tank interface {
  
      // 方法
      Tarea() float64
      Volume() float64
  }
  
  func main() {
  
      var t tank
      fmt.Println("tank interface值为: ", t)
      fmt.Printf("tank 的类型是: %T ", t)
  }
  ```

  **输出：**

  ```
  tank interface值为:  <nil>
  tank 的类型是: <nil>
  ```

  在上面的示例中，有一个名为tank的接口。在此示例中，*fmt.Println("tank interface值为: ", t)* 语句返回该接口的动态值，而 fmt.Printf("tank 的类型是: %T ", t) 语句返回该接口的动态类型，即nil，因为这里的接口不知道谁在实现它。

- **类型断言：**在Go语言中，类型断言是应用于接口值的操作。换句话说，类型断言是提取接口值的过程。

  **语法：**

  ```
  a.(T)
  ```

  在这里，a是接口的值或表达式，T是也称为类型断言的类型。类型断言用于检查其操作数的动态类型是否匹配已断言的类型。如果T是具体类型，则类型断言检查a的给定动态类型是否等于T，这里，如果检查成功进行，则类型断言返回a的动态值。否则，如果检查失败，则操作将出现panic异常。如果T是接口类型，则类型断言检查满足T的给定动态类型，这里，如果检查成功进行，则不提取动态值。

  示例

  ```
  //类型断言 
  package main 
    
  import "fmt"
    
  func myfun(a interface{}) { 
    
      //提取a的值
      val := a.(string) 
      fmt.Println("值为: ", val) 
  } 
  func main() { 
    
      var val interface { 
      } = "cainiaojc"
        
      myfun(val) 
  }
  ```

  **输出：**

  ```
  值为:  cainiaojc
  ```

  在上面的示例中，如果将*val：= a。（string）*语句更改为*val：= a。（int）*，则程序会抛出panic异常。因此，为了避免此问题，我们使用以下语法：

  ```
  value, ok := a.(T)
  ```

  在这里，如果a的类型等于T，则该值包含a的动态值，并且ok将设置为true。并且如果a的类型不等于T，则ok设置为false并且value包含零值，并且程序不会抛出panic异常。如下面的程序所示：

  示例

  ```
  package main
  
  import "fmt"
  
  func myfun(a interface{}) {
      value, ok := a.(float64)
      fmt.Println(value, ok)
  }
  func main() {
  
      var a1 interface {
      } = 98.09
  
      myfun(a1)
  
      var a2 interface {
      } = "cainiaojc"
  
      myfun(a2)
  }
  ```

  **输出：**

  ```
  98.09 true
  0 false
  ```

- **类型判断：**在Go接口中，类型判断用于将接口的具体类型与case语句中提供的多种类型进行比较。它与类型声明类似，只是有一个区别，即大小写指定类型，而不是值。您还可以将类型与接口类型进行比较。如下例所示：

  示例

  ```
  package main
  
  import "fmt"
  
  func myfun(a interface{}) {
  
      //使用类型判断
      switch a.(type) {
  
      case int:
          fmt.Println("类型: int，值:", a.(int))
      case string:
          fmt.Println("\n类型: string，值: ", a.(string))
      case float64:
          fmt.Println("\n类型: float64，值: ", a.(float64))
      default:
          fmt.Println("\n类型未找到")
      }
  }
  ```

  **输出：**

  ```
  类型: string，值:  cainiaojc
  
  类型: float64，值:  67.9
  
  类型未找到
  ```

- **接口的使用：**当您想要在其中传递不同类型的参数的方法或函数中时，可以使用接口，就像Println()函数一样。或者，当多种类型实现同一接口时，也可以使用接口。

#### 多接口实现

在Go语言中，接口是方法签名的集合，它也是一种类型，意味着您可以创建接口类型的变量。在Go语言中，您可以借助给定的语法在程序中创建多个接口：

```
type interface_name interface{

//方法签名

}
```

**注意：**在Go语言中，不允许在两个或多个接口中创建相同的名称方法。如果尝试这样做，则您的程序将崩溃。让我们借助示例来讨论多个接口。

示例

```
//多个接口的概念
package main

import "fmt"

// 接口 1
type AuthorDetails interface {
    details()
}

// 接口 2
type AuthorArticles interface {
    articles()
}

// 结构体
type author struct {
    a_name    string
    branch    string
    college   string
    year      int
    salary    int
    particles int
    tarticles int
}

//实现接口方法1
func (a author) details() {

    fmt.Printf("作者: %s", a.a_name)
    fmt.Printf("\n部分: %s 通过日期: %d", a.branch, a.year)
    fmt.Printf("\n学校名称: %s", a.college)
    fmt.Printf("\n薪水: %d", a.salary)
    fmt.Printf("\n出版文章数: %d", a.particles)

}

// 实现接口方法 2
func (a author) articles() {

    pendingarticles := a.tarticles - a.particles
    fmt.Printf("\n待定文章: %d", pendingarticles)
}

// Main value
func main() {

    //结构体赋值
    values := author{
        a_name:    "Mickey",
        branch:    "Computer science",
        college:   "XYZ",
        year:      2012,
        salary:    50000,
        particles: 209,
        tarticles: 309,
    }

    // 访问使用接口1的方法
    var i1 AuthorDetails = values
    i1.details()

    //访问使用接口2的方法
    var i2 AuthorArticles = values
    i2.articles()

}
```

**输出：**

```
作者: Mickey
部分: Computer science 通过日期: 2012
学校名称: XYZ
薪水: 50000
出版文章数: 209
待定文章: 100
```

**用法解释：**如上例所示，我们有两个带有方法的接口，即details()和Articles()。在这里，details()方法提供了作者的基本详细信息，而articles()方法提供了作者的待定文章。

![img](https://www.cainiaojc.com/run/images/Untitled-Diagram48.jpg)

还有一个名为作者(Author)的结构，其中包含一些变量集，其值在接口中使用。在主要方法中，我们在作者结构中分配存在的变量的值，以便它们将在接口中使用并创建接口类型变量以访问*AuthorDetails*和*AuthorArticles*接口的方法。

#### 接口嵌套

在Go语言中，接口是方法签名的集合，它也是一种类型，意味着您可以创建接口类型的变量。众所周知，Go语言不支持继承，但是Go接口完全支持嵌套。在嵌套过程中，一个接口可以嵌套其他接口，或者一个接口可以在其中嵌套其他接口的方法签名，两者的结果与示例1和2中所示的相同。您可以在单个接口中嵌套任意数量的接口。而且，如果对接口的方法进行了任何更改，则在将一个接口嵌套其他接口时，该接口也将反映在嵌套式接口中，如示例3所示。

**语法：**

```
type interface_name1 interface {

    Method1()
}

type interface_name2 interface {

    Method2()
}

type finalinterface_name interface {

    interface_name1
    interface_name2
}

或

type interface_name1 interface {

    Method1()
}

type interface_name2 interface {

    Method2()
}

type finalinterface_name interface {

    Method1()
    Method2()
}
```

```
package main

import "fmt"

// 接口 1
type AuthorDetails interface {
    details()
}

// 接口 2
type AuthorArticles interface {
    articles()
    picked()
}

// 接口 3
//接口3嵌套了接口1和接口2，同时加入了自己的方法
type FinalDetails interface {
    details()
    AuthorArticles
    cdeatils()
}

// author 结构体
type author struct {
    a_name    string
    branch    string
    college   string
    year      int
    salary    int
    particles int
    tarticles int
    cid       int
    post      string
    pick      int
}

// 实现接口1的方法
func (a author) details() {

    fmt.Printf("作者: %s", a.a_name)
    fmt.Printf("\n部门: %s 通过日期: %d", a.branch, a.year)
    fmt.Printf("\n大学名称: %s", a.college)
    fmt.Printf("\n薪水: %d", a.salary)
    fmt.Printf("\n发表文章数: %d", a.particles)
}

// 实现接口2的方法
func (a author) articles() {

    pendingarticles := a.tarticles - a.particles
    fmt.Printf("\n待定文章数: %d", pendingarticles)
}

func (a author) picked() {

    fmt.Printf("\n所选文章的总数: %d", a.pick)
}

// 实现嵌入了接口的方法
func (a author) cdeatils() {

    fmt.Printf("\n作者Id: %d", a.cid)
    fmt.Printf("\n提交: %s", a.post)
}

func main() {

    //结构体赋值
    values := author{

        a_name:    "Mickey",
        branch:    "Computer science",
        college:   "XYZ",
        year:      2012,
        salary:    50000,
        particles: 209,
        tarticles: 309,
        cid:       3087,
        post:      "Technical content writer",
        pick:      58,
    }

    // 使用 FinalDetails 接口访问接口1，2的方法
    var f FinalDetails = values
    f.details()
    f.articles()
    f.picked()
    f.cdeatils()
}
```

**输出：**

```
作者: Mickey
部门: Computer science 通过日期: 2012
大学名称: XYZ
薪水: 50000
发表文章数: 209
待定文章数: 100
所选文章的总数: 58
作者Id: 3087
提交: Technical content writer
```



### 泛型

泛型是 Go 语言在 1.18 版本中引入的重要特性，它让开发者能够编写更加灵活和可重用的代码。

泛型主要通过以下两个核心概念来实现：

- **类型参数（Type Parameters）：**允许你在函数或类型定义中使用一个或多个类型作为参数。
- **类型约束（Type Constraints）：**指定类型参数必须满足的条件，确保在函数内部可以安全地操作这些类型。

| 概念             | 作用                                                 | 示例                                                 |
| :--------------- | :--------------------------------------------------- | :--------------------------------------------------- |
| **类型参数**     | 在函数或类型名后声明，表示待定的类型。               | `[T any]`                                            |
| **类型约束**     | 定义类型参数必须满足的条件（如支持的操作符或方法）。 | `int，float64，comparable，constraints.Ordered，any` |
| **`any`**        | 约束类型参数为**任何**类型。                         | `[T any]`                                            |
| **`comparable`** | 约束类型参数为**可比较**的类型。                     | `[K comparable]`                                     |

泛型（Generics）允许我们编写不依赖特定数据类型的代码。

在引入泛型之前，如果我们想要处理不同类型的数据，通常需要为每种类型编写重复的函数。

#### 类型参数

泛型函数和类型通过类型参数列表来声明，语法为 `[类型参数 约束]`。

```
// 基本语法结构
func 函数名[T 约束](参数 T) 返回值类型 {
    // 函数体
}

type 类型名[T 约束] struct {
    // 结构体字段
}
```

**类型参数命名约定**

- 通常使用大写字母：`T`、`K`、`V`、`E` 等
- `T`：表示 Type（类型）
- `K`：表示 Key（键）
- `V`：表示 Value（值）
- `E`：表示 Element（元素）

#### 类型约束

约束定义了类型参数必须满足的条件，是泛型的核心概念。

**内置约束**

* **`any` 约束**:`any` 是空接口 `interface{}` 的别名，表示任何类型都可以。

* **`comparable` 约束**:`comparable` 表示类型支持 `==` 和 `!=` 操作符。
* **联合约束(Union Constraints)**：使用 `|` 运算符组合多个类型。

```
func PrintAny[T any](value T) {
    fmt.Printf("Value: %v, Type: %T\n", value, value)
}

// 使用示例
PrintAny(42)        // Value: 42, Type: int
PrintAny("hello")   // Value: hello, Type: string
PrintAny(3.14)      // Value: 3.14, Type: float64



func FindIndex[T comparable](slice []T, target T) int {
    for i, v := range slice {
        if v == target {
            return i
        }
    }
    return -1
}

// 使用示例
numbers := []int{1, 2, 3, 4, 5}
fmt.Println(FindIndex(numbers, 3))  // 输出: 2

names := []string{"Alice", "Bob", "Charlie"}
fmt.Println(FindIndex(names, "Bob"))  // 输出: 1


// 数字类型约束
type Number interface {
    int | int8 | int16 | int32 | int64 | 
    uint | uint8 | uint16 | uint32 | uint64 | 
    float32 | float64
}

func Add[T Number](a, b T) T {
    return a + b
}

// 使用示例
fmt.Println(Add(10, 20))        // 输出: 30
fmt.Println(Add(3.14, 2.71))    // 输出: 5.85
```

**自定义约束**

* **方法约束**：定义需要特定方法的约束。
* **复杂约束**：结合类型和方法要求。

```
// 定义 Stringer 约束
type Stringer interface {
    String() string
}

func PrintString[T Stringer](value T) {
    fmt.Println(value.String())
}

// 实现自定义类型
type Person struct {
    Name string
    Age  int
}

func (p Person) String() string {
    return fmt.Sprintf("%s (%d years old)", p.Name, p.Age)
}

// 使用示例
person := Person{Name: "Alice", Age: 25}
PrintString(person)  // 输出: Alice (25 years old)


// 要求类型是数字且实现 String() 方法
type NumericStringer interface {
    Number
    String() string
}
```

#### 泛型类型

**泛型结构体**

```
// 泛型栈实现
type Stack[T any] struct {
    elements []T
}

// 入栈
func (s *Stack[T]) Push(value T) {
    s.elements = append(s.elements, value)
}

// 出栈
func (s *Stack[T]) Pop() (T, bool) {
    if len(s.elements) == 0 {
        var zero T
        return zero, false
    }
    
    lastIndex := len(s.elements) - 1
    value := s.elements[lastIndex]
    s.elements = s.elements[:lastIndex]
    return value, true
}

// 查看栈顶元素
func (s *Stack[T]) Peek() (T, bool) {
    if len(s.elements) == 0 {
        var zero T
        return zero, false
    }
    return s.elements[len(s.elements)-1], true
}

// 判断栈是否为空
func (s *Stack[T]) IsEmpty() bool {
    return len(s.elements) == 0
}

// 使用示例
func main() {
    // 整数栈
    intStack := Stack[int]{}
    intStack.Push(1)
    intStack.Push(2)
    intStack.Push(3)
    
    fmt.Println(intStack.Pop())  // 输出: 3 true
    
    // 字符串栈
    stringStack := Stack[string]{}
    stringStack.Push("hello")
    stringStack.Push("world")
    
    fmt.Println(stringStack.Pop())  // 输出: world true
}
```

**泛型映射（Map）**

```
// 线程安全的泛型映射
type SafeMap[K comparable, V any] struct {
    data map[K]V
    mutex sync.RWMutex
}

// 创建新的 SafeMap
func NewSafeMap[K comparable, V any]() *SafeMap[K, V] {
    return &SafeMap[K, V]{
        data: make(map[K]V),
    }
}

// 设置键值对
func (m *SafeMap[K, V]) Set(key K, value V) {
    m.mutex.Lock()
    defer m.mutex.Unlock()
    m.data[key] = value
}

// 获取值
func (m *SafeMap[K, V]) Get(key K) (V, bool) {
    m.mutex.RLock()
    defer m.mutex.RUnlock()
    value, exists := m.data[key]
    return value, exists
}

// 删除键
func (m *SafeMap[K, V]) Delete(key K) {
    m.mutex.Lock()
    defer m.mutex.Unlock()
    delete(m.data, key)
}

// 获取所有键
func (m *SafeMap[K, V]) Keys() []K {
    m.mutex.RLock()
    defer m.mutex.RUnlock()
    
    keys := make([]K, 0, len(m.data))
    for key := range m.data {
        keys = append(keys, key)
    }
    return keys
}

// 使用示例
func main() {
    // 创建字符串到整数的映射
    scores := NewSafeMap[string, int]()
    scores.Set("Alice", 95)
    scores.Set("Bob", 87)
    
    if score, exists := scores.Get("Alice"); exists {
        fmt.Printf("Alice's score: %d\n", score)  // 输出: Alice's score: 95
    }
    
    fmt.Println("Keys:", scores.Keys())  // 输出: Keys: [Alice Bob]
}
```

## 并发与网络编程

### 并发

#### [协程](https://golang.halfiisland.com/essential/senior/110.concurrency.html#协程)

协程（coroutine）是一种轻量级的线程，或者说是用户态的线程，不受操作系统直接调度，由 Go 语言自身的调度器进行运行时调度，因此上下文切换开销非常小，这也是为什么 Go 的并发性能很不错的原因之一。协程这一概念并非 Go 首次提出，Go 也不是第一个支持协程的语言，但 Go 是第一个能够将协程和并发支持的相当简洁和优雅的语言。

在 Go 中，创建一个协程十分的简单，仅需要一个 `go` 关键字，就能够快速开启一个协程，`go` 关键字后面必须是一个函数调用。例子如下

提示

具有返回值的内置函数不允许跟随在 `go` 关键字后面，例如下面的错误示范



```
go make([]int,10) //  go discards result of make([]int, 10) (value of type []int)
```



```
func main() {
  go fmt.Println("hello world!")
  go hello()
  go func() {
    fmt.Println("hello world!")
  }()
}

func hello() {
  fmt.Println("hello world!")
}
```

以上三种开启协程的方式都是可以的，但是其实这个例子执行过后在大部分情况下什么都不会输出，协程是并发执行的，系统创建协程需要时间，而在此之前，主协程早已运行结束，一旦主线程退出，其他子协程也就自然退出了。并且协程的执行顺序也是不确定的，无法预判的，例如下面的例子



```
func main() {
  fmt.Println("start")
  for i := 0; i < 10; i++ {
    go fmt.Println(i)
  }
  fmt.Println("end")
}
```

这是一个在循环体中开启协程的例子，永远也无法精准的预判到它到底会输出什么。可能子协程还没开始运行，主协程就已经结束了，情况如下



```
start
end
```

又或者只有一部分子协程在主协程退出前成功运行，情况如下



```
start
0
1
5
3
4
6
7
end
```

最简单的做法就是让主协程等一会儿，需要使用到 `time` 包下的 `Sleep` 函数，可以使当前协程暂停一段时间，例子如下



```
func main() {
  fmt.Println("start")
  for i := 0; i < 10; i++ {
    go fmt.Println(i)
  }
    // 暂停1ms
  time.Sleep(time.Millisecond)
  fmt.Println("end")
}
```

再次执行输出如下，可以看到所有的数字都完整输出了，没有遗漏



```
start
0
1
5
2
3
4
6
8
9
7
end
```

但是顺序还是乱的，因此让每次循环都稍微的等一下。例子如下



```
func main() {
   fmt.Println("start")
   for i := 0; i < 10; i++ {
      go fmt.Println(i)
      time.Sleep(time.Millisecond)
   }
   time.Sleep(time.Millisecond)
   fmt.Println("end")
}
```

现在的输出已经是正常的顺序了



```
start
0
1
2
3
4
5
6
7
8
9
end
```

上面的例子中结果输出很完美，那么并发的问题解决了吗，不，一点也没有。对于并发的程序而言，不可控的因素非常多，执行的时机，先后顺序，执行过程的耗时等等，倘若循环中子协程的工作不只是一个简单的输出数字，而是一个非常巨大复杂的任务，耗时的不确定的，那么依旧会重现之前的问题。例如下方代码



```
func main() {
   fmt.Println("start")
   for i := 0; i < 10; i++ {
      go hello(i)
      time.Sleep(time.Millisecond)
   }
   time.Sleep(time.Millisecond)
   fmt.Println("end")
}

func hello(i int) {
   // 模拟随机耗时
   time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
   fmt.Println(i)
}
```

这段代码的输出依旧是不确定的，下面是可能的情况之一



```
start
0
3
4
end
```

因此 `time.Sleep` 并不是一种良好的解决办法，幸运的是 Go 提供了非常多的并发控制手段，常用的并发控制方法有三种：

- `channel`：管道
- `WaitGroup`：信号量
- `Context`：上下文

三种方法有着不同的适用情况，`WaitGroup` 可以动态的控制一组指定数量的协程，`Context` 更适合子孙协程嵌套层级更深的情况，管道更适合协程间通信。对于较为传统的锁控制，Go 也对此提供了支持：

- `Mutex`：互斥锁
- `RWMutex` ：读写互斥锁

#### [管道](https://golang.halfiisland.com/essential/senior/110.concurrency.html#管道)

`channel`，译为管道，Go 对于管道的作用如下解释：

> Do not communicate by sharing memory; instead, share memory by communicating.

即通过消息来进行内存共享，`channel` 就是为此而生，它是一种在协程间通信的解决方案，同时也可以用于并发控制，先来认识下 `channel` 的基本语法。Go 中通过关键字 `chan` 来代表管道类型，同时也必须声明管道的存储类型，来指定其存储的数据是什么类型，下面的例子是一个普通管道的模样。



```
var ch chan int
```

这是一个管道的声明语句，此时管道还未初始化，其值为 `nil`，不可以直接使用。

##### [创建](https://golang.halfiisland.com/essential/senior/110.concurrency.html#创建)

在创建管道时，有且只有一种方法，那就是使用内置函数 `make`，对于管道而言，`make` 函数接收两个参数，第一个是管道的类型，第二个是可选参数为管道的缓冲大小。例子如下



```
intCh := make(chan int)
// 缓冲区大小为1的管道
strCh := make(chan string, 1)
```

在使用完一个管道后一定要记得关闭该管道，使用内置函数 `close` 来关闭一个管道，该函数签名如下。



```
func close(c chan<- Type)
```

一个关闭管道的例子如下



```
func main() {
  intCh := make(chan int)
  // do something
  close(intCh)
}
```

有些时候使用 `defer` 来关闭管道可能会更好。

##### [读写](https://golang.halfiisland.com/essential/senior/110.concurrency.html#读写)

对于一个管道而言，Go 使用了两种很形象的操作符来表示读写操作：

`ch <-`：表示对一个管道写入数据

`<- ch`：表示对一个管道读取数据

`<-` 很生动的表示了数据的流动方向，来看一个对 `int` 类型的管道读写的例子



```
func main() {
    // 如果没有缓冲区则会导致死锁
  intCh := make(chan int, 1)
  defer close(intCh)
    // 写入数据
  intCh <- 114514
    // 读取数据
  fmt.Println(<-intCh)
}
```

上面的例子中创建了一个缓冲区大小为 1 的 `int` 型管道，对其写入数据 `114514`，然后再读取数据并输出，最后关闭该管道。对于读取操作而言，还有第二个返回值，一个布尔类型的值，用于表示数据是否读取成功



```
ints, ok := <-intCh
```

管道中的数据流动方式与队列一样，即先进先出（FIFO），协程对于管道的操作是同步的，在某一个时刻，只有一个协程能够对其写入数据，同时也只有一个协程能够读取管道中的数据。

##### [无缓冲](https://golang.halfiisland.com/essential/senior/110.concurrency.html#无缓冲)

对于无缓冲管道而言，因为缓冲区容量为 0，所以不会临时存放任何数据。正因为无缓冲管道无法存放数据，在向管道写入数据时必须立刻有其他协程来读取数据，否则就会阻塞等待，读取数据时也是同理，这也解释了为什么下面看起来很正常的代码会发生死锁。



```
func main() {
  // 创建无缓冲管道
  ch := make(chan int)
  defer close(ch)
  // 写入数据
  ch <- 123
  // 读取数据
  n := <-ch
  fmt.Println(n)
}
```

无缓冲管道不应该同步的使用，正确来说应该开启一个新的协程来发送数据，如下例



```
func main() {
  // 创建无缓冲管道
  ch := make(chan int)
  defer close(ch)
  go func() {
    // 写入数据
    ch <- 123
  }()
  // 读取数据
  n := <-ch
  fmt.Println(n)
}
```

##### [有缓冲](https://golang.halfiisland.com/essential/senior/110.concurrency.html#有缓冲)

当管道有了缓冲区，就像是一个阻塞队列一样，读取空的管道和写入已满的管道都会造成阻塞。无缓冲管道在发送数据时，必须立刻有人接收，否则就会一直阻塞。对于有缓冲管道则不必如此，对于有缓冲管道写入数据时，会先将数据放入缓冲区里，只有当缓冲区容量满了才会阻塞的等待协程来读取管道中的数据。同样的，读取有缓冲管道时，会先从缓冲区中读取数据，直到缓冲区没数据了，才会阻塞的等待协程来向管道中写入数据。因此，无缓冲管道中会造成死锁例子在这里可以顺利运行。



```
func main() {
   // 创建有缓冲管道
   ch := make(chan int, 1)
   defer close(ch)
   // 写入数据
   ch <- 123
   // 读取数据
   n := <-ch
   fmt.Println(n)
}
```

尽管可以顺利运行，但这种同步读写的方式是非常危险的，一旦管道缓冲区空了或者满了，将会永远阻塞下去，因为没有其他协程来向管道中写入或读取数据。来看看下面的一个例子



```
func main() {
  // 创建有缓冲管道
  ch := make(chan int, 5)
  // 创建两个无缓冲管道
  chW := make(chan struct{})
  chR := make(chan struct{})
  defer func() {
    close(ch)
    close(chW)
    close(chR)
  }()
  // 负责写
  go func() {
    for i := 0; i < 10; i++ {
      ch <- i
      fmt.Println("写入", i)
    }
    chW <- struct{}{}
  }()
  // 负责读
  go func() {
    for i := 0; i < 10; i++ {
            // 每次读取数据都需要花费1毫秒
      time.Sleep(time.Millisecond)
      fmt.Println("读取", <-ch)
    }
    chR <- struct{}{}
  }()
  fmt.Println("写入完毕", <-chW)
  fmt.Println("读取完毕", <-chR)
}
```

这里总共创建了 3 个管道，一个有缓冲管道用于协程间通信，两个无缓冲管道用于同步父子协程的执行顺序。负责读的协程每次读取之前都会等待 1 毫秒，负责写的协程一口气做多也只能写入 5 个数据，因为管道缓冲区最大只有 5，在没有协程来读取之前，只能阻塞等待。所以该示例输出如下



```
写入 0
写入 1
写入 2
写入 3
写入 4 // 一下写了5个，缓冲区满了，等其他协程来读
读取 0
写入 5 // 读一个，写一个
读取 1
写入 6
读取 2
写入 7
读取 3
写入 8
写入 9
读取 4
写入完毕 {} // 所有的数据都发送完毕，写协程执行完毕
读取 5
读取 6
读取 7
读取 8
读取 9
读取完毕 {} // 所有的数据都读完了，读协程执行完毕
```

可以看到负责写的协程刚开始就一口气发送了 5 个数据，缓冲区满了以后就开始阻塞等待读协程来读取，后面就是每当读协程 1 毫秒读取一个数据，缓冲区有空位了，写协程就写入一个数据，直到所有数据发送完毕，写协程执行结束，随后当读协程将缓冲区所有数据读取完毕后，读协程也执行结束，最后主协程退出。

提示

通过内置函数 `len` 可以访问管道缓冲区中数据的个数，通过 `cap` 可以访问管道缓冲区的大小。



```
func main() {
   ch := make(chan int, 5)
   ch <- 1
   ch <- 2
   ch <- 3
   fmt.Println(len(ch), cap(ch))
}
```

输出



```
3 5
```

利用管道的阻塞条件，可以很轻易的写出一个主协程等待子协程执行完毕的例子



```
func main() {
   // 创建一个无缓冲管道
   ch := make(chan struct{})
   defer close(ch)
   go func() {
      fmt.Println(2)
      // 写入
      ch <- struct{}{}
   }()
   // 阻塞等待读取
   <-ch
   fmt.Println(1)
}
```

输出



```
2
1
```

通过有缓冲管道还可以实现一个简单的互斥锁，看下面的例子



```
var count = 0

// 缓冲区大小为1的管道
var lock = make(chan struct{}, 1)

func Add() {
    // 加锁
  lock <- struct{}{}
  fmt.Println("当前计数为", count, "执行加法")
  count += 1
    // 解锁
  <-lock
}

func Sub() {
    // 加锁
  lock <- struct{}{}
  fmt.Println("当前计数为", count, "执行减法")
  count -= 1
    // 解锁
  <-lock
}
```

由于管道的缓冲区大小为 1，最多只有一个数据存放在缓冲区中。`Add` 和 `Sub` 函数在每次操作前都会尝试向管道中发送数据，由于缓冲区大小为 1，倘若有其他协程已经写入了数据，缓冲区已经满了，当前协程就必须阻塞等待，直到缓冲区空出位置来，如此一来，在某一个时刻，最多只能有一个协程对变量 `count` 进行修改，这样就实现了一个简单的互斥锁。

##### [注意点](https://golang.halfiisland.com/essential/senior/110.concurrency.html#注意点)

下面是一些总结，以下几种情况使用不当会导致管道阻塞：

**读写无缓冲管道**

当对一个无缓冲管道直接进行同步读写操作都会导致该协程阻塞



```
func main() {
   // 创建了一个无缓冲管道
   intCh := make(chan int)
   defer close(intCh)
   // 发送数据
   intCh <- 1
   // 读取数据
   ints, ok := <-intCh
   fmt.Println(ints, ok)
}
```

**读取空缓冲区的管道**

当读取一个缓冲区为空的管道时，会导致该协程阻塞



```
func main() {
   // 创建的有缓冲管道
   intCh := make(chan int, 1)
   defer close(intCh)
   // 缓冲区为空，阻塞等待其他协程写入数据
   ints, ok := <-intCh
   fmt.Println(ints, ok)
}
```

**写入满缓冲区的管道**

当管道的缓冲区已满，对其写入数据会导致该协程阻塞



```
func main() {
  // 创建的有缓冲管道
  intCh := make(chan int, 1)
  defer close(intCh)

  intCh <- 1
    // 满了，阻塞等待其他协程来读取数据
  intCh <- 1
}
```

**管道为 `nil`**

当管道为 `nil` 时，无论怎样读写都会导致当前协程阻塞



```
func main() {
  var intCh chan int
    // 写
  intCh <- 1
}
```



```
func main() {
  var intCh chan int
    // 读
  fmt.Println(<-intCh)
}
```

关于管道阻塞的条件需要好好掌握和熟悉，大多数情况下这些问题隐藏的十分隐蔽，并不会像例子中那样直观。

以下几种情况还会导致 `panic`：

**关闭一个 `nil` 管道**

当管道为 `nil` 时，使用 `close` 函数对其进行关闭操作会导致 panic`



```
func main() {
  var intCh chan int
  close(intCh)
}
```

**写入已关闭的管道**

对一个已关闭的管道写入数据会导致 `panic`



```
func main() {
  intCh := make(chan int, 1)
  close(intCh)
  intCh <- 1
}
```

**关闭已关闭的管道**

在一些情况中，管道可能经过层层传递，调用者或许也不知道到底该由谁来关闭管道，如此一来，可能会发生关闭一个已经关闭了的管道，就会发生 `panic`。



```
func main() {
  ch := make(chan int, 1)
  defer close(ch)
  go write(ch)
  fmt.Println(<-ch)
}

func write(ch chan<- int) {
  // 只能对管道发送数据
  ch <- 1
  close(ch)
}
```

##### [单向管道](https://golang.halfiisland.com/essential/senior/110.concurrency.html#单向管道)

双向管道指的是既可以写，也可以读，即可以在管道两边进行操作。单向管道指的是只读或只写的管道，即只能在管道的一边进行操作。手动创建的一个只读或只写的管道没有什么太大的意义，因为不能对管道读写就失去了其存在的作用。单向管道通常是用来限制通道的行为，一般会在函数的形参和返回值中出现，例如用于关闭通道的内置函数 `close` 的函数签名就用到了单向通道。



```
func close(c chan<- Type)
```

又或者说常用到的 `time` 包下的 `After` 函数



```
func After(d Duration) <-chan Time
```

`close` 函数的形参是一个只写通道，`After` 函数的返回值是一个只读通道，所以单向通道的语法如下：

- 箭头符号 `<-` 在前，就是只读通道，如 `<-chan int`
- 箭头符号 `<-` 在后，就是只写通道，如 `chan<- string`

当尝试对只读的管道写入数据时，将会无法通过编译



```
func main() {
  timeCh := time.After(time.Second)
  timeCh <- time.Now()
}
```

报错如下，意思非常明确



```
invalid operation: cannot send to receive-only channel timeCh (variable of type <-chan time.Time)
```

对只写的管道读取数据也是同理。

双向管道可以转换为单向管道，反过来则不可以。通常情况下，将双向管道传给某个协程或函数并且不希望它读取/发送数据，就可以用到单向管道来限制另一方的行为。



```
func main() {
   ch := make(chan int, 1)
   go write(ch)
   fmt.Println(<-ch)
}

func write(ch chan<- int) {
   // 只能对管道发送数据
   ch <- 1
}
```

只读管道也是一样的道理

提示

`chan` 是引用类型，即便 Go 的函数参数是值传递，但其引用依旧是同一个，这一点会在后续的管道原理中说明。

##### [for range](https://golang.halfiisland.com/essential/senior/110.concurrency.html#for-range)

通过 `for range` 语句，可以遍历读取缓冲管道中的数据，如下例



```
func main() {
  ch := make(chan int, 10)
  go func() {
    for i := 0; i < 10; i++ {
      ch <- i
    }
  }()
  for n := range ch {
    fmt.Println(n)
  }
}
```

通常来说，`for range` 遍历其他可迭代数据结构时，会有两个返回值，第一个是索引，第二个元素值，但是对于管道而言，有且仅有一个返回值，`for range` 会不断读取管道中的元素，当管道缓冲区为空或无缓冲时，就会阻塞等待，直到有其他协程向管道中写入数据才会继续读取数据。所以输出如下：



```
0
1
2
3
4
5
6
7
8
9
fatal error: all goroutines are asleep - deadlock!
```

可以看到上面的代码发生了死锁，因为子协程已经执行完毕了，而主协程还在阻塞等待其他协程来向管道中写入数据，所以应该管道在写入完毕后将其关闭。修改为如下代码



```
func main() {
   ch := make(chan int, 10)
   go func() {
      for i := 0; i < 10; i++ {
         ch <- i
      }
      // 关闭管道
      close(ch)
   }()
   for n := range ch {
      fmt.Println(n)
   }
}
```

写完后关闭管道，上述代码便不再会发生死锁。前面提到过读取管道是有两个返回值的，`for range` 遍历管道时，当无法成功读取数据时，便会退出循环。第二个返回值指的是能否成功读取数据，而不是管道是否已经关闭，即便管道已经关闭，对于有缓冲管道而言，依旧可以读取数据，并且第二个返回值仍然为 `true`。看下面的一个例子



```
func main() {
  ch := make(chan int, 10)
  for i := 0; i < 5; i++ {
    ch <- i
  }
    // 关闭管道
  close(ch)
    // 再读取数据
  for i := 0; i < 6; i++ {
    n, ok := <-ch
    fmt.Println(n, ok)
  }
}
```

输出结果



```
0 true
1 true
2 true
3 true
4 true
0 false
```

由于管道已经关闭了，即便缓冲区为空，再读取数据也不会导致当前协程阻塞，可以看到在第六次遍历的时候读取的是零值，并且 `ok` 为 `false`。

提示

关于管道关闭的时机，应该尽量在向管道发送数据的那一方关闭管道，而不要在接收方关闭管道，因为大多数情况下接收方只知道接收数据，并不知道该在什么时候关闭管道。

#### [WaitGroup](https://golang.halfiisland.com/essential/senior/110.concurrency.html#waitgroup)

`sync.WaitGroup` 是 `sync` 包下提供的一个结构体，`WaitGroup` 即等待执行，使用它可以很轻易的实现等待一组协程的效果。该结构体只对外暴露三个方法。

`Add` 方法用于指明要等待的协程的数量

```
func (wg *WaitGroup) Add(delta int)
```

`Done` 方法表示当前协程已经执行完毕

```
func (wg *WaitGroup) Done()
```

`Wait` 方法等待子协程结束，否则就阻塞

```
func (wg *WaitGroup) Wait()
```

`WaitGroup` 使用起来十分简单，属于开箱即用。其内部的实现是计数器+信号量，程序开始时调用 `Add` 初始化计数，每当一个协程执行完毕时调用 `Done`，计数就-1，直到减为 0，而在此期间，主协程调用 `Wait` 会一直阻塞直到全部计数减为 0，然后才会被唤醒。看一个简单的使用例子

```
func main() {
  var wait sync.WaitGroup
  // 指定子协程的数量
  wait.Add(1)
  go func() {
    fmt.Println(1)
    // 执行完毕
    wait.Done()
  }()
  // 等待子协程
  wait.Wait()
  fmt.Println(2)
}
```

这段代码永远都是先输出 1 再输出 2，主协程会等待子协程执行完毕后再退出。



```
1
2
```

针对协程介绍中最开始的例子，可以做出如下修改



```
func main() {
   var mainWait sync.WaitGroup
   var wait sync.WaitGroup
   // 计数10
   mainWait.Add(10)
   fmt.Println("start")
   for i := 0; i < 10; i++ {
      // 循环内计数1
      wait.Add(1)
      go func() {
         fmt.Println(i)
         // 两个计数-1
         wait.Done()
         mainWait.Done()
      }()
      // 等待当前循环的协程执行完毕
      wait.Wait()
   }
   // 等待所有的协程执行完毕
   mainWait.Wait()
   fmt.Println("end")
}
```

这里使用了 `sync.WaitGroup` 替代了原先的 `time.Sleep`，协程并发执行的的顺序更加可控，不管执行多少次，输出都如下



```
start
0
1
2
3
4
5
6
7
8
9
end
```

`WaitGroup` 通常适用于可动态调整协程数量的时候，例如事先知晓协程的数量，又或者在运行过程中需要动态调整。`WaitGroup` 的值不应该被复制，复制后的值也不应该继续使用，尤其是将其作为函数参数传递时，应该传递指针而不是值。倘若使用复制的值，计数完全无法作用到真正的 `WaitGroup` 上，这可能会导致主协程一直阻塞等待，程序将无法正常运行。例如下方的代码



```
func main() {
  var mainWait sync.WaitGroup
  mainWait.Add(1)
  hello(mainWait)
  mainWait.Wait()
  fmt.Println("end")
}
func hello(wait sync.WaitGroup) {
  fmt.Println("hello")
  wait.Done()
}
```

错误提示所有的协程都已经退出，但主协程依旧在等待，这就形成了死锁，因为 `hello` 函数内部对一个形参 `WaitGroup` 调用 `Done` 并不会作用到原来的 `mainWait` 上，所以应该使用指针来进行传递。



```
hello
fatal error: all goroutines are asleep - deadlock!
```

提示

当计数变为负数，或者计数数量大于子协程数量时，将会引发 `panic`。

#### [Context](https://golang.halfiisland.com/essential/senior/110.concurrency.html#context)

`Context` 译为上下文，是 Go 提供的一种并发控制的解决方案，相比于管道和 `WaitGroup`，它可以更好的控制子孙协程以及层级更深的协程。`Context` 本身是一个接口，只要实现了该接口都可以称之为上下文例如著名 Web 框架 `Gin` 中的 `gin.Context`。`context` 标准库也提供了几个实现，分别是：

- `emptyCtx`
- `cancelCtx`
- `timerCtx`
- `valueCtx`

##### [Context](https://golang.halfiisland.com/essential/senior/110.concurrency.html#context-1)

先来看看 `Context` 接口的定义，再去了解它的具体实现。



```
type Context interface {

   Deadline() (deadline time.Time, ok bool)

   Done() <-chan struct{}

   Err() error

   Value(key any) any
}
```

**Deadline**

该方法具有两个返回值，`deadline` 是截止时间，即上下文应该取消的时间。第二个值是是否设置 `deadline`，如果没有设置则一直为 `false`。



```
Deadline() (deadline time.Time, ok bool)
```

**Done**

其返回值是一个空结构体类型的只读管道，该管道仅仅起到通知作用，不传递任何数据。当上下文所做的工作应该取消时，该通道就会被关闭，对于一些不支持取消的上下文，可能会返回 `nil`。



```
Done() <-chan struct{}
```

**Err**

该方法返回一个 `error`，用于表示上下关闭的原因。当 `Done` 管道没有关闭时，返回 `nil`，如果关闭过后，会返回一个 `err` 来解释为什么会关闭。



```
Err() error
```

**Value**

该方法返回对应的键值，如果 `key` 不存在，或者不支持该方法，就会返回 `nil`。



```
Value(key any) any
```

##### [emptyCtx](https://golang.halfiisland.com/essential/senior/110.concurrency.html#emptyctx)

顾名思义，`emptyCtx` 就是空的上下文，`context` 包下所有的实现都是不对外暴露的，但是提供了对应的函数来创建上下文。`emptyCtx` 就可以通过 `context.Background` 和 `context.TODO` 来进行创建。两个函数如下



```
var (
  background = new(emptyCtx)
  todo       = new(emptyCtx)
)

func Background() Context {
  return background
}

func TODO() Context {
  return todo
}
```

可以看到仅仅只是返回了 `emptyCtx` 指针。`emptyCtx` 的底层类型实际上是一个 `int`，之所以不使用空结构体，是因为 `emptyCtx` 的实例必须要有不同的内存地址，它没法被取消，没有 `deadline`，也不能取值，实现的方法都是返回零值。



```
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

`emptyCtx` 通常是用来当作最顶层的上下文，在创建其他三种上下文时作为父上下文传入。context 包中的各个实现关系如下图所示

![img](./assets/context_1.png)

##### [valueCtx](https://golang.halfiisland.com/essential/senior/110.concurrency.html#valuectx)

`valueCtx` 实现比较简单，其内部只包含一对键值对，和一个内嵌的 `Context` 类型的字段。



```
type valueCtx struct {
   Context
   key, val any
}
```

其本身只实现了 `Value` 方法，逻辑也很简单，当前上下文找不到就去父上下文找。



```
func (c *valueCtx) Value(key any) any {
   if c.key == key {
      return c.val
   }
   return value(c.Context, key)
}
```

下面看一个 `valueCtx` 的简单使用案例



```
var waitGroup sync.WaitGroup

func main() {
  waitGroup.Add(1)
    // 传入上下文
  go Do(context.WithValue(context.Background(), 1, 2))
  waitGroup.Wait()
}

func Do(ctx context.Context) {
    // 新建定时器
  ticker := time.NewTimer(time.Second)
  defer waitGroup.Done()
  for {
    select {
    case <-ctx.Done(): // 永远也不会执行
    case <-ticker.C:
      fmt.Println("timeout")
      return
    default:
      fmt.Println(ctx.Value(1))
    }
    time.Sleep(time.Millisecond * 100)
  }
}
```

`valueCtx` 多用于在多级协程中传递一些数据，无法被取消，因此 `ctx.Done` 永远会返回 `nil`，`select` 会忽略掉 `nil` 管道。最后输出如下



```
2
2
2
2
2
2
2
2
2
2
timeout
```

##### [cancelCtx](https://golang.halfiisland.com/essential/senior/110.concurrency.html#cancelctx)

`cancelCtx` 以及 `timerCtx` 都实现了 `canceler` 接口，接口类型如下



```
type canceler interface {
    // removeFromParent 表示是否从父上下文中删除自身
    // err 表示取消的原因
  cancel(removeFromParent bool, err error)
    // Done 返回一个管道，用于通知取消的原因
  Done() <-chan struct{}
}
```

`cancel` 方法不对外暴露，在创建上下文时通过闭包将其包装为返回值以供外界调用，就如 `context.WithCancel` 源代码中所示



```
func WithCancel(parent Context) (ctx Context, cancel CancelFunc) {
   if parent == nil {
      panic("cannot create context from nil parent")
   }
   c := newCancelCtx(parent)
   // 尝试将自身添加进父级的children中
   propagateCancel(parent, &c)
   // 返回context和一个函数
   return &c, func() { c.cancel(true, Canceled) }
}
```

`cancelCtx` 译为可取消的上下文，创建时，如果父级实现了 `canceler`，就会将自身添加进父级的 `children` 中，否则就一直向上查找。如果所有的父级都没有实现 `canceler`，就会启动一个协程等待父级取消，然后当父级结束时取消当前上下文。当调用 `cancelFunc` 时，`Done` 通道将会关闭，该上下文的任何子级也会随之取消，最后会将自身从父级中删除。下面是一个简单的示例：



```
var waitGroup sync.WaitGroup

func main() {
  bkg := context.Background()
    // 返回了一个cancelCtx和cancel函数
  cancelCtx, cancel := context.WithCancel(bkg)
  waitGroup.Add(1)
  go func(ctx context.Context) {
    defer waitGroup.Done()
    for {
      select {
      case <-ctx.Done():
        fmt.Println(ctx.Err())
        return
      default:
        fmt.Println("等待取消中...")
      }
      time.Sleep(time.Millisecond * 200)
    }

  }(cancelCtx)
  time.Sleep(time.Second)
  cancel()
  waitGroup.Wait()
}
```

输出如下



```
等待取消中...
等待取消中...
等待取消中...
等待取消中...
等待取消中...
context canceled
```

再来一个层级嵌套深一点的示例



```
var waitGroup sync.WaitGroup

func main() {
   waitGroup.Add(3)
   ctx, cancelFunc := context.WithCancel(context.Background())
   go HttpHandler(ctx)
   time.Sleep(time.Second)
   cancelFunc()
   waitGroup.Wait()
}

func HttpHandler(ctx context.Context) {
   cancelCtxAuth, cancelAuth := context.WithCancel(ctx)
   cancelCtxMail, cancelMail := context.WithCancel(ctx)

   defer cancelAuth()
   defer cancelMail()
   defer waitGroup.Done()

   go AuthService(cancelCtxAuth)
   go MailService(cancelCtxMail)

   for {
      select {
      case <-ctx.Done():
         fmt.Println(ctx.Err())
         return
      default:
         fmt.Println("正在处理http请求...")
      }
      time.Sleep(time.Millisecond * 200)
   }

}

func AuthService(ctx context.Context) {
   defer waitGroup.Done()
   for {
      select {
      case <-ctx.Done():
         fmt.Println("auth 父级取消", ctx.Err())
         return
      default:
         fmt.Println("auth...")
      }
      time.Sleep(time.Millisecond * 200)
   }
}

func MailService(ctx context.Context) {
   defer waitGroup.Done()
   for {
      select {
      case <-ctx.Done():
         fmt.Println("mail 父级取消", ctx.Err())
         return
      default:
         fmt.Println("mail...")
      }
      time.Sleep(time.Millisecond * 200)
   }
}
```

例子中创建了 3 个 `cancelCtx`，尽管父级 `cancelCtx` 在取消的同时会取消它的子上下文，但是保险起见，如果创建了一个 `cancelCtx`，在相应的流程结束后就应该调用 `cancel` 函数。输出如下



```
正在处理http请求...
auth...
mail...
mail...
auth...
正在处理http请求...
auth...
mail...
正在处理http请求...
正在处理http请求...
auth...
mail...
auth...
正在处理http请求...
mail...
context canceled
auth 父级取消 context canceled
mail 父级取消 context canceled
```

##### [timerCtx](https://golang.halfiisland.com/essential/senior/110.concurrency.html#timerctx)

`timerCtx` 在 `cancelCtx` 的基础之上增加了超时机制，`context` 包下提供了两种创建的函数，分别是 `WithDeadline` 和 `WithTimeout`，两者功能类似，前者是指定一个具体的超时时间，比如指定一个具体时间 `2023/3/20 16:32:00`，后者是指定一个超时的时间间隔，比如 5 分钟后。两个函数的签名如下



```
func WithDeadline(parent Context, d time.Time) (Context, CancelFunc)

func WithTimeout(parent Context, timeout time.Duration) (Context, CancelFunc)
```

`timerCtx` 会在时间到期后自动取消当前上下文，取消的流程除了要额外的关闭 `timer` 之外，基本与 `cancelCtx` 一致。下面是一个简单的 `timerCtx` 的使用示例



```
var wait sync.WaitGroup

func main() {
  deadline, cancel := context.WithDeadline(context.Background(), time.Now().Add(time.Second))
  defer cancel()
  wait.Add(1)
  go func(ctx context.Context) {
    defer wait.Done()
    for {
      select {
      case <-ctx.Done():
        fmt.Println("上下文取消", ctx.Err())
        return
      default:
        fmt.Println("等待取消中...")
      }
      time.Sleep(time.Millisecond * 200)
    }
  }(deadline)
  wait.Wait()
}
```

尽管上下文到期会自动取消，但是为了保险起见，在相关流程结束后，最好手动取消上下文。输出如下



```
等待取消中...
等待取消中...
等待取消中...
等待取消中...
等待取消中...
上下文取消 context deadline exceeded
```

`WithTimeout` 其实与 `WithDealine` 非常相似，它的实现也只是稍微封装了一下并调用 `WithDeadline`，和上面例子中的 `WithDeadline` 用法一样，如下



```
func WithTimeout(parent Context, timeout time.Duration) (Context, CancelFunc) {
   return WithDeadline(parent, time.Now().Add(timeout))
}
```

提示

就跟内存分配后不回收会造成内存泄漏一样，上下文也是一种资源，如果创建了但从来不取消，一样会造成上下文泄露，所以最好避免此种情况的发生。

#### [Select](https://golang.halfiisland.com/essential/senior/110.concurrency.html#select)

`select` 在 Linux 系统中，是一种 IO 多路复用的解决方案，类似的，在 Go 中，`select` 是一种管道多路复用的控制结构。什么是多路复用，简单的用一句话概括：在某一时刻，同时监测多个元素是否可用，被监测的可以是网络请求，文件 IO 等。在 Go 中的 `select` 监测的元素就是管道，且只能是管道。`select` 的语法与 `switch` 语句类似，下面看看一个 `select` 语句长什么样



```
func main() {
  // 创建三个管道
  chA := make(chan int)
  chB := make(chan int)
  chC := make(chan int)
  defer func() {
    close(chA)
    close(chB)
    close(chC)
  }()
  select {
  case n, ok := <-chA:
    fmt.Println(n, ok)
  case n, ok := <-chB:
    fmt.Println(n, ok)
  case n, ok := <-chC:
    fmt.Println(n, ok)
  default:
    fmt.Println("所有管道都不可用")
  }
}
```

##### [使用](https://golang.halfiisland.com/essential/senior/110.concurrency.html#使用)

与 `switch` 类似，`select` 由多个 `case` 和一个 `default` 组成，`default` 分支可以省略。每一个 `case` 只能操作一个管道，且只能进行一种操作，要么读要么写，当有多个 `case` 可用时，`select` 会伪随机的选择一个 `case` 来执行。如果所有 `case` 都不可用，就会执行 `default` 分支，倘若没有 `default` 分支，将会阻塞等待，直到至少有一个 `case` 可用。由于上例中没有对管道写入数据，自然所有的 `case` 都不可用，所以最终输出为 `default` 分支的执行结果。稍微修改下后如下：



```
func main() {
   chA := make(chan int)
   chB := make(chan int)
   chC := make(chan int)
   defer func() {
      close(chA)
      close(chB)
      close(chC)
   }()
   // 开启一个新的协程
   go func() {
      // 向A管道写入数据
      chA <- 1
   }()
   select {
   case n, ok := <-chA:
      fmt.Println(n, ok)
   case n, ok := <-chB:
      fmt.Println(n, ok)
   case n, ok := <-chC:
      fmt.Println(n, ok)
   }
}
```

上例开启了一个新的协程来向管道 A 写入数据，`select` 由于没有默认分支，所以会一直阻塞等待直到有 `case` 可用。当管道 A 可用时，执行完对应分支后主协程就直接退出了。要想一直监测管道，可以配合 `for` 循环使用，如下。



```
func main() {
  chA := make(chan int)
  chB := make(chan int)
  chC := make(chan int)
  defer func() {
    close(chA)
    close(chB)
    close(chC)
  }()
  go Send(chA)
  go Send(chB)
  go Send(chC)
  // for循环
  for {
    select {
    case n, ok := <-chA:
      fmt.Println("A", n, ok)
    case n, ok := <-chB:
      fmt.Println("B", n, ok)
    case n, ok := <-chC:
      fmt.Println("C", n, ok)
    }
  }
}

func Send(ch chan<- int) {
  for i := 0; i < 3; i++ {
    time.Sleep(time.Millisecond)
    ch <- i
  }
}
```

这样确实三个管道都能用上了，但是死循环+`select` 会导致主协程永久阻塞，所以可以将其单独放到新协程中，并且加上一些其他的逻辑。



```
func main() {
  chA := make(chan int)
  chB := make(chan int)
  chC := make(chan int)
  defer func() {
    close(chA)
    close(chB)
    close(chC)
  }()

  l := make(chan struct{})

  go Send(chA)
  go Send(chB)
  go Send(chC)

  go func() {
  Loop:
    for {
      select {
      case n, ok := <-chA:
        fmt.Println("A", n, ok)
      case n, ok := <-chB:
        fmt.Println("B", n, ok)
      case n, ok := <-chC:
        fmt.Println("C", n, ok)
      case <-time.After(time.Second): // 设置1秒的超时时间
        break Loop // 退出循环
      }
    }
    l <- struct{}{} // 告诉主协程可以退出了
  }()

  <-l
}

func Send(ch chan<- int) {
  for i := 0; i < 3; i++ {
    time.Sleep(time.Millisecond)
    ch <- i
  }
}
```

上例中通过 `for` 循环配合 `select` 来一直监测三个管道是否可以用，并且第四个 `case` 是一个超时管道，超时过后便会退出循环，结束子协程。最终输出如下



```
C 0 true
A 0 true
B 0 true
A 1 true
B 1 true
C 1 true
B 2 true
C 2 true
A 2 true
```

**超时**

上一个例子用到了 `time.After` 函数，其返回值是一个只读的管道，该函数配合 `select` 使用可以非常简单的实现超时机制，例子如下



```
func main() {
  chA := make(chan int)
  defer close(chA)
  go func() {
    time.Sleep(time.Second * 2)
    chA <- 1
  }()
  select {
  case n := <-chA:
    fmt.Println(n)
  case <-time.After(time.Second):
    fmt.Println("超时")
  }
}
```

**永久阻塞**

当 `select` 语句中什么都没有时，就会永久阻塞，例如



```
func main() {
  fmt.Println("start")
  select {}
  fmt.Println("end")
}
```

`end` 永远也不会输出，主协程会一直阻塞，这种情况一般是有特殊用途。

提示

在 `select` 的 `case` 中对值为 `nil` 的管道进行操作的话，并不会导致阻塞，该 `case` 则会被忽略，永远也不会被执行。例如下方代码无论执行多少次都只会输出 timeout。



```
func main() {
   var nilCh chan int
   select {
   case <-nilCh:
      fmt.Println("read")
   case nilCh <- 1:
      fmt.Println("write")
   case <-time.After(time.Second):
      fmt.Println("timeout")
   }
}
```

##### [非阻塞](https://golang.halfiisland.com/essential/senior/110.concurrency.html#非阻塞)

通过使用`select`的`default`分支配合管道，我们可以实现非阻塞的收发操作，如下所示



```
func TrySend(ch chan int, ele int) bool  {
	select {
	case ch <- ele:
		return true
	default:
		return false
	}
}

func TryRecv(ch chan int) (int, bool)  {
	select {
	case ele, ok := <-ch:
		return ele, ok
	default:
		return 0, false
	}
}
```

同理，也可以实现非阻塞的判断一个`context`是否已经结束



```
func IsDone(ctx context.Context) bool {
	select {
	case <-ctx.Done():
		return true
	default:
		return false
	}
}
```

#### [锁](https://golang.halfiisland.com/essential/senior/110.concurrency.html#锁)

先来看看的一个例子



```
var wait sync.WaitGroup
var count = 0

func main() {
   wait.Add(10)
   for i := 0; i < 10; i++ {
      go func(data *int) {
         // 模拟访问耗时
         time.Sleep(time.Millisecond * time.Duration(rand.Intn(5000)))
         // 访问数据
         temp := *data
         // 模拟计算耗时
         time.Sleep(time.Millisecond * time.Duration(rand.Intn(5000)))
         ans := 1
         // 修改数据
         *data = temp + ans
         fmt.Println(*data)
         wait.Done()
      }(&count)
   }
   wait.Wait()
   fmt.Println("最终结果", count)
}
```

对于上面的例子，开启了十个协程来对 `count` 进行 `+1` 操作，并且使用了 `time.Sleep` 来模拟不同的耗时，根据直觉来讲，10 个协程执行 10 个 `+1` 操作，最终结果一定是 `10`，正确结果也确实是 `10`，但事实并非如此，上面的例子执行结果如下：



```
1
2
3
3
2
2
3
3
3
4
最终结果 4
```

可以看到最终结果为 4，而这只是众多可能结果中的一种。由于每个协程访问和计算所需的时间不同，A 协程访问数据耗费 500 毫秒，此时访问到的 `count` 值为 1，随后又花费了 400 毫秒计算，但在这 400 毫秒内，B 协程已经完成了访问和计算并成功更新了 `count` 的值，A 协程在计算完毕后，A 协程最初访问到的值已经过时了，但 A 协程并不知道这件事，依旧在原先访问到的值基础上加一，并赋值给 `count`，这样一来，B 协程的执行结果被覆盖了。多个协程读取和访问一个共享数据时，尤其会发生这样的问题，为此就需要用到锁。

Go 中 `sync` 包下的 `Mutex` 与 `RWMutex` 提供了互斥锁与读写锁两种实现，且提供了非常简单易用的 API，加锁只需要 `Lock()`，解锁也只需要 `Unlock()`。需要注意的是，Go 所提供的锁都是非递归锁，也就是不可重入锁，所以重复加锁或重复解锁都会导致 `fatal`。锁的意义在于保护不变量，加锁是希望数据不会被其他协程修改，如下



```
func DoSomething() {
  Lock()
    // 在这个过程中，数据不会被其他协程修改
  Unlock()
}
```

倘若是递归锁的话，就可能会发生如下情况



```
func DoSomething() {
  Lock()
    DoOther()
  Unlock()
}

func DoOther() {
  Lock()
  // do other
  Unlock()
}
```

`DoSomthing` 函数显然不知道 `DoOther` 函数可能会对数据做点什么，从而修改了数据，比如再开几个子协程破坏了不变量。这在 Go 中是行不通的，一旦加锁以后就必须保证不变量的不变性，此时重复加锁解锁都会导致死锁。所以在编写代码时应该避免上述情况，必要时在加锁的同时立即使用 `defer` 语句解锁。

##### [互斥锁](https://golang.halfiisland.com/essential/senior/110.concurrency.html#互斥锁)

`sync.Mutex` 是 Go 提供的互斥锁实现，其实现了 `sync.Locker` 接口



```
type Locker interface {
   // 加锁
   Lock()
   // 解锁
   Unlock()
}
```

使用互斥锁可以非常完美的解决上述问题，例子如下



```
var wait sync.WaitGroup
var count = 0

var lock sync.Mutex

func main() {
  wait.Add(10)
  for i := 0; i < 10; i++ {
    go func(data *int) {
      // 加锁
      lock.Lock()
      // 模拟访问耗时
      time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
      // 访问数据
      temp := *data
      // 模拟计算耗时
      time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
      ans := 1
      // 修改数据
      *data = temp + ans
      // 打印当前协程修改后的值
      fmt.Println(*data)
      // 解锁
      lock.Unlock()
      wait.Done()
    }(&count)
  }
  wait.Wait()
  fmt.Println("最终结果", count)
}
```

每一个协程在访问数据前，都先上锁，更新完成后再解锁，其他协程想要访问就必须要先获得锁，否则就阻塞等待。如此一来，就不存在上述问题了，所以输出如下



```
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

##### [读写锁](https://golang.halfiisland.com/essential/senior/110.concurrency.html#读写锁)

互斥锁适合读操作与写操作频率都差不多的情况，对于一些读多写少的数据，如果使用互斥锁，会造成大量的不必要的协程竞争锁，这会消耗很多的系统资源，这时候就需要用到读写锁，即读写互斥锁，对于一个协程而言：

- 如果获得了读锁，其他协程进行写操作时会阻塞，其他协程进行读操作时不会阻塞
- 如果获得了写锁，其他协程进行写操作时会阻塞，其他协程进行读操作时会阻塞

Go 中读写互斥锁的实现是 `sync.RWMutex`，它也同样实现了 `Locker` 接口，但它提供了更多可用的方法，如下：



```
// 加读锁
func (rw *RWMutex) RLock()

// 尝试加读锁
func (rw *RWMutex) TryRLock() bool

// 解读锁
func (rw *RWMutex) RUnlock()

// 加写锁
func (rw *RWMutex) Lock()

// 尝试加写锁
func (rw *RWMutex) TryLock() bool

// 解写锁
func (rw *RWMutex) Unlock()
```

其中 `TryRlock` 与 `TryLock` 两个尝试加锁的操作是非阻塞式的，成功加锁会返回 `true`，无法获得锁时并不会阻塞而是返回 `false`。读写互斥锁内部实现依旧是互斥锁，并不是说分读锁和写锁就有两个锁，从始至终都只有一个锁。下面来看一个读写互斥锁的使用案例



```
var wait sync.WaitGroup
var count = 0

var rw sync.RWMutex

func main() {
  wait.Add(12)
  // 读多写少
  go func() {
    for i := 0; i < 3; i++ {
      go Write(&count)
    }
    wait.Done()
  }()
  go func() {
    for i := 0; i < 7; i++ {
      go Read(&count)
    }
    wait.Done()
  }()
  // 等待子协程结束
  wait.Wait()
  fmt.Println("最终结果", count)
}

func Read(i *int) {
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(500)))
  rw.RLock()
  fmt.Println("拿到读锁")
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
  fmt.Println("释放读锁", *i)
  rw.RUnlock()
  wait.Done()
}

func Write(i *int) {
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
  rw.Lock()
  fmt.Println("拿到写锁")
  temp := *i
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
  *i = temp + 1
  fmt.Println("释放写锁", *i)
  rw.Unlock()
  wait.Done()
}
```

该例开启了 3 个写协程，7 个读协程，在读数据的时候都会先获得读锁，读协程可以正常获得读锁，但是会阻塞写协程，获得写锁的时候，则会同时阻塞读协程和写协程，直到释放写锁，如此一来实现了读协程与写协程互斥，保证了数据的正确性。例子输出如下：



```
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

提示

对于锁而言，不应该将其作为值传递和存储，应该使用指针。

##### [条件变量](https://golang.halfiisland.com/essential/senior/110.concurrency.html#条件变量)

条件变量，与互斥锁一同出现和使用，所以有些人可能会误称为条件锁，但它并不是锁，是一种通讯机制。Go 中的 `sync.Cond` 对此提供了实现，而创建条件变量的函数签名如下：



```
func NewCond(l Locker) *Cond
```

可以看到创建一个条件变量前提就是需要创建一个锁，`sync.Cond` 提供了如下的方法以供使用



```
// 阻塞等待条件生效，直到被唤醒
func (c *Cond) Wait()

// 唤醒一个因条件阻塞的协程
func (c *Cond) Signal()

// 唤醒所有因条件阻塞的协程
func (c *Cond) Broadcast()
```

条件变量使用起来非常简单，将上面的读写互斥锁的例子稍微修改下即可



```
var wait sync.WaitGroup
var count = 0

var rw sync.RWMutex

// 条件变量
var cond = sync.NewCond(rw.RLocker())

func main() {
  wait.Add(12)
  // 读多写少
  go func() {
    for i := 0; i < 3; i++ {
      go Write(&count)
    }
    wait.Done()
  }()
  go func() {
    for i := 0; i < 7; i++ {
      go Read(&count)
    }
    wait.Done()
  }()
  // 等待子协程结束
  wait.Wait()
  fmt.Println("最终结果", count)
}

func Read(i *int) {
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(500)))
  rw.RLock()
  fmt.Println("拿到读锁")
  // 条件不满足就一直阻塞
  for *i < 3 {
    cond.Wait()
  }
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
  fmt.Println("释放读锁", *i)
  rw.RUnlock()
  wait.Done()
}

func Write(i *int) {
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
  rw.Lock()
  fmt.Println("拿到写锁")
  temp := *i
  time.Sleep(time.Millisecond * time.Duration(rand.Intn(1000)))
  *i = temp + 1
  fmt.Println("释放写锁", *i)
  rw.Unlock()
  // 唤醒所有因条件变量阻塞的协程
  cond.Broadcast()
  wait.Done()
}
```

在创建条件变量时，因为在这里条件变量作用的是读协程，所以将读锁作为互斥锁传入，如果直接传入读写互斥锁会导致写协程重复解锁的问题。这里传入的是 `sync.rlocker`，通过 `RWMutex.RLocker` 方法获得。



```
func (rw *RWMutex) RLocker() Locker {
   return (*rlocker)(rw)
}

type rlocker RWMutex

func (r *rlocker) Lock()   { (*RWMutex)(r).RLock() }
func (r *rlocker) Unlock() { (*RWMutex)(r).RUnlock() }
```

可以看到 `rlocker` 也只是把读写互斥锁的读锁操作封装了一下，实际上是同一个引用，依旧是同一个锁。读协程读取数据时，如果小于 3 就会一直阻塞等待，直到数据大于 3，而写协程在更新数据后都会尝试唤醒所有因条件变量而阻塞的协程，所以最后的输出如下



```
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
释放写锁 3 // 第三个写协程执行完毕
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
释放读锁 3
最终结果 3
```

从结果中可以看到，当第三个写协程更新完数据后，七个因条件变量而阻塞的读协程都恢复了运行。

提示

对于条件变量，应该使用 `for` 而不是 `if`，应该使用循环来判断条件是否满足，因为协程被唤醒时并不能保证当前条件就已经满足了。



```
for !condition {
  cond.Wait()
}
```

#### [sync](https://golang.halfiisland.com/essential/senior/110.concurrency.html#sync)

Go 中很大一部分的并发相关的工具都是 `sync` 标准库提供的，上述已经介绍过了 `sync.WaitGroup`，`sync.Locker` 等，除此之外，`sync` 包下还有一些其他的工具可以使用。

##### [Once](https://golang.halfiisland.com/essential/senior/110.concurrency.html#once)

当在使用一些数据结构时，如果这些数据结构太过庞大，可以考虑采用懒加载的方式，即真正要用到它的时候才会初始化该数据结构。如下面的例子



```
type MySlice []int

func (m *MySlice) Get(i int) (int, bool) {
   if *m == nil {
      return 0, false
   } else {
      return (*m)[i], true
   }
}

func (m *MySlice) Add(i int) {
   // 当真正用到切片的时候，才会考虑去初始化
   if *m == nil {
      *m = make([]int, 0, 10)
   }
   *m = append(*m, i)
}
```

那么问题就来了，如果只有一个协程使用肯定是没有任何问题的，但是如果有多个协程访问的话就可能会出现问题了。比如协程 A 和 B 同时调用了 `Add` 方法，A 执行的稍微快一些，已经初始化完毕了，并且将数据成功添加，随后协程 B 又初始化了一遍，这样一来将协程 A 添加的数据直接覆盖掉了，这就是问题所在。

而这就是 `sync.Once` 要解决的问题，顾名思义，`Once` 译为一次，`sync.Once` 保证了在并发条件下指定操作只会执行一次。它的使用非常简单，只对外暴露了一个 `Do` 方法，签名如下：



```
func (o *Once) Do(f func())
```

在使用时，只需要将初始化操作传入 `Do` 方法即可，如下



```
var wait sync.WaitGroup

func main() {
  var slice MySlice
  wait.Add(4)
  for i := 0; i < 4; i++ {
    go func() {
      slice.Add(1)
      wait.Done()
    }()
  }
  wait.Wait()
  fmt.Println(slice.Len())
}

type MySlice struct {
  s []int
  o sync.Once
}

func (m *MySlice) Get(i int) (int, bool) {
  if m.s == nil {
    return 0, false
  } else {
    return m.s[i], true
  }
}

func (m *MySlice) Add(i int) {
  // 当真正用到切片的时候，才会考虑去初始化
  m.o.Do(func() {
    fmt.Println("初始化")
    if m.s == nil {
      m.s = make([]int, 0, 10)
    }
  })
  m.s = append(m.s, i)
}

func (m *MySlice) Len() int {
  return len(m.s)
}
```

输出如下



```
初始化
4
```

从输出结果中可以看到，所有的数据等正常添加进切片，初始化操作只执行了一次。其实 `sync.Once` 的实现相当简单，去除注释真正的代码逻辑只有 16 行，其原理就是锁+原子操作。源代码如下：



```
type Once struct {
    // 用于判断操作是否已经执行
  done uint32
  m    Mutex
}

func (o *Once) Do(f func()) {
  // 原子加载数据
  if atomic.LoadUint32(&o.done) == 0 {
    o.doSlow(f)
  }
}

func (o *Once) doSlow(f func()) {
    // 加锁
  o.m.Lock()
    // 解锁
  defer o.m.Unlock()
    // 判断是否执行
  if o.done == 0 {
        // 执行完毕后修改done
    defer atomic.StoreUint32(&o.done, 1)
    f()
  }
}
```

##### [Pool](https://golang.halfiisland.com/essential/senior/110.concurrency.html#pool)

`sync.Pool` 的设计目的是用于存储临时对象以便后续的复用，是一个临时的并发安全对象池，将暂时用不到的对象放入池中，在后续使用中就不需要再额外的创建对象可以直接复用，减少内存的分配与释放频率，最重要的一点就是降低 GC 压力。`sync.Pool` 总共只有两个方法，如下：



```
// 申请一个对象
func (p *Pool) Get() any

// 放入一个对象
func (p *Pool) Put(x any)
```

并且 `sync.Pool` 有一个对外暴露的 `New` 字段，用于对象池在申请不到对象时初始化一个对象



```
New func() any
```

下面以一个例子演示



```
var wait sync.WaitGroup

// 临时对象池
var pool sync.Pool

// 用于计数过程中总共创建了多少个对象
var numOfObject atomic.Int64

// BigMemData 假设这是一个占用内存很大的结构体
type BigMemData struct {
   M string
}

func main() {
   pool.New = func() any {
      numOfObject.Add(1)
      return BigMemData{"大内存"}
   }
   wait.Add(1000)
   // 这里开启1000个协程
   for i := 0; i < 1000; i++ {
      go func() {
         // 申请对象
         val := pool.Get()
         // 使用对象
         _ = val.(BigMemData)
         // 用完之后再释放对象
         pool.Put(val)
         wait.Done()
      }()
   }
   wait.Wait()
   fmt.Println(numOfObject.Load())
}
```

例子中开启了 1000 个协程不断的在池中申请和释放对象，如果不采用对象池，那么 1000 个协程都需要各自实例化对象，并且这 1000 个实例化后的对象在使用完毕后都需要由 GC 来释放内存，如果有几十万个协程或者说创建该对象的成本十分的高昂，这种情况下就会占用很大的内存并且给 GC 带来非常大的压力，采用对象池后，可以复用对象减少实例化的频率，比如上述的例子输出可能如下：



```
5
```

即便开启了 1000 个协程，整个过程中也只创建了 5 个对象，如果不采用对象池的话 1000 个协程将会创建 1000 个对象，这种优化带来的提升是显而易见的，尤其是在并发量特别大和实例化对象成本特别高的时候更能体现出优势。

在使用 `sync.Pool` 时需要注意几个点：

- 临时对象：`sync.Pool` 只适合存放临时对象，池中的对象可能会在没有任何通知的情况下被 GC 移除，所以并不建议将网络链接，数据库连接这类存入 `sync.Pool` 中。
- 不可预知：`sync.Pool` 在申请对象时，无法预知这个对象是新创建的还是复用的，也无法知晓池中有几个对象
- 并发安全：官方保证 `sync.Pool` 一定是并发安全，但并不保证用于创建对象的 `New` 函数就一定是并发安全的，`New` 函数是由使用者传入的，所以 `New` 函数的并发安全性要由使用者自己来维护，这也是为什么上例中对象计数要用到原子值的原因。

提示

最后需要注意的是，当使用完对象后，一定要释放回池中，如果用了不释放那么对象池的使用将毫无意义。

标准库 `fmt` 包下就有一个对象池的使用案例，在 `fmt.Fprintf` 函数中



```
func Fprintf(w io.Writer, format string, a ...any) (n int, err error) {
   // 申请一个打印缓冲区
   p := newPrinter()
   p.doPrintf(format, a)
   n, err = w.Write(p.buf)
   // 使用完毕后释放
   p.free()
   return
}
```

其中 `newPointer` 函数和 `free` 方法的实现如下



```
func newPrinter() *pp {
   // 向对象池申请的一个对象
   p := ppFree.Get().(*pp)
   p.panicking = false
   p.erroring = false
   p.wrapErrs = false
   p.fmt.init(&p.buf)
   return p
}

func (p *pp) free() {
    // 为了让对象池中的缓冲区大小大致相同以便更好的弹性控制缓冲区大小
    // 过大的缓冲区就不用放回对象池
  if cap(p.buf) > 64<<10 {
    return
  }
  // 字段重置后释放对象到池中
  p.buf = p.buf[:0]
  p.arg = nil
  p.value = reflect.Value{}
  p.wrappedErr = nil
  ppFree.Put(p)
}
```

##### [Map](https://golang.halfiisland.com/essential/senior/110.concurrency.html#map)

`sync.Map` 是官方提供的一种并发安全 Map 的实现，开箱即用，使用起来十分的简单，下面是该结构体对外暴露的方法：



```
// 根据一个key读取值，返回值会返回对应的值和该值是否存在
func (m *Map) Load(key any) (value any, ok bool)

// 存储一个键值对
func (m *Map) Store(key, value any)

// 删除一个键值对
func (m *Map) Delete(key any)

// 如果该key已存在，就返回原有的值，否则将新的值存入并返回，当成功读取到值时，loaded为true，否则为false
func (m *Map) LoadOrStore(key, value any) (actual any, loaded bool)

// 删除一个键值对，并返回其原有的值，loaded的值取决于key是否存在
func (m *Map) LoadAndDelete(key any) (value any, loaded bool)

// 遍历Map，当f()返回false时，就会停止遍历
func (m *Map) Range(f func(key, value any) bool)
```

下面用一个简单的示例来演示下 `sync.Map` 的基本使用



```
func main() {
  var syncMap sync.Map
  // 存入数据
  syncMap.Store("a", 1)
  syncMap.Store("a", "a")
  // 读取数据
  fmt.Println(syncMap.Load("a"))
  // 读取并删除
  fmt.Println(syncMap.LoadAndDelete("a"))
  // 读取或存入
  fmt.Println(syncMap.LoadOrStore("a", "hello world"))
  syncMap.Store("b", "goodbye world")
  // 遍历map
  syncMap.Range(func(key, value any) bool {
    fmt.Println(key, value)
    return true
  })
}
```

输出



```
a true
a true
hello world false
a hello world
b goodbye world
```

接下来看一个并发使用 map 的例子：



```
func main() {
  myMap := make(map[int]int, 10)
  var wait sync.WaitGroup
  wait.Add(10)
  for i := 0; i < 10; i++ {
    go func(n int) {
      for i := 0; i < 100; i++ {
        myMap[n] = n
      }
      wait.Done()
    }(i)
  }
  wait.Wait()
}
```

上例中使用的普通 map，开了 10 个协程不断的存入数据，显然这很可能会触发 fatal，结果大概率会如下



```
fatal error: concurrent map writes
```

使用 `sync.Map` 就可以避免这个问题



```
func main() {
  var syncMap sync.Map
  var wait sync.WaitGroup
  wait.Add(10)
  for i := 0; i < 10; i++ {
    go func(n int) {
      for i := 0; i < 100; i++ {
        syncMap.Store(n, n)
      }
      wait.Done()
    }(i)
  }
  wait.Wait()
  syncMap.Range(func(key, value any) bool {
    fmt.Println(key, value)
    return true
  })
}
```

输出如下



```
8 8
3 3
1 1
9 9
6 6
5 5
7 7
0 0
2 2
4 4
```

为了并发安全肯定需要做出一定的牺牲，`sync.Map` 的性能要比 map 低 10-100 倍左右。

#### [原子](https://golang.halfiisland.com/essential/senior/110.concurrency.html#原子)

在计算机学科中，原子或原语操作，通常用于表述一些不可再细化分割的操作，由于这些操作无法再细化为更小的步骤，在执行完毕前，不会被其他的任何协程打断，所以执行结果要么成功要么失败，没有第三种情况可言，如果出现了其他情况，那么它就是不是原子操作。例如下方的代码：



```
func main() {
  a := 0
  if a == 0 {
    a = 1
  }
  fmt.Println(a)
}
```

上方的代码是一个简单的判断分支，尽管代码很少，但也不是原子操作，真正的原子操作是由硬件指令层面支持的。

##### [类型](https://golang.halfiisland.com/essential/senior/110.concurrency.html#类型)

好在大多情况下并不需要自行编写汇编，Go 标准库 `sync/atomic` 包下已经提供了原子操作相关的 API，其提供了以下几种类型以供进行原子操作。



```
atomic.Bool{}
atomic.Pointer[]{}
atomic.Int32{}
atomic.Int64{}
atomic.Uint32{}
atomic.Uint64{}
atomic.Uintptr{}
atomic.Value{}
```

其中 `Pointer` 原子类型支持泛型，`Value` 类型支持存储任何类型，除此之外，还提供了许多函数来方便操作。因为原子操作的粒度过细，在大多数情况下，更适合处理这些基础的数据类型。

提示

`atmoic` 包下原子操作只有函数签名，没有具体实现，具体的实现是由 `plan9` 汇编编写。

##### [使用](https://golang.halfiisland.com/essential/senior/110.concurrency.html#使用-1)

每一个原子类型都会提供以下三个方法：

- `Load()`：原子的获取值
- `Swap(newVal type) (old type)`：原子的交换值，并且返回旧值
- `Store(val type)`：原子的存储值

不同的类型可能还会有其他的额外方法，比如整型类型都会提供 `Add` 方法来实现原子加减操作。下面以一个 `int64` 类型演示为例：



```
func main() {
  var aint64 atomic.Uint64
  // 存储值
  aint64.Store(64)
  // 交换值
  aint64.Swap(128)
  // 增加
  aint64.Add(112)
    // 加载值
  fmt.Println(aint64.Load())
}
```

或者也可以直接使用函数



```
func main() {
   var aint64 int64
   // 存储值
   atomic.StoreInt64(&aint64, 64)
   // 交换值
   atomic.SwapInt64(&aint64, 128)
   // 增加
   atomic.AddInt64(&aint64, 112)
   // 加载
   fmt.Println(atomic.LoadInt64(&aint64))
}
```

其他的类型的使用也是十分类似的，最终输出为：



```
240
```

##### [CAS](https://golang.halfiisland.com/essential/senior/110.concurrency.html#cas)

`atomic` 包还提供了 `CompareAndSwap` 操作，也就是 `CAS`。它是实现乐观锁和无锁数据结构的核心。乐观锁本身并不是锁，是一种并发条件下无锁化并发控制方式：线程/协程在修改数据前，不会先加锁，而是先读取数据，进行计算，然后在提交修改时使用`CAS`来判断在此期间是否有其他线程修改过该数据。如果没有（值仍等于之前读取的值），则修改成功；否则，失败并重试。因此之所以被称作乐观锁，是因为它总是乐观的假设共享数据不会被修改，仅当发现数据未被修改时才会去执行对应操作，而前面了解到的互斥量就是悲观锁，互斥量总是悲观的认为共享数据肯定会被修改，所以在操作时会加锁，操作完毕后就会解锁。由于无锁化实现的并发，其安全性和效率相对于锁要高一些，许多并发安全的数据结构都采用了 `CAS` 来进行实现，不过真正的效率要结合具体使用场景来看。看下面的一个例子：



```
var lock sync.Mutex

var count int

func Add(num int) {
   lock.Lock()
   count += num
   lock.Unlock()
}
```

这是一个使用互斥锁的例子，每次增加数字前都会先上锁，执行完毕后就会解锁，过程中会导致其他协程阻塞，接下来使用 `CAS` 改造一下：



```
var count int64

func Add(num int64) {
  for {
    expect := atomic.LoadInt64(&count)
    if atomic.CompareAndSwapInt64(&count, expect, expect+num) {
      break
    }
  }
}
```

对于 `CAS` 而言，有三个参数，内存值，期望值，新值。执行时，`CAS` 会将期望值与当前内存值进行比较，如果内存值与期望值相同，就会执行后续的操作，否则的话什么也不做。对于 Go 中 `atomic` 包下的原子操作，`CAS` 相关的函数则需要传入地址，期望值，新值，且会返回是否成功替换的布尔值。例如 `int64` 类型的 `CAS` 操作函数签名如下：



```
func CompareAndSwapInt64(addr *int64, old, new int64) (swapped bool)
```

在 `CAS` 的例子中，首先会通过 `LoadInt64` 来获取期望值，随后使用 `CompareAndSwapInt64` 来进行比较交换，如果不成功的话就不断循环，直到成功。这样无锁化的操作虽然不会导致协程阻塞，但是不断的循环对于 CPU 而言依旧是一个不小的开销，所以在一些实现中失败达到了一定次数可能会放弃操作。但是对于上面的操作而言，仅仅只是简单的数字相加，涉及到的操作并不复杂，所以完全可以考虑无锁化实现。

提示

大多数情况下，仅仅只是比较值是无法做到并发安全的，比如因 `CAS` 引起 ABA 问题，就需要使用额外加入 `version` 来解决问题。

##### [Value](https://golang.halfiisland.com/essential/senior/110.concurrency.html#value)

`atomic.Value` 结构体，可以存储任意类型的值，结构体如下



```
type Value struct {
   // any类型
   v any
}
```

尽管可以存储任意类型，但是它不能存储 `nil`，并且前后存储的值类型应当一致，下面两个例子都无法通过编译



```
func main() {
   var val atomic.Value
   val.Store(nil)
   fmt.Println(val.Load())
}
// panic: sync/atomic: store of nil value into Value
```



```
func main() {
   var val atomic.Value
   val.Store("hello world")
   val.Store(114514)
   fmt.Println(val.Load())
}
// panic: sync/atomic: store of inconsistently typed value into Value
```

除此之外，它的使用与其他的原子类型并无太大的差别，并且需要注意的是，所有的原子类型都不应该复制值，而是应该使用它们的指针。

### 网络编程

#### net

Go 语言的`net`标准库是一个非常强大的库，它提供了处理网络通信、IP 地址、DNS 解析、TCP/UDP 协议、HTTP 协议等常见任务的功能。由于 Go 语言本身的并发特性，得益于此，Go 在处理网络 IO 的时候非常的简洁高效。

##### [地址解析](https://golang.halfiisland.com/essential/std/net.html#地址解析)

Go 提供了四个函数来解析网络地址，下面逐一讲解。

###### [MAC 地址](https://golang.halfiisland.com/essential/std/net.html#mac-地址)

签名

```
func ParseMAC(s string) (hw HardwareAddr, err error)
```

示例



```
package main

import (
  "fmt"
  "net"
)

func main() {
  hw, err := net.ParseMAC("00:1A:2B:3C:4D:5E")
  if err != nil {
    panic(err)
  }
  fmt.Println(hw)
}
```

###### [CIDR](https://golang.halfiisland.com/essential/std/net.html#cidr)

签名



```
func ParseCIDR(s string) (IP, *IPNet, error)
```

示例



```
package main

import (
    "fmt"
    "log"
    "net"
)

func main() {
    ipv4Addr, ipv4Net, err := net.ParseCIDR("192.0.2.1/24")
    if err != nil {
       log.Fatal(err)
    }
    fmt.Println(ipv4Addr)
    fmt.Println(ipv4Net)
}
```

###### [IP 地址](https://golang.halfiisland.com/essential/std/net.html#ip-地址)

IP 地址支持解析 ipv4，ipv6，函数签名如下



```
func ResolveIPAddr(network, address string) (*IPAddr, error)
```

使用示例如下



```
package main

import (
  "fmt"
  "net"
)

func main() {
  ipv4Addr, err := net.ResolveIPAddr("ip4", "192.168.2.1")
  if err != nil {
    panic(err)
  }
  fmt.Println(ipv4Addr)

  ipv6Addr, err := net.ResolveIPAddr("ip6", "2001:0db8:85a3:0000:0000:8a2e:0370:7334")
  if err != nil {
    panic(err)
  }
  fmt.Println(ipv6Addr)
}
```

###### [TCP 地址](https://golang.halfiisland.com/essential/std/net.html#tcp-地址)

TCP 地址支持 tcp4，tcp6，签名如下



```
func ResolveTCPAddr(network, address string) (*TCPAddr, error)
```

使用示例如下



```
package main

import (
  "fmt"
  "net"
)

func main() {
  tcp4Addr, err := net.ResolveTCPAddr("tcp4", "0.0.0.0:2020")
  if err != nil {
    panic(err)
  }
  fmt.Println(tcp4Addr)
  tcp6Addr, err := net.ResolveTCPAddr("tcp6", "[::1]:8080")
  if err != nil {
    panic(err)
  }
  fmt.Println(tcp6Addr)
}
```

###### [UDP 地址](https://golang.halfiisland.com/essential/std/net.html#udp-地址)

UDP 地址支持 udp4，udp6，签名如下



```
func ResolveUDPAddr(network, address string) (*UDPAddr, error)
```

使用示例如下



```
package main

import (
  "fmt"
  "net"
)

func main() {
  udp4Addr, err := net.ResolveUDPAddr("udp4", "0.0.0.0:2020")
  if err != nil {
    panic(err)
  }
  fmt.Println(udp4Addr)
  udp6Addr, err := net.ResolveUDPAddr("udp6", "[::1]:8080")
  if err != nil {
    panic(err)
  }
  fmt.Println(udp6Addr)
}
```

###### [Unix 地址](https://golang.halfiisland.com/essential/std/net.html#unix-地址)

Unix 地址支持 unix，unixgram，unixpacket，签名如下

```
func ResolveUnixAddr(network, address string) (*UnixAddr, error)
```

使用示例如下



```
package main

import (
    "fmt"
    "net"
)

func main() {
    unixAddr, err := net.ResolveUnixAddr("unix", "/tmp/mysocket")
    if err != nil {
       panic(err)
    }
    fmt.Println(unixAddr)
}
```

##### [DNS](https://golang.halfiisland.com/essential/std/net.html#dns)

Go 还提供了很多函数用于 DNS 查询，下面一个例子是解析域名的 IP 地址



```
package main

import (
  "fmt"
  "net"
)

func main() {
  addrs, err := net.LookupHost("github.com")
  if err != nil {
    panic(err)
  }
  fmt.Println(addrs)
}
```

查询记录值



```
package main

import (
  "fmt"
  "net"
)

func main() {
  mxs, err := net.LookupMX("github.com")
  if err != nil {
    panic(err)
  }
  fmt.Println(mxs)
}
```

##### [网络编程](https://golang.halfiisland.com/essential/std/net.html#网络编程)

tcp 编程的逻辑十分简单，对于客户端而言就是

1. 建立连接
2. 发送数据或读取数据
3. 退出

对于服务端而言就是

1. 监听地址
2. 获取连接
3. 新建一个协程去处理该连接

下面是一个简单的例子，客户端代码



```
package main

import (
  "net"
)

func main() {
  // 建立连接
  conn, err := net.Dial("tcp", "0.0.0.0:1234")
  if err != nil {
    panic(err)
  }
  defer conn.Close()

  // 发送数据
  for i := range 10 {
    _, err := conn.Write([]byte{'a' + byte(i)})
    if err != nil {
      panic(err)
    }
  }
}
```

服务端代码



```
package main

import (
  "errors"
  "fmt"
  "io"
  "net"
  "sync"
)

func main() {
  // 监听地址
  listener, err := net.Listen("tcp", "0.0.0.0:1234")
  if err != nil {
    panic(err)
  }
  defer listener.Close()

  var wg sync.WaitGroup

  for {
    // 阻塞等待下一个连接建立
    conn, err := listener.Accept()
    if err != nil {
      panic(err)
    }

    // 开启一个新的协程去异步处理该连接
    wg.Add(1)
    go func() {
      defer wg.Done()
      buf := make([]byte, 4096)
      for {
        // 从连接中读取数据
        n, err := conn.Read(buf)
        if errors.Is(err, io.EOF) {
          break
        } else if err != nil {
          panic(err)
        }

        data := string(buf[:n])
        fmt.Println(data)
      }
    }()
  }

  wg.Wait()
}
```

客户端发送数据，服务端接收数据，这个例子非常的简单，服务端建立新连接时，只需开启一个新的协程就可以去处理，不需要阻塞，UDP 大体上的写法也都是类似的。

#### http

Go 语言标准库中的`net/http`包十分的优秀，提供了非常完善的 HTTP 客户端与服务端的实现，仅通过几行代码就可以搭建一个非常简单的 HTTP 服务器。

几乎所有的 go 语言中的 web 框架，都是对已有的 http 包做的封装与修改，因此，十分建议学习其他框架前先行掌握 http 包。

##### [Get 示例](https://golang.halfiisland.com/essential/std/http.html#get-示例)

关于 Http 相关的知识这里不再赘述，想要了解更多的话可以去百度。



```
func main() {
  resp, err := http.Get("https://baidu.com")
  if err != nil {
    fmt.Println(err)
    return
  }
  defer resp.Body.Close()
  content, err := io.ReadAll(resp.Body)
  fmt.Println(string(content))
}
```

通过直接调用 Http 包下的函数就可以发起简单的请求，会返回一个指针与错误，调用过后必须将其手动关闭。

##### [Post 示例](https://golang.halfiisland.com/essential/std/http.html#post-示例)



```
func main() {
   person := Person{
      UserId:   "120",
      Username: "jack",
      Age:      18,
      Address:  "usa",
   }

   json, _ := json.Marshal(person)
   reader := bytes.NewReader(json)

   resp, err := http.Post("https://golang.org", "application/json;charset=utf-8", reader)
   if err != nil {
      fmt.Println(err)
   }
   defer resp.Body.Close()
}
```

##### [客户端](https://golang.halfiisland.com/essential/std/http.html#客户端)

一般情况下，我们都不会直接使用上述的方法，而且会自己配置一个客户端来达到更加细致化的需求。这将会用到`http.Client{}`结构体，可提供的配置项总共有四个:

- `Transport`:配置 Http 客户端数据传输相关的配置项，没有就采用默认的策略
- `Timeout`：请求超时时间配置
- `Jar`：Cookie 相关配置
- `CheckRedirect`：重定向配置

##### [**简单示例**](https://golang.halfiisland.com/essential/std/http.html#简单示例)



```
func main() {
  client := &http.Client{}
  request, _ := http.NewRequest("GET", "https://golang.org", nil)
  resp, _ := client.Do(request)
  defer resp.Body.Close()
}
```

##### [**增加 header**](https://golang.halfiisland.com/essential/std/http.html#增加-header)



```
func main() {
   client := &http.Client{}
   request, _ := http.NewRequest("GET", "https://golang.org", nil)
   request.Header.Add("Authorization","123456")
   resp, _ := client.Do(request)
   defer resp.Body.Close()
}
```

一些详细的配置这里不会做过多的赘述，还请自行了解。

##### [服务端](https://golang.halfiisland.com/essential/std/http.html#服务端)

对于 go 而言，创建一个 http 服务器只需要一行代码。

第一个参数是监听的地址，第二个参数是处理器，如果为空的话则使用默认的处理器。大多数情况下使用默认的处理器 DefaultServeMux 即可。



```
http.ListenAndServe("localhost:8080", nil)
```

##### [**自定义**](https://golang.halfiisland.com/essential/std/http.html#自定义)

当然也可以自定义配置一个服务端



```
func main() {
   server := &http.Server{
      Addr:              ":8080",
      Handler:           nil,
      TLSConfig:         nil,
      ReadTimeout:       0,
      ReadHeaderTimeout: 0,
      WriteTimeout:      0,
      IdleTimeout:       0,
      MaxHeaderBytes:    0,
      TLSNextProto:      nil,
      ConnState:         nil,
      ErrorLog:          nil,
      BaseContext:       nil,
      ConnContext:       nil,
   }
   server.ListenAndServe()
}
```

一些详细的配置请自行了解。

##### [**路由**](https://golang.halfiisland.com/essential/std/http.html#路由)

首先需要首先自定义一个结构体实现`Handler`接口中的`ServeHTTP(ResponseWriter, *Request)`方法，再调用`http.handle()`函数即可



```
func main() {
   http.Handle("/index", &MyHandler{})
   http.ListenAndServe(":8080", nil)
}

type MyHandler struct {
}

func (h *MyHandler) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
   fmt.Println("my implement")
}
```

但是每一次都要自定义一个结构体将会十分的繁琐，也可以直接`http.handlerFunc`函数，我们只需要写处理函数即可，从而不用创建结构体。其内部是使用了适配器类型`HandlerFunc`,HandlerFunc 类型是一个适配器，允许将普通函数用作 HTTP 的处理器。如果 f 是具有适当签名的函数，HandlerFunc(f)是调用 f 的 Handler。



```
func main() {
   http.HandleFunc("/index", func(responseWriter http.ResponseWriter, request *http.Request) {
      fmt.Println(responseWriter, "index")
   })
   http.ListenAndServe(":8080", nil)
}
```

`ServerMux`是核心结构体，实现了基本的方法，`DefaultServeMux`是的默认实例。

##### [**反向代理**](https://golang.halfiisland.com/essential/std/http.html#反向代理)

http 包提供了开箱即用的反向代理功能



```
func main() {
   http.HandleFunc("/forward", func(writer http.ResponseWriter, request *http.Request) {
      director := func(request *http.Request) {
         request.URL.Scheme = "https"
         request.URL.Host = "golang.org"
         request.URL.Path = "index"
      }

      proxy := httputil.ReverseProxy{Director: director}
      proxy.ServeHTTP(writer, request)

   })

   http.ListenAndServe(":8080", nil)
}
```

上述代码会将所有请求转发到`https://golang.org/index`。

## 语言特性

### 范围

Go 语言中 range 关键字用于 for 循环中迭代数组(array)、切片(slice)、通道(channel)或集合(map)的元素。在数组和切片中它返回元素的索引和索引对应的值，在集合中返回 key-value 对。

for 循环的 range 格式可以对 slice、map、数组、字符串等进行迭代循环。格式如下：

```
for key, value := range oldMap {
    newMap[key] = value
}
```

以上代码中的 key 和 value 是可以省略。

如果只想读取 key，格式如下：

```
for key := range oldMap
```

或者这样：

for key, _ := range oldMap

如果只想读取 value，格式如下：

```
for _, value := range oldMap
```

#### 数组与切片

```
package main

import "fmt"

// 声明一个包含 2 的幂次方的切片
var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}

func main() {
   // 遍历 pow 切片，i 是索引，v 是值
   for i, v := range pow {
      // 打印 2 的 i 次方等于 v
      fmt.Printf("2**%d = %d\n", i, v)
   }
}
```

#### 字符串

range 迭代字符串时，返回每个字符的索引和 Unicode 代码点（rune）。

```
package main

import "fmt"

func main() {
    for i, c := range "hello" {
        fmt.Printf("index: %d, char: %c\n", i, c)
    }
}
```

#### 映射（Map）

for 循环的 range 格式可以省略 key 和 value，如下实例：

```
package main

import "fmt"

func main() {
    // 创建一个空的 map，key 是 int 类型，value 是 float32 类型
    map1 := make(map[int]float32)
    
    // 向 map1 中添加 key-value 对
    map1[1] = 1.0
    map1[2] = 2.0
    map1[3] = 3.0
    map1[4] = 4.0
   
    // 遍历 map1，读取 key 和 value
    for key, value := range map1 {
        // 打印 key 和 value
        fmt.Printf("key is: %d - value is: %f\n", key, value)
    }

    // 遍历 map1，只读取 key
    for key := range map1 {
        // 打印 key
        fmt.Printf("key is: %d\n", key)
    }

    // 遍历 map1，只读取 value
    for _, value := range map1 {
        // 打印 value
        fmt.Printf("value is: %f\n", value)
    }
}
```

#### 通道（Channel）

range 遍历从通道接收的值，直到通道关闭。

```
package main

import "fmt"

func main() {
    ch := make(chan int, 2)
    ch <- 1
    ch <- 2
    close(ch)
    
    for v := range ch {
        fmt.Println(v)
    }
}
```

#### 忽略值

在遍历时可以使用 **_** 来忽略索引或值。

```
package main

import "fmt"

func main() {
    nums := []int{2, 3, 4}
    
    // 忽略索引
    for _, num := range nums {
        fmt.Println("value:", num)
    }
    
    // 忽略值
    for i := range nums {
        fmt.Println("index:", i)
    }
}
```

#### 其他

range 遍历其他数据结构：

```
package main
import "fmt"
func main() {
    //这是我们使用 range 去求一个 slice 的和。使用数组跟这个很类似
    nums := []int{2, 3, 4}
    sum := 0
    for _, num := range nums {
        sum += num
    }
    fmt.Println("sum:", sum)
    //在数组上使用 range 将传入索引和值两个变量。上面那个例子我们不需要使用该元素的序号，所以我们使用空白符"_"省略了。有时侯我们确实需要知道它的索引。
    for i, num := range nums {
        if num == 3 {
            fmt.Println("index:", i)
        }
    }
    //range 也可以用在 map 的键值对上。
    kvs := map[string]string{"a": "apple", "b": "banana"}
    for k, v := range kvs {
        fmt.Printf("%s -> %s\n", k, v)
    }

    //range也可以用来枚举 Unicode 字符串。第一个参数是字符的索引，第二个是字符（Unicode的值）本身。
    for i, c := range "go" {
        fmt.Println(i, c)
    }
}
```

### 迭代器

在 Go 中，用于迭代特定数据结构的关键字为`for range`，之前的章节中已经介绍过它的一些应用，它仅能作用于语言内置的几个数据结构

- 数组
- 切片
- 字符串
- map
- chan
- 整型值

这样的话使用起来非常的不灵活，没有拓展性，对于自定义类型几乎不支持，不过好在 go1.23 版本更新以后，`for range`关键字支持了`range over func`，这样一来自定义迭代器也就成为了可能。

#### [认识](https://golang.halfiisland.com/essential/senior/91.iterator.html#认识)

下面通过一个例子来初步认识迭代器，不知道各位还是否记得在函数小节中讲解的[闭包求解斐波那契数列的例子](https://golang.halfiisland.com/essential/base/69.func.html#闭包)，它的实现代码如下



```
func Fibonacci(n int) func() (int, bool) {
  a, b, c := 1, 1, 2
  i := 0
  return func() (int, bool) {
    if i >= n {
      return 0, false
    } else if i < 2 {
      f := i
      i++
      return f, true
    }

    a, b = b, c
    c = a + b
    i++

    return a, true
  }
}
```

我们可以把它改造成迭代器，如下所示，可以看到代码量要减少了一些



```
func Fibonacci(n int) func(yield func(int) bool) {
  a, b, c := 0, 1, 1
  return func(yield func(int) bool) {
    for range n {
      if !yield(a) {
        return
      }
      a, b = b, c
      c = a + b
    }
  }
}
```

Go 的迭代器是`range over func`风格，我们可以直接用`for range`关键字来进行使用，使用起来也要比原来更方便



```
func main() {
    n := 8
  for f := range Fibonacci(n) {
    fmt.Println(f)
  }
}
```

输出如下



```
0
1
1
2
3
5
8
13
```

如上所示，迭代器就是一个闭包函数，它接受一个回调函数作为参数，你甚至可以在里面看到`yield`这种字眼，写过 python 的人应该都很熟悉，它与 python 中的生成器很类似。Go 的迭代器并没有新增任何关键字，语法特性，在上述示例中`yield`也只是一个回调函数，它并非关键字，官方取这个名字是为了方便理解。

#### [推送式迭代器](https://golang.halfiisland.com/essential/senior/91.iterator.html#推送式迭代器)

关于迭代器的定义，我们可以在`iter`库中找到如下解释

> An iterator is a function that passes successive elements of a sequence to a callback function, conventionally named yield.
>
> 迭代器是一个函数，它将序列中的元素逐个传递给回调函数，通常称为 yield。

我们从中可以明确的一点，迭代器就是一个函数，它接受一个回调函数作为参数，在迭代过程中会将序列中的元素逐个传递给回调函数`yield`。在之前示例中我们是按照下面的方式使用迭代器的



```
for f := range Fibonacci(n) {
    fmt.Println(f)
}
```

根据官方定义，上面迭代器`Backward`的例子使用就等同于下面这段代码



```
Fibonacci(n)(func(f int) bool {
    fmt.Println(f)
    return true
})
```

循环体的 body 就是迭代器的回调函数`yiled`，当函数返回`true`迭代器会继续迭代，否则就会停止。

此外，`iter`标准库中也定义了迭代器的类型`iter.Seq`，它的类型就是函数。



```
type Seq[V any] func(yield func(V) bool)

type Seq2[K, V any] func(yield func(K, V) bool)
```

`iter.Seq`的回调函数只接受一个参数，那么在迭代时`for range`仅有一个返回值，如下



```
for v := range iter {
  // body
}
```

`iter.Seq2`的回调函数接受两个参数，那么在迭代时`for range`就有两个返回值，如下



```
for k, v := range iter {
  // body
}
```

虽然标准库中没有定义 0 个参数的 Seq，但这也是完全允许的，它相当于



```
func(yield func() bool)
```

使用起来如下所示



```
for range iter {
  // body
}
```

回调函数的参数数量只能是 0 至 2 个，多了会无法通过编译。

简而言之，`for range`中的循环体就是迭代器中的`yield`回调函数，`for range`返回几个值，相应的`yeild`函数就有几个入参，每一轮迭代时，迭代器都会调用`yield`函数，也就是执行循环体中的代码，主动将序列中的元素传递给`yield`函数，这种主动传递元素的迭代器我们一般称之为推送式迭代器（pushing iterator），比较典型的例子就是其他语言中的`foreach`，比如 js



```
let arr = [1, 2, 3, 4, 5];
arr
  .filter((e) => e % 2 === 0)
  .forEach((e) => {
    console.log(e);
  });
```

在 Go 中的表现形式就是由`range`返回被迭代的元素。



```
for index, value := range iterator() {
  fmt.Println(index, value)
}
```

在某些语言（比如 Java）中它还有另一个叫法：数据流处理。

既然循环体中的代码是作为回调函数传入迭代器的，而且它很可能是一个闭包函数，Go 就需要让一个闭包函数在执行`defer`，`return`，`break`，`goto`等关键字时表现的像一个普通循环体代码段一样，思考下面几种情况。

比如说在迭代器循环中返回，那么在`yield`回调函数中要怎么去处理这个 return 呢？



```
for index, value := range iterator() {
    if value > 10 {
        return
  }
  fmt.Println(index, value)
}
```

不可能直接在回调函数中 return，这么做只会让迭代停止而已，达不到返回的效果



```
iterator()(func(index int, value int) bool {
  if value > 10 {
    return false
  }
  fmt.Println(index, value)
})
```

再比如说在迭代器循环中使用`defer`



```
for index, value := range iterator() {
    defer fmt.Println(index, value)
}
```

也不能直接在回调函数中使用`defer`，因为这么做的话在回调函数结束时就会直接延迟调用了



```
iterator()(func(index int, value int) bool {
  defer fmt.Println(index, value)
})
```

像其他的几个关键字`break`，`continue`，`goto`也是类似的，好在这些情况 Go 已经帮我们处理好了，我们只需使用即可，可以暂时不需要关心这些，如果感兴趣可以自行浏览[rangefunc/rewrite.go](https://github.com/golang/go/blob/go1.23.0/src/cmd/compile/internal/rangefunc/rewrite.go#L628)中的源代码。

#### [拉取式迭代器](https://golang.halfiisland.com/essential/senior/91.iterator.html#拉取式迭代器)

推送式迭代器（pushing iterator）是由迭代器来控制迭代的逻辑，用户被动获取元素，相反的拉取式迭代器（pulling iterator）就是由用户来控制迭代逻辑，主动的去获取序列元素。一般而言，拉取式迭代器都会有特定的函数如`next()`，`stop()`来控制迭代的开始或结束，它可以是一个闭包或者结构体。



```
scanner := bufio.NewScanner(file)
for scanner.Scan() {
    line, err := scanner.Text(), scanner.Err()
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Println(line)
}
```

如上所示，Scanner 通过方法`Text()`来获取文件中的下一行文本，通过方法`Scan()`来表示迭代是否结束，这也是拉取式迭代器的一种模式。Scanner 采用结构体来记录状态，而在`iter`库定义的拉取式迭代器采用闭包来记录状态，我们通过`iter.Pull`或`iter.Pull2`函数就可以将一个标准的推送式迭代器转换为拉取式迭代器，`iter.Pull`与`iter.Pull2`的区别就是后者的返回值有两个，签名如下



```
func Pull[V any](seq Seq[V]) (next func() (V, bool), stop func())

func Pull2[K, V any](seq Seq2[K, V]) (next func() (K, V, bool), stop func())
```

它们都接受一个迭代器作为参数，然后会返回两个函数`next()`和`stop()`，用于控制迭代的继续和停止。



```
func next() (V, bool)

func stop()
```

`next`会返回被迭代的元素，和一个表示当前值是否有效的布尔值，当迭代结束时`next`函数会返回元素的零值和`false`。`stop`函数会结束迭代过程，当调用者不再使用迭代器后，就必须使用`stop`函数来结束迭代。顺带一提，在多个协程调用同一个迭代器的`next`函数是错误的做法，因为它并非并发安全。

下面通过一个例子来演示，它的功能就是把之前的斐波那契迭代器改造成拉取式迭代器，如下



```
func main() {
  n := 10
  next, stop := iter.Pull(Fibonacci(n))
  defer stop()
  for {
    fibn, ok := next()
    if !ok {
      break
    }
    fmt.Println(fibn)
  }
}
```

输出



```
0
1
1
2
3
5
8
13
21
34
```

这样一来我们就可以通过`next`和`stop`函数来手动控制迭代的逻辑了。你或许可能会觉得这样做多此一举，如果要这样做的话那为什么不直接用最初的闭包版本就好了，一样可以自己控制迭代，闭包的用法是这样的



```
func main() {
  fib := Fibonacci(10)
    for {
        n, ok := fib()
        if !ok {
            break
        }
        fmt.Prinlnt(n)
    }
}
```

转换过程：闭包 → 迭代器 → 拉取式迭代器，闭包与拉取式迭代器的用法都大差不差，它们的思想都是一样的，后者还会因为各种各样的处理导致性能上的拖累。老实说这么做确实多此一举，它的应用场景确实不是很多，不过`iter.pull`是为了`iter.Seq`而存在的，也就是为了将推送式迭代器转换成拉取式迭代器的而存在的，如果你仅仅只是想要一个拉取式迭代器，还专门为此去实现一个推送式迭代器来进行转换，要这样做的话不妨考虑下自己实现的复杂度和性能，就像这个斐波那契数列的例子一样，绕了一圈又回到原点，唯一的好处可能就是符合官方的迭代器规范。

#### [错误处理](https://golang.halfiisland.com/essential/senior/91.iterator.html#错误处理)

在迭代时发生了错误怎么办？我们可以将其传递给`yield`函数让`for range`返回，让调用者来进行处理，就像下面这个行迭代器的例子一样



```
func ScanLines(reader io.Reader) iter.Seq2[string, error] {
  scanner := bufio.NewScanner(reader)
  return func(yield func(string, error) bool) {
    for scanner.Scan() {
      if !yield(scanner.Text(), scanner.Err()) {
        return
      }
    }
  }
}
```

提示

值得注意的是，`ScanLines`迭代器是一次性使用的，文件关闭以后就不能再次使用了。

可以看到它的第二个返回值是`error`类型，使用起来如下



```
for line, err := range ScanLines(file) {
    if err != nil {
        fmt.Println(err)
        break
    }
    fmt.Println(line)
}
```

这样处理起来就跟普通的错误处理没什么区别，拉取式迭代器也是同理



```
next, stop := iter.Pull2(ScanLines(file))
defer stop()
for {
    line, err, ok := next()
    if err != nil {
        fmt.Println(err)
        break
    } else if !ok {
        break
    }
    fmt.Println(line)
}
```

如果发生了 panic，就像平常一样使用`recovery`即可。



```
defer func() {
    if err := recover(); err != nil {
        fmt.Println("panic:", err)
        os.Exit(1)
    }
}()

for line, err := range ScanLines(file) {
    if err != nil {
        fmt.Println(err)
        break
    }
    fmt.Println(line)
}
```

拉取式迭代器依然同理，这里就不演示了。

#### [标准库](https://golang.halfiisland.com/essential/senior/91.iterator.html#标准库)

有很多标准库也支持了迭代器，最常用的就是`slices`和`maps`标准库，下面介绍几个比较实用的功能。

**slices.All**



```
func All[Slice ~[]E, E any](s Slice) iter.Seq2[int, E]
```

`slices.All`会将切片转换成一个切片迭代器



```
func main() {
  s := []int{1, 2, 3, 4, 5}
  for i, n := range slices.All(s) {
    fmt.Println(i, n)
  }
}
```

输出



```
0 1
1 2
2 3
3 4
4 5
```

**slices.Values**



```
func Values[Slice ~[]E, E any](s Slice) iter.Seq[E]
```

`slices.Values`会将切片转换成一个切片迭代器，但是不带索引



```
func main() {
  s := []int{1, 2, 3, 4, 5}
  for n := range slices.Values(s) {
    fmt.Println(n)
  }
}
```

输出



```
1
2
3
4
5
```

**slices.Chunk**



```
func Chunk[Slice ~[]E, E any](s Slice, n int) iter.Seq[Slice]
```

`slices.Chunk`函数会返回一个迭代器，该迭代器会以 n 个元素为切片推送给调用者



```
func main() {
  s := []int{1, 2, 3, 4, 5}
  for chunk := range slices.Chunk(s, 2) {
    fmt.Println(chunk)
  }
}
```

输出



```
[1 2]
[3 4]
[5]
```

**slices.Collect**



```
func Collect[E any](seq iter.Seq[E]) []E
```

`slices.Collect`函数会将切片迭代器收集成一个切片



```
func main() {
  s := []int{1, 2, 3, 4, 5}
  s2 := slices.Collect(slices.Values(s))
  fmt.Println(s2)
}
```

输出



```
[1 2 3 4 5]
```

**maps.Keys**



```
func Keys[Map ~map[K]V, K comparable, V any](m Map) iter.Seq[K]
```

`maps.Keys`会返回一个迭代 map 所有键的迭代器，配合`slices.Collect`可以直接收集成一个切片。



```
func main() {
  m := map[string]int{"one": 1, "two": 2, "three": 3}
  keys := slices.Collect(maps.Keys(m))
  fmt.Println(keys)
}
```

输出



```
[three one two]
```

由于 map 是无序的，所以输出也不固定

**maps.Values**



```
func Values[Map ~map[K]V, K comparable, V any](m Map) iter.Seq[V]
```

`maps.Values`会返回一个迭代 map 所有值的迭代器，配合`slices.Collect`可以直接收集成一个切片。



```
func main() {
  m := map[string]int{"one": 1, "two": 2, "three": 3}
  keys := slices.Collect(maps.Values(m))
  fmt.Println(keys)
}
```

输出



```
[3 1 2]
```

由于 map 是无序的，所以输出也不固定

**maps.All**



```
func All[Map ~map[K]V, K comparable, V any](m Map) iter.Seq2[K, V]
```

`maps.All`可以将一个 map 转换为成一个 map 迭代器



```
func main() {
  m := map[string]int{"one": 1, "two": 2, "three": 3}
  for k, v := range maps.All(m) {
    fmt.Println(k, v)
  }
}
```

一般不会这么直接用，都是拿来配合其他数据流处理函数的。

**maps.Collect**



```
func Collect[K comparable, V any](seq iter.Seq2[K, V]) map[K]V
```

`maps.Collect`可以将一个 map 迭代器收集成一个 map



```
func main() {
  m := map[string]int{"one": 1, "two": 2, "three": 3}
  m2 := maps.Collect(maps.All(m))
  fmt.Println(m2)
}
```

collect 函数一般作为数据流处理的终结函数来使用。

#### [链式调用](https://golang.halfiisland.com/essential/senior/91.iterator.html#链式调用)

通过上面标准库提供的函数，我们可以将其组合来处理数据流，比如对数据流进行排序，如下



```
sortedSlices := slices.Sorted(slices.Values(s))
```

go 的迭代器采用的是闭包，只能像这样嵌套函数调用，本身没法链式调用，调用链长了以后可读性会很差，但我们可以自己通过结构体来记录迭代器，就能够实现链式调用。

##### [demo](https://golang.halfiisland.com/essential/senior/91.iterator.html#demo)

一个简单的链式调用 demo 如下所示，它包含了`Filter`，`Map`，`Find`，`Some`等常用的功能。



```
package iterx

import (
  "iter"
  "slices"
)

type SliceSeq[E any] struct {
  seq iter.Seq2[int, E]
}

func (s SliceSeq[E]) All() iter.Seq2[int, E] {
  return s.seq
}

func (s SliceSeq[E]) Filter(filter func(int, E) bool) SliceSeq[E] {
  return SliceSeq[E]{
    seq: func(yield func(int, E) bool) {
      // 重新组织索引
      i := 0
      for k, v := range s.seq {
        if filter(k, v) {
          if !yield(i, v) {
            return
          }
          i++
        }
      }
    },
  }
}

func (s SliceSeq[E]) Map(mapFn func(E) E) SliceSeq[E] {
  return SliceSeq[E]{
    seq: func(yield func(int, E) bool) {
      for k, v := range s.seq {
        if !yield(k, mapFn(v)) {
          return
        }
      }
    },
  }
}

func (s SliceSeq[E]) Fill(fill E) SliceSeq[E] {
  return SliceSeq[E]{
    seq: func(yield func(int, E) bool) {
      for i, _ := range s.seq {
        if !yield(i, fill) {
          return
        }
      }
    },
  }
}

func (s SliceSeq[E]) Find(equal func(int, E) bool) (_ E) {
  for i, v := range s.seq {
    if equal(i, v) {
      return v
    }
  }
  return
}

func (s SliceSeq[E]) Some(match func(int, E) bool) bool {
  for i, v := range s.seq {
    if match(i, v) {
      return true
    }
  }
  return false
}

func (s SliceSeq[E]) Every(match func(int, E) bool) bool {
  for i, v := range s.seq {
    if !match(i, v) {
      return false
    }
  }
  return true
}

func (s SliceSeq[E]) Collect() []E {
  var res []E
  for _, v := range s.seq {
    res = append(res, v)
  }
  return res
}

func (s SliceSeq[E]) Sort(cmp func(x, y E) int) []E {
  collect := s.Collect()
  slices.SortFunc(collect, cmp)
  return collect
}

func (s SliceSeq[E]) SortStable(cmp func(x, y E) int) []E {
  collect := s.Collect()
  slices.SortStableFunc(collect, cmp)
  return collect
}

func Slice[S ~[]E, E any](s S) SliceSeq[E] {
  return SliceSeq[E]{seq: slices.All(s)}
}
```

然后我们就可以通过链式调用来处理了，看几个使用案例。

**处理元素值**



```
func main() {
  s := []string{"apple", "banana", "cherry"}
  all := iterx.Slice(s).Map(strings.ToUpper).All()
  for i, v := range all {
    fmt.Printf("index: %d, value: %s\n", i, v)
  }
}
```

输出



```
index: 0, value: APPLE
index: 1, value: BANANA
index: 2, value: CHERRY
```

**寻找某一个指定值**



```
func main() {
  s := []int{1, 2, 3, 4, 5}
  result := iterx.Slice(s).Find(func(i int, e int) bool {
    return e == 3
  })
  fmt.Println(result)
}
```

输出



```
3
```

**填充切片**



```
func main() {
  s := []int{1, 2, 3, 4, 5}
  result := iterx.Slice(s).Fill(6).Collect()
  fmt.Println(result)
}
```

输出



```
[6 6 6 6 6]
```

**过滤元素**



```
func main() {
  s := []int{1, 2, 3, 4, 5}
  filter := iterx.Slice(s).Filter(func(i int, e int) bool {
    return e%2 == 0
  }).All()
  for i, v := range filter {
    fmt.Printf("Index: %d, Value: %d\n", i, v)
  }
}
```

输出



```
Index: 0, Value: 2
Index: 1, Value: 4
```

比较可惜的是 Go 目前还不支持简写匿名函数，就像 js，rust，java 中的箭头函数一样，否则链式调用还可以更加简洁和优雅一些。

#### [性能](https://golang.halfiisland.com/essential/senior/91.iterator.html#性能)

因为 Go 对迭代器做了许多的处理，它的性能肯定是不如原生 for range 循环的，我们拿最简单的一个切片遍历来测试下它们的性能区别，分为下面几种

- 原生 for 循环
- 推送式迭代器
- 拉取式迭代器

测试代码如下，测试切片长度为 1000。

```
package main

import (
  "iter"
  "slices"
  "testing"
)

var s []int

const n = 10000

func init() {
  for i := range n {
    s = append(s, i)
  }
}

func testNaiveFor(s []int) {
  for i, n := range s {
    _ = i
    _ = n
  }
}

func testPushing(s []int) {
  for i, n := range slices.All(s) {
    _ = i
    _ = n
  }
}

func testPulling(s []int) {
  next, stop := iter.Pull2(slices.All(s))
  for {
    i, n, ok := next()
    if !ok {
      stop()
      return
    }
    _ = i
    _ = n
  }
}

func BenchmarkNaive_10000(b *testing.B) {
  for range b.N {
    testNaiveFor(s)
  }
}

func BenchmarkPushing_10000(b *testing.B) {
  for range b.N {
    testPushing(s)
  }
}

func BenchmarkPulling_10000(b *testing.B) {
  for range b.N {
    testPulling(s)
  }
}
```

测试结果如下



```
goos: windows
goarch: amd64
pkg: golearn
cpu: 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
BenchmarkNaive_10000
BenchmarkNaive_10000-16           492658              2398 ns/op               0 B/op          0 allocs/op
BenchmarkPushing_10000
BenchmarkPushing_10000-16         315889              3707 ns/op               0 B/op          0 allocs/op
BenchmarkPulling_10000
BenchmarkPulling_10000-16           2016            574509 ns/op             440 B/op         14 allocs/op
PASS
ok      golearn 4.029s
```

我们通过结果可以看到推送式迭代器与原生的`for range`循环相差不是特别大，但拉取式迭代器要比前面两个慢了几乎两个数量级，在使用的时候各位可以根据自己的实际情况来进行考虑。

### 反射

反射是一种在运行时检查语言自身结构的机制，它可以很灵活的去应对一些问题，但同时带来的弊端也很明显，例如性能问题等等。在 Go 中，反射与`interface{}`密切相关，很大程度上，只要有`interface{}`出现的地方，就会有反射。Go 中的反射 API 是由标准库`reflect`包提供的。

#### [接口](https://golang.halfiisland.com/essential/senior/105.reflect.html#接口)

在开始之前先简单的了解一下位于`runtime`包下的两个接口。在 Go 中，接口本质上是结构体，Go 在运行时将接口分为了两大类，一类是没有方法集的接口，另一个类则是有方法集的接口。对于含有方法集的接口来说，在运行时由如下的结构体`iface`来进行表示



```
type iface struct {
   tab  *itab // 包含 数据类型，接口类型，方法集等
   data unsafe.Pointer // 指向值的指针
}
```

而对于没有方法集接口来说，在运行时由`eface` 结构体来进行表示，如下



```
type eface struct {
   _type *_type // 类型
   data  unsafe.Pointer // 指向值的指针
}
```

而这两个结构体在`reflect`包下都有与其对应的结构体类型，`iface`对应的是`nonEmptyInterface`



```
type nonEmptyInterface struct {
  itab *struct {
    ityp *rtype // 静态接口类型
    typ  *rtype // 动态具体类型
    hash uint32 // 类型哈希
    _    [4]byte
    fun  [100000]unsafe.Pointer // 方法集
  }
  word unsafe.Pointer // 指向值的指针
}
```

而`eface`对应的是`emptyInterface`



```
type emptyInterface struct {
   typ  *rtype // 动态具体类型
   word unsafe.Pointer // 指向指针的值
}
```

对于这两种类型，官方给出了很明确的定义

- `nonEmptyInterface`： nonEmptyInterface is the header for an interface value with methods
- `emptyInterface`：emptyInterface is the header for an interface{} value

上述提到了动态具体类型这一词，原文为`dynamic concrete type`，首先 Go 语言是一个百分之百的静态类型语言，静态这一词是体现在对外表现的抽象的接口类型是不变的，而动态表示是接口底层存储的具体实现的类型是可以变化的。至此，对于接口的简单原理只需要了解到这里就足够满足后续反射的学习。

#### [桥梁](https://golang.halfiisland.com/essential/senior/105.reflect.html#桥梁)

在`reflect`包下，分别有`reflect.Type`接口类型来表示 Go 中的类型，`reflect.Value`结构体类型来表示 Go 中的值



```
type Type interface {
    ...

    Name() string

  PkgPath() string

  Size() uintptr

  String() string

  Kind() Kind

    ...
}

type Value struct {

   typ *rtype

   ptr unsafe.Pointer

   flag

}
```

上面的代码省略了很多细节，先只需要了解这两个类型的存在即可。Go 中所有反射相关的操作都是基于这两个类型，`reflect`包提供了两个函数来将 Go 中的类型转换为上述的两种类型以便进行反射操作，分别是`reflect.TypeOf`函数



```
func TypeOf(i any) Type
```

与`reflect.ValueOf`函数



```
func ValueOf(i any) Value
```

可以看到两个函数的参数类型都是`any`，也就是`interface{}`的别名。如果想要进行反射操作，就需要先将其类型转换为`interface{}`，这也是为什么前面提到了只要有反射就离不开空接口。不严谨的说，空接口就是连接 Go 类型系统与反射的桥梁，下图很形象的描述了其过程。

![img](./assets/reflect_1.png)

提示

下文中为了方便，统一使用别名`any`来替代`interface{}`

#### [核心](https://golang.halfiisland.com/essential/senior/105.reflect.html#核心)

在 Go 中有三个经典的反射定律，结合上面所讲的内容也就非常好懂，分别如下

1. 反射可以将`interface{}`类型变量转换成反射对象
2. 反射可以将反射对象还原成`interface{}`类型变量
3. 要修改反射对象，其值必须是可设置的

这三个定律便是 Go 反射的核心，当需要访问类型相关信息时，便需要用到`reflect.TypeOf`，当需要修改反射值时，就需要用到`reflect.ValueOf`

#### [类型](https://golang.halfiisland.com/essential/senior/105.reflect.html#类型)

`reflect.Type`代表着 Go 中的类型，使用`reflect.TypeOf()`函数可以将变量转换成`reflect.Type`。代码示例如下



```
func main() {
  str := "hello world!"
  reflectType := reflect.TypeOf(str)
  fmt.Println(reflectType)
}
```

输出结果为



```
string
```

##### [Kind](https://golang.halfiisland.com/essential/senior/105.reflect.html#kind)

对于`Type`而言，Go 内部使用`reflect.Kind`来表示 Go 中的基础类型，其本质上是无符号整型`uint`。



```
type Kind uint
```

`reflect`包使用`Kind`枚举出了 Go 中所有的基础类型，如下所示



```
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

`Kind`类型仅仅实现了`Stringer`接口的`String()`方法，该类型也仅有这一个方法，`String()`方法的返回值来自于一个其内部的 `slice`，如下所示，这种写法乍一看很像 map，但其实这是 Go 中的一种特殊的写法：索引初始化语法（index expressions in slice literals）



```
var kindNames = []string{
   Invalid:       "invalid",
   Bool:          "bool",
   Int:           "int",
   Int8:          "int8",
   Int16:         "int16",
   Int32:         "int32",
   Int64:         "int64",
   Uint:          "uint",
   Uint8:         "uint8",
   Uint16:        "uint16",
   Uint32:        "uint32",
   Uint64:        "uint64",
   Uintptr:       "uintptr",
   Float32:       "float32",
   Float64:       "float64",
   Complex64:     "complex64",
   Complex128:    "complex128",
   Array:         "array",
   Chan:          "chan",
   Func:          "func",
   Interface:     "interface",
   Map:           "map",
   Pointer:       "ptr",
   Slice:         "slice",
   String:        "string",
   Struct:        "struct",
   UnsafePointer: "unsafe.Pointer",
}
```



```
type Type interface{
    Kind() Kind
}
```

通过`Kind`，可以知晓空接口存储的值究竟是什么基础类型，例如



```
func main() {
    // 声明一个any类型的变量
  var eface any
    // 赋值
  eface = 100
    // 通过Kind方法，来获取其类型
  fmt.Println(reflect.TypeOf(eface).Kind())
}
```

输出结果



```
int
```

##### [Elem](https://golang.halfiisland.com/essential/senior/105.reflect.html#elem)



```
type Type interface{
    Elem() Type
}
```

使用`Type.Elem()`方法，可以判断类型为`any`的数据结构所存储的元素类型，可接收的底层参数类型必须是指针，切片，数组，通道，映射表其中之一，否则会`panic`。下面是代码示例



```
func main() {
  var eface any
  eface = map[string]int{}
  rType := reflect.TypeOf(eface)
    // key()会返回map的键反射类型
  fmt.Println(rType.Key().Kind())
  fmt.Println(rType.Elem().Kind())
}
```

输出为



```
string
int
```

指针也可以理解为是一个容器，对于指针使用`Elem()`会获得其指向元素的反射类型，代码示例如下



```
func main() {
  var eface any
    // 赋值指针
  eface = new(strings.Builder)
  rType := reflect.TypeOf(eface)
    // 拿到指针所指向元素的反射类型
  vType := rType.Elem()
    // 输出包路径
  fmt.Println(vType.PkgPath())
    // 输出其名称
  fmt.Println(vType.Name())
}
```



```
strings
Builder
```

对于数组，切片，通道用使用起来都是类似的。

##### [Size](https://golang.halfiisland.com/essential/senior/105.reflect.html#size)



```
type Type interface{
    Size() uintptr
}
```

通过`Size`方法可以获取对应类型所占的字节大小，示例如下



```
func main() {
  fmt.Println(reflect.TypeOf(0).Size())
  fmt.Println(reflect.TypeOf("").Size())
  fmt.Println(reflect.TypeOf(complex(0, 0)).Size())
  fmt.Println(reflect.TypeOf(0.1).Size())
  fmt.Println(reflect.TypeOf([]string{}).Size())
}
```

输出结果为



```
8
16
16
8
24
```

提示

使用`unsafe.Sizeof()`可以达到同样的效果

##### [Comparable](https://golang.halfiisland.com/essential/senior/105.reflect.html#comparable)



```
type Type interface{
    Comparable() bool
}
```

通过`Comparable`方法可以判断一个类型是否可以被比较，例子如下



```
func main() {
  fmt.Println(reflect.TypeOf("hello world!").Comparable())
  fmt.Println(reflect.TypeOf(1024).Comparable())
  fmt.Println(reflect.TypeOf([]int{}).Comparable())
  fmt.Println(reflect.TypeOf(struct{}{}).Comparable())
}
```

输出如下



```
true
true
false
true
```

##### [Implements](https://golang.halfiisland.com/essential/senior/105.reflect.html#implements)



```
type Type interface{
    Implements(u Type) bool
}
```

通过`Implements`方法可以判断一个类型是否实现了某一接口



```
type MyInterface interface {
  My() string
}

type MyStruct struct {
}

func (m MyStruct) My() string {
  return "my"
}

type HisStruct struct {
}

func (h HisStruct) String() string {
  return "his"
}

func main() {
  rIface := reflect.TypeOf(new(MyInterface)).Elem()
  fmt.Println(reflect.TypeOf(new(MyStruct)).Elem().Implements(rIface))
  fmt.Println(reflect.TypeOf(new(HisStruct)).Elem().Implements(rIface))
}
```

输出结果



```
true
false
```

##### [ConvertibleTo](https://golang.halfiisland.com/essential/senior/105.reflect.html#convertibleto)



```
type Type interface{
    ConvertibleTo(u Type) bool
}
```

使用`ConvertibleTo`方法可以判断一个类型是否可以被转换为另一个指定的类型



```
type MyInterface interface {
  My() string
}

type MyStruct struct {
}

func (m MyStruct) My() string {
  return "my"
}

type HisStruct struct {
}

func (h HisStruct) String() string {
  return "his"
}

func main() {
  rIface := reflect.TypeOf(new(MyInterface)).Elem()
  fmt.Println(reflect.TypeOf(new(MyStruct)).Elem().ConvertibleTo(rIface))
  fmt.Println(reflect.TypeOf(new(HisStruct)).Elem().ConvertibleTo(rIface))
}
```

输出



```
true
false
```

#### [值](https://golang.halfiisland.com/essential/senior/105.reflect.html#值)

`reflect.Value`代表着反射接口的值，使用`reflect.ValueOf()`函数可以将变量转换成`reflect.Value`。代码示例如下



```
func main() {
  str := "hello world!"
  reflectValue := reflect.ValueOf(str)
  fmt.Println(reflectValue)
}
```

输出结果为



```
hello world!
```

##### [Type](https://golang.halfiisland.com/essential/senior/105.reflect.html#type)



```
func (v Value) Type() Type
```

`Type`方法可以获取一个反射值的类型



```
func main() {
   num := 114514
   rValue := reflect.ValueOf(num)
   fmt.Println(rValue.Type())
}
```

输出



```
int
```

##### [Elem](https://golang.halfiisland.com/essential/senior/105.reflect.html#elem-1)



```
func (v Value) Elem() Value
```

获取一个反射值的元素反射值



```
func main() {
   num := new(int)
   *num = 114514
   // 以指针为例子
   rValue := reflect.ValueOf(num).Elem()
   fmt.Println(rValue.Interface())
}
```

输出



```
114514
```

##### [指针](https://golang.halfiisland.com/essential/senior/105.reflect.html#指针)

获取一个反射值的指针方式有两种



```
// 返回一个表示v地址的指针反射值
func (v Value) Addr() Value

// 返回一个指向v的原始值的uinptr 等价于 uintptr(Value.Addr().UnsafePointer())
func (v Value) UnsafeAddr() uintptr

// 返回一个指向v的原始值的uintptr
// 仅当v的Kind为 Chan, Func, Map, Pointer, Slice, UnsafePointer时，否则会panic
func (v Value) Pointer() uintptr

// 返回一个指向v的原始值的unsafe.Pointer
// 仅当v的Kind为 Chan, Func, Map, Pointer, Slice, UnsafePointer时，否则会panic
func (v Value) UnsafePointer() unsafe.Pointer
```

示例如下



```
func main() {
   num := 1024
   ele := reflect.ValueOf(&num).Elem()
   fmt.Println("&num", &num)
   fmt.Println("Addr", ele.Addr())
   fmt.Println("UnsafeAddr", unsafe.Pointer(ele.UnsafeAddr()))
   fmt.Println("Pointer", unsafe.Pointer(ele.Addr().Pointer()))
   fmt.Println("UnsafePointer", ele.Addr().UnsafePointer())
}
```

输出



```
&num 0xc0000a6058
Addr 0xc0000a6058
UnsafeAddr 0xc0000a6058
Pointer 0xc0000a6058
UnsafePointer 0xc0000a6058
```

提示

`fmt.Println`会反射获取参数的类型，如果是`reflect.Value`类型的话，会自动调用`Value.Interface()`来获取其原始值。

换成一个 map 再来一遍



```
func main() {
  dic := map[string]int{}
  ele := reflect.ValueOf(&dic).Elem()
  println(dic)
  fmt.Println("Addr", ele.Addr())
  fmt.Println("UnsafeAddr", *(*unsafe.Pointer)(unsafe.Pointer(ele.UnsafeAddr())))
  fmt.Println("Pointer", unsafe.Pointer(ele.Pointer()))
  fmt.Println("UnsafePointer", ele.UnsafePointer())
}
```

输出



```
0xc00010e4b0
Addr &map[]
UnsafeAddr 0xc00010e4b0
Pointer 0xc00010e4b0
UnsafePointer 0xc00010e4b0
```

##### [设置值](https://golang.halfiisland.com/essential/senior/105.reflect.html#设置值)



```
func (v Value) Set(x Value)
```

倘若通过反射来修改反射值，那么其值必须是可取址的，这时应该通过指针来修改其元素值，而不是直接尝试修改元素的值。



```
func main() {
   // *int
   num := new(int)
   *num = 114514
   rValue := reflect.ValueOf(num)
    // 获取指针指向的元素
   ele := rValue.Elem()
   fmt.Println(ele.Interface())
   ele.SetInt(11)
   fmt.Println(ele.Interface())
}
```

输出如下



```
114514
11
```

##### [获取值](https://golang.halfiisland.com/essential/senior/105.reflect.html#获取值)



```
func (v Value) Interface() (i any)
```

通过`Interface()`方法可以获取反射值原有的值



```
func main() {
   var str string
   str = "hello"
   rValue := reflect.ValueOf(str)
   if v, ok := rValue.Interface().(string); ok {
      fmt.Println(v)
   }
}
```

输出



```
hello
```

#### [函数](https://golang.halfiisland.com/essential/senior/105.reflect.html#函数)

通过反射可以获取函数的一切信息，也可以反射调用函数

##### [信息](https://golang.halfiisland.com/essential/senior/105.reflect.html#信息)

通过反射类型来获取函数的一切信息



```
func Max(a, b int) int {
   if a > b {
      return a
   }
   return b
}

func main() {
   rType := reflect.TypeOf(Max)
   // 输出函数名称,字面量函数的类型没有名称
   fmt.Println(rType.Name())
   // 输出参数，返回值的数量
   fmt.Println(rType.NumIn(), rType.NumOut())
   rParamType := rType.In(0)
   // 输出第一个参数的类型
   fmt.Println(rParamType.Kind())
   rResType := rType.Out(0)
   // 输出第一个返回值的类型
   fmt.Println(rResType.Kind())
}
```

输出



```
2 1
int
int
```

##### [调用](https://golang.halfiisland.com/essential/senior/105.reflect.html#调用)

通过反射值来调用函数



```
func (v Value) Call(in []Value) []Value
```



```
func main() {
   // 获取函数的反射值
   rType := reflect.ValueOf(Max)
   // 传入参数数组
   rResValue := rType.Call([]reflect.Value{reflect.ValueOf(18), reflect.ValueOf(50)})
   for _, value := range rResValue {
      fmt.Println(value.Interface())
   }
}
```

输出



```
50
```

#### [结构体](https://golang.halfiisland.com/essential/senior/105.reflect.html#结构体)

假设有如下结构体



```
type Person struct {
  Name    string `json:"name"`
  Age     int    `json:"age"`
  Address string `json:"address"`
  money   int
}

func (p Person) Talk(msg string) string {
  return msg
}
```

##### [访问字段](https://golang.halfiisland.com/essential/senior/105.reflect.html#访问字段)

`reflect.StructField`结构的结构如下



```
type StructField struct {
  // 字段名称
  Name string
  // 包名
  PkgPath string
  // 类型名
  Type      Type
  // Tag
  Tag       StructTag
  // 字段的字节偏移
  Offset    uintptr
  // 索引
  Index     []int
  // 是否为嵌套字段
  Anonymous bool
}
```

访问结构体字段的方法有两种，一种是通过索引来进行访问，另一种是通过名称。



```
type Type interface{
    Field(i int) StructField
}
```

通过索引访问的例子如下



```
func main() {
  rType := reflect.TypeOf(new(Person)).Elem()
  // 输出结构体字段的数量
  fmt.Println(rType.NumField())
  for i := 0; i < rType.NumField(); i++ {
    structField := rType.Field(i)
    fmt.Println(structField.Index, structField.Name, structField.Type, structField.Offset, structField.IsExported())
  }
}
```

输出



```
4
[0] Name string 0 true
[1] Age int 16 true
[2] Address string 24 true
[3] money int 40 false
```



```
type Type interface{
    FieldByName(name string) (StructField, bool)
}
```

通过名称访问的例子如下



```
func main() {
   rType := reflect.TypeOf(new(Person)).Elem()
   // 输出结构体字段的数量
   fmt.Println(rType.NumField())
   if field, ok := rType.FieldByName("money"); ok {
      fmt.Println(field.Name, field.Type, field.IsExported())
   }
}
```

输出



```
4
money int false
```

##### [修改字段](https://golang.halfiisland.com/essential/senior/105.reflect.html#修改字段)

倘若要修改结构体字段值，则必须传入一个结构体指针，下面是一个修改字段的例子



```
func main() {
  // 传入指针
  rValue := reflect.ValueOf(&Person{
    Name:    "",
    Age:     0,
    Address: "",
    money:   0,
  }).Elem()

  // 获取字段
  name := rValue.FieldByName("Name")
  // 修改字段值
  if (name != reflect.Value{}) { // 如果返回reflect.Value{}，则说明该字段不存在
    name.SetString("jack")
  }
  // 输出结构体
  fmt.Println(rValue.Interface())
}
```

输出



```
{jack 0  0}
```

对于修改结构体私有字段而言，需要进行一些额外的操作，如下



```
func main() {
  // 传入指针
  rValue := reflect.ValueOf(&Person{
    Name:    "",
    Age:     0,
    Address: "",
    money:   0,
  }).Elem()

  // 获取一个私有字段
  money := rValue.FieldByName("money")
  // 修改字段值
  if (money != reflect.Value{}) {
    // 构造指向该结构体未导出字段的指针反射值
    p := reflect.NewAt(money.Type(), money.Addr().UnsafePointer())
    // 获取该指针所指向的元素，也就是要修改的字段
    field := p.Elem()
    // 修改值
    field.SetInt(164)
  }
  // 输出结构体
  fmt.Printf("%+v\n", rValue.Interface())
}
```

##### [访问 Tag](https://golang.halfiisland.com/essential/senior/105.reflect.html#访问-tag)

获取到`StructField`后，便可以直接访问其 Tag



```
// 如果不存在，ok为false
func (tag StructTag) Lookup(key string) (value string, ok bool)

// 如果不存在，返回空字符串
func (tag StructTag) Get(key string) string
```

示例如下



```
func main() {
   rType := reflect.TypeOf(new(Person)).Elem()
   name, ok := rType.FieldByName("Name")
   if ok {
      fmt.Println(name.Tag.Lookup("json"))
      fmt.Println(name.Tag.Get("json"))
   }
}
```

输出



```
name true
name
```

##### [访问方法](https://golang.halfiisland.com/essential/senior/105.reflect.html#访问方法)

访问方法与访问字段的过程很相似，只是函数签名略有区别。`reflect.Method`结构体如下



```
type Method struct {
  // 方法名
  Name string
  // 包名
  PkgPath string
  // 方法类型
  Type  Type
  // 方法对应的函数，第一个参数是接收者
  Func  Value
  // 索引
  Index int
}
```

访问方法信息示例如下



```
func main() {
  // 获取结构体反射类型
  rType := reflect.TypeOf(new(Person)).Elem()
  // 输出方法个数
  fmt.Println(rType.NumMethod())
  // 遍历输出方法信息
  for i := 0; i < rType.NumMethod(); i++ {
    method := rType.Method(i)
    fmt.Println(method.Index, method.Name, method.Type, method.IsExported())
  }
}
```

输出



```
1
0 Talk func(main.Person, string) string true
```

如果想要获取方法的参数和返回值细节，可以通过`Method.Func`来进行获取，过程与访问函数信息一致，将上面的代码稍微修改下



```
func main() {
  // 获取结构体反射类型
  rType := reflect.TypeOf(new(Person)).Elem()
  // 输出方法个数
  fmt.Println(rType.NumMethod())
  // 遍历输出方法信息
  for i := 0; i < rType.NumMethod(); i++ {
    method := rType.Method(i)
    fmt.Println(method.Index, method.Name, method.Type, method.IsExported())
    fmt.Println("方法参数")
    for i := 0; i < method.Func.Type().NumIn(); i++ {
      fmt.Println(method.Func.Type().In(i).String())
    }
    fmt.Println("方法返回值")
    for i := 0; i < method.Func.Type().NumOut(); i++ {
      fmt.Println(method.Func.Type().Out(i).String())
    }
  }
}
```

可以看到第一个参数是`main.Person`，也就是接收者类型



```
1
0 Talk func(main.Person, string) string true
方法参数
main.Person
string
方法返回值
string
```

##### [调用方法](https://golang.halfiisland.com/essential/senior/105.reflect.html#调用方法)

调用方法与调用函数的过程相似，而且并不需要手动传入接收者，例子如下



```
func main() {
   // 获取结构体反射类型
   rValue := reflect.ValueOf(new(Person)).Elem()
   // 输出方法个数
   fmt.Println(rValue.NumMethod())
   // 遍历输出方法信息
   talk := rValue.MethodByName("Talk")
   if (talk != reflect.Value{}) {
      // 调用方法，并获取返回值
      res := talk.Call([]reflect.Value{reflect.ValueOf("hello,reflect!")})
      // 遍历输出返回值
      for _, re := range res {
         fmt.Println(re.Interface())
      }
   }
}
```

输出



```
1
hello,reflect!
```

#### [创建](https://golang.halfiisland.com/essential/senior/105.reflect.html#创建)

通过反射可以构造新的值，`reflect`包同时根据一些特殊的类型提供了不同的更为方便的函数。

##### [基本类型](https://golang.halfiisland.com/essential/senior/105.reflect.html#基本类型)



```
// 返回指向反射值的指针反射值
func New(typ Type) Value
```

以`string`为例



```
func main() {
   rValue := reflect.New(reflect.TypeOf(*new(string)))
   rValue.Elem().SetString("hello world!")
   fmt.Println(rValue.Elem().Interface())
}
```



```
hello world!
```

##### [结构体](https://golang.halfiisland.com/essential/senior/105.reflect.html#结构体-1)

结构体的创建同样用到`reflect.New`函数



```
type Person struct {
   Name    string `json:"name"`
   Age     int    `json:"age"`
   Address string `json:"address"`
   money   int
}

func (p Person) Talk(msg string) string {
   return msg
}

func main() {
   // 创建结构体反射值
   rType := reflect.TypeOf(new(Person)).Elem()
   person := reflect.New(rType).Elem()
   fmt.Println(person.Interface())
}
```

输出



```
{ 0  0}
```

##### [切片](https://golang.halfiisland.com/essential/senior/105.reflect.html#切片)

反射创建切片



```
func MakeSlice(typ Type, len, cap int) Value
```



```
func main() {
   // 创建切片反射值
   rValue := reflect.MakeSlice(reflect.TypeOf(*new([]int)), 10, 10)
   // 遍历赋值
   for i := 0; i < 10; i++ {
      rValue.Index(i).SetInt(int64(i))
   }
   fmt.Println(rValue.Interface())
}
```



```
[0 1 2 3 4 5 6 7 8 9]
```

##### [Map](https://golang.halfiisland.com/essential/senior/105.reflect.html#map)

反射创建 Map



```
func MakeMapWithSize(typ Type, n int) Value
```



```
func main() {
   //构建map反射值
   rValue := reflect.MakeMapWithSize(reflect.TypeOf(*new(map[string]int)), 10)
   // 设置值
   rValue.SetMapIndex(reflect.ValueOf("a"), reflect.ValueOf(1))
   fmt.Println(rValue.Interface())
}
```



```
map[a:1]
```

##### [管道](https://golang.halfiisland.com/essential/senior/105.reflect.html#管道)

反射创建管道



```
func MakeChan(typ Type, buffer int) Value
```



```
func main() {
   // 创建管道反射值
   makeChan := reflect.MakeChan(reflect.TypeOf(new(chan int)).Elem(), 0)
   fmt.Println(makeChan.Interface())
}
```

##### [函数](https://golang.halfiisland.com/essential/senior/105.reflect.html#函数-1)

反射创建函数



```
func MakeFunc(typ Type, fn func(args []Value) (results []Value)) Value
```



```
func main() {
    // 传入包装类型和函数体
  fn := reflect.MakeFunc(reflect.TypeOf(new(func(int))).Elem(), func(args []reflect.Value) (results []reflect.Value) {
    for _, arg := range args {
      fmt.Println(arg.Interface())
    }
    return nil
  })
  fmt.Println(fn.Type())
  fn.Call([]reflect.Value{reflect.ValueOf(1024)})
}
```

输出



```
func(int)
1024
```

#### [完全相等](https://golang.halfiisland.com/essential/senior/105.reflect.html#完全相等)

`reflect.DeepEqual`是反射包下提供的一个用于判断两个变量是否完全相等的函数，签名如下。



```
func DeepEqual(x, y any) bool
```

该函数对于每一种基础类型都做了处理，下面是一些类型判断方式。

- 数组：数组中的每一个元素都完全相等
- 切片：都为`nil`时，判为完全相等，或者都不为空时，长度范围内的元素完全相等
- 结构体：所有字段都完全相等
- 映射表：都为`nil`时，为完全相等，都不为`nil`时，每一个键所映射的值都完全相等
- 指针：指向同一个元素或指向的元素完全相等
- 接口：接口的具体类型完全相等时
- 函数：只有两者都为`nil`时才是完全相等，否则就不是完全相等

下面是一些例子：

**切片**



```
func main() {
   a := make([]int, 100)
   b := make([]int, 100)
   fmt.Println(reflect.DeepEqual(a, b))
}
```

输出



```
true
```

**结构体**



```
func main() {
   mike := Person{
      Name:   "mike",
      Age:    39,
      Father: nil,
   }

   jack := Person{
      Name:   "jack",
      Age:    18,
      Father: &mike,
   }

   tom := Person{
      Name:   "tom",
      Age:    18,
      Father: &mike,
   }
   fmt.Println(reflect.DeepEqual(mike, jack))
   fmt.Println(reflect.DeepEqual(tom, jack))
   fmt.Println(reflect.DeepEqual(jack, jack))
}
```

输出



```
false
false
true
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
