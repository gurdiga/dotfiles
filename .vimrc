syntax on

set nomodeline
set autoindent
set shiftwidth=2
set tabstop=2
set expandtab
set ruler
set number
set backspace=indent,eol,start
set history=1000
set scrolloff=5

set noerrorbells
"set visualbell

set foldmethod=indent
set nofoldenable
set encoding=utf-8
set listchars=tab:▸\ ,eol:¬

" enable per-directory .vimrc files
set exrc

"restore cursor position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" remove line numbers for log files
autocmd BufNewFile,BufRead *.log set nonu

"autocmd Filetype php,html,xml,xsl source ~/.vim/closetag.vim
autocmd BufNewFile,BufRead *.html,*.php let b:unaryTagsStack="none"

autocmd Filetype blog set textwidth=72 formatoptions=tanv
autocmd Filetype gitcommit set textwidth=72

highlight SpacesBeforeTab ctermbg=red guibg=lightgreen
highlight TrailingWhitespace ctermbg=red guibg=lightgreen
highlight TabsNotAtTheStartOfLine ctermbg=red guibg=lightgreen
highlight SpacesForIndentingAfterTabs ctermbg=red guibg=lightgreen
"highlight SpacesForIndenting ctermbg=darkgreen guibg=lightgreen
highlight OnlyWhitespace ctermbg=red guibg=lightgreen

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match SpacesBeforeTab / \+\ze\t/
autocmd Syntax * syn match TrailingWhitespace /\s\+$/

" Show tabs that are not at the start of a line:
autocmd Syntax * syn match TabsNotAtTheStartOfLine /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting).
autocmd Syntax * syn match SpacesForIndentingAfterTabs /^\t*\zs \+/
autocmd Syntax * syn match SpacesForIndenting /^ \+/
autocmd Syntax * syn match OnlyWhitespace /^[ \t]\+$/

autocmd BufRead,BufNewFile nginx.* set filetype=nginx
autocmd BufRead,BufNewFile */nginx.conf.d/*.conf set filetype=nginx
autocmd BufRead,BufNewFile */bind/zones/*.db set tabstop=8
autocmd BufRead,BufNewFile Gemfile,*.ru,*.rb.* set filetype=ruby
filetype plugin on
source ~/.vimrc_local

let g:netrw_list_hide='.*\.swp$'
