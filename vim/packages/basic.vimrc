filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set wrap
set textwidth=0 wrapmargin=0
set ruler
set modeline
set ls=2
set encoding=utf-8
set nobackup
set noswapfile
set nolist
set lcs=tab:»·
set lcs+=trail:·
set lcs+=eol:↲
set lcs+=extends:#
set hlsearch
set incsearch
set ignorecase
set smartcase
set relativenumber
set number
set wildignore+=*.class,*.jar,*.pyc
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
let loaded_matchparen=1
set backspace=eol,start,indent
set linebreak
set breakindent
set showbreak=↳\ 
set colorcolumn=101
set wildmenu
set foldlevelstart=20
set scrolloff=5              " At least 5 lines around cursor, also good for debugging with Vigor
set vb                       " Turn on visual bell so that it does not beep

set fillchars=vert:│,fold:-

syntax on

" Solarized colorscheme
set t_Co=16
let g:solarized_termcolors=16
if has('win32') || has('win64')
    let g:solarized_underline=0   "ConEmu does not support underline for Windows yet
endif
set background=light
colorscheme solarized

hi VertSplit ctermbg=NONE guibg=NONE

"Easy motions
nmap s <Plug>(easymotion-s)
nmap <leader>w <Plug>(easymotion-bd-w)
omap t <Plug>(easymotion-bd-t)
omap / <Plug>(easymotion-tn)

let g:indentLine_char = '│'

let g:airline_left_sep=''
let g:airline_right_sep=''
" let g:airline#extensions#tabline#enabled = 1
" defalt g:airline_section_z='%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v'
let g:airline_section_z='%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v│%{winnr()}'

" see https://wiki.corp.google.com/twiki/bin/view/Main/CtrlP on how to speed of ctrlp
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ --ignore review
      \ -g ""'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_use_caching = 0

nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
nnoremap <silent>[menu]u :Unite -silent -winheight=20 -start-insert menu:all<CR>
nnoremap <silent>[menu]l :Unite -silent -start-insert line<CR>
nnoremap <silent><leader>e :<C-u>VimFiler -buffer-name=explorer -no-quit -split -status -columns={type} -winwidth=50 -toggle<CR>
nnoremap <silent><leader>E :<C-u>VimFilerBufferDir -buffer-name=explorer -no-quit -split -status -columns={type} -winwidth=50 -toggle<CR>
nnoremap <silent><leader>o :<C-u>Unite -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru     -start-insert neomru/file<cr>
nnoremap <leader>b :<C-u>Unite -buffer-name=buffer     -start-insert buffer<cr>
"nnoremap <leader>t :LocateFile<cr>
nnoremap <silent><leader>t :FZF<cr>
" jump to the nth match of a search: e.g. 10,n
map <Leader>n :<C-U>exe "normal! gg".v:count1."n"<CR><Plug>SearchIndex

"Glaive ranger !remember_last_visited
nnoremap <leader>f :<C-U>call ranger#RangeChooser('')<CR>
nnoremap <leader>F :<C-U>call ranger#RangeChooser(expand('%:p'))<CR>

vmap <C-c><C-c> "ay :call tmux#send#Send(@a) <CR>
nmap <C-c><C-c> V"ay :call tmux#send#Send(@a)<CR>
nmap <C-c>v :TmuxTarget<CR>

nnoremap <silent><C-S-H> :<C-u>BufSurfBack<CR>
nnoremap <silent><C-S-L> :<C-u>BufSurfForward<CR>

" Delete a buffer without closing the window
"command Bd bp\|bd \#

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <Esc>      <Plug>(unite_exit)
endfunction

" Move to a window by number
nnoremap <Leader>1 :1wincmd w<CR>
nnoremap <Leader>2 :2wincmd w<CR>
nnoremap <Leader>3 :3wincmd w<CR>
nnoremap <Leader>4 :4wincmd w<CR>
nnoremap <Leader>5 :5wincmd w<CR>
nnoremap <Leader>6 :6wincmd w<CR>
nnoremap <Leader>7 :7wincmd w<CR>
nnoremap <Leader>8 :8wincmd w<CR>
nnoremap <Leader>9 :9wincmd w<CR>

call unite#custom#source('file,file/new,buffer,file_rec,file_rec/git,outline,line,menu',
      \ 'matchers', 'matcher_fuzzy')

let g:unite_source_menu_menus.all = {
      \ 'description' : '  All', }

let g:unite_source_menu_menus.all.command_candidates = [
      \['search                                                     ⌘ ,b', ":exec 'Fag(' . input('search: ') . ')'"],
      \['search under cursor                                        ⌘ ,b', ":exec 'Fag(' . expand('<cword>') . ')'"],
      \['vimrc                                                      ⌘ ,b', ":if &modified | :vsplit $MYVIMRC | else | :edit $MYVIMRC | endif"],
      \['jump                                                       ⌘ ,b', ":call jump#JumpToFile()"],
      \['commands                                                   ⌘ ,b', ":edit ~/git/dotfiles/commands"],
      \['cheatsheet                                                 ⌘ ,b', ":edit ~/git/dotfiles/cheatsheet"],
      \['pull from android                                          ⌘ ,b', ":PullFromStudio" ],
      \['send to android                                            ⌘ ,b', ":SendToStudio" ],
      \['Toogle HEX                                                 ⌘ ,b', ":if getline(1) =~ '0000000:' | exec ':%!xxd -r' | else | exec ':%!xxd' | endif"],
      \['Toggle dark/light background                               ⌘ ,b', ":let &background = ( &background == 'dark'? 'light' : 'dark' )"],
      \['Toggle invisible characters                                ⌘ ,b', ":set list!"],
      \['Toggle number                                              ⌘ ,b', ":if &number == 0 | set number | set relativenumber | else | set nonumber | set norelativenumber"],
      \['Toggle gitgutter                                           ⌘ ,b', ":GitGutterToggle"],
      \['git status                                                 ⌘ ,b', ":Gstatus"],
      \['git revert                                                 ⌘ ,b', ":GitGutterRevertHunk"],
      \['git stage                                                  ⌘ ,b', ":GitGutterStageHunk"],
      \['git5 lint                                                  ⌘ ,b', ":cexpr system('git5 lint -q')"],
      \['Syntastic Check                                            ⌘ ,b', ":SyntasticCheck"],
      \['CL files                                                   ⌘ ,b', ":PiperLoadActiveAsBuffers"],
      \['Delete buffer                                              ⌘ ,b', ":bp | sp | bn | bd"],
      \['Sudo save                                                  ⌘ ,b', ":w !sudo tee > /dev/null %"],
      \['colorscheme solarized                                      ⌘ ,b', ":set t_Co=16 | colorscheme solarized"],
      \['colorscheme papercolor                                     ⌘ ,b', ":set t_Co=256 | colorscheme PaperColor"],
      \['colorscheme summerfruit                                    ⌘ ,b', ":set t_Co=256 | colorscheme summerfruit256"],
      \['colorscheme hemisu                                         ⌘ ,b', ":set t_Co=256 | colorscheme hemisu"],
      \]

command! SendToStudio call s:send_to_studio()
function! s:send_to_studio()
  let files = split(system('ps -ef | grep -o "[/]bin/sh .*studio.sh" | cut -d" " -f 2'), '\n')
  for f in files
    call system(f . ' --line ' . line('.') . ' ' . fnameescape(expand('%:p')))
  endfor
endfunction

command! PullFromStudio call s:pull_from_studio()
function! s:pull_from_studio()
  let files = split(system("wmctrl -l -p | grep -o '] - [^]]* - Android Studio' | sed -r 's/^.{4}//' | sed -r 's/.{17}$//'"), '\n')
  for f in files
    exec "edit " . fnameescape(f)
  endfor
endfunction

let g:hardtime_default_on = 1
let g:hardtime_timeout = 2000
let g:hardtime_maxcount = 10

let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_tree_leaf_icon = '│'
" let g:vimfiler_readonly_file_icon

autocmd FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings()
  setlocal winfixwidth
  setlocal nonumber
  setlocal norelativenumber
endfunction

"Rename tabs to show tab# and # of viewports
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
            let s .= i
            if tabpagewinnr(i,'$') > 1
                let s .= '.'
                let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
                let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
            end

            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let path = fnamemodify(file, ':p:h')
                let file = fnamemodify(file, ':p:t')
                echom path
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            if getbufvar(bufnr, "&modified")
              let s .= '*'
            endif
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        return s
    endfunction
    " set stal=2
    " set tabline=%!MyTabLine()
endif

