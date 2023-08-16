# WebAssebmly Module
WebAssembly-Programme sind in Module organisiert, die die Einheit zum Veröffentlichen, Laden und Kompilierung darstellen. Ein Modul sammelt Definitionen für Typen, Funktionen, Tabellen, Speicher und globale Variablen. Darüber hinaus kann es Importe und Exporte deklarieren und Initialisierung in Form von Daten- und Elementsegmenten oder einer Startfunktion bereitstellen.

Aufbau des Beitrags:
1. Theorie 
2. Analyse
3. Praxis

## Theorie: Modul Struktur
* [WebAssembly Module Sections](https://webassembly.github.io/spec/core/binary/modules.html)

Dateiformate werden oft mit einer sogenannten «magic number» identifiziert. Bei WebAssembly ist dies die Zahl 0x6d736100 («\0asm» in ASCII) gefolgt von der Versionnummer 0x00000001.
Auf die Identifikation folgen die verschiedenen Modul Abschnitte (Sections). Jeder Abschnitt beginnt mit einem Byte, welches den Abschnittstypen definiert. Danach folgt die Länge des Abschnitts in Bytes als [Leb128](https://en.wikipedia.org/wiki/LEB128) kodiert und der Inhalt des Abschnitts.

ID | Name | Description
---|------|------------
0 | Custom | Benutzdefinierter Bereich definiert Debugging oder Metadaten zur Verwendung von Dritten
1 | Type | Definiert alle Funktionstypen im Modul
2 | Import | Importiert Funktionen, globale Variablen, Tabellen und Speicher in das Modul
3 | Function | Definiert alle Funktionssignaturen im Modul (Referenziert dazu andere Abschnitte)
4 | Table | Definiert alle [Tabellen](https://webassembly.github.io/spec/core/syntax/modules.html#tables) im Modul (Vektor von indirekten, schreibgeschützten Referenzen). Initialisiert durch den Element-Abschnitt
5 | Memory | Definiert allen [Speicher](https://webassembly.github.io/spec/core/syntax/modules.html#memories) im Modul (Vektor von linearem Speicher). Initialisiert durch den Data-Abschnitt
6 | Global | Definiert alle [Globalen](https://webassembly.github.io/spec/core/syntax/modules.html#globals) im Modul (Vektor von globalen Variablen)
7 | Export | Exportiert Funktionen, globale Variablen, Tabellen und Speicher vom Modul
8 | Start | Eine optionale Startfunktion vom Modul. Wird bei initialisierung des Moduls ausgeführt, sobald die Tabellen und der Speicher initialisiert sind. Das Modul selbst und seine Exports sind erst nach dieser Ausführung von Aussen nutzbar.
9 | Element | Definiert die [Elemente](https://webassembly.github.io/spec/core/syntax/modules.html#syntax-elem) im Modul. Tabellen sind standardmässig nicht initialisiert, Teilbereiche von Tabellen können durch Vektoren an statischen Elementen initialisiert werden
10 | Code | Definiert die Funktionen (Body/Code) im Modul
11 | Data | Definiert die [Daten](https://webassembly.github.io/spec/core/syntax/modules.html#syntax-data) im Modul. Der Speicher wird standardmässig mit 0x00 initialisiert, Teilbereiche vom Speicher können durch Vektoren an statischen Bytes initialisiert werden.
12 | Data Count | Anzahl an Daten im Modul (Optional)

## Analyse
Beispiel eines WebAssembly Moduls:
```wat
(module
  (func $alert (import "imports" "alert_func") (param i32))

  (func $multiply (param $a i32) (param $b i32) (result i32)
    local.get $a
    local.get $b
    i32.mul
  )

  (func $alert_multiply (param $a i32) (param $b i32)
    local.get $a
    local.get $b
    call $multiply
    call $alert
  )

  (export "multiply" (func $multiply))
  (export "alert_multiply" (func $alert_multiply))
)
```

Dies wird übersetzt in WASM inklusive den Debugging Informationen `wat2wasm multiply.wat -o multiply.wasm --debug-names`. Das Resultat kann nun per `wasm-objdump -x multiply.wasm` analysiert werden. Alternativ dazu gibt es die Möglichkeit das Modul in einem [WebAssembly Code Explorer](https://wasdk.github.io/wasmcodeexplorer/) zu analysieren.

TODO Bild

TODO Dump
