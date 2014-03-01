fs = require('fs')
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
    process.chdir @projectDir
    @configuredPattern = sh.exec("lineman config --process files.browserify.entrypoint").stdout
    @default = "app/js/#{name}.coffee"

  ensureExists: ->
    unless @exists(@configuredPattern)
      console.log("Writing a default '#{@default}' file into '#{@projectDir}'")
      fs.writeFileSync @default, @contents

  exists: (pattern) ->
    !!glob.sync(pattern).length

  contents: """
            window._ = require("underscore")
            require("./hello")

            """
