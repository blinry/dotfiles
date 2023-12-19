let
  screens = import ./screens.nix;
  sideBySide = list: {
    fingerprint = builtins.listToAttrs (builtins.map (screen: { name = screen.name; value = screen.fingerprint; }) list);
    config =
      let buildConfigHelper = acc: elem:
        let scale = elem.scale or 1; in
        {
          config = acc.config // {
            ${elem.name} = {
              enable = true;
              mode = "${toString elem.width}x${toString elem.height}";
              position = "${toString acc.totalWidth}x0";
              scale = {
                x = scale;
                y = scale;
              };
            };
          };
          totalWidth = builtins.ceil (acc.totalWidth + elem.width * scale);
        };
      in (builtins.foldl' buildConfigHelper { config = { }; totalWidth = 0; } list).config;
  };
in
{
  enable = true;
  profiles = {
    single = sideBySide [ screens.notebook ];
    triple = sideBySide [ screens.side screens.center screens.notebook ];
  };
}
