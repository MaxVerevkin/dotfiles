local autocmd = vim.api.nvim_create_autocmd

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

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function()
    vim.cmd [[nnoremap <silent> <buffer> q :close<CR>]]
  end,
})

autocmd("BufWritePre", {
  callback = vim.lsp.buf.formatting_sync,
})
