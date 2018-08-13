nnoremap <leader>v :call <SID>VimGrepOperator()<cr>

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
vnoremap <leader>G :<c-u>call <SID>GrepOperator(visualmode(), '-r')<cr>

function! s:VimGrepOperator()
    " grab pattern from search register
    let pattern = '/' . @/ . '/'

    silent execute "vimgrep! " . pattern . " %"
    copen
    redraw!
endfunction

function! s:GrepOperator(type, ...)
    let saved_unnamed_register = @@
    let command = "grep!"

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    if a:0
        let command .= ' ' . a:1
    endif

    silent execute command . ' ' . shellescape(@@, 1) . " *"
    copen
    redraw!

    let @@ = saved_unnamed_register 
endfunction
