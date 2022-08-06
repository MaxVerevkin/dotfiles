local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("MyAutocmds", {})

vim.cmd [[
  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

autocmd("BufEnter", {
  group = group,
  callback = function()
    -- never show tabs
    -- I dont know why this has to be here instead of options.lua
    vim.o.showtabline = 0
  end,
})

autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo" },
  group = group,
  callback = function()
    vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = 0 })
  end,
})
