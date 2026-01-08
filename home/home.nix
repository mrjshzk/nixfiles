{
  pkgs,
  spicetify-nix,
  nix-colors,
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
    };
    packages = with pkgs; [
      # common utils
      ripgrep
      killall
      fd
      fzf
      stow
      tldr

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
      discord
      vscodium

      # Other useful tools
      wiremix # tui for audio
      brightnessctl # Screen brightness
      playerctl # Media control
      font-awesome
      roboto
      fastfetch
      mpd
      mpc

      # langs
      prettier
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

      (pkgs.clang-tools.overrideAttrs (oldAttrs: {
        meta.priority = 9;
      }))
      (pkgs.clang.overrideAttrs (oldAttrs: {
        meta.priority = 10;
      }))
      (pkgs.gcc.overrideAttrs (oldAttrs: {
        meta.priority = 20;
      }))

      glslang

      gdtoolkit_4

      tree-sitter
      pandoc
      nodejs_24

      nixfmt

      shfmt
      shellcheck

      # arduino
      arduino-core
      arduino-cli

      luajit
      luajitPackages.luarocks-nix
      lua-language-server
      stylua

      vscode-langservers-extracted
      nil
      typescript-language-server
      eslint
      live-server

      # neovim snacks tools
      imagemagick
      git-spice
      tectonic
      mermaid-cli
      lazygit

    ];
  };

  imports = [
    inputs.nix-doom-emacs-unstraightened.homeModule
    spicetify-nix.homeManagerModules.spicetify
    nix-colors.homeManagerModules.default
    ./bash.nix
    ./ghostty.nix
    ./waybar/waybar.nix
    ./wofi.nix
    ./hyprpaper.nix
    ./starship.nix
    ./mako.nix
    ./hyprland.nix
  ];

  # Colorscheme
  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;

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

  programs.quickshell = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # System version (don't change this)
  home.stateVersion = "25.11";
}
