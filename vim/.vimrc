" install vim-pulg
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')

" utility
Plug 'bronson/vim-trailing-whitespace'
Plug 't9md/vim-quickhl'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/Align'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'

" change directory and load rc
Plug 'airblade/vim-rooter'
Plug 'thinca/vim-localrc'

" commenter
Plug 'scrooloose/nerdcommenter'

" colorschema
Plug 'joshdick/onedark.vim'
Plug 'mrkn/mrkn256.vim'
Plug 'tomasr/molokai'
Plug 'yuroyoro/yuroyoro256.vim'

" ag
Plug 'rking/ag.vim', { 'on' : 'Ag' }

" html, tt2, eruby, slim
Plug 'mattn/emmet-vim', { 'for': ['html', 'tt2', 'eruby', 'slim'] }

" haml
Plug 'tpope/vim-haml', { 'for': 'haml' }

" Dockerfile
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

" slim
Plug 'slim-template/vim-slim', { 'for': 'slim' }

" tf
Plug 'hashivim/vim-terraform', { 'for': 'tf' }

" es6
Plug 'othree/yajs.vim', { 'for':  'es6'}

" jinja
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }

" go
Plug 'fatih/vim-go', { 'for': 'go' }

call plug#end()

" quickhl
let g:quickhl_manual_enable_at_startup = 1
let g:quickhl_manual_keywords = [ "TODO", "CAUTION", "DELETED", "NOTE" ]
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
nmap <Space>j <Plug>(quickhl-cword-toggle)

" nerdcommenter
let g:NERDSpaceDelims = 1
nmap <Leader>x <plug>NERDCommenterToggle
vmap <Leader>x <plug>NERDCommenterToggle

" vim-gitgutter
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

" lightline "{{{
" lightline let g:lightline = {
  \  'colorscheme': 'wombat',
  \  'active': {
  \    'left': [ [ 'mode', 'paste' ],
  \              [ 'fugitive', 'filename'] ],
  \    'right': [ [ 'lineinfo' ],
  \               [ 'percent' ],
  \               [ 'hoge', 'fileformat', 'fileencoding', 'filetype' ] ]
  \  },
  \  'component_function': {
  \    'fugitive': 'MyFugitive',
  \    'readonly': 'MyReadonly',
  \    'modified': 'MyModified',
  \    'filename': 'MyFilename',
  \    'hoge':     'ShowCurTag'
  \  },
  \  'separator': { 'left': '⮀', 'right': '⮂' },
  \  'subseparator': { 'left': '⮁', 'right': '⮃' }
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

function! ShowCurTag()
    return strlen(tagbar#currenttag('%s', '')) ? tagbar#currenttag('%s', '') : '??'
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != expand('%t') ? expand('%t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
" "}}}

set nobackup
set noundofile
set noswapfile
set modelines=5
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
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
set list
set listchars=tab:>-,extends:<,trail:-

" NOTE: 要検討
" "{{{
" " ターミナルタイプによるカラー設定
" if &term =~ "xterm-256color" || "screen-256color"
"   " 256色
"   set t_ut=
"   set t_Co=256
"   set t_Sf=[3%dm set t_Sb=[4%dm
" elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
"   set t_Co=16
"   set t_Sf=[3%dm
"   set t_Sb=[4%dm
" elseif &term =~ "xterm-color"
"   set t_Co=8
"   set t_Sf=[3%dm
"   set t_Sb=[4%dm
" endif
" "}}}

" mapping {{{
" General {{{
imap <c-j> <ESC>
nmap <silent> <ESC><ESC> :noh<CR><ESC>
imap <silent> <c-d><c-d> <c-r>=strftime("%Y-%m-%d")<CR>
imap <silent> <c-d><c-f> <c-r>=strftime("%Y/%m/%d")<CR>
" }}}

" Tab {{{
nnoremap [tab] <Nop>
nmap ,t [tab]
" tc 新しいタブを一番右に作る
nnoremap <silent> [tab]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
nnoremap <silent> [tab]x :tabclose<CR>
" tn 次のタブ
nnoremap <silent> [tab]n :tabnext<CR>
" tp 前のタブ
nnoremap <silent> [tab]p :tabprevious<CR>
" tp 最後のタブ
nnoremap <silent> [tab]l :tablast<CR>
" }}}

" See :help folding
" vim: foldmethod=marker
