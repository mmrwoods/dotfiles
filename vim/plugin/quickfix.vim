function! QuickfixToggle()
  if get(getqflist({'winid': 1}), 'winid') != 0
    cclose
  elseif getqflist() != []
    copen
  else
    echohl ErrorMsg
    echo "Quickfix List is empty."
    echohl None
  endif
endfunction
command! QuickfixToggle call QuickfixToggle()
nnoremap <silent><leader>q :QuickfixToggle<CR>

function! LocListToggle()
  if get(getloclist(winnr(), {'winid': 1}), 'winid') != 0
    lclose
  elseif getloclist(winnr()) != []
    lopen
  else
    echohl ErrorMsg
    echo "Location List is empty."
    echohl None
  endif
endfunction
command! LocListToggle call LocListToggle()
nnoremap <silent><leader>l :LocListToggle<CR>

augroup vimrc_quickfix
  au!

  " Use q to close the quickfix window and return to the previous window
  autocmd FileType qf nnoremap <silent> <buffer> q :wincmd p<CR>:cclose<CR>:wincmd =<CR>

  " Fix previous window navigation when existing quickfix window re-used
  autocmd QuickFixCmdPre * if &ft == 'qf' | wincmd p | end
augroup END
