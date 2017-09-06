setlocal textwidth=80

" Sets background for 81st column onward
if exists('+colorcolumn')
  let &colorcolumn=join(range(81,999),",")
endif
