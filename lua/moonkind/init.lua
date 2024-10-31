local C = assert(require("moonkind.utils.constants"))
package.path = C.luapath
package.cpath = C.cpath

local M = {}

M.c = assert(require("moonkind.checks"))
M.t = assert(require("moonkind.throws"))

return M
