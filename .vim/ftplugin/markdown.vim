setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
setlocal textwidth=80

setlocal spell spelllang=en_us
highlight clear SpellBad
highlight SpellBad cterm=underline

":he fo-table
setlocal formatoptions+=tn1
setlocal formatoptions-=ba 

nnoremap <buffer> <C-F> vipgq
