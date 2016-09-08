let test#strategy = "vimux"
let test#runners = {'Ruby': ['GitHub']}

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
