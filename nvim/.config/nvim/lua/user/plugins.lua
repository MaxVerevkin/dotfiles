-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  group = vim.api.nvim_create_augroup("Packer", { clear = true }),
  command = "source <afile> | PackerSync",
})

if PACKER_BOOTSTRAP then
  vim.notify "hello???"
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "it-works",
  display = {
    open_fn = function()
      return require("packer.util").float { border = "none" }
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
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight (#12587)
  use "folke/which-key.nvim" -- a popup with possible keybindings
  use "stevearc/dressing.nvim" -- Improve the default vim.ui interfaces
  use "matbme/JABS.nvim" -- Just Another Buffer Switcher for Neovim

  -- use "phaazon/hop.nvim"
  use { "ChristianChiarulli/hop.nvim", branch = "fix-pending-operation-col-increment" }

  use "nvim-lualine/lualine.nvim" -- Status line

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A set of themes with excelent plugin support
  use { "ellisonleao/gruvbox.nvim" } -- My fav theme
  -- use { "ellisonleao/gruvbox.nvim", commit = "3352c12c083d0ab6285a9738b7679e24e7602411" } -- My fav theme
  -- use "alex-popov-tech/timer.nvim" -- For automatic theme switching
  use "lunarvim/darkplus.nvim"

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
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "ray-x/lsp_signature.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/playground"

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
  use {
    "saecki/crates.nvim",
    tag = "v0.2.0",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  }
  use "simrat39/rust-tools.nvim"
  -- use "Avimitin/rust-tools.nvim"

  use "seandewar/nvimesweeper"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
