{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./hyprland.nix
  ];

  options.windowManager = {
    name = mkOption {
      type = types.enum [ "hyprland" "sway" "i3" "none" ];
      default = "hyprland";
      description = "The window manager to use";
    };

    isWayland = mkOption {
      type = types.bool;
      default = builtins.elem config.windowManager.name [ "hyprland" "sway" ];
      description = "Whether the window manager uses Wayland";
    };

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
      default = 2;
      description = "Border size for windows";
    };

    rounding = mkOption {
      type = types.int;
      default = 10;
      description = "Corner rounding for windows";
    };

    bar = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable a status bar";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.waybar;
        description = "The status bar package to use";
      };
    };

    wallpaper = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable wallpaper";
      };

      path = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Path to the wallpaper image";
      };
    };
  };
}
