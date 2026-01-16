# common/common. nix
{ config, pkgs, spicetify-nix, ... }: {
  # ============================================
  # SYSTEM BASICS
  # ============================================

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings = { AutoConnect = true; };
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
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
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
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
    experimental-features = [ "nix-command" "flakes" ];
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
  services.upower.enable = true;

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
  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #
  #
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
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXinerama
    xorg.libXfixes
    xorg.libXxf86vm
    pulseaudio
    xorg.libSM
    xorg.libICE
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
  ];

  system.stateVersion = "25.11";
}
