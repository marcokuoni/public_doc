# Theoretische Informatik

## Mathematische Notationen
* Negation `¬`
* Konjunktion `∧`
* Disjunktion `∨`
* Implikation `p→q` ist wahr wenn p falsch oder q wahr ist `¬p ∨ q`
* Äquivalenz `↔`
* Exklusives Oder `⊕`
* Allquantor `∀` für alle Elmente
* Existenzquantor `∃` es existiert ein Element
* Leere Menge `∅`
* Mächtigkeit `|A|`
* Potenzmenge `P(A)`
* Komplement `A'`
* Vereinigung `A ∪ B`
* Schnittmenge `A ∩ B`
* Differenz `A \ B`
* Symmetrische Differenz `A Δ B`
* Kartesisches Produkt `A × B` mit `A × B = {(a, b) | a ∈ A ∧ b ∈ B}` Jedes Element von `A × B` ist ein Tupel `(a, b)` mit `a ∈ A` und `b ∈ B` Bsp: `A = {1, 2}, B = {a, b, c} ⇒ A × B = {(1, a), (1, b), (1, c), (2, a), (2, b), (2, c)}`
* Relation `R ⊆ A × B`
* Funktion `f: A → B`
* Injektivität (Linkseindeutigkeit) `f: A → B` ist injektiv, wenn `∀x, y ∈ A: f(x) = f(y) → x = y` Bsp: Kino -> auf jedem Sitz maximal eine Person
* Surjektivität (Rechtstotalen) `f: A → B` ist surjektiv, wenn `∀y ∈ B ∃x ∈ A: f(x) = y` Bsp: Kino -> jeder Sitz ist besetzt, jedoch auch mehrfach möglich
* Bijektivität (Eindeutigkeit) `f: A → B` ist bijektiv, wenn `f` injektiv und surjektiv ist Bsp: Kino -> jeder Sitz ist besetzt und auf jedem Sitz maximal eine Person
* Eine Relation ist eine totale Funktion: Linkstotal und Rechtseindeutig z.Bsp. y <= z
* Identität `id_A: A → A` mit `id_A(x) = x`
* Komposition `f ∘ g: A → C` mit `(f ∘ g)(x) = f(g(x))`
* Inverse `f⁻¹: B → A` mit `f⁻¹(f(x)) = x`
* Relation `R ⊆ A × B`
* Reflexivität `R ⊆ A × A` mit `∀x ∈ A: xRx`
* Symmetrie `R ⊆ A × A` mit `∀x, y ∈ A: xRy → yRx`
* Anti-Symmetrie `R ⊆ A × A` mit `∀x, y ∈ A: xRy ∧ yRx → x = y`
* Transitivität `R ⊆ A × A` mit `∀x, y, z ∈ A: xRy ∧ yRz → xRz`
* Halbordnungsrelation `R ⊆ A × A` mit `∀x, y ∈ A: xRy ∨ yRx ∨ x = y` (reflexiv, anti-symmetrisch, transitiv). Bsp: Halbordnungsrealtion auf ℕ: `≤`
* Äquivalenzrelation `R ⊆ A × A` mit `∀x, y, z ∈ A: xRy ∧ yRz → xRz` (reflexiv, symmetrisch, transitiv). Bsp: Äquivalenzrelation auf ℕ: `=`
* Äquivalenzklasse `[x]_R = {y ∈ A | xRy}`
* Quotientenmenge `A/R = {[x]_R | x ∈ A}`
* Ordnungsrelation `R ⊆ A × A` mit `∀x, y, z ∈ A: xRy ∧ yRz → xRz`
* Totalordnung `R ⊆ A × A` mit `∀x, y ∈ A: xRy ∨ yRx ∨ x = y`
* Wohlordnung `R ⊆ A × A` mit `∀S ⊆ A: S ≠ ∅ → ∃x ∈ S: ∀y ∈ S: xRy`
* Minimum `min(S) = x ∈ S` mit `∀y ∈ S: x ≤ y`
* Maximum `max(S) = x ∈ S` mit `∀y ∈ S: y ≤ x`
* Supremum `sup(S) = x ∈ S` mit `∀y ∈ S: y ≤ x ∧ ∀z ∈ S: z ≤ y → z = y`
* Infimum `inf(S) = x ∈ S` mit `∀y ∈ S: x ≤ y ∧ ∀z ∈ S: y ≤ z → z = y`
* Monotonie `f: A → B` ist monoton, wenn `∀x, y ∈ A: x ≤ y → f(x) ≤ f(y)`
* Stetigkeit `f: A → B` ist stetig, wenn `∀x ∈ A: ∀ε > 0 ∃δ > 0: ∀y ∈ A: |x - y| < δ → |f(x) - f(y)| < ε`
* Stetigkeit `f: A → B` ist stetig, wenn `∀x ∈ A: ∀ε > 0 ∃δ > 0: f(B_δ(x)) ⊆ B_ε(f(x))`
* Stetigkeit `f: A → B` ist stetig, wenn `∀x ∈ A: ∀ε > 0 ∃δ > 0: f⁻¹(B_ε(f(x))) ⊆ B_δ(x)`
* Tautologie `⊤` Eine aussage die immer Wahr ist
* Kontradiktion `⊥` Eine Aussage die immer Falsch ist
* Kommutativität:
    * `∧` `x ∧ y = y ∧ x`
    * `∨` `x ∨ y = y ∨ x`
    * `+` `x + y = y + x`
    * `*` `x * y = y * x`
* Assoziativität:
    * `∧` `(x ∧ y) ∧ z = x ∧ (y ∧ z)`
    * `∨` `(x ∨ y) ∨ z = x ∨ (y ∨ z)`
    * `+` `(x + y) + z = x + (y + z)`
    * `*` `(x * y) * z = x * (y * z)`
* Distributivität:
    * `∧` `x ∧ (y ∨ z) = (x ∧ y) ∨ (x ∧ z)`
    * `∨` `x ∨ (y ∧ z) = (x ∨ y) ∧ (x ∨ z)`
    * `+` `x + (y * z) = (x + y) * (x + z)`
    * `*` `x * (y + z) = (x * y) + (x * z)`
* De Morgan:
    * `¬(x ∧ y) = ¬x ∨ ¬y`
    * `¬(x ∨ y) = ¬x ∧ ¬y`
* Idempotenz:
    * `∧` `x ∧ x = x`
    * `∨` `x ∨ x = x`
    * `+` `x + x = x`
    * `*` `x * x = x`
* Absorption:
    * `∧` `x ∧ (x ∨ y) = x`
    * `∨` `x ∨ (x ∧ y) = x`
    * `+` `x + (x * y) = x`
    * `*` `x * (x + y) = x`
* Neutrales Element:
    * `∧` `x ∧ ⊤ = x`
    * `∨` `x ∨ ⊥ = x`
    * `+` `x + 0 = x`
    * `*` `x * 1 = x`
* Inverses Element:
    * `∧` `x ∧ ¬x = ⊥`
    * `∨` `x ∨ ¬x = ⊤`
    * `+` `x + (-x) = 0`
    * `*` `x * (1/x) = 1`
* Komplement:
    * `∧` `x ∧ ¬x = ⊥`
    * `∨` `x ∨ ¬x = ⊤`
    * `+` `x + (-x) = 0`
    * `*` `x * (1/x) = 1`
* Universum: G ist eine Menger über dem Univerum U, wenn `G ⊆ P(U)`
* Freie Variable: Eine Variable ist frei, wenn sie nicht durch einen Quantor (`∀`, `∃`) gebunden ist
* Gebundene Variable: Eine Variable ist gebunden, wenn sie durch einen Quantor gebunden ist
* Prädikatenlogik: `∀x ∈ A: P(x)` oder `∃x ∈ A: P(x)` Eine logische Aussage mit freien Variablen heisst auch Prädikat, wobei x hier die freie Variable ist
* Negation von Quantoren:
    * `¬(∀x ∈ A: P(x)) ⇔ ∃x ∈ A: ¬P(x)` Wenn etwas für alle Elemente gilt, muss es ein Element geben, für das die Aussage nicht gilt (Die Eigenschaft entspricht `P(x)`)
    * `¬(∃x ∈ A: P(x)) ⇔ ∀x ∈ A: ¬P(x)` Gibt es kein Element, das eine bestimmte Eigenschaft hat, haben alle Elemente diese Eigenschaft nicht
* Disjunktheit: Zwei Mengen sind disjunkt, wenn sie keine gemeinsamen Elemente haben `A ∩ B = ∅`
* Potenzmenge: `P(A) = {B | B ⊆ A}` Die Potenzmenge einer Menge A ist die Menge aller Teilmengen von A (inklusive der leeren Menge und A selbst) `|P(A)| = 2^|A|` Die Potenzmenge einer Menge mit n Elementen hat 2^n Elemente 
* Teilmenge `A ⊆ B` Eine Menge A ist eine Teilmenge von B, wenn jedes Element von A auch in B ist
* Echte Teilmenge `A ⊂ B` Eine Menge A ist eine echte Teilmenge von B, wenn jedes Element von A auch in B ist und A nicht gleich B ist
* Partielle Funktion `f: A → B` Eine Funktion ist partiell, wenn nicht für alle Elemente von A ein Funktionswert existiert
* Totale Funktion `f: A → B` Eine Funktion ist total, wenn für alle Elemente von A genau eine Zuordnung in B existiert. Bsp `f: ℕ → ℕ` mit `f(x) = x + 1` ist total, `f: ℕ → ℕ` mit `f(x) = 1/x` ist partiell (für die Null gibt es keinen Funktionswert)
* Komposition `f ∘ g: A → C` mit `(f ∘ g)(x) = f(g(x))`
* Graphen `G = (V, E)` mit `V` als Menge von Knoten (vertices) und `E` als Menge von Kanten (edges)
    * benachbart wird auch mit adjazenz bezeichnet
    * deg(v) ist der Grad eines Knotens v, also die Anzahl Nachbarn. Ohne Nachbarn, der Knoten ist isoliert, ist der Grad 0
    * Ausgangsgrad `deg^+(v)` ist die Anzahl ausgehender Kanten, Eingangsgrad `deg^-(v)` ist die Anzahl eingehender Kanten
    * Stark zusammenhängend: Es gibt einen Pfad von jedem Knoten zu jedem anderen Knoten.
    * Schwach zusammenhängend: Zusammenhang ist nur gewährleistet, wenn die Richtun ignoriert wird.
    * DAG (directed acyclic graph): Ein gerichteter Graph ohne Zyklen
    * Ein Spannbaum ist ein Teilgraph, der alle Knoten enthält und ein Baum ist
* Abzählbar unendlich: Eine Menge ist abzählbar unendlich, wenn es eine Bijektion zu den natürlichen Zahlen gibt
* Überabzählbar unendlich: Eine Menge ist überabzählbar unendlich, wenn es keine Bijektion zu den natürlichen Zahlen gibt. Die Menge ist nicht mehr numerierbar
* Beweise
    * Direkter Beweis: `p → q` Wenn p wahr ist, ist q auch wahr (p impliziert q). Modus ponens (wenn p, dann q)
    * Fallunterscheidung: `p ∨ q` Wenn p oder q wahr ist, ist die Aussage wahr. o.B.d.A. (ohne Beschränkung der Allgemeinheit, komplett symetrische Fälle)
    * Beweis per Kontraposition: `p → q ⇔ ¬q → ¬p` Wenn q falsch ist, ist p auch falsch. Modus tollens (wenn nicht q, dann nicht p)
    * Widerspruchsbeweis: `p → q` Wenn p wahr ist, ist q auch wahr. Wenn q falsch ist, ist p auch falsch. Man zeigt das die Aussage nicht falsch sein kann.
    * Vollständige Induktion: `p(0) ∧ ∀n ∈ ℕ: p(n) → p(n+1)` Wenn p(0) wahr ist und wenn p(n) wahr ist, ist auch p(n+1) wahr, dann ist p(n) für alle natürlichen Zahlen wahr. Starke Induktion `p(0) ∧ ∀n ∈ ℕ: (∀k ∈ ℕ: k < n → p(k)) → p(n)`: Anstatt nur auf einen Vorgänger zu beziehen, kann auch die Gültigkeit der Aussage für mehrere oder sogar für alle Vorgänger benötigt werden, um den Induktionsschritt zu beweisen (z.B. bei der Fibonacci-Folge).
    * Konstruktive und nichtkonstruktive Beweise: «Es gibt ein x mit Eigenschaft p» ist ein konstruktiver Beweis. «Es gibt ein x mit Eigenschaft p, aber ich weiss nicht welches» ist ein nichtkonstruktiver Beweis. Nichtkonstruktive Beweise sind oft einfacher zu finden, aber weniger informativ. Bsp: «Es gibt eine Ziffer d, die unendlich oft in den Nachkommastellen der Dezimaldarstellung von π vorkommt» ist ein nichtkonstruktiver Beweis. «Die Zahl π ist irrational» ist ein konstruktiver Beweis.

## Einführung in die Berechenbarkeitstheorie
Ein Algorithmus berechnet eine Funktion. Es gibt abzählbar unendlich viele Algorithmen (jeder Algorithmus kann in Form der natürlichen Zahlen auf den Speicher gelet werden), aber überabzählbar unendlich viele Funktionen. Es gibt also Funktionen, die nicht berechnet werden können. 

### Halteproblem
Das Halteproblem ist nicht berechenbar. Es gibt also keine Funktion, die für jedes Programm und jede Eingabe entscheiden kann, ob das Programm terminiert oder nicht.
Schlussfolgerung:
1. Es ist nicht für beliebige Algorithmen entscheidbar, ob diese auf einer bestimmten Eingabe anhalten.
2. Wenn nicht entscheidbar ist, ob ein Algorithmus auf einer Eingabe anhält, kann auch nicht entschieden werden, ob er mit dem richtigen Ergebnis anhält.
3. Wenn dies noch nicht einmal für eine einzelne Eingabe entscheidbar ist, dann erst recht nicht für alle möglichen Eingaben.
4. Damit kann nicht entschieden werden, ob ein Algorithmus für alle Eingaben das korrekte Ergebnis liefert.
Es kann also nicht entschieen werden ob ein Algorithus korrekt funktioniert.

## Problemtypen
### Formalisierung
Die Formalisierung eines Problems besteht aus der Eingabe, Ausgabe und Korrektheitsbedingung sowie jeweils dr Interpretation dieser Elemente.

### Berechenbare Funktionen (Definition)
Eine Funktion ist berechenbar, wenn es einen Algorithmus gibt, der genau diese Funktion berechnet.

### Datencodierung
* Codierung von Daten aller Art als Zeichenketten
* Alternativ als natürliche Zahlen
Überabzählbar grosse Mengen können in der Regel nicht codiert werden. Bei enigen Mengen funktioniert dies jedoch:
* Für berechenbare Funktionen, wir codieren mit einem Algorithmus
* Darauf aufbauend codieren wir unendliche Mengen beziehungsweise Tupel. Wir nutzen eine Funktion die die Elemente der Menge zählt. Diese Funktion codieren wir dann wiederum stellvertretend über einen Algorithmus, der diese Funtkion berechnet. Mengen, für die diese Konstruktion funktioniert, heissen aufzählbare Mengen.

> Achtung Verwechslungsgefahr: Abzählbarkeit, eine Menge ist abzählbar (unendlich), wenn es eine Bijektion zwischen der Menge und den natürlichen Zahlen gibt (Mathematik). Aufzählbarkeit, fordert zusätzlich noch, dass die Bijektion berechenbar ist (Informatik).

### Entscheidbare Sprachen (Definition)
Eine Sprache M heisst eintscheidbar, wen die dazugehörige charakteristische Funktion χ_M berechenbar ist. Ansonsten sagen wir, sie ist unentscheidbar bzw nicht entscheidbar. 

#### Charakteristische Funktion einer Sprache
Sei M eine Sprache über einem Alphabet Σ. Die charakteristische Funktion χ_M ist definiert als:
```
χ_M(w) = 1, falls w ∈ M
χ_M(w) = 0, falls w ∉ M
```

Bsp. Halteproblem: Die Sprache M = {⟨P, w⟩ | Algorithmus P hält auf Eingabe w} ist nicht entscheidbar. Die charakteristische Funktion χ_M ist nicht berechenbar.

### Semi-entscheidbare Sprachen (Definition)
Eine Sprache M heisst semi-entscheidbar, wenn die dazugehörige partielle charakteristische Funktion χ^_M berechenbar ist. Man nennt die Sprache aufzählbare Sprache.

#### Partielle charakteristische Funktion einer Sprache
Sei M eine Sprache über einem Alphabet Σ. Die partielle charakteristische Funktion χ^_M ist definiert als:
```
χ^_M(w) = 1, falls w ∈ M
χ^_M(w) = undefiniert (`⊥`, undefinierte Ausgabe), falls w ∉ M
```

Jede entscheidbare Sprache ist auch semi-entscheidbar. Die Umkehrung gilt nicht. Bsp. Halteproblem: Die Sprache M = {⟨P, w⟩ | Algorithmus P hält auf Eingabe w} ist nicht entscheidbar, aber semi-entscheidbar. Die partielle charakteristische Funktion χ^_M ist berechenbar.

* Etnscheidbare Sprachen - REC (engl. recursive)
* Semi-entscheidbare Sprachen - RE (engl. recursively enumerable)
* Komplement von RE - co-RE (engl. co-recursively enumerable).

-> REC = RE ∩ co-RE. Eine Sprache ist entscheidbar, wenn sowohl zugehörige als auch nicht zugehörige Elemente algorithmisch erkennen lassen.

## Einführung in formale Sprachen
* Alphabet Σ: endliche Menge von Symbolen Bsp: Σ = {a, b, c}
* Wort: endliche Folge von Symbolen aus Σ Bsp: w = abba. Die Menge aller Wörter über Σ ist Σ^*.
* Wortlänge: Anzahl Symbole in einem Wort Bsp: |w| = 4, |ε| = 0 (ε ist das leere Wort), |Σ^*| = ∞, |w|_a = 2 (Anzahl a in w)
* Wortmengen: Menge von Wörtern über Σ Bsp: M = {ab, ba, bb} ⊆ Σ^2
* Leeres Wort: ε ∈ Σ^*. Für jedes beliebige Alphabet Σ^0 = {ε}
* Kleenesche Hülle: Σ^* = Σ^0 ∪ Σ^1 ∪ Σ^2 ∪ ... Wenn man das leere Wort explizit ausschliesst, dann ist Σ^+ = Σ^* \ Σ^0
* Konkatenation: w_1w_2 = w_1 · w_2. Bsp: abba · b = abbab
* Potenz: w^n = w · w · ... · w (n-mal). Bsp: abba^2 = abba · abba = abbaabba
* Sprache: Menge von Wörtern über Σ. Bsp: L = {ab, ba, bb} ⊆ Σ^2. L_1 = { w ∈ Σ_1^* | die Symbole in w sind alphabetisch sortiert } -> aabbcc ∈ L_1, abcc ∈ L_1, aabb ∈ L_1, cab ∉ L_1
    * Achtung in vielen Fällen wird das Alphabet nicht mehr expliziet genannt, weil die Sprache dies impliziert.
* Konkatenation von Sprachen: L_1 ∘ L_2 = { w_1w_2 | w_1 ∈ L_1, w_2 ∈ L_2 }. Bsp: L_1 = {ab, ba, bb}, L_2 = {a, b} -> L_1L_2 = {aba, baa, bba, ab, ba, bb}
* Kleenesche Hülle: L^* = L^0 ∪ L^1 ∪ L^2 ∪ ... Bsp: L = {ab, ba, bb} -> L^* = {ε, ab, ba, bb, abab, abba, abbb, baab, baba, babb, bbab, bbba, bbbb, ...}

### Die Chomsky-Hierarchie
* Typ-0: RE aufzählbare Sprachen. Viele Probleme in dieser Klasse können nur semi-entschieden werden.
* Typ-1: Kontextsensitive Sprachen. Alle Sprachen in dieser Klasse sind entscheidbar. Da die Berechnung unbrauchbar lang dauern kann, werden sie wie auch Typ-0 in der Praxis nicht verwendet.
* Typ-2: Kontextfreie Sprachen. Können effizient entschieden werden. Damit können die meisten Konzepte aus den bekannten Programmiersprachen bechrieben werden. Zum Beispiel die Syntax von korrekt geklammerten verschachtelten Bedingungen und Schleifen. Jedoch kann nur eingeschränkt mit Zahlen gearbeitet werden. zBsp kann nicht entschieden werden ob eine Zahl eine Primzahl ist.
* Typ-3: Regulären Sprachen. Diese sind in der Lage, simple Wortstrukturen zu erkennen. Können mit sehr einfachen Berechnungsodellen sehr effizient entschieden werden.

Echte Teilmengenbeziehungen:
```
Typ-3 ⊂ Typ-2 ⊂ Typ-1 ⊂ Typ-0
```

Alle gängigen Programmiersprachen sowie unsere Alltagscomputer sind Berechnungsmodelle für Typ-0-Sprachen. Die Vorteile aus Typ-2 und Typ-3 werden in einzelne Anwendungszwecke szunutze gemacht.

## Reguläre Sprachen
### Deterministischer endlicher Automat (DEA)
Ein deterministischer endlicher Automat (DEA) ist ein 5-Tupel M = (Q, Σ, δ, q_0, F) mit:
* Q: endliche Menge von Zuständen
* Σ: endliches Eingabealphabet
* δ: Zustandsübergangsfunktion δ: Q × Σ → Q. die Funktion δ ist total, d.h. für alle q ∈ Q und a ∈ Σ existiert ein q' ∈ Q mit δ(q, a) = q'
* q_0: Startzustand q_0 ∈ Q
* F: Menge von akzeptierenden Zuständen F ⊆ Q

Erweiterete Zustandsübergangsfunktion δ^*: Q × Σ^* → Q mit: 
```
δ^*(q, ε) = q
δ^*(q, wa) = δ(δ^*(q, w), a) für alle q ∈ Q, w ∈ Σ^*, a ∈ Σ
```
Während die «normale» Übergangsfunktion ausgehend vom aktuellen Zustand defniert, in welchem Zustand der Automat nach dem Lesen eines Symbols wechselt, gibt die Erweiterte dasselbe für ein ganzes Wort an.
Wir defnieren darüber die Sprache des Automaten L(M) = { w ∈ Σ^* | δ^*(q_0, w) ∈ F }

Sprachäquivalenz:
* Jedes Wort der Sprache L_1 muss den Automaten in einen Endzustand führen, also L_1 ⊆ L(M)
* Jedes vom Automaten akzeptierte Wort ist in der Sprache L_1 enthalten, also L(M) ⊆ L_1
* Damit gilt L_1 = L(M)

### Nichtdeterministischer endlicher Automat (NEA)
Ein nichtdeterministischer endlicher Automat (NEA) ist ein 5-Tupel M = (Q, Σ, δ, q_0, F) mit:
* Zustandsmenge, Alphabet, Startzustand und Endzustände sind genau wie bei DEAs defniert.
* Die Zustandsüberführungsfunktion δ: Q × Σ → P(Q) bildet nun einen Zustand und ein gelesenes Zeichen auf eine Teilmenge der Zustände ab statt wie zuvor auf genau einen Zielzustand und beschreibt damit alle möglichen Zustände, in die der Automat mit dem gelesenen Eingabesymbol wechseln kann.

Unterschied im Verhalten:
* Sind für den aktuellen Zustand und das gelesene Eingabesymbol mehrere Übergänge definiert, so werden alle Möglichen der Arbarbeitung als eigene Berechnungspfade weiterverfolgt.
* Is für das gelesene Symbol und den aktuellen Zustand kein Übergang definiert, so wird dieser Berechnungspfad abgebrochen.

Epsilonübergänge: Ein NEA kann zusätzlich zu den normalen Übergängen auch Epsilonübergänge haben. Diese werden mit ε bezeichnet und erlauben es, den Zustand des Automaten zu wechseln, ohne ein Eingabesymbol zu lesen.

Potenzmengenkonstruktion: Ein NEA kann in einen äquivalenten DEA umgewandelt werden. Dazu wird für jeden Zustand des NEA ein Zustand des DEAs definiert. Die Zustände des DEAs sind also die Potenzmenge der Zustände des NEA. Die Zustandsübergangsfunktion des DEAs wird so definiert, dass sie für jeden Zustand des NEA und jedes Eingabesymbol die Menge der Zustände des NEA enthält, in die der NEA mit dem Eingabesymbol wechseln kann. Der Startzustand des DEAs ist der Startzustand des NEA. Die Endzustände des DEAs sind die Zustände des NEA, die einen Endzustand enthalten.

### Gramatiken


## Eigene Rezession

## Review