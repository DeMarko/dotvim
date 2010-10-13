" DeMarko's blatantly stolen .vimrc
"   which you totally should not feel guilty about stealing either
"   no, like seriously, go ahead

autocmd!                              

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

au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

" auto switch to folder where editing file
" set autochdir
" autocmd BufEnter * cd %:p:h

" * Tab-related
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" * Basics
set showmode                       " display the current mode in the status line
set showcmd                        " show partially-typed commands in the status line
set ruler                          " add a useful ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set laststatus=2                   " always show status line

" status line hijinks
set statusline=%<%f\ %h%m%r%y
 \%{exists('g:loaded_fugitive')?fugitive#statusline():''}
 \%{exists('g:loaded_rvm')?rvm#statusline_ft_ruby():''}
 \%{&filetype=='perl'?'['.system($perlv).']':''}
 \%=%-14.(%l,%c%V%)\ %P

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
"nnoremap / /\v
"vnoremap / /\v
set ignorecase                     " make searches case-insensitive
set smartcase                      " unless they contain upper-case letters ;)
set incsearch                      " show the `best match so far' as search strings are typed
set gdefault                       " assume the /g flag on :s substitutions to replace all matches in a line
set hlsearch                       " highlight search items
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %


set wrap linebreak textwidth=0     " set vim to soft wrap lines
set formatoptions=qrn1
set autoindent
set shiftround

set wildchar=<TAB>                 " have command-line completion <Tab>
set whichwrap=h,l,~,[,]            " have the h and l cursor keys wrap between 
                                   " lines (like <Space> and <BkSpc> do by default),
                                   " and ~ convert case over line breaks; 
                                   " also have the cursor keys wrap in insert mode

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" tab navigation
nmap <C-w> :tabclose<cr>
nmap <C-Tab> :tabnext<cr>
nmap <C-S-Tab> :tabprev<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

" page down with <Space> (like in `Lynx', `Mutt', `Pine', `Netscape Navigator',
" `SLRN', `Less', and `More'); page up with - (like in `Lynx', `Mutt', `Pine'),
" or <BkSpc> (like in `Netscape Navigator'):
"noremap <Space> <PageDown>
"noremap <BS> <PageUp>

" Fuck you, help key.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap ; :

" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Easier linewise reselection
map <leader>v V`]

" Ack
if version >= 703
    map <leader>a :Ack 
endif

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" Formatting, TextMate-style
map <leader>q gqip

" find out who's to blame for the current line
vmap <leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 
vmap <leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Folding
" set foldlevelstart=1
" set foldmethod=indent
au BufNewFile,BufRead *.html map <leader>ft Vatzf

" get rid of the default style of C comments, and define a style with two stars at the start of `middle' rows which (looks nicer and) avoids asterisks used for bullet lists being treated like C comments; then define a bullet list style for single stars (like already is for hyphens):
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
" for actual C (not C++) programming where comments have explicit end characters, if starting a new line in the middle of a comment automatically insert the comment leader characters:
autocmd FileType c set formatoptions+=ro
" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent
" in makefiles, don't expand tabs to spaces, since actual tab characters are needed, and have indentation at 8 chars to be sure that all indents are tabs (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

" PHP Specific
" highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
autocmd FileType php let php_sql_query=1
" does exactly that. highlights html inside of php strings
autocmd FileType php let php_htmlInStrings=1
" discourages use oh short tags. c'mon its deprecated remember
autocmd FileType php let php_noShortTags=1
" automagically folds functions & methods. this is getting IDE-like isn't it?
autocmd FileType php let php_folding=2
" set "make" command when editing php files
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

set omnifunc=syntaxcomplete#Complete
" autocomplete funcs and identifiers for languages
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete

let g:DisableAutoPHPFolding = 0



syntax on                          " syntax highlighting is nifty! let's turn it on!
set background=dark
colorscheme dante

