---
title: 'Hello WASI'
subtitle: 'The introduction to WASI, the practical example, and the key benefits of using WASI with WebAssembly.'
author: Marco Kuoni
date: 2024-09-29T00:00:00+0100
keywords: [WebAssembly,wasi,javascript,Webdev,Webdeveloper,web,html,browser,webapp,webapplication,webapplications,programming,coding,software,technology]
lang: en-US
abstract: |
  The introduction to WASI, the practical example, and the key benefits of using WASI with WebAssembly.
email: mail@marcokuoni.ch
reference-section-title: Further Resources
---

# Hello WASI
Some functionalities are more difficult to achieve in WebAssembly due to imposed security goals. The language does not rely on the security mechanisms of the host system, as is the case with most others. Therefore, access to the file system, memory, and other resources must be explicitly allowed. This excludes many unrecognized attack vectors.

WebAssembly was also developed to make code portable, and thanks to WASI, it becomes a portable application.

In the browser, there is a standardized environment, and APIs can always be passed to WebAssembly modules in the same way for internal use. On the operating system, certain functionality is expected from the module itself, provided the permission is available. An additional layer is needed, which was created by WASI.

## "Hello, WASI!" Example
Create a new project:

```bash
$ cargo new --bin hello-wasi
     Created binary (application) `hello-wasi` package
```

The `main.rs` file in the `src` directory looks something like this:

```rust
fn main() {
    println!("Hello, WASI!");
}
```

Build:

```bash
$ cd hello-wasi/

$ cargo build --release
   Compiling hello-wasi v0.1.0 (...)
    Finished release [optimized] target(s) in 0.42s
```

Run:

```bash
$ cargo run --release
    Finished release [optimized] target(s) in 0.00s
     Running `target/release/hello-wasi`
Hello, WASI!
```

Because Rust is LLVM-based, a binary for the current operating system has now been created. However, this binary doesn't work on another operating system.

### As a WebAssembly Module
Try to run a WebAssembly module directly. We'll use wasm3, but the same can be done with other outside-the-browser WebAssembly runtimes (e.g., wasmtime, wasmer, ...).

---

If Rust in WebAssembly is new to you or you're more interested in the topic, I recommend consulting my older posts:
* [Simple Rust Program in WebAssembly](https://medium.com/webassembly/simple-rust-program-in-webassembly-8561efd81b9f): Simple guide on how to use Rust in a web application

---

Build:

```bash
$ cargo build --target wasm32-unknown-unknown --release
   Compiling hello-wasi v0.1.0 (...)
    Finished release [optimized] target(s) in 0.25s
```

Run:

```bash
$ wasm3 target/wasm32-unknown-unknown/release/hello-wasi.wasm
Error: function lookup failed ('_start')
```

The WebAssembly module cannot be executed directly. It lacks the correct structure, such as the `_start` function here, to be executed by the runtime.

Build with WASI backend:

```bash
$ cargo build --target wasm32-wasi --release
   Compiling hello-wasi v0.1.0 (...)
    Finished release [optimized] target(s) in 0.16s
```

Run:

```bash
$ wasm3 target/wasm32-wasi/release/hello-wasi.wasm
Hello, WASI!
```

Analyze:

```bash
$ wasm-objdump -x target/wasm32-wasi/release/hello-wasi.wasm


hello-wasi.wasm:	file format wasm 0x1

Section Details:

Type[18]:
 - type[0] () -> nil
 - type[1] (i32) -> nil
 - type[2] (i32, i32) -> nil
 - type[3] (i32) -> i32
 - type[4] (i32, i32) -> i32
 ....
Import[4]:
 - func[0] sig=7 <_ZN4wasi13lib_generated22wasi_snapshot_preview18fd_write17haeb8e9d471da6707E> <- wasi_snapshot_preview1.fd_write
 - func[1] sig=4 <__imported_wasi_snapshot_preview1_environ_get> <- wasi_snapshot_preview1.environ_get
 - func[2] sig=4 <__imported_wasi_snapshot_preview1_environ_sizes_get> <- wasi_snapshot_preview1.environ_sizes_get
 - func[3] sig=1 <__imported_wasi_snapshot_preview1_proc_exit> <- wasi_snapshot_preview1.proc_exit
Function[204]:
 - func[4] sig=0 <__wasm_call_ctors>
 - func[5] sig=0 <_start>
 - func[6] sig=1 <_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h90275821610c977eE>
 - func[7] sig=3 <_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h077ef646d308a78dE>
 - func[8] sig=3 <_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h7be2897f107f95f6E>
 - func[9] sig=1 <_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd02ca6a3ba2a3b9bE>
 - func[10] sig=0 <_ZN10hello_wasi4main17h913399cd9566c9a2E>
 - func[11] sig=8 <__main_void>
 - func[12] sig=4 <__rust_alloc>
 - func[13] sig=5 <__rust_dealloc>
 - func[14] sig=7 <__rust_realloc>
 - func[15] sig=2 <__rust_alloc_error_handler>
 ...
Table[1]:
 - table[0] type=funcref initial=75 max=75
Memory[1]:
 - memory[0] pages: initial=17
Global[1]:
 - global[0] i32 mutable=1 <__stack_pointer> - init i32=1048576
Export[3]:
 - memory[0] -> "memory"
 - func[5] <_start> -> "_start"
 - func[11] <__main_void> -> "__main_void"
Elem[1]:
 - segment[0] flags=0 table=0 count=74 - init i32=1
  - elem[1] = func[10] <_ZN10hello_wasi4main17h913399cd9566c9a2E>
  ...
Code[204]:
 - func[4] size=2 <__wasm_call_ctors>
 - func[5] size=68 <_start>
 - func[6] size=11 <_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h90275821610c977eE>
 - func[7] size=15 <_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h077ef646d308a78dE>
 - func[8] size=15 <_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h7be2897f107f95f6E>
 - func[9] size=2 <_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd02ca6a3ba2a3b9bE>
 - func[10] size=82 <_ZN10hello_wasi4main17h913399cd9566c9a2E>
 - func[11] size=70 <__main_void>
 - func[12] size=19 <__rust_alloc>
 - func[13] size=15 <__rust_dealloc>
 - func[14] size=23 <__rust_realloc>
 ...
Data[2]:
 - segment[0] <.rodata> memory=0 size=7192 - init i32=1048576
  - 0100000: 0200 0000 0400 0000 0400 0000 0300 0000  ................
  - 0100010: 0400 0000 0400 0000 4865 6c6c 6f2c 2057  ........Hello, W
  - 0100020: 4153 4921 0a00 0000 1800 1000 0d00 0000  ASI!............
  - 0100030: 2829 0000 0f00 0000 0400 0000 0400 0000  ()..............
  ...
Custom:
 - name: ".debug_abbrev"
 ...

```

Without going too deep, you can now see the desired _start function in the export. In addition, the WASI compiler provides a standard for WebAssembly modules to import functionality that the module itself wants to use. More details on this in the [WASI Tutorial by wasmtime](https://github.com/bytecodealliance/wasmtime/blob/main/docs/WASI-tutorial.md#web-assembly-text-example).

---

As a tip, Rust-based WASI applications can be developed directly with cargo

Install:

```bash
$ cargo install cargo-wasi
    Updating crates.io index
  Downloaded cargo-wasi v0.1.28
  Downloaded 1 crate (13.9 KB) in 1.03s
  Installing cargo-wasi v0.1.28
    Updating crates.io index
  Downloaded cargo-wasi-exe-x86_64-unknown-linux-musl v0.1.28
  Downloaded 1 crate (5.4 MB) in 3.12s
   Compiling cfg-if v1.0.0
   Compiling cargo-wasi-exe-x86_64-unknown-linux-musl v0.1.28
   Compiling cargo-wasi v0.1.28
    Finished release [optimized] target(s) in 9.85s
  Installing /home/progressio/.cargo/bin/cargo-wasi
   Installed package `cargo-wasi v0.1.28` (executable `cargo-wasi`)
```

Run:

```bash
$ cargo wasi run
   Compiling hello-wasi v0.1.0 (/home/progressio/Nextcloud/marco-private/Git/Forschung/public_doc/essays/14_hello_wasi/hello-wasi)
    Finished dev [unoptimized + debuginfo] target(s) in 0.06s
     Running `/home/progressio/.cargo/bin/cargo-wasi target/wasm32-wasi/debug/hello-wasi.wasm`
     Running `target/wasm32-wasi/debug/hello-wasi.wasm`
Hello, WASI!
```

---

Compilation to WASI code is offered for various programming languages. As an example for C/C++, [wasienv](https://github.com/wasienv/wasienv).

WASI applications can be run on various platforms, including Node.js, Deno, [Browser](https://dev.to/ndesmic/building-a-minimal-wasi-polyfill-for-browsers-4nel), etc.

## Further Resources
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/14_hello_wasi)
* [Deutsche Version](https://github.com/marcokuoni/public_doc/tree/main/essays/14_hello_wasi/README.de.md)

I am happy to clarify, expand, or correct the article. Write feedback or contact me directly.

Created by [Marco Kuoni, September 2024](https://marcokuoni.ch)
