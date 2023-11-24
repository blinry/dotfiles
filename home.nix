{ config, pkgs, ... }:

let
  nixGLIntel = (pkgs.callPackage "${builtins.fetchTarball {
      url = https://github.com/nix-community/nixGL/archive/489d6b095ab9d289fe11af0219a9ff00fe87c7c5.tar.gz;
      sha256 = "03kwsz8mf0p1v1clz42zx8cmy6hxka0cqfbfasimbj858lyd930k";
    }}/nixGL.nix"
    { }).nixGLIntel;
  wrapGL = pkg:
    pkgs.writeShellScriptBin (pkgs.lib.getName pkg) ''
      ${nixGLIntel}/bin/nixGLIntel ${pkgs.lib.getExe pkg} "$@"
    '';
in
{
  home.username = "blinry";
  home.homeDirectory = "/home/blinry";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    anki
    arandr
    ardour
    audacity
    autorandr
    chromium
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
    httpie
    inkscape
    libreoffice
    mblaze
    neovim
    nmap
    offlineimap
    ripgrep
    rsync
    ruby
    xcwd
    prusa-slicer
    mpv
  ] ++ (
    map wrapGL (with pkgs; [
      blender
    ])
  );

  home.stateVersion = "23.05";

  programs = {
    home-manager.enable = true;

    fish = {
      enable = false;
      plugins = [
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
          };
        }
      ];
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
      package = wrapGL pkgs.kitty;
      settings = {
        window_padding_width = 4;
        scrollback_lines = 100000;
        confirm_os_window_close = 0;
        resize_in_steps = true;
        color0 = "#202425";
        color8 = "#555753";
        color1 = "#ff3333";
        color9 = "#ff5555";
        color2 = "#307000";
        color10 = "#4e9a06";
        color3 = "#ce5c00";
        color11 = "#edd400";
        color4 = "#3465a4";
        color12 = "#729fcf";
        color5 = "#75507b";
        color13 = "#ad7fa8";
        color6 = "#06989a";
        color14 = "#34e2e2";
        color7 = "#d3d7cf";
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
