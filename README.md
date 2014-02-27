# lineman-browserify

This is a plugin to make it easy to use [Browserify](http://browserify.org/) in conjunction with a
[Lineman](http://linemanjs.com) app.

## Usage

First, add the plugin to your lineman project:

```
$ npm install lineman-browserify --save-dev
```

The plugin will create a default entrypoint that agrees with the vanilla lineman project archetype (which prints a little hello world on the screen). If you've installed the plugin into a vanilla project, you should see the demo continue to work, but otherwise you'll want to start by replacing the contents of `app/js/entrypoint.coffee` with whatever `require` statements you need to kick off your app. You can also rename this file to a ".js" extension if you like.

If you want to pull in a file from `vendor/js`, just require it; the aliases have been set up such that you can treat `vendor/js` as just a second root load path for the application.
