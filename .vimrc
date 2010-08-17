set tabstop=4
set expandtab
set shiftwidth=4
set showmatch
set autoindent
set cindent
set number
set incsearch
set ambiwidth=double

" show the cursor position all the time
set ruler

" keep 50 lines of command line history
set history=50

" set color result of searching
set hlsearch

set nobackup
set laststatus=2
set statusline=%y%{GetStatusEx()}\ 0x%B(%b)%F%m%r%=<%c:%l>

imap <C-j> <Esc>
imap <C-k> <C-m>
imap <silent> <C-D><C-D> <C-R>=strftime("%Y-%m-%d")<CR>

" set popup color
hi Pmenu ctermbg=4
hi PmenuSel ctermbg=4
hi PMenuSbar ctermbg=4

function! GetStatusEx()
	let str = ''
	let str = str . '' . &fileformat . ']'
	if has('multi_byte') && &fileencoding != ''
		let str = '[' . &fileencoding . ':' . str
	endif
	return str
endfunction

function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=darkblue
endf

if has( "syntax" )
    syntax on
    autocmd BufNew,BufRead * call JISX0208SpaceHilight()
endif


" set the new fold function, etc
autocmd BufRead,BufNewFile *.pl,*.pm,*.cgi,*.t call MyPerlSettings()
function MyPerlSettings()
	call PerlRun()
    call PerlCritic()
    set smartindent expandtab
endfunction

function! PerlRun()
set makeprg=perl\ -cw\ %\ 2>&1\ \\\|\ perl\ -pe\ \'/at\\s\(\\S\+\)\\sline\\s\(\\d+\)\/\;print\ \"\$1:\$2:\"\;'
	set efm=%f:%l:%m
endfunction

" 'perl -cw' current buffer into a new window
function! PerlCritic()
    set grepformat=%f:%l:%c:m
    set grepprg=perlcritic\ -2\ -verbose\ 1\ %
endfunction

" " JavaScript setting
" autocmd BufRead,BufNewFile *.js call MyJavaScriptSettings( )
" function MyJavaScriptSettings()
"     set filetype=javascript
"     set omnifunc=javascriptcomplete#CompleteJS
"     set smartindent
"     set tabstop=2
"     set shiftwidth=2
" "    let g:AutoComplPop_CompleteOption='.,w,b,u,t,i,k~/.vim/dict/js.dict'
"     let g:acp_behaviorKeywordLength=3
"     let g:acp_completeOption='.,w,b,u,t,i,k~/.vim/dict/js.dict' " acp setting
" endfunction
" 
" " css setting
" autocmd BufRead,BufNewFile *.css call MyCSSSettings()
" function MyCSSSettings()
"     set filetype=css
"     set tabstop=2
"     set shiftwidth=2
"     set nocindent
" "    set omnifunc=acp#meetsForCssOmni
"     set omnifunc=csscomplete#CompleteCSS
"     let g:acp_completeOption='.,w,b,u,t,i,k~/.vim/dict/css.dict' " acp setting
" endfunction
" 
" " html setting
" autocmd BufRead,BufNewFile *.html call MyHTMLSettings()
" function MyHTMLSettings()
"     set filetype=html
"     set omnifunc=htmlcomplete#CompleteTags
" endfunction



au BufRead,BufNewFile *.thtml,*.ctp,*.html setfiletype html
au FileType html call SetHtmlSurround()
function SetHtmlSurround()
"for surround.vim
" [key map]
" 1 : <h1>|</h1>  2 : <h2>|</h2>  3 : <h3>|</h3>
" 4 : <h4>|</h4>  5 : <h5>|</h5>  6 : <h6>|</h6>
"
" p : <p>|</p>    u : <ul>|</ul>        o : <ol>|</ol>
" l : <li>|</li>  a : <a href="">|</a>  A : <a href="|"></a>
" i : <img src="|" alt="" />            I : <img src="" alt"|" />
" d : <div>|</div>                      D : <div class="section">|</div>
    let b:surround_49  = "<h1>\r</h1>"
    let b:surround_50  = "<h2>\r</h2>"
    let b:surround_51  = "<h3>\r</h3>"
    let b:surround_52  = "<h4>\r</h4>"
    let b:surround_53  = "<h5>\r</h5>"
    let b:surround_54  = "<h6>\r</h6>"
                                                          
    let b:surround_112 = "<p>\r</p>"
    let b:surround_117 = "<ul>\r</ul>"
    let b:surround_111 = "<ol>\r</ol>"
    let b:surround_108 = "<li>\r</li>"
    let b:surround_97  = "<a href=\"\">\r</a>"
    let b:surround_65  = "<a href=\"\r\"></a>"
    let b:surround_105 = "<img src=\"\r\" alt=\"\" />"
    let b:surround_73  = "<img src=\"\" alt=\"\r\" />"
    let b:surround_100 = "<div>\r</div>"
    let b:surround_68  = "<div class=\"section\">\r</div>"
endfunction
