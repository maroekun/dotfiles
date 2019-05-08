" fzf {{{
nnoremap [fzf] <Nop>
nmap ,f [fzf]
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]T :<C-u>Filetypes<CR>
nnoremap <silent> [fzf]g :<C-u>GFiles<CR>
nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]c :<C-u>Colors<CR>
nnoremap <silent> [fzf]m :<C-u>Fmru<CR>

" Vaffle {{{
nnoremap <silent> [fzf]v :<C-u>Vaffle %:h<CR>
" }}}

" See: https://github.com/junegunn/fzf.vim#advanced-customization
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Rgc
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>). ' '. expand('%:h'), 1,
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
" vim-markdown "{{{
let g:vim_markdown_folding_disabled=1
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

" quickhl {{{
let g:quickhl_manual_enable_at_startup = 1
let g:quickhl_manual_keywords = [ "TODO", "CAUTION", "DELETED", "NOTE" ]
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
nmap <Space>j <Plug>(quickhl-cword-toggle)
" }}}

" nerdcommenter {{{
let g:NERDSpaceDelims = 1
nmap <Leader>x <plug>NERDCommenterToggle
vmap <Leader>x <plug>NERDCommenterToggle
" }}}

" vim-gitgutter {{{
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
" }}}

" lightline {{{
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
" }}}

" vim: foldmethod=marker
