" no hanging indent for ruby assignment, see $VIMRUNTIME/indent/ruby.vim
" THIS-> │ foobar = if foo    NOT-> │ foobar = if foo
"        │   bar                    │            bar
"        │ end                      │          end
let g:ruby_indent_assignment_style = 'variable'
