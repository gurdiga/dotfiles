setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

"autocmd! BufWritePost *.elm ElmMake

let g:elm_format_autosave = 1
let g:elm_jump_to_error = 1
let g:elm_make_show_warnings = 1

map <C-]> gd
