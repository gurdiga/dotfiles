set expandtab
set tabstop=2
set shiftwidth=2

iabbrev <buffer> tede describe '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> teco context '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> teit it '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> tebe before do end<ESC>F i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>
