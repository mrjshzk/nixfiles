{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      colorSchemes.predefinedScheme = "Monochrome";
      location = {
        name = "Vila do Conde, Portugal";
      };
    };
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "~/backgrounds/cat_at_play.png";
      wallpapers = {
        "DP-1" = "~/backgrounds/cat_at_play.png";
      };
    };
  };
}
