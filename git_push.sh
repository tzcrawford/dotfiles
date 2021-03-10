#!/bin/sh
#updates the git repository, give comment without quotations as first parameter
#git init
#git add .
git add -A
git commit -m "$*"
#git remote add origin https://github.com/tzcrawford/dotfiles.git
#git push --set-upstream origin master
git push --force origin master #I hard link my local repo, so this changes everything on the remote repo
