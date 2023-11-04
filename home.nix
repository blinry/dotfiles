{ config, pkgs, ... }:

{
  home.username = "blinry";
  home.homeDirectory = "/home/blinry";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}

