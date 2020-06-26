# Experiments using Annif to suggest suitable Brinkman subjects

## Introduction
Annif is an opensource tool for automated subject indexing and classification developed at the National Library of Finland. Annif uses a user given controlled vocabulary (e.g. thesaurus) and pre-labeled data to train models that can than be used to assign subjects to a new input text. This repository contains files created while researching the use of Annif with ebook data from the KB using the Brinkman thesaurus as controlled vocabulary.


## Results
- `annif_uitkomsten.xlsx` contains all Annif evaluation outcomes of experiments using different backends and settings. Each tab contains outcomes using a different subset of the original dataset (datasets not on github):

  - subset 1 _ggc1_: subset with summaries from all ebooks in original dataset.
  - subset 2 _ggc2_: subset with summaries, titles and subtitles from all ebooks in original dataset.
  - subset 3 _ggc\_zaaktrefwoorden_: subset with summaries, titles and subtitles from ebooks which got assigned one or more Brinkman subjects refering to content.
  - subset 4 _ggc\_vormtrefwoorden_: subset with summaries, titles and subtitles from ebooks which got assigned one or more Brinkman subjects refering to form.
  
- _Annif aantekeningen_ folder contains documentation as tex/pdf.


## Generate document corpus for use in Annif
- `generate_dataset_annif.ipynb` is a Jupyter Notebook file to generate a document corpus usable by Annif from raw GGC data.


## Exploratory analysis of Brinkman subjects in GGC-dataset
- `Exploratory_analysis_ggc_dataset.ipynb` is a Jupyter Notebook file to analyse assigned Brinkman subjects in the ebook GGC-data.


## Preliminary investigation on similarities between Thema and Brinkman thesaurus
Files located in _thema\_thes_ folder.
- `Generate_thema_tsv.py` is a Python file to convert Thema thesaurus XML file into a TSV file to be used as Annif vocab.
- `compare_Brinkman_and_Thema.ipynb` contains some exploratory investigation on similarities between Brinkman and Thema thesaurus.
- `brinkman_thema_overlap.tsv` contains Brinkman subjects which are also found in Thema.
