# From https://github.com/izelnakri/home-manager/blob/main/modules/functions/wrap-nix-gl.nix
{ pkgs }:
pkg:
let
  bins = "${pkg}/bin";
in
pkgs.buildEnv {
  name = "nixGL-${pkg.name}";
  paths =
    [ pkg ] ++
    (map
      (bin: pkgs.hiPrio (
        pkgs.writeShellScriptBin bin ''
          exec -a "$0" "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel" "${bins}/${bin}" "$@"
        ''
      ))
      (builtins.attrNames (builtins.readDir bins)));
}
