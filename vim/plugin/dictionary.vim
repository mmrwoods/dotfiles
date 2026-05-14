if !executable("dict")
  finish
endif

" Lookup current word using dict program and show results in preview win
" FIXME: does not work with previewpopup
function! <SID>Dict(word)
  silent! exe "noautocmd pedit dict \\\"" . a:word . "\\\""
  noautocmd wincmd P
  setlocal modifiable
  setlocal buftype=nofile
  setlocal nobuflisted
  setlocal nofoldenable
  setlocal statusline=%f
  setlocal keywordprg=:Dict
  nnoremap <buffer><silent> q :bw!<CR>

  silent! exe "noautocmd r! dict \"" . a:word . "\""
  silent! exe "1d_"
  silent! exe "gg"
  setlocal nomodifiable
endfunction
command! -nargs=1 Dict :call <SID>Dict(<q-args>)

augroup vimrc_dict
  au!
  autocmd FileType text,markdown,gitcommit,hgcommit,asciidoc,rst,rdoc
    \ setlocal keywordprg=:Dict
augroup END
