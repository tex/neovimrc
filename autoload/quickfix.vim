function! quickfix#DeleteLine()
    let l:current_line_no = line('.')
    call setqflist(filter(getqflist(), {idx -> idx != l:current_line_no - 1}), 'r')
    execute ":".l:current_line_no
endfunction
