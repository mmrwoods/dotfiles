if !exists('g:loaded_nerd_tree')
  finish
endif

" Override NERDTreeToggle to locate the current file in the tree when opening
function! NERDTreeToggle()
  if g:NERDTree.IsOpen()
    NERDTreeClose
  elseif filereadable(expand('%'))
    NERDTreeFind
    exe "norm! zz"
  else
    NERDTreeFocus
  endif
endfunction
command! NERDTreeToggle call NERDTreeToggle()

" Automatically reveal current file in NERDTree
augroup vimrc_nerdtree
  au!
  autocmd BufFilePost *
    \ if empty(&buftype) && exists('g:NERDTree') && g:NERDTree.IsOpen() |
    \   noautocmd NERDTreeRefreshRoot |
    \ endif
  autocmd WinEnter,BufEnter *
    \ if empty(&buftype) && exists('g:NERDTree') && g:NERDTree.IsOpen()
    \ && filereadable(expand('%')) && stridx(fnamemodify(expand('%'), ':p'), getcwd()) == 0 |
    \   noautocmd NERDTreeFind | exe "norm! zz" | noautocmd wincmd p |
    \ endif
augroup END
