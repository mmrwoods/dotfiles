if !exists('g:loaded_fuzzbox')
  finish
endif

augroup vimrc_fuzzbox
  au!

  " Disable default devicons highlighting in nerdtree
  autocmd VimEnter * hi! link NERDTreeFlags Normal

  " Use same devicon colors in fuzzbox, nerdtree, and bufexplorer
  autocmd FileType nerdtree,bufexplorer
    \ try |
    \   call fuzzbox#devicons#Colorize() |
    \   catch /\v:(E700|E117):/ |
    \ endtry

  " For testing - prefer vim-nerdfont to vim-devicons if both installed
  autocmd VimEnter *
    \ if exists("g:loaded_nerdfont") |
    \   let g:fuzzbox_devicons_glyph_func = 'nerdfont#find' |
    \ endif
augroup END

" Additional Fuzzbox commands and mappings
command! FuzzyFilesAll call fuzzbox#Launch('files', #{command: 'rg -uu --files', title: 'All Files'})
nnoremap <leader>fa :FuzzyFilesAll<CR>
nnoremap <leader>fF :FuzzyFilesRoot<CR>
nnoremap <leader>fG :FuzzyGrepRoot<CR>
nnoremap <leader>fj :FuzzyJumps<CR>
nnoremap <leader>fm :FuzzyMarks<CR>
nnoremap <leader>fR :FuzzyMruRoot<CR>
nnoremap <leader>ft :FuzzyTags<CR>
nnoremap <leader>fT :FuzzyTagsRoot<CR>
" FuzzyGrep current word
nnoremap <leader>fw :FuzzyGrep <C-R><C-W><CR>
" https://github.com/vim-fuzzbox/fuzzbox-lsp.vim
nnoremap <leader>fo :FuzzyLspDocumentSymbols<CR>
nnoremap <leader>fs :FuzzyLspWorkspaceSymbols<CR>
