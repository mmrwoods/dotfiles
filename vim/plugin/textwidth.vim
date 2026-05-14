" Highlight long lines in active window rather than display colorcolumn
" Note: set custom hlgroup as goyo.vim overrides CursorColumn when active
function! <SID>SetTextWidthHl()
  let hlgroup_attrs = hlget('ColorColumn')[0]
  let hlgroup_attrs['name'] = 'TextWidth'
  call hlset([hlgroup_attrs])
endfunction
call <SID>SetTextWidthHl()

function! <SID>HighlightTextWidth()
  if exists('w:textwidth_mid')
    silent! call matchdelete(w:textwidth_mid)
  endif
  if empty(&buftype) && &textwidth > 0
    let w:textwidth_mid = matchadd('TextWidth', '\%'.(&tw+1).'v.\+', -1)
  endif
endfunction

augroup vimrc_textwidth
  au!
  autocmd ColorScheme * call <SID>SetTextWidthHl()
  autocmd WinEnter,BufEnter * call <SID>HighlightTextWidth()
  autocmd WinLeave,BufLeave * silent! call matchdelete(w:textwidth_mid)
  if exists('##OptionSet')
    autocmd OptionSet textwidth call <SID>HighlightTextWidth()
  endif
augroup END
