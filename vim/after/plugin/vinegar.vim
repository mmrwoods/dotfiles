if !exists('g:loaded_vinegar')
  finish
endif

" Workaround for vim-vinegar not working with g:netrw_altfile = 1
" See https://github.com/tpope/vim-vinegar/issues/137
nnoremap - :Explore<CR>:silent! call search('^' . expand('#:t'), 'wc')<CR>
