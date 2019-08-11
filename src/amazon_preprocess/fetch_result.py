import os
from ast import literal_eval as l_eval

target_dir = "model/AmazonSplit"

all_results = {}

for d in os.listdir(target_dir):
    try:
        loc = os.path.join(target_dir, d)
        #print(loc)
        if '-[' in d:
            document = (d.split('-[')[1].split(']-')[0].strip(), d.split('-[')[1].split(']-')[1].strip())
        else:
            document = (d, "-".join(d.split('-')[1:])[6:])
        if 'bert-' in d:
            document = ("BERT", document[1][7:-7])
        else:
            document = (document[0][18:], document[1])
            document = (document[0][7:-7], document[1][7:-7])
        eval_result = os.path.join(loc, "eval_results.txt")
        r = {}
        with open(eval_result) as fin:
            for l in fin:
                cor = l.split(" = ")
                k = cor[0].strip()
                v = "%.1f" % (l_eval(cor[1].strip())*100)
                r[k] = v
        all_results[document] = "%s/%s" % (r['pearson'], r['spearmanr'])
    except Exception as e:
        print(e)
        pass

from pprint import pprint
# labels = list(set([k[1] for k in all_results.keys()]))
labels = ['C','WC','MC','BC','S','MS','MV','B',]

print(labels)
# print
line = "\t\t"
for l in labels:
    line = line+l+'\t\t'
print(line)
line = "BERT\t"
for l in labels:
    if ("BERT", l) in all_results:
        line = line + all_results[("BERT", l)] + '\t'
    else:
        line = line + '\t\t'
print(line)
for l in labels:
    line = l+'\t'
    for l2 in labels:
        if (l, l2) in all_results:
            line = line + all_results[(l, l2)] + '\t'
        else:
            line = line + '\t\t'
    print(line)