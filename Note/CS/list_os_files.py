import os
import sys

notes_dir = r'd:\Learn\Note\CS-Notes\notes'
files = os.listdir(notes_dir)

print("所有操作系统相关文件:")
for f in files:
    if '操作系统' in f:
        print(f)
        filepath = os.path.join(notes_dir, f)
        print(f"  路径: {filepath}")
        print(f"  存在: {os.path.exists(filepath)}")
        print()
