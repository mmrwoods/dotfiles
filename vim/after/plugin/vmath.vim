if !exists('g:loaded_vmath')
  finish
endif

" Calculate sum, avg, min, and max of visual selection
vmap <expr> ++ VMATH_YankAndAnalyse()
