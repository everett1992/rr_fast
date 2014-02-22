# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file:  http: //coffeescript.org/


# Legend
#==============================
legend = {
  w: {color: null, type: "wall"},
  " ": {color: null, type: "space"},
  a: {color: "red", type: "crescent"},
  b: {color: "red", type: "star"},
  c: {color: "red", type: "gear"},
  d: {color: "red", type: "planet"},
  e: {color: "blue", type: "crescent"},
  f: {color: "blue", type: "star"},
  g: {color: "blue", type: "gear"},
  h: {color: "blue", type: "planet"},
  i: {color: "green", type: "crescent"},
  j: {color: "green", type: "star"},
  k: {color: "green", type: "gear"},
  l: {color: "green", type: "planet"},
  m: {color: "yellow", type: "crescent"},
  n: {color: "yellow", type: "star"},
  o: {color: "yellow", type: "gear"},
  p: {color: "yellow", type: "planet"},
  q: {color: "cosmic", type: "cosmic"}
}
q1 = [
	"wwwwwwwwwwwwwwwww",
	"w         w      ",
	"w                ",
	"w    bw          ",
	"w    w           ",
	"w                ",
	"w                ",
	"w wl             ",
	"w  w         w   ",
	"w           wo   ",
	"w w              ",
	"w                ",
	"w          w     ",
	"w          ew    ",
	"w             www",
	"w      qw     www",
	"w      w      www"
]

q2 = [
  "wwwwwwwwwwwwwwwww",
  "w   w            ",
  "w        w       ",
  "w       wa       ",
  "w  w             ",
  "w  kw            ",
  "w                ",
  "w            nw  ",
  "w            w   ",
  "w                ",
  "w                ",
  "w                ",
  "ww               ",
  "w     wh         ",
  "w      w      www",
  "w             www",
  "w             www"
]

q3 = [
  "wwwwwwwwwwwwwwwww",
  "w       w        ",
  "w                ",
  "w wc             ",
  "w  w         w   ",
  "w            iw  ",
  "w                ",
  "w                ",
  "w                ",
  "w    fw          ",
  "w    w         w ",
  "w             wp ",
  "ww               ",
  "w                ",
  "w             www",
  "w             www",
  "w             www",
]

q4 = [
  "wwwwwwwwwwwwwwwww",
  "w       w        ",
  "w                ",
  "w          jw    ",
  "w          ww    ",
  "w wd             ",
  "w ww             ",
  "w                ",
  "ww          ww   ",
  "w           wp   ",
  "w                ",
  "w                ",
  "w    ww          ",
  "w    gw          ",
  "w             www",
  "w             www",
  "w             www"
]

class Tile
  constructor: (tile) ->
    _(tile).map (row) ->  
      _(row).map (char) -> 
         legend(char)

test = new Tile(q4)
console.log test
