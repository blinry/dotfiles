let
  associations = {
    "eog" = [ "image/png" "image/jpeg" "image/gif" ];
    "inkscape" = [ "image/svg+xml" ];
    "mpv" = [ "video/mp4" "video/mpeg" ];
    "org.gnome.Evince" = [ "application/pdf" ];
  };
in
builtins.listToAttrs (builtins.concatMap
  (name:
    builtins.map (ext: { name = ext; value = "${name}.desktop"; }) (builtins.getAttr name associations))
  (builtins.attrNames associations))
