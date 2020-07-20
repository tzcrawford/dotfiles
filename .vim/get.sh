#!/bin/sh
#installs vim addons
VIMDIR=~/.vim

#using pathogen to install addons!
mkdir $VIMDIR > /dev/null 2>&1 #make the directory if possible and ignore output
mkdir $VIMDIR/autoload > /dev/null 2>&1 #make the directory if possible and ignore output
cd $VIMDIR/autoload
git clone https://github.com/tpope/vim-pathogen.git
mv vim-pathogen/autoload/* .
sudo rm -r vim-pathogen
#add to vimrc (uncommented):
#execute pathogen#infect()
#execute pathogen#helptags()

mkdir $VIMDIR/bundle > /dev/null 2>&1
cd $VIMDIR/bundle

#install vim autocomlpop
mkdir $VIMDIR/bundle > /dev/null 2>&1
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
cd $VIMDIR/bundle/
git clone git@github.com:rsmenon/vim-mathematica.git

##for R 
##install nvim-r
#nvimrversion=0.9.14
#wget https://github.com/jalvesaq/Nvim-R/releases/download/v0.9.14/Nvim-R_$nvimrversion.zip
#unzip Nvim-R_$nvimrversion.zip
#rm Nvim-R_$nvimrversion.zip
#mv start/Nvim-R .
#rmdir start
##install ncm-R for autocompletion
#ncmrversion=1.0
#wget https://github.com/gaalcaras/ncm-R/archive/v$ncmrversion.zip
#unzip v$ncmrversion.zip
#rm v$ncmrversion.zip
##install nvim-completion-manager
#git clone https://github.com/ncm2/ncm2.git
