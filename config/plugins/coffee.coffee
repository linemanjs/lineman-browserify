module.exports = (lineman) ->
  app = lineman.config.application

  config:
    removeTasks:
      common: app.removeTasks.common.concat("coffee")

    watch:
      coffee:
        files: []
        tasks: []

      coffeeSpecs:
        files: []
        tasks: []
