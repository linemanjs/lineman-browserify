_ = require("underscore")

module.exports = (lineman) ->
  app = lineman.config.application

  config:
    concat_sourcemap:
      js:
        src: _(app.concat_sourcemap.js.src).without(
          "<%= files.js.vendor %>", "<%= files.js.app %>", "<%= files.coffee.generated %>"
        ).concat("<%= files.browserify.generated %>")


    watch:
      js:
        files: []
        tasks: []
