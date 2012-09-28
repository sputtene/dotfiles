" Checking attachments in edited emails for use in Mutt: warns user when
" exiting
" by Hugo Haas <hugo@larve.net> - 20 June 2004
" based on an idea by The Doctor What explained at
" <mid:caq406$rq4$1@FreeBSD.csie.NCTU.edu.tw>
" http://www.vim.org/scripts/download_script.php?src_id=3165
autocmd BufUnload mutt-* call CheckAttachments()
function! CheckAttachments()
  let l:english = 'attach\(ing\|ed\|ment\)\?'
  let l:french = 'attach\(e\|er\|ée\?s\?\|ement\|ant\)'
  let l:dutch = 'bijlage'

  let l:ic = &ignorecase
  if (l:ic == 0)
    set ignorecase
  endif
  if (search('^\([^>|].*\)\?\<\(re-\?\)\?\(' . l:english . '\|' . l:french . '\|' . l:dutch . '\|' . '\)\>', "w") != 0)
    let l:temp = inputdialog("Do you want to attach a file? [Hit return] ")
  endif
  if (l:ic == 0)
    set noignorecase
  endif
  echo
endfunction
