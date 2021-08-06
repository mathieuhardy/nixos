" ==============================================================================
"
" Script name: init.vim
" Description: Configuration for neovim.
" Dependencies:
" GitHub: https://www.github.com/mathieuhardy/nixos
" License: https://www.github.com/mathieuhardy/nixos/LICENSE
" Contributors: Mathieu Hardy
"
" Run :PlugInstall at first run to install plugins
"
" ==============================================================================

" ------------------------------------------------------------------------------
" Vim-plug
" ------------------------------------------------------------------------------

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ------------------------------------------------------------------------------
" Variables
" ------------------------------------------------------------------------------

let g:max_width = 80

let s:vim_dir = expand('$HOME') . '/.vim'
let s:templates_dir = s:vim_dir . '/templates'
let s:backup_dir = s:vim_dir . '/backup'
let s:undo_dir = s:vim_dir . '/undo'
let g:local_plugins_dir = expand('$HOME') . '/.config/nvim/local-plugged'

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

call plug#begin()

" Scrollbar
"Plug 'dstein64/nvim-scrollview'

" CSS colors
Plug 'ap/vim-css-color'

" Auto complete
"   https://github.com/ncm2/ncm2/wiki for a list of plugins per language.
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-bufword'     " Words from current buffer
Plug 'fgrsnau/ncm2-otherbuf' " Words from other buffers

Plug 'ncm2/ncm2-cssomni' " CSS
Plug 'ncm2/ncm2-jedi'    " Python (needs pip3 install jedi)
Plug 'ncm2/ncm2-pyclang' " C++
Plug 'ncm2/ncm2-tern'    " Javascript
Plug 'ncm2/ncm2-vim'     " Vimscript

" Auto close tags
Plug 'tmsvg/pear-tree'

" Open file a specified position
Plug 'vim-scripts/file-line'

" Fuzzy file search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Indent guides
Plug 'ntpeters/vim-indent-guides'

" Status bar
Plug 'itchyny/lightline.vim'

" Manpages
Plug 'vim-utils/vim-man'

" Commenter
Plug 'scrooloose/nerdcommenter'

" File tree
Plug 'scrooloose/nerdtree'

" Value toggler
Plug 'qwertologe/nextval.vim'

" Syntax highlighter
Plug 'sheerun/vim-polyglot'

" Alignement
Plug 'godlygeek/tabular'

" Symbols viewer
Plug 'preservim/tagbar'

" Navigate through buffers
Plug 'christoomey/vim-tmux-navigator'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Git
Plug 'tpope/vim-fugitive'

" MD5
Plug 'vim-scripts/md5.vim'

" Distractionn free mode
Plug 'junegunn/goyo.vim'

" Limited view
Plug 'junegunn/limelight.vim'

" Quick menu
Plug 'skywind3000/quickmenu.vim'

" Start menu
Plug 'mhinz/vim-startify'

" Digraphs
Plug 'vim-scripts/unicycle'

" Markdown viewer
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Underline word under cursor
Plug 'itchyny/vim-cursorword'

" Local plugins
Plug g:local_plugins_dir . '/buffers'
Plug g:local_plugins_dir . '/cscope'
Plug g:local_plugins_dir . '/executable'
Plug g:local_plugins_dir . '/folding'
Plug g:local_plugins_dir . '/invisiblechars'
Plug g:local_plugins_dir . '/mapping'
Plug g:local_plugins_dir . '/sessions'
Plug g:local_plugins_dir . '/strip'
Plug g:local_plugins_dir . '/theme'
Plug g:local_plugins_dir . '/wrapping'

call plug#end()

" ------------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------------

function! s:get_uid()
    if !exists('s:uid')
        let s:uid = 0
    else
        let s:uid += 1
    endif

    return s:uid
endfunction

" ------------------------------------------------------------------------------
" Setup
" ------------------------------------------------------------------------------

" Create output directories
if !isdirectory(s:vim_dir)
    call mkdir(s:vim_dir, '', 0770)
endif

if !isdirectory(s:backup_dir)
    call mkdir(s:backup_dir, '', 0770)
endif

if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, '', 0770)
endif

" ------------------------------------------------------------------------------
" Plugin: auto-pairs
" ------------------------------------------------------------------------------

" HTML
"   - add auto completes: <!-- -->
"   - remove auto completes: {
autocmd FileType html let b:AutoPairs = AutoPairsDefine(
    \ {'<!--' : '-->'},
    \ ['{'] )

" ------------------------------------------------------------------------------
" Plugin: cscope
" ------------------------------------------------------------------------------

let g:cscope_dir = expand('$HOME') . '/.cscope'

" ------------------------------------------------------------------------------
" Plugin: fugitive
" ------------------------------------------------------------------------------

" Toggle display of git blame buffer
function! s:ToggleBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        :Git blame
    endif
endfunction

" ------------------------------------------------------------------------------
" Plugin: fzf
" ------------------------------------------------------------------------------

" Run Fzf with DevIcons
function! s:FzfDevicons(qargs)
    let l:bat_cmd = 'bat --style=numbers,changes --color always {2..-1}'
    let l:head_cmd = 'head -' . &lines
    let l:preview_cmd = '--preview "' . l:bat_cmd . ' | ' . l:head_cmd . '"'
    let l:opts = l:preview_cmd
        \ . ' --expect=ctrl-t,ctrl-v,ctrl-x'
        \ . ' --multi'
        \ . ' --bind=ctrl-a:select-all,ctrl-z:deselect-all'

    function! s:files(dir)
        let l:cmd = 'ag -l -g ""'

        if a:dir != ''
            let l:cmd .= ' ' . shellescape(a:dir)
        endif

        let l:files = split(system(l:cmd), '\n')

        return s:prepend_icon(l:files)
    endfunction

   function! s:prepend_icon(candidates)
        let l:result = []

        for l:candidate in a:candidates
            let l:fname = fnamemodify(l:candidate, ':p:t')
            let l:is_directory = isdirectory(l:fname)
            let l:icon = WebDevIconsGetFileTypeSymbol(l:fname, l:is_directory)

            call add(l:result, printf('%s %s', l:icon, l:candidate))
        endfor

        return l:result
   endfunction

   function! s:edit_file(lines)
        if len(a:lines) < 2 | return | endif

        let l:cmd = get({
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vertical split',
            \ 'ctrl-t': 'tabe'
            \ },
            \ a:lines[0], 'e')

        for l:item in a:lines[1:]
            let l:pos = stridx(l:item, ' ')
            let l:file_path = l:item[pos+1:-1]

            execute 'silent '. l:cmd . ' ' . l:file_path
        endfor
    endfunction

    call fzf#run(
        \ fzf#wrap(
        \ 'files-with-icons', {
            \ 'source': <SID>files(a:qargs),
            \ 'sink*': function('s:edit_file'),
            \ 'options': '-m ' . l:opts,
            \ 'down': '40%' },
        \ 0))
endfunction

" Path to fzf
let &rtp .= ',' . expand('$HOME') . '/.fzf'

let g:fzf_colors = {
    \   'fg':      ['fg', 'Normal'],
    \   'bg':      ['bg', 'Normal'],
    \   'hl':      ['fg', 'ModeMsg'],
    \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \   'hl+':     ['fg', 'ModeMsg'],
    \   'info':    ['fg', 'PreProc'],
    \   'border':  ['fg', 'Ignore'],
    \   'prompt':  ['fg', 'MoreMsg'],
    \   'pointer': ['fg', 'Comment'],
    \   'marker':  ['fg', 'Keyword'],
    \   'spinner': ['fg', 'Label'],
    \   'header':  ['fg', 'Comment']
    \ }

" ------------------------------------------------------------------------------
" Plugin: goyo
" ------------------------------------------------------------------------------

function! s:goyo_leave()
    :call theme#apply()
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

" ------------------------------------------------------------------------------
" Plugin: lightline
" ------------------------------------------------------------------------------

let g:lightline = {
    \ 'colorscheme': 'Tomorrow',
    \ 'active': {
    \   'left':  [
    \              ['mode', 'paste'],
    \              ['gitbranch', 'readonly', 'filename', 'modified']
    \            ],
    \
    \   'right': [
    \              ['lineinfo'],
    \              ['percent'],
    \              ['filetype', 'fileformat', 'fileencoding']
    \            ],
    \ },
    \ }

" ------------------------------------------------------------------------------
" Plugin: mapping
" ------------------------------------------------------------------------------

let g:mapping_uid = s:get_uid()

" ------------------------------------------------------------------------------
" Plugin: ncm2
" ------------------------------------------------------------------------------

" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Remove annoying message on status bar
set shortmess+=c

" Use tab key to move around results
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Run popup on-demand
let g:ncm2#auto_popup=0
let g:ncm2#manual_complete_length = [[5,0]]

" ------------------------------------------------------------------------------
" Plugin: nerdtree
" ------------------------------------------------------------------------------

function! NERDTreeDoubleClickCbk(node)
   call a:node.activate({'stay': 0, 'where': 'p', 'keepopen': 1})
endfunction

let NERDTreeIgnore          = ['CVS\C']
let NERDTreeMouseMode       = 2 " open files by double clicking
let NERDTreeWinSize         = 64
let NERDTreeMapActivateNode = '<right>'

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "✚",
    \ "Untracked" : "?",
    \ "Renamed"   : "»",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✘",
    \ "Dirty"     : "!",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : "✹",
    \ "Unknown"   : "?"
    \ }

hi NERDTreeGitStatusModified    guifg=#FD971F gui=bold
hi NERDTreeGitStatusStaged      guifg=#66D9EF gui=bold
hi NERDTreeGitStatusRenamed     guifg=#A6E22E gui=bold
hi NERDTreeGitStatusUnmerged    guifg=fg      gui=bold
hi NERDTreeGitStatusUntracked   guifg=fg      gui=bold
hi NERDTreeGitStatusDirDirty    guifg=#F92672 gui=bold
hi NERDTreeGitStatusDirClean    guifg=#A6E22E gui=bold
hi NERDTreeGitStatusIgnored     guifg=fg      gui=bold

" ------------------------------------------------------------------------------
" Plugin: polyglot
" ------------------------------------------------------------------------------

let g:cpp_no_function_highlight = 1

" ------------------------------------------------------------------------------
" Plugin: sessions
" ------------------------------------------------------------------------------

let g:sessions_dir = s:vim_dir . '/sessions'

" ------------------------------------------------------------------------------
" Plugin: startify
" ------------------------------------------------------------------------------

function! SessionCallback(name)
    execute 'Session ' . a:name

    if exists('*NERDTreeCWD')
        NERDTreeCWD
    endif
endfunction

function! s:get_sessions()
    let l:list = []

    for l:dir in split(globpath(g:sessions_dir, '*'), '\n')
        let l:name = substitute(l:dir, g:sessions_dir . '/', '', '')
        let l:name = substitute(l:name, '.vim', '', '')
        let l:cmd = ":call SessionCallback('" . l:name . "')"
        call add(l:list, {'line': l:name, 'cmd': l:cmd})
    endfor

    return l:list
endfunction

let g:startify_lists = [
    \ { 'type': function('s:get_sessions'), 'header': ['   Sessions'] },
    \ ]

let g:startify_custom_header = [
    \ '   ███╗   ██╗██╗   ██╗██╗███╗   ███╗',
    \ '   ████╗  ██║██║   ██║██║████╗ ████║',
    \ '   ██╔██╗ ██║██║   ██║██║██╔████╔██║',
    \ '   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    \ '   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
    \ '   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝'
    \ ]

" ------------------------------------------------------------------------------
" Plugin: tabular
" ------------------------------------------------------------------------------

nmap <silent> <Leader>t= :Tab /=<CR>
vmap <silent> <Leader>t= :Tab /=<CR>

nmap <silent> <Leader>t: :Tab /:<CR>
vmap <silent> <Leader>t: :Tab /:<CR>

nmap <silent> <Leader>t\| :Tab /\|<CR>
vmap <silent> <Leader>t\| :Tab /\|<CR>

" ------------------------------------------------------------------------------
" Plugin: tagbar
" ------------------------------------------------------------------------------

let g:tagbar_left        = 1  " opens on left
let g:tagbar_singleclick = 1  " singleclick for jumping
let g:tagbar_width       = 50 " width of window
let g:tagbar_autofocus   = 1  " move cursor to tagbar
let g:tagbar_sort        = 0  " no sort by default
let g:tagbar_silent      = 1  " be silent

hi default link TagbarSignature       Folded
hi default link TagbarAccessPublic    Identifier
hi default link TagbarAccessProtected PreProc
hi default link TagbarAccessPrivate   Statement

" Tmux Navigator
let g:tmux_navigator_no_mappings = 1 " No default mapping

" ------------------------------------------------------------------------------
" Plugin: markdown-preview
" ------------------------------------------------------------------------------

let g:mkdp_refresh_slow = 0
"TODO: create custom CSS style for markdown preview
"let g:mkdp_markdown_css = '~/markdown.css'
"let g:mkdp_highlight_css = ''

" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------

set nocompatible  " no vi-compatible mode
set noexrc        " don't use local version of .(g)vimrc, .exrc

if has("cmdline_hist")
    set history=1000 " keep 1000 lines of command line
endif

" ------------------------------------------------------------------------------
" Templates
" ------------------------------------------------------------------------------

if has('autocmd')
    augroup templates
        autocmd!
        autocmd BufNewFile *.html,*.htm  call Template('html')
        autocmd BufNewFile *.py          call Template('py')
        autocmd BufNewFile *.sh          call Template('sh')
        autocmd BufNewFile *.c,*.cpp     call Template('c')
        autocmd BufNewFile *.h,*.hpp     call Template('h')
    augroup END

    function! Template(type)
        if has('unix')
            let l:file     = expand('%:t')
            let l:author   = expand('$USER')
            let l:date     = strftime('%d-%m-%Y')
            let l:skeleton = s:templates_dir . '/skeleton.' . a:type

            " Load template
            execute 'silent! 0r ' . l:skeleton

            " Replace patterns
            execute 'silent! %s/%FILE%/'   . l:file   . '/ge'
            execute 'silent! %s/%AUTHOR%/' . l:author . '/ge'
            execute 'silent! %s/%DATE%/'   . l:date   . '/ge'

            " Place cursor at end
            execute 'normal! G'
        endif
    endfunction
endif

" ------------------------------------------------------------------------------
" Filetypes
" ------------------------------------------------------------------------------

filetype on        " enable file type detection
filetype plugin on " load filetype plugins settings
filetype indent on " load filetype indent settings

" ------------------------------------------------------------------------------
" User interface
" ------------------------------------------------------------------------------

" Use mouse everywhere
if has('mouse')
    set mouse=a
endif

" Cursor shape
let &t_SI = '\<Esc>[6 q'
let &t_EI = '\<Esc>[2 q'

" Sizes
set cmdheight=1   " height of the command bar
set numberwidth=1 " minimal width of number margin
set linespace=0   " spaces between lines

if has('gui_running')
    set lines=50    " default row count of window
    set columns=150 " default column count of window
endif

" Error notifications
set novisualbell " don't blink windows on error
set noerrorbells " don't make noise

" Offsets from current position
set scrolloff=0     " offset below and above the current line
set sidescrolloff=0 " number of columns between active column and cursor

" Various
set nolazyredraw               " redraw window during scripts execution
set noinsertmode               " don't start in insert mode
set hidden                     " a buffer becomes hidden when it is abandoned
set report=0                   " always display messages like '1 line yanked'
set confirm                    " display graphical confirmation dialogs
set number                     " turn on line numbers
set backspace=indent,eol,start " make backspace more flexible
set nostartofline              " leave my cursor where it was
set ruler                      " always show current position in status bar
set showtabline=1              " show tab widget if there's more than 1 tab
set showcmd                    " show the command being typed
set whichwrap+=<,>,h,l         " go to next/previous line when reaching
                               " end/begin of line with cursor
set ttyfast                    " fast scrolling
set nopaste                    " allow indentation during pastes
set noshowmode                 " because we use lightline plugin
set laststatus=2               " always show the status line

" Tab bar
set guitablabel=%t " Only filename in tab bar

" Regex
set magic " allow to search with regex like '.*'

" Matching
set showmatch       " show matching brackets
set matchpairs+=<:> " add other sets of characters to match

" Highlightning
if has('syntax')
    set nocursorline          " no highlight of current row"
    set nocursorcolumn        " no highlight of current column"
    syntax on                 " syntax highlighting on
    "syntax sync minlines=200 " 'fromstart' = slower syntax highlightning but
                              " best results
    syntax sync fromstart
endif

" GUI
if has('gui_running') || $COLORTERM == 'truecolor'
    set t_Co=256                      " use 256 colors in terminals
    set guifont=DejaVu\ Sans\ Mono\ 9 " font
    set mousehide                     " hide the mouse cursor when typing
endif

" DEPRECATED

" Autocomplete wild menu
"set wildmode=longest,full " turn on wild mode huge list
"set suffixes=.bak,.log,~  " give lower precedence for these extensions

"if has('wildmenu')
   "set wildmenu " enable graphical menu when autocomplete
"endif

"if has("wildignore")
   "set wildignore=*.gif,*.jpg,*.png                " ignore images
   "set wildignore+=*.pdf                           " ignore documents
   "set wildignore+=*.a,*.o,*.dll,*.obj,*.exe,*.pyc " ignore build objects
   "set wildignore+=*.bz,*.gz,*.tar,*.tgz,*.zip     " ignore archives
"endif

" Autocomplete insert mode
"set complete=.,w,t " . = current buffer
                   " w = buffers from other windows
                   " b = buffers from buffer list
                   " u = buffers unloaded from buffer list
                   " t = tag completetion
                   " i = current and included files

" ------------------------------------------------------------------------------
" Files, backups and undo
" ------------------------------------------------------------------------------

" File format
set fileformats=unix,dos,mac " support all three, in this order

if &modifiable
    set fileformat=unix " Unix format by default
endif

" File encoding as UTF-8
set encoding=utf-8

if &modifiable
    set fileencoding=utf-8
endif

" Automatic tasks
set autoread       " set to auto read when a file is changed from the outside
set noautowrite    " no automatic writing
set noautowriteall " no automatic writing
set noswapfile     " turn off swap files

" Backups
set backup                  " enable backup
set writebackup             " backup when writing
set backupext=.backup       " extension of backup files
let &backupdir=s:backup_dir " directory of backup files

" Undo
set undolevels=1000 " undo levels

" Persistent undo
if has('persistent_undo')
    let &undodir=s:undo_dir " set undo directory
    set undofile            " enable undo files
endif

" ------------------------------------------------------------------------------
" Text, tabs, and indent related
" ------------------------------------------------------------------------------

" Indentation
if has('smartindent')
    set nosmartindent " don't use stupid 'smart indentation'
endif

:set cino+=(0 " align multiline parameters of a function
:set cino+==0 " align 'break' under the 'case' statement

" Indentation size
set tabstop=4     " tabulation size in display (in number of spaces)
set softtabstop=3 " mixed tabulation size
set shiftwidth=4  " size of tabulation in number of spaces
set smarttab      " be smart when using tabs
set expandtab     " use spaces instead of tabs
set cindent       " C identation

" set replacements (tab, nbsp, trailing spaces)
if has('gui_running') || $COLORTERM == 'truecolor'
    set listchars=tab:▸\ ,nbsp:␣,trail:-
else
    set listchars=tab:>\ ,nbsp:_,trail:-
endif

" Text
set conceallevel=0 " show `` characters

" ------------------------------------------------------------------------------
" Searching
" ------------------------------------------------------------------------------

set ignorecase " case insensitive by default
set smartcase  " case sensitive if using uppercase letters
set hlsearch   " enable highlight in search
set incsearch  " do incremental searching

" ------------------------------------------------------------------------------
" Abbreviations
" ------------------------------------------------------------------------------

iabbrev #i #include
iabbrev #d #define

" ------------------------------------------------------------------------------
" Mappings
"
"   :nmap - Display normal mode maps
"   :imap - Display insert mode maps
"   :vmap - Display visual and select mode maps
"   :smap - Display select mode maps
"   :xmap - Display visual mode maps
"   :cmap - Display command-line mode maps
"   :omap - Display operator pending mode maps
"
"   - mapping issue with ctrl key: $ showkey -a then search for key in `log`
"     file generated by doing: $ nvim -V3log
" ------------------------------------------------------------------------------

" +/-: increment/decrement value under cursor
map <kMinus> <Plug>nextvalDec
map <kPlus>  <Plug>nextvalInc

map - <Plug>nextvalDec
map + <Plug>nextvalInc

" alt-<arrow>: tmux up/down/left/right
nmap <silent> <A-Up>    :TmuxNavigateUp<CR>
nmap <silent> <A-Down>  :TmuxNavigateDown<CR>
nmap <silent> <A-Left>  :TmuxNavigateLeft<CR>
nmap <silent> <A-Right> :TmuxNavigateRight<CR>

" shift-v: visual block mode
nnoremap <S-v> <C-v>

" ctrl-x: cut
vnoremap <silent> <C-X> "+x

" crl-c: copy
map <silent> <C-c> "+y

" ctrl-v: paste
map  <silent> <C-v> "+gP
imap <silent> <C-v> <ESC>"+gpa

" ?: show mapping
nmap <silent> ? :MappingToggle<CR>

if has('gui_running') || $COLORTERM == 'truecolor'
    " ctrl-Space: auto completion
    imap <C-Space> <Plug>(ncm2_manual_trigger)

    " \\: open previous file
    map <Leader><Leader> :e#<CR>

    " ctrl-b: git blame
    map <silent> <C-b> :call <SID>ToggleBlame()<CR>

    " ctrl-f: search files
    :map <silent> <C-f> :call <SID>FzfDevicons($pwd)<CR>

    " ctrl-d => drop all hidden buffers
    map <silent> <C-d> :BuffersClean<CR>

    " ctrl-k: comment/uncomment
    map  <silent> <C-k> <Leader>c<space>
    imap <silent> <C-k> <ESC><Leader>c<space>
    vmap <silent> <C-k> <Leader>c<space>

    " ctrl-o: sorting
    nnoremap <silent> <C-o> Vip:sort i<CR>
    vnoremap <silent> <C-o> :sort i<CR>

    " ctrl-m: markdown preview toggle
    nmap <silent> <C-m> <Plug>MarkdownPreviewToggle
    imap <silent> <C-m> <Plug>MarkdownPreviewToggle
    vmap <silent> <C-m> <Plug>MarkdownPreviewToggle

    " ctrl-PageUp: previous tab
    map <silent> <C-PageUp> gT

    " ctrl-PageDown: next tab
    map <silent> <C-PageDown> gt

    " F1: save
    :map  <F1> :w<CR>
    :imap <F1> <ESC>:w<CR>a
    :vmap <F1> <ESC>:w<CR>

    " F2: quit
    map  <silent> <F2> :q<CR>
    imap <silent> <F2> <ESC>:q<CR>
    vmap <silent> <F2> <ESC>:q<CR>

    " F3: horizontal split
    map  <silent> <F3> :split<CR>
    imap <silent> <F3> <ESC>:split<CR>a
    vmap <silent> <F3> <ESC>:split<CR>

    " F4: vertical split
    map  <silent> <F4> :vsplit<CR>
    imap <silent> <F4> <ESC>:vsplit<CR>a
    vmap <silent> <F4> <ESC>:vsplit<CR>

    " F6: cscope
    map  <F6> :CscopeUpdate<CR>
    imap <F6> <ESC>:CscopeUpdate<CR>
    vmap <F6> <ESC>:CscopeUpdate<CR>

    " ctrl-F6 => rebuild cscope
    map  <C-F6> :CscopeRebuild<CR>
    imap <C-F6> <ESC>CscopeRebuild<CR>
    vmap <C-F6> <ESC>CscopeRebuild<CR>

    map  <F30> :CscopeRebuild<CR>
    imap <F30> <ESC>:CscopeRebuild<CR>
    vmap <F30> <ESC>:CscopeRebuild<CR>

    " F7: no highlight
    map  <silent> <F7> :nohlsearch<CR>
    imap <silent> <F7> <ESC>:nohlsearch<CR>a
    vmap <silent> <F7> <ESC>:nohlsearch<CR>

    " F8: indent all file
    map  <silent> <F8> gg=G
    imap <silent> <F8> <ESC>gg=G
    vmap <silent> <F8> <ESC>gg=G

    " F9: symbols list
    map  <silent> <F9> :TagbarToggle<CR>
    imap <silent> <F9> <ESC>:TagbarToggle<CR>a
    vmap <silent> <F9> <ESC>:TagbarToggle<CR>

    " F10: tree file explorer
    map  <silent> <F10> :NERDTreeToggle<CR>
    imap <silent> <F10> <ESC>:NERDTreeToggle<CR>a
    vmap <silent> <F10> <ESC>:NERDTreeToggle<CR>

    " F11: toggle invisible characters
    map  <silent> <F11> :InvisibleCharsToggle<CR>
    imap <silent> <F11> <ESC>:InvisibleCharsToggle<CR>a
    vmap <silent> <F11> <ESC>:InvisibleCharsToggle<CR>

    " F12: distraction free mode
    map  <silent> <F12> :Goyo<CR>
    imap <silent> <F12> <ESC>:Goyo<CR>a
    vmap <silent> <F12> <ESC>:Goyo<CR>

    " ctrl-F12 => limited view mode
    map  <C-F12> :Limelight!!<CR>
    imap <C-F12> <ESC>:Limelight!!<CR>
    vmap <C-F12> <ESC>:Limelight!!<CR>

    map  <F36> :Limelight!!<CR>
    imap <F36> <ESC>:Limelight!!<CR>
    vmap <F36> <ESC>:Limelight!!<CR>
endif

" ------------------------------------------------------------------------------
" Autocommands
" ------------------------------------------------------------------------------

if has('autocmd')
    autocmd VimEnter * :InvisibleCharsToggle 1
    autocmd VimEnter * :WrappingToggle 0
    autocmd VimEnter * :FoldingToggle 0

    " Remap double click in NERDTree
    autocmd VimEnter * :call NERDTreeAddKeyMap({
        \ 'key': '<2-LeftMouse>',
        \ 'scope': "FileNode",
        \ 'callback': "NERDTreeDoubleClickCbk",
        \ 'override':1
        \ })

    " Remove trailing spaces for these kinds of files
    autocmd BufWrite *.c    :StripRun
    autocmd BufWrite *.cpp  :StripRun
    autocmd BufWrite *.h    :StripRun
    autocmd BufWrite *.hpp  :StripRun

    " Detect which files are executables
    autocmd BufWritePost * ExecutableDetect

    " Set PRO files detected as make files
    autocmd BufNewFile,BufRead *.pro set filetype=make

    " Python
    augroup au_python
        autocmd!
        autocmd FileType python :IndentGuidesEnable
    augroup END
endif

" ------------------------------------------------------------------------------
" Cscope
" ------------------------------------------------------------------------------

if has('cscope')
    " Configurations
    set cscopetag     " use both cscope and ctag for 'ctrl-]', ':ta', and
                      " 'vim -t'
    set csto=0        " check cscope for definition of a symbol before checking
                      " ctags (1 for inverse order)
    set cscopeverbose " show msg when any other cscope db added
    set notimeout     " remove 1 second timeout for each keystroke

    " Key mappings
    nmap <C-j> :cs find f <C-R>=expand("<cword>")<CR><CR>
    nmap <C-s> :cs find s <C-R>=expand("<cword>")<CR><CR>

    vmap <C-LeftRelease> :cs find g <C-R>=expand("<cword>")<CR><CR>
endif

" ------------------------------------------------------------------------------
" Theme
" ------------------------------------------------------------------------------

call theme#apply()
