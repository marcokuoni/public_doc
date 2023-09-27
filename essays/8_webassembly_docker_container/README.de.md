# WebAssembly Docker Container

## Warum?
Das berühmte Zitat von einem der Erfinder von Docker, Solomon Hykes: «If WASM+WASI existed in 2008, we wouldn’t have needed to created Docker» - «Wenn WASM+WASI 2008 existiert hätte, hätten wir Docker nicht erfinden müssen».

![Solomon Hykes Twitter Post about WASM](hykes-wasm-1.jpeg)

Es gibt noch eine fortsetzung des Tweets in dem Solomon davon Spricht, dass Docker davon nicht verschwinden wird. Vielmehr werden Windows, Linux und WebAssembly Container zusammen und nebeneinander auf Docker laufen.

![Containers Compared](ContainersCompared.png)
Bild von [kodekloud](https://kodekloud.com/blog/webassembly-vs-docker/)

Klassische Docker-Container beziehungsweise deren Inhalt sind für für eine bestimmte Zielarchitekur (arm, x86, usw.) kompiliert und beinhalten verschiedene Betriebssystemkomponenten. Wenn nun eine WebAssembly-Runtime zur Verfügung gestellt wird, können diese Punkte an die Runtime abgeben werden. Als Resultat erhält man einen Container, mit folgenden zusätzlichen Vorteilen:
* Beinhaltet nur Applikationscode was zu kleineren (Speicher) und sicheren (Angriffsfläche) Containern mit schnelleren Startzeiten führt.
* Kompatibilität über verschiedene Architekturen und Betriebsystemen hinweg.

Inklusiven den bekannten Vorteilen von WebAssembly
* Sicherheit: WebAssembly Programme laufen in einer Sandbox. Es ist nicht einfach so möglich auf das Gästesystem oder andere Container zuzugreifen.
* Performance: WebAssembly kommt kompiliert als Maschinen-Code daher.
* Und Weiteren, siehe in meinem letzten [Artikel](https://medium.com/webassembly/emscripten-simple-portability-9d3238d99294)

| Aspekt                        | Klassiche                            | WebAssembly Container                                                                             |
| ----------------------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------- |
| Grösse                        | 10 bis 100 Fache an MB               | Einige MB                                                                                         |
| Startzeiten                   | Sekunden                             | [Millisekunden](https://www.docker.com/blog/why-containers-and-webassembly-work-well-together/)   |
| Performance Geschwindigkeit   | Weit Weg von Native                  | Nahe an Native                                                                                    |
| Läuft in Webbrowser           | Nein                                 | Ja                                                                                                |
| Cross Platform / Portabilität | Nein                                 | Ja                                                                                                |
| Standards                     | [OCI](https://opencontainers.org/)   | [W3C](https://www.w3.org/community/webassembly/) und OCI                                          |
| System Interaktionen          | Beinhaltet Betriebs- und Dateisystem | Benutzt [WASI](https://wasi.dev/) um aufs Gästesystem zuzugreifen |

Zusammengefasst erhalten wir mit Docker + WebAssembly
* Gebüdelten Code (Package)
* Fast Native Performance
* Hohe Sicherheit
* Hohe Portabilität
* Runtime Isolation
* Schnelle Startzeit

## Wie?
![Docker Wasm](DockerWasmContainer.png)
Bild von [kodekloud](https://kodekloud.com/blog/webassembly-vs-docker/)





How?
containerd
In the simplest terms, containerd is a broadly-adopted open container runtime. It manages the complete container lifecycle of its host system! This includes pulling and pushing images as well as handling the starting and stopping of containers. Not to mention, containerd is a low-level brick in the container experience. Rather than being used directly by developers, it’s designed to be embedded into systems like Docker and Kubernetes.


    runc
    Lowest-level 🔩 The low-level container runtime. runc is a low-level container runtime. It uses the native features of Linux to create and run containers. It follows the OCI standard, and it includes libcontainer, a Go library for creating containers.
    runc provides all of the low-level functionality for containers, interacting with existing low-level Linux features, like namespaces and control groups. It uses these features to create and run container processes.
    alternativen:
        * crun https://github.com/containers/crun
        * firecracker https://github.com/firecracker-microvm/firecracker-containerd
        * gVisor https://gvisor.dev/

wasmedge

alternativen:   
* wasmtime


* Containerd Runtime OCI-compatible (Standartisierte container schnittstelle: https://opencontainers.org/). containerd-shim können zusammen mit containerd-wasi-shim benutzt werden. Diese dienen als Schnittstelle zwischen Containerd und den Runtimes. runc für Linux und wasmedge (*) für wasm

Not Beta but enable
* only docker desktop, not desktop (https://docs.docker.com/engine/alternative-runtimes/#wasmtime)
* its beta
* Known Issues: https://docs.docker.com/desktop/wasm/#known-issues  

Build

Run

compose


What if this manifest file contained a list of manifests, so that the Docker Engine could pick the one that it matches at runtime? That’s exactly how the manifest is built for a multi-arch image. This type of manifest is called a manifest list.    



What is the expected contents of a docker image? An application + all supporting libraries and any other required files.
What does that normally mean in practice? Basically a trimmed down Linux userland + the application.

Of course not every single file is architecture specific, but the binaries and libraries were compiled for some specific architecture (this is obviously the case whether they were placed in a docker image or not).





WasmEdge implements the WASI standard that gives you access to the outside world. There is still active work happening on this specification. You can follow Wasm spec work more broadly as it happens under the Bytecode Alliance.

--platform=wasi/wasm32 – This specifies the architecture of the image we want to use. By leveraging a Wasm architecture, we don’t need to build separate images for the different architectures. The Wasm runtime will do the final step of converting the Wasm binary to machine instructions.

We see Wasm as a complementary technology to Linux containers where developers can choose which technology they use (or both!) depending on the use case. And as the community explores what’s possible with Wasm, we want to help make Wasm applications easier to develop, build, and run using the experience and tools you know and love.

It is essential to create a Docker image that matches the correct system architecture such as Intel, ARM 0r AMD. For example, if you are running Raspberry Pi OS with Docker, you must create a Docker image for your C program based on a Linux image and compile it for ARM processor architecture. otherwise, the container will not run correctly.

https://www.docker.com/blog/build-share-run-webassembly-apps-docker/
Structure Image: https://www.docker.com/blog/why-containers-and-webassembly-work-well-together/
https://www.docker.com/blog/docker-wasm-technical-preview/
Pros: https://medium.com/@guglielmino/docker-webassembly-a-quick-intro-730c38e8390c
https://kodekloud.com/blog/webassembly-vs-docker/
Runtimes: https://docs.docker.com/desktop/wasm/
https://www.docker.com/blog/docker-wasm-technical-preview/?ref=kodekloud.com
The containerd shim for WasmEdge: https://github.com/second-state/runwasi
Roadmap: https://github.com/docker/roadmap/issues/426

php https://wasmlabs.dev/articles/docker-without-containers/

## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_simple_portability)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_simple_portability/README.md)

Ich bin gerne bereit den Artikel noch zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, September 2023](https://marcokuoni.ch)