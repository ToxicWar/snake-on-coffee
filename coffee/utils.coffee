randomNumber = (options) ->
  Math.floor(Math.random() * options)

find = (array, test) ->
  for i in [0...array.length]
    return array[i] if test(array[i])
