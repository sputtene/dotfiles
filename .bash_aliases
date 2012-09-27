#!/bin/bash

# Always colour my diffs
alias diff='colordiff'

# When invoking git in my homedir, act on my dotfiles repo
alias git='_git() { if [ `pwd` == "$HOME" ] ; then `which git` --git-dir=$HOME/.dotfiles.git --work-tree=$HOME "$@" ; else `which git` "$@"; fi }; _git'
