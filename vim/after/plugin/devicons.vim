if !exists('g:loaded_webdevicons')
  finish
endif

" Update devicon glyphs for nerd fonts v3
" See https://github.com/ryanoasis/vim-devicons/issues/452
" And https://github.com/ryanoasis/vim-devicons/pull/454
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex']    = '󰙧'  " nf-md-stop_circle_outline
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cs']     = '󰌛'  " nf-md-language_csharp
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['r']      = '󰟔'  " nf-md-language_r
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rproj']  = '󰗆'  " nf-md-vector_rectangle
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sol']    = '󰡪'  " nf-md-ethereum
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pem']    = '󰌋'  " nf-md-key_variant
" And other nerd font glyphs that are missing from vim-devicons
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['kt']     = '󱈙' " nf-md-language_kotlin
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['lisp']   = '' " nf-custom-common_lisp
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ps1']    = '󰨊' " nf-md-powershell
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['zig']    = '' " nf-seti-zig
