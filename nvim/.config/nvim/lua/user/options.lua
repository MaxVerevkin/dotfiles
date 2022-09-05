local o = vim.opt

o.backup = false -- creates a backup file
o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.cmdheight = 1
o.completeopt = { "menuone", "noselect" } -- mostly just for cmp
o.showtabline = 0 -- always hide the tabline
o.conceallevel = 0 -- so that `` is visible in markdown files
o.fileencoding = "utf-8" -- the encoding written to a file
o.hlsearch = true -- highlight all matches on previous search pattern
o.ignorecase = true -- ignore case in search patterns
o.mouse = "a" -- allow the mouse to be used in neovim
o.pumheight = 10 -- pop up menu height
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.smartcase = true -- smart case
o.smartindent = true -- make indenting smarter again
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = false -- creates a swapfile
o.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile = true -- enable persistent undo
o.updatetime = 300 -- faster completion (4000ms default)
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
o.expandtab = true -- convert tabs to spaces
o.cursorline = true -- highlight the current line
o.number = true -- set numbered lines
o.relativenumber = false -- set relative numbered lines
o.numberwidth = 1 -- set number column width to 2 {default 4}
o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.wrap = false -- display lines as one long line
o.title = true -- display file name in the window title
o.guifont = "JetBrainsMono Nerd Font:h11" -- font for neovide

o.scrolloff = 8 -- is one of my fav
o.sidescrolloff = 8 -- this too

o.shiftwidth = 4 -- the number of spaces inserted for each indentation
o.tabstop = 4 -- insert 4 spaces for a tab

o.shortmess:append "c"
