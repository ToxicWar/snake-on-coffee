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
    @scale = dotsize

  update: () ->
    @life--

  is_alive: () ->
    @life > 0

  draw: () ->
    console.log 'draw'
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
      if !@tasty_points[i].is_alive()
        this.removeTastyPoint(@tasty_points[i])
      else
        i++
    if @tasty_points.length < max_tasty_points  # && randomNumber(20) == 3
      console.log 'spawn'
      this.spawnTastyPoint()

  spawnTastyPoint: () ->
    location = new Point(0, 0)
    while true
      location.set(randomNumber(playField.width), randomNumber(playField.height))
      tasty_point = new TastyPoint(location)
      @tasty_points.push(tasty_point)
      break

  removeTastyPoint: (tasty_point) ->
    index = @tasty_points.indexOf(tasty_point)
    if index >= 0
      @tasty_points.splice(index, 1)

  munchMushroom: (point) ->
    tasty_point = this.tastyPointAt(point)
    if tasty_point?
      this.removeMushroom(tasty_point)
      true
    else
      false

  tastyPointAt: (point) ->
      find(@tasty_points, (tasty) -> (tasty.is_alive() && tasty.location.isEqualTo(point)))

  draw: () ->
    gameCanvas.clear()
    @tasty_points.forEach((tasty_point) -> tasty_point.draw())
