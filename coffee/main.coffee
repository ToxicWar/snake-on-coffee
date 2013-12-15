#
#       Game settings
#
tick_period = 60
dotsize = 24
min_tasty_point_life = 50
max_tasty_points = 1


# globals
ticker = ticks = playField = gameCanvas = null

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
  ticks = 0
  ticker = setInterval(tick, tick_period)

stop = ->
  clearInterval(ticker) if ticker?

tick = ->
  ticks++
  console.log "tick"
  playField.update()
  playField.draw()
