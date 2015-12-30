
nnoremap <leader>f :<C-U>call RangeChooser('')<CR>
nnoremap <leader>F :<C-U>call RangeChooser(expand('%:p'))<CR>

let s:remember_last_visited = 1

let s:ranger_choosefiles = tempname()
let s:ranger_choosefile = tempname()
let s:ranger_choosedir = tempname()

""
" Open ranger to select or manage files.
function! RangeChooser(select_file)

  echom a:select_file

  " Commands to empty temp files and open ranger
  let l:cmd = 'silent !cat /dev/null >' . shellescape(s:ranger_choosefiles)
        \. ' && cat /dev/null >' . shellescape(s:ranger_choosefile)
        \. ' && cat /dev/null >' . shellescape(s:ranger_choosedir)
        \. ' && ranger --choosefiles=' . shellescape(s:ranger_choosefiles)
        \. ' --choosefile=' . shellescape(s:ranger_choosefile)
        \. ' --choosedir=' . shellescape(s:ranger_choosedir)

  let l:show_hidden = 0
  if len(a:select_file) > 0
    let l:cmd .= ' --selectfile=' . shellescape(a:select_file)
    let l:show_hidden = fnamemodify(a:select_file, ':t') =~ "^\\."
  elseif s:remember_last_visited
    let l:last_file = s:ReadFirstLine(s:ranger_choosefile, '')
    if empty(l:last_file)
      let l:last_file = s:ReadFirstLine(s:ranger_choosedir, '.')
      let l:cmd .= ' --cmd="cd -r \%f"'
    endif
    let l:cmd .= ' --selectfile=' . shellescape(l:last_file)
    let l:show_hidden = fnamemodify(l:last_file, ':t') =~ "^\\."
  endif
  if l:show_hidden
    let l:cmd .= ' --cmd="set show_hidden true"'
  endif

  echom l:cmd
  exec l:cmd

  let l:names = readfile(s:ranger_choosefiles)
  if !empty(l:names) && !empty(l:names[0])
    " Open the selected file
    exec 'edit ' . fnameescape(s:ReadFirstLine(s:ranger_choosefile, l:names[0]))
    if len(l:names) > 1
      " Open other selected files in buffers
      for l:name in l:names
        exec 'argadd ' . fnameescape(l:name)
      endfor
    endif
  endif
  redraw!

endfunction

""
" Read the first line from a {file}. If it's empty or nonexisting, return
" value {defaultIfEmpty}
function s:ReadFirstLine(file, defaultIfEmpty)
  if !filereadable(a:file)
    return a:defaultIfEmpty
  endif
  let l:lines = readfile(a:file, '', 1)
  if empty(l:lines) || empty (l:lines[0])
    return a:defaultIfEmpty
  endif
  return l:lines[0]
endfunction

