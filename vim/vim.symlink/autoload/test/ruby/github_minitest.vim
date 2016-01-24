" This is a custom vim-test test runner for github/github. It's based largely
" on vim-test's Minitest runner, but uses the line numbers of the test
" descriptions rather than the raw test descriptions themselves.
"
" NOTE: Only works for Minitest Spec syntax

if !exists('g:test#ruby#github_minitest#file_pattern')
  let g:test#ruby#github_minitest#file_pattern = '_test\.rb$'
endif

function! test#ruby#github_minitest#test_file(file) abort
  return a:file =~# g:test#ruby#github_minitest#file_pattern
endfunction

function! test#ruby#github_minitest#build_position(type, position) abort
  if a:type == 'nearest'
    " Use vim-test's logic to determine the name of the test we're currently
    " in
    let name = s:nearest_test(a:position)

    " In the event there are any double quotes in the test, escape them
    let escaped_name = escape(name, '"')

    " Set up the grep command to determine the line number of the test
    " description
    let grep = 'grep -n "'.escaped_name.'" '.a:position['file'].' | cut -f1 -d:'

    " Execute the grep and remove the newline
    let line_number = system(grep)[:-2]

    return [a:position['file'], '--name', '/L'.line_number.'/']
  elseif a:type == 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

function! test#ruby#github_minitest#build_args(args) abort
  for idx in range(0, len(a:args) - 1)
    if test#base#file_exists(a:args[idx])
      let path = remove(a:args, idx) | break
    endif
  endfor

  if exists('path') && isdirectory(path)
    let path = fnamemodify(path, ':p:.') . '**/*_test.rb'
  elseif !exists('path')
    let path = 'test/**/*_test.rb'
  endif

  for option in ['--name', '--seed']
    let idx = index(a:args, option)
    if idx != -1
      let value = remove(a:args, idx + 1)
      let a:args[idx] = option.'='.shellescape(value, 1)
    endif
  endfor

  " Pass directly to ruby args since we don't want to excute Rake
  return s:build_ruby_args(get(l:, 'path'), a:args)
endfunction

function! s:build_ruby_args(path, args) abort
  if a:path =~# '*'
    return ['-e '.shellescape('Dir["./'.a:path.'"].each &method(:require)')] + a:args
  else
    return [a:path] + a:args
  endif
endfunction

function! test#ruby#github_minitest#executable() abort
  " Always return the preferred executable
  return 'script/testrb_or_zt'
endfunction

" http://chriskottom.com/blog/2014/12/command-line-flags-for-minitest-in-the-raw/
function! s:nearest_test(position) abort
  let syntax = s:syntax(a:position['file'])
  let name = test#base#nearest_test(a:position, g:test#ruby#patterns)

  let namespace = filter([test#base#escape_regex(join(name['namespace'], '::'))], '!empty(v:val)')
  if empty(name['test'])
    let test = ''
  else
    " Return the contents of the test description
    let test = name['test'][0]
  endif

  return test
endfunction

function! s:syntax(file) abort
  let lines = split(system('cat '.a:file), '\n')

  if !empty(filter(copy(lines), 'v:val =~# g:test#ruby#patterns["test"][1]'))
    return 'rails'
  elseif !empty(filter(copy(lines), 'v:val =~# g:test#ruby#patterns["test"][2]'))
    return 'spec'
  else
    return 'test'
  endif
endfunction
