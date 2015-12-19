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

# Kindle USB networking
alias kindle_un='sudo ifconfig usb0 192.168.15.201'
alias kindle_ssh='ssh root@192.168.15.244'

# Perl local::lib easy syntax
# See http://blogs.perl.org/users/aristotle/2015/12/locallib-ez.html
alias perl-locallib='_perl_locallib() { eval "`perl -M'local::lib @ARGV' - "$@" 1<&-`" ; }; _perl_locallib'
