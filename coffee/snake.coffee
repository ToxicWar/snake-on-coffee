#
#       Point
#

class Point
  constructor: (@x, @y) ->

  set: (@x, @y) ->

  add: (otherPoint) ->
    new Point(@x + otherPoint.x, @y + otherPoint.y)

  addTo: (otherPoint) ->
    this.set(@x + otherPoint.x, @y + otherPoint.y)

  isEqualTo: (otherPoint) ->
    @x == otherPoint.x && @y == otherPoint.y


#
#       Tasty point
#

class TastyPoint
  constructor: (@location) ->
    @life = min_tasty_point_life + randomNumber(min_tasty_point_life)
    @scale = tasty_point_scale

  update: () ->
    @life--

  is_alive: () ->
    @life > 0

  draw: () ->
    gameCanvas.drawPixel(@location.x, @location.y, @scale, '#58d68d')


#
#       Play field
#

class PlayField
  constructor: (@width, @height) ->
    @tasty_points = []

  update: () ->
    i = 0
    while i < @tasty_points.length
      @tasty_points[i].update()

      if !@tasty_points.is_alive()
        this.removeTastyPoint(@tasty_points[i])
      else
        i++

      if @tasty_points.length < max_tasty_points && randomNumber(tasty_points_frequency) == 3
        this.spawnTastyPoint()

  spawnTastyPoint: () ->
    location = new Point(0, 0)
    location.set(randomNumber(playField.width), randomNumber(playField.height))
    tasty_point = new TastyPoint(location)
    @tasty_points.push(tasty_point)

  removeTastyPoint: (tasty_point) ->
    index = @tasty_points.indexOf(tasty_point)
    if index >= 0
      @tasty_points.splice(index, 1)

  draw: () ->
    gameCanvas.clear()
    gameCanvas.drawPixel(100, 100, 100, '#58d68d')
