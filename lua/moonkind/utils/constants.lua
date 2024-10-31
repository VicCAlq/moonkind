local M = {}

M.version = _VERSION:match("%d+%.%d+")
M.path_full = string.gsub(assert(io.popen("pwd", "r")):read("*a"), "\n", "")

M.luapath = string.format(
  [[%s/modules/share/lua/%s/?/?.lua;%s/modules/share/lua/%s/?/init.lua;%s/modules/share/lua/%s/?.lua;%s]],
  M.path_full,
  M.version,
  M.path_full,
  M.version,
  M.path_full,
  M.version,
  package.path
)

M.cpath = string.format(
  [[%s/modules/lib/lua/%s/?.so;%s/modules/lib/lua/%s/?/?.so;%s]],
  M.path_full,
  M.version,
  M.path_full,
  M.version,
  package.cpath
)

return M
