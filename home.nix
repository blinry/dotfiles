{ config, pkgs, ... }:

{
  home.username = "blinry";
  home.homeDirectory = "/home/blinry";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.chromium
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.kitty =
    let nixGLIntel = (pkgs.callPackage "${builtins.fetchTarball {
      url = https://github.com/nix-community/nixGL/archive/489d6b095ab9d289fe11af0219a9ff00fe87c7c5.tar.gz;
      sha256 = "03kwsz8mf0p1v1clz42zx8cmy6hxka0cqfbfasimbj858lyd930k";
    }}/nixGL.nix"
      { }).nixGLIntel;
    in
    {
      enable = true;
      package =
        pkgs.writeShellScriptBin "kitty" ''
          #!/bin/sh

          ${nixGLIntel}/bin/nixGLIntel ${pkgs.kitty}/bin/kitty "$@"
        '';
      settings = {
        window_padding_width = 4;
        scrollback_lines = 100000;
        confirm_os_window_close = 0;
        resize_in_steps = true;
      };
      font = {
        name = "monospace";
        size = 15;
      };
      theme = "Tango Dark";
    };
}
