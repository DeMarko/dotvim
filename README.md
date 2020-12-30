vimfiles
========
These are some of the files I use with vim. They are not compatible with vim versions before 8

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

### disclaimer ###
I write Ruby on Rails these days, and use VSCode pretty much daily. I use this for the odd personal project

### shoutz ###
+  Ben Hamill for teaching me [how to update submodules in cloned repos
   properly](https://twitter.com/benhamill/status/304330375088467968)
+  Sara Bobo for actually getting me to update my vimfilesg

[MacVim]: http://code.google.com/p/macvim/ "MacVim.app"



