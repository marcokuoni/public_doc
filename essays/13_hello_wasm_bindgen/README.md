---
title: 'Hello wasm-bindgen'
subtitle: 'Wasm-bindgen is a tool that simplifies communication between Rust and JavaScript…'
author: Marco Kuoni
date: 2024-03-27T00:00:00+0100
keywords: [WebAssembly,wasi,javascript,Webdev,Webdeveloper,web,html,browser,webapp,webapplication,webapplications,programming,coding,software,technology]
lang: en-US
abstract: |
  Wasm-bindgen is a tool that simplifies communication between Rust and JavaScript…
email: mail@marcokuoni.ch
reference-section-title: Further Resources
---

# Hello wasm-bindgen
Wasm-bindgen is a tool that simplifies communication between Rust and JavaScript. It enables calling JavaScript functions from Rust and vice versa, simplifying the transfer of data between these languages. Actually, it's not exclusively for Rust, but Rust works best with wasm-bindgen.

## "Hello, Rust!" Example
As mentioned earlier, wasm-bindgen allows us to call all functions from the browser from Rust code. Additionally, functions defined in Rust can also be used in JavaScript code.

Creating a new project:

```bash
$ cargo new --lib hello-wasm-bindgen
     Created library `hello-wasm-bindgen` package
```

Install Rust: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

Now, the `src/lib.rs` file will be modified:

```rust
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

#[wasm_bindgen]
pub fn greet(name: &str) {
    log(&format!("Hello, {}!", name));
}
```

Short explanation:
* `wasm_bindgen::prelude::*` imports all necessary functions and traits to connect our functions with JavaScript.
* `#[wasm_bindgen]` together with `extern` defines that a function from JavaScript is used in Rust. In this case, it's the `console.log` function. `#[wasm_bindgen(js_namespace = console)]` defines that the function is found in the JavaScript namespace `console`.
* `#[wasm_bindgen]` together with `pub` defines that the `greet` function should be exported for JavaScript. It calls the `log` function and outputs the text "Hello, {name}!".

Before compiling this for the web, the `Cargo.toml` file needs to be adjusted:

```toml
[package]
name = "hello-wasm-bindgen"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2.92"
```

Short explanation:
* `crate-type = ["cdylib"]` defines that a dynamic C library is created.
* `wasm-bindgen = "0.2.92"` defines the version of wasm-bindgen.

Now the project can be compiled for the web. Alternatives would be Webpack, Node.js, or Deno:

```bash
$ wasm-pack build --target web
[INFO]: 🎯  Checking for the Wasm target...
[INFO]: 🌀  Compiling to Wasm...
   Compiling proc-macro2 v1.0.79
   Compiling unicode-ident v1.0.12
   Compiling wasm-bindgen-shared v0.2.92
   Compiling once_cell v1.19.0
   Compiling bumpalo v3.15.4
   Compiling log v0.4.21
   Compiling wasm-bindgen v0.2.92
   Compiling cfg-if v1.0.0
   Compiling quote v1.0.35
   Compiling syn v2.0.55
   Compiling wasm-bindgen-backend v0.2.92
   Compiling wasm-bindgen-macro-support v0.2.92
   Compiling wasm-bindgen-macro v0.2.92
   Compiling hello-wasm-bindgen v0.1.0 (.../hello-wasm-bindgen)
    Finished release [optimized] target(s) in 4.42s
[INFO]: ⬇️  Installing wasm-bindgen...
[INFO]: found wasm-opt at "/usr/bin/wasm-opt"
[INFO]: Optimizing wasm binaries with `wasm-opt`...
[INFO]: Optional fields missing from Cargo.toml: 'description', 'repository', and 'license'. These are not necessary, but recommended
[INFO]: ✨   Done in 7.77s
[INFO]: 📦   Your wasm pkg is ready to publish at .../hello-wasm-bindgen/pkg.
```

Install wasm-pack: `curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh`

This has created a `pkg` directory containing a package.json file for project definition, the WebAssembly file, the JavaScript file, and type definitions for TypeScript.

Analysis:

```bash
$ wasm-objdump -x hello_wasm_bindgen_bg.wasm

hello_wasm_bindgen_bg.wasm:     file format wasm 0x1

Section Details:

Type[10]:
 - type[0] (i32, i32) -> i32
 - type[1] (i32, i32) -> nil
 - type[2] (i32, i32, i32) -> i32
 - type[3] (i32) -> nil
 - type[4] (i32, i32, i32, i32) -> i32
 - type[5] (i32, i32, i32, i32) -> nil
 - type[6] (i32, i32, i32) -> nil
 - type[7] (i32) -> i32
 - type[8] (i32, i32, i32, i32, i32, i32) -> nil
 - type[9] () -> nil
Import[1]:
 - func[0] sig=1 <wbg.__wbg_log_641153c3c7e8b3d9> <- wbg.__wbg_log_641153c3c7e8b3d9
Function[45]:
 - func[1] sig=7
 - ...
Table[1]:
 - table[0] type=funcref initial=29 max=29
Memory[1]:
 - memory[0] pages: initial=17
Global[1]:
 - global[0] i32 mutable=1 - init i32=1048576
Export[4]:
 - memory[0] -> "memory"
 - func[16] <greet> -> "greet"
 - func[22] <__wbindgen_malloc> -> "__wbindgen_malloc"
 - func[26] <__wbindgen_realloc> -> "__wbindgen_realloc"
Elem[1]:
 - segment[0] flags=0 table=0 count=28 - init i32=1
  - ...
Code[45]:
 - func[1] size=4675
 - ...
Data[1]:
 - segment[0] memory=0 size=764 - init i32=1048576
  - ...
Custom:
 - name: "producers"
Custom:
 - name: "target_features"
  - [+] mutable-globals
  - [+] sign-ext
```

Short explanation:
* Upon import, it's evident that the `log` function from JavaScript is being imported.
* The `greet` function is exported and can therefore be called from JavaScript.
* The `__wbindgen_malloc` and `__wbindgen_realloc` functions are used for memory management.

### Usage in a Web Application
```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Hello wasm-bindgen</title>
</head>

<body>
    <script type="module">
        import init, { greet } from './hello-wasm-bindgen/pkg/hello_wasm_bindgen.js';
        init().then(() => {
            greet('Rust');
        });
    </script>
</body>

</html>
```

Start application: `python3 -m http.server`.

Analyze in the browser `http://localhost:8000`.

![Console Log Output](console_log.png)

## Further Resources
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/13_hello_wasm_bindgen)
* [Deutsche Version](https://github.com/marcokuoni/public_doc/tree/main/essays/13_hello_wasm_bindgen/README.de.md)
* [Install Rust](https://www.rust-lang.org/tools/install)
* [Install wasm-pack](https://rustwasm.github.io/wasm-pack/installer/)
* [wasm-bindgen Documentation](https://rustwasm.github.io/docs/wasm-bindgen/)
* [wasm-bindgen Source Code](https://github.com/rustwasm/wasm-bindgen)

I am open to refining, expanding, or correcting the article. Feel free to provide a feedback or get in touch with me.

Created by [Marco Kuoni, March 2024](https://marcokuoni.ch)
