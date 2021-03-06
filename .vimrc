" for dein {{{
let g:rc_dir = expand('~/.vim/rc')
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " NOTE: TOMLにうまいこと移植できんかった
  call dein#add('itchyny/lightline.vim', {
            \ 'hook_add': "
            \   let g:lightline = {
            \     'colorscheme': 'wombat',
            \     'active': {
            \       'left': [ [ 'mode', 'paste' ],
            \                 [ 'fugitive', 'filename'] ],
            \       'right': [ [ 'lineinfo' ],
            \                  [ 'percent' ],
            \                  [ 'hoge', 'fileformat', 'fileencoding', 'filetype' ] ]
            \     },
            \     'component_function': {
            \       'fugitive': 'MyFugitive',
            \       'readonly': 'MyReadonly',
            \       'modified': 'MyModified',
            \       'filename': 'MyFilename',
            \       'hoge':     'ShowCurTag'
            \     },
            \     'separator': { 'left': '⮀', 'right': '⮂' },
            \     'subseparator': { 'left': '⮁', 'right': '⮃' }
            \   }
            \ " })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
" }}}

" Setting {{{
syntax enable
filetype plugin on

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
" set statusline=%y%{GetStatusEx()}%{fugitive#statusline()}\ 0x%B(%b)%F%m%r%=<%c:%l>
set list
set listchars=tab:>-,extends:<,trail:-
" }}}

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

" ColorRoller {{{
nnoremap <silent><F9> : <C-u>call ColorRoller.roll()<CR>
nnoremap <silent><F8> : <C-u>call ColorRoller.unroll()<CR>
" }}}

" Command {{{
map ,ptv :! perltidy
" Require: https://github.com/monochromegane/mdt
" NOTE: autoCMD あたりでいける？
map ,mdt :! mdt
" }}}

" }}}

" Functions for lightline.vim: "{{{
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

function! ShowCurTag()
    return strlen(tagbar#currenttag('%s', '')) ? tagbar#currenttag('%s', '') : '??'
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != expand('%t') ? expand('%t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
"}}}

" color roller: "{{{
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
            \'onedark',
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
"}}}

" Colors: {{{
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
" }}}
colorscheme onedark

" FileTypes {{{
augroup fileTypeIndent
    autocmd!
    " tabstop: ts, softtabstop: sts, shiftwidth: sw
    autocmd BufNewFile,BufRead *.py setlocal ts=4 sts=4 sw=4
    autocmd BufNewFile,BufRead *.rb setlocal ts=2 sts=2 sw=2
    autocmd BufNewFile,BufRead *.scss,*.css setlocal ts=2 sts=2 sw=2
    autocmd BufNewFile,BufRead *.rb,*.rake setlocal ts=2 sts=2 sw=2
    autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja setlocal ft=jinja
    autocmd BufNewFile,BufRead *.html,*.erb setlocal ts=2 sts=2 sw=2
    autocmd BufNewFile,BufRead *.js setlocal ts=2 sts=2 sw=2
    autocmd BufNewFile,BufRead *.slim setlocal ts=2 sts=2 sw=2 ft=slim
augroup END

autocmd BufEnter * if exists("b:rails_root") | call s:LoadRailsSnippet() | endif

function! s:LoadRailsSnippet()
 " カレントディレクトリのディレクトリパス（絶対パス）取得
  let s:current_file_path = expand("%:p:h")

  " appフォルダ内でなければ無視
  if ( s:current_file_path !~ "app/" ) | return | endif

  if ( s:current_file_path =~ "app/controllers" )
    let l:hoge = g:neosnippet#snippets_directory . 'rails.snip'

    " NOTE: どうやって変数展開で渡せるんや...
	NeoSnippetSource ~/dotfiles/snippets/rails.snip
  endif

endfunction

" }}}

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" For conceal markers. {{{
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}

" See :help folding
" vim: foldmethod=marker
