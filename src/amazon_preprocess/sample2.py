import os

dir_to_sample = [
    "AMAZON-BC",
    "AMAZON-B",
    "AMAZON-C",
    "AMAZON-MC",
    "AMAZON-MS",
    "AMAZON-MV",
    "AMAZON-S",
    "AMAZON-WC",
]
# sample again
# dir_to_sample = [d + "-SAMPLE" for d in dir_to_sample]
# no, that is wrong

data_path = "data/raw_dataset"
expected_num = int(3e3*5)
train_num = int(expected_num*0.8)
dev_num = expected_num - train_num

import random
from pprint import pprint
from collections import Counter
from ast import literal_eval as l_eval
random.seed("AMAZON")

from tqdm import tqdm
for d in dir_to_sample:
    print("Processing {}".format(d))
    ori_dir = os.path.join(data_path, d)
    target_dir = ori_dir+"-SAMPLE2"
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
    dev_loc = os.path.join(ori_dir, "dev.tsv")
    train_loc = os.path.join(ori_dir, "train.tsv")
    results = {}
    statistic = Counter()
    for loc in [train_loc, dev_loc]:
        with open(loc, 'r') as fin, tqdm(total=expected_num) as pbar:
            for line in fin:
                sentence = line.split('\t')[2]
                score = l_eval(line.split('\t')[1])
                if len(results) >= expected_num:
                    break
                if sentence in results:
                    continue
                if statistic[score] >= expected_num / 5:
                    continue
                results[sentence] = line
                statistic[score] += 1
                pbar.update(1)
    pprint(sorted(dict(statistic).items()))
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
    