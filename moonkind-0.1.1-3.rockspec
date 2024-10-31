rockspec_format = "3.0"
package = "moonkind"
version = "0.1.2-1"
source = {
  url = "git+https://github.com/VicCAlq/moonkind.git",
  branch = "0.1.1",
}
description = {
  summary = "Simple type assertions for your Lua projeccts",
  detailed = [[
Moonkind allows you to easily assert the types of your variables, and doesn't do implicit conversions. 
You can either use it to throw errors in case of mismatched variables, or get the errors as values
to decide how to handle them.
]],
  homepage = "https://VicCAlq.github.io/moonkind",
  license = "MIT",
  issues_url = "https://VicCAlq.github.io/moonkind/issues",
  labels = {
    "typing",
    "type-system",
    "moonkind",
    "util",
  },
  maintainer = "Victor Cavalcanti <vic.mca.dev@gmail.com>",
}
supported_platforms = {
  "unix",
  "bsd",
  "solaris",
  "netbsd",
  "openbsd",
  "freebsd",
  "dragonfly",
  "linux",
  "macosx",
  "cygwin",
  "msys",
  "haiku",
  "windows",
  "win32",
  "mingw",
  "mingw32",
  "msys2_mingw_w64",
}
dependencies = {
  "lua >= 5.1, < 5.5",
}
build_dependencies = {}
build = {
  type = "builtin",
  modules = {
    moonkind = "lua/moonkind/init.lua",
    ["moonkind.checks"] = "lua/moonkind/core/checks.lua",
    ["moonkind.throws"] = "lua/moonkind/core/throws.lua",
    ["moonkind.utils.constants"] = "lua/moonkind/utils/constants.lua",
  },
  copy_directories = {
    "doc",
  },
}
test_dependencies = {}
