# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# root gets a red prompt, everyone else a blue one
if [ `whoami` == "root" ]; then
    export PS1="\[\e[1;31m\]\w\[\e[0m\] "
else
    export PS1="\[\e[1;34m\]\w\[\e[0m\] "
fi

# bash now an elephant
export HISTSIZE=1000000
export HISTFILESIZE=1000000
# but doesn't remember duplicate or empty commands
export HISTCONTROL=ignoreboth
# remember commands from all terminals
shopt -s histappend
# check window size after each command
shopt -s checkwinsize

# Enable... bash completion!
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

source ~/.shellrc

# Für den Vorkurs:
export PATH="$HOME/.vorkurs:$PATH"
