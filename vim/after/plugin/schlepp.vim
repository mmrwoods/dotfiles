if !exists('g:Schlepp#Loaded')
  finish
endif

" Move block selections around in visual mode with schlepp plugin
vmap <C-Up> <Plug>SchleppUp
vmap <C-Down> <Plug>SchleppDown
vmap <C-Left> <Plug>SchleppLeft
vmap <C-Right> <Plug>SchleppRight
