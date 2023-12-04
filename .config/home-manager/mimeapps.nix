let
  associations = {
    "org.gnome.eog" = [ "image/png" "image/jpeg" "image/gif" ];
    "org.inkscape.Inkscape" = [ "image/svg+xml" ];
    "mpv" = [ "video/mp4" "video/mpeg" ];
    "org.gnome.Evince" = [ "application/pdf" ];
    "firefox" = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ];
    "org.qbittorrent.qBittorrent" = [ "x-scheme-handler/magnet" ];
  };
in
builtins.listToAttrs (builtins.concatMap
  (name:
    builtins.map (ext: { name = ext; value = "${name}.desktop"; }) (builtins.getAttr name associations))
  (builtins.attrNames associations))
