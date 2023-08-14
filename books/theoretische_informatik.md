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
* Injektivität `f: A → B` ist injektiv, wenn `∀x, y ∈ A: f(x) = f(y) → x = y` Bsp: Kino -> auf jedem Sitz maximal eine Person
* Surjektivität `f: A → B` ist surjektiv, wenn `∀y ∈ B ∃x ∈ A: f(x) = y` Bsp: Kino -> jeder Sitz ist besetzt, jedoch auch mehrfach möglich
* Bijektivität `f: A → B` ist bijektiv, wenn `f` injektiv und surjektiv ist Bsp: Kino -> jeder Sitz ist besetzt und auf jedem Sitz maximal eine Person
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
    * Konstruktive und nichtkonstruktive Beweise: «Es gibt ein x mit Eigenschaft p» ist ein konstruktiver Beweis. «Es gibt ein x mit Eigenschaft p, aber ich weiss nicht welches» ist ein nichtkonstruktiver Beweis. Nichtkonstruktive Beweise sind oft einfacher zu finden, aber weniger informativ. Bsp: «Es gibt eine Ziffer d, die unendlich oft in den Nachkommastellen der Dezimaldarstellung von π vorkommt» ist ein nichtkonstruktiver Beweis. «Die Zahl π ist irrational» ist ein konstruktiver Beweis.s


## Eigene Rezession

## Review