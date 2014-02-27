module.exports = (lineman) ->
  app = lineman.config.application

  config:
    loadNpmTasks: app.loadNpmTasks.concat("grunt-browserify")

    prependTasks:
      common: ["browserify"].concat(app.prependTasks.common)

    browserify:
      common:
        files:
          "<%= files.browserify.generated %>" : "<%= files.browserify.entrypoint %>"
        options:
          debug: false
          extensions: [".js", ".coffee"]
          transform: ["coffeeify"]
          aliasMappings: [
            cwd: "vendor/js"
            src: "**/*.{js,coffee}"
            dest: ""
          ]

    watch:
      browserify:
        files: ["<%= files.js.vendor %>", "<%= files.js.app %>", "<%= files.coffee.app %>"]
        tasks: ["browserify", "concat_sourcemap:js"]

