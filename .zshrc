autoload -U compinit promptinit
compinit
promptinit

autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "'"
zstyle ':vcs_info:*' stagedstr '°'

VCS_PATH='%%F{blue}%R/%%U%S%%u'
VCS_BRANCH='%%B%%F{green}%b%%F{yellow}%u%c%%b'

zstyle ':vcs_info:*' nvcsformats "%F{blue}%3~%f "
zstyle ':vcs_info:*' formats "$VCS_PATH $VCS_BRANCH "
zstyle ':vcs_info:*' actionformats "$VCS_PATH $VCS_BRANCH %%F{red}(%a)%%f "

precmd () {
    vcs_info
}

setopt prompt_subst
PROMPT='%B${${vcs_info_msg_0_/\/%U./}/$HOME/~}%f'

zstyle ':completion:*' menu select
setopt completealiases

bindkey "^[[3~" delete-char             # Del
bindkey "^[[7~" beginning-of-line       # Pos1
bindkey "^[[8~" end-of-line             # End

source ~/.shellrc
