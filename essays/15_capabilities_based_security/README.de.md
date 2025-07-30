---
title: "Capabilities-Based Security mit WASI"
subtitle: "Sicherer Ressourcenzugriff in WebAssembly mit Capabilities-Based Security und WASI"
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
lang: de-CH
abstract: |
  WASI implementiert Capabilities-Based Security, indem es WebAssembly Modulen nur explizit zugewiesene Zugriffe gewährt. Anstatt globaler Benutzerrechte erhalten Programme einzelne «Schlüssel» (Capabilities) für genau die Ressourcen, die sie benötigen. Das schützt vor Missbrauch wie dem Confused Deputy Problem. Ein Beispiel zeigt, wie Dateizugriffe in WASI nur mit vorgängig gewährtem Ordnerzugriff funktionieren, wodurch Sandbox-Sicherheit sichergestellt wird.
email: mail@marcokuoni.ch
reference-section-title: Weiterführend
---

# Capabilities-Based Security mit WASI

Es soll die Möglichkeit bestehen, Anwendungen auf unseren Systemen Funktionalitäten beziehungsweise Zugriffe kontrolliert zur Verfügung zu stellen. Da im Voraus nicht bestimmt werden kann welche Software böswillig sein könnte, machen standardisierte Sandbox Umgebungen Sinn.

Von Anfang an war WASI bestrebt [Capabilities-Based Security](https://de.wikipedia.org/wiki/Capability-based_security) für die einzelnen WebAssembly Modulen durchzusetzen.

---

Capabilities-Based Security: Das ist ein Sicherheitsmodell, bei dem Zugriffsrechte direkt als Objekte (Capabilities) vergeben werden.

- Eine Capability ist wie ein Schlüssel, der dir erlaubt, etwas Bestimmtes zu tun.
- Wenn du keinen Schlüssel hast, kannst du es nicht tun.
- Programme oder Benutzer erhalten nur genau die Schlüssel, die sie brauchen (Principle of Least Privilege).

Somit keine globale Zugriffskontrolle mit Benutzer-IDs und Checks. Stattdessen werden Capabilities direkt weitergegeben.

---

WebAssembly gibt willkürlichem Code nicht direkten Zugriff zum Speicher. Genau gleich macht es WASI mit sensiblen Ressourcen wie Datei-Handler, Netzwerksockets, oder Details zu Unterprozessen. Diese Ressourcen werden den WebAssembly Modulen mit klar definierten und unfälschbaren Handlern zur Verfügung gestellt.

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

Builden:

```bash
$ cargo build --release
   Compiling hello-security v0.1.0 (...)
    Finished `release` profile [optimized] target(s) in 0.57s
```

Ausführen:

```bash
$ cargo run --release
    Finished `release` profile [optimized] target(s) in 0.00s
     Running `target/release/hello-security`
Read in from file: Hello Security
$ cat hello.txt
Hello Security
```

Dieses kleine Rust Beispiel zeigt einen einfachen Zugriff auf das Dateisystem. Es wird eine Datei erstellt, darin ein Text abgelegt, dieser von der Datei wieder eingelesen und auf der Konsole ausgegeben. Das Programm zu schreiben und zu compilieren ist dabei keine Herausforderung. Selbst das ausführen und das erstellen beziehungsweise zugreifen auf das Dateisystem geht ohne Probleme. Dies ist Möglich, da ich als Benutzer und Ausführer des Programms die nötigen Berechtigungen auf den benutzten Ressourcen verwende.

In diesem Beispiel wurde das Programm selbst geschrieben, was aber wenn die Software von irgendwo her stammt. Dieses Phänomen wird unter [Confused Deputy Problem](https://en.wikipedia.org/wiki/Confused_deputy_problem) gehandelt.

---

Das Confused Deputy Problem tritt auf, wenn ein Programm (der «Deputy», also «Stellvertreter») Berechtigungen von jemand anderem nutzt und dabei aus Versehen etwas macht, was es nicht sollte.
Man geht zur Post und sagt: «Schick dieses Paket gratis, ich bin ein Mitarbeiter.»

---

Was passiert nun wenn man nicht direkt in ein ausführbares Binary sondern über WebAssembly compiliert.

Builden:

```bash
$ cargo build --target wasm32-wasip2 --release
   Compiling hello-security v0.1.0 (...)
    Finished `release` profile [optimized] target(s) in 0.30s
```

---

Notiz: Weil WASI noch stark in Entwicklung ist können Targets laufend ändern, um die aktuellen Möglichkeiten anzuzeigen `rustc --print target-list`. Sollten Fehler auftauchen, wie das `std` nicht gefunden wird. So kann es sein, dass das Target nicht installiert ist `rustup target add wasm32-wasip2`

---

Ausführen:

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

Notiz: Weil WASI noch stark in Entwicklung ist ändern auch die Engines laufend, bei Problemen hilft vermutlich ein [Wasmtime](https://wasmtime.dev/) Update `curl https://wasmtime.dev/install.sh -sSf | bash`.

---

Beim Ausführen des WebAssembly's scheint nun etwas nicht mehr zu funktionieren. Wie der Fehlermeldung zu entnehmen ist «failed to find a pre-opened file descriptor through which \"hello.txt\" could be opened», fehlt dem WASI Host der «pre-opened file descriptor» um auf die Datei zuzugreifen.

```bash
$ wasmtime --dir=. target/wasm32-wasip2/release/hello-security.wasm
Read in from file: Hello Security
```

Führen wir nun Wasmtime mit der Erlaubnis aus, auf den aktuellen Ordners zugriff zu haben, funktioniert alles wie erwartet.

## Weiterführend

- [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/15_capabilities_based_security)
- [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/15_capabilities_based_security/README.md)

Ich bin gerne bereit den Artikel zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, Juli 2025](https://marcokuoni.ch)
