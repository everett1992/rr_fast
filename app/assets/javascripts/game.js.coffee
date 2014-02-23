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
    "w    ww          ",
    "w                ",
    "w                ",
    "w wl             ",
    "w ww        ww   ",
    "w           wo   ",
    "w w              ",
    "w                ",
    "w          ww    ",
    "w          ew    ",
    "w             www",
    "w      qw     www",
    "w      ww     www"
  ]

  q2 = [
    "wwwwwwwwwwwwwwwww",
    "w   w            ",
    "w       ww       ",
    "w       wa       ",
    "w  ww            ",
    "w  kw            ",
    "w                ",
    "w            nw  ",
    "w            ww  ",
    "w                ",
    "w                ",
    "w                ",
    "ww               ",
    "w     wh         ",
    "w     ww      www",
    "w             www",
    "w             www"
  ]

  q3 = [
    "wwwwwwwwwwwwwwwww",
    "w       w        ",
    "w                ",
    "w wc             ",
    "w ww         ww  ",
    "w            iw  ",
    "w                ",
    "w                ",
    "w                ",
    "w    fw          ",
    "w    ww       ww ",
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

  class Game
    constructor: (q1, q2, q3, q4) ->
      self=this
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

      #NUMBERWANG
      q1 = parse_tile(q1)

      q2 = rotate(parse_tile(q2))
      q3 = rotate(rotate(parse_tile(q3)))
      q4 = rotate(rotate(rotate(parse_tile(q4))))
      concat = ->
        self.board = []
        _((q1.length + q2.length) - 1).times ->
          self.board.push(Array((q3.length + q4.length) - 1))
        #Quadrant 1 into board
        _(q1.length).times (y) ->
          _(q1[y].length).times (x) ->
            self.board[y][x] = q1[y][x]
        #Quadrant 2 into board, and checking with wall conflicts on q1
        _(q2.length).times (y) ->
          if(self.board[y][q1.length - 1].type is "wall" || q2[y][0].type is "wall")
            self.board[y][q1.length - 1] = LEGEND['w']
        _(q2.length).times (y) ->
          _(q2[y].length).times (x) ->
            if(x>0)
              self.board[y][x + q1[0].length - 1] = q2[y][x]
        #Quadrant 3 into board, checking with wall conflicts on q2
        _(q3.length).times (x) =>
          if(self.board[q2.length - 1][x + q4[0].length - 1].type is "wall" || q3[q2.length - 1][x + q1[0].length - 1].type is "wall")
            self.board[q2.length - 1][x + q4[0].length - 1] = LEGEND['w']
        _(q3.length).times (y) =>
          if(y>0)
            _(q3[y].length).times (x) =>
              self.board[y + q2.length - 1][x + q4[0].length - 1] = q3[y][x]
        #Quadrant 4 into board, checking with conflicts on q1 AND q3. Tricky.
          #Quadrant 4 and 1
        _(q4.length).times (x) =>
          if(self.board[q1.length - 1][x].type is "wall" || q4[0][x].type is "wall")
            self.board[q1.length - 1][x] = LEGEND['w']
          #Quadrant 4 and 3
        _(q4.length).times (y) =>
          if(self.board[y + q1.length - 1][q4.length - 1].type is "wall" || q3[y][0].type is "wall")
            self.board[y + q4.length - 1][q4[0].length - 1] = LEGEND['w']
          #Filling in the rest of q4
        _(q4.length).times (y) =>
          if(y>0)
            _(q4[y].length).times (x) =>
              if(x<q4[0].length - 1)
                self.board[y + q1.length - 1][x] = q4[y][x]
      concat()

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
      draw_walls = () =>
        even = (n) ->
          n % 2 == 0

        console.log @board
        _(@board).each (row, j) ->
          _(row).each (cell, i) ->
            console.log cell
            if cell.type == 'wall'
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

  game = new Game(q1, q2, q3, q4)
  game.draw $('#game')

