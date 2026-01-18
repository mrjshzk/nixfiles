{ pkgs, spicetify-nix, osConfig, ... }: {

  home = {
    file = {
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
        ripgrep
        killall
        fd
        fzf
        stow
        tldr

        grim # Screenshot utility
        slurp # Select screen region
        wl-clipboard # Clipboard utilities

        bluetui
        impala

        discord
        vscodium

        wiremix # tui for audio
        brightnessctl # Screen brightness
        playerctl # Media control
        font-awesome
        roboto
        fastfetch
        mpd
        mpc

        lazygit
        brotli
        blender
        libxxf86vm

        imagemagick
        git-spice
        tectonic
        mermaid-cli

      ] ++ osConfig.core.packages; # Add core application packages
  };

  imports = [
    spicetify-nix.homeManagerModules.spicetify
    ./bash.nix
    ./wm/hyprland.nix
    ./core_apps
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    spicetify.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          name = "mrjshzk";
          email = "mrjsilva05@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };

  # System version (don't change this)
  home.stateVersion = "25.11";
}
