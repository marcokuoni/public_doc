#!/usr/bin/env bash
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/1_first_experiences_with_webassembly.html ./1_first_experiences_with_webassembly/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/1_first_experiences_with_webassembly.de.html ./1_first_experiences_with_webassembly/README.de.md
cp -r ./1_first_experiences_with_webassembly/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/2_webassembly_modules_import_export.html ./2_webassembly_modules_import_export/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/2_webassembly_modules_import_export.de.html ./2_webassembly_modules_import_export/README.de.md
cp -r ./2_webassembly_modules_import_export/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/3_javascript_and_bytes.html ./3_javascript_and_bytes/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/3_javascript_and_bytes.de.html ./3_javascript_and_bytes/README.de.md
cp -r ./3_javascript_and_bytes/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/4_webassembly_memory.html ./4_webassembly_memory/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/4_webassembly_memory.de.html ./4_webassembly_memory/README.de.md
cp -r ./4_webassembly_memory/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/5_simple_c_programm_in_webassembly.html ./5_simple_c_programm_in_webassembly/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/5_simple_c_programm_in_webassembly.de.html ./5_simple_c_programm_in_webassembly/README.de.md
cp -r ./5_simple_c_programm_in_webassembly/*.jpg /srv/marcokuoni/data/app/project/public/blog/
cp -r ./5_simple_c_programm_in_webassembly/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/6_hello_world_cpp_programm.html ./6_hello_world_cpp_programm/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/6_hello_world_cpp_programm.de.html ./6_hello_world_cpp_programm/README.de.md
cp -r ./6_hello_world_cpp_programm/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/7_emscripten_simple_portability.html ./7_emscripten_simple_portability/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/7_emscripten_simple_portability.de.html ./7_emscripten_simple_portability/README.de.md
cp -r ./7_emscripten_simple_portability/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/8_webassembly_docker_container.html ./8_webassembly_docker_container/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/8_webassembly_docker_container.de.html ./8_webassembly_docker_container/README.de.md
cp -r ./8_webassembly_docker_container/*.jpg /srv/marcokuoni/data/app/project/public/blog/
cp -r ./8_webassembly_docker_container/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/9_porting_third_party_to_webassembly.html ./9_porting_third_party_to_webassembly/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/9_porting_third_party_to_webassembly.de.html ./9_porting_third_party_to_webassembly/README.de.md
cp -r ./9_porting_third_party_to_webassembly/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/10_webassembly_table_dynamic_linking.html ./10_webassembly_table_dynamic_linking/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/10_webassembly_table_dynamic_linking.de.html ./10_webassembly_table_dynamic_linking/README.de.md
cp -r ./10_webassembly_table_dynamic_linking/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/11_from_c_through_emscripten_to_a_deno_server_application.html ./11_from_c_through_emscripten_to_a_deno_server_application/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/11_from_c_through_emscripten_to_a_deno_server_application.de.html ./11_from_c_through_emscripten_to_a_deno_server_application/README.de.md
cp -r ./11_from_c_through_emscripten_to_a_deno_server_application/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/12_simple_rust_program_in_webassembly.html ./12_simple_rust_program_in_webassembly/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/12_simple_rust_program_in_webassembly.de.html ./12_simple_rust_program_in_webassembly/README.de.md
cp -r ./12_simple_rust_program_in_webassembly/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/13_hello_wasm_bindgen.html ./13_hello_wasm_bindgen/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/13_hello_wasm_bindgen.de.html ./13_hello_wasm_bindgen/README.de.md
cp -r ./13_hello_wasm_bindgen/*.png /srv/marcokuoni/data/app/project/public/blog/

./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/14_hello_wasi.html ./14_hello_wasi/README.md
./pandoc-medium.sh --output /srv/marcokuoni/data/app/project/public/blog/14_hello_wasi.de.html ./14_hello_wasi/README.de.md
