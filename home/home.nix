{
  config,
  pkgs,
  lazyvim,
  spicetify-nix,
  nix-colors,
  inputs,
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
      mako # Notifications
      hyprpaper # Wallpaper daemon
      ghostty # Terminal
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
    nix-colors.homeManagerModules.default
    ./nvim.nix
    ./bash.nix
    ./ghostty.nix
    ./waybar.nix
    ./wofi.nix
    ./hyprpaper.nix
    ./starship.nix
    ./mako.nix
    ./hyprland.nix
  ];

  # Colorscheme
  colorScheme = nix-colors.colorSchemes.dracula;

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
