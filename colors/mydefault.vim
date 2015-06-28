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

" �w�i�F�A�����F�̐ݒ�
hi Normal ctermfg=white guifg=white guibg=black

" �h���b�O�̃o�b�N�O���E���h�F��windows vista�V�X�e���J���[(#3399FF)�ɁB�h���b�O�̕����F�𔒂ɁB
hi visual ctermfg=white ctermbg=cyan guifg=white guibg=cyan

" �J�[�\���F���܂��A�h���b�O���Ɠ������̂Ƃ���B
hi Cursor ctermfg=white ctermbg=cyan guibg=white guibg=cyan

" �R�����g���̐F�̕ύX�Bvisual C++ �� octave��Notepad++�Ɠ����F��(#008000)->(#00A500)�B
highlight  Comment ctermfg=green guifg=#60ff60
"highlight Comment ctermfg=darkcyan guifg=#80a0ff

" ���ʑΉ��̋����\��:���w�i�̐ԐF���ʁB
hi MatchParen term=standout ctermbg=black ctermfg=red  guibg=Black guifg=Red

" statement�̐F�͐F�ɁB
hi Statement ctermfg=darkcyan guifg=#80a0ff

" �֐��錾�̐F��statement���l�F�B(�f�t�H���g�Ő��F)
hi Function ctermfg=darkcyan guifg=#80a0ff

" �C���N���[�h���Ƃ����ς��炵�����ǁA���͕s�v���Ǝv���B
"hi PreProc guifg=#ff80ff

" �萔�̐F��Octave��Notepad++����Ƃ���(#ff8000)�B->��߂܂���
highlight Constant ctermfg=Magenta guifg=Magenta

" �s�ԍ���\������Ƃ��A�w�i���F�Ƃ���B
hi LineNr ctermfg=Yellow guifg=Yellow 

" �X�e�[�^�X���C���̐F�͔��n�ɗ΂���Ƃ���B
"highlight StatusLine ctermfg=white ctermbg=green guifg=white guibg=green

" �����n�C���C�g�̐F�����w�i�̐ԕ����Ƃ���B
highlight search ctermfg=darkred ctermbg=yellow guifg=darkred guibg=yellow

" �C���N�������^���T�[�`�̐F
hi Incsearch  ctermfg=black ctermbg=yellow guifg=black guibg=darkred

" �⊮����Ƃ��̐F
hi Pmenu ctermfg=black ctermbg=white guifg=black guibg=white
hi PmenuSel ctermfg=black ctermbg=Magenta guifg=Black guibg=Magenta

" �܂肽���݂̐ݒ�
hi Folded ctermfg=white ctermbg=DarkBlue guifg=White guibg=DarkBlue

"�^�u�y�[�W�̍s�́A�A�N�e�B�u�łȂ��^�u�y�[�W�̃��x��
hi TabLine		ctermfg=black ctermbg=gray guifg=black guibg=gray
"�^�u�y�[�W�̍s�́A���x�����Ȃ�����
hi TabLineFill	ctermfg=cyan ctermbg=cyan guifg=cyan guibg=cyan
"�^�u�y�[�W�̍s�́A�A�N�e�B�u�ȃ^�u�y�[�W�̃��x��
hi TabLineSel	ctermfg=cyan ctermbg=black guifg=cyan guibg=black

"hi NonText		guifg=magenta	ctermfg=lightMagenta
hi identifier	guifg=#00A4A4
hi type		guifg=#60ff60
"hi special		guifg=magenta	ctermfg=lightMagenta	ctermbg=darkBlue
"hi Underlined	guifg=cyan		ctermfg=cyan	gui=underline	cterm=underline
"hi label		guifg=yellow	ctermfg=yellow
"hi operator		guifg=orange	gui=bold	ctermfg=lightRed	ctermbg=darkBlue
" vim: sw=2
