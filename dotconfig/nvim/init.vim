augroup MyAutoCmd
  autocmd!
augroup END

set number
set mouse=a
set clipboard+=unnamedplus
set expandtab
set autoindent
set smartindent
set cindent
set smartcase
set textwidth=0
set foldlevelstart=10

augroup MyAutoCmd
  " restore-cursor
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"zv" |
        \ endif
augroup END

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
highlight Whitespace cterm=NONE ctermfg=16 guifg=gray

" Keymaps {{{
let mapleader = "\<Space>"

nnoremap <silent> <M-Space> :simalt ~<CR>

" emacs-like keybind {{{
noremap! <C-a>  <Home>
noremap! <C-e>  <End>
noremap! <C-b>  <Left>
noremap! <C-f>  <Right>
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
noremap! <C-d>  <Del>
noremap! <M-b>  <C-Left>
noremap! <M-f>  <C-Right>
noremap! <M-d>  <Del>
" }}}

" edit {{{
nnoremap <leader>p "*p
nnoremap <leader>P "*P
nnoremap <leader>y "*y
nnoremap <leader>d "*d
vnoremap <leader>y "*y
vnoremap <leader>d "*d
nnoremap <A-v> $v^
inoremap <silent> jj <ESC>
" }}}

" tabs and windows {{{
nnoremap [tabwin] <Nop>
nmap     s [tabwin]
" tabpage changing
nnoremap          <C-TAB>       gt
nnoremap          <C-S-TAB>     gT
nnoremap          [tabwin]n     gt
nnoremap          [tabwin]p     gT
nnoremap <silent> [tabwin]t     :<C-u>tabnew<CR>
" tabpage moving
nnoremap <silent> [tabwin]N     :<C-u>tabmove +1<CR>
nnoremap <silent> [tabwin]P     :<C-u>tabmove -1<CR>
" kill buffer
nnoremap <silent> [tabwin]d     :<C-u>bd<CR>
nnoremap <silent> [tabwin]D     :<C-u>bd!<CR>
" }}}

" search {{{
nnoremap <leader>/ /\v
nnoremap <silent> <C-n> :nohlsearch<CR>
" }}}

" }}}
