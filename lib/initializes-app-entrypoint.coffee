fs = require('fs')
path = require('path')
sh = require('execSync')
glob = require('glob')
findsRoot = require('find-root-package')

module.exports =
  initialize: (dir = process.cwd()) ->
    topDir = findsRoot.findTopPackageJson(dir)
    return unless isInstalledAsDependency(dir, topDir)
    new EntryPoint(topDir).ensureExists()


isInstalledAsDependency = (dir, topDir) ->
  topDir? && topDir != dir


class EntryPoint

  constructor: (@projectDir, name='entrypoint') ->
    @pattern = sh.exec("cd #{@projectDir} && lineman config --process files.browserify.entrypoint").stdout
    @coffee = "app/js/#{name}.coffee"

  ensureExists: ->
    unless @exists()
      console.log("Writing a default '#{@coffee}' file into '#{@projectDir}'")
      fs.writeFileSync path.join(@projectDir, @coffee), @contents

  exists: ->
    !!glob.sync(path.join(@projectDir, @pattern)).length

  contents: """
            window._ = require("underscore")
            require("./hello")

            """
