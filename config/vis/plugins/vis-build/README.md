# vis-build - asynchronously run (build) commands

This is a simple `vis` plugin to asynchronously run any shell command using
the `vis:communicate` API.

I use the plugin to run build commands while keeping my editor usable.

## Configuration

By default, the `build` will execute `make(1)` in the current directory.
The used build command can either be passed as first argument to `build` or
is retrieved by calling the function `build.get_default_build_cmd`.

So in order to change the default build command to ninja add this snippet to
you `visrc.lua`:

```lua
local build = require('plugins/vis-build')
build.get_default_build_cmd = function() return 'ninja' end
```

## Bindings

`<M-b>` is bound to the `build` command.
