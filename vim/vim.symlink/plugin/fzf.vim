" Map CtrlP to FZF
nnoremap <C-p> :FZF<CR>

" Make jump to tag open up FZF
nnoremap <c-]> :Tags <c-r><c-w><cr>

function! s:fzf_statusline()
  setlocal statusline=\FZF
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Create a search command that uses Ripgrep and offers previews
command! -bang -complete=file -nargs=* Search
  \ call fzf#vim#grep(
  \   'rg --smart-case --vimgrep --no-heading --color=always '.<q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
