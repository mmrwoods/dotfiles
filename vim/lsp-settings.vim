" yegappan/lsp (aka vim9lsp) config

" global mappings, copied from Neovim defaults
" see https://neovim.io/doc/user/lsp.html
nnoremap gra :LspCodeAction<cr>
xnoremap gra :LspCodeAction<cr>
nnoremap gri :LspGotoImpl<cr>
nnoremap grn :LspRename<cr>
nnoremap grr :LspShowReferences<cr>
nnoremap grt :LspGotoTypeDef<cr>
nnoremap gO :LspDocumentSymbol<cr>
nnoremap <C-S> :LspShowSignature<cr>

nnoremap [d :LspDiagPrevWrap<CR>
nnoremap ]d :LspDiagNextWrap<CR>
nnoremap [D :LspDiagFirst<CR>
nnoremap ]D :LspDiagLast<CR>

" Turn down the diagnostic dials!
hi link LspDiagInlineError Underlined
hi link LspDiagInlineHint Underlined
hi link LspDiagInlineInfo Underlined
hi link LspDiagInlineWarning Underlined

" TODO: add server info to statusline, something like this:
" copy(lsp#buffer#CurbufGetServers())->map('v:val.name')

" Note: autoComplete disabled because it interferes with other <CR> mappings
" by default, use Vim's new built in autocomplete option if desired instead
autocmd User LspSetup call LspOptionsSet(#{
  \   autoComplete: v:false,
  \   definitionFallback: v:true,
  \   hoverFallback: v:true,
  \   noNewlineInCompletion: v:true,
  \   outlineOnRight: v:true,
  \   outlineWinSize: 40,
  \   showDiagOnStatusLine: v:true,
  \   showDiagWithSign: v:false,
  \   useBufferCompletion: v:true,
  \   usePopupInCodeAction: v:true,
  \   useQuickfixForLocations: v:true,
  \   formatFallback: v:true,
  \ })

" Note: vim-language-server hover data is generated from Neovim
autocmd User LspAttached
  \ if &filetype !=# 'vim' && !lsp#buffer#BufLspServerGet(bufnr(), 'hover')->empty() |
  \   nnoremap <buffer> K <cmd>LspHover<cr> |
  \ endif

" Use CTRL-] and other tag related commands to jump to symbol locations
" Note: don't mess with gd, jumps to local declaration (e.g. imports)
autocmd User LspAttached
  \ if !lsp#buffer#BufLspServerGet(bufnr(), 'definition')->empty() |
  \   setlocal tagfunc=lsp#lsp#TagFunc |
  \ endif

" Use gq to format a range of lines, either in visual mode or with a motion
autocmd User LspAttached
  \ if !lsp#buffer#BufLspServerGet(bufnr(), 'documentRangeFormatting')->empty() |
  \   setlocal formatexpr=lsp#lsp#FormatExpr() |
  \ endif

" brew install typescript-language-server
autocmd User LspSetup call LspAddServer([#{
  \   name: 'typescriptls',
  \   filetype: ['typescript', 'javascript', 'typescriptreact', 'javascriptreact'],
  \   path: 'typescript-language-server',
  \   args: ['--stdio']
  \  }])

" npm i -g vscode-langservers-extracted
autocmd User LspSetup call LspAddServer([#{
  \ name: 'jsonls',
  \   filetype: ['json', 'jsonc', 'json.cloudformation'],
  \   path: 'vscode-json-language-server',
  \   args: ['--stdio'],
  \   initializationOptions: #{ provideFormatter: v:true }
  \ }])
" snippetSupport must be enabled for json completion
autocmd User LspSetup call LspOptionsSet(#{ snippetSupport: v:true })

" brew install lua-language-server
autocmd User LspSetup call LspAddServer([#{
  \   name: 'luals',
  \   filetype: 'lua',
  \   path: 'lua-language-server',
  \   args: []
  \ }])

" npm install -g vim-language-server
autocmd User LspSetup call LspAddServer([#{
  \   name: 'vimls',
  \   filetype: 'vim',
  \   path: 'vim-language-server',
  \   args: ['--stdio'],
  \   initializationOptions: #{ diagnostic: #{ enable: v:false } }
  \ }])

" brew install bash-language-server
autocmd User LspSetup call LspAddServer([#{
  \   name: 'bashls',
  \   filetype: ['bash', 'sh'],
  \   path: 'bash-language-server',
  \   args: ['start']
  \ }])

" brew install solargraph
autocmd User LspSetup call LspAddServer([#{
  \   name: 'solargraph',
  \   filetype: 'ruby',
  \   path: 'solargraph',
  \   args: ['stdio'],
  \   initializationOptions: #{ formatting: v:true }
  \ }])

" brew install ruby-lsp
" Disabled for now, doesn't work well with outdated app dependencies
" autocmd User LspSetup call LspAddServer([#{
"   \   name: 'ruby-lsp',
"   \   filetype: 'ruby',
"   \   path: 'ruby-lsp',
"   \   args: ['stdio'],
"   \   debug: v:true,
"   \ }])

" pipx install jedi-language-server
autocmd User LspSetup call LspAddServer([#{
  \   name: 'jedi',
  \   filetype: 'python',
  \   path: 'jedi-language-server',
  \   args: [],
  \ }])

"brew install ruff
autocmd User LspSetup call LspAddServer([#{
  \   name: 'ruff',
  \   filetype: 'python',
  \   path: 'ruff',
  \   args: ['server'],
  \ }])

" brew install llvm, full path required as llvm is key-only
autocmd User LspSetup call LspAddServer([#{
  \   name: 'clangd',
  \   filetype: ['c', 'cpp'],
  \   path: '/opt/homebrew/opt/llvm/bin/clangd',
  \   args: ['--background-index', '--clang-tidy']
  \ }])

packadd lsp
