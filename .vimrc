syntax on

set nomodeline
set autoindent
set shiftwidth=2
set tabstop=2
set ruler
set number
set backspace=indent,eol,start
set mouse=a
set history=200
set nohlsearch

set noerrorbells
"set visualbell

set foldmethod=indent
set nofoldenable
set encoding=utf-8
set listchars=tab:▸\ ,eol:¬

"restore cursor position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" remove line numbers for log files
autocmd BufNewFile,BufRead *.log set nonu

autocmd Filetype html,xml,xsl source ~/.vim/closetag.vim
autocmd BufNewFile,BufRead *.html,*.php let b:unaryTagsStack="none"

autocmd Filetype blog set textwidth=72 formatoptions=tanv

highlight TrailingWhitespaceAndSpacesBeforeTab ctermbg=darkgreen guibg=lightgreen
highlight TabsNotAtTheStartOfLine ctermbg=darkgreen guibg=lightgreen
highlight SpacesForIndentingAfterTabs ctermbg=darkgreen guibg=lightgreen
"highlight SpacesForIndenting ctermbg=darkgreen guibg=lightgreen

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match TrailingWhitespaceAndSpacesBeforeTab /\s\+$\| \+\ze\t/

" Show tabs that are not at the start of a line:
autocmd Syntax * syn match TabsNotAtTheStartOfLine /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting).
autocmd Syntax * syn match SpacesForIndentingAfterTabs /^\t*\zs \+/
autocmd Syntax * syn match SpacesForIndenting /^ \+/
autocmd FileType ruby set expandtab
