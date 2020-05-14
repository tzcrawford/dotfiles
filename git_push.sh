#!/bin/sh
#updates the git repository, give comment without quotations as first parameter
#git init
git add .
git commit -m "$*"
#git remote add origin https://github.com/tzcrawford/dotfiles.git
#git push origin master
#git push
git push --set-upstream origin master
