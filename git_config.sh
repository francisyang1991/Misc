#!/bin/bash

git config --global color.ui auto
git config --global alias.l "log --graph --format=format:'%Cblue%h%Creset - %s %Cgreen%d%Creset %C(dim white)%an%Creset' --abbrev-commit"
git config --global alias.st status 
git config --global alias.co checkout
git config --global alias.ci commit 
git config --global alias.b branch 
