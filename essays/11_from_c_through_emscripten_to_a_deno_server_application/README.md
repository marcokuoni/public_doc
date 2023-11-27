# From C through Emscripten to a Deno Server Application
[WebAssembly for Node.js](https://nodejs.org/en/learn/getting-started/nodejs-with-webassembly) has been on the road for almost as long as the implementation in the web browser. It is interesting to replace [C/C++ Addons](https://nodejs.org/dist/latest-v20.x/docs/api/addons.html) with WebAssembly modules. These C/C++ Addons are compiled into specific machine code using [node-gyp](https://github.com/nodejs/node-gyp), which complicates the portability of the addon, making a WebAssembly implementation attractive. Especially when, for example, using [Wasmtime](https://docs.wasmtime.dev/) with [WASI](https://wasi.dev/) (WebAssembly System Interface), so you can access system functions. WebAssembly Modules also allows the use of various alternative programming languages such as [Rust](https://www.rust-lang.org/), [Go](https://golang.org/), or [AssemblyScript](https://www.assemblyscript.org/).

To demonstrate that the newer and by default secure sibling [Deno also supports WebAssembly](https://docs.deno.com/runtime/manual/runtime/webassembly#using-webassembly) modules, a small example application is shown here. In this case, a C program is compiled into a WebAssembly module using Emscripten and executed in Deno in a server application.

A brief note on [Supply Chain Attacks](https://www.fortinet.com/resources/cyberglossary/supply-chain-attacks): Caution is always advised when using externally created modules.

## WebAssembly Math Module
```c
#include <emscripten.h>

EMSCRIPTEN_KEEPALIVE
int mul(int a, int b) {
    return a * b;
}

EMSCRIPTEN_KEEPALIVE
int div(int a, int b) {
    return a / b;
}
```

Compiling the C program with Emscripten: `emcc math.c`

This creates two files, `a.out.js` and `a.out.wasm`. In this case, only the WebAssembly module is needed. The JavaScript file could be used directly as an alternative, as shown in other articles like [Porting Third Party to WebAssembly](https://medium.com/webassembly/porting-third-party-to-webassembly-46c2e4eb8cbe).

Analysis in WebAssembly Text Format: `wasm2wat a.out.wasm > a.out.wat`

Or alternatively:

```bash
$ wasm-objdump -x a.out.wasm 

a.out.wasm:     file format wasm 0x1

Section Details:

Type[7]:
 - type[0] () -> i32
 - type[1] () -> nil
 - type[2] (i32) -> nil
 - type[3] (i32, i32) -> i32
 - type[4] (i32) -> i32
 - type[5] (i32, i32, i32) -> i32
 - type[6] (i32, i64, i32) -> i64
Function[16]:
 - func[0] sig=1 <__wasm_call_ctors>
 - func[1] sig=3 <mul>
 - func[2] sig=3 <div>
 - func[3] sig=0 <stackSave>
 - func[4] sig=2 <stackRestore>
 - func[5] sig=4 <stackAlloc>
 - func[6] sig=1 <emscripten_stack_init>
 - func[7] sig=0 <emscripten_stack_get_free>
 - func[8] sig=0 <emscripten_stack_get_base>
 - func[9] sig=0 <emscripten_stack_get_end>
 - func[10] sig=2
 - func[11] sig=0
 - func[12] sig=4
 - func[13] sig=1 <__stdio_exit>
 - func[14] sig=2
 - func[15] sig=0 <__errno_location>
Table[1]:
 - table[0] type=funcref initial=1 max=1
Memory[1]:
 - memory[0] pages: initial=256 max=256
Global[3]:
 - global[0] i32 mutable=1 - init i32=5243920
 - global[1] i32 mutable=1 - init i32=0
 - global[2] i32 mutable=1 - init i32=0
Export[14]:
 - memory[0] -> "memory"
 - func[0] <__wasm_call_ctors> -> "__wasm_call_ctors"
 - func[1] <mul> -> "mul"
 - func[2] <div> -> "div"
 - table[0] -> "__indirect_function_table"
 - func[15] <__errno_location> -> "__errno_location"
 - func[13] <__stdio_exit> -> "__stdio_exit"
 - func[6] <emscripten_stack_init> -> "emscripten_stack_init"
 - func[7] <emscripten_stack_get_free> -> "emscripten_stack_get_free"
 - func[8] <emscripten_stack_get_base> -> "emscripten_stack_get_base"
 - func[9] <emscripten_stack_get_end> -> "emscripten_stack_get_end"
 - func[3] <stackSave> -> "stackSave"
 - func[4] <stackRestore> -> "stackRestore"
 - func[5] <stackAlloc> -> "stackAlloc"
Code[16]:
 - func[0] size=4 <__wasm_call_ctors>
 - func[1] size=57 <mul>
 - func[2] size=57 <div>
 - func[3] size=4 <stackSave>
 - func[4] size=6 <stackRestore>
 - func[5] size=18 <stackAlloc>
 - func[6] size=20 <emscripten_stack_init>
 - func[7] size=7 <emscripten_stack_get_free>
 - func[8] size=4 <emscripten_stack_get_base>
 - func[9] size=4 <emscripten_stack_get_end>
 - func[10] size=2
 - func[11] size=10
 - func[12] size=4
 - func[13] size=57 <__stdio_exit>
 - func[14] size=97
 - func[15] size=5 <__errno_location>
 ```

Interesting at this point are the designations `mul` and `div` of the exported functions under `Export[14]`. These are now used in the Deno server application.

## Deno Server Application
```typescript
import { serve } from "https://deno.land/std/http/server.ts";
import { join } from "https://deno.land/std/path/mod.ts";

const wasmPath = join(Deno.cwd(), "a.out.wasm");
const wasmCode = await Deno.readFile(wasmPath);
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule);
const wasmExports = wasmInstance.exports;
const mul = wasmExports.mul as (a: number, b: number) => number;
const div = wasmExports.div as (a: number, b: number) => number;

function requestHandler(request: Request): Response {
    const searchParams = new URL(request.url).searchParams;
    const a = parseInt(searchParams.get('a') || '14')
    const b = parseInt(searchParams.get('b') || '3')

    const result = `mul(${a}, ${b}) = ${mul(a, b)}\ndiv(${a}, ${b}) = ${div(a, b)}`;

    return new Response(result);
}

const server = serve(requestHandler, { port: 8000 });
```

To start the server:

```bash
$ deno run --allow-read --allow-net server.ts
Listening on http://localhost:8000/
```

Calling the server: `http://localhost:8000/?a=14&b=3`

![Web Application](webapplication.png)

Short Explanation:
* First, the WebAssembly module is loaded from the filesystem and instantiated.
* The exported functions are then assigned to TypeScript variables.
* A server on port 8000 is started, and the `requestHandler` function is passed as the handler.
* In the handler, an attempt is made to read and convert the search parameters `a` and `b` from the URL into integers.
* The integers are passed to the WebAssembly functions.
* The result of the two WebAssembly functions is returned as a string in the body of the `Response`.
* Deno is also started with the `--allow-read` and `--allow-net` flags to allow the server to access the filesystem and the network.

## Further Resources
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/11_from_c_through_emscripten_to_a_deno_server_application)
* [Deutsche Version](https://github.com/marcokuoni/public_doc/tree/main/essays/11_from_c_through_emscripten_to_a_deno_server_application/README.de.md)
* [Connect to SQLite with the WASM-Optimized Module in Deno](https://docs.deno.com/runtime/manual/basics/connecting_to_databases#connect-to-sqlite-with-the-wasm-optimized-module)

A brief note on the experimental implementation of [ES6 WebAssembly Modules](https://nodejs.org/api/esm.html#wasm-modules). This allows for a elegant use of WebAssembly modules in Node.js.

```javascript
import * as M from './module.wasm';
console.log(M); 
```

I am open to refining, expanding, or correcting the article. Feel free to provide a feedback or get in touch with me.

Created by [Marco Kuoni, November 2023](https://marcokuoni.ch)
