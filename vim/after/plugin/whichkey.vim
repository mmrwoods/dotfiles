if !exists('g:loaded_vim_which_key')
  finish
endif

" Open WhichKey menu for leader mappings after timeoutlen
nnoremap <silent> <leader> :WhichKey "\<leader>"<CR>

" And for square bracket mappings from vim-unimpaired and friends
nnoremap <silent> ] :WhichKey ']'<CR>
nnoremap <silent> [ :WhichKey '['<CR>

" Workaround for WhichKey bug affecting unimpaired option mappings
" Writes part of RHS of map to buffer, so hide from WHichKey menu
nnoremap <silent> ]o :WhichKey ''<CR>
nnoremap <silent> [o :WhichKey ''<CR>
