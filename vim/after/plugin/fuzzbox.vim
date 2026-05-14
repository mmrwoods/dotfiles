if !exists('g:loaded_fuzzbox')
  finish
endif

" Use same devicon colors in fuzzbox, nerdtree, and bufexplorer
hi link NERDTreeFlags Normal
augroup vimrc_fuzzbox
  au!
  autocmd FileType nerdtree,bufexplorer
    \ try |
    \   call fuzzbox#devicons#Colorize() |
    \   catch /\v:(E700|E117):/ |
    \ endtry
augroup END
