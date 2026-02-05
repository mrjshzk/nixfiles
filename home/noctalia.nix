{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      colorSchemes.predefinedScheme = "GitHub Dark";
      location = {
        name = "Vila do Conde, Portugal";
      };
      bar = {
        position = "bottom";
        floating = false;
        marginVertical = 4;
        marginHorizontal = 4;
      };
    };
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/mrjshzk/backgrounds/pixel.png";
      wallpapers = {
        "DP-1" = "/home/mrjshzk/backgrounds/pixel.png";
        "eDP-1" = "/home/mrjshzk/backgrounds/pixel.png";
      };
    };
  };
}
