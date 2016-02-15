if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Don't start searching until typing has stopped
let g:ctrlp_lazy_update = 200
