fs = require('fs')
path = require('path')
findsRoot = require('find-root-package')

module.exports =
  initialize: (dir = process.cwd()) ->
    topDir = findsRoot.findTopPackageJson(dir)
    return unless isInstalledAsDependency(dir, topDir)

    entrypoint = path.join(topDir, 'app/js/entrypoint')
    return if entrypointFileExists(entrypoint)

    console.log("Writing a default 'app/js/entrypoint.coffee' file into '#{topDir}'")
    fs.writeFileSync "#{entrypoint}.coffee", """
                                             window._ = require("underscore")
                                             require("./hello")

                                             """

isInstalledAsDependency = (dir, topDir) ->
  topDir? && topDir != dir

entrypointFileExists = (entrypoint) ->
  fs.existsSync("#{entrypoint}.js") || fs.existsSync("#{entrypoint}.coffee")
