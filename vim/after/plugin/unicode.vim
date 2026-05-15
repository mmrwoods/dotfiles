if !exists('g:loaded_unicodePlugin')
  finish
endif

" Note: <C-X><C-Z> for ins-completion of unicode chars

" Search for specific digraph char
nnoremap <leader>ud :Digraphs<SPACE>
" Search for specific Unicode char
nnoremap <leader>us :UnicodeSearch<SPACE>
" Search for specific Unicode char (and insert at current cursor position)
nnoremap <leader>ui :UnicodeSearch!<SPACE>
" Identify character under cursor (like ga command)
nnoremap <leader>un :UnicodeName<CR>
" Print Unicode Table in new window
nnoremap <leader>ut :UnicodeTable<CR>
nnoremap <leader>uh :help unicode-commands<CR>
