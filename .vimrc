syntax on
filetype plugin on

nnoremap Q :echo "The “Q” normal command is disabled because it’s annoying and useless"<CR>

"enable per-directory .vimrc files
set exrc
set secure

set foldmethod=manual
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

set nomodeline
set autoindent
set shiftwidth=2
set tabstop=2
set ruler
set number
set backspace=indent,eol,start
set history=1000
set scrolloff=2
set noerrorbells
set encoding=utf-8

set cursorline
highlight CursorLine term=bold cterm=bold guifg=NONE guibg=#121212 gui=NONE ctermfg=NONE ctermbg=236

set hlsearch
highlight Search term=NONE cterm=NONE ctermfg=11 ctermbg=239 guifg=#ffff00 guibg=#808000 gui=NONE

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
" exclude Vim help files
autocmd Syntax .txt syn match TabsNotAtTheStartOfLine /none/

"Show spaces used for indenting (so you use only tabs for indenting).
autocmd Syntax * syn match SpacesForIndentingAfterTabs /^\t*\zs \+/
autocmd Syntax * syn match SpacesForIndenting /^ \+/
autocmd Syntax * syn match OnlyWhitespace /^[ \t]\+$/

autocmd BufRead,BufNewFile nginx.* set filetype=nginx
autocmd BufRead,BufNewFile */nginx.conf.d/*.conf set filetype=nginx
autocmd BufRead,BufNewFile */bind/zones/*.db set tabstop=8
autocmd BufRead,BufNewFile Capfile,Gemfile,*.ru,*.rb.* set filetype=ruby
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.env.* set filetype=sh
autocmd BufRead,BufNewFile * silent execute (getline(1) =~ '[^ ]\+/\(env \)\?node\>' ? "set filetype=javascript" : "")
autocmd BufRead,BufNewFile *.md setlocal textwidth=72

" Underscore templates
autocmd BufRead,BufNewFile *.html._ set filetype=html
autocmd BufRead,BufNewFile *.html._ set syntax=underscore_template

let g:netrw_list_hide='.*\.swp$'
let g:netrw_banner=0

"select the just-pasted text
nnoremap gp `[v`]
nnoremap =p :set paste!<CR>:set paste?<CR>

execute pathogen#infect()

func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

source ~/.vim/colors/diff.vim

" let every line be considered a change in the undo history
inoremap <CR> <C-G>u<CR>

" let ^Z suspend vim even if in insert mode
inoremap <C-Z> <ESC>:stop<CR>

" let ^L clear also search highlighting
map <silent> <C-l> :nohlsearch<CR>:redraw!<CR>

" Capture inside slashes. Useful for paths and regular expressions.
" Thanks to Dhruva Sagar @ http://stackoverflow.com/a/23668360/227167
onoremap <silent> i/ :<C-U>normal! T/vt/<CR>

" Capture inside double smart quotes.
onoremap <silent> i” :<C-U>normal! T“vt”<CR>
