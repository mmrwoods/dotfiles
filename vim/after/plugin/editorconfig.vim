if !exists('g:loaded_EditorConfig')
  finish
endif

" Use an EditorConfig hook to set b:editorconfig, similar to Neovim
" Allows other autocmds to check what has been applied by EditorConfig
" Note: EditorConfig also runs on BufNew, e.g. when opening a new file, or when
" populating the quickfix list, and the buffer it is configuring is <abuf>,
" which is not necessarily the current buffer, so don't just set b:editorconfig
function! <SID>EditorConfigHook(config)
  let bufnr = str2nr(expand('<abuf>'))
  call setbufvar(bufnr > 0 ? bufnr : bufnr('%'), 'editorconfig', a:config)
endfunction
call editorconfig#AddNewHook(function('<SID>EditorConfigHook'))
