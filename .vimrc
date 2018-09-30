syntax on
filetype plugin on

nnoremap Q :echo "The “Q” normal command is disabled because it’s annoying and useless"<CR>

"enable per-directory .vimrc files
set exrc
set secure

set foldmethod=manual

" display all matches on tab completion
set wildmenu

set nomodeline
set autoindent
set ruler
set number
set backspace=indent,eol,start
set history=1000
set scrolloff=2
set noerrorbells
set encoding=utf-8
set tabstop=4

set cursorline
highlight CursorLine term=bold cterm=bold guifg=NONE guibg=#121212 gui=NONE ctermfg=NONE ctermbg=236

set hlsearch
highlight Search term=NONE cterm=NONE ctermfg=11 ctermbg=239 guifg=#ffff00 guibg=#808000 gui=NONE

highlight mySpacesBeforeTab             ctermbg=red guibg=lightgreen
highlight myTrailingWhitespace          ctermbg=red guibg=lightgreen
highlight myTabsNotAtTheStartOfLine     ctermbg=red guibg=lightgreen
highlight mySpacesForIndentingAfterTabs ctermbg=red guibg=lightgreen
highlight myOnlyWhitespace              ctermbg=red guibg=lightgreen

function! RestoreCursorPosition()
	if line("'\"") > 0
		if line("'\"") <= line("$")
			execute "norm '\""
		else
			execute "norm $"
		endif
	endif
endfunction

augroup my
  autocmd BufReadPost * call RestoreCursorPosition()

  "Show trailing whitepace and spaces before a tab:
  autocmd Syntax * syntax match mySpacesBeforeTab / \+\ze\t/
  autocmd Syntax * syntax match myTrailingWhitespace /\s\+$/

  "Show tabs that are not at the start of a line:
  autocmd Syntax * if &filetype != "help"
    \|syntax match myTabsNotAtTheStartOfLine /[^\t]\zs\t\+/

  "Show spaces used for indenting (so you use only tabs for indenting).
  autocmd Syntax * syntax match mySpacesForIndentingAfterTabs /^\t*\zs \+/
  autocmd Syntax * syntax match mySpacesForIndenting /^ \+/
  autocmd Syntax * syntax match myOnlyWhitespace /^[ \t]\+$/

  autocmd BufRead,BufNewFile nginx.* set filetype=nginx
  autocmd BufRead,BufNewFile */nginx.conf.d/*.conf set filetype=nginx
  autocmd BufRead,BufNewFile */bind/zones/*.db set tabstop=8
  autocmd BufRead,BufNewFile Capfile,Gemfile,*.ru,*.rb.* set filetype=ruby
  autocmd BufRead,BufNewFile *.json set nospell
  autocmd BufRead,BufNewFile *.env.* set filetype=sh
  autocmd BufRead,BufNewFile * silent execute (getline(1) =~ '[^ ]\+/\(env \)\?node\>' ? "set filetype=javascript" : "")
  autocmd BufRead,BufNewFile *.md setlocal textwidth=72
  autocmd BufRead,BufNewFile *.as,*.js.esm set filetype=javascript
  autocmd BufRead,BufNewFile ~/.aws/credentials set filetype=dosini
  autocmd BufRead,BufNewFile .crontab set filetype=crontab
  autocmd BufRead,BufNewFile .gitignore set filetype=config

  " Underscore templates
  autocmd BufRead,BufNewFile *.html._ set filetype=html
  autocmd BufRead,BufNewFile *.html._ set syntax=underscore_template

  "remove line numbers for log files
  autocmd BufNewFile,BufRead *.log set nonu

  autocmd BufNewFile,BufRead *.html,*.php let b:unaryTagsStack="none"
augroup END

let g:netrw_list_hide='.*\.swp$'
let g:netrw_banner=0

execute pathogen#infect()

function! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

source ~/.vim/colors/diff.vim
source ~/.vim/colors/comments.vim
source ~/.vim/ftplugin/common.vim

"select the just-pasted text
nnoremap gp `[v`]

" let every line be considered a change in the undo history
inoremap <CR> <C-G>u<CR>

" let ^Z suspend vim even if in insert mode
inoremap <silent> <C-Z> <ESC>:stop<CR>
cnoremap <silent> <C-Z> <ESC>:stop<CR>

" let ^L clear search highlighting
noremap <silent> <C-l> :nohlsearch<CR>:redraw!<CR>:GitGutterAll<CR>

" Capture inside slashes. Useful for paths and regular expressions.
" Thanks to Dhruva Sagar @ http://stackoverflow.com/a/23668360/227167
onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
onoremap <silent> i* :<C-U>normal! T*vt*<CR>
onoremap <silent> i+ :<C-U>normal! T+vt+<CR>

" IRB templates
onoremap <silent> i% :<C-U>normal! T%vt%<CR>

" Capture inside double smart quotes.
onoremap <silent> i” :<C-U>normal! T“vt”<CR>

" Capture Ruby lambda’s argument list
onoremap <silent> i\| :<C-U>normal! T\|vt\|<CR>

set showcmd
command W write
command Wq wq
command Wqa wqa
command Q quit

set signcolumn=yes
let g:closetag_filenames = "*.xml,*.html"
"let g:tsuquyomi_use_vimproc = 1
let g:elm_format_autosave = 1

call plug#begin()
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'elmcast/elm-vim'
Plug 'mitermayer/vim-prettier', {
	\ 'tag': '0.0.15',
	\ 'do': 'brew install yarn && yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss']
  \ }
Plug 'metakirby5/codi.vim'
Plug 'heavenshell/vim-tslint'
Plug 'michaeljsmith/vim-indent-object'
Plug 'othree/xml.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-liquid'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chase/vim-ansible-yaml'
Plug 'groenewege/vim-less'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'ElmCast/elm-vim'
Plug 'alvan/vim-closetag'
Plug 'airblade/vim-gitgutter'
Plug 'hail2u/vim-css3-syntax'
Plug 'w0rp/ale'
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-pug'
Plug 'jiangmiao/auto-pairs'
call plug#end()

"fzf
cnoremap <C-T> :GFiles<CR>
cnoremap <C-R> :History:<CR>
cnoremap <C-O> :Buffers<CR>
cnoremap <C-F> Ag<Space>

set spellfile=$HOME/.vim/spell/en.utf-8.add
set dictionary+=/usr/share/dict/words

" ALE begin https://github.com/w0rp/ale
let g:ale_fixers = {
\   'css': ['stylelint', 'prettier'],
\   'javascript': ['prettier'],
\   'typescript': ['tslint', 'prettier'],
\   'typescript.tsx': ['tslint', 'prettier'],
\   'json': ['prettier'],
\}

let g:ale_fix_on_save = 1

autocmd User ALEFixPost GitGutterAll
nmap <C-A><C-F> :ALEFix<CR>
nmap <C-A><C-L> :ALELint<CR>

"TODO: disable when &diff == 1

" ALE end

let g:vim_json_syntax_conceal = 0

" auto-pairs
let g:AutoPairs = {
\  '`': '`',
\  '"': '"',
\  '{': '}',
\  '''': '''',
\  '(': ')',
\  '[': ']',
\}

"TODO: have ft-specific pair-sets, e.g. <> is unwanted in most cases

" Disabling this because it messes up my typing: I can’t type î any more.
let g:AutoPairsShortcutJump=''

" When the filetype is FILETYPE then make AutoPairs only match for parenthesis
"autocmd Filetype FILETYPE let b:AutoPairs = {"(": ")"}


" auto-pairs end
