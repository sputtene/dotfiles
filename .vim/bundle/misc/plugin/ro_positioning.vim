" http://www.vim.org/scripts/script.php?script_id=718
" $VIMRUNTIME/plugin/ro-positioning.vim
    if exists("g:ro_positioning_loaded") | finish | endif
    let g:ro_positioning_loaded=1
    let s:save_so = &scrolloff

    function! s:RoBufEnter()
        if &readonly
             if line(".") == 1
                 let s:x=winheight(winnr())/2
                 :exe ":" . s:x . "\n"
             endif
             set so=999
        else
             let &so = s:save_so
        endif
        if &so == 999 && &readonly 
            " noremap j :call s:SoRo_Down()<cr>
            noremap <silent> <Down> :call SoRo_Down()<cr>
            noremap <silent> <Up>   :call SoRo_Up()<cr>

            noremap <silent> <Delete> :call SoRo_Down()<cr>
            noremap <silent> <Insert> :call SoRo_Up()<cr>
        endif
    endfunction
    function! SoRo_Down()
        if &so == 999 && &readonly
            if line('.') < winheight(winnr())/2
                let skip=winheight(winnr())/2 - line('.')
                :exe "normal " skip . "j"
            else
                normal j
            endif
        else
            normal j
        endif
        echo ""
    endfunction
    function! SoRo_Up()
        if &so != 0 && &readonly
            if line('.') > line('$') - winheight(winnr())/2
                let skip=line('.') - (line('$') - winheight(winnr())/2)
                :exe "normal " skip ."k"
            else
                normal k
            endif
        else
            normal k
        endif
        echo ""
    endfunction

    au BufEnter * :call s:RoBufEnter()
" $VIMRUNTIME/plugin/ro-positioning.vim
