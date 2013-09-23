set nocompatible

 
if has('gui_running') && has('windows')
	set guifont=DejaVu\ Sans\ Mono:h10
endif

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
NeoBundle 'Shougo/unite-session'
NeoBundle 'ujihisa/unite-launch'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'matchit.zip'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'thinca/vim-quickrun'
NeoBundle 'trungphan/unite-cmd'
NeoBundle 'trungphan/vim-java-nav'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-fugitive'

" Solarized colorscheme
set t_Co=16
colorscheme solarized
let g:solarized_termcolors=16
" let g:airline_theme='solarized'
set background=light

" Remove arrow for airline status line
let g:airline_left_sep=' '
let g:airline_right_sep=' '


" Quickfix (unite.vim plugin)
let g:unite_quickfix_is_multiline=0
call unite#custom_source('quickfix', 'converters', 'converter_quickfix_highlight')
call unite#custom_source('location_list', 'converters', 'converter_quickfix_highlight')

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

let g:unite_cmd_list = [
    \ ["File: Open/New", "command", ":Unite -start-insert -buffer-name=Files file"],
    \ ["Directory", "command", ":Unite -start-insert -buffer-name=Directories directory"],
    \ ["Search: ", "command", ":UniteWithCursorWord -buffer-name=Search grep"],
    \ ["Navigate: Resources", "command", ":Unite -start-insert -buffer-name=Resources file_rec/async"],
    \ ["Navigate: Outline", "command", ":Unite -start-insert -buffer-name=Outline outline"],
    \ ["Navigate: Buffers", "command", ":Unite -start-insert -buffer-name=Buffers buffer"],
    \ ["Navigate: MRU", "command", ":Unite -start-insert -buffer-name=MRU file_mru"],
    \ ["Navigate: Directory Tree", "command", ":NERDTreeToggle"],
    \ ["Navigate: Test", "command", ":call jump#JumpToJavaTest()"],
    \ ["Build: Make", "command", ":make | cw"],
    \ ["Display: Toggle Invisible", "command", ":set list!"],
    \ ["Display: Toggle Syntax", "command", ":if exists('g:syntax_on') | syntax off | else | syntax enable | endif"],
    \ ["Display: Toggle Highlight Search", "command", ":set hlsearch!"],
    \ ["Display: Toggle Background Light\/Dark", "command", ":let &background = ( &background == 'dark'? 'light' : 'dark' )"],
    \ ["Preferences: VIMRC", "command", ":vsplit $MYVIMRC"],
    \ ["Preferences: Rebuild Tags", "command", "VimProcBang ctags -R ./src"],
    \ ]

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
let loaded_matchparen=1
set backspace=2

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

set wildmenu

let mapleader=","

let g:ctrlp_custom_ignore = 'surefire-report\|__pycache__\|doc/'

let g:unite_source_file_rec_ignore_pattern = '/bin\/\|doc\/\|lib\/\|\.idea\/\|target\/\|\.git\|\.DS_Store/'

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
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('source/grep', 'context', {'no_quit' : 1})

let g:unite_source_history_yank_enable = 1
nnoremap <leader>t :<C-u>Unite -buffer-name=files   -start-insert file_rec/async<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -buffer-name=buffer  buffer<cr>
nnoremap <leader>c :<C-u>Unite -buffer-name=command -start-insert cmd<cr>

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

" Load local vimrc if found
if filereadable(glob(".vimrc.local"))
    source .vimrc.local
endif

