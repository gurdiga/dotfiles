syntax on

set nomodeline
set autoindent
set smartindent
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

"restore cursor position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" remove line numbers for log files
autocmd BufNewFile,BufRead *.log :set nonu

autocmd Filetype html,xml,xsl source ~/.vim/closetag.vim 
autocmd BufNewFile,BufRead *.html,*.php let b:unaryTagsStack="none"

source ~/.vim/html_macros.vim
autocmd BufEnter *.html,*.shtml,*.php imap <Tab> <C-R>=GetMacroByKey()<CR>
autocmd BufLeave *.html,*.shtml,*.php iunmap <Tab>
