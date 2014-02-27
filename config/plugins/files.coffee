module.exports = (lineman) ->
  files:
    browserify:
      generated: "generated/js/browserify.js"
      entrypoint: "app/js/entrypoint.{js,coffee}"
