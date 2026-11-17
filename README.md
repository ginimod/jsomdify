# JsoMDify

Une expérimentation de pivot **JSon** de fichier **MarkDown** pour **Typst** 

## Le pourquoi 

Le pourquoi du comment est expliqué dans ce post [Keszako, le JsoMD ?](https://www.inimod.org/plumitif/jsonmd) , une version rapide est qu'Obsidian est mon système-auteur central et que je recherche un mécanisme de WOPE (Write Once, Publish Everywhere) pour la production de PDF par Typst.

**JSoMDify** fait parti de mon apprentissage de Typst, le périmètre fonctionnel est donc le mien et le _process_ le couvre :

- Si cela vous convient : Utilisez-le, forkez-le, vous vous l'appropriez.

- Si cela ne vous convient pas : Le code est ouvert. Ouvrez votre éditeur, modifiez-le
  
- Si vous faîtes du Latex : restez avec vos runes de grimoires poussiéreux et venez pas me rapper les sabots, l'âne est agressif en cette saison !


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
## Template

- jsomdify.typ est la _lib Typst_ qui expose la fonction **jsomd-render**

- article.typ est un template pour produire directement à partir de article.md

- article_as_asset.typ correspond à **mon usage**, le JsoMD est vu comme un dictionnaire d'asset H1 et H2 

## Limites

- Indexation à deux niveaux : niveau 1 et 2

- Pas de gestion du Latex mais des contournements sont possibles.

- et tous les cas de figure qui m'ont pas encore éclatés à la tronche

 > On tombe dessus, c'est le jeux ma pauvre Lucette ! 

Template


