set nohlsearch

map <F6> :tabe<Space>
map <F7> :tabp<CR>
map <F8> :tabn<CR>

nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" Conceal
hi! clear Conceal
set conceallevel=2

set number relativenumber

" Disable status-bar
set laststatus=0
highlight LineNr ctermfg=grey
highlight NonText ctermfg=0

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

" Easy commenting`
Plug 'preservim/nerdcommenter'

" Latex setup
Plug 'lervag/vimtex', {'for': 'tex', 'tag': 'v1.6'}
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

let g:tex_conceal_frac=1
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9,+-/().]"

" Rust setup
Plug 'neoclide/coc.nvim', {'for': 'rust', 'branch': 'release'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
let g:rustfmt_autosave = 1

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


"colorscheme monokai
"let g:tokyonight_transparent_background = 1
colorscheme tokyonight
"colorscheme cosmic_latte

