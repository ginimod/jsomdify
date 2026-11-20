#import "@preview/cmarker:0.1.2"

#let default-image-scope = (
  image: (path, alt: none, ..rest) => {
    if alt != none {
      image(path, alt: alt)
    } else {
      image(path)
    }
  }
)

#let resolve-jsomd-path(fallback_path) = {
  sys.inputs.at("jsomd", default: fallback_path)
}

#let frontmatter-get(data, key, default: none) = {
  let frontmatter = data.at("frontmatter", default: (:))
  if frontmatter == none or type(frontmatter) != dictionary {
    return default
  }
  let val = frontmatter.at(str(key), default: none)
  if val == none {
    return default
  }
  if type(val) == str and val.trim() == "" {
    return default
  }
  val
}

#let frontmatter-title(data, default: "Document") = {
  let title = frontmatter-get(data, "title", default: none)
  if title != none {
    return str(title)
  }
  let titre = frontmatter-get(data, "titre", default: none)
  if titre != none {
    return str(titre)
  }
  default
}

#let jsomd-render(json_path, strategy-fn) = {
  let resolved = resolve-jsomd-path(json_path)
  let data = json(resolved)
  strategy-fn(data, default-image-scope)
}
