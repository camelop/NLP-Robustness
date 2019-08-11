import os

dir_to_sample = [
    "AMAZON-B",
    "AMAZON-BC",
    "AMAZON-C",
    "AMAZON-MC",
    "AMAZON-MS",
    "AMAZON-MV",
    "AMAZON-S",
    "AMAZON-WC",
]

data_path = "data/raw_dataset"
expected_num = int(5e4)
train_num = int(expected_num*0.8)
dev_num = expected_num - train_num

import random
from pprint import pprint
from collections import Counter
from ast import literal_eval as l_eval
random.seed("AMAZON")

for d in dir_to_sample:
    print("Processing {}".format(d))
    ori_dir = os.path.join(data_path, d)
    target_dir = ori_dir+"-SAMPLE"
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
    dev_loc = os.path.join(ori_dir, "dev.tsv")
    train_loc = os.path.join(ori_dir, "train.tsv")
    results = {}
    statistic = []
    with open(train_loc, 'r') as fin:
        for line in fin:
            sentence = line.split('\t')[2]
            score = l_eval(line.split('\t')[1])
            if sentence in results:
                continue
            results[sentence] = line
            statistic.append(score)
            if len(results) >= expected_num:
                break
    pprint(sorted(dict(Counter(statistic)).items()))
    assert len(results) == expected_num
    dev_loc = os.path.join(target_dir, "dev.tsv")
    train_loc = os.path.join(target_dir, "train.tsv")
    output = list(results.values())
    random.shuffle(output)
    with open(train_loc, 'w', newline='', encoding="UTF-8") as fout:
        for l in output[:train_num]:
            fout.write(l)
    with open(dev_loc, 'w', newline='', encoding="UTF-8") as fout:
        for l in output[train_num:]:
            fout.write(l)
    