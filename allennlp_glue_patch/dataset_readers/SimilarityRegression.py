from typing import Dict, List, Iterable
import logging
import csv
import sys

from overrides import overrides

from allennlp.data.dataset_readers.dataset_reader import DatasetReader
from allennlp.data.token_indexers import TokenIndexer, SingleIdTokenIndexer
from allennlp.data.tokenizers import Token, Tokenizer, WordTokenizer
from allennlp.data.instance import Instance
from allennlp.data.fields import TextField, LabelField
from allennlp.common.file_utils import cached_path

logger = logging.getLogger(__name__)

@DatasetReader.register("similarity_regression")
class SimilarityRegressionDatasetReader(DatasetReader):

    @staticmethod
    def _read_tsv(input_file, quotechar=None):
        """Reads a tab separated value file."""
        with open(input_file, "r", encoding="utf-8-sig") as f:
            reader = csv.reader(f, delimiter="\t", quotechar=quotechar)
            lines = []
            for line in reader:
                if sys.version_info[0] == 2:
                    line = list(unicode(cell, 'utf-8') for cell in line)
                lines.append(line)
            return lines[1:]  # ignore the header

    def __init__(
        self,
        tokenizer: Tokenizer = None,
        token_indexers: Dict[str, TokenIndexer] = None,
        lazy: bool = False, 
    ) -> None:
        super().__init__(lazy)
        self._tokenizer = tokenizer or WordTokenizer()
        #siti = SingleIdTokenIndexer()
        self._token_indexers = token_indexers or {"tokens_a": SingleIdTokenIndexer(), "tokens_b": SingleIdTokenIndexer()}


    # TODO: update the following part
    @overrides
    def _read(self, file_path: str) -> Iterable[Instance]:
        file_path = cached_path(file_path)
        logger.info("Reading instances from lines in file at: %s", file_path)
        lines = SimilarityRegressionDatasetReader._read_tsv(file_path)
        for i, line in enumerate(lines):
            yield self.text_to_instance(i, line[7], line[8], line[-1])
    
    def text_to_instance(self, index: int, text_a: str, text_b: str, label: str) -> Instance:
        if "tokens" in self._token_indexers:
            return Instance({  # use [1:] to skip the second <cls> symbol
                "tokens": TextField(self._tokenizer.tokenize(text_a) + self._tokenizer.tokenize(text_b)[1:], self._token_indexers),
                "label": LabelField(label)
            })
        else:  # splitted
            return Instance({
                "tokens_a": TextField(self._tokenizer.tokenize(text_a), self._token_indexers),
                "tokens_b": TextField(self._tokenizer.tokenize(text_b), self._token_indexers),
                "label": LabelField(label)
            })