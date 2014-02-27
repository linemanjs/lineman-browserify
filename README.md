# lineman-browserify

This is a plugin to make it easy to use [Browserify](http://browserify.org/) in conjunction with a
[Lineman](http://linemanjs.com) app.

## Usage

First, add the plugin to your lineman project:

```
$ npm install lineman-browserify --save-dev
```

Next, you'll want to add the browserify entry points to `config/files.js`. The plugin supports a javascript _or_ coffeescript entrypoint named "browserifyBundle"


```
module.exports = function(lineman) {
  return {
    js: {
      browserifyBundle: "app/js/entrypoint.js"
    },

    // or

    coffee: {
      browserifyBundle: "app/js/entrypoint.coffee"
    }
  };
};
```

lineman-browserify configures concat_sourcemap to concatenate the 2 files that grunt-browserify emits:

- "generated/js/browserifyBundle.js"
- "generated/js/browserifyBundle.coffee.js"

Now, when you run `lineman run` and visit [localhost:8000](http://localhost:8000),
you should see Browserify compile the modules, and emit js and coffee sourcemaps in the browser.
