" Custom grep prompt, inspired by vim-grepper, but simpler, runs grepprg in a
" subshell to avoid the "Press ENTER to continue" prompt when running external
" commands, and also allow use of cmdline special characters without escaping
function! Grepper(...)
  echohl Question
  let args = trim(input('grep> ', join(a:000, ' '), 'customlist,GrepperComplete'))
  echohl None
  if empty(args) | redraw! | return | end
  let grepcmd = &grepprg . ' ' . args
  redraw!
  echohl MessageWindow | echo "Running: " . grepcmd | echohl None
  try
    noautocmd cgetexpr system(grepcmd)
    call setqflist([], 'r', #{title: grepcmd})
  catch /^Vim:Interrupt$/
    call setqflist([], 'r', #{title: grepcmd . ' (Interrupted)'})
    echoerr "Interrupted: " . grepcmd
  finally
    redraw! | copen
  endtry
endfunction

" Simple completion for grep prompt, also inspired by vim-grepper
function! GrepperComplete(lead, _line, _pos)
  let args = split(a:lead, '.*\s\zs', 1)
  if len(args) < 2 | return [] | end
  let path = args[-1]
  let head = join(args[0:-2])
  return map(getcompletion(args[-1], 'dir'), 'head . fnameescape(v:val)')
endfun

" Search in files using grep program, see :help grepprg and :help grep
command! Grepper call Grepper()
nnoremap <leader>s :Grepper<CR>
