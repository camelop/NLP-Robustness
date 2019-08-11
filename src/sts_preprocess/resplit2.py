import pandas as pd
import csv
from csv import QUOTE_NONE
import random

data_dir = "./"
def read_table(loc):
    return pd.read_csv(loc, sep='\t', index_col=0, quoting=QUOTE_NONE)
train = read_table(data_dir+"train.tsv") # actually all

files = ['MSRpar', 'headlines', 'MSRvid', 'images']
trains_num = dict(zip(files, [1000, 1799, 1000, 1000]))
devs_num = dict(zip(files, [250, 450, 250, 250]))

examples = {f:[] for f in files}

for i in train.itertuples():
    f = i[2] 
    if f not in files:
        continue
    examples[f].append(list(i))

random.seed("TAPE")
new_trains = {f:None for f in files}
new_devs = {f:None for f in files}
for k, v in examples.items():
    random.shuffle(v)
    new_trains[k] = v[:trains_num[k]]
    new_devs[k] = v[trains_num[k]:]
    assert len(new_devs[k]) == devs_num[k]

header = ['index'] + list(train.columns)

'''
new_trains_all = sum([v for k, v in new_trains.items()], [])
random.shuffle(new_trains_all)
new_devs_all = sum([v for k, v in new_devs.items()], [])
random.shuffle(new_devs_all)
with open("train-{}.tsv".format("all"), 'w', newline='', encoding="UTF-8") as f:
    writer = csv.writer(f, delimiter='\t')
    writer.writerow(header)
    for l in new_trains_all:
        writer.writerow(l)
with open("dev-{}.tsv".format("all"), 'w', newline='', encoding="UTF-8") as f:
    writer = csv.writer(f, delimiter='\t')
    writer.writerow(header)
    for l in new_devs_all:
        writer.writerow(l)
'''

for f in files:
    with open("train-{}.tsv".format(f), 'w', newline='', encoding="UTF-8") as fout:
        writer = csv.writer(fout, delimiter='\t')
        writer.writerow(header)
        for l in new_trains[f]:
            writer.writerow(l)
    with open("dev-{}.tsv".format(f), 'w', newline='', encoding="UTF-8") as fout:
        writer = csv.writer(fout, delimiter='\t')
        writer.writerow(header)
        for l in new_devs[f]:
            writer.writerow(l)