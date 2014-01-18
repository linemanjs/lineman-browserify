module.exports = (lineman) ->
  config:
    concat_sourcemap:
      js:
        src: [
          "<%= files.js.vendor %>"
          "<%= files.js.browserifyBundle %>"
          "<%= files.coffee.browserifyBundle %>"
          "<%= files.template.generated %>"
        ]