if !exists('g:loaded_lexima')
  finish
endif

" Custom basic auto-closing pair rules for Lexima, fewer than the defaults in
" Lexima and stricter, cursor must be before whitespace or one of ;:.,=})>]
let g:lexima_enable_basic_rules = 0
let s:lexima_before_pattern = '\([;:.,=})>]\|\]\|\s\|\n\)'
let s:lexima_closing_pairs = { '[': ']', '(': ')', '{': '}', '"': '"', '''': '''', '`': '`' }
let s:lexima_filetype_rules = [
\ {'char': '"', 'at': '^\s*\%#', 'filetype': 'vim'},
\ {'char': '"', 'at': '\%#\s*$', 'filetype': 'vim'},
\ {'char': "'", 'filetype': ['haskell', 'lisp', 'clojure', 'ocaml', 'reason', 'scala', 'rust']},
\ {'char': '`', 'filetype': ['ocaml', 'reason']},
\ {'char': '"', 'at': '""\%#'. s:lexima_before_pattern, 'input_after': '"""', 'filetype': ['python', 'scala', 'java', 'kotlin']},
\ {'char': '"', 'at': '\%#"""'. s:lexima_before_pattern, 'leave': 3, 'filetype': ['python', 'scala', 'java', 'kotlin']},
\ {'char': '`', 'at': '``\%#' . s:lexima_before_pattern, 'input_after': '```', 'filetype': ['markdown']},
\ {'char': '`', 'at': '\%#```'. s:lexima_before_pattern, 'leave': 3, 'filetype': ['markdown']},
\]
" don''t leave me this way, one apostrophe pls
let s:lexima_apostrophe_rule = {'char': "'", 'at': '\w\%#''\@!', 'priority': 1}
" workarund for duplicate 'augroup END' on CR
let s:lexima_augroup_end_rule = {'char': '<CR>', 'at': '^\s*\(aug\|augroup\) END\s*\%#$', 'filetype': 'vim'}
" exported vim9script functions
let s:lexima_augroup_end_rule = {'char': '<CR>', 'at': '^\s*export def\>.*\%#$', 'input_after': '<CR>' . 'enddef',
  \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1' . 'enddef', 'filetype': 'vim'}

function! AddLeximaRules()
  for [open, close] in items(s:lexima_closing_pairs)
    let insert_at = '\%#' . s:lexima_before_pattern
    let delete_at = ( open == '[' ? '\[\%#\]' : $'{open}\%#{close}' ) . s:lexima_before_pattern
    call lexima#add_rule({'char': open, 'at': insert_at, 'input_after': close})
    call lexima#add_rule({'char': '<BS>', 'at': delete_at, 'delete': 1})
    call lexima#add_rule({'char': close, 'at': $'\%#{close}', 'leave': 1})
    call lexima#add_rule({'char': open, 'at': '\%#', 'syntax': 'String'})
  endfor
  call lexima#add_rule(s:lexima_apostrophe_rule)
  call lexima#add_rule(s:lexima_augroup_end_rule)
  for rule in s:lexima_filetype_rules
    call lexima#add_rule(rule)
  endfor
endfunction

augroup vimrc_lexima
  au!
  " Add rules on VimEnter to avoid autoloading Lexima source files,
  " which results in Lexima being initialised earlier than expected
  " Note: friendly.vim sets lexima_accept_pum_with_enter on VimEnter
  autocmd VimEnter * call AddLeximaRules()
augroup END
