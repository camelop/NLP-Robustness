# Notes

## Troubleshooting
- "allennlp: command not found"
```
alias allennlp='python -m allennlp.run'
```
- cannot use roberta tokenizer
    - bug from pytorch-transformers
        - change tokenization_auto.py, line 88 into:
        ```
                if 'bert' in pretrained_model_name_or_path and 'roberta' not in pretrained_model_name_or_path:
        ```
        - change modeling_auto.py, line 113 into:
        ```
                if 'bert' in pretrained_model_name_or_path and 'roberta' not in pretrained_model_name_or_path:
        ```
        - change modeling_auto.py, line 228 into:
        ```
                if 'bert' in pretrained_model_name_or_path and 'roberta' not in pretrained_model_name_or_path:
        ```

## Commands
- Train a model
```
allennlp train <config> -s <serialization-dir>
# e.g. allennlp train config/test/sst-lstm.json -s model/test-lstm[sst-2] --include-package allennlp_glue_patch
```
- Eval a model
```
allennlp evaluate <model.tar.gz> <test-loc>
```
- Predict a model
```
allennlp predict <model.tar.gz> <pred-loc>
```

## convenient commands
```
rm -rf model/test-lstm[sst-2] && allennlp train config/test/sst-lstm.json -s model/test-lstm[sst-2] --include-package allennlp_glue_patch
rm -rf model/test-cnn[sst-2] && allennlp train config/test/sst-cnn.json -s model/test-cnn[sst-2] --include-package allennlp_glue_patch
rm -rf model/test-cnn-bow[sst-2] && allennlp train config/test/sst-cnn-bow.json -s model/test-cnn-bow[sst-2] --include-package allennlp_glue_patch
rm -rf model/test-sum[sst-2] && allennlp train config/test/sst-sum.json -s model/test-sum[sst-2] --include-package allennlp_glue_patch
rm -rf model/test-bert[sst-2] && allennlp train config/test/sst-bert.jsonnet -s model/test-bert[sst-2] --include-package allennlp_glue_patch
rm -rf model/test-roberta[sst-2] && allennlp train config/test/sst-roberta.jsonnet -s model/test-roberta[sst-2] --include-package allennlp_glue_patch
```