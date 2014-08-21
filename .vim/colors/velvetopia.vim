set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "velvetopia"

" Syntax Elements
hi Comment    ctermfg=darkgreen cterm=italic
hi Constant   ctermfg=darkblue cterm=bold
hi Identifier ctermfg=none cterm=none
hi Statement  ctermfg=yellow cterm=bold
hi PreProc    ctermfg=darkgray
hi Type       ctermfg=gray
hi Special    ctermfg=red
hi Delimiter  ctermfg=darkblue
hi Underlined ctermfg=lightblue cterm=underline
hi Error      ctermbg=darkred
hi Todo       ctermfg=black ctermbg=green cterm=bold

hi link Define Statement

" Vim GUI
hi ColorColumn  ctermbg=black
hi LineNr       ctermfg=black
hi StatusLine   ctermbg=black cterm=none
hi StatusLineNC ctermfg=darkgray cterm=inverse
hi TabLine      ctermbg=black cterm=none
hi TabLineFill  ctermbg=black cterm=none
hi TabLineSel   ctermbg=darkgray cterm=none
hi VertSplit    ctermfg=darkgray cterm=inverse
hi Visual       ctermbg=black
