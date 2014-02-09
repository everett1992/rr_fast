# Fast Ricochet Robots with real time feedback.

Part of the fun of Ricochet Robots is holding all of the moves in your head, but I think it would be
cool to see how fast the game can get with computer aids, and real time feedback.

# Some thoughts

- Robots move in straight lines until they hit walls or other robots.
- The goal is to move one of the four robots to a specified square on the grid in the least number of moves.
- After a player finds a solution the other players have one minute to find a shorter solution.
  At the end of the minute countdown the player with the shortest solution will get the point.

- Players can move the robots around their own boards in real time, any solution they find will
  be submitted automatically.
- All previous moves are recorded and listed.
- The length of other players shortest solution is displayed.


# Questions
- Should robots be animated, or instantly move to the final block of their move.
- Hardcore animé explosions when solutions are found?

## Controls
- One set of keys for each robot?
  q,w,e,r
  a,s,d,f
  j,k,l,; / h,j,k,l
  u,i,o,p / y,u,i,o
- One set of keys for all robots, cycle through robots?
- Touchscreen input, swipe robots to send them along a path?


# Steps
## Server
- [ ] Connect players to the same game.
  - [ ] New game, generate url with unique id.
  - [ ] Join game, enter an id.
  - [ ] Start game when all players are ready

## Javascript
- [ ] Model game board.
  - [ ] Robot Positions
  - [ ] Target Position.
  - [ ] Legal moves.
  - [ ] Different tile sets?

- [ ] Input moves.
- [ ] Render tried moves.
- [ ] Render board.
- [ ] Send moves to other players.
- [ ] Step through accepted solution.
- [ ] Track points.


# Steps

## Pregame
1. One player starts a game
2. The server creates a new game and redirects the player to `/<game_id>`
3. That player sends the other players a link to `/<game_id>`
4. Other players join the game by going to that address.
5. If at any time all players in the game are in the ready state the game starts.
6. After each game players state is set to not ready. GOTO 5

## Game

1. Target spaces are randomly shuffled.
2. Pop the first target and start a round with it.
3. GOTO 2

## Round

1. Players key in moves trying to the correct robot to the round's target.
2. When any player finds a solution a one minute timer starts.
3. The length of each players shortest solution is displayed next to their name
   if they have a solution.
4. At the end of the minute the player with the shortest solution gets a point
5. The shortest solution is played back.

Game
  [Targets]
  [Players]
  [state] waiting, playing, done

Player
  Points

Target
  color
  position

Robot
  color
  position

Solution
  [moves]

Move
  robot
  direction
