import os, json
from tqdm import tqdm
import csv

complete_path = "data/raw_dataset/AMAZON/complete.json"
metadata_path = "data/raw_dataset/AMAZON/metadata.json"

# generate all_cat.txt
'''
all_cat = set()
with open(metadata_path) as f:
    for l in tqdm(f, total=9400000):
        d = eval(l)
        if 'categories' not in d:
            continue
        cs = d['categories']
        for c in cs:
            c = tuple(c)
            if c not in all_cat:
                all_cat.add(c)
                print(c)

with open("all_cat.txt", 'w') as fout:
    for c in all_cat:
        fout.write(str(c))
        fout.write('\n')
'''

# sort all_cat
'''
with open("all_cat.txt") as fin:
    all_cat = []
    from ast import literal_eval
    for l in fin:
        t = literal_eval(l)
        all_cat.append(t)

with open("all_cat.txt", 'w') as fout:
    for c in sorted(all_cat):
        fout.write(str(c))
        fout.write('\n')
'''
# generate focus list
focus_list_output_loc = "focus.json"
labels = {
    "Clothes": lambda x: "Clothing" in x and "Shoes" not in x,
    "Women Clothing": lambda x: "Clothing" in x and "Women" in x and  "Shoes" not in x,
    "Men Clothing": lambda x: "Clothing" in x and "Men" in x and  "Shoes" not in x,
    "Baby Clothing": lambda x: "Clothing" in x and "Baby" in x and  "Shoes" not in x,
    "Shoes": lambda x: "Shoes" in x,
    "Music": lambda x: ("CDs & Vinyl" in x or "Digital Music" in x) and "Books" not in x,
    "Movies": lambda x: "Movies" in x and "Books" not in x,
    "Books": lambda x: 'Books' in x,
}
'''
with open(metadata_path) as fin, open(focus_list_output_loc, "w") as fout:
    for l in tqdm(fin, total=9500000):
        d = eval(l)
        if 'categories' not in d or 'asin' not in d:
            continue
        cs = sum(d['categories'], [])
        ls = []
        for label, f in labels.items():
            if f(cs):
                ls.append(label)
        if ls:
            fout.write(str({"asin": d['asin'], "label": ls}))
            fout.write('\n') 
'''

import time, pickle
from ast import literal_eval as l_eval
'''
focus = {}
t1 = time.time()
print("Loading focus list")
with open(focus_list_output_loc) as fin:
    for l in tqdm(fin, total=4240092):
        d = l_eval(l)
        focus[d['asin']] = d['label'] # 200 seconds
with open("focus.pickle", 'wb') as fout:
    pickle.dump(focus, fout)
with open("focus.pickle", 'rb') as fin:
    x = pickle.load(fin) # 10 seconds
print("Loading focus list finished, used_time: {}".format(time.time()-t1))
'''

'''

def parse(path):
    with open(path) as fin:
        for l in fin:
            yield l_eval(l)

t1 = time.time()
print("Loading focus list")
with open("focus.pickle", 'rb') as fin:
    focus = pickle.load(fin) # 10 seconds
print("Loading focus list finished, used_time: {}".format(time.time()-t1))

import csv
fouts = {label:open("amazon_split/{}-all.tsv".format(label.replace(' ', '_').lower()), 'w', newline="", encoding="UTF-8") for label, _ in labels.items()}
writers = {label:csv.writer(f, delimiter='\t') for label, f in fouts.items()}

# tryit = 50

for d in tqdm(parse(complete_path), total=142900000):
    if "asin" not in d or "reviewText" not in d or "overall" not in d:
        continue
    asin = d['asin']
    if asin not in focus:
        continue
    reviewText = d['reviewText']
    overall = d['overall']
    for l in focus[asin]:
        writers[l].writerow([asin, overall, reviewText])
    # tryit -= 1
    # if tryit < 0:
    #     break

for d in fouts.values():
    d.close()

'''

# make folder for each task
shorthand = {
    'baby_clothing': "AMAZON-BC",
    'books': "AMAZON-B",
    'clothes': "AMAZON-C",
    'men_clothing': "AMAZON-MC",
    'women_clothing': "AMAZON-WC",
    'movies': "AMAZON-MV",
    'music': "AMAZON-MS",
    'shoes': "AMAZON-S"
}
for k, v in shorthand.items():
    print("begin -> {}".format(k))
    def create_folder(loc):
        if not os.path.exists(loc):
            os.makedirs(loc)
    folder = "amazon_split/{}".format(v)
    create_folder(folder)
    with open("amazon_split/{}-all.tsv".format(k)) as fin:
        f_train = open(folder+'/train.tsv', 'w', newline='', encoding="UTF-8")
        f_dev = open(folder+'/dev.tsv', 'w', newline='', encoding="UTF-8")
        s_train, n_train = 0, 0
        s_dev, n_dev = 0, 0
        for i, l in enumerate(fin):
            if i % 5 == 0:
                f_dev.write(l)
                s_dev += l_eval(l.split('\t')[1])
                n_dev += 1
            else:
                f_train.write(l)
                s_train += l_eval(l.split('\t')[1])
                n_train += 1
        print(s_train, n_train, s_dev, n_dev)
        f_train.close()
        f_dev.close()