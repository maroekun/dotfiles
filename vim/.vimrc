set runtimepath+=$HOME/dotfiles/vim
set rtp+=$(brew --prefix)/opt/fzf

augroup MyAugroup
  autocmd!
augroup end

runtime! rc/plug.vim
runtime! rc/set-mapping.vim
runtime! rc/plug-mapping.vim

augroup MyAugroup
  autocmd FileType ruby setlocal sw=2 ts=2 sts=2
  autocmd FileType perl setlocal sw=4 ts=4 sts=4
  autocmd FileType javascript setlocal sw=2 ts=2 sts=2

  autocmd BufNewFile, BufRead *.slim setlocal sw=2 ts=2 sts=2 ft=slim

  " autocmd BufNewFile,BufRead *.py setlocal ts=4 sts=4 sw=4
  " autocmd BufNewFile,BufRead *.rb setlocal ts=2 sts=2 sw=2
  " autocmd BufNewFile,BufRead *.scss,*.css setlocal ts=2 sts=2 sw=2
  " autocmd BufNewFile,BufRead *.rb,*.rake setlocal ts=2 sts=2 sw=2
  " autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja setlocal ft=jinja
  " autocmd BufNewFile,BufRead *.html,*.erb setlocal ts=2 sts=2 sw=2
  " autocmd BufNewFile,BufRead *.js setlocal ts=2 sts=2 sw=2
  " autocmd BufNewFile,BufRead *.slim setlocal ts=2 sts=2 sw=2 ft=slim
augroup end

set background=dark
colorscheme material

if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" NOTE: 要検討
" "{{{
" " ターミナルタイプによるカラー設定
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
" "}}}

" See :help folding
" vim: foldmethod=marker
