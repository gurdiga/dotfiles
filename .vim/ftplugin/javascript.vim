setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

iabbrev <buffer> rq require('');
  \<Esc>F'i
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> colo console.log('');
  \<Esc>F'i
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> _fn function() {}

iabbrev <buffer> fn <Esc>:normal a_fn<CR>
  \i<CR>
  \<Esc><Up>f)i
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> fnus <Esc>:normal a_fn<CR>
  \I(
  \<Esc>A());
  \<Esc>F}i<CR>
  \<Esc>O<Tab>'use strict';<CR><CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> tede <Esc>:normal a_fn<CR>
  \Idescribe('',<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>f'a
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> teit <Esc>:normal a_fn<CR>
  \Iit('',<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>^f'a
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

iabbrev <buffer> us 'use strict';<CR>
  \<C-R>=Eatchar('\s')<CR>
