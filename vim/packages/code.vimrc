set completeopt=menuone,longest,preview

" for gf in google3
set path+=java
set path+=javatests

" rainbow colors
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['gray',        'RoyalBlue3'],
      \ ['black',       'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]

" Enable rainbow parentheses for all buffers
au VimEnter * RainbowParenthesesActivate
au Filetype scheme,lisp,clojure,java RainbowParenthesesLoadRound
au Filetype clojure,java RainbowParenthesesLoadSquare
au Filetype clojure,java RainbowParenthesesLoadBraces

au BufEnter *.java set showbreak=↳\ 
au BufEnter *.py set showbreak=↳\ 
" au BufEnter BUILD set tabstop=4 shiftwidth=4 softtabstop=2
au BufEnter *.xml set tabstop=4 shiftwidth=4 softtabstop=2
au BufEnter *.tex set showbreak=
au BufEnter *.scm set showbreak=↳\ | let b:match_skip='s:comment\|string\|character'
" modify b:match_skip for scheme so that it ignores character constant #\( and
" #\) when typing %

au BufNewFile,BufRead *.gradle setf groovy

" See http://stackoverflow.com/questions/5176972/trouble-using-vims-syn-include-and-syn-region-to-embed-syntax-highlighting
function! HighlightTexWithOtherLanguages()
  runtime! syntax/tex.vim

  unlet! b:current_syntax
  syntax include @Python syntax/python.vim

  unlet! b:current_syntax
  syntax include @Java syntax/java.vim

  unlet! b:current_syntax
  syntax include @TeX syntax/tex.vim

  syntax region pythonCode matchgroup=Snip start="\\begin{python}" end="\\end{python}" containedin=@TeX contains=@Python
  syntax region javaCode matchgroup=Snip start="\\begin{java}" end="\\end{java}" containedin=@TeX contains=@Java

  hi link Snip SpecialComment
endfunction

autocmd BufNewFile,BufRead *.tex call HighlightTexWithOtherLanguages()

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_matchpairs = "(:),[:],{:},<:>"
" Make delimitMate handle [] and () correctly when handling <CR>
" imap <expr><CR> pumvisible() ? "\<C-n>" : "<Plug>delimitMateCR"


let g:EclimCompletionMethod = 'omnifunc'
let g:EclimJavaSearchSingleResult = 'edit'
let g:EclimLocateFileDefaultAction = 'edit'

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

