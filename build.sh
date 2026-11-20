#!/bin/bash

#  MD -> JsoMD
python jsomdify.py article.md

# Typst
# .article.jsomd
typst compile --input jsomd=.article.jsomd article_complet.typ article.pdf
typst compile --input jsomd=.article.jsomd article_asset.typ article_asset.pdf
