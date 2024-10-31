# MoonKind

Allows you to assert the types of your variables, without doing implicit conversions.

It can operate in two ways:

1. Throws an error in case a variable's type isn't correct
2. Returns a <boolean, variable|error> which you can decide on how to handle

They are essentially wrappers around `assert(type(var) == "type")` and `pcall(assert, type(var) == "type")` with error messages that are helpful for debugging purposes.

## Basic Usage

Enforcing the type of a variable and throwing an error if it's mismached:

```lua
local t = require("moonkind.throws")

local my_string = t.str("Hello there") -- Just returns the string
local not_string = t.str(12) -- Fails with error "Incorrect type: (12) is not a string"
```

Indicating the variable type but having the option to decide yourself how to handle it in case you get a mismatched type:

```lua
local c = require("moonkind.checks")

local success, my_integer = c.int(45) -- It returns a boolean first (true here), the variable second
local success, not_integer = c.int(67.8) -- It won't throw, but will return "false" and "not_integer" now contains the error message
```

## Installation

Luarocks: `luarocks install moonkind` is all that's needed. Use the option most adequate to your use case, either installing it globally or per project.

Manually: copy `lua/moonkind` directory into your Lua module path. It's typically `/usr/local/share/lua/5.x` on a Linux system and `C:\Program Files\Lua\5.x\lua` for Lua for Windows if you want it to be system-wide. To have it installed per-project, just copy `lua/moonkind` into your project's root.

## Versioning

Moonkind aims to follow [Semantic Versioning](https://semver.org/). As small of a library as this is, this will be enforced in case there are any breaking changes.

## Reasoning

Lua already has a lot of extensions, supersets and alternatives that compile/transpile to Lua to enhance the experience for users who want different syntax for classes, types, functional methods and other features ([Teal](https://github.com/teal-language/tl) and [Moonscript](https://github.com/leafo/moonscript) being two of the more proeminent examples, not accounting for Roblox's Luau). Some of these require you to adopt new syntax and/or to run your scripts through a transpiler before executing them.

This tiny library is for people who want mostly just type-checking and would rather not add any sort of build step or adopt new syntax. It's composed of small wrappers around asserts, so instead of writing something like

```lua
local my_var: string = "Yup, just a string"
```

as is common with typed Lua variants, in this library it becomes

```lua
local my_var = t.str("Yup, just a string")
```

Both will work similarly, so this library provides you an option in how you want to incorporate type-checking in your scripts. The comparison can be summarized to:

|                 | Transpiled languages | Moonkind |
| --------------- | -------------------- | -------- |
| Familiar syntax | ✅                   | ❌       |
| Type checking   | ✅                   | ✅       |
| Other features  | ✅                   | ❌       |
| No build step   | ❌                   | ✅       |

TL;DR: If you want a familiar type-checking syntax and possible a lot of other features, a transpiled Lua dialect is probably a more adequate solution. However if you just want basic type-checking and would like to avoid transpiling scripts, you can give MoonKind a spin.

> Why an entire project for such a small feature?

- While working on another project I started doing way too many type assertions, and since they're all too similar it'd be best to make things easier by wrapping them in helpful functions.

> Why not use a compiled/transpiled Lua dialect with typing support?

- To avoid transpilation and reduce the ammount of dependencies per project.

## Type system

MoonKind gives you two ways of checking for types: Either by direct assertion which will throw an error on type mismatch, or by giving you two returns, containing a type-match success boolean and a <given_variable | error>.

It does this by having two implementations for each type-check function, and you get to choose which one you want to use at any given time by picking between `require("moonkind.checks)` or `require("moonkind.throws)`

`checks` contains methods for only **C**hecking types (no error throwing) and giving you possible errors as values, while `throws` has methods for **T**hrowing errors in case of type mismatch. The interface for both is the same:

```lua
c.tbl({1, 2, 3}) -- Returns "true" and {1, 2, 3}
t.tbl({4, 5, 6}) -- Returns {4, 5, 6}

c.bool("True") -- Returns "false" and "Incorrect type: (True) is not a boolean"
t.bool("False") -- Throws erro with message "Incorrect type: (False) is not a boolean"
```

None of the functions in this library will do type conversion or coercion, either implicitly or explicitly. This is by design, to ensure you're getting precisely what you expect.

MoonKind has the following type-checking methods:

- `str()` for strings
- `int()` for integers
- `float()` for numbers, integer or not
- `bool()` for booleans
- `tbl()` for table, with no distinction between which kind of indexing the table uses
- `fun()` for functions
- `thread()` for coroutines

Special case:

- `obj()` for an object following a given structure

The struct is given by creating a table with named fields, each field containing a string denoting its type, e.g:

```lua
local Person = {
    name = "string",
    age = "number",
    address = "table"
    greet = "function"
}

local tom = {
    name = "Thomas G.",
    age = 42,
    address = { street = "Einstein Avenue", number = "300"},
    greet = function(name) return string.format("Good evening, %s", name) end
}

local greg = {
    name = "Gregory Gregson",
    age = "38",
    address = "SimpleTown street, 60",
    greet = function() return "Hi there, buddy" end
}

t.obj(tom, Person) -- Will match correctly
t.obj(greg, Person) -- Will fail because "age" field isn't a number, and "address" isn't a table
```

You can think of the "type object" as a type declaration. You can freely import it from elsewhere in the codebase as it is just a common Lua table. The upside is you don't need an LSP to parse docstrings for you, the downside is that your LSP won't help you match the fields to the correct types (and you'll find out if you got it wrong by getting an error thrown).

## Contributing

Contributions are welcome, either code, issues, documentation suggestions or bug reports.

## License

Moonkind is distributed under the [MIT license](LICENSE).
