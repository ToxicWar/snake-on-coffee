#
#       Game canvas
#

class GameCanvas
  constructor: (@canvas, @width, @height) ->
    @context = @canvas.getContext('2d')
    @xScale = @canvas.width / width
    @yScale = @canvas.height / height

  clear: ->
    @context.clearRect(0, 0, @canvas.width, @canvas.height)

  drawPixel: (x, y, color) ->
    @context.fillStyle = color
    @context.fillRect(x * @xScale, y * @yScale, @xScale, @yScale)

  beginPath: (x, y, color) ->
    @context.fillStyle = 'none'
    @context.strokeStyle = color
    @context.lineWidth = (@xScale + @yScale) / 2
    @context.beginPath(x * @xScale, y * @yScale)

  lineTo: (x, y) ->
    @context.lineTo(x * @xScale + 12, y * @yScale + 12)

  endPath: () ->
    @context.stroke()
