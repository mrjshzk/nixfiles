# common/common. nix
{
  config,
  pkgs,
  ...
}: {
  # ============================================
  # SYSTEM BASICS
  # ============================================

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixxy";

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };
  # ============================================
  # USERS
  # ============================================

  users.users.mrjshzk = {
    # Your username
    isNormalUser = true;
    description = "Miguel Silva";
    extraGroups = ["networkmanager" "wheel" "video" "audio"];
    shell = pkgs.bash;
  };

  # ============================================
  # SYSTEM PACKAGES
  # ============================================

  environment.systemPackages = with pkgs; [
    # Essential tools
    wget
    curl
    git
    # File management
    unzip
    zip

    # System utilities
    pciutils
    usbutils

    # Login
    wayland
    wayland-protocols
  ];

  # ============================================
  # NIX SETTINGS
  # ============================================

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # ============================================
  # AUDIO
  # ============================================

  # PipeWire (modern audio system)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse. enable = true;
    jack. enable = true;
  };

  # ============================================
  # FONTS
  # ============================================

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    font-awesome
    fira-code
    jetbrains-mono
    meslo-lg
    nerd-fonts.zed-mono
  ];

  # ============================================
  # SECURITY & POLKIT
  # ============================================

  security.polkit. enable = true;

  # ============================================
  # SERVICES
  # ============================================

  # Enable SSH (optional, but useful)
  services.openssh = {
    enable = true;
    settings. PermitRootLogin = "no";
  };

  # Enable CUPS for printing (if needed)
  # services.printing.enable = true;
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # ============================================
  # MISC
  # ============================================

  # Enable command-not-found
  programs.command-not-found.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
