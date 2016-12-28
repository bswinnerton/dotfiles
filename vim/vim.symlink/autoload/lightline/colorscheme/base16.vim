let s:base00 = [ '#181818',  0 ] " black
let s:base01 = [ '#282828', 18 ]
let s:base02 = [ '#383838', 19 ]
let s:base03 = [ '#585858',  8 ]
let s:base04 = [ '#B8B8B8', 20 ]
let s:base05 = [ '#D8D8D8',  7 ]
let s:base06 = [ '#E8E8E8', 21 ]
let s:base07 = [ '#F8F8F8', 15 ] " white

let s:base08 = [ '#AB4642',  1 ] " red
let s:base09 = [ '#DC9656', 16 ] " orange
let s:base0A = [ '#F7CA88',  3 ] " yellow
let s:base0B = [ '#A1B56C',  2 ] " green
let s:base0C = [ '#86C1B9',  6 ] " teal
let s:base0D = [ '#7CAFC2',  4 ] " blue
let s:base0E = [ '#BA8BAF',  5 ] " pink
let s:base0F = [ '#A16946', 17 ] " brown

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:base00, s:base0D ], [ s:base05, s:base02 ] ]
let s:p.insert.left     = [ [ s:base00, s:base0B ], [ s:base0B, s:base00 ] ]
let s:p.visual.left     = [ [ s:base00, s:base09 ], [ s:base09, s:base00 ] ]
let s:p.replace.left    = [ [ s:base00, s:base08 ], [ s:base08, s:base00 ] ]
let s:p.inactive.left   = [ [ s:base00, s:base02 ] ]

let s:p.normal.middle   = [ [ s:base05, s:base01 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]

let s:p.normal.right    = [ [ s:base01, s:base0D ], [ s:base05, s:base02 ] ]
let s:p.inactive.right  = [ [ s:base00, s:base02 ] ]

let s:p.normal.error    = [ [ s:base07, s:base08 ] ]
let s:p.normal.warning  = [ [ s:base07, s:base09 ] ]

let s:p.tabline.left    = [ [ s:base03, s:base00 ] ]
let s:p.tabline.middle  = [ [ s:base05, s:base00 ] ]
let s:p.tabline.right   = [ [ s:base00, s:base00 ] ]
let s:p.tabline.tabsel  = [ [ s:base0B, s:base01 ] ]

let g:lightline#colorscheme#base16#palette = lightline#colorscheme#flatten(s:p)
