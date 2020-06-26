## Introduction
Annif is a opensource tool for automated subject indexing and classification developed at the National Library of Finland. Annif uses a user given controlled vocabulary (e.g. thesaurus) and pre-labeled data (e.g. ebooks with manually assigned subjects) to train models that can than be used to assign subjects to a new input text. This repository contains files created while researching the use of Annif with ebook data from the KB.

## Results
- `annif_uitkomsten.xlsx` contains all Annif evaluation outcomes of experiments using different backends and settings.
- `Annif aantekeningen` folder contains documentation as tex/pdf.

## Generate document corpus for use in Annif
- `generate_dataset_annif.ipynb` is a Jupyter Notebook file to generate a dataset usable by Annif from GGC raw data.


## Preliminary investigation on Thema and Brinkman thesaurus

### Exploratory analysis of GGC-dataset
- `Analyse_brinkman_trefwoorden_v2.ipynb` is a Jupyter Notebook file to analyse assigned Brinkman subjects in the GGC-data and create dataset to train a model in Annif - this is an older file, part of the code is split of into a separate notebook `generate_dataset_annif.ipynb`.

### Compare Brinkman with Thema thesaurus
Jupyter Notebook file to find overlap between Brinkman and Thema thesauri.
- `Generate_thema_tsv.py` is a Python file to convert Thema thesaurus XML file into a TSV file to be used as Annif vocab.
- `compare_Brinkman_and_Thema.ipynb` contains some exploratory investigation on similarities between Brinkman and Thema thesaurus.
- `brinkman_thema_overlap.tsv` contains Brinkman subjects which are also found in Thema.
