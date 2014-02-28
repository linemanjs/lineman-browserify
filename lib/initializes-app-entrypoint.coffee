fs = require('fs')
path = require('path')
findsRoot = require('find-root-package')

module.exports =
  initialize: (dir = process.cwd()) ->
    topDir = findsRoot.findTopPackageJson(dir)
    return unless isInstalledAsDependency(dir, topDir)
    new EntryPoint(topDir).ensureExists()


isInstalledAsDependency = (dir, topDir) ->
  topDir? && topDir != dir


class EntryPoint

  constructor: (@projectDir, @name='entrypoint') ->
    @js = "app/js/#{@name}.js"
    @coffee = "app/js/#{@name}.coffee"

  ensureExists: ->
    unless @exists()
      console.log("Writing a default '#{@coffee}' file into '#{@projectDir}'")
      fs.writeFileSync path.join(@projectDir, @coffee), @contents

  exists: ->
    fs.existsSync(path.join(@projectDir, @js)) || fs.existsSync(path.join(@projectDir, @coffee))

  contents: """
            window._ = require("underscore")
            require("./hello")

            """
