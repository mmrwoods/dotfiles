augroup vimrc_colors
  au!

  autocmd ColorScheme *
    \ hi! link SignColumn LineNr |
    \ hi! clear QuickFixLine |
    \ hi! QuickFixLine ctermfg=red guifg=red |

  " Consistent highlighting of tabline, statusline and vertsplit
  autocmd ColorScheme *
    \ set fillchars+=vert:\ , |
    \ hi! link VertSplit StatusLineNC |
    \ hi! link Tablinefill StatusLineNC |
    \ hi! link TablineSel StatusLine |
    \ hi! link Tabline StatusLineNC |
    \ hi! link StatusLineTerm StatusLine |
    \ hi! link StatusLineTermNC StatusLineNC |

  autocmd ColorScheme onedark
    \ hi! Visual ctermbg=64 |
    \ hi! Comment ctermfg=243 |
    \ hi! SpecialComment ctermfg=243 |
    \ hi! StatusLine ctermbg=242 |
    \ hi! StatusLineNC ctermbg=237 |
    \ hi! Search ctermfg=235 ctermbg=108 |
    \ hi! IncSearch ctermfg=235 ctermbg=215 |
    \ hi! link CurSearch IncSearch |

  autocmd ColorScheme PaperColor
    \ hi! Spellbad guibg=NONE guifg=NONE |
augroup END

if has('gui_running')
  colorscheme PaperColor          " High contrast light bg colors for gui
elseif $TERM_PROGRAM =~# 'iTerm'
  colorscheme onedark             " Match dark iTerm color scheme locally
elseif $SSH_CLIENT != ''
  colorscheme elflord             " Distinct color scheme for ssh sessions
else
  colorscheme dim                 " Default IMproved color scheme elsewhere
endif
