#!/bin/bash

txtgrn='\033[1;32m' # Green
txtrst='\033[0m'    # Text Reset

cd $HOME/.vim/bundle/
for bundle in *
do
    cd $bundle
    echo -e "${txtgrn}${bundle}${txtrst}"
    git pull origin master
    cd ..
done
