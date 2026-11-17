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
#let jsomd-render(json_path, strategy-fn) = {
  let data = json(json_path)
  strategy-fn(data, default-image-scope)
}
