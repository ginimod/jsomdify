#import "jsomdify.typ": *

#set document(title: "Mon Super Article")
#set page(paper: "a4", margin: (x: 3cm, y: 2.5cm))
#set text(font: "DejaVu Serif", size: 7pt, lang: "fr")
#set par(justify: true, leading: 0.75em)


#let pipeline(data, scope) = {
  let h1 = data.toc.at("1")
  let sections = h1.sections

  v(1.5em)
  text(18pt, weight: "bold", h1.title)
  v(1em)

  cmarker.render(sections.at("1.1"), scope: scope)

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
  cmarker.render(sections.at("1.2"), scope: scope)
}

// Appel du pipeline générique
#jsomd-render(".article.jsomd", pipeline)
