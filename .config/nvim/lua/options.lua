require "nvchad.options"

-- add yours here!

local o = vim.o
o.cmdheight = 0  -- Remove gap below statusline
o.clipboard = "unnamedplus"  -- Use system clipboard by default
o.mouse = "a"  -- Enable mouse in all modes
o.exrc = true  -- Enable project-local config files
o.secure = true  -- Prevent malicious commands in local configs
-- o.cursorlineopt ='both' -- to enable cursorline!
