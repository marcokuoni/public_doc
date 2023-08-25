# JavaScript und Bytes
JavaScript kennt in der Regel nur den Datentyp `number` und ein `Array` kann aus beliebigen Typen bestehen. Somit ist nicht sichergestellt wie die Daten im Speicher abgelegt und angeordnet sind. Will man nun über eine API kommunizieren (Filesystem, Webworker, WebAssembly...) muss die Byte-Anordnung beim Empfang bzw. Senden sicher gestellt werden. Daher hat das WebGL Standard Komittee die Typed Arrays entwickelt.

![Array Buffer von mozilla.org](array_buffer.png)

To achieve maximum flexibility and efficiency, JavaScript typed arrays split the implementation into buffers and views. A buffer (implemented by the ArrayBuffer object) is an object representing a chunk of data; it has no format to speak of, and offers no mechanism for accessing its contents. In order to access the memory contained in a buffer, you need to use a view. A view provides a context — that is, a data type, starting offset, and number of elements — that turns the data into an actual typed array.


## Array Buffer
* [Array Buffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer)

The ArrayBuffer is a data type that is used to represent a generic, fixed-length binary data buffer. You can't directly manipulate the contents of an ArrayBuffer; instead, you create a typed array view or a DataView which represents the buffer in a specific format, and use that to read and write the contents of the buffer.



The `ArrayBuffer` object is used to represent a generic, fixed-length raw binary data buffer. You cannot directly manipulate the contents of an `ArrayBuffer`; instead, you create one of the typed array objects or a `DataView` object which represents the buffer in a specific format, and use that to read and write the contents of the buffer. It has special mechanisms to change there size and also to transfer them. If you transfer an `ArrayBuffer` the ownership of memory gets also moved and it's original copy gets detached.

```javascript

## Typed Arrays View
* [Typed Arrays](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays)
* [Typed Arrays](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypedArray)
* [Typed Arrays](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Typed_arrays)

Dies ermöglicht einen Weg um auf die Rohdaten im Speicher zuzugreifen. Folgende Typen sind verfügbar:
* `Int8Array` 8-bit signed integer
* `Uint8Array` 8-bit unsigned integer
* `Uint8ClampedArray` 8-bit unsigned integer (clamped)
* `Int16Array` 16-bit signed integer
* `Uint16Array` 16-bit unsigned integer
* `Int32Array` 32-bit signed integer
* `Uint32Array` 32-bit unsigned integer
* `Float32Array` 32-bit floating point number
* `Float64Array` 64-bit floating point number
* `BigInt64Array` 64-bit signed integer
* `BigUint64Array` 64-bit unsigned integer

```javascript
const u32arr = new Uint32Array([1, 2, 3]);
const u32buf = u32arr.buffer;
const u8arr = new Uint8Array(u32buf);

console.log(`u32arr length: ${u32arr.length} bytes: ${u32arr.byteLength}`);
console.log(`u32buf length: ${u32buf.length} bytes: ${u32buf.byteLength}`);
console.log(`u8arr length: ${u8arr.length} bytes: ${u8arr.byteLength}`);

console.log(`u32arr: ${u32arr}`);
console.log(`u32buf: ${u32buf}`);
console.log(`u8arr: ${u8arr}`);
```

## Data View
* [Data View](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView)
* [Data View](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays#typedarray)
* [Data View](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView#methods)

The `DataView` view provides a low-level interface for reading and writing multiple number types in an `ArrayBuffer` irrespective of the platform's endianness. You can use this to read and write to the buffer. 

The DataView is a low-level interface that provides a getter/setter API to read and write arbitrary data to the buffer. This is useful when dealing with different types of data, for example. Typed array views are in the native byte-order (see Endianness) of your platform. With a DataView you are able to control the byte-order. It is big-endian by default and can be set to little-endian in the getter/setter methods.

```
Register:
MSB      LSB
0A 0B 0C 0D

Memory:
Big-endien
a  : OA
a+1: 0B
a+2: 0C
a+3: 0D

Little-endien
a  : 0D
a+1: OC
a+2: 0B
a+3: 0A
```

```javascript
const buffer = new ArrayBuffer(21);
const view = new DataView(buffer);

view.setUint8(0, 4);
view.setUint16(1, 1);
view.setUint16(3, 1);
view.setFloat32(5, 0x80);
view.setFloat32(9, 0x80);
view.setFloat32(13, 0x80);
view.setFloat32(17, 0x80);

console.log(`Buffer:`, buffer);

const dv = new DataView(buffer);
const vector_length = dv.getUint8(0);
const width = dv.getUint16(1); // 0+uint8 = 1 bytes offset
const height = dv.getUint16(3); // 0+uint8+uint16 = 3 bytes offset
let littleEndianVectors = new Float32Array(width*height*vector_length);
let vectors = new Float32Array(width*height*vector_length);
for (let i=0, off=5; i<vectors.length; i++, off+=4) {
  littleEndianVectors[i] = dv.getFloat32(off, true);
  vectors[i] = dv.getFloat32(off, false);
}

console.log(`vector_length: ${vector_length}`);
console.log(`width: ${width}`);
console.log(`height: ${height}`);
console.log(`little endian vectors:`, littleEndianVectors);
console.log(`vectors:`, vectors);
```


## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/webassembly_modules_import_export)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/webassembly_modules_import_export/README.md)


Ich bin gerne bereit den Beitrag noch zu präzisieren, erweitern oder zu korrigieren. Schreibt Feedback oder meldet euch bei mir.

Erstellt von [Marco Kuoni, August 2023](https://marcokuoni.ch)