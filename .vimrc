set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

"NeoBundle 'Color-Sampler-Pack'
    NeoBundle 'Align'
    NeoBundle 'EnhCommentify.vim'
    NeoBundle 'surround.vim'
"NeoBundle 'neocomplcache'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
"NeoBundle 'snipMate'
NeoBundle 'tlib'
    NeoBundle 'hotchpotch/perldoc-vim'
    NeoBundle 'unite.vim'
    NeoBundle 'unite-colorscheme'
    NeoBundle 'quickhl.vim'
    NeoBundle 'vim-scripts/Colour-Sampler-Pack'
    NeoBundle 'smartword'
    NeoBundle 'thinca/vim-ref'
    NeoBundle 'mattn/zencoding-vim'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'tpope/vim-rails'
    NeoBundle 'tpope/vim-endwise'

" colors
    NeoBundle 'desert256.vim'
    NeoBundle 'mrkn256.vim'
    NeoBundle 'tomasr/molokai'
    NeoBundle 'yuroyoro/yuroyoro256.vim'
    NeoBundle 'motemen/xslate-vim'

NeoBundle 'taglist.vim'
NeoBundle 'dbext.vim'
NeoBundle 'bigfish/vim-nodelint'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'airblade/vim-gitgutter'

" StatusLine
    NeoBundle 'itchyny/lightline.vim'

" Syntax
    NeoBundle 'elzr/vim-json'
    NeoBundle 'haml.zip'
    NeoBundle 'nginx.vim'
    NeoBundle 'kchmck/vim-coffee-script'
    NeoBundle 'jelera/vim-javascript-syntax'
    NeoBundle 'tpope/vim-markdown'

" Haskell
    NeoBundle 'dag/vim2hs'

"colorscheme yuroyoro256
colorscheme ironman

filetype plugin indent on
NeoBundleCheck

"********************
" defult line setting
"********************
syntax on
set nobackup
set modelines=5
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

command! Nginx : call Nginx()

hi Comment ctermfg=lightcyan

"********************
" key mapping
"********************

"** General
imap <c-j> <ESC>
imap <silent> <c-d><c-d> <c-r>=strftime("%Y-%m-%d")<CR>
imap <silent> <c-d><c-f> <c-r>=strftime("%Y/%m/%d")<CR>
nmap <silent> <ESC><ESC> :nohlsearch<CR><ESC>
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

"** PerlTidy
"map ,ptv :'<,'>! perltidy
map ,ptv :! perltidy

"** NERDtree
nmap <silent> <c-e> :NERDTreeToggle<CR>

"********************
" status line setting
"********************
set laststatus=2
"set statusline=%y%{GetStatusEx()}\ 0x%B(%b)%F%m%r%=<%c:%l>
set statusline=%y%{GetStatusEx()}%{fugitive#statusline()}\ 0x%B(%b)%F%m%r%=<%c:%l>

"********************
" bash setting
"********************
autocmd BufRead,BufNewFile *.sh call MyShellSetting()
function! MyShellSetting()
    set filetype=sh
    set smartindent
    set tabstop=2
    set shiftwidth=2
endfunction

"********************
" javascript setting
"********************
autocmd BufRead,BufNewFile *.js call MyJSSetting()
function! MyJSSetting()
    set filetype=javascript
    set smartindent
    set tabstop=2
    set shiftwidth=2
    call JavaScriptFold()
endfunction

"********************
" css setting
"********************
autocmd BufRead,BufNewFile *.css,*.scss call MyCSSSetting()
function! MyCSSSetting()
    set filetype=css
    set tabstop=2
    set shiftwidth=2
    set nocindent
endfunction

"********************
" html setting
"********************
autocmd BufRead,BufNewFile *.html,*.tt,*.tx call HTMLSetting()
function! HTMLSetting()
    set filetype=html
    call HTMLTags()
endfunction

"********************
" html setting
"********************
autocmd BufRead,BufNewFile *.tx call XslateSetting()

function! XslateSetting()
    set filetype=xslate
    call HTMLTags()
endfunction

function! HTMLTags()
    set tabstop=2
    set shiftwidth=2

    let b:surround_49  = "<h1>\r</h1>" "49  = 1
    let b:surround_50  = "<h2>\r</h2>" "50  = 2
    let b:surround_51  = "<h3>\r</h3>" "51  = 3
    let b:surround_52  = "<h4>\r</h4>" "52  = 4
    let b:surround_53  = "<h5>\r</h5>" "53  = 5
    let b:surround_54  = "<h6>\r</h6>" "54  = 6
    let b:surround_112 = "<p>\r</p>"   "112  = p
    let b:surround_117 = "<ul>\r</ul>" "117 = u
    let b:surround_111 = "<ol>\r</ol>" "111 = o
    let b:surround_108 = "<li>\r</li>" "108 = l
    let b:surround_97  = "<a href=\"\">\r</a>" "97 = a
    let b:surround_65  = "<a href=\"\r\"></a>" "65 = A
    let b:surround_105 = "<img src = \"\r\" alt = \"\" />" "105  = i
    let b:surround_73  = "<img src = \"\" alt   = \"\r\" />" "73 = I
    let b:surround_100 = "<div>\r</div>" "100 = d
    let b:surround_68  = "<div class=\"section\">\r</div>" "68 = D
endfunction



"********************
" ruby setting
"********************
autocmd BufRead,BufNewFile *.rb,Gemfile,Vagrantfile call MyRubySetting()
function! MyRubySetting()
    set filetype=ruby
    set tabstop=2
    set shiftwidth=2
endfunction

"********************
" haml setting
"********************
autocmd BufRead,BufNewFile *.haml call MyHamlSetting()
function! MyHamlSetting()
    set filetype=haml
    set tabstop=2
    set shiftwidth=2
endfunction

"********************
" perl setting
"********************
autocmd BufRead,BufNewFile *.psgi,*.t,*.pl,*.pm call MyPERLSetting()
function! MyPERLSetting()
    set filetype=perl
    set tabstop=4
    set shiftwidth=4
endfunction

"********************
" yaml setting
"********************
autocmd BufRead,BufNewFile *.yaml,*.yml call MyYamlSetting()
function! MyYamlSetting()
    set tabstop=2
    set shiftwidth=2
endfunction

"********************
" tSkeleton
"********************
let g:tskelUserName="Yu.Shimizu"
let g:tskelUserEmail="you05232050@gmail.com"

" "********************
" " neocomplcache.vim
" "********************
" let g:neocomplcache_enable_at_startup=1
" let g:neocomplcache_enable_smart_case=1
" let g:neocomplcache_enable_undebar_completion=1
" let g:neocomplcache_min_syntax_length=1
" "let g:neocomplcache_dictionary_filetype_lists={ array }
" imap <c-k> <Plug>(neocomplcache_snippets_expand)
" inoremap <expr><C-g> neocomplcache#undo_completion()
" inoremap <expr><C-l> neocomplcache#complete_common_string()
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y> neocomplcache#close_popup()
" inoremap <expr><C-e> neocomplcache#cancel_popup()

"********************
" quickhl.vim
"********************
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

let g:quickhl_keywords = [
            \ "TODO",
            \ "CAUTION",
            \]
"********************
" lightline.vim
"********************
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename'] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'MyFugitive',
  \   'readonly': 'MyReadonly',
  \   'modified': 'MyModified',
  \   'filename': 'MyFilename'
  \ },
  \ 'separator': { 'left': '⮀', 'right': '⮂' },
  \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
  \ }
function! MyFugitive()
  return exists('*fugitive#head') && strlen(fugitive#head()) ? '⭠ '.fugitive#head() : ''
endfunction

function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return "⭤"
    else
        return ""
    endif
endfunction

function! MyModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    else
        return ""
    endif
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%t') ? expand('%t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

""""""""""""""""""""""""""""""
" vim-nodelint
""""""""""""""""""""""""""""""
let g:NodelintConfig = $HOME . '/.vim/bundle/vim-nodelint/nodelint-config.js'
let g:NodelintReporter = 'vim'

""""""""""""""""""""""""""""""
" vim-gitgutter
""""""""""""""""""""""""""""""
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 0

"********************
" perldoc-vim
"********************
noremap K :Perldoc<CR>
setlocal iskeyword-=/
setlocal iskeyword+=:
au FileType perl let g:perldoc_program='/Users/maroekun/perl5/perlbrew/perls/current/bin/perldoc'

"********************
" taglist.vim
"********************
let Tlist_Exit_OnlyWindow = 1

"********************
" syntastic.vim
"********************
let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': ['ruby']
      \ }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_quiet_warnings = 0

"********************
" Unite file
"********************
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files file buffer file_mru bookmark<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"********************
" ColorRoller
"********************
let ColorRoller = {}
let ColorRoller.colors = [
    \'default',
    \'adaryn',
    \'anotherdark',
    \'solarized',
    \'moss',
    \'dante',
    \'golden',
    \'ironman',
    \'jellybeans',
    \'mustang',
    \'softblue',
    \'tir_black',
    \'wombat256',
    \'yuroyoro256',
    \'molokai',
    \'desert256',
    \'mrkn256',
    \'wuye',
    \ ]
function! ColorRoller.change()
    let color = get(self.colors, 0)
    silent exe "colorscheme " . color
    redraw
    echo self.colors
endfunction

function! ColorRoller.roll()
    let item = remove(self.colors, 0)
    call insert(self.colors, item, len(self.colors))
    call self.change()
endfunction

function! ColorRoller.unroll()
    let item = remove(self.colors, -1)
    call insert(self.colors, item, 0)
    call self.change()
endfunction

nnoremap <silent><F9> : <C-u>call ColorRoller.roll()<CR>
nnoremap <silent><F8> : <C-u>call ColorRoller.unroll()<CR>

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

function! Nginx()
    ec "set filetype to nginx!"
    set filetype=nginx
    redraw
endfunction

source $HOME/.selfvim/perlbrew.vim

"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------
" colorscheme mrkn256
"colorscheme yuroyoro256

" ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

"ポップアップメニューのカラーを設定
"hi Pmenu guibg=#666666
"hi PmenuSel guibg=#8cd0d3 guifg=#666666
"hi PmenuSbar guibg=#333333

" ハイライト on
syntax enable
" 補完候補の色づけ for vim7
" hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
" hi PmenuSel ctermbg=blue ctermfg=black
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
" hi PmenuSbar ctermbg=0 ctermfg=9
" hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

