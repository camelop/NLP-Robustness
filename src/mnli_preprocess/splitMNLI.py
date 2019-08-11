import pandas as pd
import csv
from csv import QUOTE_NONE
import random

train_loc = "train.tsv"
dev_loc = "dev.tsv"
def read_table(loc):
    return pd.read_csv(loc, sep='\t', index_col=0, quoting=QUOTE_NONE)

train = read_table(train_loc)
dev = read_table(dev_loc)

# telephone - face2face/letter
header = ['index'] + list(train.columns)

def write_split(s, tag, genre):
    cnt = 0
    with open("{}.tsv".format(tag), 'w', encoding="UTF-8") as fout:
        writer = csv.writer(fout, delimiter='\t')
        writer.writerow(header)
        for i in s.itertuples():
            if i[3] == genre:
                cnt += 1
                writer.writerow(list(i))
    print(genre, cnt)

write_split(train, "train-telephone", "telephone")
write_split(dev, "dev-telephone", "telephone")
write_split(dev, "dev-letters", "letters")
write_split(dev, "dev-facetoface", "facetoface")