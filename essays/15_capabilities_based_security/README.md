---
title: "Capabilities-Based Security with WASI"
subtitle: "Secure resource access in WebAssembly with Capabilities-Based Security and WASI"
author: Marco Kuoni
date: 2025-07-10T00:00:00+0100
keywords:
  [
    WebAssembly,
    wasi,
    javascript,
    Webdev,
    Webdeveloper,
    web,
    html,
    browser,
    webapp,
    webapplication,
    webapplications,
    programming,
    coding,
    software,
    technology,
  ]
lang: en-US
abstract: |
  WASI implements capabilities-based security by granting WebAssembly modules only explicitly assigned accesses. Instead of global user rights, programs receive individual “keys” (capabilities) for exactly the resources they need. This prevents misuse such as the confused deputy problem. An example shows how file access in WASI only works with previously granted folder access, ensuring sandbox security.
email: mail@marcokuoni.ch
reference-section-title: Further Resources
---

# Capabilities-Based Security with WASI

There should be a way to provide applications on our systems with functionalities or accesses in a controlled manner. Since it cannot be determined in advance which software might be malicious, standardized sandbox environments make sense.

From the beginning, WASI aimed to enforce [capabilities-based security](https://en.wikipedia.org/wiki/Capability-based_security) for individual WebAssembly modules.

---

Capabilities-Based Security: This is a security model where access rights are granted directly as objects (capabilities).

- A capability is like a key that allows you to do something specific.
- If you don’t have the key, you cannot do it.
- Programs or users receive only exactly the keys they need (Principle of Least Privilege).

Thus, there is no global access control with user IDs and checks. Instead, capabilities are passed directly.

---

WebAssembly does not give arbitrary code direct access to memory. WASI does the same with sensitive resources like file handlers, network sockets, or subprocess details. These resources are made available to WebAssembly modules with clearly defined and unforgeable handlers.

```rust
use std::fs;
use std::io::{Read, Write};

fn main() {
    let greeting = "Hello Security";
    let outfile = "hello.txt";
    let mut output_file = fs::File::create(outfile).expect(&format!("Error creating {}", outfile));

    output_file
        .write_all(greeting.as_bytes())
        .expect(&format!("Error writing: {}", outfile));

    let mut input_file = fs::File::open(outfile).expect(&format!("Error opening {}", outfile));

    let mut input = String::new();
    input_file
        .read_to_string(&mut input)
        .expect(&format!("Error reading: {}", outfile));

    println!("Read in from file: {}", input);
}
```

Build:

```bash
$ cargo build --release
   Compiling hello-security v0.1.0 (...)
    Finished `release` profile [optimized] target(s) in 0.57s
```

Run:

```bash
$ cargo run --release
    Finished `release` profile [optimized] target(s) in 0.00s
     Running `target/release/hello-security`
Read in from file: Hello Security
$ cat hello.txt
Hello Security
```

This small Rust example shows a simple file system access. A file is created, a text is written to it, read back from the file, and printed to the console. Writing and compiling the program is not a challenge. Even executing it and creating or accessing the file system works without problems. This is possible because, as the user and executor of the program, I have the necessary permissions for the resources used.

In this example, the program was written by oneself, but what if the software comes from somewhere else? This phenomenon is referred to as the [Confused Deputy Problem](https://en.wikipedia.org/wiki/Confused_deputy_problem).

---

The Confused Deputy Problem occurs when a program (the “deputy”) uses someone else’s permissions and accidentally does something it shouldn’t.
You go to the post office and say: “Send this package for free, I’m an employee.”

---

What happens if you compile not directly into an executable binary but via WebAssembly.

Build:

```bash
$ cargo build --target wasm32-wasip2 --release
   Compiling hello-security v0.1.0 (...)
    Finished `release` profile [optimized] target(s) in 0.30s
```

---

Note: Because WASI is still under heavy development, targets can change frequently. To show current possibilities use `rustc --print target-list`. If errors occur such as `std` not found, it may be that the target is not installed: `rustup target add wasm32-wasip2`.

---

Run:

```bash
$ wasmtime target/wasm32-wasip2/release/hello-security.wasm

thread 'main' panicked at src/main.rs:7:53:
Error creating hello.txt: Custom { kind: Uncategorized, error: "failed to find a pre-opened file descriptor through which \"hello.txt\" could be opened" }
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
Error: failed to run main module `target/wasm32-wasip2/release/hello-security.wasm`

Caused by:
    0: failed to invoke `run` function
    1: error while executing at wasm backtrace:
           0:   0x81cb - hello_security-090e4df4606edf50.wasm!__rust_start_panic
           1:   0x7de4 - hello_security-090e4df4606edf50.wasm!rust_panic
           2:   0x7db7 - hello_security-090e4df4606edf50.wasm!std::panicking::rust_panic_with_hook::hb7190c590f9be4d8
           3:   0x6d7a - hello_security-090e4df4606edf50.wasm!std::panicking::begin_panic_handler::{{closure}}::h48f52bd42a75647b
           4:   0x6cdb - hello_security-090e4df4606edf50.wasm!std::sys::backtrace::__rust_end_short_backtrace::h03e3c9e25b76593d
           5:   0x76ec - hello_security-090e4df4606edf50.wasm!rust_begin_unwind
           6:   0xdec7 - hello_security-090e4df4606edf50.wasm!core::panicking::panic_fmt::h6517fc7e4d8ce25f
           7:   0xfb94 - hello_security-090e4df4606edf50.wasm!core::result::unwrap_failed::hdd25c2c6a49e7f15
           8:   0x17a1 - hello_security-090e4df4606edf50.wasm!hello_security::main::hd3fa14b8c58e2c8a
           9:   0x1460 - hello_security-090e4df4606edf50.wasm!std::sys::backtrace::__rust_begin_short_backtrace::hfedc2d3118e53f13
          10:   0x1453 - hello_security-090e4df4606edf50.wasm!std::rt::lang_start::{{closure}}::h72fa6f82f816a30e
          11:   0x3977 - hello_security-090e4df4606edf50.wasm!std::rt::lang_start_internal::haa6ee9ed7c5d7b00
          12:   0x1b33 - hello_security-090e4df4606edf50.wasm!__main_void
          13:   0x142c - hello_security-090e4df4606edf50.wasm!_start
          14:  0x1a88e - wit-component:adapter:wasi_snapshot_preview1!wasi:cli/run@0.2.3#run
    2: wasm trap: wasm `unreachable` instruction executed
```

---

Note: Because WASI is still under heavy development, engines also change frequently. In case of problems, an update of [Wasmtime](https://wasmtime.dev/) might help: `curl https://wasmtime.dev/install.sh -sSf | bash`.

---

When running the WebAssembly module, something seems to no longer work. As the error message shows “failed to find a pre-opened file descriptor through which "hello.txt" could be opened”, the WASI host is missing the “pre-opened file descriptor” to access the file.

```bash
$ wasmtime --dir=. target/wasm32-wasip2/release/hello-security.wasm
Read in from file: Hello Security
```

If we now run Wasmtime with the permission to access the current folder, everything works as expected.

## Further Resources

- [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/15_capabilities_based_security)
- [Deutsche Version](https://github.com/marcokuoni/public_doc/tree/main/essays/15_capabilities_based_security/README.de.md)

I am happy to clarify, expand, or correct the article. Write feedback or contact me directly.

Created by [Marco Kuoni, July 2025](https://marcokuoni.ch)
