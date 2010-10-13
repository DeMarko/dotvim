#!/bin/zsh

txtgrn='\e[1;32m' # Green
txtrst='\e[0m'    # Text Reset

cd $HOME/.vim/bundle/
for bundle in *
do
    cd $bundle
    echo -e "${txtgrn}${bundle}${txtrst}"
    git pull
    cd ..
done
