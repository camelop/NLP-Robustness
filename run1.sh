#!/bin/bash
export DATA_DIR=./data/raw_dataset
export TASK_NAME=SST-2

export RUN_TAG=init_test00

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$TASK_NAME \
#     --max_seq_length 128 \
#     --per_gpu_eval_batch_size=8   \
#     --per_gpu_train_batch_size=8   \
#     --learning_rate 2e-5 \
#     --num_train_epochs 3.0 \
#     --output_dir ./model/$TASK_NAME/$RUN_TAG

export RUN_TAG=init_test01_sst

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$TASK_NAME \
#     --max_seq_length 512 \
#     --per_gpu_eval_batch_size=4   \
#     --per_gpu_train_batch_size=4   \
#     --learning_rate 1e-5 \
#     --num_train_epochs 8.0 \
#     --save_steps 200 \
#     --output_dir ./model/$TASK_NAME/$RUN_TAG

export RUN_TAG=init_test02_eval_sst_zero
export TRAIN_TASK_NAME=SST-2
export EVAL_TASK_NAME=IMDB

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/init_test01_sst \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 512 \
#     --per_gpu_eval_batch_size=4   \
#     --per_gpu_train_batch_size=4   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG \
#     --overwrite_output_dir

export RUN_TAG=init_test03_eval_bbu
export TRAIN_TASK_NAME=NONE
export EVAL_TASK_NAME=SST-2

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 512 \
#     --per_gpu_eval_batch_size=4   \
#     --per_gpu_train_batch_size=4   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=init_test04_eval_bbu
export TRAIN_TASK_NAME=NONE
export EVAL_TASK_NAME=IMDB

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 512 \
#     --per_gpu_eval_batch_size=4   \
#     --per_gpu_train_batch_size=4   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=init_test05_train_on_imdb
export TRAIN_TASK_NAME=IMDB
export EVAL_TASK_NAME=IMDB

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 512 \
#     --per_gpu_eval_batch_size=4   \
#     --per_gpu_train_batch_size=4   \
#     --learning_rate 1e-5 \
#     --num_train_epochs 8.0 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=init_test06_train_on_imdb_eval_on_sst
export TRAIN_TASK_NAME=IMDB
export EVAL_TASK_NAME=SST-2

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/init_test05_train_on_imdb \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 512 \
#     --per_gpu_eval_batch_size=4   \
#     --per_gpu_train_batch_size=4   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=init_test07_sts_all
export TRAIN_TASK_NAME=STS-B-ALL
export EVAL_TASK_NAME=STS-B-ALL

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 128 \
#     --per_gpu_eval_batch_size=16   \
#     --per_gpu_train_batch_size=16   \
#     --learning_rate 1e-5 \
#     --num_train_epochs 8.0 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG


export RUN_TAG=init_test08_sts_all
export TRAIN_TASK_NAME=STS-B-ALL
export EVAL_TASK_NAME=STS-B-ALL

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 4e-5 \
#     --num_train_epochs 8.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG \
#     --overwrite_output_dir

# export RUN_TAG=id0-bbu-none-all
# export TRAIN_TASK_NAME=STS-B-ALL
# export EVAL_TASK_NAME=STS-B-ALL

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --overwrite_output_dir \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id1-bbu-none-news
# export TRAIN_TASK_NAME=STS-B-NEWS
# export EVAL_TASK_NAME=STS-B-NEWS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --overwrite_output_dir \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG


# export RUN_TAG=id2-bbu-none-captions
# export TRAIN_TASK_NAME=STS-B-CAPTIONS
# export EVAL_TASK_NAME=STS-B-CAPTIONS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --overwrite_output_dir \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id3-bbu-none-forums
# export TRAIN_TASK_NAME=STS-B-FORUMS
# export EVAL_TASK_NAME=STS-B-FORUMS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --overwrite_output_dir \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id4-bbu-all-all
# export TRAIN_TASK_NAME=STS-B-ALL
# export EVAL_TASK_NAME=STS-B-ALL

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 4e-5 \
#     --num_train_epochs 8.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id5-bbu-all-news
# export TRAIN_TASK_NAME=STS-B-ALL
# export EVAL_TASK_NAME=STS-B-NEWS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id4-bbu-all-all \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id6-bbu-all-captions
# export TRAIN_TASK_NAME=STS-B-ALL
# export EVAL_TASK_NAME=STS-B-CAPTIONS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id4-bbu-all-all \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id7-bbu-all-forums
# export TRAIN_TASK_NAME=STS-B-ALL
# export EVAL_TASK_NAME=STS-B-FORUMS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id4-bbu-all-all \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id8-bbu-news-news
# export TRAIN_TASK_NAME=STS-B-NEWS
# export EVAL_TASK_NAME=STS-B-NEWS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 4e-5 \
#     --num_train_epochs 8.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id9-bbu-news-all
# export TRAIN_TASK_NAME=STS-B-NEWS
# export EVAL_TASK_NAME=STS-B-ALL

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id8-bbu-news-news \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id10-bbu-news-captions
# export TRAIN_TASK_NAME=STS-B-NEWS
# export EVAL_TASK_NAME=STS-B-CAPTIONS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id8-bbu-news-news \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id11-bbu-news-forums
# export TRAIN_TASK_NAME=STS-B-NEWS
# export EVAL_TASK_NAME=STS-B-FORUMS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id8-bbu-news-news \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id12-bbu-captions-captions
# export TRAIN_TASK_NAME=STS-B-CAPTIONS
# export EVAL_TASK_NAME=STS-B-CAPTIONS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 4e-5 \
#     --num_train_epochs 8.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id13-bbu-captions-all
# export TRAIN_TASK_NAME=STS-B-CAPTIONS
# export EVAL_TASK_NAME=STS-B-ALL

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id12-bbu-captions-captions \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id14-bbu-captions-news
# export TRAIN_TASK_NAME=STS-B-CAPTIONS
# export EVAL_TASK_NAME=STS-B-NEWS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id12-bbu-captions-captions \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id15-bbu-captions-forums
# export TRAIN_TASK_NAME=STS-B-CAPTIONS
# export EVAL_TASK_NAME=STS-B-FORUMS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id12-bbu-captions-captions \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id16-bbu-forums-forums
# export TRAIN_TASK_NAME=STS-B-FORUMS
# export EVAL_TASK_NAME=STS-B-FORUMS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path bert-base-uncased \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 4e-5 \
#     --num_train_epochs 8.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id17-bbu-forums-all
# export TRAIN_TASK_NAME=STS-B-FORUMS
# export EVAL_TASK_NAME=STS-B-ALL

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id16-bbu-forums-forums \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id18-bbu-forums-news
# export TRAIN_TASK_NAME=STS-B-FORUMS
# export EVAL_TASK_NAME=STS-B-NEWS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id16-bbu-forums-forums \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

# export RUN_TAG=id19-bbu-forums-captions
# export TRAIN_TASK_NAME=STS-B-FORUMS
# export EVAL_TASK_NAME=STS-B-CAPTIONS

# python ./pytorch-transformers/examples/run_glue.py \
#     --model_type bert \
#     --model_name_or_path ./model/$TRAIN_TASK_NAME/id16-bbu-forums-forums \
#     --task_name $EVAL_TASK_NAME \
#     --do_train \
#     --do_eval \
#     --do_lower_case \
#     --data_dir $DATA_DIR/$EVAL_TASK_NAME \
#     --max_seq_length 64 \
#     --per_gpu_eval_batch_size=32   \
#     --per_gpu_train_batch_size=32   \
#     --learning_rate 0 \
#     --num_train_epochs 0.0 \
#     --save_steps 200 \
#     --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG
