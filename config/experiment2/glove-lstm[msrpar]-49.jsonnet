{
    "dataset_reader": {
        "type": "similarity_regression"
    },
    "validation_dataset_reader": {
        "type": "similarity_regression"
    },
    "train_data_path": "./data/STS-B-MSRPAR/train.tsv",
    "validation_data_path": "./data/STS-B-MSRPAR/dev.tsv",
    "model": {
        "type": "stsb_regressor",
        "text_field_embedder": {
            "type": "stsb",
            "output_key_specified": true,
            "token_embedders": {
                "tokens_a": {
                    "type": "embedding",
                    "embedding_dim": 300,
                    "pretrained_file": "https://allennlp.s3.amazonaws.com/datasets/glove/glove.840B.300d.txt.gz",
                    "trainable": false
                }, 
                "tokens_b": {
                    "type": "embedding",
                    "embedding_dim": 300,
                    "pretrained_file": "https://allennlp.s3.amazonaws.com/datasets/glove/glove.840B.300d.txt.gz",
                    "trainable": false
                }
            }
        },
        "seq2vec_encoder": {
            "type": "lstm",
            "input_size": 300,
            "hidden_size": 1024,
            "num_layers": 1,
            "batch_first": true
        },
        "dropout": 0.1
    },
    "iterator": {
        "type": "basic",
        "batch_size": 32
    },
    "trainer": {
        "num_epochs": 128,
        "patience": 32,
        "grad_norm": 4.0,
        "validation_metric": "+PearsonCorrelation",
        "cuda_device": 3,
        "optimizer": {
            "type": "adam",
            "lr": 1e-4
        }
    }
}