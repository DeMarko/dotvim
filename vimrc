" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/YankRing.vim'
Plug 'yggdroot/indentline'

" Initialize plugin system
call plug#end()

set nocompatible                   " screw vi compatibility, only geezers use vi
set encoding=utf-8

" Backups, undo, views, YankRing and Markdown previews
set backup                        " enable backups
silent execute '!mkdir -p $HOME/.vim/tmp/backup'
set backupdir=$HOME/.vim/tmp/backup// " backups
silent execute '!mkdir -p $HOME/.vim/tmp/swap'
set directory=$HOME/.vim/tmp/swap//   " swap files
silent execute '!mkdir -p $HOME/.vim/tmp/views'
set viewdir=$HOME/.vim/tmp/views//    " view files
silent execute '!mkdir -p $HOME/.vim/tmp/yankring'
let g:yankring_history_dir = '$HOME/.vim/tmp/yankring'
silent execute '!mkdir -p $HOME/.vim/tmp/other/'

if has("persistent_undo")
  silent execute '!mkdir -p $HOME/.vim/tmp/undo'
  set undodir=~/.vim/tmp/undo// " undofiles
  set undofile
endif

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
if has("mouse")
    set mouse=a                    " enable full mouse support in the console
endif
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
set colorcolumn=121

set relativenumber             " shows line numbers relative to current line
set pastetoggle=<F2> "enable paste toggle and map it to <F2>
set autochdir " cd into directory of opened file
set autoread " when a file is changed outside of vim, automatically read it again
set splitright " split new windows on the right of the current one
set splitbelow " split new windows below the current one
set fillchars=diff:⣿,vert:│
set title " why this doesn't happen by default is a mystery
let &titleold=fnamemodify(&shell, ":t") " string to restore the title to when exiting Vim
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
set shortmess=aoOtI           " list of flags to make messages shorter

set wildchar=<TAB>            " have command-line completion <Tab>
set whichwrap=h,l,~,[,]       " have the h and l cursor keys wrap between
                              " lines (like <Space> and <BkSpc> do by default),
                              " and ~ convert case over line breaks;
                              " also have the cursor keys wrap in insert mode

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" invisible characters to show
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" autocommands
au BufWinLeave * silent! mkview   " make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview " make vim load view (state) (folds, cursor, etc)

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" absolute line numbers in insert mode, relative otherwise for easy movement
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Resize splits when the window is resized
au VimResized * :wincmd =


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


" * Plugin specific
"
" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" NERDTree
nnoremap  <F4> :NERDTreeToggle<cr>
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

" delimitMate
let g:delimitMate_no_esc_mapping = 1

" ctrl p
nnoremap <silent> <leader>p :CtrlP<cr>
let g:ctrlp_working_path_mode = 'rc'

" FZF
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_buffers_jump = 1
let g:fzf_action = {
  \ 'enter': 'tabedit',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Undotree keymaps
nnoremap <F5> :UndotreeToggle<CR>

" find out who's to blame for the current line
nnoremap <leader>b :Gblame<CR>

set background=dark
if !empty(glob('~/.vim/plugged/gruvbox'))
  colorscheme gruvbox
endif

" some custom shit I wrote
