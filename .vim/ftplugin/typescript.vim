setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

iabbrev <buffer> colo console.log("");
  \<Esc>F"i
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> _fn_es5 function() {}

iabbrev <buffer> fn <Esc>:normal a_fn_es5<CR>
  \i<CR>
  \<Esc><Up>f)i
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> _fn () => {}

iabbrev <buffer> tede <Esc>:normal a_fn<CR>
  \Idescribe("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>f"a
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> teco <Esc>:normal a_fn<CR>
  \Icontext("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>f"a
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> teit <Esc>:normal a_fn<CR>
  \Iit("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>^f"a
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> tebe <Esc>:normal a_fn<CR>
  \IbeforeEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> teaf <Esc>:normal a_fn<CR>
  \IafterEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>
