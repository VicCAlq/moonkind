local C = assert(require("moonkind.utils.constants"))
package.path = C.luapath
package.cpath = C.cpath

local f = string.format

local M = {}

--- Checks the given value against the given type,
--- then returns a boolean to indicate success or failure
--- and either the variable itself or an error message.
--- This function doesn't do implicit type coercion.
---@param var any The expected value
---@param expected_type string The expected type
---@param assertion boolean|nil A custom assertion clause
---@param err_msg string|nil A custom error message
---@return boolean success
---@return any|boolean|nil res
local function check_type(var, expected_type, assertion, err_msg)
  local message = err_msg or f("Incorrect type: (%s) is not a %s", var, expected_type)
  local clause = false
  if assertion ~= nil then
    clause = assertion
  else
    clause = type(var) == expected_type
  end

  ---@diagnostic disable-next-line
  local success, res = pcall(assert, clause, message)

  if not success then
    return success, res
  end
  return success, var
end

--- Checks if given value is a string returning a boolean
--- indicating success or failure and the corresponding
--- value or error.
--- This function doesn't do implicit type coercion.
---@param var string The expected value
---@return boolean success
---@return string|boolean|nil res
function M.str(var)
  local success, res = check_type(var, "string", nil, nil)
  return success, res
end

--- Checks if given value is an integer returning a boolean
--- indicating success or failure and the corresponding
--- value or error.
--- This function doesn't do implicit type coercion.
---@param var number The expected value
---@return boolean success
---@return number|boolean|nil res
function M.int(var)
  local msg = f("Incorrect type: (%s) is not an integer", var)
  local assertion = type(var) == "number" and var % 1 == 0
  local success, res = check_type(var, "integer", assertion, msg)
  return success, res
end

--- Checks if given value is a number returning a boolean
--- indicating success or failure and the corresponding
--- value or error.
--- This function doesn't do implicit type coercion.
---@param var number The expected value
---@return boolean success
---@return number|boolean|nil res Returns the number if valid
function M.float(var)
  local success, res = check_type(var, "number", nil, nil)
  return success, res
end

--- Checks if given value is a boolean returning a boolean
--- indicating success or failure and the corresponding
--- value or error.
--- This boolean doesn't do implicit type coercion.
---@param var boolean The expected value
---@return boolean success
---@return boolean|nil res Returns the boolean if valid
function M.bool(var)
  local success, res = check_type(var, "boolean", nil, nil)
  return success, res
end

--- Checks if given value is a table returning a boolean
--- indicating success or failure and the corresponding
--- value or error.
--- This function doesn't do implicit type coercion.
---@param var table The expected value
---@return boolean success
---@return table|boolean|nil res Returns the table if valid
function M.tbl(var)
  local success, res = check_type(var, "table", nil, nil)
  return success, res
end

--- Checks if given value is a function returning a boolean
--- indicating success or failure and the corresponding
--- value or error.
--- This function doesn't do implicit type coercion.
---@param var function The expected value
---@return boolean success
---@return function|boolean|nil res Returns the function if valid
function M.fun(var)
  local success, res = check_type(var, "function", nil, nil)
  return success, res
end

--- Checks if given value is a thread returning a boolean
--- indicating success or failure and the corresponding
--- value or error.
--- This thread doesn't do implicit type coercion.
---@param var thread The expected value
---@return boolean success
---@return thread|boolean|nil res Returns the var if valid
function M.thread(var)
  local success, res = check_type(var, "thread", nil, nil)
  return success, res
end

--- Checks if given object has the specified fields
--- returning a boolean indicating success or failure
--- and the corresponding value or error.
--- This thread doesn't do implicit type coercion.
---
--- To define a struct, create a table with named fields, and define
--- the value for each field as a string with the name of the desired
--- type, e.g.: `struct = { name = "string", age = "number" }`
---@param var table The expected value
---@return boolean success
---@return table|boolean|nil res Returns the object if valid
function M.obj(var, struct)
  local success, res = false, false
  for k, v in pairs(var) do
    success, res = pcall(
      ---@diagnostic disable-next-line
      assert,
      type(v) == struct[k],
      f(
        [[Incorrect type: The received object is not compatible with the given struct. Expected type for field (%s) is (%s), but received value is a (%s)]],
        k,
        struct[k],
        type(v)
      )
    )
  end
  if not success then
    return success, res
  end
  return success, var
end

return M
