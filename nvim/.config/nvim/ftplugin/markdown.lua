vim.opt_local.spell = true
vim.opt_local.wrap = true

vim.cmd [[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]]
