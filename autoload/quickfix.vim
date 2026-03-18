function! quickfix#DeleteLine()
    let l:current_line_no = line('.')
    call setqflist(filter(getqflist(), {idx -> idx != l:current_line_no - 1}), 'r')
    execute ":".l:current_line_no
endfunction

function! quickfix#Sort()
    let l:current_line_no = line('.')
    call setqflist(sort(getqflist(), 'QfStrCmp'), 'r')
    execute ":".l:current_line_no
endfunction
function! QfStrCmp(e1, e2)
    let [t1, t2] = [bufname(a:e1.bufnr), bufname(a:e2.bufnr)]
    return t1 <# t2 ? -1 : t1 ==# t2 ? 0 : 1
endfunction
