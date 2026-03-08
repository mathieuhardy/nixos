--------------------------------------------------------------------------------
-- Load default use configuration files
--------------------------------------------------------------------------------

function table_merge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        table_merge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

vim.cmd("luafile " .. vim.fn.stdpath("config") .. "/lua/config/defaults.lua")
vim.cmd("silent! luafile " .. vim.fn.stdpath("config") .. "/config.lua")

if not opts then
  opts = {}
end

global_opts = table_merge(default_opts, opts)

--------------------------------------------------------------------------------
-- Leader
--------------------------------------------------------------------------------

vim.g.mapleader = global_opts.leader
vim.g.maplocalleader = global_opts.leader

--------------------------------------------------------------------------------
-- Load configs
--------------------------------------------------------------------------------

require("helpers")
require("config")
