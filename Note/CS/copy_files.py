# -*- coding: utf-8 -*-
import shutil
import os

files = [
    '算法与数据结构 - 1.复杂度分析.md',
    '算法与数据结构 - 2.数组与链表.md',
    '算法与数据结构 - 3.栈与队列.md',
    '算法与数据结构 - 4.哈希表.md',
    '算法与数据结构 - 目录.md',
    '算法与数据结构 - 完整知识体系.md',
    '算法与数据结构改造报告.md',
    '计算机网络 - 01 网络基础总览.md',
    '计算机网络 - 02 OSI与TCP-IP模型.md',
    '计算机网络 - 09 HTTPS与TLS.md',
    '计算机网络 - 10 DNS与CDN.md',
    '计算机网络 - 12 Cookie、Session与Token.md',
    '计算机网络 - 13 网络安全基础.md',
    '计算机网络 - 14 网络高频判断.md',
    '计算机操作系统 - 目录.md'
]

src_base = r'D:\Learn\Note\CS-Notes\Note\CS-Notes\notes'
dst_base = r'D:\Learn\Note\CS-Notes\notes'

count = 0
for f in files:
    src = os.path.join(src_base, f)
    dst = os.path.join(dst_base, f)
    try:
        shutil.copy2(src, dst)
        count += 1
        print(f'✓ {f}')
    except Exception as e:
        print(f'✗ {f}: {e}')

print(f'\n总计复制: {count}/{len(files)} 个文件')
