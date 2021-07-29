set USER_LINES (cat ~/.user | grep -v '^$' | sed 's/^/set /;s/=/ /')
for LINE in $USER_LINES
    eval "$LINE"
end

set -x FULLNAME "$FULLNAME"
set -x EMAIL "$EMAIL"
set -x LAT "$LAT"
set -x LON "$LON"
set -x DEFAULT_USER "$DEFAULT_USER"
set -x DEFAULT_HOSTNAME "$DEFAULT_HOSTNAME"

set -x GIT_AUTHOR_NAME "$FULLNAME"
set -x GIT_AUTHOR_EMAIL "$EMAIL"
set -x GIT_COMMITTER_NAME "$FULLNAME"
set -x GIT_COMMITTER_EMAIL "$EMAIL"

set -x PATH $HOME/wip/wit $HOME/wip/minitools/target/debug $HOME/wip/timelens/timelens/target/debug $HOME/permanent/habitctl/target/debug $HOME/.bin $HOME/.cargo/bin/ (ruby -e 'print Gem.user_dir')/bin /usr/bin/vendor_perl/ $HOME/.cabal/bin/ $HOME/.npm-packages/bin $PATH
set -x EDITOR nvim
set -x TERMINAL alacritty
set -x BROWSER chromium

set -x FZF_DEFAULT_COMMAND "rg --files"

# This fixes a Blender bug on Intel.
set -x MESA_LOADER_DRIVER_OVERRIDE i965

set -x LANG en_US.UTF-8
set -x LC_TIME de_DE.UTF-8
set -x LC_PAPER de_DE.UTF-8
set -x LC_MONETARY de_DE.UTF-8

set -e GREP_OPTIONS

# Default permissions: rw(x)------
umask 0077

# Use dircolors template
eval (dircolors -c ~/.dircolors)

set fish_greeting

function fish_mode_prompt
end

complete -c w -a '(pushd .; cd ~/permanent/wiki; ls; popd)'
complete -c pf -a '(pushd .; cd ~/permanent/pf2-wiki; ls; popd)'

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

function fzfcd
    cd ~

    # Select from everything not ignored, and not unignored by ~/.fdignore
    fd -H -d5 -E /permanent/mail/ | sort -V | fzf | read SELECTION

    # And perform an appropriate action
    if test -d "$SELECTION"
        cd "$SELECTION"
    else if test -e "$SELECTION"
        cd (dirname "$SELECTION")
        cd (git rev-parse --show-toplevel)
        vim ~/"$SELECTION"
    else
        cd -
    end

    commandline -f force-repaint
end

for mode in insert default visual
    bind -M $mode \cp fzfcd
    bind -M $mode \cf forward-char
end

. ~/.aliases
