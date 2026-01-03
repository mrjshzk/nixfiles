{
  config,
  pkgs,
  lazyvim,
  spicetify-nix,
  inputs,
  ...
}:
{
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
      ".config/kitty" = {
        source = ./kitty;
        recursive = true;
      };
      ".config/dunst" = {
        source = ./dunst;
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
      kitty # Terminal
      starship # custom prompt

      # Screenshot tools
      grim # Screenshot utility
      slurp # Select screen region
      wl-clipboard # Clipboard utilities

      # File manager
      yazi

      bluetui
      impala

      # Browsers
      librewolf

      # Other useful tools
      wiremix # tui for audio
      brightnessctl # Screen brightness
      playerctl # Media control

      # langs
      python313
      python313Packages.pip
      python313Packages.black
      python313Packages.pyflakes
      python313Packages.isort
      pipenv
      python313Packages.pytest

      go
      gopls
      gomodifytags
      gotests
      gore

      cmake
      gnumake

      rocmPackages.clang
      glslang

      gdtoolkit_4

      tree-sitter
      pandoc

      nixfmt

      shfmt
      shellcheck
    ];
  };

  imports = [
    inputs.nix-doom-emacs-unstraightened.homeModule
    spicetify-nix.homeManagerModules.spicetify
    ./colorscheme.nix
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
  programs = {
    doom-emacs = {
      enable = true;
      doomDir = ./doomdir; # or e.g. `./doom.d` for a local configuration
    };
    spicetify.enable = true;
  };
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
