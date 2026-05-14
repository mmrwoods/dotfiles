" Set working directory when opening vim, use directory of current file when
" provided as argument, otherwise cwd to root of project/package if possible.
" Note: uses vim-rooter, and works nicely with monorepos (not reliant on VCS)
function! <SID>SetWorkingDir()
  if !exists('*FindRootDirectory')
    return
  endif
  let $OLDPWD = getcwd()
  if argc() == 1 && len(argv()) == 1
    if isdirectory(argv(0))
      exec 'cd' argv(0)
    elseif filereadable(argv(0))
      exec 'cd %:p:h'
    end
  elseif len(argv()) == 0 && stridx(getcwd(), $HOME) == 0
    let l:root = FindRootDirectory()
    if !empty(l:root) && l:root !=# getcwd()
      exec 'cd' l:root
    endif
  endif
  if $OLDPWD !=# getcwd()
    echohl WarningMsg
    echo "vimrc: cwd changed to '" . getcwd() . "', :cd - returns to previous cwd"
    echohl None
  endif
endfunction

augroup vimrc_workdir
  autocmd VimEnter * call <SID>SetWorkingDir()
augroup END
