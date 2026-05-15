if !exists('g:loaded_fugitive')
  finish
endif

nmap <leader>gb :Git blame<CR>
nmap <leader>gd :Git diff %<CR>
nmap <leader>gD :Git diff<CR>
nmap <leader>gg :GitGutterToggle<CR>
nmap <leader>gl :Git log --oneline --follow %<CR>
nmap <leader>gL :Git log --oneline<CR>
nmap <leader>gp :Git peek %<CR>
nmap <leader>gP :Git peek<CR>
command! GitStatus :exe ":Git"
nmap <leader>gs :GitStatus<CR>
nmap <leader>gv :Gvdiffsplit<CR>
