if !exists('g:loaded_fuzzbox')
  finish
endif

augroup vimrc_fuzzbox
  au!

  " Disable default devicons highlighting in nerdtree
  autocmd VimEnter * hi! link NERDTreeFlags Normal

  " For testing - prefer vim-nerdfont to vim-devicons if both installed
  autocmd VimEnter *
    \ if exists("g:loaded_nerdfont") |
    \   let g:fuzzbox_devicons_glyph_func = 'nerdfont#find' |
    \ endif
augroup END

" Additional Fuzzbox commands and mappings
command! FuzzyFilesAll call fuzzbox#Launch('files', #{command: 'rg -uu --files', title: 'Find Files (All)'})
command! FuzzyGrepAll call fuzzbox#Launch('grep', #{command: 'rg -uu -S --vimgrep -e $* .', title: 'Live Grep (All)'})
nnoremap <leader>fF :FuzzyFilesAll<CR>
xnoremap <leader>fF <Cmd>FuzzyFilesAll<CR>
nnoremap <leader>fG :FuzzyGrepAll<CR>
xnoremap <leader>fG <Cmd>FuzzyGrepAll<CR>
nnoremap <leader>fc :FuzzyChanges<CR>
nnoremap <leader>fj :FuzzyJumps<CR>
nnoremap <leader>fm :FuzzyMarks<CR>
nnoremap <leader>ft :FuzzyTags<CR>
xnoremap <leader>ft <Cmd>FuzzyTags<CR>
nnoremap <leader>f: :FuzzyCmdHistory<CR>
nnoremap <leader>f/ :FuzzySearchHistory<CR>
" FuzzyGrep current word
nnoremap <leader>fw :FuzzyGrep <C-R><C-W><CR>
" https://github.com/vim-fuzzbox/fuzzbox-lsp.vim
nnoremap <leader>fo :FuzzyLspDocumentSymbols<CR>
nnoremap <leader>fs :FuzzyLspWorkspaceSymbols<CR>
xnoremap <leader>fo <Cmd>FuzzyLspDocumentSymbols<CR>
xnoremap <leader>fs <Cmd>FuzzyLspWorkspaceSymbols<CR>
" https://github.com/vim-fuzzbox/fuzzbox-unicode.vim
nnoremap <leader>fu :FuzzyUnicode<CR>
