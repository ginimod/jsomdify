#import "jsomdify.typ": *

#let jsomd_path = sys.inputs.at("jsomd", default: none)
#assert(jsomd_path != none and jsomd_path.trim() != "", message: "Argument CLI manquant : passe --input jsomd=<fichier.jsomd>")

#let doc_data = json(jsomd_path)
#let doc_title = frontmatter-title(doc_data, default: "La gravité")

#set document(title: doc_title)
#set page(paper: "a4", margin: (x: 3cm, y: 2.5cm))
#set text(font: "DejaVu Serif", size: 7pt, lang: "fr")
#set par(justify: true, leading: 0.75em)

#let pipeline(data, scope) = {
  let chapitre1 = data.toc.at("1")
  let chap1_sections = chapitre1.sections


  cmarker.render(chap1_sections.at("1"), scope: scope)

  block(
    fill: rgb("f0f4f8"),
    inset: 1.2em,
    radius: 4pt,
    stroke: 0.5pt + rgb("cbd5e1"),
    width: 100%
  )[
    #text(size: 10pt, style: "italic")[Ce rendu peu être inséré entre les sections.]
  ]

  v(1em)
  cmarker.render(chap1_sections.at("2"), scope: scope)
}

#jsomd-render(jsomd_path, pipeline)
