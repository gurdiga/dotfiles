set expandtab

iabbrev rq require('');<ESC>F'i<C-R>=Eatchar('\s')<CR>
iabbrev colo console.log('');<ESC>F'i<C-R>=Eatchar('\s')<CR>
iabbrev fn function() {<CR>}<ESC><UP>$F)i<C-R>=Eatchar('\s')<CR>
iabbrev fnus (function(window, document, undefined) {}(window, document));<ESC>F}i<CR><CR><CR><UP><UP><TAB>'use strict';<CR><CR><C-R>=Eatchar('\s')<CR>
iabbrev us; 'use strict';<C-R>=Eatchar('\s')<CR><CR>
iabbrev me= module.exports =;<ESC>i

iabbrev tede describe('', function() {});<ESC>F}i<CR><ESC>O<TAB><UP><ESC>2f'i<C-R>=Eatchar('\s')<CR>
iabbrev teit it('', function() {});<ESC>F}i<CR><ESC>O<TAB><UP><ESC>^2f'i<C-R>=Eatchar('\s')<CR>
iabbrev tebe beforeEach(function() {});<ESC>F}i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>
iabbrev teaf afterEach(function() {});<ESC>F}i<CR><ESC>O<TAB><C-R>=Eatchar('\s')<CR>
