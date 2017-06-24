setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

"autocmd! BufWritePost *.elm ElmMake

let g:elm_format_autosave = 1
let g:elm_jump_to_error = 1
let g:elm_make_show_warnings = 1

map <C-]> gd

iabbrev <buffer> if if then<CR><Backspace>else<CR>
	\<Esc><Up><Up>^ffa

iabbrev <buffer> case case of
	\<Esc>F i

iabbrev <buffer> let let<CR><Backspace>in
	\<Esc><Up>A<CR>

iabbrev <buffer> {-- {--<CR>--}
	\<Esc>O
	\<C-R>=Eatchar('\s')<CR>
