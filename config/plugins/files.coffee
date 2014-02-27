module.exports = (lineman) ->
  files:
    browserify:
      entrypoint: "app/js/entrypoint.{js,coffee}"
      generated: "generated/js/browserify.js"
      generatedSpec: "generated/js/browserify-spec.js"
