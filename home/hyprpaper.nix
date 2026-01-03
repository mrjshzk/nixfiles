{
  pkgs,
  config,
  ...
}:
let
  # Create a derivation that contains your wallpapers
  wallpaperDir = pkgs.runCommand "wallpapers" { } ''
    mkdir -p $out
    cp ${./backgrounds}/* $out/
  '';

  backgroundDir = "${wallpaperDir}";

  wallpapers = map (name: "${backgroundDir}/${name}") (
    builtins.attrNames (builtins.readDir wallpaperDir)
  );

  defaultWallpaper = "cat_at_play.png";
  defaultWallpaperPath = "${backgroundDir}/${defaultWallpaper}";

  monitors = [
    "eDP-1"
    "HDMI-A-1"
    "DP-3"
  ];
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = wallpapers;
      wallpaper = map (monitor: "${monitor},${defaultWallpaperPath}") monitors;
    };
  };
}
