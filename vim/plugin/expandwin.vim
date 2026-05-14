" Expand/maximize current window (similar to tmux expand pane)
" See https://stackoverflow.com/a/26551079/17278003
function! ExpandWin() abort
  if winnr('$') == 1 | return | endif
  if exists('w:expanded') && w:expanded
    execute w:expand_winrestcmd
    let w:expanded = 0
  else
    let w:expand_winrestcmd = winrestcmd()
    resize
    vertical resize
    let w:expanded = 1
  endif
endfunction
command! ExpandWin call ExpandWin()

augroup vimrc_expandwin
  au!
  autocmd WinLeave * if exists('w:expanded') && w:expanded | call ExpandWin() | endif
augroup END

nnoremap <Leader>x :ExpandWin<CR>
