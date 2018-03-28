setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
setlocal textwidth=80

setlocal spell spelllang=en_us
highlight clear SpellBad
highlight SpellBad cterm=underline

":he fo-table
setlocal formatoptions+=tn1
setlocal formatoptions-=ba 

nnoremap <buffer> <C-F> vipgq

"Alt-1
nnoremap <buffer> ¡ ^i# <Esc>^

"Alt-2
nnoremap <buffer> ™ ^i## <Esc>^

"Alt-3
nnoremap <buffer> £ ^i### <Esc>^

"Alt-4
nnoremap <buffer> ¢ ^i#### <Esc>^

" Alt-7 - make unordered list
vnoremap <buffer> ¶ :s/^\s*/\0* /g\|:nohlsearch<CR>

" Alt-8 - make ordered list
vnoremap <buffer> • :s/^\s*/\00 /g\|:nohlsearch\|:normal gpo^g<CR>

vnoremap <buffer> <C-K> S]%a()<Left>
vnoremap <buffer> <C-I> S_e
vnoremap <buffer> <C-B> S*vf*S*e
