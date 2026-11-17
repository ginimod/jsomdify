import json
from pathlib import Path
import frontmatter
import mistletoe
from mistletoe.ast_renderer import AstRenderer

def init_toc_entry(toc, h1_key):
  """Assure l'initialisation d'une entrée H1 dans la TOC si elle n'existe pas."""
  if h1_key not in toc:
    toc[h1_key] = {"title": "", "sections": {}}

def init_section_entry(toc, h1_key, h2_key):
  """Assure l'initialisation d'une section H2 dans la TOC si elle n'existe pas."""
  init_toc_entry(toc, h1_key)
  if h2_key not in toc[h1_key]["sections"]:
    toc[h1_key]["sections"][h2_key] = []

def append_to_section(toc, h1_key, h2_key, text):
  """Ajoute un bloc de texte à la section courante."""
  init_section_entry(toc, h1_key, h2_key)
  toc[h1_key]["sections"][h2_key].append(text)

def process_heading(parsed_block, counters, keys, toc_structure):
  """Traite un titre (H1, H2, H3+) et met à jour les compteurs et clés."""
  level = parsed_block["level"]
  heading_clean = parsed_block["text"].lstrip("#").strip()
  h1_k, h2_k = keys["h1"], keys["h2"]

  match level:
    case 1:
      counters["h1"] += 1
      counters["h2"] = 0
      h1_k = str(counters["h1"])
      h2_k = f"{h1_k}.{counters['h2']}"
      toc_structure[h1_k] = {"title": heading_clean, "sections": {h2_k: []}}
    case 2:
      counters["h2"] += 1
      h2_k = f"{h1_k}.{counters['h2']}"
      init_toc_entry(toc_structure, h1_k)
      toc_structure[h1_k]["sections"][h2_k] = [parsed_block["text"]]
    case _:
      append_to_section(toc_structure, h1_k, h2_k, parsed_block["text"])

  return h1_k, h2_k

def parse_markdown_to_jsomd(md_path):
  md_file = Path(md_path)
  if not md_file.exists():
    print(f"[ERREUR] Fichier introuvable : {md_path}")
    return

  post = frontmatter.load(md_file)
  lines = post.content.splitlines()

  doc = mistletoe.Document(lines)
  renderer = AstRenderer()
  raw_ast = json.loads(renderer.render(doc))

  toc = {}
  counters = {"h1": 0, "h2": 0}
  keys = {"h1": "1", "h2": "1.0"}
  toc[keys["h1"]] = {"title": "", "sections": {keys["h2"]: []}}
  blocks = raw_ast.get("children", [])

  parsed_blocks = []
  for i, block in enumerate(blocks):
    start_line = block.get("line_number", 1) - 1
    if i + 1 < len(blocks):
      end_line = blocks[i + 1].get("line_number", len(lines)) - 1
    else:
      end_line = len(lines)
    block_text = "\n".join(lines[start_line:end_line]).strip()
    parsed_blocks.append({"type": block.get("type"), "level": block.get("level"), "text": block_text})

  for parsed_block in parsed_blocks:
    if parsed_block["type"] == "Heading":
      keys["h1"], keys["h2"] = process_heading(parsed_block, counters, keys, toc)
    else:
      append_to_section(toc, keys["h1"], keys["h2"], parsed_block["text"])

  for h1_k, h1_val in toc.items():
    for sec_k, sec_blocks in h1_val["sections"].items():
      h1_val["sections"][sec_k] = "\n\n".join(sec_blocks)

  jsomd_payload = { "frontmatter": dict(post.metadata), "toc": toc }
  build_dir = md_file.parent
  jsomd_path = build_dir / f".{md_file.stem}.jsomd"
  jsomd_path.write_text(json.dumps(jsomd_payload, ensure_ascii=False, indent=2), encoding="utf-8")
  print(f"JsoMD : {jsomd_path}")


if __name__ == "__main__":
  import sys

  if len(sys.argv) > 1:
    parse_markdown_to_jsomd(sys.argv[1])
  else:
    print("Usage: python jsomdify.py <article.md>")
