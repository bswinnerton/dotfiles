" Two spaces for tabs everywhere
setlocal expandtab shiftwidth=2 tabstop=2

" Insert binding.pry
map <silent> <Leader>p orequire "pry"; binding.pry<ESC>
map <silent> <Leader>P orescue<CR>require "pry"; binding.pry<ESC>
