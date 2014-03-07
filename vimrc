" Use Vim settings, rather then Vi settings (much better!).
" " This must be first, because it changes other options as a side effect.
set nocompatible

" use syntax highlighting
syntax on

" make backspace work the way it should
set backspace=indent,eol,start

" highlight for search
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" don't deselect visual block after indent/unindent
vnoremap < <gv
vnoremap > >gv

" only use 16 colors
set t_Co=16

" make backspace work the way it should
set backspace=indent,eol,start

" use line numbers
set number
highlight LineNr ctermbg=244
highlight SignColumn ctermbg=none
highlight LineNr ctermfg=253
 
" set tab = 4 spaces
set expandtab
set sw=2
set ts=2

" reset leader
let mapleader=","
 
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
" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
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
