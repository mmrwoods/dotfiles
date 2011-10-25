" Vim color file
" Maintainer:	Mark Woods
" Licence:	Public Domain

" GUI only color scheme based on the eclipse color scheme, optimised for ruby.

set background=light

highlight clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "wicklow"

highlight Normal guifg=Black guibg=White

" Search
highlight IncSearch gui=underline guifg=#404040 guibg=#e0e040
highlight Search    gui=none      guifg=#544060 guibg=#f0c0ff

" Messages
highlight ErrorMsg   gui=none guifg=#f8f8f8 guibg=#4040ff
highlight WarningMsg gui=none guifg=#f8f8f8 guibg=#4040ff
highlight ModeMsg    gui=none guifg=#d06000 guibg=bg
highlight MoreMsg    gui=none guifg=#0090a0 guibg=bg
highlight Question   gui=none guifg=#8000ff guibg=bg

" Split area
highlight StatusLine   gui=none guifg=#ffffff guibg=#4570aa
highlight StatusLineNC gui=none guifg=#ffffff guibg=#75a0da
highlight VertSplit    gui=none guifg=#f8f8f8 guibg=#904838
highlight WildMenu     gui=none guifg=#f8f8f8 guibg=#ff3030

" Diff
highlight DiffText   gui=none guifg=red   guibg=#ffd0d0
highlight DiffChange gui=none guifg=black guibg=#ffe7e7
highlight DiffDelete gui=none guifg=bg    guibg=#e7e7ff
highlight DiffAdd    gui=none guifg=blue  guibg=#e7e7ff

" Cursor
highlight Cursor   gui=none guifg=#ffffff guibg=#0080f0
highlight lCursor  gui=none guifg=#ffffff guibg=#8040ff
highlight CursorIM gui=none guifg=#ffffff guibg=#8040ff

" Fold
highlight Folded     gui=none guifg=#804030 guibg=#fff0d0
highlight FoldColumn gui=none guifg=#6b6b6b guibg=#e7e7e7

" Popup Menu
highlight PMenu      ctermbg=green ctermfg=white
highlight PMenuSel   ctermbg=white ctermfg=black
highlight PMenuSBar  ctermbg=red   ctermfg=white
highlight PMenuThumb ctermbg=white ctermfg=red

" Other
highlight Directory  gui=none guifg=#7050ff guibg=bg
highlight LineNr     gui=none guifg=#6b6b6b guibg=#eeeeee
highlight NonText    gui=none guifg=#707070 guibg=#e7e7e7
highlight SpecialKey gui=none guifg=#c0c0c0 guibg=bg
highlight Title      gui=bold guifg=#0033cc guibg=bg
highlight Visual     gui=none guifg=#804020 guibg=#ffc0a0

" Syntax group
highlight Comment       gui=none guifg=#658173 guibg=bg
highlight Constant      gui=none guifg=#a4357a guibg=bg
highlight Error         gui=none guifg=#f8f8f8 guibg=#4040ff
highlight Identifier    gui=none guifg=#b07800 guibg=bg
highlight Ignore        gui=none guifg=bg      guibg=bg
highlight PreProc       gui=none guifg=#683821 guibg=bg
highlight Special       gui=none guifg=#2a00ff guibg=bg
highlight Statement     gui=bold guifg=#b64f90 guibg=bg
highlight Todo          gui=none guifg=#ff5050 guibg=white
highlight Type          gui=none guifg=#a4357a guibg=bg
highlight Underlined    gui=none guifg=blue    guibg=bg
highlight String        gui=none guifg=#2a00ff guibg=bg
highlight Number        gui=none guifg=#0080ff guibg=bg

if !has("gui_running")
    highlight link Float          Number
    highlight link Conditional    Repeat
    highlight link Include        PreProc
    highlight link Macro          PreProc
    highlight link PreCondit      PreProc
    highlight link Structure      Type
    highlight link StorageClass   Type
    highlight link Typedef        Type
    highlight link Tag            Special
    highlight link Delimiter      Normal
    highlight link SpecialComment Special
    highlight link Debug          Special
endif

" Java syntax
highlight javaStorageClass      guifg=#a4357a gui=bold

" Ruby syntax
highlight rubyDefine            guifg=#a4357a gui=bold
highlight rubyAccess            guifg=#a4357a gui=bold
highlight rubyBeginEnd          guifg=#a4357a gui=bold
highlight rubyControl           guifg=#a4357a gui=bold
highlight rubyBoolean           guifg=#a4357a gui=none
highlight rubyFunction          guifg=#683821 gui=none
highlight rubyIdentifier        guifg=#683821 gui=none
highlight rubyConditional       guifg=#a4357a gui=bold
highlight rubyGlobalVariable    guifg=#ff0000 gui=none
highlight rubyRegExpSpecial     guifg=#5a1ea0 gui=none
highlight rubySymbol            guifg=#ff4040 gui=bold
highlight rubyClassVariable     guifg=#004080 gui=bold
highlight rubyInstanceVariable  guifg=#004080 gui=bold

" vim:ff=unix:
