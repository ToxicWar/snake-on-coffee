#
#       Game settings
#
tick_period = 100
dotsize = 24
min_tasty_point_life = 50
max_tasty_points = 10
initial_snake_length = 5


# globals
ticker = ticks = playField = gameCanvas = snake = keyboardController = null

readyStateCheckInterval = setInterval(
  ->
    if document.readyState == "complete"
      init()
      clearInterval(readyStateCheckInterval)
  10)

registerHandler = (node, event, handler) ->
  if typeof node.addEventListener == "function"
    node.addEventListener(event, handler, false)
  else
    node.attachEvent("on" + event, handler)

init = ->
  startButton = document.getElementById('start')
  registerHandler startButton, 'click', ->
    start()

start = ->
  stop()
  playField = new PlayField(720 / dotsize, 480 / dotsize)
  gameCanvas = new GameCanvas(document.getElementById('game'), playField.width, playField.height)
  snake = new Snake(initial_snake_length)
  keyboardController = new KeyboardController()
  ticks = 0
  ticker = setInterval(tick, tick_period)

stop = ->
  clearInterval(ticker) if ticker?

tick = ->
  ticks++
  if snake.is_alive
    console.log 'snake move'
    snake.move()
  playField.update()
  playField.draw()
  snake.draw()