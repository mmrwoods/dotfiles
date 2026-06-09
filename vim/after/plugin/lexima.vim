if !exists('g:loaded_lexima')
  finish
endif

" Custom basic auto-closing pair rules for Lexima, fewer than the defaults in
" Lexima and stricter, cursor must be before whitespace or one of ;:.,=})>]
let g:lexima_enable_basic_rules = 0
let g:lexima_enable_endwise_rules = 0
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

function! s:lexima_basic_rules()
  for [open, close] in items(s:lexima_closing_pairs)
    let insert_at = '\%#' . s:lexima_before_pattern
    let delete_at = ( open == '[' ? '\[\%#\]' : $'{open}\%#{close}' ) . s:lexima_before_pattern
    call lexima#add_rule({'char': open, 'at': insert_at, 'input_after': close})
    call lexima#add_rule({'char': '<BS>', 'at': delete_at, 'delete': 1})
    call lexima#add_rule({'char': close, 'at': $'\%#{close}', 'leave': 1})
    call lexima#add_rule({'char': open, 'at': '\%#', 'syntax': 'String'})
  endfor
  call lexima#add_rule(s:lexima_apostrophe_rule)
  for rule in s:lexima_filetype_rules
    call lexima#add_rule(rule)
  endfor
endfunction

function! s:lexima_endwise_rules()
  let rules = []
  " vim
  for at in ['function', 'while', 'for', 'def']
    call lexima#add_rule(s:make_endwise_rule('^\s*' . at . '\>.*\%#$', 'end' . at, 'vim', []))
  endfor
  call lexima#add_rule(s:make_endwise_rule('^\s*export def\>.*\%#$', 'enddef', 'vim', []))
  call lexima#add_rule(s:make_endwise_rule('^\s*try\>.*\%#$', 'endtry', 'vim', [], ['catch']))
  call lexima#add_rule(s:make_endwise_rule('^\s*if\>.*\%#$', 'endif', 'vim', [], ['else', 'elseif']))
  for at in ['aug', 'augroup']
    call lexima#add_rule(s:make_endwise_rule('^\s*' . at . '\s\+\(END\)\@!.\+\%#$', at . ' END', 'vim', []))
  endfor

  " ruby
  call lexima#add_rule(s:make_endwise_rule('^\s*\%(module\|class\|unless\|for\|while\|until\|case\)\>\%(.*[^.:@$]\<end\>\)\@!.*\%#$', 'end', 'ruby', []))
  call lexima#add_rule(s:make_endwise_rule('^\s*\%(if\)\>\%(.*[^.:@$]\<end\>\)\@!.*\%#$', 'end', 'ruby', [], ['else', 'elsif']))
  call lexima#add_rule(s:make_endwise_rule('^\s*\%(def\)\>\%(.*[^.:@$]\<end\>\)\@!.*\%#$', 'end', 'ruby', [], ['rescue']))
  call lexima#add_rule(s:make_endwise_rule('^\s*\%(begin\)\s*\%#$', 'end', 'ruby', [], ['rescue']))
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*#.*\)\@<!do\%(\s*|.*|\)\?\s*\%#$', 'end', 'ruby', []))

  " elixir
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*#.*\)\@<!do\s*\%#$', 'end', 'elixir', [], ['rescue']))

  " sh
  call lexima#add_rule(s:make_endwise_rule('^\s*if\>.*\%#$', 'fi', ['sh', 'zsh'], [], ['else', 'elif']))
  call lexima#add_rule(s:make_endwise_rule('^\s*case\>.*\%#$', 'esac', ['sh', 'zsh'], []))
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*#.*\)\@<!do\>.*\%#$', 'done', ['sh', 'zsh'], []))

  " julia
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*#.*\)\@<!\<\%(module\|struct\|function\|for\|while\|do\|let\|macro\)\>\%(.*\<end\>\)\@!.*\%#$', 'end', 'julia', []))
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*#.*\)\@<!\<\%(if\)\>\%(.*\<end\>\)\@!.*\%#$', 'end', 'julia', [], ['else', 'elseif']))
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*#.*\)\@<!\s*\<\%(begin\|quote\)\s*\%#$', 'end', 'julia', []))
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*#.*\)\@<!\s*\<try\s*\%#$', 'end', 'julia', [], ['catch']))

  " lua
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*--.*\)\@<!\<function\>\%(.*\<end\>\)\@!.*\%#$', 'end', 'lua', []))
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*--.*\)\@<!\<do\s*\%#$', 'end', 'lua', []))
  call lexima#add_rule(s:make_endwise_rule('\%(^\s*--.*\)\@<!\<then\s*\%#$', 'end', 'lua', []))
endfunction

function! s:make_endwise_rule(at, end, filetype, syntax, ...)
  let not_before = empty(a:000) ? [a:end] : [a:end] + a:1
  return {
    \ 'char': '<CR>',
    \ 'input': '<CR>',
    \ 'input_after': '<CR>' . a:end,
    \ 'at': a:at,
    \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1(' . not_before->join('|') . ')',
    \ 'filetype': a:filetype,
    \ 'syntax': a:syntax,
    \ }
endfunction

function! AddLeximaRules()
  call s:lexima_basic_rules()
  call s:lexima_endwise_rules()
endfunction

augroup vimrc_lexima
  au!
  " Add rules on VimEnter to avoid autoloading Lexima source files,
  " which results in Lexima being initialised earlier than expected
  " Note: friendly.vim sets lexima_accept_pum_with_enter on VimEnter
  autocmd VimEnter * call AddLeximaRules()
augroup END
