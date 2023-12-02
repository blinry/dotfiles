{ pkgs, nom, ... }:

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

  xresources.properties = {
    "Xft.dpi" = 192;
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
    calibre
    chromium
    curl
    digikam
    dmenu
    evince
    eza
    fd
    feh
    ffmpeg
    fzf
    gimp
    gnome.cheese
    gnome.eog
    gnupg
    gnuplot
    gopass
    gparted
    httpie
    inkscape
    krita
    libreoffice
    maim
    mblaze
    mutt
    neovim
    nmap
    prettierd
    prusa-slicer
    qbittorrent
    ripgrep
    rsync
    ruby
    scrcpy
    shellcheck
    signal-desktop
    termdown
    visidata
    wireshark
    wget
    xcwd
  ] ++ (
    map wrapNixGL (with pkgs; [
      blender
    ])
  ) ++ [
    nom
  ];

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      shellInit = ''
        set -gp PATH $HOME/.nix-profile/bin
        set -gp PATH $HOME/.bin
        bind -M insert \cf forward-char
        bind -M insert \cp fzfcd
      '';
      functions = {
        fish_greeting = "";
        fish_mode_prompt = "";
        fish_title = "prompt_pwd";
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
        unwrap = ''
          set DIR (aunpack -q "$argv" 2>&1 | grep -Po "(?<=\`).*(?=')")
          if test -d "$DIR"
              rm "$argv"
              cd "$DIR"
          end
        '';
        fzfcd = ''
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
        '';
      };
    };

    git = {
      enable = true;
      userName = "blinry";
      userEmail = "mail@blinry.org";
      aliases = {
        graph = "log --graph --pretty=oneline --abbrev-commit --all --decorate";
        take = "checkout -b";
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

    firefox = {
      enable = true;
      profiles.blinry = {
        path = "7zkoarj1.blinry";
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          privacy-badger
          browserpass
          sponsorblock
          firefox-color
          refined-github
        ];
        search = {
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
          };
        };
      };
    };

    browserpass.enable = true;

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

    offlineimap.enable = true;
    msmtp.enable = true;
    notmuch.enable = true;
    neomutt.enable = true;

    vdirsyncer.enable = true;
    khal.enable = true;
    khard.enable = true;

    autorandr = import ./autorandr.nix;
  };

  accounts = {
    email = {
      maildirBasePath = "permanent/mail";
      accounts = {
        blinry = {
          address = "mail@blinry.org";
          primary = true;
          realName = "blinry";
          userName = "blinry";
          passwordCommand = "gopass show blinry.org/blinry";
          maildir.path = ".";

          folders = {
            inbox = "INBOX";
            drafts = "Drafts";
            trash = "Junk";
            sent = "Sent";
          };

          imap = {
            host = "blinry.org";
            port = 993;
          };

          smtp = {
            host = "blinry.org";
            port = 587;
            tls.useStartTls = true;
          };

          msmtp.enable = true;
          offlineimap.enable = true;
          notmuch.enable = true;
          neomutt.enable = true;
        };
      };
    };
    calendar = {
      accounts = {
        blinry = {
          primary = true;
          primaryCollection = "calendar";
          local = {
            fileExt = ".ics";
            path = "~/permanent/calendar";
            type = "filesystem";
          };
          remote = {
            url = "https://cal.blinry.org";
            userName = "blinry";
            type = "caldav";
            passwordCommand = [ "gopass" "show" "-o" "cal.blinry.org" ];
          };
          vdirsyncer = {
            enable = true;
            metadata = [ "color" "displayname" ];
          };
          khal = {
            enable = true;
            type = "discover";
          };
        };
      };
    };
    contact = {
      accounts = {
        blinry = {
          local = {
            path = "~/permanent/contacts";
            type = "filesystem";
            fileExt = ".vcf";
          };
          remote = {
            url = "https://cal.blinry.org/025d65a1-0209-1c28-b394-38ea87a4ef08/";
            userName = "blinry";
            type = "carddav";
            passwordCommand = [ "gopass" "show" "-o" "cal.blinry.org" ];
          };
          vdirsyncer.enable = true;
          khard.enable = true;
        };
      };
    };
  };

  fonts.fontconfig.enable = true;
}

