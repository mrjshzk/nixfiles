{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkIf config.desktopEnvironments.hyprland.enable {
    # ============================================
    # WAYLAND/HYPRLAND ESSENTIALS
    # ============================================
    programs.hyprland = {enable = true;};

    # ============================================
    # XDG PORTAL (for screen sharing, file pickers)
    # ============================================

    xdg.portal = {
      enable = mkDefault true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "*";
    };

    # ============================================
    # ENVIRONMENT VARIABLES
    # ============================================

    environment.sessionVariables = {
      # Wayland
      NIXOS_OZONE_WL = "1"; # For Electron apps

      GTK_IM_MODULE = "simple";
    };
  };
}
