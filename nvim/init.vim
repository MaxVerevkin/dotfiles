set nohlsearch

set tabstop=4
set shiftwidth=4
set expandtab

map <C-s> :tabp<CR>
map <C-h> :tabn<CR>
map <C-t> :tabe<Space>
map gd :call CocAction('jumpDefinition', 'tab drop')<CR>

nmap <leader>ac <Plug>(coc-codeaction)

map  <leader>y  "+y
map  <leader>p  "+p
map  <leader>P  "+P

" Conceal
hi! clear Conceal
set conceallevel=2

set number relativenumber

" Disable status-bar
set laststatus=0
"highlight LineNr ctermfg=grey
"highlight NonText ctermfg=0

" Disable arrows, eable mouse
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
set mouse=a


""""""""""""""""""""""""""""""""""""""""
""" <Plugins>
""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" Themes
Plug 'crusoexia/vim-monokai'
Plug 'nightsense/cosmic_latte'
Plug 'ghifarit53/tokyonight-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-scripts/colorizer'

" Easy commenting
Plug 'preservim/nerdcommenter'

" Latex setup
Plug 'lervag/vimtex', {'for': 'tex'}
let g:vimtex_mappings_enabled=0
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
map <leader>ll <plug>(vimtex-compile)

" Rust setup
Plug 'neoclide/coc.nvim', {'for': ['rust', 'tex', 'zig'], 'branch': 'release'}
Plug 'rust-lang/rust.vim', {'for': ['rust']}
let g:rustfmt_autosave = 1

Plug 'ziglang/zig.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""
""" </Plugins>
""""""""""""""""""""""""""""""""""""""""


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

runtime layout-ru.vim
runtime layout-workman.vim
runtime theme.vim
