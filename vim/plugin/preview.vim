function! Preview()
  if !empty(&buftype) || empty(bufname('%')) || !filereadable(expand('%'))
    echoerr "Cannot view file: invalid buffer type or file not found"
    return
  endif
  let cmd = ''
  if &ft == 'markdown' && executable('glow')
    let cmd = 'glow -w 120 -p %'
  elseif &ft == 'markdown' && executable('mdcat')
    let cmd = 'mdcat -p %'
  elseif &ft =~ '\v(x)?html' && executable('w3m')
    let cmd = 'w3m %'
  endif
  if empty(cmd)
    echohl ErrorMsg
    echo "No previewer for filetype '" . &filetype . "'"
    echohl None
    return
  endif
  let title = expandcmd(cmd, '%:~:.')
  " FIXME: use popup and remove floaterm dependency
  silent execute 'FloatermNew --disposable --titleposition=center --title=\ ' . substitute(title, ' ', '\\ ', 'g')  .  '\  ' . cmd
endfunction
command! Preview call Preview()
nnoremap <Leader>v :Preview<CR>
