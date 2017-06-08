setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

"autocmd! BufWritePost *.elm ElmMake

let g:elm_format_autosave = 1
let g:elm_jump_to_error = 1
let g:elm_make_show_warnings = 1

imap <buffer> [ [  ]<Left><Left>
imap <buffer> [] []

imap <buffer> { {  }<Left><Left>
imap <buffer> {} {}

imap <buffer> ( (  )<Left><Left>
imap <buffer> () ()

inoremap <buffer> " ""<Left>
inoremap <buffer> ' ''<Left>

iabbrev if if then<CR><Backspace>else<CR>
	\<Esc><Up><Up>^ffa

iabbrev case case of
	\<Esc>F i

iabbrev let let<CR><Backspace>in
	\<Esc><Up>A<CR>

iabbrev <buffer> {-- {--<CR>--}
	\<Esc>O
	\<C-R>=Eatchar('\s')<CR>
