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
                    "type": "bag_of_word_counts_corrected",
                    "projection_dim": 300
                }, 
                "tokens_b": {
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