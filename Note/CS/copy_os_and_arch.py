# -*- coding: utf-8 -*-
import shutil
import os

# 操作系统文件（需要重命名）
os_files_rename = {
    '操作系统 - 上下文切换.md': '计算机操作系统 - 上下文切换.md',
    '操作系统 - 用户态与内核态.md': '计算机操作系统 - 用户态与内核态.md',
    '操作系统 - 文件系统.md': '计算机操作系统 - 文件系统.md',
    '操作系统 - 高频判断.md': '计算机操作系统 - 高频判断.md'
}

# 检查是否有 I/O模型 文件
io_model_files = [
    '操作系统 - I/O模型.md',
    '计算机操作系统 - I/O模型.md',
    'I/O模型.md'
]

# 计算机组成原理文件（保持原名）
comp_arch_files = [
    '计算机组成原理 - 目录.md',
    '计算机组成原理 - 计算机如何工作.md',
    '计算机组成原理 - CPU与指令执行.md',
    '计算机组成原理 - 寄存器.md',
    '计算机组成原理 - RAM.md',
    '计算机组成原理 - CPU_Cache.md',
    '计算机组成原理 - 中断.md',
    '计算机组成原理 - 存储层次.md',
    '计算机组成原理 - 局部性原理.md',
    '计算机组成原理 - 二进制基础.md',
    '计算机组成原理 - 补码.md',
    '计算机组成原理 - 浮点数基础.md',
    '计算机组成原理 - 高频判断.md'
]

src_base = r'D:\Learn\Note\CS-Notes\Note\CS-Notes\notes'
dst_base = r'D:\Learn\Note\CS-Notes\notes'

count = 0
os_count = 0
arch_count = 0

print("=" * 60)
print("操作系统模块（重命名）")
print("=" * 60)

# 复制并重命名操作系统文件
for src_name, dst_name in os_files_rename.items():
    src = os.path.join(src_base, src_name)
    dst = os.path.join(dst_base, dst_name)
    try:
        if os.path.exists(src):
            shutil.copy2(src, dst)
            count += 1
            os_count += 1
            print(f'✓ {src_name} → {dst_name}')
        else:
            print(f'✗ 未找到: {src_name}')
    except Exception as e:
        print(f'✗ {src_name}: {e}')

# 检查 I/O模型 文件
print("\n检查 I/O模型 文件...")
io_found = False
for io_file in io_model_files:
    src = os.path.join(src_base, io_file)
    if os.path.exists(src):
        dst = os.path.join(dst_base, '计算机操作系统 - I/O模型.md')
        try:
            shutil.copy2(src, dst)
            count += 1
            os_count += 1
            print(f'✓ {io_file} → 计算机操作系统 - I/O模型.md')
            io_found = True
            break
        except Exception as e:
            print(f'✗ {io_file}: {e}')

if not io_found:
    print('✗ 未找到 I/O模型 文件')

print("\n" + "=" * 60)
print("计算机组成原理模块")
print("=" * 60)

# 复制计算机组成原理文件
for f in comp_arch_files:
    src = os.path.join(src_base, f)
    dst = os.path.join(dst_base, f)
    try:
        if os.path.exists(src):
            shutil.copy2(src, dst)
            count += 1
            arch_count += 1
            print(f'✓ {f}')
        else:
            print(f'✗ 未找到: {f}')
    except Exception as e:
        print(f'✗ {f}: {e}')

print("\n" + "=" * 60)
print("复制完成")
print("=" * 60)
print(f'操作系统模块: {os_count} 个文件')
print(f'计算机组成原理模块: {arch_count} 个文件')
print(f'总计: {count} 个文件')
