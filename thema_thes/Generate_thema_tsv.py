#! /usr/bin/env python3
"""Thema TSV lijst genereren van Thema XML t.b.v. Annif."""
import csv
from lxml import etree

THEMA_LIST = "/Users/haighton_macbook/Desktop/Annif/data/Thema_v1.3.2_nl.xml"
TSV_LIST = "/Users/haighton_macbook/Desktop/Annif/data/Thema_v1.3.2_nl.tsv"


def extract_thema_list(THEMA_LIST):
    cvalue = []
    cdescription = []
    try:
        with open(THEMA_LIST, 'rb') as tl:
            context = etree.iterparse(tl, events=('start', 'end'))
            for events, elem in context:
                if (events == 'end' and etree.QName(elem.tag).localname ==
                   'Code'):
                    for child in elem.getchildren():
                        if child.tag == 'CodeValue':
                            cvalue.append('<https://ns.editeur.org/thema/nl/' +
                                          child.text + '>')
                        elif child.tag == 'CodeDescription':
                            cdescription.append(child.text)
    except etree.XMLSyntaxError as e:
        print(e)
    if len(cvalue) == len(cdescription):
        annif_list = list(zip(cvalue, cdescription))
    return(annif_list)


def write_tsv(annif_list):
    with open(TSV_LIST, 'wt') as out_file:
        tsv_writer = csv.writer(out_file, delimiter='\t')
        for uri, description in annif_list:
            tsv_writer.writerow([uri, description])


if __name__ == "__main__":
    write_tsv(extract_thema_list(THEMA_LIST))
