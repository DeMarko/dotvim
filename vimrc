" DeMarko's vimrc

autocmd!
filetype on
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set nocompatible                   " screw vi compatibility, only geezers use vi

" * Security
set modelines=0                    " prevents known security exploit

" Backups and undo and YankRing
set backup                        " enable backups
silent execute '!mkdir -p $HOME/.vim/tmp/backup'
set backupdir=$HOME/.vim/tmp/backup// " backups
silent execute '!mkdir -p $HOME/.vim/tmp/swap'
set directory=$HOME/.vim/tmp/swap//   " swap files
silent execute '!mkdir -p $HOME/.vim/tmp/views'
set viewdir=$HOME/.vim/tmp/views//    " view files
silent execute '!mkdir -p $HOME/.vim/tmp/yankring'
let g:yankring_history_dir = '$HOME/.vim/tmp/yankring'

if version >= 703
    set undofile
    silent execute '!mkdir -p $HOME/.vim/tmp/undo'
    set undodir=~/.vim/tmp/undo// " undofiles
endif

" starts NERDTree for every file 
autocmd VimEnter * exe 'NERDTree' | wincmd l
autocmd BufEnter * NERDTreeMirror

au BufWinLeave * silent! mkview   " make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview " make vim load view (state) (folds, cursor, etc)

" auto switch to folder where editing file
set autochdir
" autocmd BufEnter * cd %:p:h

" * Tab-related
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" * Basics
syntax on                          " syntax highlighting is nifty! let's turn it on!
set showmode                       " display the current mode in the status line
set showcmd                        " show partially-typed commands in the status line
set ruler                          " add a useful ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set hidden

" Statusline Hijinx
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

" fugitive statusline
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        "always show status line


" * Leader
let mapleader = ","

" * General Options
set history=1000                   " keeps a thousand lines of history
set magic                          " allows pattern matching with special characters
set backspace=2                    " make backspace work like normal
set visualbell                     " visual bell instead of annoying beeping
set mouse=a                        " enable full mouse support in the console
set virtualedit=onemore            " allow for cursor beyond last character
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
set wildmenu                       " enables a menu at the bottom of the vim/gvim window
set wildmode=longest,list          " complete on tab to longest match, present match list on second tab
set ttyfast                        " enable support for higher speed terminal connections
set showmatch                      " show brace matching
set matchtime=3                    " for 3 milliseconds
set scrolloff=4

set wildchar=<TAB>            " have command-line completion <Tab>
set whichwrap=h,l,~,[,]       " have the h and l cursor keys wrap between
                              " lines (like <Space> and <BkSpc> do by default),
                              " and ~ convert case over line breaks;
                              " also have the cursor keys wrap in insert mode

set background=dark
colorscheme candycode

" * Key Remaps

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" unhighilight search items with ,<space>
nnoremap <leader><space> :noh<cr>

" edit vim config
nmap <leader>V :tabedit $MYVIMRC<CR>

" page down with <Space> (like in `Lynx', `Mutt', `Pine', `Netscape Navigator',
" `SLRN', `Less', and `More'); page up with - (like in `Lynx', `Mutt', `Pine'),
" or <BkSpc> (like in `Netscape Navigator'):
" NOTE: enabling this may make the space.vim plugin wonky
"noremap <Space> <PageDown>
"noremap <BS> <PageUp>

" Fuck you, help key.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap ; :

nmap <leader>sw :syntax off<CR>:syntax on<CR>

" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Easier linewise reselection
map <leader>v V`]

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Gundo keymaps
nnoremap <F5> :GundoToggle<CR>
nnoremap <leader>g :GundoToggle<CR>

" highlight long lines in file
nnoremap <leader>long :HighlightLongLines<CR>

" find out who's to blame for the current line
nnoremap <leader>b :VCSBlame<CR>

" fold html tags
au BufNewFile,BufRead *.html map <leader>ft Vatzf

" stuff I've only found works properly in 7.3
if version >= 703
    " Ack
    map <leader>a :Ack<space>
endif


" * Plugin Options

" disable PIV's PHP autofolding
let g:DisableAutoPHPFolding = 1

" Syntastic options
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1

" wtf LustyExplorer, most annoying warning EVER
let g:LustyExplorerSuppressRubyWarning = 1

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" NERDTree
let g:NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar

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


" * Text Formatting -- Specific File Formats

" recognize anything at all with a .txt extension as being human-language text
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END
" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human set formatoptions+=t textwidth=72
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
autocmd FileType php let php_folding = 3
" highlight functions from the base library
autocmd FileType php let php_baselib = 1

" OmniCompletion for std lib functions and so forth (C-X, C-o)
set omnifunc=syntaxcomplete#Complete

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

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
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
autocmd WinEnter * call NERDTreeQuit()

" toggle quickfix window
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
nmap <silent> \ :QFix<CR>
