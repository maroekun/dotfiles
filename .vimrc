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

  let s:toml      = '~/.vim/rc' . '/dein.toml'
  let s:lazy_toml = '~/.vim/rc' . '/dein_lazy.toml'
  "# let s:toml      = g:rc_dir . '/dein.toml'
  "# let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#add('Shougo/vimproc.vim', {
  \ 'hook_post_update': "
  \   if dein#util#_is_windows()
  \     let cmd = 'tools\\update-dll-mingw'
  \   elseif dein#util#_is_cygwin()
  \     let cmd = 'make -f make_cygwin.mak'
  \   elseif dein#util#_is_mac()
  \     let cmd = 'make -f make_mac.mak'
  \   elseif executable('gmake')
  \     let cmd = 'gmake'
  \   else
  \     let cmd = 'make'
  \   endif
  \   let g:dein#plugin.build = cmd
  \ "})

  call dein#add('scrooloose/nerdcommenter', {
    \ 'hook_add': 'let g:NERDSpaceDelims = 1'
    \ })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
" }}}

syntax enable
filetype plugin on

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
set statusline=%y%{GetStatusEx()}%{fugitive#statusline()}\ 0x%B(%b)%F%m%r%=<%c:%l>
set list
set listchars=tab:✓\ 

" Functions: "{{{
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
"}}}

