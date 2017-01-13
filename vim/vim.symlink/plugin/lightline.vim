let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive' ], [ 'filename' ] ],
	\ 	'right': [ [ 'cursorpercentage' ], [ 'fileformatting' ], [ 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightlineFugitive',
  \   'readonly': 'LightlineReadonly',
  \   'modified': 'LightlineModified',
  \   'filename': 'LightlineFilename',
	\ 	'fileformatting': 'LightlineFileFormatting',
	\   'cursorpercentage': 'LightlineCursorPercentage'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ 'colorscheme': 'base16',
  \ }

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '  '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand("%.:h")  ? expand("%.:h") : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "[+]"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightlineFileFormatting()
	return "" . &fileencoding . "[" . &fileformat . "]"
endfunction

function! LightlineCursorPercentage()
	let currentLine = line(".") * 1.0
	let lastLine 		= line("$") * 1.0
	let percentage = float2nr((currentLine / lastLine) * 100)
	return " " . string(percentage) . "%  " . line(".") . "/" . line("$") . "☰ :  " . col(".")
endfunction
