setlocal expandtab tabstop=2 shiftwidth=2

iabbrev <buffer> tede describe '' do end<ESC>F i<CR><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> teco context '' do end<ESC>F i<CR><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> teit it '' do end<ESC>F i<CR><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> tebe before do end<ESC>F i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>

" vim-ruby
let g:ruby_indent_assignment_style = 'hanging'
let g:ruby_indent_access_modifier_style = 'normal'
