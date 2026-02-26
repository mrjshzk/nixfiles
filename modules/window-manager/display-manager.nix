{
  config,
  lib,
  ...
}:
with lib; {
  config = mkIf (
    config.desktopEnvironments.hyprland.enable
    || config.desktopEnvironments.kde.enable
    || config.desktopEnvironments.gnome.enable
  ) {
    # ============================================
    # SDDM DISPLAY MANAGER
    # ============================================
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # ============================================
    # HARDWARE
    # ============================================
    hardware.graphics.enable = mkDefault true;
    hardware.graphics.enable32Bit = mkDefault true;
  };
}
