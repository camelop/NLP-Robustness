#!/bin/bash
export DATA_DIR=./data/raw_dataset

# begin
export RUN_TAG=id-a4-bbu-all-all
export TRAIN_TASK_NAME=STS-B-ALL
export EVAL_TASK_NAME=STS-B-ALL

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path bert-base-uncased \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 1e-5 \
    --num_train_epochs 32.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a5-bbu-all-news
export TRAIN_TASK_NAME=STS-B-ALL
export EVAL_TASK_NAME=STS-B-NEWS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a4-bbu-all-all \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a6-bbu-all-captions
export TRAIN_TASK_NAME=STS-B-ALL
export EVAL_TASK_NAME=STS-B-CAPTIONS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a4-bbu-all-all \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a7-bbu-all-forums
export TRAIN_TASK_NAME=STS-B-ALL
export EVAL_TASK_NAME=STS-B-FORUMS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a4-bbu-all-all \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a8-bbu-news-news
export TRAIN_TASK_NAME=STS-B-NEWS
export EVAL_TASK_NAME=STS-B-NEWS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path bert-base-uncased \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 1e-5 \
    --num_train_epochs 32.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a9-bbu-news-all
export TRAIN_TASK_NAME=STS-B-NEWS
export EVAL_TASK_NAME=STS-B-ALL

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a8-bbu-news-news \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a10-bbu-news-captions
export TRAIN_TASK_NAME=STS-B-NEWS
export EVAL_TASK_NAME=STS-B-CAPTIONS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a8-bbu-news-news \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a11-bbu-news-forums
export TRAIN_TASK_NAME=STS-B-NEWS
export EVAL_TASK_NAME=STS-B-FORUMS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a8-bbu-news-news \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a12-bbu-captions-captions
export TRAIN_TASK_NAME=STS-B-CAPTIONS
export EVAL_TASK_NAME=STS-B-CAPTIONS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path bert-base-uncased \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 1e-5 \
    --num_train_epochs 32.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a13-bbu-captions-all
export TRAIN_TASK_NAME=STS-B-CAPTIONS
export EVAL_TASK_NAME=STS-B-ALL

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a12-bbu-captions-captions \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a14-bbu-captions-news
export TRAIN_TASK_NAME=STS-B-CAPTIONS
export EVAL_TASK_NAME=STS-B-NEWS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a12-bbu-captions-captions \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a15-bbu-captions-forums
export TRAIN_TASK_NAME=STS-B-CAPTIONS
export EVAL_TASK_NAME=STS-B-FORUMS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a12-bbu-captions-captions \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a16-bbu-forums-forums
export TRAIN_TASK_NAME=STS-B-FORUMS
export EVAL_TASK_NAME=STS-B-FORUMS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path bert-base-uncased \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 1e-5 \
    --num_train_epochs 32.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a17-bbu-forums-all
export TRAIN_TASK_NAME=STS-B-FORUMS
export EVAL_TASK_NAME=STS-B-ALL

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a16-bbu-forums-forums \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a18-bbu-forums-news
export TRAIN_TASK_NAME=STS-B-FORUMS
export EVAL_TASK_NAME=STS-B-NEWS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a16-bbu-forums-forums \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG

export RUN_TAG=id-a19-bbu-forums-captions
export TRAIN_TASK_NAME=STS-B-FORUMS
export EVAL_TASK_NAME=STS-B-CAPTIONS

python ./pytorch-transformers/examples/run_glue.py \
    --model_type bert \
    --model_name_or_path ./model/$TRAIN_TASK_NAME/id-a16-bbu-forums-forums \
    --task_name $EVAL_TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $DATA_DIR/$EVAL_TASK_NAME \
    --max_seq_length 64 \
    --per_gpu_eval_batch_size=32   \
    --per_gpu_train_batch_size=32   \
    --learning_rate 0 \
    --num_train_epochs 0.0 \
    --save_steps 200 \
    --output_dir ./model/$EVAL_TASK_NAME/$RUN_TAG
