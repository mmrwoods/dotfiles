" Remap gs to open Scratch window in normal rather than insert mode
if exists(':Scratch') " note: scratch.vim has no plugin loaded guard
  nnoremap gs :Scratch<CR>
endif
