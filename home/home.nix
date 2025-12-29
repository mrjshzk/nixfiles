{
  config,
  pkgs,
  lazyvim,
  ...
}: {
  imports = [
    ./nvim.nix
    ./bash.nix
    ./kitty.nix
    ./waybar.nix
    ./wofi.nix
    ./hyprpaper.nix
    ./starship.nix
    ./hyprland.nix
  ];

  #hack
  home = {
    file = {
      ".bashrc".text = ''
        # Load Starship prompt
        eval "$(starship init bash)"
      '';

      #".config/hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
      #".config/hypr/autostart.conf".source = ./hyprland/autostart.conf;
      #".config/hypr/bindinds.conf".source = ./hyprland/bindings.conf;
      ###".config/hypr/input.conf".source = ./hyprland/input.conf;
      #".config/hypr/monitors.conf".source = ./hyprland/monitors.conf;
    };
  };

  # System version (don't change this)
  home.stateVersion = "25.11";
}
