" remap CTRL-] to use :tjump rather than :tag
" shows list when multiple matches, see :h g_CTRL-]
nnoremap <C-]> g<C-]>

" remap g] to jump to tag in next window or new split
function! TJumpSplit()
  let currword = expand("<cword>")
  let startwin = winnr()
  " Move to next window with a normal buffer
  let currwin = startwin
  let lastwin = winnr('$')
  while currwin < lastwin
    exec 'wincmd w'
    if empty(getbufvar(+expand("<abuf>"), "&buftype"))
      break
    endif
    let currwin = currwin + 1
  endwhile
  " Back where we started? Open a new split
  if winnr() == startwin
    exec 'wincmd v'
  endif
  try
    exec "tjump " . currword
  catch
    " Close window if we opened a new split
    if winnr() > lastwin
      close
    endif
    echoerr v:exception
  endtry
endfunction
command! TJumpSplit call TJumpSplit()
nnoremap g] :TJumpSplit<CR>
