{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  imports = [./hm_bootstrapper.nix];

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
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
    extraGroups = ["networkmanager" "wheel" "video" "audio" "dialout"];
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
    glib
    libnotify

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
    pulse.enable = true;
    jack.enable = true;
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

  security.polkit.enable = true;

  # ============================================
  # SERVICES
  # ============================================

  # Enable SSH (optional, but useful)
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  # Enable CUPS for printing (if needed)
  # services.printing.enable = true;
  services.xserver.enable = true;

  # ============================================
  # MISC
  # ============================================

  # Enable command-not-found
  programs.command-not-found.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.dev.libraries = with pkgs; [
    # Provides the dynamic loader + libstdc++/libgcc runtime
    stdenv.cc.cc

    # Very commonly needed by downloaded binaries
    zlib
    openssl
    curl

    # Wayland stack
    wayland
    libxkbcommon

    # Vulkan / OpenGL userspace loaders
    vulkan-loader
    libGL

    # Many apps still pull X11 libs even on Wayland (via XWayland)
    libx11
    libxcursor
    libxext
    libxi
    libxrandr
    libxrender
    libxinerama
    libxfixes
    libxxf86vm
    pulseaudio
    libsm
    libice
    fontconfig
    dbus
    glib
    atk
    pango
    cairo
    alsa-lib

    gdk-pixbuf
    freetype
    expat
    libdrm
    mesa
    udev
    zstd
  ];

  system.stateVersion = "25.11";
}
