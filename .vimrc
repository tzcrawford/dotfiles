"Need the following for this to apply in Windows I think
if has('win32') || has('win64')
    set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
    "set runtimepath=C:\Users\myuser\Vim\vim90,C:\Users\myuser\.vim,U:\.vim,U:\.vim\after
    set backspace=indent,eol,start
    set vb
    set t_vb=
    "gvim font
    set guifont=Cascadia_Code:h16
endif


" VIM RUN COMMANDS
" YOU CAN IMMEDIATELY APPLY ANY CHANGES TO THIS CONFIGURATION FILE BY RUNNING ':source ~/.vimrc' IN ANY VIM SESSION
" THIS VIMRC FILE SHOULD SERVE AS A TEMPLATE AND INTRODUCTION
" NOTE THAT DOUBLE QUOTE PRECEDES A COMMENT
" SINGLE QUOTES WILL BE USED TO REFER TO THINGS RATHER THAN DOUBLE QUOTES



"VIMRC AND MACROING
"Default settings will be saved in ~/.vimrc
"You can change default settings by editing this file
"You can also change vim's settings in the session of vim you are running. They will be reset to default next time you open vim
"You can set the option '_____' with 'set _____'
"You can map key presses with 'map <BUTTON> :_____' where '_____' is the command
"You can map multiple commands to a button by feeding multiple commands separated by spaces?

"See https://dougblack.io/words/a-good-vimrc.html for more recommendations



"ENABLE THE PATHOGEN PLUGIN MANAGER
"See https://github.com/tpope/vim-pathogen
execute pathogen#infect()
execute pathogen#helptags()



"MODES
""vim has 4 modes. STANDARD, INSERT, REPLACE, and VISUAL
"vim starts in standard mode, all commands work here. 
"at any point, press <ESC> to go back to standard mode
"
"'i'     to enter 'INSERT' mode. This allows you to insert text 
"'a'     to append after the cursor. Does the same as 'i'?
"'A'     to append the selected line, i.e. enter 'INSERT' mode at the end of the line
"'o'     to open the line below the cursor, i.e. enter 'INSERT' mode on a new line below the selected line
"'O'     to open the line above the cursor
"'R'     enters 'REPLACE' mode. This is essentially the same as insert mode but deletes next characters
"'r'     will replace an argument, but you need to pass one. E.g. 'rw' will replace a word
"
"'v'    starts visual mode for selecting the lines and you can perform operation on that like d to delete
"the most recently deleted or yanked line will occupy the vim register; paste the register with 'p'
"Make a visual block with '<Ctrl>+V'. This allows you to do the same process on multiple lines.



"MOVING AROUND
"   ** To move the cursor, press the h,j,k,l keys as indicated. **
"             ^
"             k                     The h key is at the left and moves left.
"       < h       l >               The l key is at the right and moves right.
"             j                     The j key looks like a down arrow.
"             v
"or just use the arrow keys
"
"'0'     to go to the beginning of the line
"'2w'    for two words forward; '3w' for three words forward etc
"'2g'    to go to line 2, '302g' to go to line 302, etc.
"'w'     moves to the next word
"'b'     backward a word
"'G'     to move you to the bottom of the file.
"'gg'    to move you to the start of the file.
"'gj'    go down a line on the screen(not an actual numbered line)

"These normal mode remaps make it so scrolling up/down scrolls by the lines on the screen rather than the actual file line numbers
noremap <Up> gk
noremap <Down> gj
noremap k gk
noremap j gj

"These remaps change F1 from a help menu to escape
nmap <F1> <Esc>
imap <F1> <Esc>



"MOTIONS AND ARGUMENTS
"'w'     for word
"'e'     for end of word
"'b'     for backward a word
"'s'     for sentence
"'p'     for paragraph
"'$'     for until end of line
"MODIFYING ARGUMENTS?
"'i'     inner
"'a'     around

"EXAMPLES
"'diw'   delete inner word
"'daw'   delete around word
"'db'    delete previous word
"'wa'    append to beginning of word
"'ce'    change to end of word



"EXITING, READING, AND WRITING
"':q!'           will force quit
"':w'            will save onto the current file
"':wq'           will save and quit
"':w file.txt'   to write to a file named file.txt
"':r file.txt'   will insert the content of file.txt into the current file after the cursor



"UNDO, REDO, AND REPEAT
"'u'            to undo the last the command and U to undo the whole line
"'<CTRL>+R'     to redo a command
"'.'            to repeat your last command



"DELETING AND REPLACING
"'x'            to delete the unwanted character
"'dd'           to delete the line and 2dd to delete to line .number can be changed for deleting the number of consecutive words
"'d$' or 'D'    to delete to the end of a line
"'r'            to replace the letter e.g press re to replace the letter with e
"'cw'           to change word etc.



"CUT COPY PASTE
"'p'            PASTE OPERATOR; pastes most recently yanked or deleted text
"'y'            YANK OPERATOR; copy text using v visual mode and p to paste it
"'d'            DELETE OPERATOR; is used to cut; 'p' puts the previously deleted text after the cursor
"
"Can combine with other arguments rather than use visual mode
"'dd'           to delete the line and store it in a Vim register
"'yd'           to copy line into register



"SEARCH
"'/_____<ENTER>'     to search forward for an expression '_____'
"'?_____<ENTER>'     to search backward for an expression
"follow these searches with 'n' for the next occurrence and 'N' for the previous occurrence
"'%)'                to find a matching ). Same with ] or }
"':s/old/new/g'      to substitute 'new' for 'old' where g is globally
"'<CTRL>+G'          will display location in the file and the file status

set ic               "will ignore case when searching
set incsearch        "search as characters are entered
set hlsearch         "highlight matches
set autoread         "automatically discard changes and reload file 
                     "combine this with vim-autoread extension since tui vim will not run autoread without some sort of event trigger.


"SHELL COMMANDS AND MORE ON WRITING FILES
"':!_____'           to run the shell command '_____' like :!dir, :!ls



"SPELLCHECKER
"turn on spellchecker with language US
map <F5> :setlocal spell! spelllang=en_us<Return>
"':set spell!' turns on spellchecker
"'spelllang=____' defines the language&region for the spellchecker dictionary
"Move to next misspelled word with ']s' or back with '[s'
"Or move to next misspelled word(ignoring region) with ']S'; back with '[S'
"'z='        will give suggestions to replace the word; supply number of the word you want to use
"'zg'        will add to dictionary
"'zug'       will remove from dictionary
"'zw'        will always make a word appear as misspelled

"searches /usr/share/dict/<> for a dictionary. Need words package on arch linux
"if dictionary is not set, it will use words from spellang
set dictionary+=/usr/share/dict/american-english
set dictionary+=$HOME/.vim/spell/en.utf-8.add
"custom words
set spellfile=$HOME/.vim/spell/en.utf-8.add



"AESTHETIC OPTIONS
"colorscheme slate   "define colorscheme
"try ':colorscheme <CTRL+D>' to see a list of colorschemes
set ruler               "location of cursor in bottom right of page
set number              "line numbers
syntax on               "changes the color for coding syntax
set showcmd             "shows the last command entered in the bottom right corner
"set relativenumber     "makes active line number the absolute file line number and non-active line numbers the line number away from the active one
"set cursorline         "draws line under the line being edited



"PATHOGEN FILETYPE PLUGIN OPTIONS
filetype on
filetype plugin on



"SHELL TAB COMPLETION IN VIM (WILDMENU)
"Make sure vim is not in compatible mode (:set nocp)
"Start typing a shell command ':!_____'
"Press <TAB>         to try to tab complete
"Press '<CTRL>+D'    to list commands that begin with what you've already typed
set wildmenu "lists tab completion recommendations on a special command in vim ':_____'
set wildmode=list,full "list all matches and complete each full match. See ':help wildmode'



"WHITESPACE OPTIONS
"filetype plugin indent on "allows vim to use indentation settings independent to filetype with config files
set autoindent "mimics the indentation of the previous line
"this appears to stop vim from changing the indent of the current line after you press return
set indentexpr=
"the following should allow vim to present long lines as wrapped but not enter return characters on your behalf
set wrap
set linebreak
set textwidth=0 

set expandtab "<TAB> just enters 4 spaces rather than a tab character. Important for python whitespace.
"set tabstop=4 "number of visual spaces per <TAB> character (in previous documents?)
set shiftwidth=4 "number of visual spaces per << or == or >> command
set softtabstop=4 "number of visual spaces per <TAB> entry or removal
inoremap <S-Tab> <C-V><Tab> "force a normal tab character
"autocmd FileType html setlocal shiftwidth=2 tabstop=2
"autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4



"SPLIT OPTIONS
"to see the same file,
"open a horizontal split with :split or :sp 
"open a vertical split with :vsplit or :vs
"open a specific file with :split ~/test.txt
"
"to open a split for help menu, :help or :h <search item>
"to make a split go away, :q or Ctrl+w,c on that split 
"
"to swap between splits, Ctrl+w,w or Ctrl+w,j/k/h/l
"to shrink split, Ctrl+w,- . Grow with Ctrl+w,+
"Ctrl+w _ to set max height
"Ctrl+w | to set max width
"Ctrl+w = to equalize width
"
"new splits will open below or to the right
set splitbelow
set splitright



"MACROING
""'q' will record a macro. Give it a name e.g. '@_', where _ is a letter, and enter the process you want the macro to do. Finally press q again to stop recording
"To call the macro, simply type '@_'
"Or you can precede '@_' with the number of times you want it to occur. E.g. 23@a will repeat the macro a 23 times.
"Additionally, '.' will repeat the process of whatever you did last.

"set lazyredraw      "redraws screen only when needed; speeds up macros



"AUTOCOMPILE 
"Press FX when editing a .tex file to save and compile a pdf. Useful to monitor changes to the file
"autocmd FileType tex map <FX> :w<RETURN>:!pdflatex %<RETURN><RETURN>
"same for R markdown
"autocmd Filetype rmd map <FX> :w<RETURN>:!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter><RETURN>



"LEADERS AND TAG SHORTUCTS 
"I have set a leader key to be used to let vim know that I want
"to do some sort of custom remapped command, i.e. those just below this
let mapleader =","



"NAVIGATING WITH GUIDES 
""<++> characters may appear when doing an HTML macro as below. <leader><leader> will
"act as a shortcut to jump to and overwrite these characters.
"
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l



"COPY/CUT/PASTE WITH SYSTEM CLIPBOARDS
"in visual mode copy/cut/paste to CLIPBOARD (freedesktop.org specification, CTRL+C/CTRL+V)
vnoremap <leader>y "+y
vnoremap <leader>x "+x
vnoremap <leader>p "+p
"in visual mode copy/cut/paste to PRIMARY (freedesktop.org specification, Highlight/Shift+Insert)
vnoremap <leader>Y "*y
vnoremap <leader>X "*x
vnoremap <leader>P "*p
"in normal mode copy/cut/paste to CLIPBOARD (freedesktop.org specification, CTRL+C/CTRL+V)
nnoremap <leader>y "+y
nnoremap <leader>x "+x
nnoremap <leader>p "+p
"in normal mode copy/cut/paste to PRIMARY (freedesktop.org specification, Highlight/Shift+Insert)
nnoremap <leader>Y "*y
nnoremap <leader>X "*x
nnoremap <leader>P "*p



"AUTOCOMPLETION
"uses AUTOCOMPLPOP extension for on-the-fly auto-completion
"set omnifunc=syntaxcomplete#Complete "Use all syntax completion options all the time
"We Instead use vim-lsp for syntax completion below with set omnifunc=lsp
"au FileType cs set omnifunc=syntaxcomplete#Complete

"autocomplete from the spell check dictionary
"set complete+=kspell  "this is not needed since we added the spell file to the dictionary

"Autocomplete will show completions when there is only one recommendation
"set completeopt=menuone
set completeopt=menuone,preview "This allows popups for OmniSharp documentation etc
"suppresses output on bottom of screen for selections
set shortmess+=c

"Ignore case for autocompletion recommendations (1 i.e. true is default)
let g:acp_ignorecaseOption = 1
"Length of keyword characters before the cursor needed to attempt keyword completion
let g:acp_behaviorKeywordLength = 1

"Ctrl+e will make autocomplete menu go away
"remap carriage return/enter so that it doesn't autocomplete,
inoremap <expr> <CR> pumvisible() ? '<C-e><CR>' : '<CR>'

"Fill with your selection using CTRL+l
"remap Ctrl+l to select first option in autocomplete if menu has spawned
"inoremap <expr> <C-l> pumvisible() ? '<CR>' : '<CR>' "This one does not run menu manually (below)

"Likewise, manually spawn *syntax* autocomplete menu with a CTRL+l in insertmode. 
"This is necessary for filling object attributes/methods in python etc. 
"Autocomplpop does not fill starting on period.
inoremap <expr> <C-l> pumvisible() ? '<CR>' : '<C-x><C-o>' "Use this instead of above

"Or Ctrl+u to switch from dictionary recommendation to *syntax* recommendations
inoremap <expr> <C-u> pumvisible() ? '<C-e><C-x><C-o>' : '<C-x><C-o>'

"Instead of filling like above, you cycle throught the list replacing what you type 
"w/ Ctrl+n or Ctrl+p or with Ctrl+j or Ctrl+k with these remaps
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

"How much space the autocomplete menu takes up
set pumheight=8 "how many recommendations to give default is all space (100?)


"LANGUAGE-SPECIFIC AUTOCOMPLETION POPUPS
function! s:on_lsp_buffer_enabled() abort
    "setlocal omnifunc=lsp#complete
    set omnifunc=lsp#complete
    "setlocal signcolumn=yes
    nmap <buffer> gi <plug>(lsp-definition) " Go to definition
    nmap <buffer> gd <plug>(lsp-declaration) " Go to declaration. Useful for languages such as C/C++ where there is a clear distinction between declaration and definition.
    nmap <buffer> gr <plug>(lsp-references) " Find all references
    nmap <buffer> gl <plug>(lsp-document-diagnostics) " Gets document diagnostics and opens in location-list (a window-local quickfix list)
    nmap <buffer> <f2> <plug>(lsp-rename) " What does this do? Renames the symbol???
    nmap <buffer> <f3> <plug>(lsp-hover) " Show a popup or a preview window containing details about the symbol hovering over
endfunction

let g:lsp_diagnostics_enabled=0 " Hide warnings
call lsp#disable_diagnostics_for_buffer()
let g:lsp_document_code_action_signs_enabled = 0 " Hide code action signs
"let g:lsp_signature_help_enabled = 0 " Disable support for signature help i.e. information about the parameters and their types for a function or method call as you are typing it
"let g:lsp_show_workspace_edits = 0 " Disable workspace edits i.e. operations that involve modifying the code in a more complex way than a single text edit.

let g:lsp_hover_ui = 'float' " Default UI behavior for LspHover

"let g:lsp_preview_float = 0 " Opens preview windows as normal windows (split)
let g:lsp_preview_float = 1 " Opens preview windows as floating
let g:lsp_preview_autoclose = 1 " Opens preview windows as floating

"let g:lsp_peek_alignment = 'bottom' " How to align the location of interest for :LspPeekDefinition as an example ... not working?

let g:lsp_semantic_enabled = 1 " Semantic highlighting



"SYNTASTIC SETTINGS
"checks syntax opens recommendations in new split
"options for output window?
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"run the check (have to save the buffer first)
map <F6> :SyntasticCheck<Return>
"clear the error list
map <F7> :SyntasticReset<Return>

"Syntastic default mode, can be set for each filetype in the arrays
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

"checks syntax on file open
let g:syntastic_check_on_open = 0
"checks syntax on :wq :x or :ZZ if 1
let g:syntastic_check_on_wq = 0

"Always put detected errors in the list (can conflict w other plugins)
let g:syntastic_always_populate_loc_list = 1

"0 - error window not opened/closed automatically.
"1 - error window automatically opened when errors detected, closed when none are detected. (default)
"2 - error window automatically closed when no errors are detected, but not opened automatically.
"3 - error window automatically opened when errors are detected, but not closed automatically.
let g:syntastic_auto_loc_list = 1
"how tall the syntastic list is
let g:syntastic_loc_list_height = 7

"How syntastic split title bar looks
let g:syntastic_stl_format = "[Syntax! line: %F | %E{Total Errors: %e} | %W{Total Warnings: %w}]"

"go between next and previous matches
nnoremap <leader><C-j> :lnext<CR>
nnoremap <leader><C-k> :lprevious<CR>

"ALE Linting
" Here we only want to enable ALE linting for a particular set of filetypes
let g:ale_enabled = 1
let fts = ['cs','sh','python','javascript']
if index(fts, &filetype) == -1
    " Could not find current file type in list fts above
    let g:ale_enabled = 0
endif
nnoremap <F9> :ALEToggle<CR> " Have ALE turn on/off on F9 keypress
let g:ale_linters = {'cs': ['OmniSharp'], 'javascript': ['eslint']}
"disable text at the end of lines
let g:ale_virtualtext_cursor = 'disabled'
"let g:ale_sign_error = '>>'
let g:ale_sign_error = '>'
"let g:ale_sign_warning = '--'
let g:ale_sign_warning = '-'

"Remove highlighting in sign gutter
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign
"
"Remove highlighting for SpellBad, SpellCap, error, todo
let g:ale_set_highlights = 0
"Hightlight errors with one color
"highlight ALEWarning ctermbg=DarkMagenta

"OMNISHARP PLUGIN SETTINGS
"Bug installing?
"try :OmniSharpInstall v1.38.1
"https://github.com/OmniSharp/omnisharp-vim/issues/766

"filetype indent plugin on "This was said to be required? I think Omnisharp said it was needed if not using a plugin manager
filetype indent plugin off "I need to turn it off to get indentexpr declaration to apply

"syntax enable "already done above...
"let g:OmniSharp_start_server = 0 "disable plugin
let g:OmniSharp_server_use_mono = 1 "what type of server to use mono or .net

"let g:OmniSharp_popup = 0 " Disable popups
"autocmd FileType cs AutoComplPopDisable "disable autocomplpop for csharp
let g:OmniSharp_highlighting = 3
let g:OmniSharp_popup_position = 'atcursor'
let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [1],
\ 'border': [1],
\ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
\ 'borderhighlight': ['Special']
\}
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>'],
\ 'lineDown': ['<C-j>'],
\ 'lineUp': ['<C-k>']
\}
"Vim in the terminal does not have a default <Esc> close mapping, because <Esc> mappings interfere with escape codes in terminal Vim, meaning that key-codes such as arrow keys and <PageUp>/<PageDown> do not work as expected. Therefore, terminal Vim only has the gq mapping. Gvim and neovim handle escape codes differently, so are not affected, and have both gq and <Esc> as default close mappings.
let g:OmniSharp_popup_mappings.close = '<Esc>'



"For linting with syntastic if no ALE
"let g:syntastic_cs_checkers = ['code_checker']

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  "autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_preview_definition) " custom
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> gf <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END




"R PLUGIN SETTINGS
"disable autocomplpop for r files
"autocmd FileType r AutoComplPopDisable 
"autocmd FileType rmd AutoComplPopDisable 
"want to use nvim-r+ncm2+ncm-R, install with script in github
"enable ncm2 for buffers
"autocmd FileType r BufEnter * call ncm2#enable_for_buffer()
"autocmd FileType rmd BufEnter * call ncm2#enable_for_buffer()
"autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=noinsert,menuone,noselect
"
"VIM-MATHEMATICA PLUGIN SETTINGS
"for editing mathematica plain-text scripts
let g:mma_candy = 1 
set encoding=utf-8
set fileencoding=utf-8



"LATEX MACROS
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
autocmd FileType tex nmap <leader>fr i\begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
autocmd FileType tex nmap <leader>fi i\begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
autocmd FileType tex nmap <leader>exe i\begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
autocmd FileType tex nmap <leader>em i\emph{}<++><Esc>T{i
autocmd FileType tex nmap <leader>bf i\textbf{}<++><Esc>T{i
autocmd FileType tex vnoremap <leader> <iESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
autocmd FileType tex nmap <leader>it i\textit{}<++><Esc>T{i
autocmd FileType tex nmap <leader>ct i\textcite{}<++><Esc>T{i
autocmd FileType tex nmap <leader>cp i\parencite{}<++><Esc>T{i
autocmd FileType tex nmap <leader>glos i{\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
autocmd FileType tex nmap <leader>x i\begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
autocmd FileType tex nmap <leader>ol i\begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex nmap <leader>ul i\begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex nmap <leader>li i<Enter>\item<Space>
autocmd FileType tex nmap <leader>ref i\ref{}<Space><++><Esc>T{i
autocmd FileType tex nmap <leader>tab i\begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex nmap <leader>ot i\begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
autocmd FileType tex nmap <leader>can i\cand{}<Tab><++><Esc>T{i
autocmd FileType tex nmap <leader>con i\const{}<Tab><++><Esc>T{i
autocmd FileType tex nmap <leader>v i\vio{}<Tab><++><Esc>T{i
autocmd FileType tex nmap <leader>a i\href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex nmap <leader>sc i\textsc{}<Space><++><Esc>T{i
autocmd FileType tex nmap <leader>chap i\chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex nmap <leader>sec i\section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex nmap <leader>ssec i\subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex nmap <leader>sssec i\subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex nmap <leader>st i<Esc>F{i*<Esc>f}i
autocmd FileType tex nmap <leader>beg i\begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
autocmd FileType tex nmap <leader>up i<Esc>/usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex nnoremap <leader>up i/usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex nmap <leader>tt i\texttt{}<Space><++><Esc>T{i
autocmd FileType tex nmap <leader>bt i{\blindtext}
autocmd FileType tex nmap <leader>nu i$\varnothing$
autocmd FileType tex nmap <leader>col i\begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
autocmd FileType tex nmap <leader>rn i(\ref{})<++><Esc>F}i
".bib
autocmd FileType bib nmap <leader>a i@article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
autocmd FileType bib nmap <leader>b i@book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
autocmd FileType bib nmap <leader>c i@incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i

"HTML MACROS
autocmd FileType html nmap &<space> &amp;<space>
autocmd FileType html nmap á &aacute;
autocmd FileType html nmap é &eacute;
autocmd FileType html nmap í &iacute;
autocmd FileType html nmap ó &oacute;
autocmd FileType html nmap ú &uacute;
autocmd FileType html nmap ä &auml;
autocmd FileType html nmap ë &euml;
autocmd FileType html nmap ï &iuml;
autocmd FileType html nmap ö &ouml;
autocmd FileType html nmap ü &uuml;
autocmd FileType html nmap ã &atilde;
autocmd FileType html nmap ẽ &etilde;
autocmd FileType html nmap ĩ &itilde;
autocmd FileType html nmap õ &otilde;
autocmd FileType html nmap ũ &utilde;
autocmd FileType html nmap ñ &ntilde;
autocmd FileType html nmap à &agrave;
autocmd FileType html nmap è &egrave;
autocmd FileType html nmap ì &igrave;
autocmd FileType html nmap ò &ograve;
autocmd FileType html nmap ù &ugrave;

" VB.NET macros
autocmd BufReadPost *.aspx nmap <leader>b a<b></b><Space><++><Esc>FbT>i
autocmd BufReadPost *.aspx nmap <leader>it a<em></em><Space><++><Esc>FeT>i
autocmd BufReadPost *.aspx nmap <leader>h1 a<h1></h1><Enter><Enter><++><Esc>2kf<i
autocmd BufReadPost *.aspx nmap <leader>h2 a<h2></h2><Enter><Enter><++><Esc>2kf<i
autocmd BufReadPost *.aspx nmap <leader>h3 a<h3></h3><Enter><Enter><++><Esc>2kf<i
autocmd BufReadPost *.aspx nmap <leader>p a<p></p><Enter><Enter><++><Esc>02kf>a
autocmd BufReadPost *.aspx nmap <leader>a a<a<Space>href=""><++></a><Space><++><Esc>14hi
autocmd BufReadPost *.aspx nmap <leader>im a<img src="" alt="<++>"><Space><++><Esc>Fcf"a
autocmd BufReadPost *.aspx nmap <leader>e a<a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
autocmd BufReadPost *.aspx nmap <leader>ul a<ul><Enter></ul><++><Esc>O<Tab>
autocmd BufReadPost *.aspx nmap <leader>ol a<ol><Enter></ol><++><Esc>O<Tab>
autocmd BufReadPost *.aspx nmap <leader>li a<li></li><++><Esc>8hi
autocmd BufReadPost *.aspx nmap <leader>table a<table><Enter></table><Space><++><Esc>O<Tab>
autocmd BufReadPost *.aspx nmap <leader>tr a<tr><Enter></tr><Space><++><Esc>O<Tab>
autocmd BufReadPost *.aspx nmap <leader>td a<td></td><Space><++><Esc>FdT>i
autocmd BufReadPost *.aspx nmap <leader>code a<code></code><Esc>F>a


autocmd BufReadPost *.aspx nmap <leader>btn a<asp:Button ID="btn<++>" runat="server" Text="<++>" /><++><Esc>0
autocmd BufReadPost *.aspx nmap <leader>lbl a<asp:Label ID="lbl<++>" runat="server" Text="<++>" /><++><Esc>0
autocmd BufReadPost *.aspx nmap <leader>tb a<asp:TextBox ID="tb<++>" runat="server" Text="<++> Visible="<++>" Enabled="<++>" Rows="<++>" Width="<++>" MaxHeight="<++>" /><++><Esc>0
autocmd BufReadPost *.aspx nmap <leader>cb a<asp:CheckBox ID="cb<++>" runat="server" DataSourceID="<++>" DataValueField="<++>" AppendDataBoundItems="<++>" Checked="<++>" Enabled="<++>" Visible="<++>" /><++><Esc>0
autocmd BufReadPost *.aspx nmap <leader>ddl a<asp:DropDownList ID="ddl<++>" runat="server" AutoPostBack="<++>" Visible="<++>" Enabled="<++>" OnSelectedIndexChanged="<++>" ><++></asp:DropDownList><Esc>0
autocmd BufReadPost *.aspx nmap <leader>pnl a<asp:Panel ID="pn<++>" runat="server" Visible="True" BackColor="#ffffff" ><Return><Tab><++><Return><Backspace></asp:Panel><Esc>--0
autocmd BufReadPost *.aspx nmap <leader>sds a<asp:SqlDataSource ID="sds<++>" runat="server" ConnectionString="<%$ ConnectionStrings:<++>ConnectionString %>"<Return><Tab>SelectCommand="<Return><Tab><++><Return><BackSpace>" UpdateCommand="<Return><Tab><++><Return><Backspace>" DeleteCommand="<Return><Tab><++><Return><BackSpace>" InsertCommand="<Return><Tab><++><Return><BackSpace>"><Return><Tab><SelectParameters><Return><Tab><asp:ControlParameter ControlID="<++>" Name="<++>" PropertyName="<++>" /><Return><BackSpace></SelectParameters><Return><UpdateParameters><Return><Tab><asp:ControlParameter ControlID="<++>" Name="<++>" PropertyName="<++>" /><Return><BackSpace></UpdateParameters><Return><DeleteParameters><Return><Tab><asp:ControlParameter ControlID="<++>" Name="<++>" PropertyName="<++>" /><Return><BackSpace></DeleteParameters><Return><InsertParameters><Return><Tab><asp:ControlParameter ControlID="<++>" Name="<++>" PropertyName="<++>" /><Return><BackSpace></InsertParameters><Return><BackSpace><BackSpace></asp:SqlDataSource><Esc>----------------------0
autocmd BufReadPost *.aspx nmap <leader>gv a<asp:GridView ID="gv<++>" runat="server"<Return><Tab>DataSourceID="sds<++>" DataKeyNames="<++>" AutoGenerateColumns="<++>" AutoPostBack="<++>"<Return>AllowPaging="True" AllowSorting="True" PageSize="<++>"<Return>CellPadding="<++>" CellSpacing="<++>" HorizontalAlign="<++>"<Return>BackColor="<++>" BorderColor="<++>" BorderStyle="Ridge" BorderWidth="<++>" Gridlines="None"<Return><BackSpace>><Return><Tab><FooterStyle BackColor="<++>" ForeColor="<++>" /><Return><HeaderStyle BackColor="<++>" ForeColor="<++>" HorizontalAlign="<++>" Font-Bold="<++>" /><Return><PagerStyle BackColor="<++>" ForeColor="<++>" HorizontalAlign="Left" /><Return><RowStyle BackColor="<++>" ForeColor="<++>" HorizontalAlign="<++>" /><Return><AlternatingRowStyle BackColor="<++>" /><Return><SelectedRowStyle BackColor="<++>" ForeColor="<++>" HorizontalAlign="<++>" /><Return><SortedAscendingCellStyle BackColor="<++>" /><Return><SortedAscendingHeaderStyle BackColor="<++>" /><Return><SortedDescendingCellStyle BackColor="<++>" /><Return><SortedDescendingHeaderStyle BackColor="<++>" /><Return><EmptyDataTemplate><++></EmptyDataTemplate><Return><Columns><Return><Tab><++><Return><BackSpace></Columns><Return><Backspace></asp:GridView><Esc>---------------------0<leader><leader>
autocmd BufReadPost *.aspx nmap <leader>bf a<asp:BoundField DataField="<++>" SortExpression="<++>" HeaderText="<++>" /><++><Esc>0
autocmd BufReadPost *.aspx nmap <leader>cf a<asp:CommandField ShowSelectButton="<++>" ShowEditButton="<++>" ShowDeleteButton="<++>" /><++><Esc>0<leader><leader>
autocmd BufReadPost *.aspx nmap <leader>Li a<asp:ListItem Text="<++>" Value="<++>" /><++><Esc>0


"IDK this isn't loading above immediately on Windows, but we can run it when the window has already spawned and it works.
set omnifunc=lsp#complete

