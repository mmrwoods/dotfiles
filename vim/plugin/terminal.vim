" Toggle terminal - for default shell only, other terms ignored
function! ToggleTerminal()
  let termbufs = filter(term_list(), { _, bufnr -> stridx(bufname(bufnr), $SHELL) > 0 })
  if empty(termbufs)
    call Terminal()
  else
    let termwins = filter(map(copy(termbufs), { _, bufnr -> bufwinnr(bufnr) }), 'v:val != -1')
    if empty(termwins)
      for bufnr in termbufs | exe 'sbuffer ' . bufnr | endfor
    else
      for winnr in reverse(sort(termwins)) | exe winnr . 'wincmd c' | endfor
    endif
  endif
endfunction
command! ToggleTerminal call ToggleTerminal()
nnoremap <C-W>` :ToggleTerminal<CR>
tnoremap <C-W>` <C-W>:ToggleTerminal<CR>

" Open terminal in directory of current file
function! Terminal()
  if getcwd() ==# expand('%:p:h')
    terminal
  else
    let $OLDPWD = getcwd()
    split | silent lcd %:p:h | terminal ++curwin
    echohl WarningMsg
    echo "Terminal started relative to current file, cd - returns to cwd"
    echohl None
    call timer_start(3000, { -> execute("echo ''", "") })
  endif
endfunction
command! Terminal call Terminal()
nnoremap <silent><leader>` :Terminal<CR>

if exists('##TerminalWinOpen')
  augroup vimrc_terminal
    au!

    " Custom terminal statusline, not a normal editor window
    autocmd TerminalWinOpen * setlocal statusline=%f

    " Make p paste from unanmed register in terminal normal mode
    autocmd TerminalWinOpen *
      \ nnoremap <silent> <buffer> p :call term_sendkeys('', getreg()) \| normal! A<CR>
  augroup END
endif
