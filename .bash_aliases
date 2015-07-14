#!/bin/bash

# Easy editing of this file: http://www.modernperlbooks.com/mt/2009/10/remove-the-little-pessimizations.html
alias realias='$EDITOR ~/.bash_aliases; source ~/.bash_aliases'

# Always colour my diffs
alias diff='colordiff'

# When invoking git in my homedir, act on my dotfiles repo
alias git='_git() { if [ `pwd` == "$HOME" ] ; then `which git` --git-dir=$HOME/.dotfiles.git --work-tree=$HOME "$@" ; else `which git` "$@"; fi }; _git'

# Make head and tail use available screen size
# Aso, more responsive tail -f
alias head='head -n $(($LINES - 2))'
alias tail='tail -n $(($LINES - 2)) -s.1'

# Simple graphical browser
alias glinks='links2 -g'
