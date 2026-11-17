# jsomdify
un pivot Json der MD pour Typst 

## Le pourquoi 

[Keszako, le JsoMD ?](https://www.inimod.org/plumitif/jsonmd)

## Howto

Je suppose que Python3 et Typst sont installés

**Dépendances python**

```requirements

python-frontmatter
mistletoe
```

**Exécution**

```
pip install -r requirements.txt

python jsomdify.py article.md

typst compile article.typ
typst compile article_as_asset.typ

```
