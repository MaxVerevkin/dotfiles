local silent = { silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.keymap.set("n", "<c-d>", "<cmd>Bdelete<cr>", silent)
vim.keymap.set("n", "=", "<cmd>JABSOpen<cr>", silent)

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

-- Pasting w/o yanking
vim.keymap.set("x", "p", '"_dP', silent)

-- Changing w/o yanking
vim.keymap.set("x", "c", '"_di', silent)
vim.keymap.set("n", "C", '"_Da', silent)
vim.keymap.set("n", "cc", '0"_Di', silent)
