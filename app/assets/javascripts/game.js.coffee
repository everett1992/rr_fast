# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file:  http: //coffeescript.org/


$ ->
  # Legend
  #==============================
  COLORS = [ 'red', 'blue', 'green', 'darkorange' ]

  LEGEND = {
    w:   {color: null,         type: "wall"},
    " ": {color: null,         type: "space"},
    a:   {color: COLORS[0],        type: "target", symbol: "crescent"},
    b:   {color: COLORS[0],        type: "target", symbol: "star"},
    c:   {color: COLORS[0],        type: "target", symbol: "gear"},
    d:   {color: COLORS[0],        type: "target", symbol: "planet"},
    e:   {color: COLORS[1],       type: "target", symbol: "crescent"},
    f:   {color: COLORS[1],       type: "target", symbol: "star"},
    g:   {color: COLORS[1],       type: "target", symbol: "gear"},
    h:   {color: COLORS[1],       type: "target", symbol: "planet"},
    i:   {color: COLORS[2],      type: "target", symbol: "crescent"},
    j:   {color: COLORS[2],      type: "target", symbol: "star"},
    k:   {color: COLORS[2],      type: "target", symbol: "gear"},
    l:   {color: COLORS[2],      type: "target", symbol: "planet"},
    m:   {color: COLORS[3], type: "target", symbol: "crescent"},
    n:   {color: COLORS[3], type: "target", symbol: "star"},
    o:   {color: COLORS[3], type: "target", symbol: "gear"},
    p:   {color: COLORS[3], type: "target", symbol: "planet"},
    q:   {color: "skyblue",    type: "target", symbol: "cosmic"}
  }
  SYM_TABLE = {
    crescent: "\u25B4"
    star: "\u25C6"
    gear: "\u25A0"
    planet: "\u25CF"
    cosmic: "\u2622"
  }
  TARGETS = [ 
    {color: COLORS[0], symbol: "crescent"},
    {color: COLORS[0], symbol: "star"},
    {color: COLORS[0], symbol: "gear"},
    {color: COLORS[0], symbol: "planet"},
    {color: COLORS[1], symbol: "crescent"},
    {color: COLORS[1], symbol: "star"},
    {color: COLORS[1], symbol: "gear"},
    {color: COLORS[1], symbol: "planet"},
    {color: COLORS[2], symbol: "crescent"},
    {color: COLORS[2], symbol: "star"},
    {color: COLORS[2], symbol: "gear"},
    {color: COLORS[2], symbol: "planet"},
    {color: COLORS[3], symbol: "crescent"},
    {color: COLORS[3], symbol: "star"},
    {color: COLORS[3], symbol: "gear"},
    {color: COLORS[3], symbol: "planet"},
    {color: "skyblue", symbol: "cosmic"},
  ]
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
    "ww               ",
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
    "w           wm   ",
    "w                ",
    "w                ",
    "w    ww          ",
    "w    gw          ",
    "w             www",
    "w             www",
    "w             www"
  ]

  class Game
    serialize: () ->
      {
        robots: @robots,
        targets: @targets
        current_target: @current_target
      }

    constructor: (@selector, q1, q2, q3, q4, game_data) ->
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

      q1 = parse_tile(q1)

      ###
        _   _ _   _ __  __ ____  _____ ______        ___    _   _  ____ _ _ _ _ _ _ _
       | \ | | | | |  \/  | __ )| ____|  _ \ \      / / \  | \ | |/ ___| | | | | | | |
       |  \| | | | | |\/| |  _ \|  _| | |_) \ \ /\ / / _ \ |  \| | |  _| | | | | | | |
       | |\  | |_| | |  | | |_) | |___|  _ < \ V  V / ___ \| |\  | |_| |_|_|_|_|_|_|_|
       |_| \_|\___/|_|  |_|____/|_____|_| \_\ \_/\_/_/   \_\_| \_|\____(_|_|_|_|_|_|_)

      ###


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
        #Quadrant 4 into board, and checking with wall conflicts on q1
        _(q4.length).times (y) ->
          if(self.board[y][q1.length - 1].type is "wall" || q4[y][0].type is "wall")
            self.board[y][q1.length - 1] = LEGEND['w']
        _(q4.length).times (y) ->
          _(q4[y].length).times (x) ->
            if(x>0)
              self.board[y][x + q1[0].length - 1] = q4[y][x]
        #Quadrant 3 into board, checking with wall conflicts on q4
        _(q3.length).times (x) =>
          if(self.board[q4.length - 1][x + q1[0].length - 1].type is "wall" || q3[0][x].type is "wall")
            self.board[q4.length - 1][x + q1[0].length - 1] = LEGEND['w']
        _(q3.length).times (y) =>
          if(y>0)
            _(q3[y].length).times (x) =>
              self.board[y + q4.length - 1][x + q2[0].length - 1] = q3[y][x]
        #Quadrant 2 into board, checking with conflicts on q1 AND q3. Tricky.
          #Quadrant 2 and 1
        _(q2.length).times (x) =>
          if(self.board[q1.length - 1][x].type is "wall" || q2[0][x].type is "wall")
            self.board[q1.length - 1][x] = LEGEND['w']
          #Quadrant 2 and 3
        _(q2.length).times (y) =>
          if(self.board[y + q1.length - 1][q2.length - 1].type is "wall" || q3[y][0].type is "wall")
            self.board[y + q2.length - 1][q2[0].length - 1] = LEGEND['w']
          #Filling in the rest of q2
        _(q2.length).times (y) =>
          if(y>0)
            _(q2[y].length).times (x) =>
              if(x<q2[0].length - 1)
                self.board[y + q1.length - 1][x] = q2[y][x]
      concat()

      if game_data
        @robots = game_data.robots
        @targets = game_data.targets
        @current_target = game_data.current_target
      else
        # Create robots and place them randomly
        @robots = []
        _(COLORS).each (color) ->
          x = 0; y = 0
          while true
            x = Math.floor((self.board.length / 2 - 1) * Math.random()) * 2 + 1
            y = Math.floor((self.board.length / 2 - 1) * Math.random()) * 2 + 1
            break unless self.board[x][y].type == 'wall' || _(self.robots).some (robot) ->
              robot.x == x && robot.y == y

          self.robots.push(new Robot(x, y, color))


        # Shuffle all targets
        self.targets = _(TARGETS).shuffle()

        # Set the current target
        @current_target=@targets.pop()

      # Select the first robot.
      self.selected_robot = self.robots[0]


    draw: () ->
      self=this

      s = 800
      w = s / 16

      $(@selector).empty()
      canvas = $('<canvas/>').attr({width: s, height: s}).appendTo(@selector)

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

        _(@board).each (row, j) ->
          _(row).each (cell, i) ->
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

              else if !even(i) && !even(j)
                x = 0.5 * w * i - 0.5 * w
                y = 0.5 * w * j - 0.5 * w
                context.strokeStyle = "black"
                context.fillStyle = "black"
                context.fillRect(x,y,w,w)

                context.stroke()

        context.lineWidth = 5
        context.strokeStyle = "black"
        context.stroke()


        
      draw_targets = () =>
        even = (n) ->
          n % 2 == 0

        _(@board).each (row, j) ->
          _(row).each (cell, i) ->
            if cell.type == 'target'
              x = w * 0.5 * i
              y = w * 0.5 * j + 0.27 * w

              context.font =  "40pt Calibri"
              context.fillStyle = cell.color

              context.textAlign = "center"
              context.testBaseline = "middle"
              context.fillText(SYM_TABLE[cell.symbol], x, y)

        context.lineWidth = 5

        context.strokeStyle = "black"
        context.fillStyle = "black"
        context.stroke()

      draw_selected_cell = () =>
        x = 0.5 * w * @selected_robot.x - 0.5 * w
        y = 0.5 * w * @selected_robot.y - 0.5 * w
        context.fillStyle = "yellow"
        context.fillRect(x,y,w,w)

        context.stroke()

      draw_robots = () =>
        _(@robots).each (robot) ->
          x = robot.x * 0.5 * w
          y = robot.y * 0.5 * w + 0.375 * w

          context.font =  "40pt Calibri"
          context.fillStyle = robot.color
          context.strokeStyle = "black"
          context.lineWidth = 2

          context.textAlign = "center"
          context.testBaseline = "middle"
          context.fillText('\u265F' , x, y)
          context.strokeText('\u265F' , x, y)


      draw_current_target = () =>
          x = s/2
          y = s/2 + 0.65*w

          context.font =  "100pt Calibri"
          context.fillStyle = @current_target.color
          context.strokeStyle = "white"
          context.lineWidth = 3

          context.textAlign = "center"
          context.testBaseline = "middle"
          context.fillText(SYM_TABLE[@current_target.symbol], x, y)
          context.strokeText(SYM_TABLE[@current_target.symbol] , x, y)


      draw_board = ->
        draw_selected_cell()
        draw_grid()
        draw_walls()
        draw_targets()
        draw_robots()
        draw_current_target()

      draw_board()

    get_target: () ->
      @current_target = @targets.pop()
      
    is_solved: () ->
      if @current_target.symbol is "cosmic" && @board[@selected_robot.y][@selected_robot.x].type=="target" && @board[@selected_robot.y][@selected_robot.x].symbol=="cosmic"
        return true
      else if @board[@selected_robot.y][@selected_robot.x].type=="target" && @selected_robot.color is @current_target.color && @board[@selected_robot.y][@selected_robot.x].symbol==@current_target.symbol
        return true
      else
        return false

    reset: () =>
      _(@robots).each (robot) =>
        robot.x = robot.start_x
        robot.y = robot.start_y
      @draw()


      #Game Logic
      #-move robot
    move_robot: (direction) ->
      if direction is "up"
        while true
          break if @board[@selected_robot.y-1][@selected_robot.x].type=="wall" || _(@robots).some (robot) =>
            robot.x == @selected_robot.x && robot.y == @selected_robot.y-2
          @selected_robot.y-=2
      if direction is "down"
        while true
          break if @board[@selected_robot.y+1][@selected_robot.x].type=="wall" || _(@robots).some (robot) =>
            robot.x == @selected_robot.x && robot.y == @selected_robot.y+2
          @selected_robot.y+=2
      if direction is "left"
        while true
          break if @board[@selected_robot.y][@selected_robot.x-1].type=="wall" || _(@robots).some (robot) =>
            robot.x == @selected_robot.x-2 && robot.y == @selected_robot.y
          @selected_robot.x-=2
      if direction is "right"
        while true
          break if @board[@selected_robot.y][@selected_robot.x+1].type=="wall" || _(@robots).some (robot) =>
            robot.x == @selected_robot.x+2 && robot.y == @selected_robot.y
          @selected_robot.x+=2

      @draw()


    cycle_robot: (direction) ->
      checker=false
      if direction is "right"
        _(@robots).each (robot,n) =>
          if(@selected_robot.color is robot.color && !checker)
            @selected_robot = @robots[(n+1)%4]
            checker=true
      else if direction is "left"
        _(@robots).each (robot,n) =>
          if(@selected_robot.color is robot.color && !checker)
            if n - 1 < 0
              @selected_robot = @robots[3]
            else
              @selected_robot = @robots[(n-1)%4]
            checker=true
      @draw()



  class Robot
    constructor: (@x, @y, @color) ->
      @start_x = @x
      @start_y = @y

  class User
    constructor: (@user_name) ->
      @points = 0
    serialize: => { user_name: @user_name, points: @points }

  class Net
    constructor: (uri) ->
      @dispatcher = new WebSocketRails(url)
      @dispatcher.on_open = @create_user
      @bind_events()

    userListTemplate: (userList) ->
        userHtml = ""
        for user in userList
          userHtml = userHtml + "<li>#{user.user_name} - #{user.points}</li>"
        $(userHtml)

    update_user_list: (user_list) =>
      @user_list = user_list
      $('#user_list').html @userListTemplate(user_list)

    update_user_info: (event) =>
      @user.user_name = $('input#user_name').val()
      $('#username').html @user.user_name
      @dispatcher.trigger 'change_username', @user.serialize()

    create_user: () =>
      @user = new User("user#{Math.floor(Math.random() * 1000)}")
      $("#username").html @user.user_name
      $("input#user_name").val @user.user_name
      @dispatcher.trigger "new_user", @user.serialize()

    set_game: (game) =>
      @dispatcher.trigger "set_game", game.serialize()

    get_game: (game_data) =>
      console.log(game_data)
      window.game = new Game('#game', q1, q2, q3, q4, game_data)
      net.set_game game
      game.draw()

    bind_events: () =>
      @dispatcher.bind 'user_list', @update_user_list
      @dispatcher.bind 'get_game', @get_game
      $('input#user_name').on 'keyup', @update_user_info

  url = $('#game').data('uri')
  net = new Net(url)

  new_game = () ->
    window.game = new Game('#game', q1, q2, q3, q4)
    game.get_target()
    net.set_game game
    game.draw()


  handleKeypress = (e) =>
    if e.keyCode is 97
      game.move_robot("left")
    else if e.keyCode is 119
      game.move_robot("up")
    else if e.keyCode is 115
      game.move_robot("down")
    else if e.keyCode is 100
      game.move_robot("right")
    else if e.keyCode is 101
      game.cycle_robot("right")
    else if e.keyCode is 113
      game.cycle_robot("left")
    else if e.keyCode is 114
      game.reset()

  $(document).keypress(handleKeypress)
  $('#reset').on "click", game.reset
  $('#new-game').on "click", new_game
