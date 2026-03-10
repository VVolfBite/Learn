import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

notes_dir = r'd:\Learn\Note\CS-Notes\notes'
files = os.listdir(notes_dir)

os_files = [f for f in files if f.startswith('璁＄畻鏈烘搷浣滅郴缁?)]
print('鎿嶄綔绯荤粺鐩稿叧鏂囦欢:')
for f in sorted(os_files):
    print(f'  {f}')
    filepath = os.path.join(notes_dir, f)
    print(f'    鏂囦欢澶у皬: {os.path.getsize(filepath)} bytes')
