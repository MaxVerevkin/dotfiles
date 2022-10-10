local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("MyAutocmds", {})

autocmd("VimResized", {
  group = group,
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

autocmd("FileType", {
  pattern = { "help", "tsplayground" },
  group = group,
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = args.buf })
  end,
})
