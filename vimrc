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
if exists('+colorcolumn')
  set colorcolumn=80
endif
highlight LineNr ctermbg=244
highlight LineNr ctermfg=253
highlight CursorLine cterm=none ctermbg=236
highlight CursorColumn cterm=none ctermbg=236
highlight ColorColumn ctermbg=235
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

" ignore files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/bundle/*

" vundle requirements
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-markdown'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'benmills/vimux'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-haml'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'christoomey/vim-tmux-navigator'

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
