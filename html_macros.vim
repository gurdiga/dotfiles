" Put this file in ~/.vim/ and add the following lines to your ~/.vimrc
"
" source ~/.vim/html_macros.vim
" autocmd Filetype *.html imap <Tab> <C-R>=GetMacroByKey()<CR>
" autocmd BufLeave *.html iunmap <Tab>

let g:html_macros = {
  \'a': ['<a href=""></a>', 'F"'],
  \'ac': ['<a href="" class=""></a>', '3F"'],
  \'ai': ['<a href="" id=""></a>', '3F"'],
  \'p': ['<p></p>', 'F<'],
  \'pi': ['<p id=""></p>', 'F"'],
  \'pc': ['<p class=""></p>', 'F"'],
  \'div': ['<div></div>', 'F<'],
  \'divi': ['<div id=""></div>', 'F"'],
  \'divc': ['<div class=""></div>', 'F"'],
  \'strong': ['<strong></strong>', 'F<'],
  \'em': ['<em></em>', 'F<'],
  \'span': ['<span></span>', 'F<'],
  \'spani': ['<span id=""></span>', 'F"'],
  \'spanc': ['<span class=""></span>', 'F"'],
  \'ul': ["<ul>\n\t<li></li>\n<li></li>\n\<BS></ul>", '2k2l'],
  \'uli': ["<ul id=\"\">\n\t<li></li>\n<li></li>\n\<BS></ul>", '2k2l'],
  \'ulc': ["<ul class=\"\">\n\t<li></li>\n<li></li>\n\<BS></ul>", '2k2l'],
  \'ol': ["<ol>\n\t<li></li>\n<li></li>\n\<BS></ol>", '2k2l'],
  \'oli': ['<ol id="">\n\t<li></li>\n<li></li>\n\<BS></ol>', '^3k2f"'],
  \'olc': ['<ol class="">\n\t<li></li>\n<li></li>\n\<BS></ol>', '^3k2f"'],
  \'html5': ["<!DOCTYPE html>\n" .
      \"<html>\n" .
      \"<head>\n" .
      \"\t<meta charset=\"utf-8\"/>\n" .
      \"<title>Page title</title>\n" .
      \"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/screen.css\"/>\n" .
      \"\<BS></head>\n" .
      \"<body>\n" .
      \"\t\n" .
      \"\<BS></body>\n" .
      \"</html>", '2ka'],
  \'xhtml': ["<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" .
      \"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n" .
      \"    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n" .
      \"\<BS>\<BS><html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">\n" .
      \"<head>\n" .
      \"\t<title>Page title</title>\n" .
      \"<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\" />\n" .
      \"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/screen.css\" />\n" .
      \"\<BS></head>\n" .
      \"<body>\n" .
      \"\t<div id=\"wrapper\">\n" .
      \"\t\n" .
      \"\<BS></div>\n" .
      \"\<BS></body>\n" .
      \"</html>", '3ka'],
  \'form': ["<form action=\"\" method=\"post\">\n" .
      \"</form>", 'kf"a'],
  \'input': ["<input name=\"\" id=\"\" />", '3F"'],
  \'button': ["<button type=\"button\"></button>", 'F<'],
  \'submit': ["<button type=\"submit\"></button>", 'F<'],
  \'checkbox': ["<input type=\"checkbox\" name=\"\" id=\"\" />", '3F"'],
  \'radio': ["<input type=\"radio\" name=\"\" id=\"\" />", '3F"'],
  \'textarea': ["<textarea name=\"\" id=\"\"></textarea>", '3F"'],
  \'css': ["<link rel=\"stylesheet\" type=\"text/css\" href=\"css/.css\" />", '2T/'],
  \'script': ["<script type=\"text/javascript\" src=\"/js/.js\"></script>", '2T/'],
\}

if exists('g:macros')
  call extend(g:macros, g:html_macros)
else
  let g:macros = g:html_macros
endif

function! GetMacroByKey()
	let initial_pos = getpos('.')
	call search('\<', 'b') "search the start of the key
	let start_pos = getpos('.')

	let line_start = start_pos[2] == initial_pos[2]

	if line_start
		return "\<Tab>"
	endif

	"grab the key in the default register
	let one_letter_key = start_pos[2] == (initial_pos[2] - 1)

	if one_letter_key
		execute 'normal yl'
	else
		execute 'normal ye'
	endif

	let key = getreg()
	let body = get(g:macros, key)

	if empty(body) == 1
		call setpos('.', initial_pos)
		return "\<Tab>"
	endif

	if one_letter_key
		execute 'normal x'
	else
		execute 'norma de'
	endif

	let macro = body[0]
	let post_expand_command = body[1]

	if empty(post_expand_command)
		let post_expand_command = ''
	endif

	call setpos('.', start_pos)

	if strpart(post_expand_command, len(post_expand_command) - 1, 1) != 'a'
		let post_expand_command = post_expand_command . 'i'
	endif

	return macro . "\<Esc>" . post_expand_command
endfunction
