-- Automatically install packerplug
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  group = vim.api.nvim_create_augroup("Packer", {}),
  command = "source <afile> | PackerCompile",
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "moll/vim-bbye"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim" -- a popup with possible keybindings
  use "stevearc/dressing.nvim" -- Improve the default vim.ui interfaces
  use "phaazon/hop.nvim" -- Neovim motions on speed!

  use "nvim-lualine/lualine.nvim" -- Status line

  -- Colorschemes
  use "~/nvim-plugin-dev/gruvbox.nvim"
  use "LunarVim/synthwave84.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lua" -- completions for nvim's lua API
  use "hrsh7th/cmp-nvim-lsp" -- LSP

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "williamboman/mason.nvim" -- LSP and DAP package manager
  use "williamboman/mason-lspconfig.nvim" -- Mason lspconfig integration
  use "lvimuser/lsp-inlayhints.nvim" -- Inlay hints
  use {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      local ok, lines = pcall(require, "lsp_lines")
      if ok then
        lines.setup()
      end
    end,
  }

  -- DAP
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/playground"
  use "SmiteshP/nvim-gps"

  -- Git
  use "lewis6991/gitsigns.nvim"

  use {
    "j-hui/fidget.nvim",
    config = function()
      local ok, fidget = pcall(require, "fidget")
      if ok then
        fidget.setup()
      end
    end,
  }

  -- Rust
  use "saecki/crates.nvim" -- for Crargo.toml

  -- Markdown
  use "davidgranstrom/nvim-markdown-preview"

  -- Why not
  use "seandewar/nvimesweeper"
end)
