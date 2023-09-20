# Emscripten einfache Portabilität, C/C++ -> WebAssembly
Warum macht eine einfache Portabilität von C/C++ Code zu WebAssembly Sinn? Es gibt diverse Gründe, einige sind hier kurz aufgezählt:
* Es gibt bereits grosse Bibliotheken an bestehenden C/C++ Codes.
* Es gibt Problemstellungen welche in JavaScript nicht optimal gelöst werden können.
* Es benötigt keine seperate Runtime, sondern wird bereits kompeliert ausgeliefert. Dies sparrt Speicher beim Transport vom Server zum Client aber auch Performance für die Interpretation und Kompilierung auf dem Client.
* Es können verschiedene Sprachen gemischt eingesetzt werden.
* Es kann Vertrauenswürdiger Code von Vertrauenwürdigen Quellen verwendet werden. Ein gutes Beispiel ist hier [libsodium](https://doc.libsodium.org), welches die [Networking and Cryptography (NaCl)](https://nacl.cr.yp.to/) Bilbliothek direkt von der Quelle zu WebAssembly bringt.

[Emscripten](https://emscripten.org) legt hier das Fundament um diese Portabilität möglichst einfach zu ermöglichen. Emscripten hat schon lange bestand und wird durch die beiden Hauptbeteiligten [Alon Zakai](https://kripken.github.io/blog/about/) und [Luke Wagner](https://github.com/lukewagner) entwickelt. Welche auch schon bei asm.js und dann bei WebAssembly bis Heute mitwirken. Das Projekt baut auch auf der LLVM Platform auf, wobei das Backend einfach von asm.js Kompiler zu einem WebAssembly Kompiler gewechselt wurde.
Eine solche Portabilität ist nicht ganz einfach umzusetzen. Alleine der Fakt, dass ein Browser im normalfall ein Single-Threaded Environment ist, macht es nicht einfach. Zudem gibt es auch diverse Schnittstellen mit der Ausswenwelt, welche es anzubinden gilt. Die Emscripten Toolchain bietet hierzu viele nützliche Hilfestellungen um nativen C/C++ Code einfach in eine Webanwendung zu portieren.

---

Ist dies alles Neuland oder besteht das Verlagen die Details einer Portierung zu kennen, dann empfehle ich meine älteren Beiträge zu konsultieren:
* [Ein einfaches C Programm in WebAssembly](https://medium.com/webassembly/simple-c-program-in-webassembly-1a7b148293c2) wie ein einfaches C-Programm als WebAssembly kompiliert und in einer Webanwendung verwendet werden kann.
* ["Hello World" C++ Programm](https://medium.com/webassembly/hello-world-c-program-4b85d3f8fbea) Ist ein einfaches C++-Programm, aber wie implementiert man es so, dass es in einer Webanwendung als WebAssembly verwendet werden kann?

---



## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_easy_portability)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_easy_portability/README.md)

Ich bin gerne bereit den Beitrag noch zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, September 2023](https://marcokuoni.ch)