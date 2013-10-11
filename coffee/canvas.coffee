#
#       Game canvas
#

class GameCanvas
  constructor: (@canvas, @width, @height) ->
    @context = @canvas.getContext('2d')

  clear: ->
    @context.clearRect(0, 0, @canvas.width, @canvas.height)

  drawPixel: (x, y, scale, colour) ->
    if scale > 0
      @context.fillStyle = colour
      @context.fillRect(x, y, scale, scale)
