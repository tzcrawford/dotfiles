#!/bin/sh
#installs vim addons
VIMDIR=~/.vim/

#using pathogen to install addons!
mkdir $VIMDIR/autoload > /dev/null 2>&1
cd $VIMDIR/autoload
git clone https://github.com/tpope/vim-pathogen.git
#add to vimrc (uncommented):
#execute pathogen#infect()
#execute pathogen#helptags()

#install vim autocomlpop
cd $VIMDIR/bundle
git clone https://github.com/vim-scripts/AutoComplPop
#make sure to add/enable options in vimrc

#install syntastic
cd $VIMDIR/bundle/
git clone https://github.com/scrooloose/syntastic
#make sure to add/enable options in vimrc

#install loremipsum
cd $VIMDIR/bundle/
git clone https://github.com/vim-scripts/loremipsum
#make sure to add/enable options in vimrc

#install loremipsum
cd $VIMDIR/bundle/
git clone https://github.com/vim-scripts/loremipsum

#install vim-mathematica
#cd $VIMDIR/bundle/
#git clone git@github.com:rsmenon/vim-mathematica.git

# install ale for linting
cd $VIMDIR/bundle/
git clone https://github.com/dense-analysis/ale 

# install omnisharp for c#/c++/unity
cd $VIMDIR/bundle/
git clone https://github.com/OmniSharp/omnisharp-vim


