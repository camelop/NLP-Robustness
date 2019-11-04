from typing import Dict, Optional

from overrides import overrides
import torch

from allennlp.data import Vocabulary
from allennlp.models.model import Model
from allennlp.modules import Seq2SeqEncoder, Seq2VecEncoder, TextFieldEmbedder
from allennlp.nn import InitializerApplicator, RegularizerApplicator
from allennlp.nn.util import get_text_field_mask
from allennlp.training.metrics import PearsonCorrelation


@Model.register("stsb_regressor")
class STSBRegressor(Model):
    """
    This ``Model`` implements a basic text regressor. After embedding the text into
    a text field, we will optionally encode the embeddings with a ``Seq2SeqEncoder``. The
    resulting sequence is pooled using a ``Seq2VecEncoder`` and then passed to
    a linear regression layer, which projects into a single value. If a
    ``Seq2SeqEncoder`` is not provided, we will pass the embedded text directly to the
    ``Seq2VecEncoder``.

    Parameters
    ----------
    vocab : ``Vocabulary``
    text_field_embedder : ``TextFieldEmbedder``
        Used to embed the input text into a ``TextField``
    seq2seq_encoder : ``Seq2SeqEncoder``, optional (default=``None``)
        Optional Seq2Seq encoder layer for the input text.
    seq2vec_encoder : ``Seq2VecEncoder``
        Required Seq2Vec encoder layer. If `seq2seq_encoder` is provided, this encoder
        will pool its output. Otherwise, this encoder will operate directly on the output
        of the `text_field_embedder`.
    dropout : ``float``, optional (default = ``None``)
        Dropout percentage to use.
    scale : ``float``, optional (default = 1)
        Scale regression result is between 0 ~ scale
    label_namespace: ``str``, optional (default = "labels")
        Vocabulary namespace corresponding to labels. By default, we use the "labels" namespace.
    initializer : ``InitializerApplicator``, optional (default=``InitializerApplicator()``)
        If provided, will be used to initialize the model parameters.
    regularizer : ``RegularizerApplicator``, optional (default=``None``)
        If provided, will be used to calculate the regularization penalty during training.
    """
    def __init__(self,
                 vocab: Vocabulary,
                 text_field_embedder: TextFieldEmbedder,
                 seq2vec_encoder: Seq2VecEncoder,
                 seq2seq_encoder: Seq2SeqEncoder = None,
                 dropout: float = None,
                 scale: float = 1,
                 label_namespace: str = "labels",
                 initializer: InitializerApplicator = InitializerApplicator(),
                 regularizer: Optional[RegularizerApplicator] = None) -> None:

        super().__init__(vocab, regularizer)
        self._text_field_embedder = text_field_embedder

        if seq2seq_encoder:
            self._seq2seq_encoder = seq2seq_encoder
        else:
            self._seq2seq_encoder = None

        self._seq2vec_encoder = seq2vec_encoder

        self._classifier_input_dim = self._seq2vec_encoder.get_output_dim() * 2  # run encoder seperately and concat the result

        if dropout:
            self._dropout = torch.nn.Dropout(dropout)
            self._dropout_a = torch.nn.Dropout(dropout)
            self._dropout_b = torch.nn.Dropout(dropout)
        else:
            self._dropout = None

        self._label_namespace = label_namespace

        self._num_labels = 1  # because we're running a regression task
        self._scale = scale
        self.__first = True

        self._mlp_dims = [self._classifier_input_dim] * 3
        self._mlp_layers = torch.nn.ModuleList()
        for i, j in zip(self._mlp_dims, self._mlp_dims[1:]):
            self._mlp_layers.append(torch.nn.Linear(i, j))
            self._mlp_layers.append(torch.nn.ReLU())
            if dropout:
                self._mlp_layers.append(torch.nn.Dropout(dropout))
        self._classification_layer = torch.nn.Linear(self._classifier_input_dim, self._num_labels)
        self._metric = PearsonCorrelation()
        self._similarity = torch.nn.CosineSimilarity()
        self._loss = torch.nn.MSELoss()
        initializer(self)

    def forward(self,  # type: ignore
                tokens_a: Dict[str, torch.LongTensor],
                tokens_b: Dict[str, torch.LongTensor],
                label: torch.IntTensor = None) -> Dict[str, torch.Tensor]:
        # pylint: disable=arguments-differ
        """
        Parameters
        ----------
        tokens : Dict[str, torch.LongTensor]
            From a ``TextField``
        label : torch.IntTensor, optional (default = None)
            From a ``LabelField``

        Returns
        -------
        An output dictionary consisting of:

        logits : torch.FloatTensor
            A tensor of shape ``(batch_size, 1)`` representing
            unnormalized log probabilities of the label.
        loss : torch.FloatTensor, optional
            A scalar loss to be optimised.
        """
        tokens = {"tokens_a": tokens_a["tokens_a"], "tokens_b": tokens_b["tokens_b"]}  
        if self.__first:
            self.__first = False
            print("tokens: \n")
            print(tokens)
        # I don't know why tokens_a and tokens_b both includes keys named by each other
        tokens_a = {"tokens_a": tokens_a["tokens_a"]}
        tokens_b = {"tokens_b": tokens_b["tokens_b"]}
        embedded_text = self._text_field_embedder(tokens)
        embedded_text_a = embedded_text["tokens_a"]  # TODO: check the shape for this
        mask_a = get_text_field_mask(tokens_a).float()
        embedded_text_b = embedded_text["tokens_b"]
        mask_b = get_text_field_mask(tokens_b).float()

        if self._seq2seq_encoder:
            embedded_text_a = self._seq2seq_encoder(embedded_text_a, mask=mask_a)
            embedded_text_b = self._seq2seq_encoder(embedded_text_b, mask=mask_b)
            
        embedded_text_a = self._seq2vec_encoder(embedded_text_a, mask=mask_a)
        embedded_text_b = self._seq2vec_encoder(embedded_text_b, mask=mask_b)
        # embedded_text = torch.cat([embedded_text_a, embedded_text_b], dim=-1)
        
        if self._dropout:
            embedded_text_a = self._dropout_a(embedded_text_a)
            embedded_text_b = self._dropout_b(embedded_text_b)
        '''
        if self._mlp_layers:
            for l in self._mlp_layers:
                embedded_text = l(embedded_text)
        logits = self._classification_layer(embedded_text)
        '''
        logits = self._similarity(embedded_text_a, embedded_text_b) * 5
        output_dict = {"logits": logits}

        if label is not None:  # convert the label into a float number and update the metric
            label_to_str = lambda l: self.vocab.get_index_to_token_vocabulary(self._label_namespace).get(l)
            label_tensor = torch.tensor([float(label_to_str(int(label[i]))) for i in range(label.shape[0])], device=logits.device)
            loss = self._loss(logits.view(-1), label_tensor)
            output_dict["loss"] = loss
            self._metric(logits, label_tensor)

        return output_dict

    @overrides
    def decode(self, output_dict: Dict[str, torch.Tensor]) -> Dict[str, torch.Tensor]:
        """
        Does a simple argmax over the probabilities, converts index to string label, and
        add ``"label"`` key to the dictionary with the result.
        """
        # update this part to generate a float number result as similarity score
        predictions = output_dict["logits"]
        if predictions.dim() == 2:
            predictions_list = [predictions[i] for i in range(predictions.shape[0])]
        else:
            predictions_list = [predictions]
        classes = []
        for prediction in predictions_list:
            label_idx = "{:.1f}".format(prediction.long())
            label_str = (self.vocab.get_index_to_token_vocabulary(self._label_namespace)
                         .get(label_idx, str(label_idx)))
            classes.append(label_str)
        output_dict["label"] = classes
        return output_dict

    def get_metrics(self, reset: bool = False) -> Dict[str, float]:
        metrics = {'PearsonCorrelation': self._metric.get_metric(reset)}
        return metrics
