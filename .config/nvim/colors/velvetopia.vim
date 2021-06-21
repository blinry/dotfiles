set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "velvetopia"

" Syntax Elements
hi Comment    ctermfg=green cterm=italic
hi Constant   ctermfg=none
hi String     ctermfg=blue
hi Identifier ctermfg=gray cterm=none
hi Statement  ctermfg=yellow cterm=bold
hi Operator   ctermfg=darkblue cterm=bold
hi PreProc    ctermfg=darkgray
hi Type       ctermfg=yellow cterm=bold
hi Special    ctermfg=blue cterm=bold "red
hi Delimiter  ctermfg=darkblue
hi Underlined ctermfg=blue cterm=underline
hi Error      ctermfg=white ctermbg=red
hi Todo       ctermfg=green ctermbg=none cterm=inverse
hi Define     ctermfg=yellow cterm=bold

hi link Define Statement

" Vim GUI
hi ColorColumn  ctermbg=black
hi LineNr       ctermfg=black
hi StatusLine   ctermbg=black cterm=none
hi StatusLineNC ctermfg=darkgray cterm=inverse
hi TabLine      ctermbg=black cterm=none
hi TabLineFill  ctermbg=black cterm=none
hi TabLineSel   ctermbg=none cterm=none
hi VertSplit    ctermfg=darkgray cterm=inverse
hi Visual       ctermbg=black

" Git stuff

hi DiffAdd ctermbg=black
hi DiffChange ctermbg=black
hi DiffDelete ctermbg=black

" Terminal cursor

"hi link TermCursor Cursor
"hi TermCursorNC ctermbg=white
