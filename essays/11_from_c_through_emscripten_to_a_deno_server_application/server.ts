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