let test#strategy = "vimux"

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

" Rather than build a whole new vimux strategy for github/github and
" github/hookshot, these two autocmds rely on script/tt to provide RSpec-like
" line number execution.
autocmd BufRead,BufNewFile $HOME/github/github/* nmap <silent> <leader>t :VimuxRunCommand("clear; script/tt ".@%.":".line("."))<CR>
autocmd BufRead,BufNewFile $HOME/github/hookshot/* nmap <silent> <leader>t :VimuxRunCommand("clear; script/tt ".@%.":".line("."))<CR>
