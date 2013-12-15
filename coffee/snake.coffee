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
    gameCanvas.drawPixel(@location.x, @location.y, '#58d68d')


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
    if @tasty_points.length < max_tasty_points && randomNumber(20) == 3
      this.spawnTastyPoint()

  spawnTastyPoint: () ->
    location = new Point(0, 0)
    while true
      location.set(randomNumber(playField.width), randomNumber(playField.height))
      if (this.tastyPointAt(location) == undefined && !snake.hasSegmentAt(location))
        tasty_point = new TastyPoint(location)
        @tasty_points.push(tasty_point)
        break

  removeTastyPoint: (tasty_point) ->
    index = @tasty_points.indexOf(tasty_point)
    if index >= 0
      @tasty_points.splice(index, 1)

  munchTastyPoint: (point) ->
    tasty_point = this.tastyPointAt(point)
    if tasty_point?
      this.removeTastyPoint(tasty_point)
      true
    else
      false

  tastyPointAt: (point) ->
      find(@tasty_points, (tasty) -> (tasty.is_alive() && tasty.location.isEqualTo(point)))

  draw: () ->
    gameCanvas.clear()
    @tasty_points.forEach((tasty_point) -> tasty_point.draw())


#
#       Snake
#

class Snake
  constructor: (@length) ->
    @segments = []
    @is_alive = true
    @direction = new Point(1, 0)
    @lastDirection = @direction
    x = Math.round(playField.width / 2)
    y = Math.round(playField.height / 2)
    for i in [0...length]
      @segments.push(new Point(x - i, y))

  head: () ->
    @segments[0]

  tail: () ->
    @segments[@segments.length - 1]

  hasSegmentAt: (location) ->
    arrayHas(@segments, (segment) -> segment.isEqualTo(location))

  draw: () ->
    gameCanvas.beginPath(this.head().x, this.head().y, '#58d68d')
    @segments.forEach((segment) -> gameCanvas.lineTo(segment.x, segment.y))
    gameCanvas.endPath()
    gameCanvas.drawPixel(this.head().x, this.head().y, '#e74c3c')

  move: () ->
    if this.willMeetItsDoom()
      @is_alive = false
    else
      if this.willMunchATastyPoint()
        this.grow(5)
      for i in [(@segments.length - 1)...0]
        @segments[i].set(@segments[i - 1].x, @segments[i - 1].y)
      this.head().addTo(@direction)
      @lastDirection = @direction

  willMeetItsDoom: () ->
    newHead = this.head().add(@direction)
    return true if newHead.x < 0 || newHead.x >= playField.width || newHead.y < 0 || newHead.y >= playField.height
    return true if this.hasSegmentAt(newHead)
    false

  willMunchATastyPoint: () ->
    newHead = this.head().add(@direction)
    playField.munchTastyPoint(newHead)

  grow: (length) ->
    for i in [1..length]
      @segments.push(new Point(this.tail().x, this.tail().y))

  changeDirection: (direction) ->
    if direction?
      d = @lastDirection.add(direction)
      if d.x != 0 || d.y != 0  # don't allow player to move back in the direction they are going
        @direction = direction


#
#       Keyboard controller
#


keyMap =
  '37': new Point(-1, 0)
  '39': new Point(1, 0)
  '38': new Point(0, -1)
  '40': new Point(0, 1)

class KeyboardController
  constructor: () ->
    @keysDown = []
    document.onkeydown = (event) -> keyboardController.keyDown(event)
    document.onkeyup = (event) -> keyboardController.keyUp(event)

  keyDown: (event) ->
    key = (event || window.event).keyCode
    if @keysDown.indexOf(key) == -1
      @keysDown.push(key)
      snake.changeDirection(keyMap[key])

  keyUp: (event) ->
    key = (event || window.event).keyCode
    index = @keysDown.indexOf(key)
    if index >= 0
      @keysDown.splice(index, 1)
