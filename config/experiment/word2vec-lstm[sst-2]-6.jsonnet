{
    "dataset_reader": {
        "type": "binary_sentiment"
    },
    "validation_dataset_reader": {
        "type": "binary_sentiment"
    },
    "train_data_path": "./data/SST-2/train.tsv",
    "validation_data_path": "./data/SST-2/dev.tsv",
    "model": {
        "type": "basic_classifier",
        "text_field_embedder": {
            "token_embedders": {
                "tokens": {
                    "type": "embedding",
                    "embedding_dim": 300,
                    "pretrained_file": "https://allennlp.s3.amazonaws.com/datasets/word2vec/GoogleNews-vectors-negative300.txt.gz",
                    "trainable": false
                }
            }
        },
        "seq2vec_encoder": {
            "type": "lstm",
            "input_size": 300,
            "hidden_size": 512,
            "num_layers": 2,
            "batch_first": true
        }
    },
    "iterator": {
        "type": "basic",
        "batch_size": 32
    },
    "trainer": {
        "num_epochs": 16,
        "patience": 4,
        "grad_norm": 4.0,
        "validation_metric": "+accuracy",
        "cuda_device": 0,
        "optimizer": {
            "type": "adam",
            "lr": 5e-4
        }
    }
}