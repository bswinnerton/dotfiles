" use Vim settings, rather then Vi settings (much better!).
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

" make ctrl-shift-o faster
set ttimeoutlen=100

" don't deselect visual block after indent/unindent
vnoremap < <gv
vnoremap > >gv

" use line numbers, cursor and colors
set number
set cursorline
set cursorcolumn
highlight LineNr ctermbg=244
highlight LineNr ctermfg=253
highlight CursorLine cterm=none ctermbg=236
highlight CursorColumn cterm=none ctermbg=236
set lazyredraw " hack to let curosrline bg not redraw every scroll
highlight CursorLineNr ctermfg=green ctermbg=240
highlight SignColumn ctermbg=none

" hide horizontal cursor when focus changes
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" hide vertical cursor when focus changes
augroup CursorColumn
    au!
    au VimEnter * setlocal cursorcolumn
    au WinEnter * setlocal cursorcolumn
    au BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorcolumn
augroup END

" highlight extra whitespace
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/

" easy access to the shell
map <Leader><Leader> :!

" vundle requirements
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

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
Bundle "christoomey/vim-tmux-navigator"

call vundle#end()
filetype plugin indent on

" ack-vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd vimenter * if !argc() | NERDTree | endif

" vimux
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
