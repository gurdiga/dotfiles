setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

inoreabbrev <buffer> colo console.log('');
  \<Esc>F'i
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> _fn function() {}

inoreabbrev <buffer> fn <Esc>:normal a_fn<CR>
  \i<CR>
  \<Esc><Up>f)i
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> fnus <Esc>:normal a_fn<CR>
  \I(
  \<Esc>A());
  \<Esc>F}i<CR>
  \<Esc>O<Tab>'use strict';<CR><CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> tede <Esc>:normal a_fn<CR>
  \Idescribe('',<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>f'a
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> teit <Esc>:normal a_fn<CR>
  \Iit('',<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>^f'a
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> tebe <Esc>:normal a_fn<CR>
  \IbeforeEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> teaf <Esc>:normal a_fn<CR>
  \IafterEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> us 'use strict';<CR>
  \<C-R>=Eatchar('\s')<CR>
