{ config, lib, pkgs, ... }:

with lib;

{
  config = mkIf (config.windowManager.name == "hyprland") {

    # ============================================
    # GREETD LOGIN MANAGER
    # ============================================
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/hyprland";
          user = "mrjshzk";
        };
        default_session = initial_session;
      };
    };
    # ============================================
    # WAYLAND/HYPRLAND ESSENTIALS
    # ============================================
    programs.hyprland = { enable = true; };

    # ============================================
    # XDG PORTAL (for screen sharing, file pickers)
    # ============================================

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };

    # ============================================
    # ENVIRONMENT VARIABLES
    # ============================================

    environment.sessionVariables = {
      # Wayland
      NIXOS_OZONE_WL = "1"; # For Electron apps

      # XDG
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };

    # ============================================
    # HARDWARE
    # ============================================
    hardware.graphics.enable32Bit = true;
    hardware.graphics.enable = true;

  };
}
