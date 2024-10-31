local C = assert(require("moonkind.utils.constants"))
package.path = C.luapath
package.cpath = C.cpath

local M = {}

M.checks = assert(require("moonkind.checks"))
M.throws = assert(require("moonkind.throws"))

return M
