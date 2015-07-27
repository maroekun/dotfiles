" for Neobundle {{{
if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

set nocompatible
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin'  : 'make -f make_cygwin.mak',
    \     'mac'     : 'make -f make_mac.mak',
    \     'unix'    : 'make -f make_unix.mak',
    \    },
    \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'kana/vim-smartword'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'thinca/vim-ref'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'google/vim-ft-go'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'szw/vim-tags'
NeoBundle 'airblade/vim-rooter'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'vim-scripts/Align'
NeoBundle 'fatih/vim-go'
NeoBundle 'bronson/vim-trailing-whitespace'

" NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'tyru/open-browser.vim'

NeoBundleLazy 'hotchpotch/perldoc-vim', {
            \ 'autoload': {
            \   'commands': ['Perldoc'],
            \   'filetypes': ['perl']
            \ } }

NeoBundleLazy 'vim-scripts/quickhl.vim', {
            \ 'autoload': {
            \     'mappings': ['<Plug>(quickhl-manual-this)',
            \                  '<Plug>(quickhl-manual-reset)',
            \                  '<Plug>(quickhl-cword-toggle)' ]
            \ } }

NeoBundleLazy 'rking/ag.vim', { 'autoload': { 'commands': ['Ag'] } }

NeoBundleLazy 'scrooloose/syntastic',     { 'autoload': { 'filetypes': ['ruby', 'perl'] } }

NeoBundleLazy 'Shougo/neosnippet',        { 'autoload': { 'insert': 1 } }

NeoBundleLazy 'mattn/emmet-vim', { 'autoload': { 'filetypes': ['html', 'tt2', 'xslate'] } }

NeoBundleLazy 'vim-scripts/ruby-matchit', { 'autoload': { 'filetypes': ['ruby'] } }

NeoBundleLazy 'tpope/vim-endwise', { 'autoload': { 'filetypes': ['ruby'] } }

NeoBundleLazy 'groenewege/vim-less', { 'autoload': { 'filetypes': ['less'] } }


NeoBundleLazy 'Shougo/vimfiler.vim', {
            \ 'autoload': {
            \     'commands': ['VimFiler'] } }

NeoBundleLazy 'airblade/vim-gitgutter', {
            \ 'autoload': {
            \     'commands': ['GitGutterToggle'] } }

NeoBundleLazy 'dag/vim2hs', {
            \ 'autoload': {
            \     'filetypes': ['haskell'] } }

NeoBundleLazy 'osyo-manga/vim-over', {
            \ 'autoload': {
            \     'commands': ['OverCommandLine'] } }
NeoBundleLazy 'chase/vim-ansible-yaml', { 'autoload': { 'filetypes': ['ansible'] } }
NeoBundleLazy 'ywatase/mdt.vim', { 'autoload': { 'filetypes' : ['markdown'] } }
NeoBundleLazy 'kannokanno/previm', { 'autoload': { 'filetypes': ['markdown'] } }
" Require md2fswiki
" cpanm -n git@github.com:ywatase/md2fswiki.git
NeoBundleLazy 'ywatase/md2fswiki.vim', { 'autoload' : { 'filetypes' : ['markdown'] } }

" Color syntax {{{
NeoBundle 'yuroyoro/yuroyoro256.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'vim-scripts/desert256.vim'
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'slim-template/vim-slim'
NeoBundle '29decibel/codeschool-vim-theme'
NeoBundle 'derekwyatt/vim-scala'
" }}}

NeoBundleLazy 'elzr/vim-json',            { 'autoload': { 'filetypes': ['json'] } }
NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload': {'filetypes': ['coffee']} }
NeoBundleLazy 'motemen/xslate-vim', { 'autoload': {'filetypes': ['xslate']} }
NeoBundleLazy 'tpope/vim-haml',     { 'autoload': {'filetypes': ['haml']} }
NeoBundleLazy 'tpope/vim-markdown', { 'autoload': { 'filetypes': ['markdown'] } }
NeoBundleLazy 'jelera/vim-javascript-syntax', { 'autoload': { 'filetypes': ['javascript'] } }

" for golang {{{
filetype off
filetype plugin indent off
set rtp^=$GOPATH/src/github.com/nsf/gocode/vim
filetype plugin indent on
syntax on
" }}}

NeoBundleCheck
" }}}


" for golang {{{
set path+=$GOPATH/src/**
let g:gofmt_command = 'goimports'
augroup _golang
    autocmd!
    autocmd BufWritePre *.go Fmt
    autocmd BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
    autocmd FileType go compiler go
augroup END
" }}}

set nobackup
set noundofile
set noswapfile
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
set laststatus=2
" set statusline=%y%{GetStatusEx()}\ 0x%B(%b)%F%m%r%=<%c:%l>
set statusline=%y%{GetStatusEx()}%{fugitive#statusline()}\ 0x%B(%b)%F%m%r%=<%c:%l>
set list
set listchars=tab:✓\ 

" ハイライト on
syntax enable
set background=dark
colorscheme solarized


command! Nginx : call Nginx()

hi Comment ctermfg=lightcyan

"********************
" variables
"********************

" ** vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
au FileType go nmap <Leader>b  <Plug>(go-build)
au FileType go nmap <Leader>r  <Plug>(go-run)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" ** VimFiler
let s:bundle = neobundle#get("vimfiler.vim")
function! s:bundle.hooks.on_source(bundle)
  let g:vimfiler_ignore_pattern = '^\%(\.DS_Store\)$'
endfunction
unlet s:bundle

" ** nerdcommenter
let s:bundle = neobundle#get("nerdcommenter")
function! s:bundle.hooks.on_source(bundle)
  let g:NERDSpaceDelims = 1
endfunction
unlet s:bundle

" ** syntastic
let s:bundle = neobundle#get('syntastic')
function! s:bundle.hooks.on_source(bundle)
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  " 3.4.0
  " Syntax checker changes:
  " Disable the perl checker by default, for security reasons (lcd047)
  let g:syntastic_enable_perl_checker = 1
  let g:syntastic_perl_checkers = ["perl", "podchecker", "perlcritic"]

  let g:syntastic_mode_map = {
               \ "mode": "active",
               \ "active_filetypes": ["ruby"],
               \ "passive_filetypes": ["perl"] }
  let g:syntastic_ruby_checkers  = ['rubocop']
 " let g:syntastic_quiet_warnings = 0
endfunction
unlet s:bundle

" ** vim-indent-guides
let s:bundle = neobundle#get('vim-indent-guides')
function! s:bundle.hooks.on_source(bundle)
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size  = 1
endfunction
unlet s:bundle

" ** quickhl
let s:bundle = neobundle#get('quickhl.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:quickhl_keywords = [
              \ 'TODO',
              \ 'CAUTION',
              \ 'DELETED',
              \ ]
endfunction
unlet s:bundle

" ** neosnippet
let s:bundle = neobundle#get('neosnippet')
function! s:bundle.hooks.on_source(bundle)
    let g:neosnippet#snippets_directory = '~/dotfiles/snippets'
endfunction
unlet s:bundle

" neocomplete {{{
let g:acp_enableAtStartup = 0            " Disable AutoComplPop.
let g:neocomplete#enable_at_startup  = 1 " Use neocomplete.
let g:neocomplete#enable_ignore_case = 1 " Use ignorecase.
let g:neocomplete#enable_smart_case  = 1 " Use smartcase.
let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'   " 前は使ってなかった **  必要？？？ **

" Resolve error, caused by vim-rails. >>  https://github.com/tpope/vim-rails/issues/283
let g:neocomplete#force_overwrite_completefunc = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'scala': $HOME.'/.vim/dict/scala.dict'
            \ } 

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
" }}}

" ** lightline
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

" ** vim-gitgutter
let s:bundle = neobundle#get('vim-gitgutter')
function! s:bundle.hooks.on_source(bundle)
    let g:gitgutter_enabled         = 0
    let g:gitgutter_highlight_lines = 0
endfunction
unlet s:bundle


" color roller
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
            \'lucius',
            \'twilight',
            \ ]

" tagbar
nnoremap <silent><F7> :TagbarToggle<CR>
let g:tagbar_ctags_bin  = '/usr/local/bin/ctags'
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }


"********************
" key mapping
"********************

" ** General
imap <c-j> <ESC>
imap <silent> <c-d><c-d> <c-r>=strftime("%Y-%m-%d")<CR>
imap <silent> <c-d><c-f> <c-r>=strftime("%Y/%m/%d")<CR>
nmap <silent> <ESC><ESC> :nohlsearch<CR><ESC>
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(
map ,ptv :! perltidy
" Require: https://github.com/monochromegane/mdt
map ,mdt :! mdt

" ** swithc.vim
nmap <silent> ,s :<C-u>:Switch<CR>

" ** nerdcommenter
nmap <Leader>x <Plug>NERDCommenterToggle
vmap <Leader>x <Plug>NERDCommenterToggle

" ** vim-over
nnoremap <silent> <Leader>m :OverCommandLine<CR>
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>

" ** neocomplete
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#close_popup()
nnoremap <silent> ,nt :<C-u>NeoCompleteToggle<CR>

" ** neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
xmap <C-l> <Plug>(neosnippet_start_unite_snipet_target)
nnoremap <silent> ,ne :<C-u>NeoSnippetEdit<CR>

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" ** gitgutter
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

" ** VimFiler
nmap <silent> <c-e> :VimFiler<CR>

" ** perldoc-vim
noremap K :Perldoc<CR>

" ** unite
nnoremap [unite] <Nop>
nmap ,u [unite]
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file buffer file_mru bookmark<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]A :<C-u>UniteBookmarkAdd<CR>

" ** color roller
nnoremap <silent><F9> : <C-u>call ColorRoller.roll()<CR>
nnoremap <silent><F8> : <C-u>call ColorRoller.unroll()<CR>

" ** quickhl.vim
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
nmap <Space>j <Plug>(quickhl-cword-toggle)

" ** perldoc-vim
setlocal iskeyword-=/
setlocal iskeyword+=:
au FileType perl let g:perldoc_program=$HOME . '/.plenv/shims/perldoc'

" ** unite
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
call unite#custom#profile('source/buffer', 'context', {'ignorecase': 1})
call unite#custom#profile('source/file', 'context', {'ignorecase': 1})

" ** syntastic
nnoremap <silent> ,sc :<C-u>SyntasticReset<CR>

"********************
" filse setting
"********************

autocmd BufRead,BufNewFile *.psgi,*.pl,*.pm call PerlSetting()
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a "Google Chrome"'

function! PerlSetting()
    set ts=4
    set sw=4
endfunction

autocmd BufREad,BufNewFile *.yml,*.yaml call YAMLSetting()
function! YAMLSetting()
    set ft=yaml
    set ts=2
    set sw=2
endfunction

autocmd BufRead,BufNewFile *.tt,**html call HtmlSetting()
function! HtmlSetting()
    set ft=html
    set ts=2
    set sw=2
endfunction

autocmd BufRead,BufNewFile *.tt2 call TT2Setting()
function! TT2Setting()
    set ft=tt2html
    set ts=2
    set sw=2
endfunction

" ** Xslate
autocmd BufRead,BufNewFile *.tx call XslateSetting()
function! XslateSetting()
    set ts=2
    set sw=2
endfunction

" ** slim
autocmd BufRead,BufNewFile *.slim call SlimSetting()
function! SlimSetting()
  set ft=slim
  set ts=2
  set sw=2
endfunction

" ** ruby
autocmd BufRead,BufNewFile *.rb,Gemfile,Vagrantfile call RubySetting()
function! RubySetting()
    set tabstop=2
    set shiftwidth=2
endfunction

" ** slim
autocmd BufRead,BufNewFile *.slim call SlimSetting()
function! SlimSetting()
    set ft=slim
    set ts=2
    set sw=2
endfunction

" ** json
autocmd BufRead,BufNewFile *.json call JsonSetting()
function! JsonSetting()
    set ft=json
    set ts=2
    set sw=2
    set list
    set listchars=trail:-,eol:↲
endfunction

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

function! Nginx()
    ec "set filetype to nginx!"
    set filetype=nginx
    redraw
endfunction

function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " return neocomplete#smart_close_popup() . "\<C-h>"   "# 前はこの設定で使ってた
endfunction

"-------------------------------------------------------------------------------
" Tab
"-------------------------------------------------------------------------------
nnoremap <silent> ,sc :<C-u>SyntasticReset<CR>
" tc 新しいタブを一番右に作る
nnoremap <silent> ,tc :tablast <bar> tabnew<CR>
" tx タブを閉じる
nnoremap <silent> ,tx :tabclose<CR>
" tn 次のタブ
nnoremap <silent> ,tn :tabnext<CR>
" tp 前のタブ
nnoremap <silent> ,tp :tabprevious<CR>

"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------
" colorscheme mrkn256
"colorscheme yuroyoro256

" ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_ut=
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

" 補完候補の色づけ for vim7
" hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
" hi PmenuSel ctermbg=blue ctermfg=black
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
" hi PmenuSbar ctermbg=0 ctermfg=9
" hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

" - - - - -

source $HOME/.selfvim/perlbrew.vim
