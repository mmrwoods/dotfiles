if !exists('g:loadedCutlass')
  finish
endif

" Add cut/move mappings (delete operations overridden by vim-cutlass to just
" delete, not yank and delete, see https://github.com/svermeulen/vim-cutlass)
" Warning: breaks "m{a-zA-Z}" command to set named marks, and "M" to move to
" the middle of screen. Use alternate mappings gm and Z for these instead.
nnoremap gm m
nnoremap Z M
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D
