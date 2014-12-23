syntax on
filetype plugin on

nnoremap Q :echo "The “Q” normal command is disabled because it’s annoying and useless"<CR>
cnoremap a :echo "The “:a” command is disabled because it’s annoying and useless"<CR>

"enable per-directory .vimrc files
set exrc

set nomodeline
set autoindent
set shiftwidth=2
set tabstop=2
set expandtab
set ruler
set number
set backspace=indent,eol,start
set history=1000
set scrolloff=2
set noerrorbells
set encoding=utf-8

set cursorline
highlight CursorLine term=bold cterm=bold guifg=NONE guibg=#121212 gui=NONE ctermfg=NONE ctermbg=236

"restore cursor position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"remove line numbers for log files
autocmd BufNewFile,BufRead *.log set nonu

"autocmd Filetype php,html,xml,xsl source ~/.vim/closetag.vim
autocmd BufNewFile,BufRead *.html,*.php let b:unaryTagsStack="none"

highlight SpacesBeforeTab             ctermbg=red guibg=lightgreen
highlight TrailingWhitespace          ctermbg=red guibg=lightgreen
highlight TabsNotAtTheStartOfLine     ctermbg=red guibg=lightgreen
highlight SpacesForIndentingAfterTabs ctermbg=red guibg=lightgreen
highlight OnlyWhitespace              ctermbg=red guibg=lightgreen

"Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match SpacesBeforeTab / \+\ze\t/
autocmd Syntax * syn match TrailingWhitespace /\s\+$/

"Show tabs that are not at the start of a line:
autocmd Syntax * syn match TabsNotAtTheStartOfLine /[^\t]\zs\t\+/

"Show spaces used for indenting (so you use only tabs for indenting).
autocmd Syntax * syn match SpacesForIndentingAfterTabs /^\t*\zs \+/
autocmd Syntax * syn match SpacesForIndenting /^ \+/
autocmd Syntax * syn match OnlyWhitespace /^[ \t]\+$/

autocmd BufRead,BufNewFile nginx.* set filetype=nginx
autocmd BufRead,BufNewFile */nginx.conf.d/*.conf set filetype=nginx
autocmd BufRead,BufNewFile */bind/zones/*.db set tabstop=8
autocmd BufRead,BufNewFile Capfile,Gemfile,*.ru,*.rb.* set filetype=ruby
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile * silent execute (getline(1) =~ '[^ ]\+/\(env \)\?node\>' ? "set filetype=javascript" : "")
autocmd BufRead,BufNewFile *.md setlocal textwidth=72
autocmd BufEnter *.sass,*.jade set noexpandtab

let g:netrw_list_hide='.*\.swp$'

"select the just-pasted text
nnoremap gp `[v`]
nnoremap =p :set paste!<CR>:set paste?<CR>

execute pathogen#infect()
let jshint2_save = 0
let jshint2_error = 0
let jshint2_height = 2


func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

autocmd BufEnter *.js     iabbrev colo console.log('');<ESC>F'i<C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.coffee iabbrev colo console.log <ESC>a<C-R>=Eatchar('\s')<CR>

autocmd BufEnter *.js     iabbrev fn function() {<CR>}<ESC><UP>$F)i<C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.js     iabbrev fnus (function() {}());<ESC>F}i<CR><CR><CR><UP><UP><TAB>'use strict';<CR><CR><C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.js     iabbrev us; 'use strict';<C-R>=Eatchar('\s')<CR><CR>
autocmd BufEnter *.js     iabbrev vst var context = this;
autocmd BufEnter *.js     iabbrev me= module.exports =;<ESC>i

autocmd BufEnter *.js     iabbrev tede describe('', function() {});<ESC>F}i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.js     iabbrev teit it('', function() {});<ESC>F}i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.js     iabbrev tebe beforeEach(function() {});<ESC>F}i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.js     iabbrev teaf afterEach(function() {});<ESC>F}i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>

autocmd BufEnter *.rb     iabbrev tede describe '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.rb     iabbrev teit it '' do end<ESC>F i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
autocmd BufEnter *.rb     iabbrev tebe before do end<ESC>F i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>
