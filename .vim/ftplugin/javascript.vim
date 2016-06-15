set expandtab

iabbrev rq require('');
  \<Esc>F'i
  \<C-R>=Eatchar('\s')<CR>

iabbrev colo console.log('');
  \<Esc>F'i
  \<C-R>=Eatchar('\s')<CR>

iabbrev _fn function() {}

iabbrev fn <Esc>:normal a_fn<CR>
  \i<CR>
  \<Esc><Up>f)i
  \<C-R>=Eatchar('\s')<CR>

iabbrev fnus <Esc>:normal a_fn<CR>
  \I(
  \<Esc>A());
  \<Esc>F}i<CR>
  \<Esc>O<Tab>'use strict';<CR><CR>
  \<Esc>O<Tab>
  \<C-R>=Eatchar('\s')<CR>

iabbrev tede <Esc>:normal a_fn<CR>
  \Idescribe('',<Space>
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Esc><Up>
  \<Esc>f'a
  \<C-R>=Eatchar('\s')<CR>

iabbrev teit <Esc>:normal a_fn<CR>
  \Iit('',<Space>
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Esc><Up>
  \<Esc>^f'a
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

iabbrev tett <Esc>:normal a_fn<CR>
  \It.test('',<Space>
  \<Esc>f)it
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O<Tab>t.end();
  \<Esc>O<Up>
  \<Esc>f'a
  \<C-R>=Eatchar('\s')<CR>

iabbrev us 'use strict'
  \<C-R>=Eatchar('\s')<CR>
