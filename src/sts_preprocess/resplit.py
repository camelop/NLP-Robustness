import pandas as pd
import csv
from csv import QUOTE_NONE
import random

data_dir = "./"
def read_table(loc):
    return pd.read_csv(loc, sep='\t', index_col=0, quoting=QUOTE_NONE)
train = read_table(data_dir+"train.tsv") # actually all

genres = [("main-news", ), ("main-captions", ), ("main-forum", "main-forums")]
trains_num = dict(zip(genres, [3039, 2100, 660]))
devs_num = dict(zip(genres, [760, 525, 165]))
map_to_genre = {}
for gs in genres:
    for g in gs:
        map_to_genre[g] = gs

examples = {g:[] for g in genres}
for i in train.itertuples():
    g = map_to_genre[i[1]]
    examples[g].append(list(i))

random.seed("TAPE")
new_trains = {g:None for g in genres}
new_devs = {g:None for g in genres}
for k, v in examples.items():
    random.shuffle(v)
    new_trains[k] = v[:trains_num[k]]
    new_devs[k] = v[trains_num[k]:]
    assert len(new_devs[k]) == devs_num[k]
new_trains_all = sum([v for k, v in new_trains.items()], [])
random.shuffle(new_trains_all)
new_devs_all = sum([v for k, v in new_devs.items()], [])
random.shuffle(new_devs_all)

header = ['index'] + list(train.columns)
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

for g in genres:
    with open("train-{}.tsv".format(g[0]), 'w', newline='', encoding="UTF-8") as f:
        writer = csv.writer(f, delimiter='\t')
        writer.writerow(header)
        for l in new_trains[g]:
            writer.writerow(l)
    with open("dev-{}.tsv".format(g[0]), 'w', newline='', encoding="UTF-8") as f:
        writer = csv.writer(f, delimiter='\t')
        writer.writerow(header)
        for l in new_devs[g]:
            writer.writerow(l)