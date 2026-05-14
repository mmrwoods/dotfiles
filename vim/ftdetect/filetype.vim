" Set .asc to AsciiDoc as this is recognised by GitHub (Vim only recognises
" .asciidoc and .adoc extensions by default, see $VIMRUNTIME/filetype.vim)
" Regex allows for armoured ascii PGP public key files with .asc extension
" AGS script files also use .asc extension, but checking for this is more
" complicated and vim doesn't recognise the filetype, so ignoring for now.
autocmd BufRead,BufNewFile *.asc
  \ if getline(1) !~# '^-----BEGIN/' |
  \   setfiletype asciidoc |
  \ endif

" Additional ruby files types
autocmd BufRead,BufNewFile {Berksfile,Brewfile,Capfile,Thorfile,.pryrc,pryrc,*.cap,*.thor}
  \ setfiletype ruby

" Cloudformation file types for cfn-lint
autocmd Filetype yaml,json
  \ let lines = getline(1, min([line("$"), 10])) |
  \ if match(lines, 'AWSTemplateFormatVersion') != -1 |
  \   let &ft=&ft . '.cloudformation' |
  \ endif

" Fallback to conf for foo.conf.local and friends
autocmd BufRead,BufNewFile *.conf.* setf FALLBACK conf
