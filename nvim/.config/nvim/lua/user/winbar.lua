if not vim.fn.has "nvim-0.8" then
  return
end

local ft_exclude = {
  "",
  "alpha",
  "help",
  "packer",
  "NvimTree",
  "TelescopePrompt",
  "toggleterm",
  "DressingInput",
  "JABSwindow",
}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = vim.api.nvim_create_augroup("winbar_init", {}),
  callback = function()
    if not vim.tbl_contains(ft_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = "%=%m %t "
    end
  end,
})
