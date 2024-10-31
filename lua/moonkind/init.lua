local C = assert(require("lua.moonkind.utils.constants"))
package.path = C.luapath
package.cpath = C.cpath

local c = assert(require("lua.moonkind.core.type_checks"))
local t = assert(require("lua.moonkind.core.type_throws"))

return c, t
