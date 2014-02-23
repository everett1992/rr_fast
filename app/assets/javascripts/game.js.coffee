# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file:  http: //coffeescript.org/


$ ->
  # Legend
  #==============================
  LEGEND = {
    w: {color: null, type: "wall"},
    s: {color: null, type: "space"},
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
    "wssssssssswssssss",
    "wssssssssssssssss",
    "wssssbwssssssssss",
    "wsssswsssssssssss",
    "wssssssssssssssss",
    "wssssssssssssssss",
    "wswlsssssssssssss",
    "wsswssssssssswsss",
    "wssssssssssswosss",
    "wswssssssssssssss",
    "wssssssssssssssss",
    "wsssssssssswsssss",
    "wssssssssssewssss",
    "wssssssssssssswww",
    "wssssssqwssssswww",
    "wsssssswsssssswww"
  ]

  q2 = [
    "wwwwwwwwwwwwwwwww",
    "wssswssssssssssss",
    "wsssssssswsssssss",
    "wssssssswasssssss",
    "wsswsssssssssssss",
    "wsskwssssssssssss",
    "wssssssssssssssss",
    "wssssssssssssnwss",
    "wsssssssssssswsss",
    "wssssssssssssssss",
    "wssssssssssssssss",
    "wssssssssssssssss",
    "wwsssssssssssssss",
    "wssssswhsssssssss",
    "wsssssswsssssswww",
    "wssssssssssssswww",

    "wssssssssssssswww"
  ]

  q3 = [
    "wwwwwwwwwwwwwwwww",
    "wssssssswssssssss",
    "wssssssssssssssss",
    "wswcsssssssssssss",
    "wsswssssssssswsss",
    "wssssssssssssiwss",
    "wssssssssssssssss",
    "wssssssssssssssss",
    "wssssssssssssssss",
    "wssssfwssssssssss",
    "wsssswsssssssssws",
    "wssssssssssssswps",
    "wwsssssssssssssss",
    "wssssssssssssssss",
    "wssssssssssssswww",
    "wssssssssssssswww",
    "wssssssssssssswww",
  ]

  q4 = [
    "wwwwwwwwwwwwwwwww",
    "wssssssswssssssss",
    "wssssssssssssssss",
    "wssssssssssjwssss",
    "wsssssssssswwssss",
    "wswdsssssssssssss",
    "wswwsssssssssssss",
    "wssssssssssssssss",
    "wwsssssssssswwsss",
    "wssssssssssswpsss",
    "wssssssssssssssss",
    "wssssssssssssssss",
    "wsssswwssssssssss",
    "wssssgwssssssssss",
    "wssssssssssssswww",
    "wssssssssssssswww",
    "wssssssssssssswww"
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
      #console.log((_(q1).map (m) -> (_(m).map (n) -> n.type).join("")))
      #console.log(q1)
      q2 = rotate(parse_tile(q2))
      console.log((_(q2).map (m) -> (_(m).map (n) -> n.type).join("")))
      console.log(q2)
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
            #console.log("true")
            self.board[y][q1.length - 1] = LEGEND['w']
        _(q2.length).times (y) ->
          _(q2[y].length).times (x) ->
            if(x>0)
              self.board[y][x + q1[0].length - 1] = q2[y][x]
        #Quadrant 3 into board, checking with wall conflicts on q2
        _(q3.length).times (x) =>
          if(self.board[q2.length - 1][x + q4[0].length - 1].type is "wall" || q3[q2.length - 1][x + q1[0].length - 1].type is "wall")
            #console.log("true")
            self.board[q2.length - 1][x + q4[0].length - 1] = LEGEND['w']
        _(q3.length).times (y) =>
          if(y>0)
            _(q3[y].length).times (x) =>
              self.board[y + q2.length - 1][x + q4[0].length - 1] = q3[y][x]
              ###
        #Quadrant 4 into board, checking with conflicts on q1 AND q3. Tricky.
          #Quadrant 4 and 1
        _(q4.length).times (x) =>
          if(@board[q1.length - 1][x].type is "wall" || q4[0][x].type is "wall")
            #console.log("true")
            @board[q1.length - 1][x] = LEGEND['w']
          #Quadrant 4 and 3
        _(q4.length).times (y) =>
          if(@board[y + q1.length - 1][q4.length - 1].type is "wall" || q3[y][0].type is "wall")
            #console.log(@board[y + q1.length - 1][q4.length - 1])
            @board[y + q4.length - 1][q4[0].length - 1] = LEGEND['w']
          #Filling in the rest of q4
        _(q4.length).times (y) =>
          if(y>0)
            _(q4[y].length).times (x) =>
              if(x<q4[0].length - 1)
                @board[y + q1.length - 1][x] = q4[y][x]
                ###
        console.log(self.board)
      concat()


  bard = new Game(q1, q2, q3, q4)
