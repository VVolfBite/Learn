# Shell 与重定向

## 目录

这篇内容层次较多，先看目录更容易定位复习重点。

- [标准输入、标准输出、标准错误](#标准输入标准输出标准错误)
- [重定向](#重定向)
- [管道](#管道)
- [环境变量](#环境变量)
- [特殊符号](#特殊符号)
- [场景](#场景)
- [面试重点](#面试重点)

## 标准输入、标准输出、标准错误

每个进程都有三个标准流：

| 描述符 | 名称 | 默认 |
|--------|------|------|
| 0 | stdin | 键盘 |
| 1 | stdout | 终端 |
| 2 | stderr | 终端 |

**核心**：标准输出和标准错误是分开的，可以分别重定向。

## 重定向

```bash
# 输出重定向
command > file                # 覆盖
command >> file               # 追加
command 2> file               # 错误重定向
command > file 2>&1           # 输出和错误都重定向
command > /dev/null 2>&1      # 丢弃所有输出

# 输入重定向
command < file                # 从文件读取
```

**`2>&1` 含义**：将标准错误（2）重定向到标准输出（1）

**易错点**：`command > file 2>&1` 正确 正确，`command 2>&1 > file` 错误 错误

## 管道

```bash
command1 | command2           # 命令 1 的输出给命令 2

# 实战
ps aux | grep java            # 查找进程
tail -f app.log | grep ERROR  # 实时查看错误
grep ERROR app.log | wc -l    # 统计错误数
```

**管道 vs 重定向**：管道连接命令，重定向连接文件。

## 环境变量

```bash
echo $PATH                    # 查看 PATH
export PATH=$PATH:/new/path   # 临时添加
```

**PATH**：命令搜索路径，决定 Shell 在哪里查找命令。

## 特殊符号

```bash
command1 ; command2           # 顺序执行
command1 && command2          # 成功才执行
command1 || command2          # 失败才执行
command &                     # 后台运行
```

## 场景

```bash
# 日志分析
tail -f app.log | grep ERROR
grep ERROR app.log | sort | uniq -c | sort -rn

# 批量操作
ps aux | grep java | awk ''{print $2}'' | xargs kill

# 错误排查
command > output.log 2>&1
command 2>&1 | tee output.log
```

## 面试重点

这一节主要把“面试重点”放回“Linux - Shell 与重定向”这张卡片的主线里看。先抓住它在整个Linux知识体系中的位置，再看后面的分点和对比，会更容易把零散结论串起来。

这一节主要把“面试重点”放回“Linux - Shell 与重定向”这条主线里看。先抓住它在整个Linux知识体系中的位置，再去看后面的分类和结论，会更容易把零散的判断串起来。

- 标准输入（0）、标准输出（1）、标准错误（2）
- `>` 覆盖、`>>` 追加
- `2>&1` 的含义和顺序
- 管道 `|` 连接命令
- PATH 环境变量
