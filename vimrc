" DeMarko's vimrc

autocmd!
filetype off
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on

set nocompatible                   " screw vi compatibility, only geezers use vi

" * Security
set modelines=0                    " prevents known security exploit

set encoding=utf-8

" Backups, undo, views, YankRing and Markdown previews
set backup                        " enable backups
silent execute '!mkdir -p $HOME/.vim/tmp/backup'
set backupdir=$HOME/.vim/tmp/backup// " backups
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"
silent execute '!mkdir -p $HOME/.vim/tmp/swap'
set directory=$HOME/.vim/tmp/swap//   " swap files
silent execute '!mkdir -p $HOME/.vim/tmp/views'
set viewdir=$HOME/.vim/tmp/views//    " view files
silent execute '!mkdir -p $HOME/.vim/tmp/yankring'
let g:yankring_history_dir = '$HOME/.vim/tmp/yankring'
silent execute '!mkdir -p $HOME/.vim/tmp/other/'
let g:MarkdownPreviewTMP = '$HOME/.vim/tmp/other/'

if version >= 703
    set undofile
    silent execute '!mkdir -p $HOME/.vim/tmp/undo'
    set undodir=~/.vim/tmp/undo// " undofiles
endif

" starts NERDTree for every file
"autocmd VimEnter * exe 'NERDTree' | wincmd l
"autocmd BufEnter * NERDTreeMirror

au BufWinLeave * silent! mkview   " make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview " make vim load view (state) (folds, cursor, etc)

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" au FocusLost * :silent! wall                 " Save on FocusLost
" au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost

" absolute line numbers in insert mode, relative otherwise for easy movement
" only works in 7.3 or above (because of relativenumber)
if version >= 703
    au InsertEnter * :set number
    au InsertLeave * :set relativenumber
endif

" this is the same as the above command for versions of vim
" that don't support autochdir
" autocmd BufEnter * cd %:p:h

" * Tab-related
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set tags=tags;/


" * Basics
syntax on                          " syntax highlighting is nifty! let's turn it on!
set showmode                       " display the current mode in the status line
set showcmd                        " show partially-typed commands in the status line
set ruler                          " add a useful ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set hidden
set laststatus=2        "always show status line

" * Leader
let mapleader = ","

" * General Options
set history=1000                   " keeps a thousand lines of history
set magic                          " allows pattern matching with special characters
set backspace=2                    " make backspace work like normal
set visualbell                     " visual bell instead of annoying beeping
set mouse=a                        " enable full mouse support in the console
set virtualedit=onemore            " end of the line? what's that?
" * Search & Replace
set ignorecase                     " make searches case-insensitive
set smartcase                      " unless they contain upper-case letters ;)
set incsearch    " show the `best match so far' as search strings are typed
set gdefault     " assume the /g flag on :s substitutions
set hlsearch                       " highlight search items

set wrap linebreak textwidth=0     " set vim to soft wrap lines
set formatoptions=qrn1
set autoindent
set shiftround

if version >= 703
    set relativenumber             " shows line numbers relative to current line
else
    set number
endif
set pastetoggle=<F9> "enable paste toggle and map it to F8
set autochdir " cd into directory of opened file
set autoread " when a file is changed outside of vim, automatically read it again
set splitright " split new windows on the right of the current one
set splitbelow " split new windows below the current one
set fillchars=diff:⣿,vert:│
set title " why this doesn't happen by default is a mystery
set colorcolumn=+1
set wildmenu                       " enables a menu at the bottom of the vim/gvim window
set wildmode=longest,list          " complete on tab to longest match, present match list on second tab
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files"
set ttyfast                        " enable support for higher speed terminal connections
set showmatch                      " show brace matching
set matchtime=3                    " for 3 milliseconds
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

set wildchar=<TAB>            " have command-line completion <Tab>
set whichwrap=h,l,~,[,]       " have the h and l cursor keys wrap between
                              " lines (like <Space> and <BkSpc> do by default),
                              " and ~ convert case over line breaks;
                              " also have the cursor keys wrap in insert mode

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" invisible characters to show
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

colorscheme molokai

" * Key Remaps
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" "Refocus" folds
nnoremap ,z zMzvzz"
" use sane regexes
nnoremap / /\v
vnoremap / /\v

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" unhighilight search items with ,<space>
nnoremap <leader><space> :noh<cr>

" toggle invisible characters
nnoremap <leader>l :set list!<cr>

" edit vim config
nmap <leader>vv :tabedit $MYVIMRC<CR>
nmap <leader>gg :tabedit $MYGVIMRC<CR>

" Fuck you, help key.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap ; :

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" bind current to scroll
nnoremap <leader>s :set scb!<CR>

" flip syntax on and off
nmap <leader>sw :syntax off<CR>:syntax on<CR>

" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Easier linewise reselection
map <leader>v V`]

" reselect visual block after indent change
vnoremap < <gv
vnoremap > >gv



" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" CtrlP
nnoremap <leader>p :CtrlP<CR>

" Gundo keymaps
nnoremap <F5> :GundoToggle<CR>
nnoremap <leader>g :GundoToggle<CR>

" highlight long lines in file
nnoremap <leader>long :HighlightLongLines<CR>

" find out who's to blame for the current line
nnoremap <leader>b :Gblame<CR>

" fold html tags
au BufNewFile,BufRead *.html map <leader>ft Vatzf

" stuff I've only found works properly in 7.3
if version >= 703
    " Ack
    map <leader>a :Ack<space>
endif


" * Plugin Options

" disable PIV's PHP autofolding
"let g:DisableAutoPHPFolding = 1

" Syntastic options
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_phpcs_conf = "--standard=/home/".expand($USER)."/development/Web/tests/standards/stable-ruleset.xml -d memory_limit=512M"
"let g:syntastic_phpcs_disable = 1

" wtf LustyExplorer, most annoying warning EVER
let g:LustyExplorerSuppressRubyWarning = 1

" fix bundled directory for stylesheets
"let g:MarkdownPreviewDefaultStyles = $HOME.'/.vim/bundle/markdown-preview/stylesheets/'

" Fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>

" NERDTree
noremap  <F4> :NERDTreeToggle<cr>
inoremap <F4> <esc>:NERDTreeToggle<cr>
let g:NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar
let g:NERDTreeDirArrows=0
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                    \ '.*\.o$', 'db.db', 'tags.bak']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
" disable warnings from NERDCommenter:
let g:NERDShutUp = 1

" CtrlP
let g:ctrlp_working_path_mode = 'rc'
" makes CtrlP open in tabs instead of current buffer
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': [],
  \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
  \ }

" TagBar
let g:tagbar_width = 50
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
nmap <F8> :TagbarToggle<CR>

" PHPCtags for TagBar
let g:tagbar_phpctags_bin='/home/djurado/bin/phpctags/phpctags'

" * Text Formatting

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:\ *,ex:*/
set comments+=fb:\ *
" treat lines starting with a quote mark as comments (for 'Vim' files)
set comments+=b:\"

" Resize splits when the window is resized
au VimResized * :wincmd =

" * Text Formatting -- Specific File Formats

" recognize anything at all with a .txt extension as being human-language text
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END
" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human,markdown set formatoptions+=t textwidth=78
" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent
" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro
" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent
" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

" show git diff in window split when committing
" broken if autochdir is enabled
" autocmd FileType gitcommit DiffGitCached | wincmd p

" recognize smarty files, add dictionary completion
au BufRead,BufNewFile *.tpl set filetype=smarty
au Filetype smarty exec('set dictionary=$HOME/.vim/syntax/smarty.vim')
au Filetype smarty set complete+=k

" ** PHP Specific
" highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
autocmd FileType php let php_sql_query = 1
" does exactly that. highlights html inside of php strings
autocmd FileType php let php_htmlInStrings = 1
" discourages use oh short tags. c'mon its deprecated remember
autocmd FileType php let php_noShortTags = 1
" automagically folds functions & methods. this is getting IDE-like isn't it?
"autocmd FileType php let php_folding = 3
" highlight functions from the base library
autocmd FileType php let php_baselib = 1

" open PHP classes but not functions
autocmd FileType php set foldlevel=1

" OmniCompletion for std lib functions and so forth (C-X, C-o)
set omnifunc=syntaxcomplete#Complete

" powerline is the new hotness
let g:Powerline_symbols = 'fancy'
let g:Powerline_cache_enabled = 1

" * Functions

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

" close the NERDTree window if there are no other open buffers
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
"autocmd WinEnter * call NERDTreeQuit()

