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
    fd
    feh
    firefox
    fish
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
      enable = false;
    };

    starship.enable = true;

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
  };

  fonts.fontconfig.enable = true;
}
