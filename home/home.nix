{ pkgs, spicetify-nix, osConfig, ... }: {

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
    packages = with pkgs;
      [
        # common utils
        ripgrep
        killall
        fd
        fzf
        stow
        tldr

        # Screenshot tools
        grim # Screenshot utility
        slurp # Select screen region
        wl-clipboard # Clipboard utilities

        bluetui
        impala

        # Browsers
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
        air

        cmake
        gnumake
        arduino-cli
        platformio

        (pkgs.clang-tools.overrideAttrs (oldAttrs: { meta.priority = 9; }))
        (pkgs.clang.overrideAttrs (oldAttrs: { meta.priority = 10; }))
        (pkgs.gcc.overrideAttrs (oldAttrs: { meta.priority = 20; }))

        glslang

        gdtoolkit_4

        tree-sitter
        pandoc

        shfmt
        shellcheck

        luajit
        luajitPackages.luarocks-nix

        kdePackages.qtdeclarative
        kdePackages.qtwayland
        quickshell
        lazygit
        brotli
        blender
        libxxf86vm

        # neovim snacks tools
        imagemagick
        git-spice
        tectonic
        mermaid-cli
        nodejs_24

      ] ++ osConfig.core.packages; # Add core application packages
  };

  imports = [
    spicetify-nix.homeManagerModules.spicetify
    ./bash.nix
    ./ghostty.nix
    ./starship.nix
    ./wm/hyprland.nix
  ];

  programs = {

    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
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
