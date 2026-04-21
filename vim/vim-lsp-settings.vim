" prabirshrestha/vim-lsp config

" global mappings copied from Neovim defaults
" see https://neovim.io/doc/user/lsp.html
nnoremap gra <plug>(lsp-code-action-float)
nnoremap gri <plug>(lsp-implementation)
nnoremap grn <plug>(lsp-rename)
nnoremap grr <plug>(lsp-references)
nnoremap grt <plug>(lsp-type-definition)
nnoremap gO <plug>(lsp-document-symbol)
inoremap <C-S> <plug>(lsp-signature-help)
" and additions of mine
nnoremap grd <plug>(lsp-document-diagnostics)
nnoremap [d :LspPreviousDiagnostic<CR>
nnoremap ]d :LspNextDiagnostic<CR>

" Turn down the diagnostic dials!
hi! link LspErrorHighlight Underlined
hi! link LspHintHighlight Underlined
hi! link LspInformationHighlight Underlined
hi! link LspWarningHighlight Underlined

let g:lsp_use_native_client = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_signature_help_enabled = 0

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('/tmp/vim-lsp.log')

" Use LSP for omni-completion if supported
autocmd User lsp_buffer_enabled
  \ if lsp#get_server_names()->filter("lsp#capabilities#has_completion_provider(v:val)")->len() > 0 |
  \   setlocal omnifunc=lsp#complete |
  \   setlocal complete-=t |
  \   setlocal complete+=o |
  \ endif

" Use CTRL-] and other tag related commands to jump to symbol locations
" Note: don't mess with gd, jumps to local declaration (e.g. imports)
autocmd User LspAttached
  \ if lsp#get_server_names()->filter("lsp#capabilities#has_definition_provider(v:val)")->len() > 0 |
  \   setlocal tagfunc=lsp#lsp#TagFunc |
  \ endif

" Use gq to format a range of lines, either in visual mode or with a motion
autocmd User LspAttached
  \ if lsp#get_server_names()->filter("lsp#capabilities#has_document_range_formatting_provider(v:val)")->len() > 0 |
  \   setlocal formatexpr=lsp#lsp#FormatExpr() |
  \ endif

" Note: vim-language-server hover data is generated from Neovim
autocmd User lsp_buffer_enabled
  \ if &filetype !=# 'vim' && lsp#get_server_names()->filter("lsp#capabilities#has_hover_provider(v:val)")->len() > 0 |
  \   nnoremap <buffer> K <plug>(lsp-hover)|
  \ endif

let g:lsp_settings = {
  \   'vim-language-server': {
  \     'initialization_options': {
  \       'diagnostic': { 'enable': v:false },
  \     },
  \   }
  \}

packadd vim-lsp
packadd vim-lsp-settings
