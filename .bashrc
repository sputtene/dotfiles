# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

_update_prompt () {
    # put this at the top, so return val won't get cluttered by commands executed below
    local exit="$?"

    # Prompt colors
    local black="30";
    local grey="31";
    local red="31";
    local green="32";
    local yellow="33";
    local blue="34";
    local purple="35";
    local cyan="36";
    local white="37";

    local pre="\[\033[";
    local suf="\]";

    # public values
    GREEN="${pre}0;${green}m$suf";
    BGREEN="${pre}$green;1m$suf";
    BLUE="${pre}0;${blue}m$suf";
    BBLUE="${pre}$blue;1m$suf";
    CYAN="${pre}0;${cyan}m$suf";
    BCYAN="${pre}$cyan;1m$suf";
    WHITE="${pre}0;${white}m$suf";
    BWHITE="$pre$white;1m$suf";
    RED="${pre}0;${red}m$suf";
    BRED="$pre$red;1m$suf";
    YELLOW="${pre}0;${yellow}m$suf";
    BYELLOW="$pre$yellow;1m$suf";

    NORMAL="\[\e[0;0m\]";

    local color_prompt="yes"
    local bul="\$" # make this a # for root

    #local _prompt="$BYELLOW$(date +%X)$NORMAL $BGREEN\u@\h $BBLUE\w$NORMAL";
    if [ "$color_prompt" = yes ]; then
        _prompt='\[\033[33;1m\]$(date +%T)\[\033[0;0m\] ${debian_chroot:+($debian_chroot)}\[\033[00;36m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]'
    else
        _prompt='$(date +%T) ${debian_chroot:+($debian_chroot)}\u@\h:\w'
    fi

    case "$exit" in
        "0" ) ex="$GREEN$bul$NORMAL" ;;
          * ) ex="$BRED$bul$NORMAL" ;;
    esac

    export PS1="$_prompt $ex ";
}

export PROMPT_COMMAND='_update_prompt';

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -a -p'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Pandolin doesn't honour /etc/default/keyboard, so we do it ourself
if test -z "$SSH_CONNECTION" \
    && test -n "$DISPLAY"; then
source /etc/default/keyboard    # get keyboard settings
setxkbmap -model "$XKBMODEL" -layout "$XKBLAYOUT" -variant "$XKBVARIANT" -option "$XKBOPTIONS"
xmodmap ~/.Xmodmap
fi

## TODO: move these to a devel_mode() function
# for developing: http://udrepper.livejournal.com/11429.html
export MALLOC_CHECK_=3
# The following can cause performance issues
# so unset it before performance testing for example
export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))

# Let me have core dumps
ulimit -c unlimited


# Misc exports
export LC_COLLATE=C # Fix 'natural' sorting order for ls and friends
export EDITOR=vim

# Set up perlbrew environment
PERLBREW="$HOME/perl5/perlbrew/etc/bashrc"
[ -r "$PERLBREW" ] && source $PERLBREW


# Use Vim as man pager
export MANPAGER="/bin/sh -c \"unset PAGER ;                 \
    col -b -x |                                             \
    vim -MRn                                                \
    -c 'set ft=man nolist'                                  \
    -c 'map q :q<CR>'                                       \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>'                 \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>'  \
    -c 'let g:showmarks_enable=0'                           \
    -\""


# Set random background colour for the next rxvt-unicode
case "$TERM" in
rxvt-unicode*)
    case "$(expr $$ % 6)" in
        0) color="orange"   ;;
        1) color="red"      ;;
        2) color="green"    ;;
        3) color="cyan"     ;;
        4) color="magenta"  ;;
        5) color="HotPink"  ;;
        *) ;;
    esac
    echo "Rxvt*tintColor: $color" | xrdb -merge -
    ;;
*)
    ;;
esac
