{ config, pkgs, ... }:

let
  wrapNixGL = import ./wrap-nix-gl.nix { inherit pkgs; };
in
{
  home.stateVersion = "23.05";

  home.username = "blinry";
  home.homeDirectory = "/home/blinry";

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    LC_ALL = "en_US.UTF-8";
  };

  home.shellAliases = {
    # Systemd
    start = "sudo systemctl start";
    stop = "sudo systemctl stop";
    restart = "sudo systemctl restart";
    reload = "sudo systemctl reload";
    enable = "sudo systemctl enable";
    disable = "sudo systemctl disable";
    state = "sudo systemctl status";

    # Arch Linux
    p = "sudo pacman -Ss";
    pin = "sudo pacman -S";
    pup = "sudo pacman -Su";
    pout = "sudo pacman -Rcs";
    y = "yay";

    # Git
    ga = "git add";
    gc = "git commit";
    gca = "git commit -a";
    gcaa = "git commit -a --amend";
    gco = "git checkout";
    gd = "git diff";
    gg = "git graph";
    gs = "git status --short";

    # Modern alternatives
    l = "exa -al --time-style=long-iso --sort=modified";

    # Set default options for some tools
    vi = "nvim";
    vim = "nvim";
    ls = "ls --color=auto -tr -N";
    grep = "grep --color=auto";
    egrep = "egrep --color=auto";
    df = "df -h";
    free = "free -h";
    maim = "maim -s --hidecursor";
    sm = "sm -f white -b black ''";
    gdb = "gdb -q";
    ffprobe = "ffprobe -hide_banner";
    ffmpeg = "ffmpeg -hide_banner";
    dmesg = "sudo dmesg -Hw";

    # Lazyness
    chx = "chmod u+x";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    x = "exec startx";
    die = "sudo shutdown -h now";
    zzz = "systemctl suspend";
    reboot = "sudo reboot";
    pt = "sudo powertop";
    si = "sudo vim";
    vimrc = "vim -c \"e $MYVIMRC\"";
    yt = "yt-dlp";
    hs-disconnect = "bluetoothctl disconnect 20:74:CF:EB:43:EC";
    kanji = "evince ~/library/books/kklc.pdf";

    # Handy tools
    ducks = "du -cksh * | sort -h";
    ducksa = "du -cksh * .??* | sort -h";
    psgrep = "ps ax | grep ";
    ptest = "ping google.de";
    ja = "python -m jamdict lookup";
  };

  home.packages = with pkgs; [
    acpi
    anki
    arandr
    ardour
    audacity
    autorandr
    chromium
    curl
    dmenu
    evince
    eza
    fd
    feh
    firefox
    fzf
    gimp
    git
    gnome.eog
    gnuplot
    gopass
    gparted
    httpie
    inkscape
    libreoffice
    mblaze
    mpv
    mutt
    neovim
    nmap
    offlineimap
    prettierd
    prusa-slicer
    qbittorrent
    ripgrep
    rsync
    ruby
    signal-desktop
    visidata
    wireshark
    wget
    xcwd
  ] ++ (
    map wrapNixGL (with pkgs; [
      blender
    ])
  );

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
        set -gp PATH $HOME/.nix-profile/bin
        bind -M insert \cf forward-char
      '';
      functions = {
        fish_mode_prompt = "";
        take = "mkdir -p $argv; cd $argv";
        fish_prompt = ''
          echo -n (set_color blue --bold)
          echo -n (pwd | sed "s|^$HOME|~|")
          echo -n (set_color green --bold)
          if git rev-parse --git-dir &>/dev/null
              git diff --quiet HEAD &>/dev/null
              if test $status = 1
                  echo -n (set_color yellow --bold)
                  echo -n "'"
              end
          end
          echo -n " "
        '';
      };
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "blinry.org" = {
          user = "blinry";
        };
      };
    };

    broot = {
      enable = true;
      settings.verbs = [
        { key = "enter"; execution = "$EDITOR +{line} {file}"; }
      ];
    };

    direnv.enable = true;

    kitty = {
      enable = true;
      package = wrapNixGL pkgs.kitty;
      settings = {
        window_padding_width = 4;
        scrollback_lines = 100000;
        confirm_os_window_close = 0;
        resize_in_steps = true;
        color0 = "#202425";
        color1 = "#ff3333";
        color2 = "#307000";
        color3 = "#ce5c00";
        color4 = "#3465a4";
        color5 = "#75507b";
        color6 = "#06989a";
        color7 = "#d3d7cf";
        color8 = "#555753";
        color9 = "#ff5555";
        color10 = "#4e9a06";
        color11 = "#edd400";
        color12 = "#729fcf";
        color13 = "#ad7fa8";
        color14 = "#34e2e2";
        color15 = "#eeeeec";
      };
      font = {
        name = "monospace";
        size = 15;
      };
    };

    mpv = {
      enable = true;
      config = {
        save-position-on-quit = true;
        force-window = true;
        sub-font-size = 33;
        sub-pos = 93;
      };
      bindings = {
        LEFT = "no-osd sub-seek -1";
        RIGHT = "no-osd sub-seek 1";
        o = "script-message-to subloop replay-subtitle";
        l = "script-message-to subloop ab-loop-sub";
        #L = "script-message-to subloop ab-loop-sub pause";
      };
    };
  };

  fonts.fontconfig.enable = true;
}

