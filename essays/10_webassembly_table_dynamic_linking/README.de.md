# WebAssembly Tabelle Dynamisches Linken
Ein Abschnitt aus dem Artikel [WebAssebmly Module](https://medium.com/webassembly/webassembly-module-146783e725d9) fehlt noch. Dabei geht es um den Abschnitt `Table`, welcher für das dynamische Linken verwendet wird.
Mit dem Ansatz des dynamischen Linken kann einem Modul zur Laufzeit Abhängigkeiten zur Verfügungstellt werden. Als Beispiel kann so ein zentralisiertes Modul erstellt werden, welches von verschiedenen anderen Modulen verwendet werden kann. Damit kann die Funktionalität des zentralisierten Moduls erweitert werden, ohne dass die anderen Module neu kompiliert werden müssen. So werden Code Duplikationen vermieden, Speicherplatz reduziert und die Wartbarkeit verbessert.

## Tabelle
[`Table`](https://webassembly.github.io/spec/core/syntax/modules.html#syntax-table) hat ähnliche Charakteristiken wie [`Memory`](https://webassembly.github.io/spec/core/syntax/modules.html#memories) aus meinem alten Arikel [WebAssembly Memory](https://medium.com/webassembly/webassembly-memory-32bbe210112c). Eine Tabelle ist für externe Module readonly. Das heisst über eine Tabelle können indirekte Referenzen aufgerufen werden, zum Beispiel zu Funktionen. Jedoch können keine Werte in die Tabelle geschrieben werden.
Aktuell ist es so, dass nur der [reftype](https://webassembly.github.io/spec/core/syntax/types.html#table-types) Typ erlaubt ist was primär Funktionenreferenzen enspricht. Genau gleich wie die Einschränkung von nur einer `Table` beziehungsweise einem `Memory` pro Modul, werden diese Spezifikationen in zukünftigen WebAssembly Versionen vermutlich erweitert.

### Beispiel
Es wird ein sehr einfache implementierung eines Mathematik-Moduls erstellt, welches seine Funktionen (Multiplikation, Division) via Table exportiert.

```wat
(module
    (func $mul (param $a i32) (param $b i32) (result i32)
        (i32.mul (local.get $a) (local.get $b))
    )

    (func $div (param $a i32) (param $b i32) (result i32)
        (i32.div_s (local.get $a) (local.get $b))
    )

    (table (export "math_tbl") 2 funcref)
    (elem (i32.const 0) $mul $div)
)
```

Kurbeschreibung:
* Funktionsdefinitionen wie bekannt
* `table` beinhaltet ein Array der grösse Zwei mit dem Typ `funcref`
* Die Tabelle wird mit dem Namen `math_tbl` exportiert
* `elem` initialisiert die Tabelle mit den Funktionen `mul` und `div`. Dabei ist der Startindex und die Reihenfolge der Funktionen wichtig für den späteren Aufruf.

Kompilieren `wat2wasm math.wat`
Analysieren `wasm-objdump -x math.wasm`

```bash
$ wasm-objdump -x math.wasm 

math.wasm:      file format wasm 0x1

Section Details:

Type[1]:
 - type[0] (i32, i32) -> i32
Function[2]:
 - func[0] sig=0
 - func[1] sig=0
Table[1]:
 - table[0] type=funcref initial=2
Export[1]:
 - table[0] -> "math_tbl"
Elem[1]:
 - segment[0] flags=0 table=0 count=2 - init i32=0
  - elem[0] = func[0]
  - elem[1] = func[1]
Code[2]:
 - func[0] size=7
 - func[1] size=7
```

Was nun in einer Webanwendung verwendet werden kann 

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>WebAssembly Table Dynamic Linking</title>
</head>

<body>
    <h1>WebAssembly Table Dynamic Linking</h1>
    <h2>Multiply</h2>
    <form id="mul">
        <input type="number" name="a" value="3">
        <input type="number" name="b" value="14">
        <button type="submit">Multiply</button>
        <output name="output"></output>
    </form>

    <h2>Divide</h2>
    <form id="div">
        <input type="number" name="a" value="84">
        <input type="number" name="b" value="2">
        <button type="submit">Divide</button>
        <output name="output"></output>
    </form>
    <script>
        function fetchAndInstantiate(url, importObject) {
            return fetch(url)
                .then(response => response.arrayBuffer())
                .then(bytes => WebAssembly.instantiate(bytes, importObject))
                .then(results => results.instance);
        }

        document.addEventListener('DOMContentLoaded', function () {
            const formMul = document.querySelector('form#mul');
            const formDiv = document.querySelector('form#div');

            formMul.addEventListener('submit', function (event) {
                event.preventDefault();
                const form = event.target;
                const formData = new FormData(form);

                const a = formData.get('a');
                const b = formData.get('b');

                fetchAndInstantiate('math.wasm')
                    .then(instance => {
                        const mathTbl = instance.exports.math_tbl;

                        form.output.value = mathTbl.get(0)(a, b);
                    });
            });

            formDiv.addEventListener('submit', function (event) {
                event.preventDefault();
                const form = event.target;
                const formData = new FormData(form);

                const a = formData.get('a');
                const b = formData.get('b');

                fetchAndInstantiate('math.wasm')
                    .then(instance => {
                        const mathTbl = instance.exports.math_tbl;

                        form.output.value = mathTbl.get(1)(a, b);
                    });
            });
        });
    </script>
</body>

</html>
```

Anwendung starten `python3 -m http.server`

Analysieren im Browser `http://localhost:8000`

![Web Application Calculator](webapp.png)

## Dynamisches Linken
Im folgenden Beispiel werden zwei Module erstellt. Wobei ein Modul die Mathematischen Funktionen zur Verfügung stellt und das andere Modul diese verwendet. Im unterschied zum letzten Beispiel, wird nun die Tabelle vom Gästesystem zur Verfügung gestellt und in den Modulen importiert.

### Mathematik Modul
```wat
(module
    (import "env" "math_tbl" (table 2 funcref))

    (func $mul (param $a i32) (param $b i32) (result i32)
        (i32.mul (local.get $a) (local.get $b))
    )

    (func $div (param $a i32) (param $b i32) (result i32)
        (i32.div_s (local.get $a) (local.get $b))
    )

    (elem (i32.const 0) $mul)
    (elem (i32.const 1) $div)
)
```

Kurbeschreibung:
* `import` importiert die Tabelle vom Gästesystem mit einer Grösse von 2 und dem Typ `funcref`
* `elem` im Unterschied zu vorher nun einzeln ausgeführt mit unterschiedlichen Startindizes. Die Referenzen zu den Funktionen werden so in der übergebenen Tabelle initialisiert.
* Im Modul wird somit nur indirekt exportiert. Die Funktionen können nur über die Tabelle aufgerufen werden.
  
Kompilieren `wat2wasm math_ext.wat`
Analysieren `wasm-objdump -x math_ext.wasm`

```bash
$ wasm-objdump -x math_ext.wasm

math_ext.wasm:  file format wasm 0x1

Section Details:

Type[1]:
 - type[0] (i32, i32) -> i32
Import[1]:
 - table[0] type=funcref initial=2 <- env.math_tbl
Function[2]:
 - func[0] sig=0
 - func[1] sig=0
Elem[2]:
 - segment[0] flags=0 table=0 count=1 - init i32=0
  - elem[0] = func[0]
 - segment[1] flags=0 table=0 count=1 - init i32=1
  - elem[1] = func[1]
Code[2]:
 - func[0] size=7
 - func[1] size=7
 ```

### Anwendung Modul
```wat
(module
    (import "env" "math_tbl" (table 2 funcref))

    (type $t0 (func (param $a i32) (param $b i32) (result i32)))

    (func $mul_cust (export "mul_cust") (param $a i32) (param $b i32) (result i32)
        (call_indirect (type $t0) (local.get $a) (local.get $b) (i32.const 0))
    )

    (func $div_cust (export "div_cust") (param $a i32) (param $b i32) (result i32)
        (call_indirect (type $t0) (local.get $a) (local.get $b) (i32.const 1))
    )
)
```

Kurbeschreibung:
* `import` importiert die Tabelle vom Gästesystem mit einer Grösse von 2 und dem Typ `funcref`
* `type` definiert den Typ `t0` mit den Parametern `a` und `b` vom Typ `i32` und dem Resultat als `i32`. Wird als Typendefinition für die erwarteten Funktionen von der Tabelle verwendet.
* `func` definiert und exportiert die Funktionen `mul_cust` und `div_cust`. Die Funktionen rufen jeweils die Referenzen aus der übergebenen Tabelle mit `call_indirect` dem Type `t0`, den Input-Parametern und dem jeweiligen Tabellen Index auf.

Kompilieren `wat2wasm math_custom.wat`
Analysieren `wasm-objdump -x math_custom.wasm`

```bash
$ wasm-objdump -x math_custom.wasm 

math_custom.wasm:       file format wasm 0x1

Section Details:

Type[1]:
 - type[0] (i32, i32) -> i32
Import[1]:
 - table[0] type=funcref initial=2 <- env.math_tbl
Function[2]:
 - func[0] sig=0 <mul_cust>
 - func[1] sig=0 <div_cust>
Export[2]:
 - func[0] <mul_cust> -> "mul_cust"
 - func[1] <div_cust> -> "div_cust"
Code[2]:
 - func[0] size=11 <mul_cust>
 - func[1] size=11 <div_cust>
 ```

### Webanwendung
```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>WebAssembly Table Dynamic Linking</title>
</head>

<body>
    <h1>WebAssembly Table Dynamic Linking</h1>
    <h2>Multiply</h2>
    <form id="mul">
        <input type="number" name="a" value="3">
        <input type="number" name="b" value="14">
        <button type="submit">Multiply</button>
        <output name="output"></output>
    </form>

    <h2>Divide</h2>
    <form id="div">
        <input type="number" name="a" value="84">
        <input type="number" name="b" value="2">
        <button type="submit">Divide</button>
        <output name="output"></output>
    </form>
    <script>
        function fetchAndInstantiate(url, importObject) {
            return fetch(url)
                .then(response => response.arrayBuffer())
                .then(bytes => WebAssembly.instantiate(bytes, importObject))
                .then(results => results.instance);
        }

        const mathTbl = new WebAssembly.Table({
            initial: 2,
            element: 'anyfunc'
        });

        const importObject = {
            env: {
                math_tbl: mathTbl
            }
        };

        document.addEventListener('DOMContentLoaded', function () {
            const formMul = document.querySelector('form#mul');
            const formDiv = document.querySelector('form#div');

            formMul.addEventListener('submit', function (event) {
                event.preventDefault();
                const form = event.target;
                const formData = new FormData(form);

                const a = formData.get('a');
                const b = formData.get('b');

                Promise.all([
                    fetchAndInstantiate('math_ext.wasm', importObject),
                    fetchAndInstantiate('math_custom.wasm', importObject)
                ]).then(instances => {
                    form.output.value = instances[1].exports.mul_cust(a, b);
                });
            });

            formDiv.addEventListener('submit', function (event) {
                event.preventDefault();
                const form = event.target;
                const formData = new FormData(form);

                const a = formData.get('a');
                const b = formData.get('b');

                Promise.all([
                    fetchAndInstantiate('math_ext.wasm', importObject),
                    fetchAndInstantiate('math_custom.wasm', importObject)
                ]).then(instances => {
                    form.output.value = instances[1].exports.div_cust(a, b);
                });
            });
        });
    </script>
</body>

</html>
```

Anwendung starten `python3 -m http.server`

Analysieren im Browser `http://localhost:8000/index_custom.html`

Das Resultat sieht gleich aus wie im vorherigen Beispiel. Im Unterschied wird nun aber die Tabelle vom Gästesystem ([WebAssembly API](https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Table)) zur Verfügung gestellt und es muss mit einem `Promise.all` sichergestellt werden, dass vor der Verwendung des Custom Moduls, das externe Modul auch geladen und initialisiert wurde.


## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/10_webassembly_table_dynamic_linking)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/10_webassembly_table_dynamic_linking/README.md)
* [mdn: Defining a table in Wasm](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format#webassembly_tables)

Ich bin gerne bereit den Artikel zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, November 2023](https://marcokuoni.ch)