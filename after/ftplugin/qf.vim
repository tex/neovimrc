nnoremap <buffer> dd :call quickfix#DeleteLine()<CR>

" Get current list of quickfix entries "
" s: - script variable (local to this file) "
" let s:qfw_entries = getqflist()

" function! CreateTab()
"     let l:current_line_no = line('.')
"     let l:entry = s:qfw_entries[l:current_line_no - 1]
"     let filepath = substitute(bufname(l:entry.bufnr), "../", "", "")
"     if l:entry.valid
"         " Close quickfix window "
"         cclose
"         lclose
"         pclose
" 
"         " Open new tab "
"         execute 'tabnew +'.l:entry.lnum.' '.filepath
"     endif
" endfunction
" 
" " Remaps the enter key to call CreateTab() on the current entry in quickfix "
" nnoremap <buffer> <CR>    :call CreateTab()<CR>

