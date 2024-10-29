local C = assert(require("utils.constants"))
package.path = C.luapath
package.cpath = C.cpath

local f = string.format

local M = {}

--- Checks if given value is a string. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
--- @param str string The expected value
--- @return string|nil res Returns the string if valid
function M.str(str)
	local res = assert(type(str) == "string", f("Incorrect type: (%s) is not a string", str))
	if res then
		return str
	end
end

--- Checks if given value is an integer. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
--- @param int number The expected value
--- @return number|nil res Returns the integer if valid
function M.int(int)
	local res = assert(type(int) == "number" and int % 1 == 0, f("Incorrect type: (%s) is not an integer", int))
	if res then
		return int
	end
end

--- Checks if given value is a float. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
--- @param float number The expected value
--- @return number|nil res Returns the float if valid
function M.float(float)
	local res = assert(type(float) == "number" and float % 1 ~= 0, f("Incorrect type: (%s) is not a float", float))
	if res then
		return float
	end
end

--- Checks if given value is a boolean. If so, returns it,
--- else it'll throw an error.
--- This boolean doesn't do implicit type coercion.
--- @param bool boolean The expected value
--- @return boolean|nil res Returns the boolean if valid
function M.bool(bool)
	local res = assert(type(bool) == "boolean", f("Incorrect type: (%s) is not a boolean", bool))
	if res then
		return bool
	end
end

--- Checks if given value is a table. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
--- @param tbl table The expected value
--- @return table|nil res Returns the table if valid
function M.tbl(tbl)
	local res = assert(type(tbl) == "table", f("Incorrect type: (%s) is not a table", tbl))
	if res then
		return tbl
	end
end

--- Checks if given value is a function. If so, returns it,
--- else it'll throw an error.
--- This function doesn't do implicit type coercion.
--- @param fun function The expected value
--- @return function|nil res Returns the function if valid
function M.fun(fun)
	local res = assert(type(fun) == "function", f("Incorrect type: (%s) is not a function", fun))
	if res then
		return fun
	end
end

--- Checks if given value is a thread. If so, returns it,
--- else it'll throw an error.
--- This thread doesn't do implicit type coercion.
--- @param thread thread The expected value
--- @return thread|nil res Returns the thread if valid
function M.thread(thread)
	local res = assert(type(thread) == "thread", f("Incorrect type: (%s) is not a thread", thread))
	if res then
		return thread
	end
end

--- Checks if given object has the specified fields.
--- If so, returns it, else it'll throw an error.
--- This thread doesn't do implicit type coercion.
---
--- To define a struct, create a table with named fields, and define
--- the value for each field as a string with the name of the desired
--- type, e.g.: `struct = { name = "string", age = "number" }`
--- @param obj table The expected value
--- @return table|nil res Returns the object if valid
function M.obj(obj, struct)
	local res = false
	for k, v in pairs(obj) do
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
		return obj
	end
end

return M
