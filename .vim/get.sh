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

# install svelte syntax highlighting
cd $VIMDIR/bundle/
git clone https://github.com/othree/html5.vim.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/evanleck/vim-svelte.git

# install covim for collaborative editing.... Requires python2 and recompile with python2 option.
#cd $VIMDIR/bundle/
#git clone https://github.com/FredKSchott/CoVim.git


# install multiplayer.vim for collaborative/simultaneous editing
cd $VIMDIR/bundle/
git clone https://github.com/rolf007/multiplayer.vim.git

# autoread is not functional, this will fix it
cd $VIMDIR/bundle/
git clone https://github.com/djoshea/vim-autoread.git
