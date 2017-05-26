" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=99 foldmethod=marker
"
"   This is the personal .vimrc file of Steve Francia.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find me at http://spf13.com
"
"   Edited heavily by Sven Putteneers.
" }

" Temporarily disable CSApprox until I have a nice color scheme
let g:CSApprox_loaded = 1

" Environment {
    " Basics {
        set nocompatible        " must be first line
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
            set encoding=utf-8
        endif
    " }

    " Setup Bundle Support {
    " Powerline special configuration
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

    " The next 3 lines ensure that the ~/.vim/bundle/ system works
        runtime bundle/vim-pathogen/autoload/pathogen.vim
        silent! call pathogen#infect()
        silent! call pathogen#helptags()
    " }
" }

" General {
    if (!has('win32') && !has('win64'))
        set term=$TERM       " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    set mouse=                  " always disable Vim mouse handling
    scriptencoding utf-8

    set autowrite                   " automatically write a file when leaving a modified buffer or :make
    set shortmess+=filmnrwxoOtTI    " abbrev. of messages (avoids 'hit enter')
    set viewoptions=cursor,folds,options,slash,unix " better unix / windows compatibility
    set virtualedit=block           " allow for cursor beyond last character when in Visual block mode
    set history=1000                " Store a ton of history (default is 20)

    set updatetime=1000             " make updates happen more quickly
    set nomore                      " don't pause when screen is full

    set backup                      " backups are nice ...
    set undofile                    " ... and so is persistent undo

    set spelllang=en,nl              " English and Dutch word lists
    set nospell                      " spell checking is enabled depending on filetype

    " General autocommands {
        augroup General
            autocmd!

            " Save and load view (state): folds, cursor, etc.
            autocmd BufWinLeave * silent! mkview
            autocmd BufWinEnter * silent! loadview

            " Open quickfix window after :make, :grep, ... if there
            " are recognized errors
            autocmd QuickFixCmdPost * :cwindow 5
        augroup END
    " }

    " Make vim write the closing } when I write a {
    abbreviate { {<CR>}<Esc>kA

    " Broken down for easy inclusion
    set viminfo=
    set viminfo+='1000  " max number of previous files for which the marks are remembered
    set viminfo+=!      " save and restore globals in all uppercase
    set viminfo+=%      " save and restore buffer list
    set viminfo+=/1000  " max number of search and substitute patterns to save
    set viminfo+=:1000  " max number of command line items to save
    set viminfo+=<100   " max number of lines for each register to save
    set viminfo+=@100   " max number of input-line history to save
    set viminfo+=f1     " store file marks ('0 to '9, 'A to 'Z)
    set viminfo+=h      " disable effect of hlsearch when loading viminfo
    set viminfo+=s10    " max size of an item in Kb
" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " remove the toolbar
        set lines=40                " 40 lines of text instead of 24,
        set linespace=0             " No extra spaces between rows
    endif
" }

" Vim UI {
    " set color scheme and font {
        if has("gui_running")
            if has("win32") || has("win64")
                set guifont=Envy_Code_R:h10
            else
                set guifont=Envy\ Code\ R\ 9
            endif
            colorscheme darkblue2
        else
            "colorscheme matrix
            colorscheme darkblue2
        endif

        " Manually perfect some highlighting aspects
        highlight Comment   cterm=italic gui=italic                                 " Italic comments :D
        highlight ToDo      term=bold cterm=bold ctermfg=White ctermbg=DarkRed      " Make TODO's, FIXME's, XXX's stand out a bit more

        highlight VertSplit term=NONE cterm=NONE gui=NONE                           " Unfatten vertical split lines

        highlight NonText   ctermfg=DarkGrey

        " Spelling error highlighting
        highlight SpellBad   cterm=bold,underline,italic ctermbg=DarkRed "ctermfg=LightRed
        highlight SpellCap   cterm=bold,underline,italic
        highlight SpellLocal cterm=bold,underline,italic
        highlight SpellRare  cterm=bold,underline,italic
    " }

    set tabpagemax=15   " only show 15 tabs
    set showmode        " display the current mode

    set nocursorline nocursorcolumn     " don't highlight current line nor column

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2            " always show status line

        " Broken down into easily includeable segments
        set statusline=
        set statusline+=%-3.3n\                     " buffer number
        set statusline+=%<%f                        " Filename
        set statusline+=\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}  " file encoding
        set statusline+=%(\ %a%)                   " ({current} of {max})
        set statusline+=\ %h%m%r%w                  " Status flags
        set statusline+=%{fugitive#statusline()}    " Git Hotness
        set statusline+=\ [%{&ff}/%Y]               " \n format and filetype
        set statusline+=\ %{VimBuddy()}             " show the vimbuddy
        "set statusline+=\ [%{getcwd()}]            " current dir
        set statusline+=\ {%{Tlist_Get_Tag_Prototype_By_Line()}}    " prototype of current function
        set statusline+=%=                          " right align remainder
        set statusline+=%3b\-0x%-8B                 " ASCII/Unicode value of char
        set statusline+=%-14.(%l,%c%V%)             " line,character
        set statusline+=%P                          " file position
    endif

    set number           " Line numbers

    set backspace=indent,eol,start  " backspace for dummys
    set showmatch                   " show matching brackets/parenthesis
    set winminheight=0              " windows can be 0 line high

    " visual cue for reasonable line length
    highlight ColorColumn ctermbg=52 guibg=#5f0000
    if exists('+colorcolumn')
        set colorcolumn=80
    else
        au BufWinEnter * let w:m2=matchadd('ColorColumn', '\%>80v.\+', -1)
    endif

    set incsearch       " find as you type search
    set hlsearch        " highlight search terms
    set ignorecase      " case insensitive search
    set smartcase       " case sensitive when uc present
    set wrapscan        " search wraps around EOF

    " Temporarily turn off highlighting when entering insert mode
    autocmd InsertEnter * :setlocal nohlsearch
    autocmd InsertLeave * :setlocal hlsearch


    set wildmenu                " show list instead of just completing
    "set wildmode=longest,list   " command <Tab> completion, list matches, then longest common part, then all.
    set wildmode=full
    set wildignore+=*.bak,*.swp,*.o,*~  " completely ignore these files
    set suffixes+=.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc     " These are files we are not likely to want to edit or read.

    set nofoldenable            " manually fold code
    set foldcolumn=2            " indicate open and closed folds at the side of the window
    set foldtext=MyFoldText()   " define foldtext function which handles custom foldmarks more gracefully
    function MyFoldText()
        let line = getline(v:foldstart)
        "let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
        "return v:folddashes . sub
        let sub = substitute(line, '^\W*\|\W*$', '', 'g')
        let amount = v:foldend - v:foldstart
        return v:folddashes . ' ' . amount . ' lines: ' . sub . ' '
    endfunction


    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap too

    set scrolljump=1    " lines to scroll when cursor leaves screen
    set scrolloff=3     " context lines to keep above and below cursor

    set list            " show various invisible markers
    if ((&termencoding ==# 'utf-8') || (&encoding == "utf-8") || has("gui_running"))
        let &listchars="tab:\u2506\ ,trail:\u2022,extends:\u2026,eol:\u21b2,nbsp:\u2017,precedes:\u00ab,extends:\u00bb"
        let &fillchars="vert:\u2502,fold:\u257c"
        let &showbreak="\u2026   "
    else
        set listchars=tab:\|\ ,trail:.,extends:>,eol:$,nbsp:_,precedes:<,extends:>
        let &showbreak="+++ "
    endif
" }

" Formatting {
    set wrap                " wrap long lines

    " Indentation guides: display tabs, write spaces to file
    set autoindent      " indent at the same level of the previous line
    set shiftwidth=4    " use indents of 4 spaces
    set tabstop=4       " ASCII character 9 is displayed as 4 spaces
    set softtabstop=4   " let backspace delete indent
    set smarttab        " insert 'shiftwidth' blanks when <Tab> is pressed in front of a line
    set expandtab       " expand \t to spaces

    " Perform space <-> tab conversion on the fly to get indent guides as defined in listchars
    augroup IndentGuides
        autocmd!
        autocmd BufReadPost  * call IndentGuides(1)
        autocmd BufWritePre  * call IndentGuides(0)
        autocmd BufWritePost * call IndentGuides(1)
    augroup END

    set cindent             " C style indentation

    "set matchpairs+=<:>                " match, to be used with %
    set pastetoggle=<F2>            " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" }

" Printing {
    " TODO: unify font specification for guifont and printfont
    if has("win32") || has("win64")
        set printfont=Envy_Code_R:h10
    else
        set printfont=Envy\ Code\ R\ 8
    endif
" }

" Key (re)Mappings {

    "The default leader is '\', but many people prefer ',' as it's in a standard
    "location
    let mapleader = ','

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Easier moving in tabs and windows
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h
    map <C-K> <C-W>k

    """ Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " fold current alinea when Insert is pressed
    nmap <Insert> za
    imap <Insert> za

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " use PCRE's when searching
    nnoremap / /\v
    vnoremap / /\v

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null
" }

" Plugins {
     " FuzzyFinder {
         map <leader>f :FufFileWithCurrentBufferDir **/<C-M>
         map <leader>b :FufBuffer<C-M>
     " }

    " OmniComplete {
        " Automatically set up completion for all known types
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \ if &omnifunc == "" |
                    \ setlocal omnifunc=syntaxcomplete#Complete |
                \ endif
        endif

        " Settings and preferences
        let OmniCpp_GlobalScopeSearch = 1       " search the global scope
        let OmniCpp_NamespaceSearch = 1         " search namespaces in the current buffer
        let OmniCpp_DisplayMode = 0             " filter completions on accessibility from current scope
        let OmniCpp_LocalSearchDecl = 1         " use better search for local variable names
        let OmniCpp_ShowScopeInAbbr = 0         " show scope of match in the last column
        let OmniCpp_ShowPrototypeInAbbr = 1     " show function parameters
        let OmniCpp_ShowAccess = 1              " show access info ('+', '#', '-')
        let OmniCpp_MayCompleteDot = 1          " autocomplete after .
        let OmniCpp_MayCompleteArrow = 1        " autocomplete after ->
        let OmniCpp_MayCompleteScope = 1        " autocomplete after ::
        let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]     " always parse these namespaces

        " automatically open and close the popup menu / preview window
        autocmd CursorMovedI,InsertLeave * if pumvisible() == 0 | silent! pclose | endif

        " Popup menu colors
        hi Pmenu       guifg=#000000 guibg=#F8F8F8          ctermfg=black     ctermbg=Lightgray
        hi PmenuSbar   guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan  ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan  cterm=NONE

        " Completion menu properties
        set completeopt=            " reset default values
        set completeopt+=menu       " use a popup menu to show the possible completions
        set completeopt+=menuone    " also use popup menu when there is only 1 match, to show additional information
        set completeopt+=longest    " only insert the longest common text of the matches
        "set completeopt+=preview   " show extra information about the current completion in the preview window

        " Add libstdc++ tags file to list of tag files and search upwards from
        " current directory
        set tags+=~/.vim/tags/libstdcpp
        set tags+=~/.vim/tags/wxWidgets
        set tags+=./tags;

        " some convenient mappings
        map <F12> :silent !ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>:redraw!<CR>

        " this breaks arrow keys in Insert mode
        "inoremap <expr> <Esc>     pumvisible() ? "\<C-e>" : "\<Esc>"
        "inoremap <expr> <CR>      pumvisible() ? "\<C-y>" : "\<CR>"
        "inoremap <expr> <Down>    pumvisible() ? "\<C-n>" : "\<Down>"
        "inoremap <expr> <Up>      pumvisible() ? "\<C-p>" : "\<Up>"
        "inoremap <expr> <C-d>     pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        "inoremap <expr> <C-u>     pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " and make sure that it doesn't break supertab
        let g:SuperTabCrMapping = 0
        let g:SuperTabDefaultCompletionType = "context"
    " }

    " ShowMarks {
        let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]{}()\""
        " Show marks if buffer is not readonly
        let g:showmarks_enable = 1
        let g:showmarks_ignore_type = 'hmpqr'

        highlight ShowMarksHLl gui=bold guifg=LightBlue  guibg=Black cterm=bold ctermfg=LightBlue  ctermbg=black    " For marks a-z
        highlight ShowMarksHLu gui=bold guifg=DarkRed    guibg=Black cterm=bold ctermfg=DarkRed    ctermbg=Black    " For marks A-Z
        highlight ShowMarksHLo gui=bold guifg=DarkYellow guifg=Black cterm=bold ctermfg=DarkYellow ctermbg=Black    " For all other marks
        highlight ShowMarksHLm gui=bold guifg=DarkGreen  guibg=Black cterm=bold ctermfg=DarkGreen  ctermbg=Black    " For multiple marks on the same line.
    " }

    " ShowPairs {
        hi default ShowPairsHL  cterm=bold,reverse,italic gui=bold,reverse,italic
        hi default ShowPairsHLp cterm=bold,reverse,italic gui=bold,reverse,italic
    " }

    " Supertab {
        let g:SuperTabNoCompleteAfter = [ ',', '\s', ')', ']', '}', ';', '"', "'", ':', '=' ]
        let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    " }

    " Taglist {
        let Tlist_Auto_Highlight_Tag = 1
        let Tlist_Auto_Update = 1
        let Tlist_Display_Prototype = 1
        let Tlist_Exit_OnlyWindow = 1
        let Tlist_File_Fold_Auto_Close = 1
        let Tlist_Highlight_Tag_On_BufEnter = 1
        let Tlist_WinWidth = 0
        let Tlist_Process_File_Always = 1
        let Tlist_Sort_Type = "name"
        let Tlist_Use_Right_Window = 1
        let Tlist_Use_SingleClick = 1

        let g:ctags_statusline=1
        " Override how taglist does javascript
        let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method;p:property;v:global'
     " }

    " Misc {
    " }


    " Richard's plugins {
        " Debugging with VimDebugger {
            "map <F11> :DbgStepInto<CR>
            "map <F10> :DbgStepOver<CR>
            "map <S-F11> :DbgStepOut<CR>
            "map <F5> :DbgRun<CR>
            "map <F6> :DbgDetach<CR>
            "map <F8> :DbgToggleBreakpoint<CR>
            "map <S-F8> :DbgFlushBreakpoints<CR>
            "map <F9> :DbgRefreshWatch<CR>
            "map <S-F9> :DbgAddWatch<CR>
        " }

        " JSON {
            nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
         " }
    " }
" }

" File type specific commands {
    augroup FileTypeSpecific
        autocmd!

        " No decorations for manpages.
        " Also ensure vim is not recursively invoked (man-db does this)
        " when doing ctrl-[ on a man page reference
        autocmd FileType man
            \ setlocal nonumber |
            \ setlocal foldcolumn=0 |
            \ setlocal colorcolumn= |
            \ let $MANPAGER=""

        " Muttng
        autocmd BufNewFile,BufRead muttng-*-\w\+,muttng\w\{6\} setf mail
        autocmd BufNewFile,BufRead muttngrc* setf muttrc

        " Source code operations:
        " - Remove trailing whitespaces and ^M chars
        autocmd FileType c,cpp,java,php,js,python,twig,xml,yml
            \ autocmd BufWritePre <buffer>
                \ call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

        " Text files
        autocmd FileType tex,mail,text,asciidoc,html,sgml,otl,cvs,none
            \ if (!&readonly) | setlocal spell | endif
    augroup END
" }

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim/'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory',
              \ 'undo': 'undodir' }

  for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . dirname . "/"
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else  
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories()

function! IndentGuides(create)
    " Don't perform space<->tab for non-modifiable or readonly files
    " to prevent warnings about changing a readonly buffer.
    " Don't perform conversion on Makefiles either, \t really matters!
    if (!&modifiable || &readonly
            \ || (&filetype == "automake") || (&filetype == "make")
            \ || (&filetype == "diff") || (&filetype == "cpp")
            \ || (&filetype == "c")
            \ || (&filetype == "gitconfig") || (&filetype == "gitcommit")
            \ || (&filetype == "gitolite") || (&filetype == "sh")
            \ || (&filetype == "wiki"))
        return
    endif

    if (a:create)
        setlocal noexpandtab
        retab!
    else
        setlocal expandtab
        retab!
    endif
endfunction

function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Unicode text decorations
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 OverlineShort   call s:CombineSelection(<line1>, <line2>, '0304')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 UnderlineShort  call s:CombineSelection(<line1>, <line2>, '0331')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction
