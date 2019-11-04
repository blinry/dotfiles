set USER_LINES (cat ~/.user | grep -v '^$' | sed 's/^/set /;s/=/ /')
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

set -x PATH $HOME/wip/wit $HOME/wip/minitools/target/debug $HOME/wip/timelens/timelens/target/debug $HOME/permanent/habitctl/target/debug $HOME/.bin $HOME/.cargo/bin/ (ruby -e 'print Gem.user_dir')/bin /usr/bin/vendor_perl/ $PATH
set -x EDITOR nvim
set -x TERMINAL termite
set -x BROWSER chromium

set -x FZF_DEFAULT_COMMAND "rg --files"
fzf_key_bindings

set -x LANG en_US.UTF-8
set -x LC_TIME de_DE.UTF-8
set -x LC_PAPER de_DE.UTF-8
set -x LC_MONETARY de_DE.UTF-8

set -e GREP_OPTIONS

# Default permissions: rw(x)------
umask 0077

set fish_greeting

complete -c wiki -a '(pushd .; cd ~/permanent/wiki; ls; popd)'
complete -c pf -a '(pushd .; cd ~/permanent/pf-wiki; ls; popd)'

function take
    mkdir -p $argv
    cd $argv
end

function unwrap
    set DIR (aunpack -q "$argv" 2>&1 | grep -Po "(?<=\`).*(?=')")
    if test -d "$DIR"
        rm "$argv"
        cd "$DIR"
    end
end

. ~/.aliases
