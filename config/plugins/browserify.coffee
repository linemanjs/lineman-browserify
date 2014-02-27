module.exports = (lineman) ->
  config:
    loadNpmTasks: lineman.config.application.loadNpmTasks.concat("grunt-browserify")

    prependTasks:
      common: ["browserify"].concat(lineman.config.application.prependTasks.common)

    browserify:
      app_js:
        files:
          "generated/js/browserifyBundle.js" : "<%= files.js.browserifyBundle %>"
        options:
          debug: true

      app_coffee:
        files:
          "generated/js/browserifyBundle.coffee.js" : "<%= files.coffee.browserifyBundle %>"
        options:
          debug: true
          transform: ["coffeeify"]
