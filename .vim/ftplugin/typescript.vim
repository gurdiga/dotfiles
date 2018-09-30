setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

set matchpairs+=<:>

nmap <buffer> <C-T><C-I> :TsuImport<CR>
nmap <buffer> <C-T><C-R> :TsuReferences<CR>
nmap <buffer> <C-T><C-R><C-R> :TsuReload<CR>
nmap <buffer> <C-T><C-M> :TsuRenameSymbol<CR>
nmap <buffer> <C-T><C-D> :TsuSplitDefinition<CR>
nmap <buffer> <C-T><C-E> :TsuGeterr<CR>
nmap <buffer> <C-T><C-H> :echom tsuquyomi#hint()<CR>

inoreabbrev <buffer> colo console.log("");
  \<Esc>F"i
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> _fn_es5 function() {}

inoreabbrev <buffer> fn <Esc>:normal a_fn_es5<CR>
  \i<CR>
  \<Esc><Up>f)i
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> _fn () => {}

inoreabbrev <buffer> tede <Esc>:normal a_fn<CR>
  \Idescribe("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>f"a
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> teco <Esc>:normal a_fn<CR>
  \Icontext("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>f"a
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> teit <Esc>:normal a_fn<CR>
  \Iit("",<Space>
  \<Esc>A);
  \<Esc>F}i<CR><Up>
  \<Esc>^f"a
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> tebe <Esc>:normal a_fn<CR>
  \IbeforeEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O
  \<C-R>=Eatchar('\s')<CR>

inoreabbrev <buffer> teaf <Esc>:normal a_fn<CR>
  \IafterEach(
  \<Esc>A);
  \<Esc>F}i<CR>
  \<Esc>O
  \<C-R>=Eatchar('\s')<CR>
