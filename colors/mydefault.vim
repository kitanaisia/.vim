" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mydefault"

" 背景色、文字色の設定
hi Normal ctermfg=white guifg=white guibg=black

" ドラッグのバックグラウンド色をwindows vistaシステムカラー(#3399FF)に。ドラッグの文字色を白に。
hi visual ctermfg=white ctermbg=cyan guifg=white guibg=cyan

" カーソル色もまた、ドラッグ中と同じものとする。
hi Cursor ctermfg=white ctermbg=cyan guibg=white guibg=cyan

" コメント文の色の変更。visual C++ や octaveのNotepad++と同じ色に(#008000)->(#00A500)。
highlight  Comment ctermfg=green guifg=#60ff60
"highlight Comment ctermfg=darkcyan guifg=#80a0ff

" 括弧対応の強調表示:黒背景の赤色括弧。
hi MatchParen term=standout ctermbg=black ctermfg=red  guibg=Black guifg=Red

" statementの色は青色に。
hi Statement ctermfg=darkcyan guifg=#80a0ff

" 関数宣言の色もstatement同様青色。(デフォルトで水色)
hi Function ctermfg=darkcyan guifg=#80a0ff

" インクルード文とかが変わるらしいけど、今は不要だと思う。
"hi PreProc guifg=#ff80ff

" 定数の色はOctaveのNotepad++を基準とする(#ff8000)。->やめました
highlight Constant ctermfg=Magenta guifg=Magenta

" 行番号を表示するとき、背景黒色とする。
hi LineNr ctermfg=Yellow guifg=Yellow 

" ステータスラインの色は白地に緑を基調とする。
"highlight StatusLine ctermfg=white ctermbg=green guifg=white guibg=green

" 検索ハイライトの色を黒背景の赤文字とする。
highlight search ctermfg=darkred ctermbg=yellow guifg=darkred guibg=yellow

" インクリメンタルサーチの色
hi Incsearch  ctermfg=black ctermbg=yellow guifg=black guibg=darkred

" 補完するときの色
hi Pmenu ctermfg=black ctermbg=white guifg=black guibg=white
hi PmenuSel ctermfg=black ctermbg=Magenta guifg=Black guibg=Magenta

" 折りたたみの設定
hi Folded ctermfg=white ctermbg=DarkBlue guifg=White guibg=DarkBlue

"タブページの行の、アクティブでないタブページのラベル
hi TabLine		ctermfg=black ctermbg=gray guifg=black guibg=gray
"タブページの行の、ラベルがない部分
hi TabLineFill	ctermfg=cyan ctermbg=cyan guifg=cyan guibg=cyan
"タブページの行の、アクティブなタブページのラベル
hi TabLineSel	ctermfg=cyan ctermbg=black guifg=cyan guibg=black

"hi NonText		guifg=magenta	ctermfg=lightMagenta
hi identifier	guifg=#00A4A4
hi type		guifg=#60ff60
"hi special		guifg=magenta	ctermfg=lightMagenta	ctermbg=darkBlue
"hi Underlined	guifg=cyan		ctermfg=cyan	gui=underline	cterm=underline
"hi label		guifg=yellow	ctermfg=yellow
"hi operator		guifg=orange	gui=bold	ctermfg=lightRed	ctermbg=darkBlue
" vim: sw=2
