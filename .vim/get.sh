#!/bin/bash
#installs vim addons
VIMDIR=~/.vim/

# using pathogen to install addons!
mkdir "$VIMDIR/autoload" > /dev/null 2>&1
cd "$VIMDIR/autoload"
git clone https://github.com/tpope/vim-pathogen.git
mv vim-pathogen/autoload/pathogen.vim "$VIMDIR/autoload/"
rm -rf "$VIMDIR/autoload/vim-pathogen"
# add to vimrc (uncommented):
#execute pathogen#infect()
#execute pathogen#helptags()

# We will loop over each of the plugin names that we describe in this array
pluginArray=()

# autocomlpop for autocompletions
pluginArray+=("vim-scripts/AutoComplPop")
#make sure to add/enable options in vimrc

#automatic language server configuration
pluginArray+=("prabirshrestha/vim-lsp")

#automatic install of language server libraries
pluginArray+=("mattn/vim-lsp-settings")

# syntastic for syntax checking
pluginArray+=("scrooloose/syntastic")
#make sure to add/enable options in vimrc

# ale for linting
pluginArray+=("dense-analysis/ale")

# covim for collaborative editing
# !!!Requires python2 and recompile with python2 option!!!
#git clone https://github.com/FredKSchott/CoVim

# multiplayer.vim for collaborative/simultaneous editing
pluginArray+=("rolf007/multiplayer.vim")

# autoread is not functional, this will fix it
# (automatically refreshes content if saved elsewhere)
pluginArray+=("djoshea/vim-autoread")

#install loremipsum
pluginArray+=("vim-scripts/loremipsum")
#make sure to add/enable options in vimrc

# install svelte syntax highlighting
pluginArray+=("othree/html5.vim")
pluginArray+=("pangloss/vim-javascript")
pluginArray+=("evanleck/vim-svelte")

# install omnisharp for c#/c++/unity
pluginArray+=("OmniSharp/omnisharp-vim")

#install vim-mathematica for mathematica support
#pluginArray+=("rsmenon/vim-mathematica")


for i in "${pluginArray[@]}" ; do
    cd "$VIMDIR/bundle/"
    git clone "https://github.com/${i}.git"
done

