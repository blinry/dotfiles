set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "velvetopia"

" Syntax Elements
hi Comment    ctermfg=green cterm=italic
hi String     ctermfg=blue
hi Statement  ctermfg=yellow cterm=bold
hi Operator   ctermfg=darkblue cterm=bold
hi PreProc    ctermfg=darkgray
hi Type       ctermfg=yellow cterm=bold
hi Special    ctermfg=blue cterm=bold
hi Delimiter  ctermfg=blue cterm=bold
hi Underlined ctermfg=blue cterm=underline
hi Error      ctermfg=white ctermbg=red
hi Todo       ctermfg=green ctermbg=none cterm=inverse
hi Define     ctermfg=yellow cterm=bold

"hi link Define Statement

" Vim GUI
hi ColorColumn  ctermbg=black
hi LineNr       ctermfg=black
hi StatusLine   ctermbg=darkgray cterm=none
hi StatusLineNC ctermfg=white ctermbg=black cterm=none
hi TabLine      ctermbg=black cterm=none
hi TabLineFill  ctermbg=black cterm=none
hi TabLineSel   ctermbg=darkgray cterm=none
hi VertSplit    ctermfg=darkgray cterm=inverse
hi Visual       ctermbg=darkgray

" Git stuff

hi DiffAdd ctermfg=green ctermbg=none
hi DiffChange ctermbg=black
hi DiffDelete ctermfg=red ctermbg=none

hi link diffAdded DiffAdd
hi link diffChanged DiffChange
hi link diffRemoved DiffDelete

"" Terminal cursor
"
"hi link TermCursor Cursor
"hi TermCursorNC ctermbg=white
