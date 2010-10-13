set guifont=Menlo:h12
colorscheme molokai
set cursorline
set colorcolumn=85             " have a colored column at 85
set fuoptions=maxvert,maxhorz

set go-=T
set go-=l
set go-=L
set go-=r
set go-=R

highlight SpellBad term=underline gui=undercurl guisp=Orange

" tab navigation
nmap <C-w> :tabclose<cr>
nmap <C-t> :tabnew<cr>
nmap <C-Tab> :tabnext<cr>
nmap <C-S-Tab> :tabprev<cr>

