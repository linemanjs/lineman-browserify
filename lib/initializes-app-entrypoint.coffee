fs = require('fs')
path = require('path')
findsRoot = require('find-root-package')

module.exports =
  initialize: (dir = process.cwd()) ->
    topDir = findsRoot.findTopPackageJson(dir)
    return unless isInstalledAsDependency(dir, topDir)

    return if fs.existsSync(dest = path.join(topDir, 'app', 'js', 'entrypoint.coffee'))
    console.log("Writing a default 'app/js/entrypoint.coffee' file into '#{topDir}'")
    fs.writeFileSync dest, """
                           window._ = require("underscore")
                           require("./hello")

                           """
isInstalledAsDependency = (dir, topDir) ->
  topDir? && topDir != dir

