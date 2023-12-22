{ pkgs, nom, ... }:

let
  wrapNixGL = pkgs.callPackage (import ./wrap-nix-gl.nix) { };
  screens = import ./screens.nix;
in
{
  home.stateVersion = "23.11";

  home.username = "blinry";
  home.homeDirectory = "/home/blinry";

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  home.language =
    let native = "de_DE.UTF-8";
    in
    {
      base = "en_US.UTF-8";
      address = native;
      measurement = native;
      monetary = native;
      paper = native;
      telephone = native;
      time = native;
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
    l = "eza -al";

    # Set default options for some tools
    vi = "nvim";
    vim = "nvim";
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

  home.packages = with pkgs;
    let
      flattenValues = attrSet: lib.flatten (lib.attrValues attrSet);
    in
    flattenValues {
      commandline = [
        curl
        fd
        ripgrep
        rsync
        wget
      ];
      misc = [
        acpi
        anki
        arandr
        ardour
        audacity
        calibre
        chromium
        digikam
        dmenu
        evince
        feh
        ffmpeg
        foliate
        gimp
        gnome.cheese
        gnome.eog
        gnupg
        gnuplot
        gopass
        gparted
        httpie
        imagemagick
        inkscape
        krita
        libreoffice
        libresprite
        love
        magic-wormhole
        maim
        mblaze
        mullvad-vpn
        mumble
        neovim
        nmap
        prettierd
        prusa-slicer
        qbittorrent
        redshift
        scrcpy
        screen-message
        shellcheck
        signal-desktop
        steam
        strace
        termdown
        texlive.combined.scheme-small
        visidata
        wineWowPackages.stable
        wireshark
        xclip
        xcwd
        xdg-utils
        yt-dlp
      ];
      opengl = map wrapNixGL [
        blender
      ];
      dev = [
        nodejs
        python3
        ruby
        stylua
      ];
      languageservers = [
        nodePackages.svelte-language-server
        nodePackages.typescript-language-server
        rust-analyzer
        vscode-langservers-extracted
      ];
      fonts = [
        font-awesome
      ];
      my-tools = [
        nom
      ];
    };

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      shellInit = ''
        set -gpx PATH $HOME/.nix-profile/bin
        set -gpx PATH $HOME/.bin

        bind -M insert \cf forward-char
        bind -M default \cp fzfcd
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
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
      aliases = {
        graph = "log --graph --pretty=oneline --abbrev-commit --all --decorate";
        take = "checkout -b";
      };
      ignores = [
        ".direnv/"
      ];
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
        enable_audio_bell = false;
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
      extraConfig = ''
        visual_bell_duration 0.1
      '';
    };

    firefox = {
      enable = true;
      package = wrapNixGL pkgs.firefox;
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

    neomutt =
      {
        enable = true;
        sort = "reverse-date-received";
        settings = {
          edit_headers = "yes"; # Show headers when composing.
          fast_reply = "yes"; # Skip to compose when replying
          date_format = "'%Y-%m-%d'";
          index_format = "'%Z %D %-20.20F %s'";
        };
        extraConfig = ''
          color normal default default
          color indicator default green
          color status brightwhite blue
          color tree green default
          color header green default .
        '';
        macros = [
          {
            map = [ "index" ];
            key = "O";
            action = "<shell-escape>PYTHONDONTWRITEBYTECODE='Y' offlineimap<enter>";
          }
          {
            map = [ "index" ];
            key = "o";
            action = "<shell-escape>PYTHONDONTWRITEBYTECODE='Y' offlineimap -qf INBOX<enter>";
          }
          {
            map = [ "index" ];
            key = "A";
            action = ":set confirmappend=no\\n<save-message>=Archive\\n:set confirmappend=yes\\n";
          }
          {
            map = [ "index" ];
            key = "S";
            action = ":set confirmappend=no\\n<save-message>=Junk\\n:set confirmappend=yes\\n";
          }
        ];
      };

    vdirsyncer.enable = true;
    khal.enable = true;
    khard.enable = true;

    autorandr = import ./autorandr.nix;

    i3blocks = {
      enable = true;
      blocks = [
        {
          name = "mpd";
          config = {
            command = "mpd-status";
            interval = 1;
            signal = 2;
          };
        }
        {
          name = "todo";
          config = {
            command = "todo-status";
            interval = 60;
          };
        }
        {
          name = "mail";
          config = {
            command = "echo $(mlist ~/permanent/mail/INBOX | wc -l) mails";
            interval = 60;
          };
        }
        {
          name = "wifi";
          config = {
            command = "wifi-status";
            interval = 60;
          };
        }
        {
          name = "volume";
          config = {
            command = "audio-status";
            interval = "once";
            signal = 1;
          };
        }
        {
          name = "battery";
          config = {
            command = "battery-status";
            interval = 60;
          };
        }
        {
          name = "battery2";
          config = {
            command = "battery-status-2";
            interval = 60;
          };
        }
        {
          name = "worldclock";
          config = {
            command = "worldclock";
            interval = 1;
          };
        }
        {
          name = "time";
          config = {
            command = "date +\"%Y-%m-%d %H:%M \"";
            interval = 1;
          };
        }
      ];
    };

    eza = {
      enable = true;
      enableAliases = true;
      extraOptions = [
        "--time-style=long-iso"
        "--sort=modified"
      ];
    };

    fzf = {
      enable = true;
    };

    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          height = 25;
          spacing = 15;

          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
          ];
          modules-right = [
            "network"
            "battery"
            "tray"
            "clock#date"
            "clock#time"
          ];

          network = {
            interval = 5;
            format-wifi = "{essid}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr}";
            format-disconnected = "(disconnected)";
            tooltip-format = "{ifname}: {ipaddr}";
          };

          "clock#date" = {
            format = "{:%Y-%m-%d}";
          };
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 0;
          padding: 0;
        }

        #waybar {
          background: black;
          color: white;
          font-family: Iosevka Nerd Font;
          font-size: 16px;
        }

        #workspaces button {
          color: #444;
        }

        #workspaces button.active {
          color: white;
        }
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = wrapNixGL pkgs.hyprland;
    settings =
      let
        mod = "super";
      in
      {
        exec-once = map pkgs.lib.meta.getExe (with pkgs; [ hyprpaper swaynotificationcenter waybar ]);

        general = {
          gaps_in = 4;
          gaps_out = 6;
          border_size = 0;
          layout = "dwindle";
        };

        input = {
          kb_layout = "blinry";
          scroll_method = "edge";
        };

        decoration = {
          rounding = 10;
        };

        dwindle = {
          preserve_split = true;
        };

        bind =
          [
            "${mod}, return, exec, kitty"
            "${mod}, f1, exec, firefox"
            "${mod}, f2, exec, kitty --working-directory=$HOME/tmp neomutt"
            "${mod}, f4, exec, kitty ncmpcpp"
            "${mod}, f5, exec, signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland"
            "${mod}, f6, exec, pavucontrol"

            "${mod}, h, movefocus, l"
            "${mod}, j, movefocus, d"
            "${mod}, k, movefocus, u"
            "${mod}, l, movefocus, r"

            "${mod} shift, h, movewindow, l"
            "${mod} shift, j, movewindow, d"
            "${mod} shift, k, movewindow, u"
            "${mod} shift, l, movewindow, r"

            "${mod}, d, killactive"
            "${mod}, f, fullscreen"
            "${mod}, v, togglesplit" # Doesn't work?

            ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
            ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
          ] ++ builtins.concatLists
            (map
              (n: [
                "${mod}, ${n}, workspace, ${n}"
                "${mod} shift, ${n}, movetoworkspace, ${n}"
              ])
              (map toString (pkgs.lib.lists.range 1 9)));

        bindm = [
          "${mod}, mouse:272, movewindow"
          "${mod}, mouse:273, resizewindow"
        ];
      };
    extraConfig = ''
    '';
  };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config =
        let
          mod = "Mod4";
          fonts = {
            names = [ "monospace" ];
            size = 11.0;
          };
          colors = {
            bg = "#000000";
            tx = "#ffffff";
            ac = "#005500";
            gr = "#555555";
            rd = "#aa0000";
          };
        in
        {
          modifier = mod; # Win key (but I usually swap Alt and Win via setxkbmap)
          inherit fonts;
          floating = {
            modifier = mod;
          };
          assigns = {
            "5" = [{
              class = "Signal";
            }];
          };
          bars =
            [
              {
                command = "i3bar";
                position = "bottom";
                statusCommand = "${pkgs.i3blocks}/bin/i3blocks";
                inherit fonts;
                colors = {
                  background = colors.bg;
                  statusline = colors.tx;
                  focusedWorkspace = {
                    background = colors.bg;
                    border = colors.bg;
                    text = colors.tx;
                  };
                  activeWorkspace = {
                    background = colors.bg;
                    border = colors.bg;
                    text = colors.tx;
                  };
                  inactiveWorkspace = {
                    background = colors.bg;
                    border = colors.bg;
                    text = colors.gr;
                  };
                  urgentWorkspace = {
                    background = colors.rd;
                    border = colors.rd;
                    text = colors.tx;
                  };
                  separator = colors.gr;
                };
              }
            ];
          #colors = { };
          keybindings =
            pkgs.lib.mkOptionDefault
              {
                "${mod}+Return" = "exec kitty --working-directory=\"`xcwd`\"";
                "${mod}+d" = "kill";
                "${mod}+p" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run -b -fn \"monospace-12\" -nb \"${colors.bg}\" -sf \"${colors.tx}\" -sb \"${colors.bg}\" -nf \"${colors.gr}\"";

                "${mod}+h" = "focus left";
                "${mod}+j" = "focus down";
                "${mod}+k" = "focus up";
                "${mod}+l" = "focus right";

                "${mod}+Shift+h" = "move left";
                "${mod}+Shift+j" = "move down";
                "${mod}+Shift+k" = "move up";
                "${mod}+Shift+l" = "move right";

                "${mod}+Control+h" = "resize shrink width 10 px or 10 ppt";
                "${mod}+Control+j" = "resize grow height 10 px or 10 ppt";
                "${mod}+Control+k" = "resize shrink height 10 px or 10 ppt";
                "${mod}+Control+l" = "resize grow width 10 px or 10 ppt";

                "${mod}+F1" = "exec firefox";
                "${mod}+F2" = "exec kitty --working-directory=$HOME/tmp neomutt";
                "${mod}+F3" = "exec kitty nvim -S ~/.local/share/nvim/sessions/plans.vim";
                "${mod}+F4" = "exec kitty ncmpcpp";
                "${mod}+F5" = "exec signal-desktop";
                "${mod}+F6" = "exec pavucontrol";

                "XF86AudioLowerVolume" = "exec pamixer --allow-boost -d 5 && pkill -RTMIN+1 i3blocks";
                "XF86AudioRaiseVolume" = "exec pamixer --allow-boost -i 5 && pkill -RTMIN+1 i3blocks";
                "XF86AudioMute" = "exec pamixer -t && pkill -RTMIN+1 i3blocks";
                "XF86MonBrightnessUp" = "exec sudo xbacklight -inc 5";
                "XF86MonBrightnessDown" = "exec sudo xbacklight -dec 5";

                "Print" = "exec screenshot";
                "Control+Print" = "exec screencast";

                "${mod}+Down" = "exec mpc toggle && pkill -RTMIN+2 i3blocks";
                "${mod}+Right" = "exec mpc next && pkill -RTMIN+2 i3blocks";
                "${mod}+Left" = "exec mpc prev && pkill -RTMIN+2 i3blocks";
                "${mod}+Next" = "exec mpc seek +30 && pkill -RTMIN+2 i3blocks";
                "${mod}+Prior" = "exec mpc seek -30 && pkill -RTMIN+2 i3blocks";

                "${mod}+c" = "exec middlec";

                "${mod}+b" = "bar mode toggle";
              };
          workspaceOutputAssign = [
            {
              workspace = "1";
              output = screens.side.name;
            }
            {
              workspace = "2";
              output = screens.side.name;
            }
            {
              workspace = "3";
              output = screens.center.name;
            }
            {
              workspace = "4";
              output = screens.center.name;
            }
            {
              workspace = "5";
              output = screens.notebook.name;
            }
            {
              workspace = "6";
              output = screens.notebook.name;
            }
          ];
          startup = map (p: { command = p; notification = false; }) [ "kitty" "dunst" "udiskie -nas" "redshift" "mpd" "unclutter --hide-on-touch" "init-mouse" ];
          window =
            {
              titlebar = false;
            };
          workspaceAutoBackAndForth = true;
        };
      extraConfig = ''
        new_window pixel 0
        new_float pixel 0
        popup_during_fullscreen smart
      '';
    };
  };

  services = {
    autorandr.enable = true;
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
          passwordCommand = "gopass show -o blinry.org/blinry";
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

  xdg = {
    enable = true;
    systemDirs = {
      data = [ "$HOME/.nix-profile/share" ];
    };
    userDirs =
      {
        enable = true;
        desktop = "$HOME/tmp";
        documents = "$HOME/tmp";
        download = "$HOME/tmp";
        music = "$HOME/library/music";
        pictures = "$HOME/tmp";
        publicShare = "$HOME/tmp";
        templates = "$HOME/tmp";
        videos = "$HOME/tmp";
      };
    mimeApps = {
      enable = true;
      defaultApplications = import ./mimeapps.nix;
    };
  };

  fonts.fontconfig.enable = true;
}

