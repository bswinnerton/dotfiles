" Two spaces for tabs everywhere
setlocal expandtab shiftwidth=2 tabstop=2

" Insert binding.pry
map <silent> <Leader>p orequire "pry"; binding.pry<ESC>
map <silent> <Leader>P orescue<CR>require "pry"; binding.pry<ESC>

" Sets background for 81st column onward
if exists('+colorcolumn')
  let &colorcolumn=join(range(81,999),",")
endif
