
src = "MSRPAR"
src_file_id = [
    42, 46, 47, 48, 52, 54, ...
]

import os
cnt = 100  # TODO: Change this

targets = [
    'headlines',
    'msrvid',
    'images'
]

def create_config(old_path, new_path, old_task, new_task, dryrun=True):
    if dryrun:
        return  # dryrun mode
    with open(old_path, 'r') as f_old, open(new_path, 'w') as f_new:
        for l in f_old.readlines():
            f_new.write(l.replace(old_task, new_task))
            f_new.write('\n')


path_to_dir = "config/experiment2"
created = []
for t in targets:
    to_create = []
    for fname in os.listdir(path_to_dir):    
        # TODO: scan the file dir to pick up id
        fid = int(fname.split(".json")[0].split("-")[-1])
        if fid in src_file_id:
            to_create.append((fid, fname))
    for fid, fname in sorted(to_create):
        path_to_src_file = os.path.join(path_to_dir, fname)
        new_fid = cnt
        cnt += 1
        new_fname = fname.replace(str(fid), new_fid)
        created.append((new_fid, new_fname))
        create_config(path_to_src_file, os.path.join(path_to_dir, new_fname), src, t)

print(created)