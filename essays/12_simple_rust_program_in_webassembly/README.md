# Simple Rust Program in WebAssembly
This guide does not cover the details of Rust or its installation. Since Rust is LLVM-based, it theoretically only needs a backend for WebAssembly. The backend is included in the Rust standard library.

---

If LLVM is new or there is further interest in the topic, I recommend consulting my previous posts:
* [Simple C Program in WebAssembly](https://medium.com/webassembly/simple-c-program-in-webassembly-1a7b148293c2) provides an introduction to LLVM, among other things.
* [First Experiences with WebAssembly](https://medium.com/webassembly/first-experiences-with-webassembly-dafb2cf2ab52) already uses wasm3 in a REPL-style.
  
---

```bash
$ rustup target list | grep installed
wasm32-unknown-unknown (installed)
wasm32-wasi (installed)
x86_64-unknown-linux-gnu (installed)
```

Rust backends are typically named according to the following schema: Instruction Set Architecture (ISA) - Vendor - Operating System (OS).

## Multiplying in Rust
As in the previous articles, a multiplication function is used as an example.

```rust
#[no_mangle]
pub extern "C" fn multiply(a: i32, b: i32) -> i32 {
    a * b
}

fn main() {
    println!("2 * 21 = {}", multiply(2, 21));
}
```

The `#[no_mangle]` annotation prevents Rust from altering the name of the function on compiling.

## Compilation
### For the Host System
To compile and run the program with the default backend, the following commands are used:

```bash
$ rustc multiply.rs 
$ ./multiply 
2 * 21 = 42
```

### For WebAssembly
To compile the source file into a WebAssembly file, the following command is used:

```bash
$ rustc -A dead_code --target wasm32-unknown-unknown -O --crate-type=cdylib multiply.rs -o multiply.wasm
```

Where `-A dead_code` suppresses the warning for unused functions. `-O` activates optimizations. `--crate-type=cdylib` specifies that a dynamic library should be created. `-o multiply.wasm` specifies the name of the output file.

The result can now be executed with `wasm3`:

```bash
$ wasm3 --func multiply multiply.wasm 2 21
Result: 42
```

Analyze:

```bash
$ wasm-objdump -x multiply.wasm

multiply.wasm:  file format wasm 0x1

Section Details:

Type[1]:
 - type[0] (i32, i32) -> i32
Function[1]:
 - func[0] sig=0 <multiply>
Table[1]:
 - table[0] type=funcref initial=1 max=1
Memory[1]:
 - memory[0] pages: initial=16
Global[3]:
 - global[0] i32 mutable=1 <__stack_pointer> - init i32=1048576
 - global[1] i32 mutable=0 <__data_end> - init i32=1048576
 - global[2] i32 mutable=0 <__heap_base> - init i32=1048576
Export[4]:
 - memory[0] -> "memory"
 - func[0] <multiply> -> "multiply"
 - global[1] -> "__data_end"
 - global[2] -> "__heap_base"
Code[1]:
 - func[0] size=7 <multiply>
Custom:
 - name: ".debug_info"
Custom:
 - name: ".debug_pubtypes"
Custom:
 - name: ".debug_ranges"
Custom:
 - name: ".debug_abbrev"
Custom:
 - name: ".debug_line"
Custom:
 - name: ".debug_str"
Custom:
 - name: ".debug_pubnames"
Custom:
 - name: "name"
 - func[0] <multiply>
 - global[0] <__stack_pointer>
Custom:
 - name: "producers"
Custom:
 - name: "target_features"
  - [+] mutable-globals
  - [+] sign-ext
```

#### Usage in a Web Application

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Simple Rust Program in WebAssembly</title>
</head>

<body>
    <form>
        <input type="number" name="a" value="3" />
        <input type="number" name="b" value ="14" />
        <button type="submit">Multiply</button>
        <output name="output">
    </form>
    <script>
        function fetchAndInstantiate(url, importObject) {
            return fetch(url)
                .then(response => response.arrayBuffer())
                .then(bytes => WebAssembly.instantiate(bytes, importObject))
                .then(results => results.instance);
        }

        document.addEventListener('DOMContentLoaded', function () {
            const form = document.querySelector('form');

            form.addEventListener('submit', function (event) {
                event.preventDefault();
                const formData = new FormData(form);

                const a = formData.get('a');
                const b = formData.get('b');

                fetchAndInstantiate('multiply.wasm')
                    .then(instance => {
                        const result = instance.exports.multiply(a, b);
                        form.output.value = result;
                    });
            });
        });
    </script>
</body>

</html>
```

Start application: `python3 -m http.server`.

Analyze in the browser: `http://localhost:8000`.

![Result of the web application](webapplication.png)

## Further Resources
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/12_simple_rust_program_in_webassembly)
* [Deutsche Version](https://github.com/marcokuoni/public_doc/tree/main/essays/12_simple_rust_program_in_webassembly/README.de.md)

I am open to refining, expanding, or correcting the article. Feel free to provide a feedback or get in touch with me.

Created by [Marco Kuoni, March 2024](https://marcokuoni.ch)
