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

Nachfolgend werden die einzelnen Schichten kurz erklärt. Dank der breiten Akzeptantz der Standardisierungen rund um Container über [Open Container Initiative](https://opencontainers.org/) und der [Container Runtime containerd](https://containerd.io/) können verschiedene Anwendungen einfach auf diversen Plattformen ausgeführt werden. Standartisierte Schnittstellen für containerd ermöglichen diesen auf Docker, Kubernetes oder weiteren Plattformen auszuführen. Auf der anderen Seite von containerd ermöglichen die Standartisierten Schnittstellen für die Container einfach Applikationen darin zu implementieren und auszuführen.

### Container Engine 
Dient als Schnittstelle zwischen dem Benutzer und dem Container Manager und bietet weitere higher Level plattformspezifische Funktionalitäten.

Bekannte Container Engines sind Docker, Kubernetes, Podman, CRI-O, usw.

### Container Manager
Umfasst das Verwalten von Images (Upload, Download) und Verwalten von Containern (Erstellen, Starten, Stoppen, usw.). Im Grunde alles, was man braucht, um eine Container-Plattform aufzubauen, ohne sich mit den Details des zugrunde liegenden Betriebssystems befassen zu müssen. 

Bekanntester Container Manager ist containerd unterstützt durch [Cloud Native Computing Foundation](https://www.cncf.io/). Containerd ist ein Open-Source Container Manager (ursprünglich Docker), der weit verbreitet und in Go programmiert ist. Anstatt direkt von Entwicklern verwendet zu werden, ist es so konzipiert, dass es in Systeme wie Docker und Kubernetes eingebettet werden kann.

#### Shim
Ein Shim ist eine Software, die zwischen einem Container Manager (containerd, cri-o, podman, usw.) und einer Container Runtime (runc, crun, wasmedge, usw.) angesiedelt ist und das Integrationsproblem (als Schnittstelle) dieser Gegenstücke löst.

Bekanntester Shim ist containerd-shim. Er wird verwendet, um den Container zu starten und zu überwachen. Es ist ein Prozess, der vom containerd-Daemon gestartet wird und die Verantwortung für die Verwaltung des Lebenszyklus des Containers selbst übernimmt. 

### Runtime
Umfasst das Verwalten von Containerprozessen (Erstellen, Starten, Stoppen, usw.) und stellt dazu die Low-Level-Funktionalität bereit.
[Runc](https://github.com/opencontainers/runc) als Beispiel einer Runtime für Linux interagiert mit bestehenden Low-Level-Linux-Funktionen, wie Namespaces und Control Groups. Dabei folgt er dem [OCI-Standard](https://opencontainers.org/) und enthält libcontainer, eine Go-Bibliothek zur Erstellung von Containern.
Alternativen:
  * [crun](https://github.com/containers/crun) für Linux
  * [gVisor](https://gvisor.dev/) für Linux
  * [firecracker](https://github.com/firecracker-microvm/firecracker-containerd) für microVMs
  * [wasmedge](https://wasmedge.org/) für WebAssembly (Docker Unterstützt von [Cloud Native Computing Foundation](https://www.cncf.io/))
  * [slight](https://github.com/deislabs/spiderlightning) für WebAssembly (Docker Unterstützt)
  * [spin](https://github.com/fermyon/spin) für WebAssembly (Docker Unterstützt)
  * [wasmtime](https://wasmtime.dev/) für WebAssembly (Docker Unterstützt von [Bytecode Alliance](https://bytecodealliance.org/))

#### WebAssemlby
Weil die bestehenden Shim-Implementierungen auf artefakte von Betriebssystemen beruht, können diese nicht im gleichen Sinn direkt für WebAssembly Runtimes verwendet werden. Deshalb kommen WebAssembly Runtimes mit eigenen Shims daher.
Für wasmedge, wasmtime und wasmer gibt es hierzu [runwasi](https://github.com/containerd/runwasi). Die Idee dabei ist, die Shim Schnittstelle zu erweitern und anzupassen um die jeweilige WebAssembly Runtimes zu untertützen beziehungsweise zu implementieren. Runwasi implementiert dabei zwei Modis:
* Normal: Ein Shim Prozess pro Container
* Shared: Ein Manager Service (Container) verwaltet alle Shims im Prozess

## Build mit Docker
Zwei Bemerkungen im Vorfeld:
* Mit Docker Desktop lässt sich auf einfache Art auf verschiedenen Betriebssystemen ein WebAssembly Image builden und als Container starten. Jedoch kann dies auch mit einer standard Docker Installation umgesetzt werden. Weiter Infos unter [alternative Runtimes](https://docs.docker.com/engine/alternative-runtimes/#wasmtime)
* Weil die Docker Implementerung noch eher neu ist, gibt es immer einmal Probleme. Eine Liste von bekannten Herausforderungen findet sich unter [Known Issues](https://docs.docker.com/desktop/wasm/#known-issues) und zudem einen [Issue Tracker](https://github.com/docker/roadmap/issues/426)

Als erstens muss [Docker Desktop](https://www.docker.com/products/docker-desktop) heruntergeladen werden. Dieser wird unter Ubuntu wie folgt installiert: 
```bash
sudo chmod +x ./docker-desktop-4.24.0-amd64.deb
sudo apt install ./docker-desktop-4.24.0-amd64.deb
```
Hier gilt es zu beachten, dass die aktuellste Docker Version verwendet wird > 4.24.0

Nach der Installation muss noch die Wasm Runtimes aktiviert werden. Dies kann unter Settings -> `Features in development`: `Use containerd for pulling and storing images` und `Enable Wasm` aktiviert werden.
![Enable WebAssembly in Docker Desktop](enable_wasm.png)

---

Gemäss Dokumentation, müsste der Build bereits funktionieren. Jedoch war dies bei mir nicht der Fall. Meine installierten Builder hatten keine unterstützung für die WASM/WASI Platform.
```bash
$ docker buildx ls
NAME/NODE       DRIVER/ENDPOINT STATUS  BUILDKIT             PLATFORMS
default         docker                                       
  default       default         running v0.11.6+616c3f613b54 linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/386
desktop-linux * docker                                       
  desktop-linux desktop-linux   running v0.12.2              linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/mips64le, linux/mips64
```

Daher habe ich mit folgendem Befehl einen neuen Builder erstellt: 
```bash
docker buildx create --name wasm-builder --platform wasi/wasm
docker buildx use wasm-builder
```

```bash
$ docker buildx ls
NAME/NODE       DRIVER/ENDPOINT  STATUS   BUILDKIT             PLATFORMS
wasm-builder *  docker-container                               
  wasm-builder0 desktop-linux    inactive                      wasi/wasm*
default         docker                                         
  default       default          running  v0.11.6+616c3f613b54 linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/386
desktop-linux   docker                                         
  desktop-linux desktop-linux    running  v0.12.2              linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/mips64le, linux/mips64
```

---

Wir benutzen als Demostration ein einfaches Rust Programm

```rust
fn main() {
  let s : &str = "Hello WebAssembly in Docker!";
  println!("{}", s);
}

```

Dies zusammen mit folgendem `Cargo.toml`:

```toml
[package]
name = "hello"
version = "0.1.0"
authors = ["Marco Kuoni"]
edition = "2021"

[[bin]]
name = "hello"
path = "src/main.rs"

[dependencies]
```

Und folgendem `Dockerfile`:

```dockerfile
# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM rust:1.64 AS buildbase
WORKDIR /src
RUN <<EOT bash
    set -ex
    apt-get update
    apt-get install -y \
        git \
        clang
    rustup target add wasm32-wasi
EOT

FROM buildbase AS build
COPY Cargo.toml .
COPY src ./src 
# Build the Wasm binary
RUN cargo build --target wasm32-wasi --release

FROM scratch
ENTRYPOINT [ "/hello.wasm" ]
COPY --link --from=build /src/target/wasm32-wasi/release/hello.wasm /hello.wasm
```

Bis auf die letzen drei Zeilen, werden die Befehle nur dazu verwendet um das Rust Programm im Docker Container zu WebAssembly zu kompilieren. Die letzen drei Zeilen sind für das WebAssembly Image verantwortlich. Wir kopieren das kompilierte Programm in den Container und definieren den Entrypoint.

Dies starten wir nun mit folgendem Befehl: `docker buildx build --load --platform wasi/wasm -t demo/hello_webassembly .`.

----

Ich musste unter `Features in development` für die `Builds View` ausschalten, damit das Image erschien.
![Builds view](builds_view.png)

----

![WebAssembly Image](image.png)

Damit wurde nun ein Image für die Platform WASM erstellt mit einer Grösse von 2.52 MB.

## Run mit Docker
Nun kann das Image mit folgendem Befehl gestartet werden:
```bash
$ docker run --rm --runtime=io.containerd.wasmedge.v1 --platform=wasi/wasm demo/rust_hello
Hello WebAssembly in Docker!
```

## Compose mit Docker
WebAssembly Container können nun auch zusammen mit anderen Container wie gewohnt mit Docker Compose werwendet werden und im Verbund agieren.

```
services:
  server:
    image: demo/rust_hello_compose
    build:
      context: .
    runtime: io.containerd.wasmedge.v1
```

Und dann über `docker compose up` gestartet werden.

![WebAssembly with Docker Compose](docker_compose.png)

## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_simple_portability)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/7_emscripten_simple_portability/README.md)

Als Grundlage für diesen Artikel dienten diverse Quellen. Eine Liste der Quellen findet sich hier wo man auch noch weiter Handson Beispiele findet:
* [Docker Blog: Build, Share, and Run WebAssembly Apps Using Docker](https://www.docker.com/blog/build-share-run-webassembly-apps-docker/)
* [Docker Blog: Why Containers and WebAssembly Work Well Together](https://www.docker.com/blog/why-containers-and-webassembly-work-well-together/)
* [Docker Blog: Introducing the Docker+Wasm Technical Preview](https://www.docker.com/blog/introducing-the-dockerwasm-technical-preview/)
* [Docker Desktop Dokumentation: Wasm](https://docs.docker.com/desktop/wasm/)
* [Docker Dokumentation: Alternative Runtimes](https://docs.docker.com/engine/alternative-runtimes/#wasmtime)
* [Medium: Docker + WebAssembly: a quick intro](https://medium.com/@guglielmino/docker-webassembly-a-quick-intro-730c38e8390c)
* [KodeKloud: WebAssembly vs Docker: Exploring their Connection and Potential](https://kodekloud.com/blog/webassembly-vs-docker/)
* [GitHub: Runwasi](https://github.com/second-state/runwasi)
* [GitHub: Issues - Docker+Wasm Integration](https://github.com/docker/roadmap/issues/426)
* [Wasm Labs: WebAssembly - Docker without containers!](https://wasmlabs.dev/articles/docker-without-containers/)

Ich bin gerne bereit den Artikel noch zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, September 2023](https://marcokuoni.ch)