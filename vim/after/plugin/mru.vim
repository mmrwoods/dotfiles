if !exists('g:loaded_mru')
  finish
endif

" List most recently used files
nnoremap <leader>m :MRUToggle<CR>

" Most recently used files within current working directory
command! MRUCwd execute 'MRU ' . getcwd()
nnoremap <leader>r :MRUCwd<CR>

" Most recently used files within project root directory
if exists('*FindRootDirectory')
  command! MRURoot execute 'MRU ' . FindRootDirectory()
  nnoremap <leader>R :MRURoot<CR>
endif
