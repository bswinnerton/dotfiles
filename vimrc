"-------------------------------------------------------------------------------
" Basic Settings
"-------------------------------------------------------------------------------

" Syntax highlighting
syntax on

" Leader - override default of \
let mapleader=','

" Command mode menu suggestions
set wildmenu

" Backspace
set backspace=indent,eol,start

" Backup files (none)
set nobackup
set nowritebackup
set noswapfile

" Tabs
set expandtab
set shiftwidth=2
set tabstop=2

" Searching
set hlsearch
set smartcase
set incsearch
set ignorecase
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR><Esc>:let @/=''

" Splits - more intuitive placement
set splitright
set splitbelow

" Mouse support
if has('mouse')
  set mouse=a
endif

" Scroll buffer
set scrolloff=5

" Auto reload changed files
set autoread

" Clipboard support (OSX)
set clipboard=unnamed

" Ignored files/directories from Vim autocomplete
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/bundle/*,*/public/test/*

" Turn off bells
set noerrorbells
set novisualbell

" Show status line on startup
set laststatus=2


"-------------------------------------------------------------------------------
" Vim Interface
"-------------------------------------------------------------------------------

set number
set cursorline
set cursorcolumn

" Highlight 81st character column
if exists('+colorcolumn')
  set colorcolumn=81
endif

" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/

" Reduce redraw frequency
set lazyredraw

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Hide horizontal cursor when focus changes
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Hide vertical cursor when focus changes
augroup CursorColumn
    au!
    au VimEnter * setlocal cursorcolumn
    au WinEnter * setlocal cursorcolumn
    au BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorcolumn
augroup END

" Spellcheck
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
set complete+=kspell


"-------------------------------------------------------------------------------
" Colors
"-------------------------------------------------------------------------------

set t_Co=16
set background=light

highlight LineNr ctermbg=245
highlight LineNr ctermfg=253
highlight CursorLine cterm=none ctermbg=236
highlight CursorColumn cterm=none ctermbg=236
highlight ColorColumn ctermbg=235
highlight CursorLineNr ctermfg=green ctermbg=240
highlight SignColumn ctermbg=none

" Automatically remove trailing whitespace
"autocmd BufWritePre * :%s/\s\+$//e


"-------------------------------------------------------------------------------
" Custom Movement
"-------------------------------------------------------------------------------

" Don't deselect visual block after indent/unindent
vnoremap < <gv
vnoremap > >gv

" Shortcut for <CTRL> + hjkl to traverse panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Bash like keys for the Vim command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk


"-------------------------------------------------------------------------------
" Custom Mappings
"-------------------------------------------------------------------------------

" Easy access to run commands from Vim
map <Leader><Leader> :!

" Redraw the screen
map <silent> <Leader>rr :redraw!

" Wrap `binding.pry` rescue block around visual selection
autocmd FileType ruby map <silent> <Leader>p dO#################	require 'pry'beginrescue => exceptionbinding.pry<Esc>jo#################<Esc>4ko##################################<Esc>P

" Run the associated spec in the below tmux pane(dependent on Rails.vim)
autocmd FileType ruby map <silent> <Leader>rs :AS,rb:q


"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

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
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-endwise'
Plugin 'rizzatti/dash.vim'
Plugin 'walm/jshint.vim'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'

call vundle#end()
filetype plugin indent on

" ack-vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" NERDTree
map <C-n> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"autocmd vimenter * if !argc() | NERDTree | endif

" vimux
map <Leader>rb :call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>
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
