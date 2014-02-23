# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file:  http: //coffeescript.org/


$ ->
  # Legend
  #==============================
  LEGEND = {
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

  class Board
    constructor: (q1, q2, q3, q4) ->
      parse_tile = (tile) ->
        _(tile).map (row) ->
          _(row).map (char) ->
             LEGEND[char]

      rotate = (matrix) ->

        # Create a n x n array where n is matrix.length
        arr = []
        _(matrix.length).times ->
          arr.push(Array(matrix.length))

        _(matrix).each (row, x) ->
          _(row).each (cell, y) ->
            arr[(matrix.length - 1) - y][x] = cell
        return arr

      q1 = parse_tile(q1)

      q2 = rotate(parse_tile(q2))
      q3 = rotate(rotate(parse_tile(q3)))
      q4 = rotate(rotate(rotate(parse_tile(q4))))

    draw: (selector) ->
      # Test board
      arr = []
      _(33).times ->
        b = []
        _(33).times( -> b.push {type: "wall"})
        arr.push(b)


      s = 800
      w = s / 16

      $(selector).empty()
      canvas = $('<canvas/>').attr({width: s, height: s}).appendTo(selector)

      context = canvas.get(0).getContext("2d")

      # Draw grid.
      draw_grid = () ->
        context.strokeStyle = "grey"
        for x in [0..s] by w
          for y in [0..s] by w
            context.strokeRect(x, y, w, w)

        context.stroke()


      # Draw walls.
      draw_walls = () ->
        even = (n) ->
          n % 2 == 0

        _(arr).each (row, j) ->
          _(row).each (cell, i) ->
            if arr[i][j].type == 'wall'
              if even(i) && !even(j)
                y = (j - 1) * 0.5 * w
                x = 0.5 * i * w
                context.moveTo(x, y)
                context.lineTo(x, y + w)
              else if !even(i) && even(j)
                x = (i - 1) * 0.5 * w
                y = 0.5 * j * w
                context.moveTo(x, y)
                context.lineTo(x + w, y)

        context.lineWidth = 5
        context.strokeStyle = "black"
        context.stroke()



      draw_board = ->
        draw_grid()
        draw_walls()

      draw_board()

  board = new Board(q1, q2, q3, q4)
  board.draw $("#game")

