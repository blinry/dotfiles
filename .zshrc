autoload -U compinit promptinit
compinit
promptinit

autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{28}'"'"''
zstyle ':vcs_info:*' unstagedstr '%F{11}'"'"''
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%F{2}%b%c%u%f '
    } else {
        zstyle ':vcs_info:*' formats '%F{2}%b%c%u'"'"'%f '
    }

    vcs_info
}

setopt prompt_subst
PROMPT='%{%(!.$fg_bold[red].$fg_bold[blue])%}%~ ${vcs_info_msg_0_}%{$reset_color%}'

zstyle ':completion:*' menu select
setopt completealiases

source ~/.shellrc
