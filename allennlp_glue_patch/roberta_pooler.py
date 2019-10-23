from typing import Union

from overrides import overrides

import torch
import torch.nn
from pytorch_pretrained_bert import BertModel

from allennlp.modules.seq2vec_encoders.seq2vec_encoder import Seq2VecEncoder
from allennlp.modules.token_embedders.bert_token_embedder import PretrainedBertModel


@Seq2VecEncoder.register("roberta_pooler")
class RobertaPooler(Seq2VecEncoder):
    """
    Dense with same hidden + activation using tanh, EASY
    """
    def __init__(self,
                 pretrained_model: Union[str, BertModel],
                 embedding_dim: int = 1024, # default for large
                 dropout: float = 0.0) -> None:
        super().__init__()

        self._dropout = torch.nn.Dropout(p=dropout)
        self._dense = torch.nn.Linear(embedding_dim, embedding_dim)
        self._activation = torch.nn.Tanh()
        self._embedding_dim = embedding_dim

    @overrides
    def get_input_dim(self) -> int:
        return self._embedding_dim

    @overrides
    def get_output_dim(self) -> int:
        return self._embedding_dim

    def forward(self, tokens: torch.Tensor, mask: torch.Tensor = None):  # pylint: disable=arguments-differ,unused-argument
        first_token_tensor = tokens[:, 0]
        return self._dropout(self._activation(self._dense(first_token_tensor)))
