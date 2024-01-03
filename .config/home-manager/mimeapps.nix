let
  associations = {
    "nvim" = [ "text/plain" ];
    "org.gnome.eog" = [ "image/png" "image/jpeg" "image/gif" ];
    "org.inkscape.Inkscape" = [ "image/svg+xml" ];
    "mpv" = [ "video/mp4" "video/mpeg" "audio/mpeg" ];
    "firefox" = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" "application/pdf" ];
    "org.qbittorrent.qBittorrent" = [ "x-scheme-handler/magnet" ];
    "com.github.johnfactotum.Foliate" = [ "application/epub+zip" ];
    "writer" = [ "application/vnd.oasis.opendocument.text" ];
    "calc" = [ "application/vnd.oasis.opendocument.spreadsheet" ];
    "impress" = [ "application/vnd.oasis.opendocument.presentation" ];
  };
in
builtins.listToAttrs (builtins.concatMap
  (name:
    builtins.map (ext: { name = ext; value = "${name}.desktop"; }) (builtins.getAttr name associations))
  (builtins.attrNames associations))
