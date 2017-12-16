setlocal textwidth=80

setlocal spell spelllang=en_us

" Sets background for 81st column onward
if exists('+colorcolumn')
  let &colorcolumn=join(range(81,999),",")
endif
