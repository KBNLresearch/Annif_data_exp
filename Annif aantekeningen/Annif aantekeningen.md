# Automatisch onderwerpsontsluiting m.b.v. Annif
Thomas Haighton

[TOC]

## 1. Inleiding
Dit document bevat mijn aantekeningen m.b.t. het testen van Annif t.b.v. het automatisch toekennen van onderwerpen aan boeken binnen de KB. 

De KB hanteert een eigen classificatiesysteem genaamd Brinkman catalogus. Op de [KB website](https://www.kb.nl/bronnen-zoekwijzers/zoekwijzers/meer-informatie-over-zoeken/trefwoorden-in-de-kb-catalogus) is meer informatie te vinden m.b.t. de verschillende trefwoordcatalogi binnen de KB.

Bij aanvang van dit onderzoek was er sprake van een mogelijke samenwerking tussen de KB en het [CB](https://www.cb.nl). Waar de KB de onderwerpen vastlegt d.m.v. Brinkmantrefwoorden, werkt het CB met [Thema](https://www.editeur.org/151/Thema/).

## 2. Overeenkomsten Thema en Brinkman
Het eerste onderzoek was gericht op het vinden van overeenkomsten tussen de brinkmanonderwerpen en de onderwerpen zoals deze stonden vastgelegd in Thema.
N.B.1: Bij de vergelijking zijn alle termen eerst geconverteerd naar kleine letters (lowercase), omdat Thema onderwerpen altijd beginnen met een hoofdletter en in Brinkman alleen trefwoorden als plaatsnamen of personen met een hoofdletter beginnen.

| |Brinkman|Thema|
|---|---|---|
|Totaal aantal termen|14737|7362|
|Unieke termen|13729|6355|
|Overeenkomende termen|980| _<-- discrepantie (zou 1008 moeten zijn?)_ |
Bron: [Jupyter Notebook op GitHub](https://github.com/KBNLresearch/Annif_data_exp/blob/master/compare_Brinkman_and_Thema.ipynb)

**Constatering**
Als we kijken naar een trefwoord wat alleen in Brinkman voorkomt, maar waarvan we verwachten dat deze ook in Thema zou moeten staan, b.v. 'autisme'.
In Thema wordt 'autisme' vastgelegd in:
- autisme en asperger syndroom
- omgaan met autisme/asperger

Hieruit zou je op kunnen maken dat er mogelijk meer overlap gemaalt kan worden als dat gewenst is.

N.B.2: Het CB heeft laten weten (tijdelijk) af te zien van dit project. Verder onderzoek met Thema is na dit bericht gestaakt en is er alleen gekeken naar Brinkmantrefwoorden.

## 3. Annif

### 3.1. Train en Evalueer Annif model (in vogelvlucht)
[Officiele _Getting Started_ doc](https://github.com/NatLibFi/Annif/wiki/Getting-started)
Ik gebruik /Annif/tests als project map; zoals in de documentatie wordt aangeraden.

Onderstaande commands zijn specifiek gericht op mijn eigen systeem (voor efficientie doeleinde i.e. copy/paste). Algemene opbouw van annif commands is:
`annif [actie] [configuratie] [path]`

Annif commands/options help: `annif --help`

1. (optioneel) Maak eerst een configuratie in _projects.cfg_
2. Start Annif Python virtual environment (annif-venv), in annif-venv/bin: `source activate`
3. Navigeer naar project folder (e.g. Desktop/Annif/Annif/tests) en start Annif: `annif`
4. Check of _projects.cfg_ gevonden wordt: `annif list-projects`

5. Laad onderwerpen:  `annif loadvoc tfidf-brinkman /Users/haighton_macbook/Desktop/Annif/Annif/tests/data/Annif-corpora/vocab/brinkmanthesaurus_vocab.tsv`
6. Train model:       `annif train tfidf-brinkman /Users/haighton_macbook/Desktop/Annif/Annif/tests/data/Annif-corpora/fulltext/ggc/train`
7. Evalueer model:    `annif eval tfidf-brinkman /Users/haighton_macbook/Desktop/Annif/Annif/tests/data/Annif-corpora/fulltext/ggc/dev`

   _**Notitie:** Dev set gebruikt als evaluatie set. TODO: rename dev naar eval_

8. Gebruik de getrainde modellen (zie H. 3.5)
9. Afsluiten venv: `deactivate`

### 3.2. GGC-dataset
TODO: Lijst met eisen.
TODO: Globale opbouw dataset.

### 3.3. Voorbeeld Annif configuratie en bijbehorende evaluatie
**TF-IDF backend met snowball analyzer**

**Configuratie**
```
[tfidf-brinkman]
name=TF-IDF Brinkman
language=nl
backend=tfidf
analyzer=snowball(dutch)
limit=100
vocab=brinkmanthesaurus_vocab
```

**Evaluatie**
```
Precision (doc avg):	0.07161500815660683
Recall (doc avg):   	0.6252039151712887
F1 score (doc avg): 	0.12716049583912553
Precision (conc avg):	0.0033237931737672725
Recall (conc avg):  	0.006049485486600793
F1 score (conc avg):	0.003495638750427632
Precision (microavg):	0.07161500815660685
Recall (microavg):  	0.5480649188514357
F1 score (microavg):	0.12667724715048334
NDCG:               	0.4647151156485022
NDCG@5:             	0.44466032224552277
NDCG@10:            	0.4647151156485022
Precision@1:        	0.29853181076672103
Precision@3:        	0.18651441000543773
Precision@5:        	0.12854812398042414
LRAP:               	0.39799930172762893
True positives:     	439
False positives:    	5691
False negatives:    	362
Documents evaluated:	613
```

### 3.4. Alle evaluatie uitkomsten
Ik heb verschillende backends (TF-IDF, Fasttext, Ensemble TF-IFD en Fasttext) en analyzers (snowball en simple) getest.
Voor alle uitkomsten van de verschillende configuraties zie: [annif_uitkomsten.xlsx](https://github.com/KBNLresearch/Annif_data_exp/blob/master/annif_uitkomsten.xlsx)

TODO: Na het testen van ggc2 dataset, uitkomsten toevoegen (heeft het toevoegen van (sub)titel een beter uitkomst?).

### 3.5. Gebruik de getrainde modellen 
In onderstaande tests heb ik gebruik gemaakt van de configuratie genaamd _TF-IDF Brinkman_.

**Via command-line interface**
8. Test annif: `cat document.txt | annif suggest tfidf-brinkman`

**Uitkomst tfidf-brinkman test01**

## Annif suggestie voor bijbehorende Brinkman termen voor 420818715.txt:
```
(annif-venv)  (annif-venv)  haighton_macbook@MacBook-Pro  ~/Desktop/Annif/Annif/tests   master ●  cat /Users/haighton_macbook/Desktop/Annif/Annif/tests/data/Annif-corpora/fulltext/ggc/dev/420818715.txt | annif suggest tfidf-brinkman

/Users/haighton_macbook/Desktop/annif-venv/lib/python3.6/site-packages/sklearn/externals/joblib/__init__.py:15: DeprecationWarning: sklearn.externals.joblib is deprecated in 0.21 and will be removed in 0.23. Please import this functionality directly from joblib, which can be installed with: pip install joblib. If this warning is raised when loading pickled models, you may need to re-serialize those models with scikit-learn 0.21+.
  warnings.warn(msg, category=DeprecationWarning)
<http://data.bibliotheken.nl/id/thes/p075660849>	levenskunst	0.4163530829438607
<http://data.bibliotheken.nl/id/thes/p075665689>	zelfkennis	0.39504628028213046
<http://data.bibliotheken.nl/id/thes/p075606178>	filosofie	0.3769179576596768
<http://data.bibliotheken.nl/id/thes/p075607050>	geloofsleven	0.3712595743673854
<http://data.bibliotheken.nl/id/thes/p07561765X>	organisatieontwikkeling	0.3698668389205731
<http://data.bibliotheken.nl/id/thes/p075663910>	spiritualiteit	0.36965842850694486
<http://data.bibliotheken.nl/id/thes/p075660822>	leidinggeven	0.36507826867675164
<http://data.bibliotheken.nl/id/thes/p075617846>	overdenkingen	0.36310030904972374
<http://data.bibliotheken.nl/id/thes/p075603578>	cultuurfilosofie	0.3629843846776753
<http://data.bibliotheken.nl/id/thes/p075610744>	jeugdboeken ; verhalen	0.36280384270411503
```

_Daadwerkelijk toegekende Brinkman termen - 420818715.tsv:_
```
(annif-venv)  (annif-venv)  haighton_macbook@MacBook-Pro  ~/Desktop/Annif/Annif/tests   master ●  cat /Users/haighton_macbook/Desktop/Annif/Annif/tests/data/Annif-corpora/fulltext/ggc/dev/420818715.tsv

<http://data.bibliotheken.nl/id/thes/p075600447>	bedrijfsorganisatie
<http://data.bibliotheken.nl/id/thes/p075603012>	citatenverzamelingen
```

_Volledige tekst 420818715.txt:_
```
(annif-venv)  (annif-venv)  haighton_macbook@MacBook-Pro  ~/Desktop/Annif/Annif/tests   master ●  cat /Users/haighton_macbook/Desktop/Annif/Annif/tests/data/Annif-corpora/fulltext/ggc/dev/420818715.txt

Er wordt wat afgeklooid in onze bedrijven en organisaties. Tijd om te ontklooien, dus! Hoe graag zouden we luid gillend willen protesteren tegen alle ellende? We blijken namelijk slechts 15% van onze tijd bezig te zijn met het creëren van waarde. Er zijn tienduizenden bullshitjobs. 75% van alle (ict-)projecten halen hun budget, hun deadline en/of het beoogde resultaat niet. We moeten zorgen voor onze work/life balance, alsof werken geen leven is. En wat al niet meer... De trieste waarheid is dat werken inderdaad vaak geen leven is. Maar luidop protesteren is een niet zo erg carrièrebevorderende actie. Durven we onze mond dus wel open te doen? Waarschijnlijk niet... Dit boekje snelt u ter hulp. Honderd en een citaten van bekende en minder bekende managementexperts, filosofen en wetenschappers die hun flink gepekelde vinger in de open wonden leggen. Ze vertellen precies wat u en ik denken. We kunnen ermee uitpakken: op ons whiteboard, in een mailtje of anoniem in de kantine. En wij blijven buiten schot, want de goeroe heeft het gedaan. Liever op de achtergrond blijven? Dan hebt u vast veel gniffelplezier bij het lezen van dit boekje. Bent u zelf leidinggevende, manager of directeur? Zoals de Vlaamse dichteres Alice Nahon schreef: 't is goed in 't eigen hart te kijken, des avonds voor het slapengaan. May the force be with you! Bron: Flaptekst, uitgeversinformatie%
```

*Als web applicatie*
Test annif als web applicatie: `annif run`
Via browser: [http://localhost:5000/](http://localhost:5000/)

**Uitkomst tfidf-brinkman - test02**
![annif_webapp.png](resources/7BBD85895892414FC9DD9978C35B6B14.png =2557x1427)
Bijbehorende toegekende Brinkman term: <http://data.bibliotheken.nl/id/thes/p075661098>	marketing

### 3.6. SKOS (Simple Knowledge Organization System)
[SKOS Core Guide](https://www.w3.org/TR/2005/WD-swbp-skos-core-guide-20051102/)
[SKOS Core Vocabulary](https://www.w3.org/TR/2005/WD-swbp-skos-core-spec-20051102/)

SKOS is een toepassing van RDF.
SKOS standaard is scpecifiek te gebruken voor het vastleggen  van een thesaurus, gecontroleerde vocabulaire e.d.
SKOS maakt o.a. gebruik van synoniemen (`altLabel`) van een term (`Concept`, `prefLabel`) en de hierargische relatie (`broader`, `narrower`) tussen termen in een thesaurus. 

__Snippet__
```
  <skos:Concept rdf:about="http://www.yso.fi/onto/yso/p21272">
    <rdf:type rdf:resource="http://www.yso.fi/onto/yso-meta/Concept"/>
    <skos:altLabel xml:lang="en">leaf beetles</skos:altLabel>
    <skos:broader rdf:resource="http://www.yso.fi/onto/yso/p6734"/>
    <skos:closeMatch rdf:resource="http://id.loc.gov/authorities/subjects/sh85025443"/>
    <skos:exactMatch rdf:resource="http://www.yso.fi/onto/allars/Y37803"/>
    <skos:exactMatch rdf:resource="http://www.yso.fi/onto/koko/p57371"/>
    <skos:exactMatch rdf:resource="http://www.yso.fi/onto/ysa/Y158869"/>
    <skos:inScheme rdf:resource="http://www.yso.fi/onto/yso/"/>
    <skos:narrower rdf:resource="http://www.yso.fi/onto/yso/p21619"/>
    <skos:prefLabel xml:lang="en">Chrysomelidae</skos:prefLabel>
    <skos:prefLabel xml:lang="sv">bladbaggar</skos:prefLabel>
    <skos:prefLabel xml:lang="fi">lehtikuoriaiset</skos:prefLabel>
  </skos:Concept>
```

## Actie punten
- [x] Configuratie aanpassen, i.e. probeer simple analyzer.
- [x] Probeer verschillende backends - bv ensemble approach.
- [ ] ook titel data gebruiken naast de samenvatting.
      - Dataset gemaakt [(ggc2)](https://github.com/KBNLresearch/Annif_data_exp/blob/master/vocab2.zip)
      - Testen en vergelijken met uitkomsten ggc dataset.
- [ ] Documentatie! (die lees je nu)
- [ ] SKOS vocab + Maui backend - Brinkman als SKOS.
      - Minimale eisen SKOS bestand voor Annif met Maui backend (moeten we onderstaande punten gaan uitzoeken?).
	    - Hebben wij een versie van de Brinkman catalogus waar nog de hierargischestructuur in staat vastgelegd (of is dit nog mogelijk uit de huidige TSV te halen d.m.v. ppn patroon)?
	    - Hoe is er in de Brinkman catalogus omgegaan met synoniemen?
	    - Hulp vragen Rene Voorburg om SKOS te genereren via OAI-PMH (GGC_THES) - zie zijn script op [GitHub](https://github.com/renevoorburg/oai2linerec).