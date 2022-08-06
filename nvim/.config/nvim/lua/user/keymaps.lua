-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local silent = { silent = true }

-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Close current buffer
vim.keymap.set("n", "<c-d>", "<cmd>Bdelete<cr>", silent)

-- Show open buffers
vim.keymap.set("n", "=", "<cmd>Telescope buffers<cr>", silent)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", silent)
vim.keymap.set("n", "<C-j>", "<C-w>j", silent)
vim.keymap.set("n", "<C-k>", "<C-w>k", silent)
vim.keymap.set("n", "<C-l>", "<C-w>l", silent)

-- Resize
vim.keymap.set({ "n", "t" }, "<A-j>", "<cmd>resize -2<CR>", silent)
vim.keymap.set({ "n", "t" }, "<A-k>", "<cmd>resize +2<CR>", silent)
vim.keymap.set({ "n", "t" }, "<A-h>", "<cmd>vertical resize -2<CR>", silent)
vim.keymap.set({ "n", "t" }, "<A-l>", "<cmd>vertical resize +2<CR>", silent)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", silent)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", silent)

-- Map ; to :
vim.keymap.set({ "n", "x" }, ";", ":")

-- Disaple search highlinting with <Esc>
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>", silent)

-- Stay in indent mode
vim.keymap.set("x", "<", "<gv", silent)
vim.keymap.set("x", ">", ">gv", silent)

-- LSP sepecific keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("InitLspKeymaps", {}),
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<A-{>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.keymap.set("n", "<A-}>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

    local lines_ok, lsp_lines = pcall(require, "lsp_lines")
    if lines_ok then
      vim.keymap.set("n", "gl", lsp_lines.toggle, opts)
    else
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    end
  end,
})
