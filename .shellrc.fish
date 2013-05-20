set USER_LINES (cat ~/.user.local | grep -v '^$' | sed 's/^/set /;s/=/ /')
for LINE in $USER_LINES
    eval "$LINE"
end

set -x FULLNAME "$FIRST_NAME $LAST_NAME"
set -x FIRST_NAME "$FIRST_NAME"
set -x LAST_NAME "$LAST_NAME"
set -x EMAIL "$EMAIL"
set -x LAT "$LAT"
set -x LON "$LON"
set -x DEFAULT_USER "$DEFAULT_USER"
set -x DEFAULT_HOSTNAME "$DEFAULT_HOSTNAME"

set -x GIT_AUTHOR_NAME "$FULLNAME"
set -x GIT_AUTHOR_EMAIL "$EMAIL"
set -x GIT_COMMITTER_NAME "$FULLNAME"
set -x GIT_COMMITTER_EMAIL "$EMAIL"

set -x PATH $HOME/.bin.local $HOME/.bin /usr/sbin $PATH
set -x EDITOR vim

set -x LANG en_US.UTF-8
set -x LC_TIME de_DE.UTF-8
set -x LC_PAPER de_DE.UTF-8
set -x LC_MONETARY de_DE.UTF-8

# Default permissions: rw(x)------
umask 0077

. ~/.aliases
if test -f ~/.aliases.local
    . ~/.aliases.local
end

if test -f ~/.shellrc.local
    . ~/.shellrc.fish.local
end
