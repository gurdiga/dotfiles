setlocal softtabstop=8 tabstop=8 shiftwidth=4

iabbrev <buffer> _fn function () {}

iabbrev <buffer> fn <Esc>:normal a_fn<CR>
  \i<CR>
  \<Esc><Up>f(i
  \<C-R>=Eatchar('\s')<CR>
