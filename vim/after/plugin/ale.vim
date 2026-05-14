if !exists('g:loaded_ale')
  finish
endif

" Override ALEToggle to show a message, otherwise you don't know if it has
" been enabled/disabled unless there are some diagnostics appear/disappear
function! ALEToggle()
  if g:ale_enabled
    ALEDisable
    echo 'ALE disabled'
  else
    ALEEnable
    echo 'ALE enabled'
  endif
endfunction
command! ALEToggle call ALEToggle()
