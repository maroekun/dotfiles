set runtimepath+=$HOME/dotfiles/vim

runtime! rc/plug.vim
runtime! rc/set-mapping.vim
runtime! rc/plug-mapping.vim

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

" See :help folding
" vim: foldmethod=marker
