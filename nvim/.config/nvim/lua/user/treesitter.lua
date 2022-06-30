local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  sync_install = false,
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml", "rust" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
