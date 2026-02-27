{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkIf config.desktopEnvironments.gnome.enable {
    # ============================================
    # GNOME
    # ============================================
    services.desktopManager.gnome.enable = true;

    # ============================================
    # XDG PORTAL
    # ============================================
    xdg.portal = {
      enable = mkDefault true;
      extraPortals = [pkgs.xdg-desktop-portal-gnome];
    };

    # ============================================
    # REDUCE BLOAT
    # ============================================
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      epiphany
      geary
      gnome-music
    ];
  };
}
