#import "jsomdify.typ": *


#set document(title: "Mon Super Article")
#set page(paper: "a4", margin: (x: 3cm, y: 2.5cm))
#set text(font: "DejaVu Serif", size: 7pt, lang: "fr")
#set par(justify: true, leading: 0.75em)


#show heading.where(level: 2): it => {
  v(1em)
  text(13pt, weight: "bold", it.body)
  v(0.4em)
}


#let pipeline(data, scope) = {
  // Parcours de tous les grands chapitres H1
  for (h1_key, h1_node) in data.toc {
    if h1_node.title != "" {
      v(1.5em)
      text(18pt, weight: "bold", h1_node.title)
      v(1em)
    }

    let sections = h1_node.sections
    let sorted_keys = sections.keys().sorted()
    for sec_key in sorted_keys {
      let content_md = sections.at(sec_key)
      if content_md != "" {
        block(width: 100%)[
          #pad(bottom: 1.2em)[
            #cmarker.render(content_md, scope: scope)
          ]
        ]
      }
    }
  }
}

// Appel du pipeline
#jsomd-render(".article.jsomd", pipeline)
