set nocompatible

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
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'trungphan/unite-cmd'

" Solarized colorscheme
set t_Co=16
colorscheme solarized
let g:solarized_termcolors=16
" let g:airline_theme='solarized'
set background=dark

" Remove arrow for airline status line
let g:airline_left_sep=' '
let g:airline_right_sep=' '


" Quickfix (unite.vim plugin)
let g:unite_quickfix_is_multiline=0
call unite#custom_source('quickfix', 'converters', 'converter_quickfix_highlight')
call unite#custom_source('location_list', 'converters', 'converter_quickfix_highlight')

filetype on
filetype plugin on

let g:unite_cmd_list = [
    \ ["Navigate: Files", "command", ":Unite -start-insert -buffer-name=Files file_rec/async"],
    \ ["Navigate: Outline", "command", ":Unite -start-insert -buffer-name=Outline outline"],
    \ ["Build: Make", "command", ":make | cw"],
    \ ]

" Tabs
set tabstop=4
set shiftwidth=4
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

map <F7> :update<cr>:make<cr>:cw<cr><cr>
map <F8> :cprevious<cr>
map <F9> :cnext<cr>
nmap <F5> :buffers<cr>:buffer<space>
nmap <tab> :bnext<cr>
nmap <S-tab> :bprevious<cr>

map <C-W><C-M> :update<cr>:make<cr>:cw<cr><cr>


call unite#custom_source('file,file_rec,file_rec/async,outline,cmd', 'matchers', ['matcher_fuzzy'])

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
endfunction

" Load local vimrc if found
if filereadable(glob(".vimrc.local"))
    source .vimrc.local
endif


