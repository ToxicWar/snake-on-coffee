#
#       Play field
#

class PlayField
  constructor: (@width, @height) ->

  update: ->

  draw: ->
    gameCanvas.clear()
    gameCanvas.drawPixel(100, 100, 100, '#58d68d')
