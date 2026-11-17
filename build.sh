#!/bin/bash


python jsomdify.py article.md

typst compile article.typ
typst compile article_as_asset.typ
