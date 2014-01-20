" Use Vim settings, rather then Vi settings (much better!).
" " This must be first, because it changes other options as a side effect.
set nocompatible

" use syntax highlighting
syntax on
 
" set tab = 4 spaces
set expandtab
set sw=2
set ts=2
 
" fix splitting from opening in the wrong place
set splitright
set splitbelow

" use the mouse
set ttyfast
set mouse=a
set ttymouse=xterm2

" Vundle requirements
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "vim-ruby/vim-ruby"
Bundle "tpope/vim-bundler"
Bundle "tpope/vim-rails"
Bundle "kchmck/vim-coffee-script"
Bundle "tpope/vim-markdown"

filetype plugin indent on
