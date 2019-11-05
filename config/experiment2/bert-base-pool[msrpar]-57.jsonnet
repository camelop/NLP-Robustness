local pretrained_transformer_model_name = "bert-base-uncased";

{
    "dataset_reader": {
        "type": "similarity_regression", 
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
    "train_data_path": "./data/STS-B-MSRPAR/train.tsv",
    "validation_data_path": "./data/STS-B-MSRPAR/dev.tsv",
    "model": {
        "type": "basic_regressor",
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
        "batch_size": 8
    },
    "trainer": {
        "num_epochs": 8,
        "patience": 4,
        "grad_norm": 4.0,
        "validation_metric": "+PearsonCorrelation",
        "cuda_device": 1,
        "optimizer": {
            "type": "adam",
            "lr": 2e-5
        }
    }
}