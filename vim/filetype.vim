if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " Additional ruby syntax highlighting
  autocmd BufRead,BufNewFile {Berksfile,Capfile,Vagrantfile,Thorfile,pryrc,.pryrc}
    \ setfiletype ruby |

  " Set cloudformation filetypes to enable linting in ALE
  autocmd Filetype yaml,json
    \ if search('AWSTemplateFormatVersion', 'nw') |
    \   let &ft=&ft . '.cloudformation' |
    \ endif

  " Set conf.local filetype to conf
  autocmd BufRead,BufNewFile *.conf.local setfiletype conf

  " Crude autodetection of some common rc and other dotfile types/formats
  autocmd BufRead,BufWrite .*rc,$HOME/.*
    \ if empty(&ft) |
    \   if getline(1) =~ '^{' |
    \     setfiletype json |
    \   elseif getline(1) == '---' |
    \     setfiletype yaml |
    \   elseif getline(1) =~ '^\w\+:' && ( getline(2) =~ '^\w\+:' || getline(2) =~ '^\s\+\-\s\+\w\+' ) |
    \     setfiletype yaml |
    \   elseif search('^\[.*\]', 'nw') && search('^\w\+\s*=\s*\(\w\|\"\)', 'nw') |
    \     setfiletype dosini |
    \   endif |
    \ endif
augroup END
