{ osConfig, lib, ... }:
let

  monitors = [ "eDP-1" "HDMI-A-1" "DP-3" ];
in {
  services.hyprpaper =
    lib.mkIf (osConfig.core.wallpaper.command == "hyprpaper") {
      enable = true;
      settings = {
        preload = [ "~/backgrounds/nixos.png" ];
        wallpaper =
          map (monitor: "${monitor},~/backgrounds/nixos.png") monitors;
      };
    };
}
