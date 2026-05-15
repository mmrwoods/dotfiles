if !exists('g:loaded_splitjoin')
  finish
endif

" Readable splitjoin mappings with no fallback to built in gJ
nmap gJ <plug>SplitjoinJoin
nmap gS <plug>SplitjoinSplit
