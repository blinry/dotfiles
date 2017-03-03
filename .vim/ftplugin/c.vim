"au TextChanged * call s:Play()
"au TextChangedI * call s:Play()

function! s:Play()
    wall!
    silent exec "!make music &> /dev/null"
    silent exec "!sudo killall music"
    silent exec "!sudo sh -c './music > /dev/dsp &'"
endfunction
