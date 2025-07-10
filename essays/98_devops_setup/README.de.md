---
title: 'Web-DevOps Setup'
subtitle: 'Wie sieht das ideale Web-DevOps Setup aus'
author: Marco Kuoni
date: 2024-09-29T00:00:00+0100
keywords: [WebAssembly,wasi,javascript,Webdev,Webdeveloper,web,html,browser,webapp,webapplication,webapplications,programming,coding,software,technology]
lang: de-CH
abstract: |
  Wie sieht das ideale Web-DevOps Setup aus.
email: mail@marcokuoni.ch
reference-section-title: Weiterführend
---

# Das ideale Web-DevOps Setup
Im letzten Jahr habe ich einen starken Wandel bemerkt und unterschiedliche Technologien getestet, was mich zu einem Umdecken in der Art wie ich arbeite bewegt.
Bis anhin habe ich immer grossen Wert darauf gelegt, ein einfaches und jeder Zeit verfügbares Setup zu haben. Während dem mein Umfeld laufend den Trends nach sprang und neues ausprobierte, legte ich Wert auf Erfahrung und Know-How um meine Geschwindigkeiten im Development zu erhalten. Dabei habe ich ungefähr folgende Software eingesetzt:
- Programmierung
  - Visual Studio Code (Codium)
  - Git
  - Docker
- Büro
  - NextCloud
  - Libre Office
  - Evolution
  - Slack
- Grafik
  - Gimp
  - Inkscape
- Browser
  - Firefox
  - Brave
  - Chrome
- Terminal
  - Alacritty
  - ZSH

Das ganze instaliert auf einer externen Festplatte mit ZFS und Ubuntu (Gnome Wayland) als Betriebssystem. Durch das war ich möglichst Hardware unabhängign und konnte immer und jeder Zeit gleich an meinen Projekten weiter arbeiten.
Ich werde nun kurz meine Überlegungen für mein neues Setup ausführen und danach in folge Beiträge Schritt für Schritt meine Erfahrungen und Dokumentationen präsentieren. Dabei bin ich offen für Inpus, Erfahrungen, Korrekturen und einen transparenten Austausch und würde mich über Kommentare freuen.

Ich bin ein grosser Freund von Unabhängigkeiten, Durchgängigkeit und Sicherheit. Ich möchte meine Umgebung schnell und einfach Einsatzbereit haben und dabei möglichst Hardware unabhängig sein. Ein zentraler Punkt ist daher, ein NixOS auf einer verschlüsselten externen Festplatte. Zudem setze ich auf ein gutes Management der Konfigurationen, des Speichers und des Sicherheitskonzept. Ich erhoffe mir ein schnelleres Arbeiten durch den Einsatz von Sway Desktopmanager und durchgängige Vim-Bedienung. Trotz steiler Lernkurve bewirkt dies eine schnelle Bedienung rein durch die Tastatur, daher muss auch diese ergonomischer und effizienter werden. Was mich dann am Schluss zu dem Thema Hardware bringt, welche auch hier wieder im Zug wie auch im Büro beste Leistung zeigen soll.

## Speicher
Bei einer komplettem Ausfall, sollen die Daten möglichst schnell wieder verfügbar sein und unabhängig von meinem Arbeitsgerät verwaltet werden. Dies führt zum logischen Schluss, dass alle Daten in die Cloud müssen.

### Cloud
Ohne Kompromisse bedeutet für mich, die Cloud steht in meinen vier Wenden. Alle Daten sollen in einer NextCloud verwaltet werden, die auf einer verschlüsselten Festplatte abgelegt sind. Die Daten sollen jeder Zeit von Aussen erreichbar sein über Mutual Authentication oder FIDO2. Ein dezentrales Backup wird angestrebt, jedoch werden die Daten nur verschlüsselt die Umgebung verlassen. Was soll auf dieser sicheren Cloud laufen:
- Mail (DKIM, SPF, DMARC)
- Kalender
- Kontakte
- Talk (Video Telefonie, Screensharing und Slack)
- Deck (ToDos, Notizen)
- Office (Word, Excel)
- Daten (Bilder, Videos, PDFs usw.)
- (Passwörter)

#### Umsetzung
- raspberry pi
- https://nixos.wiki/wiki/Nextcloud

### Git
Hier gilt ähnliches wie bei der Cloud. Die Repositories sollen auf einer eigen verwalteten GitLab Instanz zur Verfügung stehen. Wobei jegliche Arbeiten (Programmierung, Zeichnungen, Blog usw.) und diverse Konfigurationen darin abgelegt und verwaltet werden sollen.

#### Umsetzung
- Raspberry pi
- https://nixos.wiki/wiki/Gitlab

### Website
Hier gilt ähnliches wie bei der Cloud. Die Website soll weiterhin als persönliche Visitenkarte und Blog-Platform genutzt werden. Dabei wird diese möglichst statisch und mit nativen Technologien umgesetzt.

#### Umsetzun
- Raspberry pi
- https://nixos.wiki/wiki/Nginx

### Lokal
Lokal werden nur noch Daten verwaltet die jeder Zeit verloren gehen können. Dies beinhaltet Download, Temp, Cache oder Synchronisations Verzeichnisse.

### Backup
Ein Backupscript soll die verschlüsselte Partition dezentral auf einem Schweizer Provider ablegen, so dass die Systeme von Oben möglichst schnell auf einer neuen Hardware deployed werden können. Wichtig ist zu erwähnen, dass jegliche Konfiguration somit darin enthalten sind und ohne Wiederherstelung verloren sind.

## Sicherheit
### FIDO2 / OTP
Wo immer möglich wird FIDO2 oder mutual Authentication eigesetzt in kombination mit einem OTP als zweiten Faktor. Dazu werden die Produkte von [token2](https://www.token2.swiss) eingesetzt.
### Passwortmanager
Am liebsten hätte ich hier das NextCloud [Plugin](https://apps.nextcloud.com/apps/keeweb) für Keepass verwendet. Was die Möglichkeit geboten hätte, die Datenbank auch von anderen Clients zu lesen. Leider wird dieses aber nicht mehr weiter entwickelt, daher werde ich vermutlich auf das [«Passwords»-Plugin](https://apps.nextcloud.com/apps/passwords) oder [Passman](https://apps.nextcloud.com/apps/passman) setzen.

## Betriebssystem
Ich habe folgende zwei Tourtorials getestet und war sofort von NixOS überzogen:
- [NixOS virtual machine](https://nix.dev/tutorials/nixos/nixos-configuration-on-vm.html)
- [Development environment with nix-shell](https://nixos.wiki/wiki/Development_environment_with_nix-shell)

Schaut es euch selbst an. Die Konzepte überzeugen und die automatische Dokumentation besticht. Es braucht zum Teil etwas umdenken, weil gewisse Dateien nicht mehr einfach angepasst werden können. Als Beispiel kann ein `/etc/hosts` nicht einfach kurz ergänzt werden. Sondern es muss in einer Nix Konfiguration geschehen und durch einen Rebuild verändert. Aber beim nächsten überlegen merkt man, dass dies genau das ist was man eigentlich will.

### Sway
Ich habe [i3](https://i3wm.org/) über längere Zeit getestet. Es braucht eine gewisse gewöhnheits Zeit, aber auf einmal nimmt man seinen Computer wieder als Arbeitsintrument war und wird einiges schneller. Auf einmal findet man die Tastaturkombinationen die man beim Window Managment mit Gnome vermisst hat. Da liegt es nahe auf [Sway](https://swaywm.org/) zu wechselnt und somit von X11 auf Wayland.

### Vim
Wer denkt bei Sway sei die Lernkurve steil, wird bei der nächsten Umstellung nicht mehr mit an Board sein. Neben dem ich schon lange Vi als mein Editor auf den Server-Systemen habe. Habe ich angefangen auch in Visual Studio Code mit einem Plugin auf Vim Basis zu arbeiten. Am Anfang öffnete ich öfters einm ChatGPT um nach möglichen Tastatur Kombinationen zu fragen. In zwischen Zeit hat sich der Einstieg schon mehrfach ausbezahlt und ich nutze Vim auch im Browser und im Terminal (nicht nur als Editor).

- [Editor](https://neovim.io/)
- [Terminal](https://github.com/jeffreytse/zsh-vi-mode)
- [Browser](https://fanglingsu.github.io/vimb/)
- [IDE](https://www.lazyvim.org/)

### Hardware
#### Opensource
#### Keyboard und Maus

Speicher
Git
Cloud
Lokal?
Backup?

Konfiguration, was immer möglich, auch zur dokumentation, git

Software, lokal über browser
Rich software über browser, installiert nur minimum für persistenz und funktion, alles andere über virtuelle shells.

Hardware unabhängig, schnell wechselbar, open source und günstiger
Tastatur mehr daumen arbeit, open source mit trackpad für daumen, gut transportierbar und mobil einsetzbar
Evt tablet aber im zug? Eigenes gehäuse mit tastatur mobil.
Respory pi im office für die grossen screens?

Security fido2, mutual auth, pw less, backup
Cloud, git, mail, calendar, kontakt zu Hause 🤷‍♂️ monitoring? Updates? Security?

Devops
Shell virtuell nix
Docker
Remote shell
Neo vim auch als ide debuggen
Sway

## Weiterführend
* [Source Code](https://github.com/marcokuoni/public_doc/tree/main/essays/14_hello_wasi)
* [English Version](https://github.com/marcokuoni/public_doc/tree/main/essays/14_hello_wasi/README.md)

Ich bin gerne bereit den Artikel zu präzisieren, erweitern oder zu korrigieren. Schreibt ein Feedback oder meldet euch direkt bei mir.

Erstellt von [Marco Kuoni, September 2024](https://marcokuoni.ch)
