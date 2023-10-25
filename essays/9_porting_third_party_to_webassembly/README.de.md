# Porting Third Party to WebAssembly
Die Idee dieses Artikels ist, dass wir eine komplexere Applikation (wie sie in einer C++ Bibliothek bestehen könnte) nehmen und diese in WebAssembly portieren. Dabei werden wir diese zuerst in einem normalen C++ Programm testen und dann in WebAssembly. Wir werden dabei auf die Probleme eingehen, die wir dabei antreffen und wie wir diese lösen können.

## Bitmap Applikation
Die Applikation benutzt die `bitmap_image.hpp` von [Arash Partow](http://partow.net/programming/bitmap/index.html), welche dazu verwendet wird um verschiedene Bitmaps zu erzeugen.

```cpp
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>

#include "bitmap_image.hpp"

void cartesian()
{
    ...
}

void fractal()
{
    ...
}

int main(int argc, char **argv)
{
   int choosen = 0;
   if(argc > 1)
   {
      choosen = std::atoi(argv[1]);
   }

   switch(choosen) {
      case 1:
         cartesian();
         break;
      case 2:
         fractal();
         break;
      default:
         printf("Usage: %s [1|2]\n", argv[0]);
         break;
   }
   
   return 0;
}

```

Bevor dies nun aber gemacht werden kann muss das Programm zuerst kompiliert werden. Dazu ist bereits ein Makefile vorhanden.

```Makefile
COMPILER      = -c++
OPTIONS       = -ansi -pedantic-errors -Wall -Wall -Werror -Wextra -o
LINKER_OPT    = -L/usr/lib -lstdc++ -lm

all: bitmap

bitmap: bitmap.cpp bitmap_image.hpp
	$(COMPILER) $(OPTIONS) bitmap bitmap.cpp $(LINKER_OPT)

valgrind_check:
	valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./bitmap

clean:
	rm -f core *.o *.bak *stackdump *~
```

Welches über `make` ausgeführt werden kann. Nun wird eine Datei `bitmap` erstellt, welche ausgeführt werden kann.

```bash
./bitmap 1
./bitmap 2
```

---
emscripten nicht installiert, lese auch meinen anderen Artikel oder folge der Anweisung
https://emscripten.org/docs/getting_started/downloads.html oder unter Ubuntu `sudo apt intall emscripten`

----


sudo apt install libsfml-dev

## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/9_porting_third_party_to_webassembly)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/9_porting_third_party_to_webassembly/README.md)

* https://www.levelupwasm.com/

Ich bin gerne bereit den Artikel zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, Oktober 2023](https://marcokuoni.ch)