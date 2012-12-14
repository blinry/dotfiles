source ~/.shellrc

autoload -U compinit promptinit
compinit
promptinit

autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "'"
zstyle ':vcs_info:*' stagedstr '°'

VCS_PATH='%%B%%F{blue}%R/%%U%S%%u'
VCS_BRANCH='%%B%%F{green}%b%%F{yellow}%u%c%%b'

zstyle ':vcs_info:*' nvcsformats "%F{blue}%3~%f "
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
PROMPT='${USER}${HOSTNAME}${${vcs_info_msg_0_/\/%U./}/$HOME/~}%f'

zstyle ':completion:*' menu select
setopt completealiases

bindkey "^[[3~" delete-char             # Del
bindkey "^[[7~" beginning-of-line       # Pos1
bindkey "^[[8~" end-of-line             # End
