call plug#begin('~/.vim/plugged')

" Addons
Plug 'itchyny/lightline.vim'
Plug 'bswinnerton/vim-base16-lightline'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-rooter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Tmux integration
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" File system navigation
Plug 'tpope/vim-eunuch'

" Syntax highlighting
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-haml'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'jparise/vim-graphql'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'vim-scripts/bird-syntax'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'

" Syntax errors
Plug 'w0rp/ale'
Plug 'ntpeters/vim-better-whitespace'

" Markdown support
Plug 'junegunn/goyo.vim'

" Git support
Plug 'tpope/vim-rhubarb' | Plug 'tpope/vim-fugitive'

" ctags
Plug 'ludovicchabant/vim-gutentags'

" Themes
Plug 'chriskempson/base16-vim'
Plug 'folke/tokyonight.nvim'

" Testing
Plug 'janko-m/vim-test'
Plug 'bswinnerton/vim-test-github'

" Display hex colors
Plug 'chrisbra/Colorizer'

" Gist
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'

call plug#end()
