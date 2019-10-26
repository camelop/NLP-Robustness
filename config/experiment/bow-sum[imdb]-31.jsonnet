{
    "dataset_reader": {
        "type": "binary_sentiment"
    },
    "validation_dataset_reader": {
        "type": "binary_sentiment"
    },
    "train_data_path": "./data/IMDB/train.tsv",
    "validation_data_path": "./data/IMDB/dev.tsv",
    "model": {
        "type": "basic_classifier",
        "text_field_embedder": {
            "token_embedders": {
                "tokens": {
                    "type": "bag_of_word_counts_corrected",
                    "projection_dim": 300
                }
            }
        },
        "seq2vec_encoder": {
            "type": "bag_of_embeddings",
            "embedding_dim": 300
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
            "lr": 1e-3
        }
    }
}