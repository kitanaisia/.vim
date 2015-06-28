"                                ___           ___           ___
"      ___                      /\  \         /\  \         /\__\
"     /\  \        ___         |::\  \       /::\  \       /:/  /
"     \:\  \      /\__\        |:|:\  \     /:/\:\__\     /:/  /
"      \:\  \    /:/__/      __|:|\:\  \   /:/ /:/  /    /:/  /  ___
"  ___  \:\__\  /::\  \     /::::|_\:\__\ /:/_/:/__/___ /:/__/  /\__\
" /\  \ |:|  |  \/\:\  \__  \:\~~\  \/__/ \:\/:::::/  / \:\  \ /:/  /
" \:\  \|:|  |   ~~\:\/\__\  \:\  \        \::/~~/~~~~   \:\  /:/  /
"  \:\__|:|__|      \::/  /   \:\  \        \:\~~\        \:\/:/  /
"   \::::/__/       /:/  /     \:\__\        \:\__\        \::/  /
"    ~~~~           \/__/       \/__/         \/__/         \/__/
"

set fileformat=unix
set fileformats=unix,dos

" Not to read $VIMRUNTIME/menu.vim
set guioptions+=M   

if has("win32")
    set runtimepath+=~/.vim,
endif

augroup MyAutoCmd
   autocmd!
augroup END

if has("autocmd")
  autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd        " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
"set autowrite      " Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
"set mouse=a        " Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"swpファイル，バックアップファイル作成ディレクトリ
set directory=~/.vim/temporary
set backupdir=~/.vim/temporary

if !has("win32")
    let g:Powerline_symbols='fancy'
endif
if !has("gui_running")
    set t_Co=256
endif

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" 自動改行しない
set textwidth=0
" 文字を右端で折りたたまない
set nowrap

" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide

"" クリップボードをwindowsと共有します。
"set clipboard=unnamed
if has("win32")
    set clipboard=unnamed,autoselect
elseif has("unix")
    set clipboard=unnamedplus,autoselect
endif

set cursorline

" 括弧入力時、自動的に括弧内にカーソルが行くように設定。
" cnoremap {} {}<Left>
" cnoremap [] []<Left>
" cnoremap () ()<Left>
" cnoremap <> <><Left>
" cnoremap $$ $$<Left>
" cnoremap "" ""<Left>
" cnoremap `` ``<Left>
" cnoremap '' ''<Left>

" 自動判別文字コード。
set fileencodings=iso-2022-jp3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,eucjp-ms,cp932
set encoding=utf-8

" 自動インデント
set autoindent
set smartindent

"タブとスペースの関係づけ
set expandtab
set tabstop=4
set shiftwidth=4

" 検索結果文字列のハイライトを有効にする。大文字小文字は基本無視し、大文字が含まれている場合のみ考慮する。
set hlsearch
" ステータスバーの常時表示
set laststatus=2
"行数表示
set number

" 物理行移動設定
nnoremap j gj
nnoremap k gk

"設定トグルのキーバインド
nnoremap , <Nop>
nnoremap <silent>,w :set invwrap<CR>
nnoremap <silent>,h :set invhlsearch<CR>

"ウィンドウ移動コマンド
nnoremap <Left> <C-w><
nnoremap <Down> <C-w>+
nnoremap <Up> <C-w>-
nnoremap <Right> <C-w>>
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M-p> gT
nnoremap <M-n> gt
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l
" Altキーを端末で使う
if has("unix") && !has("gui-running")
    nmap <ESC>h <M-h>
    nmap <ESC>j <M-j>
    nmap <ESC>k <M-k>
    nmap <ESC>l <M-l>
    nmap <ESC>n <M-n>
    nmap <ESC>p <M-p>
endif

"visualモードでどこにでもカーソルを動かせるように
set virtualedit+=block

"検索時，検索語を画面中央に
nnoremap n nzz
nnoremap N Nzz

"emacsライクなコマンドラインモード
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"全ビジュアルモードでA,Iによる挿入ができるようにする
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')

function! s:force_blockwise_visual(next_key)
  if mode() ==# 'v'
    return "\<C-v>" . a:next_key
  elseif mode() ==# 'V'
    return "\<C-v>0o$" . a:next_key
  else  " mode() ==# "\<C-v>"
    return a:next_key
  endif
endfunction

"Escの2回押しでハイライト消去
nmap <silent> <ESC><ESC> :nohlsearch<CR><ESC>

"バックスペースの動作
set backspace=indent,eol,start

"誤爆防止
inoremap <C-@> <C-[>

"挿入モードでの前後移動
inoremap <C-f> <Right>
inoremap <C-b> <Left>

"ノーマルモード以外からノーマルモードに移行する場合，即時に反映する
set notimeout
set ttimeout
set timeoutlen=10

"テンプレートファイル
autocmd MyAutoCmd BufNewFile *.rb 0r ~/.vim/templates/ruby_template.rb
autocmd MyAutoCmd BufNewFile *.tex 0r ~/.vim/templates/tex_template.tex
autocmd MyAutoCmd BufNewFile *.py 0r ~/.vim/templates/python_template.py

"tabnewのキーマップ
nnoremap gn :tabnew<CR>

"command-line window の設定
nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>

nmap :  <sid>(command-line-enter)
xmap :  <sid>(command-line-enter)

autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <silent><buffer> q :<C-u>quit<CR>
  nnoremap <silent><buffer> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  
  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  " smartchrの誤爆防止
  inoremap <buffer> / /
  inoremap <buffer> : :
  inoremap <buffer> - -
  inoremap <buffer> % %
  inoremap <buffer> = =
  inoremap <buffer> * *

  startinsert!
endfunction

if has("win32")
    cd ~
endif

" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright

autocmd MyAutoCmd filetype gitcommit setlocal fileencoding=utf-8

"===================NeoBundleの設定=====================
filetype off

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/.bundle/neobundle.vim
endif

if has('gui_running')
    let g:neobundle#cache_file = expand("~/.vim/.bundle/.neobundle/gvim.cache")
else
    let g:neobundle#cache_file = expand("~/.vim/.bundle/.neobundle/vim.cache")
endif

call neobundle#begin(expand('~/.vim/.bundle'))

"プラグイン管理用プラグイン
NeoBundleFetch 'Shougo/neobundle.vim'
if neobundle#load_cache()
    call neobundle#load_toml('~/.vim/neobundle.toml')
    call neobundle#load_toml('~/.vim/neobundlelazy.toml', {'lazy' : 1} )

    NeoBundleSaveCache
endif
call neobundle#end()

filetype plugin indent on
if has("syntax")
  syntax enable
endif
"==============================カラースキーマ用設定==============================
colorscheme landscape

if filereadable(expand("~/.vim/plugins.rc.vim"))
    source ~/.vim/plugins.rc.vim
endif
