# WebAssembly: The Definitive Guide

Github: https://github.com/bsletten/wasm_tdg
Book Extras: https://www.oreilly.com/library/view/webassembly-the-definitive/9781492089834/

## Links
* [Andreas Hasas, June 2017, Bringing the web up to speed with WebAssembly](https://dl.acm.org/doi/10.1145/3062341.3062363)

## WebAssembly Text Format (WAT, *.wat)
* [WebAssembly Text Format (WAT)](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format)
* [WebAssembly Text Format (WAT) Specification](https://webassembly.github.io/spec/core/text/index.html)

Das binäre Format *.wasm ist für Menschen nicht lesbar. Das Textformat *.wat ist für Menschen lesbar. Das Textformat kann in das binäre Format kompiliert werden und somit vom Mensch geschrieben werden. Das Format besteht aus Modulen, die aus Funktionen bestehen. Funktionen bestehen aus Instruktionen für den Stackautomaten. Somit wird der WASM-Code auf einer virtuellen Stackmaschine ausgeführt. Die Instruktionen sind in der [WebAssembly Specification](https://webassembly.github.io/spec/core/binary/instructions.html) definiert. Sofern das Hostsystem somit die Maschine zur Verfügung stellt kann der Code ausgeführt werden.

Hier ein Beispiel für eine Funktion, die zwei Zahlen subtrahiert:
```wat
(module
  (func $how_old (param $year_now i32) (param $year_born i32) (result i32)
    get_local $year_now
    get_local $year_born
    i32.sub)
  (export "how_old" (func $how_old)))
```

> Note: Interne Funktionen starten mit `$`. Die Parameter werden jeweils auf einen Stack gelegt um sie zu verarbeiten. Die Funktion `i32.sub` subtrahiert die obersten zwei Elemente des Stacks und legt das Ergebnis wieder auf den Stack.

Aktuell vorhandene Typen:
* `i32` 32-bit signed integer
* `i64` 64-bit signed integer
* `f32` 32-bit floating point number
* `f64` 64-bit floating point number

## WebAssembly Binary Format (WASM, *.wasm)
* [WebAssembly Binary Format (WASM)](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_binary_format)
* [WebAssembly Binary Format (WASM) Specification](https://webassembly.github.io/spec/core/binary/index.html)

Um nun das Textformat in das binäre Format zu kompilieren kann der [wat2wasm](https://webassembly.github.io/wabt/demo/wat2wasm/) Compiler verwendet werden. wat2wasm zeigt in vier Bereichen folgende Informationen an:
* WAT: Der eingegebene WAT-Code
* Build Log: Der Build Log des Compilers (Hex Dump)
* JavaScript: Der JavaScript-Code, der den WASM-Code ausführt
* JS Log: Das Resultat des JavaScript-Codes
Alternativ kann auch das WebAssembly Binary Toolkit (WABT, ausgesprochen wabbit) verwendet werden. Dieses bietet zusätzlich noch weitere Tools an, zur Übersetzung wird `wat2wasm` verwendet.
Das Resultat konnte von 200 Byte (WAT) auf 45 Byte (WASM) reduziert werden. Welches nun wieder in Node.js oder anderen Umgebungen ausgeführt werden kann.
> wasm3 wäre ein Interpreter für WASM, der in C geschrieben ist und auf vielen Plattformen läuft. Damit kann nun der WASM-Code im Repl Stil auf dem Betriebssystem ausgeführt werden. `wasm3 --repl hello.wasm` -> `wasm3> how_old 2021 2000` -> `21`


## Modules
WebAssembly Code Explorer
* [Online] (https://wasdk.github.io/wasmcodeexplorer/)
* [Github] (https://github.com/wasdk/wasmcodeexplorer)

Every file starts with the content type `0x6d736100` (WASM). The next 4 bytes are the version number `0x01 0x00 0x00 0x00`. This numbers are also called the «magic numbers».
The Wabt toolkit is also quite helpful to inspect the WASM file. `wasm-objdump -h hello.wasm` shows the header of the WASM file.
```bash
$> wasm-objdump hello.wasm
At leas one of te following switches mus be given:
-d/--disassemble
-h/--headers
-x/--details
-s/--full-contents
```

### WebAssembly module sections
* [WebAssembly module sections](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format#webassembly_module_sections)
* [WebAssembly module sections](https://webassembly.github.io/spec/core/binary/modules.html#binary-module)

ID | Name | Description
---|------|------------
0 | Custom | Custom sections are used for debugging information, embedding other languages, or anything else that doesn't fit into the other sections.
1 | Type | The type section is used to define all the function signatures that are used in the module.
2 | Import | The import section is used to import functions, globals, memories, and tables from the environment into the module.
3 | Function | The function section is used to define all the functions in the module.
4 | Table | The table section is used to define all the tables in the module.
5 | Memory | The memory section is used to define all the memories in the module.
6 | Global | The global section is used to define all the globals in the module.
7 | Export | The export section is used to export functions, globals, memories, and tables from the module.
8 | Start | The start section is used to declare the function that will be called when the module is instantiated.
9 | Element | The element section is used to initialize the elements of tables.
10 | Code | The code section is used to define the function bodies.
11 | Data | The data section is used to initialize the data segments of memories.
12 | Data Count | The numbe of data elements defined by the module

By building the the wasm with the switch --debug-names it will insert some extra information, like the parameter names of the functions.
`wat2wasm multiply.wat -o multiply.wasm --debug-names`

* [Proposal for ES6 Modules in WebAssembly by lin clark] (https://www.youtube.com/watch?v=qR_b5gajwug)


## Eigene Rezession

## Review

