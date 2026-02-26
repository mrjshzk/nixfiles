{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkIf config.desktopEnvironments.kde.enable {
    # ============================================
    # KDE PLASMA 6
    # ============================================
    services.desktopManager.plasma6.enable = true;

    # ============================================
    # XDG PORTAL
    # ============================================
    xdg.portal = {
      enable = mkDefault true;
      extraPortals = [pkgs.xdg-desktop-portal-kde];
    };
  };
}
