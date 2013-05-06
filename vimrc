" use syntax highlighting
syntax on
 
" make backspace do what it should
"set backspace=eol,start,indent
 
" set tab = 4 spaces
set expandtab
set sw=2
set sts=2
set ts=2
 
" set tab = 2 spaces if ruby file
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
 
" fix splitting from opening in the wrong place
set splitright
set splitbelow

" fix auto-indent pasting
set paste

" use the mouse
set ttyfast
set mouse=a
set ttymouse=xterm2
