" Focus the current window for distraction free reading and writing
" Just launches goyo.vim, see https://github.com/junegunn/goyo.vim
let g:goyo_width = 100
function! ZenMode() abort
  if exists('#goyo')
    execute 'Goyo'
  else
    let width = g:goyo_width
    if empty(&buftype) && &textwidth > 0
      if (&tw + (&tw / 20)) > width
        let width = (&tw + (&tw / 20))
      endif
    endif
    execute 'Goyo' . width
  endif
endfunction
command! ZenMode call ZenMode()
nnoremap <Leader>z :ZenMode<CR>
