findsRoot = require('find-root-package')
grunt = require('lineman').grunt
minimatch = require('minimatch')
sh = require('execSync')

module.exports =
  initialize: (dir = process.cwd()) ->
    topDir = findsRoot.findTopPackageJson(dir)
    return unless isInstalledAsDependency(dir, topDir)
    new EntryPoint(topDir).ensureExists()


isInstalledAsDependency = (dir, topDir) ->
  topDir? && topDir != dir


class EntryPoint

  default: "app/js/entrypoint.coffee"

  contents: """
            window._ = require("underscore")
            require("./hello")

            """

  constructor: (@projectDir) ->
    process.chdir @projectDir
    @configuredPattern = sh.exec("lineman config --process files.browserify.entrypoint").stdout.replace(/\s*$/,'')

  ensureExists: ->
    if @exists(@configuredPattern)
      grunt.log.writeln "Entry point file '#{@configuredPattern}' already exists; nothing to do..."

    else if @isDefaultConfiguration()
      grunt.log.ok "Writing a default entry point file '#{@default}' into '#{@projectDir}'"
      grunt.file.write @default, @contents

    else
      grunt.log.error "Entry point configured as '#{@configuredPattern}' but no file exists"

  exists: (pattern) ->
    !! grunt.file.expand(pattern).length

  isDefaultConfiguration: ->
    minimatch(@default, @configuredPattern)
