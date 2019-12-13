"let &makeprg = "latexmk -pdf -pv %"
"let &makeprg = "latexmk -pdf -pv -auxdir=~/.cache/latexmk/ %"

nnoremap gf :call <SID>OpenPaperUnderCursor()<CR>

fu! s:OpenPaperUnderCursor()
    let s:bak=@"

    normal mcyaw`c
    silent execute "!xdg-open %:p:h/../references/".fnameescape(@").".pdf &>/dev/null &"
    redraw!

    let @+=@"
    let @"=s:bak
endf
