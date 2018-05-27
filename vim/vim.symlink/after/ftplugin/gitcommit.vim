" Courtesy of @aroben via https://git.io/vD4CV
"
" Put this in your .vimrc and whenever you `git commit` you'll see the diff of
" your commit next to your commit message.  For the most accurate diffs, use
" `git config --global commit.verbose true`

" BufRead seems more appropriate here but for some reason the final `wincmd p`
" doesn't work if we do that.
autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
function OpenCommitMessageDiff()
  " Save the contents of the original registers
  let old_z = getreg("z")
  let old_z_type = getregtype("z")

  try
    call cursor(1, 0)
    let diff_start = search("^diff --git")
    if diff_start == 0
      " There's no diff in the commit message; generate our own.
      let @z = system("git diff --cached -M -C")
    else
      " Yank diff from the bottom of the commit message into the z register
      :.,$yank z
      call cursor(1, 0)
    endif

    " Depending on the width of the window, split vertically or horiziontal
    "
    " 144 is wide enough to display two 72 character commit messages
    if winwidth(0) >= 144
      " Fetch the contents of the git log
      let old_q = getreg("q")
      let old_q_type = getregtype("q")
      let @q = system("git log")

      " Open a new vertical split
      vnew

      " Insert the contents of the diff
      normal! V"zP

      " Set the filetype for syntax highlighting and lock for modifications
      set filetype=diff noswapfile nomodified readonly
      silent file [Changes\ to\ be\ committed]

      " Open a new horizontal split
      new

      " Insert the contents of the git log
      normal! V"qP

      " Set the name type for syntax highlighting and lock for modifications
      set filetype=git noswapfile nomodified readonly
      silent file [Git\ log]

      " Restore the q register
      call setreg("q", old_q, old_q_type)

      " Get back to the commit message
      wincmd h
    else
      new
      normal! V"zP

      " Set the name type for syntax highlighting and lock for modifications
      set filetype=git noswapfile nomodified readonly
      silent file [Changes\ to\ be\ committed]

      " Get back to the commit message
      wincmd p
    endif
  finally
    " Restore the z register
    call setreg("z", old_z, old_z_type)
  endtry
endfunction
