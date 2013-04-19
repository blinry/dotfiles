source ~/.shellrc

autoload -U compinit promptinit
compinit
promptinit

export HISTSIZE=9999999999999
export HISTFILE=~/.cache/zsh_history
export SAVEHIST=9999999999999
setopt INC_APPEND_HISTORY
setopt share_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey '^Z'   predict-on
bindkey '^X^Z' predict-off
zstyle :predict verbose yes
zstyle :predict cursor key
zstyle ':completion:predict:*' completer _oldlist _complete _ignored _history _prefix

function take() {
    mkdir $1
    cd $1
}

autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "'"
zstyle ':vcs_info:*' stagedstr '°'

VCS_PATH='%%B%%F{blue}%R/%%U%S%%u'
VCS_BRANCH='%%B%%F{green}%b%%F{yellow}%u%c%%b'

zstyle ':vcs_info:*' nvcsformats "%B%F{blue}%3~%b%f "
zstyle ':vcs_info:*' formats "$VCS_PATH $VCS_BRANCH "
zstyle ':vcs_info:*' actionformats "$VCS_PATH $VCS_BRANCH %%F{red}(%a)%%f "

precmd () {
    vcs_info
}

USER=""
if [ "$(whoami)" != "$DEFAULT_USER" ]; then
    USER="%n@"
fi

typeset -Ag FG BG
for color in {0..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

# credits for this go to @Valodim
function t2cc {
  # get a number from the sha1 hash of the hostname
  sum=$(echo "$1" | sha1sum | tr -c -d 123456789 | tail -c 15 -)
  # divide by 256/88/8/whatever
  sum=$(( $sum % $(echotc Co) ))
  echo $sum
}

HOSTNAME=""
if [ "$(hostname)" != "$DEFAULT_HOSTNAME" ]; then
    HOSTCOLOR=$FG[$(t2cc $(hostname))]
    HOSTNAME="%{${HOSTCOLOR}%}%M:"
fi

setopt prompt_subst
PROMPT='${USER}${HOSTNAME}${${vcs_info_msg_0_/\/%U.%u / }/$HOME/~}%f'

zstyle ':completion:*' menu select
setopt completealiases

bindkey -v

bindkey "^[[3~" delete-char             # Del
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey "^R" history-incremental-search-backward

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
