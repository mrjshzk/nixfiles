# common/hyprland.nix
{
  config,
  pkgs,
  ...
}: {
  # ============================================
  # WAYLAND/HYPRLAND ESSENTIALS
  # ============================================
  programs.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  environment.systemPackages = with pkgs; [
    # Hyprland essentials
    waybar # Status bar
    wofi # App launcher
    dunst # Notifications
    hyprpaper # Wallpaper daemon
    # TODO replace hyprlock
    kitty # Terminal
    starship
    wiremix
    clang
    tree-sitter
    luajitPackages.luarocks_bootstrap
    trashy
    glib
    kdePackages.kde-cli-tools
    git-spice
    tectonic
    mermaid-cli
    tree-sitter-grammars.tree-sitter-css
    lua

    # Screenshot tools
    grim # Screenshot utility
    slurp # Select screen region
    wl-clipboard # Clipboard utilities

    # File manager
    yazi # or dolphin, nautilus

    # Browsers
    librewolf

    # Other useful tools
    pavucontrol # Audio control
    brightnessctl # Screen brightness
    playerctl # Media control
  ];

  # ============================================
  # XDG PORTAL (for screen sharing, file pickers)
  # ============================================

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
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
}
