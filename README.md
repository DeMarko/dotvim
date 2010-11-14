vimfiles
========
These are some of the files I use with vim everyday. They're mostly for use with vim 7.3 and [MacVim][]

I recommend looking at [this guide](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/) if you're getting started or trying to clone my files and not having any luck.

### how to install ###
this is the quickest way to install these files
    
    # these bits backup your current vim files and get them out of the way
    # skip if you don't have a config or have removed your own
    mv .vim vimfilesbackup
    mv .vimrc vimfilesbackup/vimrcbck
    mv .gvimrc vimfilesbackup/gvimrcbck

    # once we're clear, we can download and link my vimfiles
    git clone git://github.com/DeMarko/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    cd ~/.vim/
    git submodule update --init

### updating bundles ###

    # literally calls 'git pull origin master' on every submodule
    ~/.vim/update.sh

### disclaimer ###
I write a good amount of PHP at work so it may lean a bit in that direction

### acknowledgements ###
here are some of the things I couldn't submodule:

+  tomasr's [molokai][] 
+  Lars H. Nielsen's [wombat][]
+  Peter Hodge's [php.vim][]
+  Ken Earl's [smarty.vim][]
+  Rainer M. Schmid's [valgrind.vim][]
+  Todd Werth's [ir_black][]
+  Justin Constantino's [candycode][]

[MacVim]: http://code.google.com/p/macvim/ "MacVim.app"
[molokai]: http://winterdom.com/2008/08/molokaiforvim "Molokai Colorscheme"
[wombat]: http://dengmao.wordpress.com/2007/01/22/vim-color-scheme-wombat/ "Wombat Colorscheme"
[php.vim]: http://www.vim.org/scripts/script.php?script_id=1571 "PHP Syntax"
[smarty.vim]: http://www.vim.org/scripts/script.php?script_id=1798 "Smarty Syntax"
[valgrind.vim]: http://www.vim.org/scripts/script.php?script_id=607 "Valgrind navigator"
[candycode]: http://www.vim.org/scripts/script.php?script_id=1635
[ir_black]: http://blog.infinitered.com/entries/show/8
