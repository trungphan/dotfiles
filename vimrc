set nocompatible

 
if has('gui_running') && has('windows')
	set guifont=DejaVu\ Sans\ Mono:h10
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
" NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scratch.vim'
NeoBundle 'sukima/xmledit'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'msanders/snipmate.vim'
" NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex', {'name': 'vim-latex'}
" NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'ivanov/vim-ipython'
NeoBundle 'klen/python-mode'


" disable rope as it's very slow
let g:pymode_rope=0

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
    \ ["Navigate: Recent", "command", ":Unite -start-insert -buffer-name=MRU file_mru"],
    \ ["Navigate: Directory Tree", "command", ":NERDTreeToggle"],
    \ ["Navigate: Test", "command", ":call java#JumpToJavaTest()"],
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


call unite#custom_source('file_rec,file_rec/async,outline,cmd', 'matchers', ['matcher_fuzzy'])
call unite#custom_source('file_rec,file_rec/async', 'filters', ['converter_relative_word', 'matcher_fuzzy', 'sorter_rank', 'converter_relative_abbr'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('source/grep', 'context', {'no_quit' : 1})

let g:unite_source_history_yank_enable = 1
nnoremap <leader>t :<C-u>Unite -buffer-name=files   -start-insert file_rec/async<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=files   -start-insert file file/new<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru     -start-insert file_mru<cr>
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
    syntax include @TeX syntax/tex.vim

    syntax region pythonCode matchgroup=Snip start="\\begin{python}" end="\\end{python}" containedin=@TeX contains=@Python

    hi link Snip SpecialComment
endfunction

autocmd BufNewFile,BufRead *.tex call HighlightTexWithOtherLanguages()

" Load local vimrc if found
if filereadable(glob(".vimrc.local"))
    source .vimrc.local
endif

