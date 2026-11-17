# JsoMDify

Une expérimentation de pivot de fichier  **MarkDown** en **JSon** pour **Typst** 

## Le pourquoi 

Le pourquoi du comment est expliqué dans ce post [Keszako, le JsoMD ?](https://www.inimod.org/plumitif/jsonmd) , une version rapide est qu'Obsidian est mon système-auteur central et que je recherche un mécanisme de WOPE (Write Once, Publish Everywhere) pour la production de PDF par Typst.

Le périmètre fonctionnel est donc le mien et le _process jsomdify_ le couvre :

Si cela vous convient : Utilisez-le, forkez-le, vous vous l'appropriez.
Si cela ne vous convient pas : Le code est ouvert. Ouvrez votre éditeur, modifiez-le
Si vous faîtes du Latex : restez avec vos runes de grimoires poussiéreux et venez pas me rapper les sabots, l'âne est agressif en cette saison !

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
