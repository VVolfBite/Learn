# 常用命令与文本处理

后端开发日常排查的核心命令，聚焦实战场景。

## 目录

这篇内容层次较多，先看目录更容易定位复习重点。

- [日志查看](#日志查看)
- [文本搜索](#文本搜索)
- [文本处理](#文本处理)
- [压缩解压](#压缩解压)
- [系统监控](#系统监控)
- [场景](#场景)
- [面试重点](#面试重点)

## 日志查看

```bash
tail -f app.log                       # 实时查看
tail -f app.log | grep ERROR          # 只看错误
tail -n 100 app.log                   # 最后 100 行
less huge.log                         # 大文件分页查看
```

## 文本搜索

### grep - 查找关键词

```bash
grep "ERROR" app.log                  # 查找错误
grep -i "error" app.log               # 忽略大小写
grep -A 5 "ERROR" app.log             # 显示错误后 5 行
grep -r "timeout" /var/log/           # 递归查找
```

## 文本处理

### awk - 提取列

```bash
awk ''{print $1}'' access.log           # 提取第 1 列
ps aux | awk ''{print $2}''             # 提取 PID
awk -F: ''{print $1}'' /etc/passwd      # 指定分隔符
```

### sed - 替换

```bash
sed ''s/old/new/g'' file.txt            # 替换
sed -i ''s/old/new/g'' file.txt         # 直接修改文件
```

### sort + uniq - 排序去重

```bash
sort file.txt | uniq                  # 去重
sort file.txt | uniq -c               # 统计重复次数
```

### wc - 统计

```bash
wc -l file.txt                        # 统计行数
grep ERROR app.log | wc -l            # 统计错误数
```

## 压缩解压

```bash
tar -czvf backup.tar.gz dir/          # 压缩
tar -xzvf backup.tar.gz               # 解压
```

## 系统监控

```bash
df -h                                 # 磁盘使用
du -sh dir/                           # 目录大小
free -h                               # 内存使用
top                                   # 进程监控
```

## 场景

### 分析错误日志

```bash
# 统计错误数
grep ERROR app.log | wc -l

# 找最常见的错误
grep ERROR app.log | sort | uniq -c | sort -rn | head -10

# 查看错误上下文
grep -A 10 -B 10 "NullPointerException" app.log
```

### 分析访问日志

```bash
# 访问最多的 IP
awk ''{print $1}'' access.log | sort | uniq -c | sort -rn | head -10

# 访问最多的 URL
awk ''{print $7}'' access.log | sort | uniq -c | sort -rn | head -10
```

### 查找大文件

```bash
# 大于 100M 的文件
find /var/log -size +100M -exec ls -lh {} \;

# 目录占用排序
du -sh /var/log/* | sort -h | tail -10
```

## 面试重点

这一节看起来往往容易变成一串要点，其实先理解“面试重点”在Linux里的作用会更顺。后面的内容可以理解成围绕这个问题展开的几种常见情况。

这一节看起来往往容易变成一串结论，其实先抓住“面试重点”在Linux里的作用会更稳。后面的内容可以理解成围绕这个问题展开的几种常见判断和做法。

- `tail -f` 实时查看日志
- `grep` 搜索关键词
- `awk` 提取列
- `sort | uniq -c` 统计去重
- `tar` 压缩解压
- 管道组合使用
