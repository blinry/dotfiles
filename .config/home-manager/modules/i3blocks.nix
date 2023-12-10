{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.i3blocks;

in
{
  options = {
    programs.i3blocks = {
      enable = mkEnableOption "a feed generator for text based status bars";

      blocks = mkOption {
        type = with types; listOf (submodule {
          options = {
            name = mkOption {
              type = str;
            };
            config = mkOption {
              type = attrsOf (either str number);
            };
          };
        }
        );
        default = [ ];
        description = "list of block definitions";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.i3blocks;
        defaultText = literalExpression "pkgs.i3blocks";
        description = "i3blocks package to use.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."i3blocks/config".text =
      let
        section = n: v: "${n}=${toString v}";
      in
      concatMapStringsSep "\n"
        (
          b: "[${b.name}]\n" + (concatStringsSep "\n" (mapAttrsToList section b.config)) + "\n"
        )
        cfg.blocks;
  };
}
