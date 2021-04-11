map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['node_modules$[[dir]]']

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
