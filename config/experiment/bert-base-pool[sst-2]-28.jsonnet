local pretrained_transformer_model_name = "bert-base-uncased";

{
    "dataset_reader": {
        "type": "binary_sentiment", 
        "tokenizer": {
            "type": "pretrained_transformer_corrected",
            "model_name": pretrained_transformer_model_name,
            "do_lowercase": true
        },
        "token_indexers": {
            "tokens": {
                "type": "pretrained_transformer",
                "model_name": pretrained_transformer_model_name,
                "do_lowercase": true
            }
        }
    },
    "train_data_path": "./data/SST-2/train.tsv",
    "validation_data_path": "./data/SST-2/dev.tsv",
    "model": {
        "type": "basic_classifier",
        "text_field_embedder": {
            "token_embedders": {
                "tokens": {
                    "type": "pretrained_transformer",
                    "model_name": pretrained_transformer_model_name,
                }
            }
        },
        "seq2vec_encoder": {
            "type": "bert_pooler",
            "pretrained_model": pretrained_transformer_model_name
        }
    },
    "iterator": {
        "type": "basic",
        "batch_size": 32
    },
    "trainer": {
        "num_epochs": 8,
        "patience": 4,
        "grad_norm": 5.0,
        "validation_metric": "+accuracy",
        "cuda_device": 1,
        "optimizer": {
            "type": "adam",
            "lr": 4e-5
        }
    }
}