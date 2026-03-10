# 文件与目录

## 目录

这篇内容层次较多，先看目录更容易定位复习重点。

- [Linux 目录结构](#linux-目录结构)
- [绝对路径与相对路径](#绝对路径与相对路径)
- [文件类型](#文件类型)
- [基本操作命令](#基本操作命令)
- [文件查找](#文件查找)
- [文件属性](#文件属性)
- [常见问题](#常见问题)

## Linux 目录结构

Linux 采用树形目录结构，所有文件和目录都从根目录 / 开始。

### 重要目录

**/**：根目录，所有文件的起点

**/home**：用户主目录
- /home/username：普通用户的主目录
- 用户登录后默认在自己的主目录

**/root**：root 用户的主目录
- 不在 /home 下，单独的目录

**/etc**：系统配置文件
- /etc/passwd：用户信息
- /etc/group：用户组信息
- /etc/hosts：主机名映射
- 后端开发常看的配置文件都在这里

**/var**：可变数据
- /var/log：日志文件
- /var/run：运行时数据（如 PID 文件）
- 后端应用的日志通常在这里

**/tmp**：临时文件
- 系统重启后会清空
- 任何用户都可以写入

**/usr**：用户程序
- /usr/bin：用户命令
- /usr/lib：库文件
- /usr/local：本地安装的软件

**/bin**：基本命令
- 系统启动和修复需要的命令
- 如 ls、cp、mv

**/sbin**：系统管理命令
- 需要 root 权限的命令
- 如 ifconfig、reboot

**/dev**：设备文件
- /dev/null：黑洞设备，丢弃所有写入
- /dev/zero：零设备，读取时返回 0
- /dev/sda：第一块硬盘

**/proc**：进程信息（虚拟文件系统）
- /proc/cpuinfo：CPU 信息
- /proc/meminfo：内存信息
- /proc/[pid]：进程信息

**面试重点**：
- 知道常用目录的作用
- 知道日志在 /var/log
- 知道配置文件在 /etc
- 知道 /proc 是虚拟文件系统

## 绝对路径与相对路径

**绝对路径**：
- 从根目录 / 开始
- 例如：/home/user/file.txt
- 不管当前在哪个目录，路径都一样

**相对路径**：
- 从当前目录开始
- .：当前目录
- ..：上级目录
- 例如：./file.txt、../parent/file.txt

**例子**：
```ash
# 当前在 /home/user
cd /etc              # 绝对路径
cd ../etc            # 相对路径（从 /home 到 /etc）
cd ./documents       # 相对路径（进入当前目录下的 documents）
```

**面试重点**：
- 理解绝对路径和相对路径的区别
- 知道 . 和 .. 的含义

## 文件类型

Linux 中一切皆文件，但文件有不同类型。

### 普通文件（-）

- 文本文件、二进制文件、脚本等
- 最常见的文件类型

### 目录（d）

- 特殊的文件，存储文件名和 inode 的映射
- 可以包含其他文件和目录

### 符号链接（l）

- 软链接，指向另一个文件
- 类似 Windows 的快捷方式

### 字符设备（c）

- 字符流设备，如键盘、串口
- 例如：/dev/tty

### 块设备（b）

- 块存储设备，如硬盘
- 例如：/dev/sda

### 套接字（s）

- 进程间通信的接口
- 例如：/var/run/docker.sock

### 管道（p）

- 命名管道，进程间通信
- 例如：mkfifo mypipe

**查看文件类型**：
```ash
ls -l
# 第一个字符表示文件类型
# - 普通文件
# d 目录
# l 符号链接
# c 字符设备
# b 块设备
# s 套接字
# p 管道
```

**面试重点**：
- 知道常见的文件类型
- 知道目录是特殊文件
- 知道如何查看文件类型

## 基本操作命令

### 目录操作

**pwd**：显示当前目录
```ash
pwd
# /home/user
```

**cd**：切换目录
```ash
cd /etc              # 切换到 /etc
cd ~                 # 切换到主目录
cd -                 # 切换到上一次的目录
cd ..                # 切换到上级目录
```

**ls**：列出文件
```ash
ls                   # 列出当前目录
ls -l                # 详细信息
ls -a                # 包括隐藏文件（以 . 开头）
ls -lh               # 人类可读的文件大小
ls -lt               # 按时间排序
```

**mkdir**：创建目录
```ash
mkdir dir            # 创建目录
mkdir -p a/b/c       # 递归创建（父目录不存在时自动创建）
```

**rmdir**：删除空目录
```ash
rmdir dir            # 只能删除空目录
```

### 文件操作

**touch**：创建空文件或更新时间戳
```ash
touch file.txt       # 创建空文件
touch file.txt       # 更新文件的访问和修改时间
```

**cp**：复制文件
```ash
cp file1 file2       # 复制文件
cp -r dir1 dir2      # 递归复制目录
cp -p file1 file2    # 保留文件属性（权限、时间）
```

**mv**：移动或重命名文件
```ash
mv file1 file2       # 重命名
mv file1 /tmp/       # 移动到 /tmp
mv dir1 dir2         # 重命名目录
```

**rm**：删除文件
```ash
rm file              # 删除文件
rm -r dir            # 递归删除目录
rm -f file           # 强制删除，不提示
rm -rf dir           # 强制递归删除（危险命令）
```

**注意**：
- 
m -rf / 会删除整个系统，千万不要执行
- 删除前要确认路径，删除后无法恢复（除非有备份）

### 文件查看

**cat**：查看文件内容
```ash
cat file.txt         # 显示整个文件
cat -n file.txt      # 显示行号
```

**less**：分页查看文件
```ash
less file.txt        # 分页查看
# 空格：下一页
# b：上一页
# /pattern：搜索
# q：退出
```

**head**：查看文件开头
```ash
head file.txt        # 默认显示前 10 行
head -n 20 file.txt  # 显示前 20 行
```

**tail**：查看文件末尾
```ash
tail file.txt        # 默认显示后 10 行
tail -n 20 file.txt  # 显示后 20 行
tail -f file.txt     # 实时查看文件更新（常用于查看日志）
```

**面试重点**：
- 掌握常用命令的基本用法
- 知道 	ail -f 用于实时查看日志
- 知道 
m -rf 的危险性

## 文件查找

### find

按条件查找文件。

**按名称查找**：
```ash
find /home -name \"*.txt\"        # 查找所有 .txt 文件
find . -name \"file.txt\"          # 在当前目录查找
find /var/log -name \"*.log\"     # 查找日志文件
```

**按类型查找**：
```ash
find /home -type f               # 查找普通文件
find /home -type d               # 查找目录
find /home -type l               # 查找符号链接
```

**按大小查找**：
```ash
find /var -size +100M            # 查找大于 100M 的文件
find /var -size -1M              # 查找小于 1M 的文件
```

**按时间查找**：
```ash
find /tmp -mtime -7              # 查找 7 天内修改的文件
find /tmp -mtime +30             # 查找 30 天前修改的文件
```

**执行操作**：
```ash
find /tmp -name \"*.tmp\" -delete # 删除找到的文件
find /var/log -name \"*.log\" -exec gzip {} ; # 压缩找到的文件
```

### which

查找命令的路径。

```ash
which ls                         # /bin/ls
which python                     # /usr/bin/python
```

### whereis

查找命令的二进制文件、源码和手册。

```ash
whereis ls                       # ls: /bin/ls /usr/share/man/man1/ls.1.gz
```

### locate

快速查找文件（基于数据库）。

```ash
locate file.txt                  # 快速查找
updatedb                         # 更新数据库
```

**注意**：
- locate 基于数据库，速度快但可能不是最新
- ind 实时查找，速度慢但结果准确

**面试重点**：
- 掌握 ind 的基本用法
- 知道 which 用于查找命令路径
- 知道 ind 和 locate 的区别

## 文件属性

使用 ls -l 查看文件详细信息：

```ash
ls -l file.txt
# -rw-r--r-- 1 user group 1024 Jan 1 12:00 file.txt
```

**输出解释**：
- -rw-r--r--：文件类型和权限
  - 第 1 位：文件类型（- 普通文件，d 目录，l 符号链接）
  - 第 2-4 位：所有者权限（
w- 可读写）
  - 第 5-7 位：用户组权限（
-- 只读）
  - 第 8-10 位：其他人权限（
-- 只读）
- 1：硬链接数
- user：所有者
- group：用户组
- 1024：文件大小（字节）
- Jan 1 12:00：最后修改时间
- ile.txt：文件名

**面试重点**：
- 理解 ls -l 输出的含义
- 知道文件权限的表示方式

## 常见问题

**Q: 如何查看当前目录的完整路径？**  
A: 使用 pwd 命令。

**Q: 如何快速回到主目录？**  
A: 使用 cd ~ 或直接 cd。

**Q: 如何查看隐藏文件？**  
A: 使用 ls -a。隐藏文件以 . 开头。

**Q: 如何递归创建目录？**  
A: 使用 mkdir -p a/b/c。

**Q: 如何安全地删除文件？**  
A: 删除前先用 ls 确认，避免使用 
m -rf。可以先移动到临时目录，确认无误后再删除。

**Q: 如何实时查看日志文件？**  
A: 使用 	ail -f /var/log/app.log。

**Q: 如何查找大文件？**  
A: 使用 ind / -size +100M -exec ls -lh {} ;。

**Q: 绝对路径和相对路径哪个更好？**  
A: 看场景。脚本中用绝对路径更安全，手动操作用相对路径更方便。
