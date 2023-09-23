# Emscripten einfache Portabilität, C/C++ -> WebAssembly
Warum macht eine einfache Portabilität von C/C++ Programmen zu WebAssembly Sinn? 

Es gibt hierzu diverse Gründe, einige sind hier kurz aufgezählt:
* Es gibt bereits grosse Bibliotheken an bestehenden C/C++ Programmen.
* Es gibt Problemstellungen welche in JavaScript nicht optimal gelöst werden können.
* Es benötigt keine separate Runtime, sondern wird bereits kompiliert ausgeliefert. Dies spart Speicher aber auch Performance auf den Endgeräten.
* Es können verschiedene Sprachen gemischt eingesetzt werden.
* Es kann Vertrauenswürdiger Code von Vertrauenswürdigen Quellen verwendet werden. Ein gutes Beispiel ist hier [libsodium](https://doc.libsodium.org), welches die [Networking and Cryptography (NaCl)](https://nacl.cr.yp.to/) Bibliothek direkt von der Quelle zu WebAssembly bringt.

[Emscripten](https://emscripten.org) legt hier das Fundament um diese Portabilität möglichst leicht zu ermöglichen. Emscripten hat schon lange bestand und wird durch die beiden Hauptbeteiligten [Alon Zakai](https://kripken.github.io/blog/about/) und [Luke Wagner](https://github.com/lukewagner) entwickelt. Welche auch schon bei asm.js und nun bei WebAssembly bis Heute mitwirken. Auch dieses Projekt baut auf der LLVM Plattform auf, wobei das Backend in zwischen Zeit vom asm.js Kompiler zu einem WebAssembly Kompiler gewechselt wurde.

Eine solche Portabilität ist nicht ganz einfach umzusetzen. Alleine der Fakt, dass zum Beispiel ein Browser im Normalfall ein Single-Threaded Environment ist führt zu Herausforderungen. Zudem gibt es auch diverse Schnittstellen mit der Aussenwelt, welche es anzubinden gilt. Die Emscripten Toolchain bietet hierzu viele nützliche Hilfestellungen um nativen C/C++ Code effizient in eine Sandbox zu portieren. Welche dann auf unterschiedlichen Systemen in Form von JavaScript ausgeführt werden kann.

---

Ist dies alles Neuland oder besteht das Verlagen die Details einer Portierung zu kennen, dann empfehle ich meine älteren Artikel zu konsultieren:
* [Ein einfaches C Programm in WebAssembly](https://medium.com/webassembly/simple-c-program-in-webassembly-1a7b148293c2) wie ein einfaches C Programm als WebAssembly kompiliert und in einer Webanwendung verwendet werden kann.
* ["Hello World" C++ Programm](https://medium.com/webassembly/hello-world-c-program-4b85d3f8fbea) Ist ein einfaches C++ Programm, aber wie implementiert man es so, dass es in einer Webanwendung als WebAssembly verwendet werden kann?

---

## Hello WebAssembly
Hier zur Einführung ein ganz einfaches C Programm, welches mit Emscripten portiert wird.
> Im nächsten Artikel besteht die Idee ein bestehendes kleines C/C++ Projekt mit Emscripten zu portieren. Infos für mögliche Programme kann man mir gerne mitteilen. Das Projekt wird portiert und im nächsten Artikel dokumentiert.

Um die Emscripten Toolchain zu verwenden, muss diese zuerst installiert werden. Die Installation ist auf der [Emscripten Website](https://emscripten.org/docs/getting_started/downloads.html) beschrieben. Es gibt zudem auch eine [Docker Version](https://hub.docker.com/r/emscripten/emsdk).

Das Beispielprogramm sieht wie folgt aus:

```c
#include <stdio.h>

int main() {
    printf("Hello WebAssembly\n");
    return 0;
}
```

Das Kompilieren des Programms `emcc hello_webassembly.c -o hello_webassembly.js` erzeugt zwei Dateien: `hello_webassembly.js` und `hello_webassembly.wasm`

Wobei die etwas grosse JavaScript Datei die WebAssembly Datei lädt, ausführt und als Schnittstelle (*Runtime, Sandbox) zur Verfügung stellt. Diese kann in unterschiedlichen JavaScript Umgebungen verwendet werden. Zum Beispiel als Server Applikation in [Node](https://nodejs.org/de) oder [Bun](https://bun.sh/):

```bash
$ node hello_webassembly.js
Hello WebAssembly
$ bun hello_webassembly.js
Hello WebAssembly
```

Oder in einer Client Applikation:

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Emscripten Easy Portability, C/C++ -> WebAssembly</title>
</head>

<body>
    <h1>Emscripten Easy Portability, C/C++ -> WebAssembly</h1>
    <script src="hello_webassembly.js"></script>
</body>

</html>
```

Anwendung starten `python3 -m http.server`.

Analysieren im Browser `http://localhost:8000`.

![Console Log der Webanwendung](console_log.png)

### Interpretation des Resultats

Analysieren der WebAssembly Datei `wasm-objdump -x hello_webassembly.wasm`.

```bash
$ wasm-objdump -x hello_webassembly.wasm

hello_webassembly.wasm: file format wasm 0x1

Section Details:

Type[22]:
 - type[0] () -> i32
 - type[1] (i32, i32, i32) -> i32
 - type[2] (i32) -> i32
 - type[3] (i32) -> nil
 - type[4] () -> nil
 - type[5] (i32, i32) -> i32
 - type[6] (i32, i64, i32) -> i64
 - type[7] (i32, i32, i32) -> nil
 - type[8] (i32, i32, i32, i32, i32) -> i32
 - type[9] (i32, f64, i32, i32, i32, i32) -> i32
 - type[10] (i32, i32) -> nil
 - type[11] (i64, i32) -> i32
 - type[12] (i32, i64, i64, i32) -> nil
 - type[13] (i32, i32, i32, i32) -> i32
 - type[14] (f64, i32) -> f64
 - type[15] (i32, i32, i32, i32, i32, i32, i32) -> i32
 - type[16] (i32, i32, i32, i32) -> nil
 - type[17] (i64, i32, i32) -> i32
 - type[18] (i32, i32, i32, i32, i32) -> nil
 - type[19] (f64) -> i64
 - type[20] (i64, i64) -> f64
 - type[21] (i32, i32, i64, i32) -> i64
Import[2]:
 - func[0] sig=13 <wasi_snapshot_preview1.fd_write> <- wasi_snapshot_preview1.fd_write
 - func[1] sig=7 <env.emscripten_memcpy_js> <- env.emscripten_memcpy_js
Function[58]:
 - func[2] sig=4 <__wasm_call_ctors>
 - func[3] sig=0
 - func[4] sig=5 <main>
 - func[5] sig=5
 - func[6] sig=1
 - func[7] sig=2
 - func[8] sig=6
 - func[9] sig=1
 - func[10] sig=2
 - func[11] sig=3
 - func[12] sig=3
 - func[13] sig=3
 - func[14] sig=0
 - func[15] sig=4
 - func[16] sig=2
 - func[17] sig=2
 - func[18] sig=1
 - func[19] sig=5
 - func[20] sig=0 <__errno_location>
 - func[21] sig=14
 - func[22] sig=1
 - func[23] sig=1
 - func[24] sig=8
 - func[25] sig=15
 - func[26] sig=7
 - func[27] sig=2
 - func[28] sig=16
 - func[29] sig=17
 - func[30] sig=11
 - func[31] sig=11
 - func[32] sig=18
 - func[33] sig=1
 - func[34] sig=9
 - func[35] sig=10
 - func[36] sig=19
 - func[37] sig=2
 - func[38] sig=0
 - func[39] sig=0
 - func[40] sig=0
 - func[41] sig=4
 - func[42] sig=1
 - func[43] sig=5
 - func[44] sig=12
 - func[45] sig=12
 - func[46] sig=20
 - func[47] sig=3
 - func[48] sig=0
 - func[49] sig=4 <emscripten_stack_init>
 - func[50] sig=0 <emscripten_stack_get_free>
 - func[51] sig=0 <emscripten_stack_get_base>
 - func[52] sig=0 <emscripten_stack_get_end>
 - func[53] sig=2 <fflush>
 - func[54] sig=0 <stackSave>
 - func[55] sig=3 <stackRestore>
 - func[56] sig=2 <stackAlloc>
 - func[57] sig=0 <emscripten_stack_get_current>
 - func[58] sig=21
 - func[59] sig=8 <dynCall_jiji>
Table[1]:
 - table[0] type=funcref initial=6 max=6
Memory[1]:
 - memory[0] pages: initial=256 max=256
Global[4]:
 - global[0] i32 mutable=1 - init i32=65536
 - global[1] i32 mutable=1 - init i32=0
 - global[2] i32 mutable=1 - init i32=0
 - global[3] i32 mutable=1 - init i32=0
Export[15]:
 - memory[0] -> "memory"
 - func[2] <__wasm_call_ctors> -> "__wasm_call_ctors"
 - func[4] <main> -> "main"
 - table[0] -> "__indirect_function_table"
 - func[20] <__errno_location> -> "__errno_location"
 - func[53] <fflush> -> "fflush"
 - func[49] <emscripten_stack_init> -> "emscripten_stack_init"
 - func[50] <emscripten_stack_get_free> -> "emscripten_stack_get_free"
 - func[51] <emscripten_stack_get_base> -> "emscripten_stack_get_base"
 - func[52] <emscripten_stack_get_end> -> "emscripten_stack_get_end"
 - func[54] <stackSave> -> "stackSave"
 - func[55] <stackRestore> -> "stackRestore"
 - func[56] <stackAlloc> -> "stackAlloc"
 - func[57] <emscripten_stack_get_current> -> "emscripten_stack_get_current"
 - func[59] <dynCall_jiji> -> "dynCall_jiji"
Elem[1]:
 - segment[0] flags=0 table=0 count=5 - init i32=1
  - elem[1] = func[7]
  - elem[2] = func[6]
  - elem[3] = func[8]
  - elem[4] = func[34]
  - elem[5] = func[35]
Code[58]:
 - func[2] size=6 <__wasm_call_ctors>
 - func[3] size=73
 - func[4] size=11 <main>
 - func[5] size=41
 - func[6] size=355
 - func[7] size=4
 - func[8] size=4
 - func[9] size=370
 - func[10] size=4
 - func[11] size=2
 - func[12] size=2
 - func[13] size=2
 - func[14] size=12
 - func[15] size=8
 - func[16] size=92
 - func[17] size=10
 - func[18] size=229
 - func[19] size=22
 - func[20] size=6 <__errno_location>
 - func[21] size=142
 - func[22] size=526
 - func[23] size=204
 - func[24] size=363
 - func[25] size=2449
 - func[26] size=24
 - func[27] size=114
 - func[28] size=566
 - func[29] size=62
 - func[30] size=54
 - func[31] size=136
 - func[32] size=112
 - func[33] size=14
 - func[34] size=3203
 - func[35] size=45
 - func[36] size=5
 - func[37] size=21
 - func[38] size=4
 - func[39] size=4
 - func[40] size=6
 - func[41] size=22
 - func[42] size=288
 - func[43] size=20
 - func[44] size=83
 - func[45] size=83
 - func[46] size=482
 - func[47] size=6
 - func[48] size=4
 - func[49] size=18 <emscripten_stack_init>
 - func[50] size=7 <emscripten_stack_get_free>
 - func[51] size=4 <emscripten_stack_get_base>
 - func[52] size=4 <emscripten_stack_get_end>
 - func[53] size=314 <fflush>
 - func[54] size=4 <stackSave>
 - func[55] size=6 <stackRestore>
 - func[56] size=18 <stackAlloc>
 - func[57] size=4 <emscripten_stack_get_current>
 - func[58] size=13
 - func[59] size=35 <dynCall_jiji>
Data[2]:
 - segment[0] memory=0 size=560 - init i32=65536
  - 0010000: 2d2b 2020 2030 5830 7800 2d30 582b 3058  -+   0X0x.-0X+0X
  - 0010010: 2030 582d 3078 2b30 7820 3078 006e 616e   0X-0x+0x 0x.nan
  - 0010020: 0069 6e66 004e 414e 0049 4e46 002e 0028  .inf.NAN.INF...(
  - 0010030: 6e75 6c6c 2900 4865 6c6c 6f20 5765 6241  null).Hello WebA
  - 0010040: 7373 656d 626c 790a 0000 0000 0000 0000  ssembly.........
  - 0010050: 1900 0a00 1919 1900 0000 0005 0000 0000  ................
  - 0010060: 0000 0900 0000 000b 0000 0000 0000 0000  ................
  - 0010070: 1900 110a 1919 1903 0a07 0001 0009 0b18  ................
  - 0010080: 0000 0906 0b00 000b 0006 1900 0000 1919  ................
  - 0010090: 1900 0000 0000 0000 0000 0000 0000 0000  ................
  - 00100a0: 000e 0000 0000 0000 0000 1900 0a0d 1919  ................
  - 00100b0: 1900 0d00 0002 0009 0e00 0000 0900 0e00  ................
  - 00100c0: 000e 0000 0000 0000 0000 0000 0000 0000  ................
  - 00100d0: 0000 0000 0000 0000 0000 000c 0000 0000  ................
  - 00100e0: 0000 0000 0000 0013 0000 0000 1300 0000  ................
  - 00100f0: 0009 0c00 0000 0000 0c00 000c 0000 0000  ................
  - 0010100: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 0010110: 0000 0000 0010 0000 0000 0000 0000 0000  ................
  - 0010120: 000f 0000 0004 0f00 0000 0009 1000 0000  ................
  - 0010130: 0000 1000 0010 0000 0000 0000 0000 0000  ................
  - 0010140: 0000 0000 0000 0000 0000 0000 0000 0012  ................
  - 0010150: 0000 0000 0000 0000 0000 0011 0000 0000  ................
  - 0010160: 1100 0000 0009 1200 0000 0000 1200 0012  ................
  - 0010170: 0000 1a00 0000 1a1a 1a00 0000 0000 0000  ................
  - 0010180: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 0010190: 0000 1a00 0000 1a1a 1a00 0000 0000 0009  ................
  - 00101a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 00101b0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 00101c0: 0000 0014 0000 0000 0000 0000 0000 0017  ................
  - 00101d0: 0000 0000 1700 0000 0009 1400 0000 0000  ................
  - 00101e0: 1400 0014 0000 0000 0000 0000 0000 0000  ................
  - 00101f0: 0000 0000 0000 0000 0000 0000 0016 0000  ................
  - 0010200: 0000 0000 0000 0000 0015 0000 0000 1500  ................
  - 0010210: 0000 0009 1600 0000 0000 1600 0016 0000  ................
  - 0010220: 3031 3233 3435 3637 3839 4142 4344 4546  0123456789ABCDEF
 - segment[1] memory=0 size=148 - init i32=66096
  - 0010230: 0500 0000 0000 0000 0000 0000 0100 0000  ................
  - 0010240: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 0010250: 0000 0000 0200 0000 0300 0000 d802 0100  ................
  - 0010260: 0004 0000 0000 0000 0000 0000 0100 0000  ................
  - 0010270: 0000 0000 0000 0000 0000 0000 ffff ffff  ................
  - 0010280: 0a00 0000 0000 0000 0000 0000 0000 0000  ................
  - 0010290: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 00102a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 00102b0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  - 00102c0: 3002 0100                                0...
  ```

Im Vergleich zu meinen anderen Artikel ist die WebAssembly Datei nun einiges grösser geworden. Jedoch ist es interessant einige Abschnitte zu beleuchten. Im `Export` ist eine `main` Funktion zu finden, welche wie gewohnt von C/C++, als Einstiegspunkt verwendet wird. Im `func[4]` Array befindet sich diese Funktion an der Position 4. Wenn nun der Ablauf des Scripts analysiert werden möchte, kann diese Funktion als Startpunkt verwendet und ins WAT Format gewechselt werden.

Übersetzen von WebAssembly zu WAT: `wasm2wat hello_webassembly.wasm -o hello_webassembly.wat`. 

```wat
...
(func (;4;) (type 5) (param i32 i32) (result i32)
  (local i32)
  call 3
  local.set 2
  local.get 2
  return)
...
```

Hier wird nun nicht weiter auf die Details eingegangen. Jedoch ist es eindrücklich, wie die gesamte Funktionalität in Stackautomaten Instruktionen aussieht. Mehr Details dazu kann auch in meinen älteren Aritkel gefunden werden.

Auf der anderen Seite beim `Import` finden man die Funktion `wasi_snapshot_preview1.fd_write`, welche vom Gästesystem zur Verfügung gestellt werden muss. 

Auszug aus dem `hello_webassembly.js`:

```js
...
  var _fd_write = (fd, iov, iovcnt, pnum) => {
      // hack to support printf in SYSCALLS_REQUIRE_FILESYSTEM=0
      var num = 0;
      for (var i = 0; i < iovcnt; i++) {
        var ptr = HEAPU32[((iov)>>2)];
        var len = HEAPU32[(((iov)+(4))>>2)];
        iov += 8;
        for (var j = 0; j < len; j++) {
          printChar(fd, HEAPU8[ptr+j]);
        }
        num += len;
      }
      HEAPU32[((pnum)>>2)] = num;
      return 0;
    };
...
```

Wie bereits in meinem letzten [Artikel](https://medium.com/webassembly/hello-world-c-program-4b85d3f8fbea) beschrieben, wird so mit der Aussenwelt kommuniziert und dient dies als Schnittstelle. 

Es soll darauf hingewiesen sein, dass es sich um eine Abstraktion (Sandbox) handelt. Die Funktion `printf` vom C Programm wird nicht auf dem Betriebssystem im klassischen Sinn aufgerufen. Sondern es wird die vom JavaScript bereitgestellte und vom WebAssembly importierte `_fd_write` Funktion aufgerufen, welche dann die jeweilige Implementierung der `printf` Funktion zur Verfügung stellt.

In Ecmascript ist dies abhängig vom jeweils aufrufenden Interpreter des JavaScripts. Die `printChar` Funktion von der `_fd_write` Funktion beruht am Ende auf folgender Deklaration für den Output `var out = Module['print'] || console.log.bind(console);`. 
Hier sieht man zudem, dass die Schnittstelle (*Runtime, Sandbox) zum WebAssembly in der JavaScript Datei über eine globale Variable `Module` abstrahiert beziehungsweise zur Verfügung gestellt wird. Dieses `Module` dient als Schnittstelle zwischen WebAssembly und dem Rest des JavaScript Programmes. 

Darüber könnte nun zum Beispiel die `print` Funktion durch eine andere Funktion ersetzt werden. Was zur Folge hätte, dass diese Aufgerufen wird anstelle der Fallback Version mit `console.log`.

> \* Persönlichen Meinung: Bei der JavaScript-Datei, beziehungsweise der `Module` Variable, handelt es sich um eine Schnittstelle oder Abstraktion. Eine einheitliche Schnittstelle von der JavaScript Umgebung (interagiert mit der `Module` Variable) zur `WebAssembly` API (die eigentliche Runtime), dem Sandboxing (Import/Export in der WebAssembly Datei) und eventuell genutzten Erweiterungen (siehe nächster Artikel). Diese Datei beziehungsweise Variable wird jedoch oft auch als Runtime oder Sandbox bezeichnet. In meinen Augen sind diese Begriffe nicht optimal gewählt. Bei Ecmascript kommt dies vermutlich von Altlasten der asm.js Zeiten, als es wirklich noch eine Runtime war.

### Erweiterung
Ecmascript bietet unterschiedliche Optionen beim Kompilieren an. Welche man zum Beispiel ausnützen kann um die `main` Funktion über einen Button aufrufen zu können.
* [Dokumentation](https://emscripten.org/docs/tools_reference/emcc.html#emccdoc)
* [Darunter liegendes settings.js](https://github.com/emscripten-core/emscripten/blob/main/src/settings.js)

Als Beispiel könnte man den direkt startenden Aufruf der `main` Funktion unterbinden (`INVOKE_RUN=0`) und diese Methode als `_main` Funktion vom `Module` zur Verfügung stellen lassen (`EXPORTED_FUNCTIONS=_main`).

Kompilieren: `emcc hello_webassembly.c -s INVOKE_RUN=0 -s EXPORTED_FUNCTIONS=_main -o hello_webassembly_extended.js`

> Mit der Option `EXPORTED_FUNCTIONS` können so kommagetrennt auch weitere Funktionen vom WebAssembly direkt exportiert werden. Per Definition muss ein Unterstrich dem Funktionsname vorgestellt werden, damit die `Module` interne Namensgebung korrekt zur WebAssembly Funktion gelinkt werden kann. Zudem wäre in diesem Spezialfall die `main` Funktion bereits als default impliziet in der Liste vorhanden. Also könnte man den Befehl auch kürzen auf `emcc hello_webassembly.c -s INVOKE_RUN=0 -o hello_webassembly_extended.js`


> Die Option `EXPORTED_RUNTIME_METHODS`, dient einem anderen Zweck und sollte nicht mit der `EXPORTED_FUNCTIONS` Option verwechselt werden. Die `EXPORTED_RUNTIME_METHODS` Option dient um Methoden von der JavaScript Schnittstelle (*Runtime, Sandbox), also dem `Module` selbst (nicht dem WebAssembly), zu exportieren. Als Beispiel die [ccall Funktion](https://emscripten.org/docs/api_reference/preamble.js.html#calling-compiled-c-functions-from-javascript): `emcc hello_webassembly.c -s INVOKE_RUN=0 -s EXPORTED_RUNTIME_METHODS=ccall -o hello_webassembly_extended.js`, welche dazu dient um kompilierte C Funktionen indirekt aufrufen zu können `Module.ccall("main", "number", [], []);` (siehe den Kommentar in der folgenden HTML Datei)

> Es ist zudem zu empfehlen bei Herausforderungen oder Fragen das [FAQ](https://emscripten.org/docs/getting_started/FAQ.html) von Emscripten zu konsultieren.

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Emscripten Easy Portability, C/C++ -> WebAssembly</title>
</head>

<body>
    <h1>Emscripten Easy Portability, C/C++ -> WebAssembly</h1>
    <h2>WebAssembly Extended Version</h2>
    <button id="call-main-button">Call Main</button>
    <script src="hello_webassembly_extended.js"></script>
    <script>
        const callMainButton = document.getElementById("call-main-button");
        callMainButton.addEventListener("click", function () {
            // Module.ccall("main", "number", [], []); // When you used EXPORTED_RUNTIME_METHODS=ccall you can call the main function it like this
            Module._main();
        });
    </script>
</body>

</html>
```

Anwendung starten `python3 -m http.server`.

Analysieren im Browser `http://localhost:8000/index_extended.html`.

![WebAssembly Extended Version](extended_version.png)

![Console Log after 8 Clicks](console_log_after_click.png)

## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_simple_portability)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_simple_portability/README.md)

Ich bin gerne bereit den Artikel noch zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, September 2023](https://marcokuoni.ch)