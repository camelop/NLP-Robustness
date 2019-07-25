import argparse, uuid, os
import logging

import numpy as np
import torch

from pytorch_transformers import (BertConfig,
                                  BertForSequenceClassification, BertTokenizer)

logger = logging.getLogger(__name__)

def set_seed(args):
    random.seed(args.seed)
    np.random.seed(args.seed)
    torch.manual_seed(args.seed)
    if args.n_gpu > 0:
        torch.cuda.manual_seed_all(args.seed)

def main():
    # parse the arguments
    parser = argparse.ArgumentParser(description='Process some integers.')
    # required parameters
    parser.add_argument("func", default='help', type=str, help="train/test/help")
    parser.add_argument("--data_dir", default="data", type=str, required=False)
    parser.add_argument("--task_name", default=None, type=str, required=False)
    parser.add_argument("--tag", default=None, type=str, required=False)
    parser.add_argument("--input_dir", default=None, type=str, required=False)
    parser.add_argument("--output_dir", default=None, type=str, required=False)
    parser.add_argument("--model_name", default="bert-base-uncased", type=str, required=False)

    args = parser.parse_args()

    # do the func
    if args.func == "help":
        print("train to generate model, test to evaluate model")
    else:
        # gather parameters
        tag = args.tag
        if tag == None:
            tag = args.tag = str(uuid.uuid1())
        print("params: {}\ntag: {}".format(str(args), tag))
        device = torch.device("cuda" if torch.cuda.is_available() and not args.no_cuda else "cpu")
        n_gpu = args.n_gpu = torch.cuda.device_count()
        logging.basicConfig(format = '%(asctime)s - %(levelname)s - %(name)s -   %(message)s', datefmt = '%m/%d/%Y %H:%M:%S',level = logging.INFO)
        logger.warning("device: %s, n_gpu: %s", device, n_gpu)
        set_seed(args)
        args.task_name = args.task_name.lower()
        # TODO task specific settings
        num_labels = None

        

        if args.func == "train":
            pass # train on the task
            # gather parameters
            config = BertConfig.from_pretrained()

            output_dir = args.output_dir = args.output_dir if args.output_dir else "model"
            if os.path.exists(output_dir) and os.list(output_dir):
                raise ValueError("Output dir exists")
            config = BertConfig.from_pretrained(args.model_name, num_labels=num_labels, finetuning_task=args.task_name)
            tokenizer = BertTokenizer.from_pretrained(args.model_name, do_lower_case="uncased" in args.model_name)
            model = BertForSequenceClassification.from_pretrained(args.model_name, from_tf=False, config=config)
            
            
        elif args.func == "test":
            pass # test on the task
        else:
            raise NotImplementedError

    
    # do corresponding task

if __name__ == "__main__":
    main()