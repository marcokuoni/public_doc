type letter = number[]
type wort = number[][]

//first row
const e: letter = [0,0];
const s: letter = [0,1];
const k: letter = [0,2];
const i: letter = [0,3];
const s1: letter = [0,4];
const t: letter = [0,5];
const a: letter = [0,6];
const f: letter = [0,7];
const ue: letter = [0,8];
const n: letter = [0,9];
const f1: letter = [0,10];
//second row
const z: letter = [1,0];
const e1: letter = [1,1];
const h: letter = [1,2];
const n1: letter = [1,3];
const z1: letter = [1,4];
const w: letter = [1,5];
const a1: letter = [1,6];
const n2: letter = [1,7];
const z2: letter = [1,8];
const i1: letter = [1,9];
const g: letter = [1,10];
//third row
...

const letterMatrix: string[][] = [
  ['E', 'S', 'K', 'I', 'S', 'T', 'A', 'F', 'Ü', 'N', 'F'],
  ['Z', 'E', 'H', 'N', 'Z', 'W', 'A', 'N', 'Z', 'I', 'G'],
  ['D', 'R', 'E', 'I', 'V', 'I', 'E', 'R', 'T', 'E', 'L'],
  ['V', 'O', 'R', 'F', 'U', 'N', 'K', 'N', 'A', 'C', 'H'],
  ['H', 'A', 'L', 'B', 'A', 'E', 'L', 'F', 'Ü', 'N', 'F'],
  ['E', 'I', 'N', 'S', 'X', 'A', 'M', 'Z', 'W', 'E', 'I'],
  ['D', 'R', 'E', 'I', 'P', 'M', 'J', 'V', 'I', 'E', 'R'],
  ['S', 'E', 'C', 'H', 'S', 'N', 'L', 'A', 'C', 'H', 'T'],
  ['S', 'I', 'E', 'B', 'E', 'N', 'Z', 'W', 'Ö', 'L', 'F'],
  ['Z', 'E', 'H', 'N', 'E', 'U', 'N', 'K', 'U', 'H', 'R']
];

const es: wort = [e, s];
const ist: wort = [i,s,t];
const fuenf: wort = [f, ue, n, f];
const zehn: wort = [z, e1, h, n1];
const zwanzig: wort = [z1, w, a1, n2, z2, i1, g];
const drei: wort = [[2, 0], [2, 1], [2, 2], [2, 3]];
const viertel: wort = [[2, 4], [2, 5], [2, 6], [2, 7], [2, 8], [2, 9], [2, 10]];
...

const timeMap = [
  0, [...es, ...ist, ...],
                300, []
];

let letterDomMatrix: (HTMLTableCellElement | null)[][];
function initDom() {
  letterDomMatrix = letterMatrix.map((row, rowIndex) =>
    row.map((_, colIndex) =>
      document.querySelector(`table tr:nth-child(${rowIndex + 1}) td:nth-child(${colIndex + 1})`)
    )
  );
}

function turnAllOff() {
  letterDomMatrix.forEach(row => {
    row.forEach(letter => {
      if (letter) {
        letter.style.color = "";
      }
    })
  });
}

function turnOn(woerter: wort) {
  woerter.forEach(element => {
    const letter = letterDomMatrix[element[0]][element[1]];
    if (letter) {
      letter.style.color = "red";
    }
  });
}

function startClock() {
  initDom();
  turnOn(timeMap((new DateTime()).getSeconds()));
  turnAllOff();
  turnOn(zehn);
}


document.addEventListener('DOMContentLoaded', () => {
  startClock();
})
