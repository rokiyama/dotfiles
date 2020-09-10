" vim: set foldmethod=marker :
set encoding=utf-8
scriptencoding utf-8

" Initialize {{{
if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END
" }}}

" dein.vim configure {{{
let s:deindir = '~/.cache/dein'
if isdirectory(expand(s:deindir))
  let &runtimepath = &runtimepath . ',' . s:deindir . '/repos/github.com/Shougo/dein.vim'

  if dein#load_state(s:deindir)
    call dein#begin(s:deindir)

    call dein#load_toml('~/.config/nvim/dein.toml')
    call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy' : 1})

    call dein#end()
    call dein#save_state()

    if dein#check_install()
      call dein#install()
    endif
  endif
else
  echoerr 'dein is not installed'
endif

filetype plugin indent on
syntax enable
" }}}

" General settings {{{
set mouse=a

" タブ・インデント設定
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set cindent

" 検索
set ignorecase
set smartcase
set incsearch
set hlsearch

set visualbell
set t_vb = ""

" 自動改行しない
set textwidth=0

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

set swapfile
set directory=~/.local/share/nvim/swap

set backup
set backupdir=/tmp

set undofile
set undodir=~/.local/share/nvim/undo

if executable('grep')
  set grepprg=grep\ -n
endif

augroup MyAutoCmd
  " restore-cursor
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
" }}}

" Appearance {{{
set background=dark

" 対応する括弧を強調
set showmatch

" カーソル行を強調表示
autocmd MyAutoCmd BufEnter * set cursorline
" highlight CursorLine cterm=NONE ctermbg=brown guibg=brown

set number
set laststatus=2
set showtabline=2

" 左端に折り畳みレベルを表示
let s:my_foldcolumn = 5
let &foldcolumn = s:my_foldcolumn

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
highlight Whitespace cterm=NONE ctermfg=16 guifg=gray

" 長い行を表示する
set display=truncate

set foldlevelstart=99

highlight Visual term=reverse cterm=reverse guibg=Grey
" }}}

" Keymaps {{{
let mapleader = "\<Space>"

nnoremap <silent> <M-Space> :simalt ~<CR>

" exchange colon/semicolon
" nnoremap : ;
" nnoremap ; :
" vnoremap : ;
" vnoremap ; :

" emacs-like keybind {{{
" noremap! <C-a>  <Home>
" noremap! <C-e>  <End>
" noremap! <C-b>  <Left>
" noremap! <C-f>  <Right>
" noremap! <C-d>  <Del>
" noremap! <M-b>  <C-Left>
" noremap! <M-f>  <C-Right>
" noremap! <M-d>  <Del>
" noremap! <C-g>  <Esc>
" cnoremap <C-p>  <Up>
" cnoremap <C-n>  <Down>
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
inoremap <silent> っj <ESC>
inoremap <silent> ｊｊ <ESC>
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

" Commands {{{

" relativenumber をトグルする
function! s:RelativeToggle()
  if &relativenumber
    setlocal norelativenumber
  else
    setlocal relativenumber
  endif
endfunction
command! -nargs=0 RelativeToggle :call s:RelativeToggle()

" virtualedit をトグルする
function! s:VeditToggle()
  if &virtualedit ==? 'all'
    setlocal virtualedit=
  else
    setlocal virtualedit=all
  endif
endfunction
command! -nargs=0 VeditToggle :call s:VeditToggle()

" tab 幅を 2/4 でトグルする
function! s:TabWidthToggle()
  if &tabstop == 4
    setlocal tabstop=2 softtabstop=2 shiftwidth=2
  else
    setlocal tabstop=4 softtabstop=4 shiftwidth=4
  endif
endfunction
command! -nargs=0 TabWidthToggle :call s:TabWidthToggle()

" 日付を挿入する
function! s:InsertDateTime()
  execute 'normal i' . strftime("%Y-%m-%d %H:%M:%S")
endfunction
command! -nargs=0 InsertDateTime :call s:InsertDateTime()

" Excel 表 (TAB 区切り) を markdown テーブル風に
function! s:ExcelToMarkdownTable() range
  silent execute 'keepjumps' a:firstline ',' a:lastline 's/\t/ \| /g'
  silent execute 'keepjumps' a:firstline ',' a:lastline 's/^/\| /g'
  silent execute 'keepjumps' a:firstline ',' a:lastline 's/$/ \|/g'
  silent execute 'keepjumps' a:firstline ',' a:lastline 'EasyAlign *|'
endfunction
command! -nargs=0 -range ExcelToMarkdownTable <line1>,<line2>call s:ExcelToMarkdownTable()

" jq
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
  setf json
endfunction
command! -nargs=? Jq call s:Jq(<f-args>)

" 行番号、折り畳み表示をトグル
function! s:NumberAndFoldcolumnToggle()
  if &number == 1 && &foldcolumn > 0
    set nonumber
    set foldcolumn=0
  else
    set number
    let &foldcolumn = s:my_foldcolumn
  endif
endfunction
command! -nargs=0 NumberAndFoldcolumnToggle :call s:NumberAndFoldcolumnToggle()

" }}}

if has('gui_running') || exists("g:gui_oni") " {{{
  " source all lazy plugins
  call dein#source()
endif " }}}
