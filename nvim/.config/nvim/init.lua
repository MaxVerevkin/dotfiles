-- Improve startup time
local _, _ = pcall(require, "impatient")

-- Load all the plugins and options
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.telescope"
require "user.lsp"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
