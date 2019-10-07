#!/bin/bash
SQUAD_DIR="./data/record-squad"
BATCH_ID="Record"
num_train_epochs=8.0
learning_rate=4e-5

RUN_TAG="tryrecord2"
python ./src/run_squad.py \
    --model_type bert \
    --model_name_or_path bert-base-cased \
    --do_train \
    --do_eval \
    --do_lower_case \
    --train_file $SQUAD_DIR/train.json \
    --predict_file $SQUAD_DIR/dev.json \
    --per_gpu_train_batch_size 8 \
    --learning_rate ${learning_rate} \
    --num_train_epochs ${num_train_epochs} \
    --max_seq_length 384 \
    --doc_stride 128 \
    --overwrite_output_dir \
    --output_dir ./model/${BATCH_ID}/${RUN_TAG} # >> ./log.txt 2>&1
