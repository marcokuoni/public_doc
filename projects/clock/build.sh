#!/bin/env bash
bun build ./index.ts --outdir . --minify-whitespace  --minify-syntax --entry-naming [dir]/[name].min.[ext]
