" set
" -----------------------------------------------------
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


"
" mapping
" -----------------------------------------------------

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

" autocmd BufNewFile,BufRead *.es6 setlocal ts=2 sts=2 sw=2 ft=javascript

" vim: foldmethod=marker
