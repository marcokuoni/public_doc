#!/usr/bin/env bash
# ./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/example.html ./example.md
# Transforms Markdown format to html for use with md-publisher.
# Requires pandoc, pandoc-crossref, and pandoc-citeproc
# # See https://pandoc.org/MANUAL.html#extension-yaml_metadata_block
set -e
opts=()
opts+=(--standalone)
opts+=(--resource-path "$PWD")
opts+=(--filter pandoc-crossref)
opts+=(--citeproc)

## Add here your citation style (https://citationstyles.org/)
opts+=(--csl "./science.csl")

## Add here your global BibTex library if you like
opts+=(--bibliography "./Zotero_BBT.bib")
opts+=(--from markdown+yaml_metadata_block+implicit_figures+fenced_divs+citations+table_captions)
opts+=(--to html5)
opts+=(--webtex)
opts+=("${@}")
pandoc "${opts[@]}"
