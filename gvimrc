"Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" You can also specify a different font, overriding the default font
"if has('gui_gtk2')
"  set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
"else
"  set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
"endif

" If you want to run gvim with a dark background, try using a different
" colorscheme or running 'gvim -reverse'.
" http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/ has examples and
" downloads for the colorschemes on vim.org

" Source a global configuration file if available
if filereadable("/etc/vim/gvimrc.local")
  source /etc/vim/gvimrc.local
endif

colorscheme landscape
"colorscheme mydefault
"==================================================
" powerline.vim
" window版で，kaoriyaのgvimrcの設定が邪魔をするかもしれない
" ex) set ambiwidth=auto
" それはコメントアウトとかすること．
"==================================================
gui
set guioptions=
if has("win32")
 	autocmd MyAutoCmd GUIEnter * simalt ~x
 	set transparency=200
	" フォントサイズはお好みで
	set guifont=Ricty\ Diminished:h14
	" こっちは日本語フォント
	set guifontwide=Ricty\ Diminished:h14
	" `fancy' テーマに切り替え
	" let g:Powerline_symbols = 'fancy'
	set t_co=256
" set iminsert=0
" set imsearch=-1
else
	set guifont=RictyDiminished\ 14
    "set guifontwide=Ricty_for_Powerline\ 12
    set guifontwide=RictyDiminished\ 14
end

" 引数無し起動時にホームディレクトリで起動
autocmd MyAutoCmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | cd ~/ | endif
function! s:GetBufByte()
    let byte = line2byte(line('$') + 1)
    if byte == -1
        return 0
    else
        return byte - 1
    endif
endfunction
