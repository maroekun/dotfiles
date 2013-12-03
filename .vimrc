set nocompatible

if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

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

" NeoBundle 'rking/ag.vim'
NeoBundle 'vim-scripts/EnhCommentify.vim'
NeoBundle 'vim-scripts/quickhl.vim'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'kana/vim-smartword'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'scrooloose/syntastic'

NeoBundleLazy 'Shougo/neocomplete.vim',   { 'autoload': { 'insert': 1 } }
NeoBundleLazy 'Shougo/neosnippet',        { 'autoload': { 'insert': 1 } }
NeoBundleLazy 'vim-scripts/ruby-matchit', { 'autoload': { 'filetypes': ['ruby'] } }
NeoBundleLazy 'vim-scripts/Align', {
            \ 'autoload': {
            \     'commands': ['Align'] } }
NeoBundleLazy 'scrooloose/nerdtree', {
            \ 'autoload': {
            \     'commands': ['NERDTreeToggle'] } }
NeoBundleLazy 'airblade/vim-gitgutter', {
            \ 'autoload': {
            \     'commands': ['GitGutterToggle'] } }
NeoBundleLazy 'dag/vim2hs', {
            \ 'autoload': {
            \     'filetypes': ['haskell'] } }

" Color syntax
NeoBundle 'yuroyoro/yuroyoro256.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'vim-scripts/desert256.vim'
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'elzr/vim-json'

NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload': {'filetypes': ['coffee']} }
NeoBundleLazy 'motemen/xslate-vim', { 'autoload': {'filetypes': ['xslate']} }
NeoBundleLazy 'tpope/vim-haml',     { 'autoload': {'filetypes': ['haml']} }
NeoBundleLazy 'tpope/vim-markdown', { 'autoload': { 'filetypes': ['markdown'] } }
NeoBundleLazy 'jelera/vim-javascript-syntax', { 'autoload': { 'filetypes': ['javascript'] } }

filetype plugin indent on

NeoBundleCheck

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
set laststatus=2
" set statusline=%y%{GetStatusEx()}\ 0x%B(%b)%F%m%r%=<%c:%l>
set statusline=%y%{GetStatusEx()}%{fugitive#statusline()}\ 0x%B(%b)%F%m%r%=<%c:%l>

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
map ,ptv :! perltidy

" ** neocomplete
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#close_popup()

" ** neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
xmap <C-l> <Plug>(neosnippet_start_unite_snipet_target)

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" ** gitgutter
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

" ** nerdtree
nmap <silent> <c-e> :NERDTreeToggle<CR>

" ** perldoc-vim
noremap K :Perldoc<CR>

" ** unite
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files file buffer file_mru bookmark<CR>

" ** color roller
nnoremap <silent><F9> : <C-u>call ColorRoller.roll()<CR>
nnoremap <silent><F8> : <C-u>call ColorRoller.unroll()<CR>

" ** quickhl.vim
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

" ** perldoc-vim
setlocal iskeyword-=/
setlocal iskeyword+=:
au FileType perl let g:perldoc_program='/Users/maroekun/perl5/perlbrew/perls/current/bin/perldoc'

" ** unite
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"********************
" filse setting
"********************

autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

" ** ruby
autocmd BufRead,BufNewFile *.rb,Gemfile,Vagrantfile call RubySetting()
function! RubySetting()
    set tabstop=2
    set shiftwidth=2
endfunction

" ** json
autocmd BUfRead,BufNewFile *.json call JsonSetting()
function! JsonSetting()
    set ts=2
    set sw=2
    set ft=json
endfunction

"********************
" variables
"********************

" ** neocomplete
let s:bundle = neobundle#get('neocomplete.vim')
function! s:bundle.hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0           " Disable AutoComplPop.
    let g:neocomplete#enable_at_startup = 1 " Use neocomplete.
    let g:neocomplete#enable_smart_case = 1 " Use smartcase.
    let g:neocomplete#sources#syntax#min_keyword_length = 1 " Set minimum syntax keyword length.
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'   " 前は使ってなかった **  必要？？？ **

    " Resolve error, caused by vim-rails. >>  https://github.com/tpope/vim-rails/issues/283
    let g:neocomplete#force_overwrite_completefunc = 1

    let g:neocomplete#sources#dictionary#dictionaries = { 'default' : '', } " Define dictionary.

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
endfunction
unlet s:bundle

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

" ** syntastic
let s:bundle = neobundle#get('syntastic')
function! s:bundle.hooks.on_source(bundle)
"    let g:syntastic_check_on_wa=0
    let g:syntastic_mode_map = {
                \ 'mode': 'passive',
                \ 'active_filetypes': ['ruby']
                \ }
    let g:syntastic_ruby_checkers  = ['rubocop']
    let g:syntastic_quiet_warnings = 0
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
            \ ]

" ** quickhl
let g:quickhl_keywords = [
            \ 'TODO',
            \ 'CAUTION',
            \ ]

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

" - - - - -

source $HOME/.selfvim/perlbrew.vim
