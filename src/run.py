import os, sys
from multiprocessing import Pool

run_glue_loc = "/home/littleround/nlp-robustness/src"
if run_glue_loc not in sys.path:
    sys.path.append(run_glue_loc)

from run_glue import main

def find_source_task(task):
    task = task.lower()
    if task in ("sst-2", "imdb"):
        return "sst-2"
    elif task in ("sts-b-headlines", "sts-b-msrpar", "sts-b-msrvid", "sts-b-images"):
        return "sts-b"


def run(model_type, task, ori_task=None, gpu="-1"):
    gpu = str(gpu)
    task = task.lower()
    ori_task = ori_task.lower() if ori_task is not None else None
    os.environ["CUDA_VISIBLE_DEVICES"] = gpu
    if model_type in ["Glove", "Word2vec", "LSTM"]:
        print("{} not supported now.".format(model_type))
    else:
        _model_type = model_type.split('-')[0]
        ori_model_name = "{}[{}]".format(model_type, ori_task) if ori_task is not None else None
        _model_name_or_path = model_type if ori_task is None else "./model/{}".format(ori_model_name)
        _task_name = find_source_task(task)
        _data_dir = "./data/{}".format(task.upper())
        _max_seq_length = str(128)
        _per_gpu_train_batch_size = str(8)
        _learning_rate = "2e-5" if ori_task is None else "0.0"
        _num_train_epochs = str(3)
        new_model_name = "{}[{}]".format(model_type, task) if ori_task is None else "{}[{}]-[{}]".format(model_type, task, ori_task)
        _output_dir = "./model/{}".format(new_model_name)
        main([
            "--model_type", _model_type,
            "--model_name_or_path", _model_name_or_path,
            "--task_name", _task_name,
            "--do_train", "--do_eval", "--do_lower_case",
            "--data_dir", _data_dir,
            "--max_seq_length", _max_seq_length,
            "--per_gpu_train_batch_size", _per_gpu_train_batch_size,
            "--learning_rate", _learning_rate,
            "--num_train_epochs", _num_train_epochs,
            "--output_dir", _output_dir,
            "--save_steps", "10000",
            "--overwrite_output_dir"
        ])
    return new_model_name

def packed_run(x):
    return run(*x)

if __name__ == "__main__":
    # test "fine_tune_model"
    available_gpus = [0, 3, 4, 5, 6, 7]
    with Pool(6) as p, open("results.txt", 'w') as fout:
        model = "bert-base-uncased"  # "roberta-large"
        print(p.map(packed_run, [
            (model, "sst-2", None, 0),
            (model, "imdb", None, 3),
            (model, "sts-b-msrvid", None, 4),
            (model, "sts-b-msrpar", None, 5),
            (model, "sts-b-headlines", None, 6),
            (model, "sts-b-images", None, 7),
        ]), file=fout)