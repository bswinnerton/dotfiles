" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" reset leader
let mapleader=','

" use syntax highlighting
syntax on

" make backspace work the way it should
set backspace=2

" only use 16 colors
set t_Co=16

" no swp / backup files
set nobackup
set nowritebackup
set noswapfile

" set tab
set expandtab
set sw=2
set ts=2

" highlight for search
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
 
" fix splitting from opening in the wrong place
set splitright
set splitbelow

" use the mouse
set ttyfast
set mouse=a
set ttymouse=xterm2

" leave a 5 line buffer when scrolling
set scrolloff=5

" don't deselect visual block after indent/unindent
vnoremap < <gv
vnoremap > >gv

" use line numbers and colors
set number
set cursorline
highlight LineNr ctermbg=244
highlight LineNr ctermfg=253
highlight CursorLine cterm=none
highlight CursorLineNr ctermfg=green
highlight CursorLineNr ctermbg=240
highlight SignColumn ctermbg=none

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
Bundle "kien/ctrlp.vim"
Bundle "tpope/vim-fugitive"
Bundle "mileszs/ack.vim"
Bundle "benmills/vimux"
Bundle "groenewege/vim-less"
Bundle "tpope/vim-haml"
Bundle "scrooloose/nerdtree"
Bundle "airblade/vim-gitgutter"
Bundle "bling/vim-airline"
Bundle "terryma/vim-multiple-cursors"
Bundle "scrooloose/syntastic"

filetype plugin indent on

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd vimenter * if !argc() | NERDTree | endif

" Vimux
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vx :VimuxInterruptRunner<CR>
map <Leader>vz :call VimuxZoomRunner()<CR>

" vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-g>'
let g:multi_cursor_prev_key='<C-h>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
