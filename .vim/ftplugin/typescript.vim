set shiftwidth=2 tabstop=2 expandtab

iabbrev _fn () => {}

iabbrev tede <Esc>:normal a_fn<CR>
  \Idescribe("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Esc><Up>
  \<Esc>f"a
  \<C-R>=Eatchar('\s')<CR>

iabbrev teco <Esc>:normal a_fn<CR>
  \Icontext("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Esc><Up>
  \<Esc>f"a
  \<C-R>=Eatchar('\s')<CR>

iabbrev tebe <Esc>:normal a_fn<CR>
  \IbeforeEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

iabbrev teaf <Esc>:normal a_fn<CR>
  \IafterEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

iabbrev teit <Esc>:normal a_fn<CR>
  \Iit("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Esc><Up>
  \<Esc>^f"a
  \<C-R>=Eatchar('\s')<CR>
