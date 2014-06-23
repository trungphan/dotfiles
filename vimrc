set nocompatible

 
if has('gui_running') && has('windows')
    if has('win32') || has('win64')
	    set guifont=DejaVu\ Sans\ Mono:h10
    else
	    set guifont=DejaVu\ Sans\ Mono 10
    endif
endif

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

" NOTE
" To install: :NeoBundleInstall
" To update:  :NeoBundleUpdate
" For unite-outline to work for java, must install exuberant-ctags

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'Shougo/unite-session'
" NeoBundle 'ujihisa/unite-launch'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'tpope/vim-surround'
" NeoBundle 'kien/ctrlp.vim' " replaced by unite.vim
NeoBundle 'bling/vim-airline'
NeoBundle 'matchit.zip'
NeoBundle 'altercation/vim-colors-solarized'
" NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'thinca/vim-quickrun'
NeoBundle 'trungphan/unite-cmd'
NeoBundle 'trungphan/vim-java-nav'
NeoBundle 'trungphan/vim-jump'
" NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scratch.vim'
NeoBundle 'sukima/xmledit'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'msanders/snipmate.vim'
" NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex', {'name': 'vim-latex'}
" NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'ivanov/vim-ipython' " not really need ipython
NeoBundle 'klen/python-mode'
" NeoBundle 'VimClojure' " depreciated, replaced by vim-clojure-static, vim-fireplace
" NeoBundle 'slimv.vim'  " for clojure no longer recommended, use fireplace
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'vim-scripts/paredit.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'dag/vim2hs'

NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'Valloric/YouCompleteMe'

" disable rope as it's very slow
let g:pymode_rope=0
let g:pymode_trim_whitespaces=1

" Solarized colorscheme
set t_Co=16
colorscheme solarized
let g:solarized_termcolors=16
" let g:airline_theme='solarized'
set background=light

" Remove arrow for airline status line
let g:airline_left_sep=' '
let g:airline_right_sep=' '

set foldlevelstart=20

let g:unite_quickfix_is_multiline=0
call unite#custom_source('quickfix', 'converters', 'converter_quickfix_highlight')
call unite#custom_source('location_list', 'converters', 'converter_quickfix_highlight')

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set wrap

set completeopt=menuone,longest
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

let g:ycm_filetype_blacklist = {
        \ 'java' : 1,
        \ 'scm' : 1,
        \ 'py' : 1,
        \}


let g:unite_cmd_list = {'menu' : [
    \ ["File: Open/New", "command", ":Unite -start-insert -buffer-name=Files file file/new"],
    \ ["Current Directory", "command", ":execute 'Unite -start-insert -buffer-name=Files -input='.strpart(expand('%:p:h'), len(getcwd())+1).' file file/new'"],
    \ ["Scratch", "command", ":Scratch"],
    \ ["Search: ", "command", ":UniteWithCursorWord -buffer-name=Search grep"],
    \ ["Symbol", "command", ":Unite -start-insert -buffer-name=Symbols cmd:symbol"],
    \ ["XML: Pretty format", "command", ":% !xmllint % --format"],
    \ ["Navigate: Resources", "command", ":Unite -start-insert -buffer-name=Resources file_rec/async"],
    \ ["Navigate: Outline", "command", ":Unite -start-insert -buffer-name=Outline outline"],
    \ ["Navigate: Buffers", "command", ":Unite -start-insert -buffer-name=Buffers buffer"],
    \ ["Navigate: Recent", "command", ":Unite -start-insert -buffer-name=MRU neomru/file"],
    \ ["Navigate: Directory Tree", "command", ":NERDTreeToggle"],
    \ ["Navigate: Test", "command", ":call jump#JumpToFile()"],
    \ ["Build: Make", "command", ":make | cw"],
    \ ["Build: Run", "command", ":make run % | cw"],
    \ ["Display: Toggle Invisible", "command", ":set list!"],
    \ ["Display: Toggle Syntax", "command", ":if exists('g:syntax_on') | syntax off | else | syntax enable | endif"],
    \ ["Display: Toggle Paste", "command", ":set paste!"],
    \ ["Display: Toggle Number", "command", ":set nu!"],
    \ ["Display: Toggle Highlight Search", "command", ":set hlsearch!"],
    \ ["Display: Toggle Background Light\/Dark", "command", ":let &background = ( &background == 'dark'? 'light' : 'dark' )"],
    \ ["Git: Status", "command", ":Gstatus"],
    \ ["Preferences: VIMRC", "command", ":if &modified | :vsplit $MYVIMRC | else | :edit $MYVIMRC | endif"],
    \ ["Preferences: Rebuild Tags", "command", "VimProcBang ctags -R ./src/main/java"],
    \ ],
    \ 'symbol' : [
    \ ["Math: Not equal                       [2260]  ≠ ", "command", ":normal a≠\<Esc>l"],
    \ ["Math: Greater than equal              [2265]  ≥ ", "command", ":normal a≥"],
    \ ["Math: Less than equal                 [2264]  ≤ ", "command", ":normal a≤"],
    \ ["Math: Element of                      [2208]  ∈ ", "command", ":normal a∈"],
    \ ["Math: Subset of                       [2282]  ⊂ ", "command", ":normal a⊂"],
    \ ["Math: For all                         [2200]  ∀ ", "command", ":normal a∀"],
    \ ["Math: Exists                          [2203]  ∃ ", "command", ":normal a∃"],
    \ ["Math: Implies                         [21D2]  ⇒ ", "command", ":normal a⇒"],
    \ ["Math: Equivalent                      [21D4]  ⇔ ", "command", ":normal a⇔"],
    \ ["Draw: Box                                       ", "command", ":normal a┌─┬─┐│ │ │├─┼─┤└─┴─┘"],
    \ ["Draw: Horizontal                      [2500]  ─ ", "command", ":normal a─"],
    \ ["Draw: Vertical                        [2502]  │ ", "command", ":normal a│"],
    \ ["Draw: Top Left                        [250C]  ┌ ", "command", ":normal a┌"],
    \ ["Draw: Bottom Left                     [2514]  └ ", "command", ":normal a└"],
    \ ["Draw: Bottom Right                    [2518]  ┘ ", "command", ":normal a┘"],
    \ ["Draw: Top Right                       [2510]  ┐ ", "command", ":normal a┐"],
    \ ]}

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
let loaded_matchparen=1
set backspace=2

set linebreak
if exists('+breakindent')
    set breakindent
    set showbreak=↳\ 
endif

" Mouse
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set ruler
set modeline

" last status
set ls=2

set encoding=utf-8

syntax on

set nobackup
set noswapfile


" list chars, to show listchars: set list
set nolist
set lcs=tab:»·
set lcs+=trail:·
set lcs+=eol:↲

" search
set hlsearch
set incsearch
set ignorecase
set smartcase


set wildignore+=*.class
set wildignore+=*.jar
set wildignore+=*.pyc

set wildmenu

let mapleader=","

let g:ctrlp_custom_ignore = 'surefire-report\|__pycache__\|doc/'

" let g:unite_source_file_rec_ignore_pattern = 'bin\/\|doc\/\|lib\/\|\.*\.pyc\|\.idea\/\|target\/\|\.git\|\.DS_Store\|\.vimrc\.local'

if filereadable(glob($VIMRUNTIME . "/autoload/vimproc_unix.so"))
    let g:vimproc_dll_path=$VIMRUNTIME . "/autoload/vimproc_unix.so"
endif

map <F7> :update<cr>:make<cr>:cw<cr><cr>
map <F8> :cprevious<cr>
map <F9> :cnext<cr>
nmap <F5> :buffers<cr>:buffer<space>
nmap <tab> :bnext<cr>
nmap <S-tab> :bprevious<cr>

map <C-W><C-M> :update<cr>:make<cr>:cw<cr><cr>

call unite#custom#source('file_rec,file_rec/async,outline,cmd,neomru/file,file_mru', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])
call unite#custom#source('file_rec,file_rec/async,neomru/file,file_mru', 'filters', ['converter_relative_word', 'matcher_fuzzy', 'sorter_rank', 'converter_relative_abbr'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('source/grep', 'context', {'no_quit' : 1})

let g:unite_source_history_yank_enable = 1
if has('win32') || has('win64')
    nnoremap <leader>t :<C-u>Unite -buffer-name=files   -start-insert file_rec<cr>
else
    nnoremap <leader>t :<C-u>Unite -buffer-name=files   -start-insert file_rec/async<cr>
endif

nnoremap <leader>f :<C-u>Unite -buffer-name=files   -start-insert file file/new<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru     -start-insert neomru/file<cr>
nnoremap <leader>o :<C-u>Unite -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank    history/yank<cr>
"nnoremap <leader>e :<C-u>Unite -buffer-name=buffer  buffer<cr>
nnoremap <leader>c :<C-u>Unite -buffer-name=command -start-insert cmd:menu<cr>


let g:ipy_perform_mappings = 0
map  <buffer> <silent> <C-l>        <Plug>(IPython-RunLine)
imap <buffer> <silent> <C-l>        <C-o><Plug>(IPython-RunLine)
map  <buffer> <silent> <leader>d    <Plug>(IPython-OpenPyDoc)
map  <buffer> <silent> <leader>s    <Plug>(IPython-UpdateShell)



" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <esc>   <Plug>(unite_exit)
endfunction

autocmd BufNewFile package-info.java
            \ exe java#DefaultPackageInfoContent()
autocmd BufNewFile *.java
            \ if expand('%:t') != 'package-info.java' |
            \     exec java#DefaultJavaContent() |
            \ endif

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
au Filetype scheme,lisp,clojure RainbowParenthesesLoadRound
au Filetype clojure RainbowParenthesesLoadSquare
au Filetype clojure RainbowParenthesesLoadBraces

au BufEnter *.java set showbreak=↳\ 
au BufEnter *.py set showbreak=↳\ 
au BufEnter *.tex set showbreak=
au BufEnter *.scm set showbreak=↳\ | let b:match_skip='s:comment\|string\|character'
" modify b:match_skip for scheme so that it ignores character constant #\( and
" #\) when typing %

" Load local vimrc if found
if filereadable(glob(".vimrc.local"))
    source .vimrc.local
endif

