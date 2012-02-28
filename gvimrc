colorscheme molokai
set cursorline
set colorcolumn=85             " have a colored column at 85
set fuoptions=maxvert,maxhorz

set guioptions+=T
set guioptions-=l  " no left scrollbar
set guioptions-=L
set guioptions-=r  " no right scrollbar
set guioptions-=R

highlight SpellBad term=underline gui=undercurl guisp=Orange

" Rainbows!
nnoremap <leader>R :RainbowParenthesesToggle<CR>

" tab navigation
nmap <C-w> :tabclose<cr>
nmap <C-t> :tabnew<cr>
nmap <C-Tab> :tabnext<cr>
nmap <C-S-Tab> :tabprev<cr>

if has("gui_macvim")
    nnoremap <silent> <SwipeLeft> :macaction _cycleWindowsBackwards:<CR>
    nnoremap <silent> <SwipeRight> :macaction _cycleWindows:<CR>
    set guifont=Menlo:h12
    " For mac users (using the 'apple' key)
    map <D-S-]> gt
    map <D-S-[> gT
    map <D-1> 1gt
    map <D-2> 2gt
    map <D-3> 3gt
    map <D-4> 4gt
    map <D-5> 5gt
    map <D-6> 6gt
    map <D-7> 7gt
    map <D-8> 8gt
    map <D-9> 9gt
    map <D-0> :tablast<CR>
endif
