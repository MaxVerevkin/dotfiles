set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Use system clipboard
" set clipboard+=unnamedplus

" Tabs-Spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Do not highlight search
set nohlsearch

":au VimLeave * set guicursor=a:block-blinkon0
