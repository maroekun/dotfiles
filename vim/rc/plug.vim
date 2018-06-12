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

" vim: foldmethod=marker
