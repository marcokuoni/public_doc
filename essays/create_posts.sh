#!/usr/bin/env bash

# Array mit Blog-Ordnern
blogs=(
  "1_first_experiences_with_webassembly"
  "2_webassembly_modules_import_export"
  "3_javascript_and_bytes"
  "4_webassembly_memory"
  "5_simple_c_programm_in_webassembly"
  "6_hello_world_cpp_programm"
  "7_emscripten_simple_portability"
  "8_webassembly_docker_container"
  "9_porting_third_party_to_webassembly"
  "10_webassembly_table_dynamic_linking"
  "11_from_c_through_emscripten_to_a_deno_server_application"
  "12_simple_rust_program_in_webassembly"
  "13_hello_wasm_bindgen"
  "14_hello_wasi"
)

# Basisverzeichnis für die Ausgabe
output_base="/srv/marcokuoni/data/app/project/public/blog"

# Schleife über die Blog-Ordner
for blog in "${blogs[@]}"; do
  # Erstelle den Zielordner
  mkdir -p "$output_base/$blog"

  # Pandoc-Befehle ausführen
  ./pandoc-medium.sh --output "$output_base/$blog/index.html" "./$blog/README.md"
  ./pandoc-medium.sh --output "$output_base/$blog/index.de.html" "./$blog/README.de.md"

  # Kopiere Bilder (png, jpg)
  cp -r ./$blog/*.png "$output_base/$blog/" 2>/dev/null
  cp -r ./$blog/*.jpg "$output_base/$blog/" 2>/dev/null
done
