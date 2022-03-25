-- general
lvim.log.level = "warn"
lvim.format_on_save = true
vim.o.guifont = "JetBrainsMono Nerd Font:h11"
vim.o.cursorline = false

-- colorscheme
lvim.colorscheme = "gruvbox"
vim.o.termguicolors = true
vim.g.gruvbox_sign_column = "bg0"

-- keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
vim.api.nvim_set_keymap('n', ';', ':', {})
vim.api.nvim_set_keymap('n', '<esc>', '<cmd>nohlsearch<cr>', { silent = false })

-- Terminals
vim.api.nvim_set_keymap("t", "<esc>", [[<C-\><C-n>]], { noremap = true })
lvim.builtin.terminal.execs = {
  { "python", "<leader>tp", "Python" },
  { "htop", "<leader>th", "HTop" },
}
lvim.builtin.terminal.on_config_done = function ()
  vim.api.nvim_del_keymap("t", "<leader>tp")
  vim.api.nvim_del_keymap("t", "<leader>th")
end

-- Whichkey mappings
lvim.builtin.which_key.setup.key_labels = { ["<space>"] = "SPC" }
lvim.builtin.which_key.mappings[" "] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", "Comment" }
lvim.builtin.which_key.vmappings[" "] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope prvojects<cr>", "Projects" }
lvim.builtin.which_key.mappings["/"] = nil
lvim.builtin.which_key.vmappings["/"] = nil
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["t"] = { name = "Terminal" }
lvim.builtin.which_key.mappings["l"]["t"] = { "<cmd>TroubleToggle<cr>", "Toggle"}
lvim.builtin.which_key.mappings["l"]["d"] = { "<cmd>Trouble document_diagnostics<cr>", "Buffer diagnostics"}
lvim.builtin.which_key.mappings["l"]["w"] = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics"}

-- LSP mapping
lvim.lsp.buffer_mappings.normal_mode["gd"][1] = "<cmd>Trouble lsp_definitions<cr>"
lvim.lsp.buffer_mappings.normal_mode["gr"][1] = "<cmd>Trouble lsp_references<cr>"

-- Diagnostics
lvim.builtin.cmp.confirm_opts = { select = false }
lvim.builtin.cmp.experimental.ghost_text = false
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.diagnostics.underline = false

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.bufferline.options.diagnostics = false
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" } -- ?
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  {
    "ellisonleao/gruvbox.nvim",
    disable = lvim.colorscheme ~= "gruvbox",
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        auto_fold = true,
        use_diagnostic_signs = true,
        position = "right",
      }
    end
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
