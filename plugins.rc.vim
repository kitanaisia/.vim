if has("lua")
    let s:bundle = neobundle#get("neocomplete.vim")

    function! s:bundle.hooks.on_source(bundle)
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#enable_auto_delimiter = 1
        "
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'
        
        "C#用
        let g:clang_complete_auto = 0
        let g:clang_auto_select = 0
        let g:clang_use_library = 1
        
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
        endif
        " let g:neocomplete#force_omni_input_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'

        " if has("unix")
        "     autocmd MyAutoCmd FileType cs setlocal omnifunc=OmniSharp#Complete
        " endif
        
        imap <expr><C-k> neosnippet#expandable_or_jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<C-y>"
        smap <expr><C-k> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-k>"
        xmap <expr><C-k>     <Plug>(neosnippet_expand_target)
        
        "tabで補完候補の選択を行う
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
        " ポップアップキャンセル
        inoremap <expr><C-e> neocomplete#cancel_popup() 
        "<C-g>で補完を元に戻す
        inoremap <expr><C-g> neocomplete#undo_completion()
        "<C-l>で補完候補の共通部分のみを補完する
        inoremap <expr><C-l> neocomplete#complete_common_string()
        
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplete#close_popup()
        inoremap <expr><C-e>  neocomplete#cancel_popup()
    endfunction
    unlet s:bundle
endif

"==============================neosnippetの設定==============================
let s:bundle = neobundle#get("neosnippet.vim")
function! s:bundle.hooks.on_source(bundle)
    set completeopt-=preview
    let g:neosnippet#snippets_directory=$HOME."/.vim/snippet/"
endfunction
unlet s:bundle
"==============================unite.vimの設定==============================
"マッピング
" nnoremap <silent> sh :Unite -buffer-name=files file_mru<CR>
nnoremap <silent> sd :Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <silent> so :Unite outline -winwidth=30<CR>
nnoremap <silent> sb :Unite bookmark -default-action=rec/async <CR>
nnoremap <silent> sy :Unite register<CR>
nnoremap <silent> ss :Unite source<CR>
nnoremap <silent> sm :Unite mapping -start-insert<CR>
nnoremap <silent> sj :Unite junkfile/new junkfile -auto-preview -no-split<CR>
nnoremap <expr><silent> s/  <SID>smart_search_expr(
      \ "/", 
      \ ":\<C-u>Unite -buffer-name=search -start-insert -no-split line\<CR>")
nnoremap <silent><expr> s* <SID>smart_search_expr(
      \ ":\<C-u>UniteWithCursorWord -buffer-name=search line/fast\<CR>",
      \ ":\<C-u>UniteWithCursorWord -buffer-name=search line\<CR>")
nnoremap <silent> su :UniteResume<CR>

" 変数設定
let s:bundle = neobundle#get("unite.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:unite_enable_start_insert = 0
    let g:unite_source_file_mru_filename_format=""
    let g:unite_source_rec_max_cache_files=5000

    function! s:smart_search_expr(expr1, expr2)
      return line('$') > 50000 ?  a:expr1 : a:expr2
    endfunction

    let s:unite_action_rec = {}

    function! s:unite_action_rec.func(candidate)
      call unite#start([['file_rec/async', a:candidate.action__path]])
    endfunction

    call unite#custom_action('directory', 'rec/async', s:unite_action_rec)
    unlet! s:unite_action_rec
endfunction
unlet s:bundle

"=============================projectlocal.vimの設定===============================
" nnoremap <silent> sr  :<C-u>call Unite_project_files()<CR>
" function! Unite_project_files()
"     if exists('b:projectlocal_root_dir')
"         if has("win32")
"             execute ':Unite -buffer-name=files file_rec:' . b:projectlocal_root_dir . ' file/new'
"         else
"             execute ':Unite -buffer-name=files file_rec/async:' . b:projectlocal_root_dir . ' file/new'
"         endif
"     else
"         if has("win32")
"             execute ':Unite -buffer-name=files file_rec file/new'
"         else
"             execute ':Unite -buffer-name=files file_rec/async file/new'
"         endif
"     endif
" endfunction
" 
" let g:projectlocal#default_filetypes = []

"==============================vimfiler用設定===============================
nnoremap <silent><expr>sf expand("%") =~ "^ssh://.*$" ?
            \":leftabove 30vs %:h/<CR>" : ":VimFilerBufferDir -buffer-name=explorer -split -winwidth=30 -toggle -no-quit -simple<Cr>"
"nnoremap sf VimFilerBufferDir -buffer-name=explorer -split -winwidth=30 -toggle -no-quit -simple<Cr>
nnoremap <silent><expr><Leader>f expand("%") =~ "^ssh://.*$" ? 
            \                                       ":e %:h/<CR>" : ":VimFilerBufferDir -buffer-name=explorer <Cr>"

let s:bundle = neobundle#get("vimfiler")
function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_safe_mode_by_default=0
    let g:vimfiler_as_default_explorer=1
    let g:vimfiler_enable_auto_cd=1

    autocmd MyAutoCmd FileType vimfiler call g:My_vimfiler_settings()
    function! g:My_vimfiler_settings()
        nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_smart_l)", "\<Plug>(vimfiler_edit_file)")
        " unmap <buffer> -
    endfunction
endfunction
unlet s:bundle


"==============================vimshell用設定==============================
nnoremap <expr>sv expand("%") =~ "^ssh://.*$" ? 
\                               ":20sp<CR>:e %:h/<CR>" : ":VimShellPop<CR>"
nnoremap <expr><Leader>v expand("%") =~ "^ssh://.*$" ? 
\                               ":e %:h/<CR>" : ":VimShell<CR>"
autocmd MyAutoCmd FileType vimshell,int-* call s:vimshell_settings()
function! s:vimshell_settings()
    nnoremap <buffer><C-p> gT
    nnoremap <buffer><C-n> gt
    inoremap <buffer><expr><silent><C-l> unite#sources#vimshell_history#start_complete(0)
    imap <buffer><C-k> <Plug>(neosnippet_expand_or_jump)
"    imap <buffer><expr><C-h> pumvisible() ? neocomplete#smart_close_popup()."\<C-h>" : "<Plug>(vimshell_delete_backward_char)"
"    imap <buffer><expr><BS> pumvisible() ? neocomplete#smart_close_popup()."\<C-h>" : "<Plug>(vimshell_delete_backward_char)"
"    vimshell上で{, }が重たかったり，エラー吐くので，NOPに
    inoremap <buffer>{ <NOP>
    inoremap <buffer>{ <NOP>
endfunction

if neobundle#tap('vimshell-pure.vim')
  call neobundle#config({
        \   'autoload' : {
        \     'on_source' : [ 'vimshell.vim' ]
        \   }
        \ })
  call neobundle#untap()
endif

let s:bundle = neobundle#get("vimshell.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:vimshell_prompt = '% '
    let g:vimshell_right_prompt = 'fnamemodify(getcwd(), ":~")'
    let g:vimshell_split_command = 'tabnew' 
    " let g:vimshell_split_command = '' 
    let g:vimshell_ignore_case = 1
    let g:vimshell_smart_case = 1
    let g:vimshell_external_history_path = expand("~/.histfile")
    let g:vimshell_interactive_update_time = 1

    call unite#custom_default_action("vimshell/history", "insert")
endfunction

unlet s:bundle
"==========quickrunの設定==========
"強制終了のマップ
autocmd MyAutoCmd FileType quickrun nnoremap <buffer><expr><C-c> quickrun#sweep_sessions()  

let s:bundle = neobundle#get("vim-quickrun")
" function! s:bundle.hooks.on_source(bundle)
function! s:bundle.hooks.on_post_source(bundle)
    "横分割，高さは10行分とする.さらにvimprocによる非同期実行を設定
    let g:quickrun_config = { 
    \ '*' : {'split': '10split',
    \   'runner' : 'vimproc',
    \   'runner/vimproc/updatetime' : 60,
    \   'runmode': 'async:remote:vimproc'
    \ }
    \}
    let g:quickrun_config['r'] = {'command' : 'R', 'cmdopt' : '--no-save --no-restore --slave', 'exec' : ['%c %o < %S']}
    let g:quickrun_config['html'] = { 'command' : 'google-chrome', 'exec' : '%c %s' }
    if has('unix')
        let g:quickrun_config['tex'] = {'command' : 'mkpdf.sh', 'exec': ['%c %s']}
    elseif has("win32")
        let g:quickrun_config['tex'] = {'command' : 'mkpdf.bat', 'exec': ['%c %s']}
    endif
endfunction
unlet s:bundle

"==========surround.vimの設定==========
let s:bundle = neobundle#get("surround.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:surround_{char2nr("(")} = "(\r)"
    let g:surround_{char2nr("{")} = "{\r}"
    let g:surround_no_mappings = 1
endfunction
unlet s:bundle

"modifiableがOnの時のみ， surroundの設定を有効にする．
autocmd MyAutoCmd FileType * call s:define_surround_keymappings()
function! s:define_surround_keymappings()
    if !&modifiable
        return
    endif

    nmap <buffer> ds <Plug>Dsurround
    nmap <buffer> cs <Plug>Csurround
    nmap <buffer> ys <Plug>Ysurround
    nmap <buffer> yS <Plug>YSurround
    nmap <buffer> yss <Plug>Yssurround
    nmap <buffer> ySs <Plug>YSsurround
    if !hasmapto("<Plug>VSurround","v")
        if exists(":xmap")
            xmap  S    <Plug>VSurround
        else
            vmap  S    <Plug>VSurround
        endif
    endif
    if exists(":xmap")
        xmap    gS   <Plug>VgSurround
    else
        vmap    gS   <Plug>VgSurround
    endif
    nmap <buffer> ySS <Plug>YSsurround
endfunction

"==========ref.vimの設定==========
let g:ref_refe_cmd = "~/install/ruby-refm-1.9.3-dynamic-20120829/refe-1_8_7"
"=============================smartchrの設定===============================
let s:bundle = neobundle#get("vim-smartchr")
function! s:bundle.hooks.on_source(bundle)
    augroup MyAutoCmd
        autocmd FileType vimshell,int-ssh
                    \| inoremap <buffer><expr> > smartchr#one_of(' > ', ' >> ', '>')
                    \| inoremap <buffer><expr> < smartchr#one_of(' < ', ' << ', '<')
        autocmd Filetype tex
                    \ inoremap <buffer><expr> , smartchr#one_of(', ', ',')
        autocmd Filetype r,int-R
                    \ inoremap <buffer><expr> = smartchr#one_of(' <- ', ' == ', '=')
                    \| inoremap <buffer><expr> , smartchr#one_of(', ', ',')
    augroup END
endfunction
unlet s:bundle


"==========smartinputの設定==========
let s:bundle = neobundle#get("vim-smartinput")
function! s:bundle.hooks.on_source(bundle)
    "ruby
    call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
    call smartinput#map_to_trigger('i', '#', '#', '#')
    call smartinput#define_rule({'at': '\({\|\<do\>\)\s*\%#', 'char': '<Bar>', 'input': '<Bar><Bar><Left>', 'filetype': ['ruby']})
    call smartinput#define_rule({'at': '|.*\%#.*|', 'char': '<Bar>', 'input': '<ESC>f<Bar>a', 'filetype': ['ruby']})
    call smartinput#define_rule({'at': '^[^#]*\%#', 'char': '#', 'input': '# ', 'filetype': ['ruby']})

    "tex
    " {, }}の設定は，neosnippetとの相性問題解決のため．
    call smartinput#map_to_trigger('i', '{', '{', '{')
    call smartinput#map_to_trigger('i', '}', '}', '}')
    call smartinput#map_to_trigger('i', '$', '$', '$')
    call smartinput#map_to_trigger('i', '%', '%', '%')
    call smartinput#define_rule({'at': '\%#', 'char': '{', 'input': '{', 'filetype': ['tex']})
    call smartinput#define_rule({'at': '\%#', 'char': '}', 'input': '}', 'filetype': ['tex']})
    call smartinput#define_rule({'at': '\%#', 'char': '$', 'input': '$$<Left>', 'filetype': ['tex']})
    call smartinput#define_rule({'at': '^[^%]*\%#', 'char': '%', 'input': '% ', 'filetype': ['tex']})
endfunction
unlet s:bundle
"=============================tabline の設定===============================
set showtabline=2

"=============================echodocの設定===============================
let g:echodoc_enable_at_startup=1
set cmdheight=2

"=============================vim-marchingの設定===============================
" オムニ補完時に補完ワードを挿入したくない場合
" imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

" if has("unix")
"     let s:bundle = neobundle#get("vim-marching")
"     function! s:bundle.hooks.on_source(bundle)
"         " clang コマンドの設定
"         let g:marching_clang_command = "clang"
"
"         " オプションを追加する場合
"         let g:marching_clang_command_option="-std=c++1y"
"
"         " インクルードディレクトリのパスを設定
"         let g:marching_include_paths = filter(
"                 \        split(glob('/usr/include/c++/*'), '\n') +
"                 \        split(glob('/usr/include/*/c++/*'), '\n') +
"                 \        split(glob('/usr/include/*/'), '\n'),
"                 \        'isdirectory(v:val)')
"         " neocomplete.vim と併用して使用する場合
"         if has("lua")
"             let g:marching_enable_neocomplete = 1
"
"             if !exists('g:neocomplete#force_omni_input_patterns')
"                 let g:neocomplete#force_omni_input_patterns = {}
"             endif
"
"             let g:neocomplete#force_omni_input_patterns.cpp =
"                 \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"         endif
"     endfunction
"     unlet s:bundle
" endif
"=============================lightline.vimの設定===============================
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ }
      \ }

let g:lightline.component = {}
" let g:lightline.component.dir = '%.35(%{expand("%:h:s?\\S$?\\0/?")}%)'
" let g:lightline.component.rows = '%L'
let g:lightline.component.cd = '%.35(%{fnamemodify(getcwd(), ":~")}%)'
" let g:lightline.component.tabopts = '%{&et?"et":""}%{&ts}:%{&sw}:%{&sts},%{&tw}'
let g:lightline.tabline = {'right': [['cd']]}
"
function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

"=============================caw.vimの設定===============================
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

"=============================vim-easy-align.vimの設定===============================
vmap <Leader>= <Plug>(EasyAlign)

"=============================jedi-vimの設定===============================

let g:jedi#rename_command = "<Leader>R"
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
let g:jedi#popup_select_first = 0
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
autocmd MyAutoCmd FileType python setlocal omnifunc=jedi#completions
autocmd MyAutoCmd FileType python setlocal conceallevel=0

" let s:bundle = neobundle#get("jedi-vim")
" function! s:bundle.hooks.on_post_source(bundle)
"     let g:jedi#rename_command = "<Leader>R"
"     let g:jedi#auto_vim_configuration = 0
"     let g:jedi#show_call_signatures = 0
"     let g:jedi#popup_select_first = 0
" endfunction
"
" function! s:bundle.hooks.on_source(bundle)
"     let g:jedi#completions_enabled = 0
"     let g:jedi#popup_select_first = 0
"     if !exists('g:neocomplete#force_omni_input_patterns')
"         let g:neocomplete#force_omni_input_patterns = {}
"     endif
"     let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"
"     autocmd MyAutoCmd FileType python setlocal omnifunc=jedi#completions
" endfunction
" unlet s:bundle
"
" autocmd MyAutoCmd FileType python setlocal conceallevel=0
"
"=============================vim-singletonの設定===============================
if has("clientserver")
    let s:bundle = neobundle#get("vim-singleton")
    function! s:bundle.hooks.on_source(bundle)
        call singleton#enable()
    endfunction
    unlet s:bundle
endif
"=============================neomru.vimの設定===============================
let s:bundle = neobundle#get("neomru.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:neomru#do_validate = 0
endfunction
unlet s:bundle

"=============================Denite.nvimの設定===============================
let s:bundle = neobundle#get("denite.nvim")
function! s:bundle.hooks.on_source(bundle)
    call denite#custom#var('file_rec', 'command',
          \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'separator', [])
    call denite#custom#var('grep', 'default_opts',
          \ ['--nocolor', '--nogroup'])
endfunction

nnoremap <silent> sh :Denite -mode=normal file_mru<CR>
nnoremap <silent> sg :Denite -mode=normal grep<CR>
nnoremap <silent> sl :Denite -mode=normal line<CR>
unlet s:bundle

autocmd MyAutoCmd FileType java setlocal omnifunc=javacomplete#Complete
