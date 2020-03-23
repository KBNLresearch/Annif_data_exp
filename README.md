# Summary
Annif is a opensource tool for automated subject indexing and classification developed at the National Library of Finland. Annif uses a user given controlled vocabulary (e.g. thesaurus) and pre-labeled data (e.g. ebook with manually assigned subject) to train models that can than be used to assign subjects to a new input text.


## Analyse_brinkman_trefwoorden_v2
Jupyter Notebook to analyse assigned Brinkeys in GGC-dataset and create vocab files to train a model in Annif.

- __vocab.zip__ is a full-text document corpus of the GGC-dataset using the summaries of books and split into dev(5%), train(15%) and test(80%) set to be used in Annif.
- __vocab2.zip__ is a similar dataset but not only uses summaries of books but also their title and subtitle.


## compare_Brinkman_and_Thema
Jupyter Notebook file to find overlap between Brinkman and Thema thesauri.
- brinkman_thema_overlap.tsv: Brinkeys which are also found in Thema.
