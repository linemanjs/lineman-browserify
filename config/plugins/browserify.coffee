module.exports = (lineman) ->
  app = lineman.config.application

  config:
    loadNpmTasks: app.loadNpmTasks.concat("grunt-browserify")

    prependTasks:
      common: ["browserify"].concat(app.prependTasks.common)

    browserify:
      common:
        files:
          "<%= files.browserify.generated %>": "<%= files.browserify.entrypoint %>"
        options:
          debug: false
          extensions: [".js", ".coffee"]
          transform: ["coffeeify"]
          aliasMappings: [
            cwd: "vendor/js"
            src: "**/*.{js,coffee}"
            dest: ""
          ]

      spec:
        files:
          "<%= files.browserify.generated %>": ["<%= files.js.spec %>", "<%= files.coffee.spec %>"]
        options:
          debug: false
          extensions: [".js", ".coffee"]
          transform: ["coffeeify"]
          aliasMappings: [
              cwd: "vendor/js"
              src: "**/*.{js,coffee}"
              dest: ""
            ,
              cwd: "app/js"
              src: "**/*.{js,coffee}"
              dest: ""
          ]

    watch:
      browserify:
        files: ["<%= files.js.vendor %>", "<%= files.js.app %>", "<%= files.coffee.app %>"]
        tasks: ["browserify:common", "concat_sourcemap:js"]

      browserifySpecs:
        files: ["<%= files.js.specHelpers %>", "<%= files.js.spec %>", "<%= files.coffee.specHelpers %>", "<%= files.coffee.spec %>"]
        tasks: ["browserify:spec", "concat_sourcemap:js"]

