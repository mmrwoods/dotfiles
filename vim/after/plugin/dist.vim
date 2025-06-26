vim9script

# Backport updated comment and open plugin mappings to play nice with vim-which-key
# See https://github.com/vim/vim/pull/17563
if !has("9.1.1475")
  if maparg('gc', 'n') ==# "comment.Toggle()" && maparg('gcc', 'n') =~# '\vcomment.Toggle()'
    import autoload "comment.vim"
    nnoremap <silent> <expr> <Plug>(comment-toggle) comment.Toggle()
    xnoremap <silent> <expr> <Plug>(comment-toggle) comment.Toggle()
    nnoremap <silent> <expr> <Plug>(comment-toggle-line) comment.Toggle() .. '_'

    nnoremap gc <Plug>(comment-toggle)
    xnoremap gc <Plug>(comment-toggle)
    nnoremap gcc <Plug>(comment-toggle-line)
  endif

  if maparg('gx', 'n') =~# '\vvim9.Open' && maparg('gx', 'x') =~# '\vvim9.Open'
    import autoload 'dist/vim9.vim'
    def GetWordUnderCursor(): string
      const url = matchstr(expand("<cWORD>"), '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S\{-}\ze[^A-Za-z0-9/]*$')
      if !empty(url)
        return url
      endif
      const user_var = get(g:, 'gx_word', get(g:, 'netrw_gx', '<cfile>'))
      return expand(user_var)
    enddef

    nnoremap <Plug>(open-word-under-cursor) <scriptcmd>vim9.Open(GetWordUnderCursor())<CR>
    xnoremap <Plug>(open-word-under-cursor) <scriptcmd>vim9.Open(getregion(getpos('v'), getpos('.'), { type: mode() })->join())<CR>

    nmap gx <Plug>(open-word-under-cursor)
    xmap gx <Plug>(open-word-under-cursor)
  endif
endif
