if !exists('g:loaded_vimpector')
  finish
endif

nmap <Leader>dl <Plug>VimspectorLaunch
nmap <leader>db <Plug>VimspectorBreakpoints
nmap <leader>dt <Plug>VimspectorToggleBreakpoint
nmap <leader>dh :help vimspector-visual-studio-vscode<CR>
nmap ]` <Plug>VimspectorJumpToNextBreakpoint
nmap [` <Plug>VimspectorJumpToPreviousBreakpoint
