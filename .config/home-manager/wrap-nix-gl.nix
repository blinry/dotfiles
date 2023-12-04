## From https://github.com/izelnakri/home-manager/blob/main/modules/functions/wrap-nix-gl.nix
#{ pkgs }:
#pkg:
#let
#  bins = "${pkg}/bin";
#in
#pkgs.buildEnv {
#  name = "nixGL-${pkg.name}";
#  paths =
#    [ pkg ] ++
#    (map
#      (bin: pkgs.hiPrio (
#        pkgs.writeShellScriptBin bin ''
#          exec -a "$0" "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel" "${bins}/${bin}" "$@"
#        ''
#      ))
#      (builtins.attrNames (builtins.readDir bins)));
#}

# From https://github.com/nix-community/nixGL/issues/114#issuecomment-1585323281
{ pkgs }:

# Wrap a single package
pkg:

# Wrap the package's binaries with nixGL, while preserving the rest of
# the outputs and derivation attributes.
pkg.overrideAttrs (old: {
  name = "nixGL-${pkg.name}";
  buildCommand = ''
    set -eo pipefail

    ${
    # Heavily inspired by https://stackoverflow.com/a/68523368/6259505
    pkgs.lib.concatStringsSep "\n" (map (outputName: ''
      echo "Copying output ${outputName}"
      set -x
      cp -rs --no-preserve=mode "${pkg.${outputName}}" "''$${outputName}"
      set +x
    '') (old.outputs or [ "out" ]))}

    rm -rf $out/bin/*
    shopt -s nullglob # Prevent loop from running if no files
    for file in ${pkg.out}/bin/*; do
      echo "#!${pkgs.bash}/bin/bash" > "$out/bin/$(basename $file)"
      echo "exec -a \"\$0\" ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel $file \"\$@\"" >> "$out/bin/$(basename $file)"
      chmod +x "$out/bin/$(basename $file)"
    done
    shopt -u nullglob # Revert nullglob back to its normal default state
  '';
})
