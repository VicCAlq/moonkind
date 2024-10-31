local C = assert(require("moonkind.utils.constants"))
package.path = C.luapath
package.cpath = C.cpath

local f = string.format

local M = {}

--- Checks if given value is a string. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
---@param var string The expected value
---@return string|nil res Returns the string if valid
function M.str(var)
  local res = assert(type(var) == "string", f("Incorrect type: (%s) is not a string", var))
  if res then
    return var
  end
end

--- Checks if given value is an integer. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
---@param var number The expected value
---@return number|nil res Returns the integer if valid
function M.int(var)
  local res = assert(type(var) == "number" and var % 1 == 0, f("Incorrect type: (%s) is not an integer", var))
  if res then
    return var
  end
end

--- Checks if given value is a number. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
---@param var number The expected value
---@return number|nil res Returns the number if valid
function M.float(var)
  local res = assert(type(var) == "number", f("Incorrect type: (%s) is not a float", var))
  if res then
    return var
  end
end

--- Checks if given value is a boolean. If so, returns it,
--- else it'll throw an error.
--- This boolean doesn't do implicit type coercion.
---@param var boolean The expected value
---@return boolean|nil res Returns the boolean if valid
function M.bool(var)
  local res = assert(type(var) == "boolean", f("Incorrect type: (%s) is not a boolean", var))
  if res then
    return var
  end
end

--- Checks if given value is a table. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
---@param var table The expected value
---@return table|nil res Returns the table if valid
function M.tbl(var)
  local res = assert(type(var) == "table", f("Incorrect type: (%s) is not a table", var))
  if res then
    return var
  end
end

--- Checks if given value is a function. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
---@param var function The expected value
---@return function|nil res Returns the function if valid
function M.fun(var)
  local msg = f("Incorrect type: The given variable is not a function, but a (%s)", type(var))
  local res = assert(type(var) == "function", msg)
  if res then
    return var
  end
end

--- Checks if given value is a thread. If so, returns it,
--- else it'll throw an error.
--- This thread doesn't do implicit type coercion.
---@param var thread The expected value
---@return thread|nil res Returns the var if valid
function M.thread(var)
  local res = assert(type(var) == "thread", f("Incorrect type: (%s) is not a thread", var))
  if res then
    return var
  end
end

--- Checks if given object has the specified fields.
--- If so, returns it, else it'll throw an error.
--- This thread doesn't do implicit type coercion.
---
--- To define a struct, create a table with named fields, and define
--- the value for each field as a string with the name of the desired
--- type, e.g.: `struct = { name = "string", age = "number" }`
---@param var table The expected value
---@return table|nil res Returns the object if valid
function M.obj(var, struct)
  local res = false
  for k, v in pairs(var) do
    res = assert(
      type(v) == struct[k],
      f(
        [[Incorrect type: The received object is not compatible with the given struct. Expected type for field (%s) is (%s), but received value is a (%s)]],
        k,
        struct[k],
        type(v)
      )
    )
  end
  if res then
    return var
  end
end

return M
