if !exists('g:loaded_gitgutter')
  finish
endif

" GitGutter normally conflicts with vim comment plugin (or the reverse)
" Both use ic and ac mappings for text objects, so use h with GitGutter
if maparg('[c', 'n') =~# 'GitGutter' " if gitgutter loaded before here
  nunmap [c
  nunmap ]c
endif
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" Hunk mappings, normally <leader>h{s,u,p}
nmap <leader>ghs <Plug>(GitGutterStageHunk)
nmap <leader>ghu <Plug>(GitGutterUndoHunk)
nmap <leader>ghp <Plug>(GitGutterPreviewHunk)

" Additional <leader>g mappings
nmap <leader>gq :GitGutterQuickFixCurrentFile<CR>:copen<CR>
nmap <leader>gQ :GitGutterQuickFix<CR>:copen<CR>
