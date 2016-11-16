set expandtab
set tabstop=2
set shiftwidth=2

iabbrev tede describe '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev teco context '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev teit it '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev tebe before do end<ESC>F i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>
