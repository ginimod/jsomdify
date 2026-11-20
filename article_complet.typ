#import "jsomdify.typ": *

#let jsomd_path = sys.inputs.at("jsomd", default: none)
#assert(jsomd_path != none and jsomd_path.trim() != "", message: "Argument CLI manquant : passe --input jsomd=<fichier.jsomd>")

#let jsomd = json(jsomd_path)
#let title = frontmatter-title(jsomd, default: "Article")

#set document(title: title)
#set page(paper: "a4", margin: (x: 3cm, y: 2.5cm))
#set text(font: "DejaVu Serif", size: 7pt, lang: "fr")
#set par(justify: true, leading: 0.75em)

#show heading.where(level: 2): it => {
  v(1em)
  text(13pt, weight: "bold", it.body)
  v(0.4em)
}

#let pipeline(jsomd, scope) = {
  let title = frontmatter-title(jsomd, default: title)
  text(20pt, weight: "bold", title)
  v(1em)

  let sorted_h1 = jsomd.toc.keys().sorted(key: k => int(k))
  for h1_key in sorted_h1 {
    let h1_node = jsomd.toc.at(h1_key)

    let sections = h1_node.sections
    let sorted_keys = sections.keys().sorted(key: k => int(k))
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

#jsomd-render(jsomd_path, pipeline)
