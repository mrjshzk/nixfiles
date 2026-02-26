{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./hyprland.nix
    ./kde.nix
    ./gnome.nix
    ./display-manager.nix
  ];

  options = {
    desktopEnvironments = {
      hyprland.enable = mkEnableOption "Hyprland window manager";
      kde.enable = mkEnableOption "KDE Plasma 6 desktop environment";
      gnome.enable = mkEnableOption "GNOME desktop environment";
    };

    windowManager = {
      gaps = {
        inner = mkOption {
          type = types.int;
          default = 2;
          description = "Inner gaps between windows";
        };

        outer = mkOption {
          type = types.int;
          default = 5;
          description = "Outer gaps around windows";
        };
      };

      borderSize = mkOption {
        type = types.int;
        default = 1;
        description = "Border size for windows";
      };

      rounding = mkOption {
        type = types.int;
        default = 0;
        description = "Corner rounding for windows";
      };
    };
  };
}
