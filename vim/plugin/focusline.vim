" Only show cursorline in current window, easy to locate current window
" Note: Both Buf{Enter,Leave} and Win{Enter,Leave} required to handle
" various edge cases with popups, same buffer in multiple windows etc.
" Add exception to work alongside hack to auto reveal file in NERDTree
set nocursorline
augroup vimrc_focusline
  au!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave,BufLeave * if &filetype != 'nerdtree' | setlocal nocursorline | endif
augroup END
