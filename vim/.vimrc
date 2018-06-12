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

" utility "{{{
Plug 'bronson/vim-trailing-whitespace'
Plug 't9md/vim-quickhl'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/Align'
" }}}

" git "{{{
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" }}}

Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'kana/vim-smartword'
Plug 'tpope/vim-rails'
Plug 'szw/vim-tags'
Plug 'kannokanno/previm', { 'for': 'markdown' }

" change directory and load rc "{{{
Plug 'airblade/vim-rooter'
Plug 'thinca/vim-localrc'
" }}}

" commenter
Plug 'scrooloose/nerdcommenter'

" colorschema
Plug 'joshdick/onedark.vim'
Plug 'mrkn/mrkn256.vim'
Plug 'tomasr/molokai'
Plug 'yuroyoro/yuroyoro256.vim'
Plug 'rhysd/vim-color-spring-night'

" neosnippet
Plug 'Shougo/neosnippet-snippets'
  \ | Plug 'Shougo/neosnippet.vim'

if has("nvim")
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" filer
Plug 'cocopon/vaffle.vim'

" fzf "{{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" }}}

" ale
Plug 'w0rp/ale'

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

" fzf "{{{
nnoremap [fzf] <Nop>
nmap ,f [fzf]
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]T :<C-u>Filetypes<CR>
nnoremap <silent> [fzf]g :<C-u>GFiles<CR>
nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]c :<C-u>Colors<CR>
nnoremap <silent> [fzf]m :<C-u>Fmru<CR>

" See: https://github.com/junegunn/fzf.vim#advanced-customization
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" See: https://qiita.com/kmszk/items/aa9920f07487559c0c7e#vim%E3%81%A7%E4%BD%BF%E3%81%86
command! Fmru FZFMru
command! FZFMru call fzf#run({
            \  'source':  v:oldfiles,
            \  'sink':    'tabe',
            \  'options': '-m -x +s',
            \  'down':    '40%'})


nnoremap <C-p> :FZFFileList<CR>
command! FZFFileList call fzf#run({
            \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
            \ 'sink': 'e'})

" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
" }}}

" previm "{{{
let g:previm_open_cmd = 'open -a "Google Chrome"'
" }}}

" neosnippet {{{
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/dotfiles/snippets'

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}

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
let g:lightline = {
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


" FileTypes {{{
" autocmd BufNewFile,BufRead *.es6 setlocal ts=2 sts=2 sw=2 ft=javascript
" }}}


" See :help folding
" vim: foldmethod=marker
