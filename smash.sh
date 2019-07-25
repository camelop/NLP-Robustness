#!/bin/bash
DATA_DIR="./data/raw_dataset"
BATCH_ID="Fsplit-bbu"
train(){

    task_name=${1}    

    RUN_TAG="${BATCH_ID}-train-${task_name}"
    TRAIN_TASK_NAME=${task_name}
    EVAL_TASK_NAME=${task_name}

    python ./src/run_glue.py \
        --model_type bert \
        --model_name_or_path bert-base-uncased \
        --task_name ${EVAL_TASK_NAME} \
        --do_train \
        --do_eval \
        --do_lower_case \
        --data_dir ${DATA_DIR}/${EVAL_TASK_NAME} \
        --max_seq_length 64 \
        --per_gpu_eval_batch_size=32   \
        --per_gpu_train_batch_size=32   \
        --learning_rate 1e-5 \
        --num_train_epochs 32.0 \
        --save_steps 200 \
        --overwrite_output_dir \
        --output_dir ./model/${BATCH_ID}/${RUN_TAG} > ./log.txt 2>&1

    echo ${RUN_TAG}
}

test(){
    train_name=${1}
    test_name=${2}
    model_run_tag=${3}

    RUN_TAG="${BATCH_ID}-[${model_run_tag}]-${test_name}"
    TRAIN_TASK_NAME=${train_name}
    EVAL_TASK_NAME=${test_name}

    if [ ${model_run_tag} == "bert-base-uncased" ]
    then
        model_path="bert-base-uncased"
    else
        model_path="./model/${BATCH_ID}/${model_run_tag}"
    fi

    python ./src/run_glue.py \
        --model_type bert \
        --model_name_or_path ${model_path} \
        --task_name ${EVAL_TASK_NAME} \
        --do_train \
        --do_eval \
        --do_lower_case \
        --data_dir ${DATA_DIR}/${EVAL_TASK_NAME} \
        --max_seq_length 64 \
        --per_gpu_eval_batch_size=32   \
        --per_gpu_train_batch_size=32   \
        --learning_rate 0 \
        --num_train_epochs 0.0 \
        --save_steps 200 \
        --overwrite_output_dir \
        --output_dir ./model/${BATCH_ID}/${RUN_TAG} > ./log.txt 2>&1

    echo ${RUN_TAG}
}

# # untrained performance 
# test "STS-B-MSRPAR" "STS-B-MSRPAR" "bert-base-uncased"
# test "STS-B-HEADLINES" "STS-B-HEADLINES" "bert-base-uncased"
# test "STS-B-MSRVID" "STS-B-MSRVID" "bert-base-uncased"
# test "STS-B-IMAGES" "STS-B-IMAGES" "bert-base-uncased"

# # trained
# MSRPAR_MODEL=`train "STS-B-MSRPAR"`
# test "STS-B-MSRPAR" "STS-B-HEADLINES" ${MSRPAR_MODEL}
# HEADLINES_MODEL=`train "STS-B-HEADLINES"`
# test "STS-B-HEADLINES" "STS-B-MSRPAR" ${HEADLINES_MODEL}
# MSRVID_MODEL=`train "STS-B-MSRVID"`
# test "STS-B-MSRVID" "STS-B-IMAGES" ${MSRVID_MODEL}
# IMAGES_MODEL=`train "STS-B-IMAGES"`
# test "STS-B-IMAGES" "STS-B-MSRVID" ${IMAGES_MODEL}
