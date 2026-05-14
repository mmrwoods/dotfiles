augroup vimrc_format
  au!

  " Use xmllint as exernal program for formatting xml
  autocmd FileType xml exec 'setlocal formatprg=XMLLINT_INDENT=' . &sw . '\ xmllint\ --format\ --recover\ -'

  " Use jq as external program for formatting json
  " Note: jq preferred to jsonhint simply because easier to set indent level
  autocmd FileType json exec 'setlocal formatprg=jq\ --indent\ ' . &sw . '\ .'

  " Use js-beautify as external program for formatting javascript
  autocmd FileType javascript exec 'setlocal formatprg=js-beautify\ --indent-size=' . &sw . '\ -'

  " Use black formatter as external program for formatting python
  autocmd FileType python exec 'setlocal formatprg=black\ --quiet\ --line-length=' . &tw . '\ -'

  " Use rubocop as external program for formatting ruby
  if executable('rubocop') " check if exists as redirecting stderr to /dev/null
    " Note: --stdin FILE ignored, not needed for formatting
    autocmd FileType ruby setlocal formatprg=rubocop\ -x\ --stdin\ _\ --stderr\ 2>/dev/null
  endif
augroup END
