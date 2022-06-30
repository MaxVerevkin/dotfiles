local opts = { noremap = true, silent = true }
local silent = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

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
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Map ; to :
vim.keymap.set({ "n", "x" }, ";", ":")

-- Disaple search highlinting with <Esc>
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>", silent)

-- Visual --
-- Stay in indent mode
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

-- Pasting w/o yanking
keymap("x", "p", '"_dP', opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
