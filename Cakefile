fs = require 'fs'
{exec} = require 'child_process'

files  = [
  'utils'
  'canvas'
  'snake'
  'main'
]

output = 'game'

task 'build', 'Build single js file from *.coffee source', ->
  exec "mkdir -p js", (err, stdout, stderr) ->
    throw err if err
    appContents = new Array remaining = files.length
    for file, index in files then do (file, index) ->
      fs.readFile "coffee/#{file}.coffee", 'utf8', (err, fileContents) ->
        throw err if err
        appContents[index] = fileContents
        process() if --remaining is 0
    process = ->
      fs.writeFile "js/#{output}.coffee", appContents.join('\n\n'), 'utf8', (err) ->
        throw err if err
        exec "coffee --compile js/#{output}.coffee", (err, stdout, stderr) ->
          throw err if err
          console.log stdout + stderr
          fs.unlink "js/#{output}.coffee", (err) ->
            throw err if err
            console.log 'Done. Have fun!'

task 'clean', 'Clean output files', ->
  exec "rm -rf js"
  console.log 'Done.'
