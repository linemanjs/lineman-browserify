_ = require("underscore")

module.exports = (lineman) ->
  app = lineman.config.application

  config:
    concat_sourcemap:
      js:
        src: _(app.concat_sourcemap.js.src).without(
          "<%= files.js.vendor %>",
          "<%= files.js.app %>",
          "<%= files.coffee.generated %>"
        ).concat("<%= files.browserify.generated %>")

      spec:
        src: _(app.concat_sourcemap.spec.src).without(
          "<%= files.js.specHelpers %>",
          "<%= files.coffee.generatedSpecHelpers %>",
          "<%= files.js.spec %>",
          "<%= files.coffee.generatedSpec %>"
        ).concat("<%= files.browserify.generatedSpec %>")

    watch:
      js:
        files: []
        tasks: []

      jsSpecs:
        files: []
        tasks: []
