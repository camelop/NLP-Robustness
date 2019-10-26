local pretrained_transformer_model_name = "bert-large-uncased";

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
        "batch_size": 16
    },
    "trainer": {
        "num_epochs": 4,
        "patience": 2,
        "grad_norm": 5.0,
        "validation_metric": "+accuracy",
        "cuda_device": 0,
        "optimizer": {
            "type": "adam",
            "lr": 1e-4
        }
    }
}