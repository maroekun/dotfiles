"********************************************************
" Vundle Setting
"********************************************************
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'Align'
Bundle 'EnhCommentify.vim'
Bundle 'surround.vim'
Bundle 'neocomplcache'
Bundle 'snipMate'
Bundle 'tlib'
Bundle 'tSkeleton'
Bundle 'nginx.vim'

filetype plugin indent on

"********************************************************
" install plugins
" -------------------------------------------------------
" Align
"   http://www.vim.org/scripts/script.php?script_id=294
" EnhCommentify.vim
"   http://www.vim.org/scripts/script.php?script_id=23
" surround.vim
"   http://www.vim.org/scripts/script.php?script_id=1697
" neocomplcache
"   http://www.vim.org/scripts/script.php?script_id=2620
"********************************************************

"********************
" defult line setting
"********************
syntax on
set number
set tabstop=4
set expandtab
set shiftwidth=4
set showmatch
set autoindent
set cindent
set incsearch
set hlsearch
set ambiwidth=double
set formatoptions+=mM
set backspace=indent,eol,start
set scrolloff=5

command Nginx : call Nginx()

hi Comment ctermfg=lightcyan

"imap <c-k> <c-m>
imap <c-j> <Esc>
imap <silent> <c-d><c-d> <c-r>=strftime("%Y-%m-%d")<CR>

onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

"********************
" status line setting
"********************
set laststatus=2
set statusline=%y%{GetStatusEx()}\ 0x%B(%b)%F%m%r%=<%c:%l>

"********************
" javascript setting
"********************
autocmd BufRead,BufNewFile *.js call MyJSSetting()
function MyJSSetting()
    set filetype=javascript
    set smartindent
    set tabstop=2
    set shiftwidth=2
endfunction

"********************
" css setting
"********************
autocmd BufRead,BufNewFile *.css call MyCSSSetting()
function MyCSSSetting()
    set filetype=css
    set tabstop=2
    set shiftwidth=2
    set nocindent
endfunction

"********************
" html setting
"********************
autocmd BufRead,BufNewFile *.html,*.tt call MyHTMLSetting()
function MyHTMLSetting()
    set filetype=html
    if CheckSurroundPlugin()
        let b:surround_49  = "<h1>\r</h1>" "49  = 1
        let b:surround_50  = "<h2>\r</h2>" "50  = 2
        let b:surround_51  = "<h3>\r</h3>" "51  = 3
        let b:surround_52  = "<h4>\r</h4>" "52  = 4
        let b:surround_53  = "<h5>\r</h5>" "53  = 5
        let b:surround_54  = "<h6>\r</h6>" "54  = 6
        let b:surround_112 = "<p>\r</p>"  "112  = p
        let b:surround_117 = "<ul>\r</ul>" "117 = u
        let b:surround_111 = "<ol>\r</ol>" "111 = o
        let b:surround_108 = "<li>\r</li>" "108 = l
        let b:surround_97  = "<a href=\"\">\r</a>" "97 = a
        let b:surround_65  = "<a href=\"\r\"></a>" "65 = A
        let b:surround_105 = "<img src = \"\r\" alt = \"\" />" "105  = i
        let b:surround_73  = "<img src = \"\" alt   = \"\r\" />" "73 = I
        let b:surround_100 = "<div>\r</div>" "100 = d
        let b:surround_68  = "<div class=\"section\">\r</div>" "68 = D
    endif
endfunction

"********************
" perl setting
"********************
autocmd BufRead,BufNewFile *.pl call MyPERLSetting()
function! MyPERLSetting()
    set filetype=perl
endfunction

"********************
" surround.vim
"********************
function! CheckSurroundPlugin()
    if (exists("g:loaded_surround") && g:loaded_surround) || &cp
       return 1 
    endif
    echo "surround plugin is not loaded."
    return 0
endfunction

"********************
" tSkeleton
"********************
let g:tskelUserName="******"
let g:tskelUserEmail="******"

"********************
" neocomplcache.vim
"********************
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_undebar_completion=1
let g:neocomplcache_min_syntax_length=3
"let g:neocomplcache_dictionary_filetype_lists={ array }
imap <c-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

"********************
" functions 
"********************
function! GetStatusEx()
    let str=''
    let str = str . '' . &fileformat. ']'
    if has('multi_byte') && &fileencoding != ''
        let str = '[' . &fileencoding . ':' . str
    endif
endfunction

function Nginx()
    ec "set filetype to nginx!"
    set filetype=nginx
endfunction
