{
  config,
  pkgs,
  lazyvim,
  ...
}: {
  home = {
    file = {
      ".bashrc".text = ''
        # Load Starship prompt
        eval "$(starship init bash)"
      '';
      "backgrounds" = {
        source = ./backgrounds;
        recursive = true;
      };
      "scripts" = {
        source = ./scripts;
        recursive = true;
      };
    };
    packages = with pkgs; [
      # common utils
      ripgrep
      killall
      fd
      fzf
      stow

      # Hyprland essentials
      waybar # Status bar
      wofi # App launcher
      dunst # Notifications
      hyprpaper # Wallpaper daemon
      # TODO replace hyprlock
      kitty # Terminal
      starship # custom prompt

      # Screenshot tools
      grim # Screenshot utility
      slurp # Select screen region
      wl-clipboard # Clipboard utilities

      # File manager
      yazi

      # Browsers
      librewolf

      # Other useful tools
      wiremix # tui for audio
      brightnessctl # Screen brightness
      playerctl # Media control

      # langs
      python313
      python313Packages.pip
      go
    ];
  };

  imports = [
    ./nvim.nix
    ./bash.nix
    ./kitty.nix
    ./waybar.nix
    ./wofi.nix
    ./hyprpaper.nix
    ./starship.nix
    ./dunst.nix
    ./hyprland.nix
  ];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "mrjshzk";
        email = "mrjsilva05@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  # System version (don't change this)
  home.stateVersion = "25.11";
}
