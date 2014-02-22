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

###
window.rotate = (matrix) ->

  # Create a n x n array where n is matrix.length
  arr = []
  _(matrix.length).times ->
    arr.push(Array(matrix.length))

  console.log arr
  _(matrix).each (row, x) ->
    _(row).each (cell, y) ->
      #console.log matrix.length - y
      arr[(matrix.length - 1) - y][x] = cell
  return arr
###
class Board
  constructor: (q1, q2, q3, q4) ->
    rotate = (matrix) ->

      # Create a n x n array where n is matrix.length
      arr = []
      _(matrix.length).times ->
        arr.push(Array(matrix.length))

     _(matrix).each (row, x) ->
       _(row).each (cell, y) ->
          arr[(matrix.length - 1) - y][x] = cell
      return arr
    ###
    for (x = 0; x < matrix.length; x ++)
    arr.push(Array(matrix.length))

    for (x = 0; x < matrix.length; x ++)
    for(y = 0; y < matrix.length; y ++)
    arr[y - matrix.length, x] = matrix[x, y]
    return arr
    ###

    q1 = q1
    q2 = q2.rotate(1)
    q3 = q3.rotate(1).rotate(1)
    q4 = q4.rotate(1).rotate(1).rotate(1)

    top = merge(q1, q2)
    bot = merge(q3, q4)

