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
    programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

    # ============================================
    # XDG PORTAL
    # ============================================
    xdg.portal = {
      enable = mkDefault true;
      extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
    };
  };
}
