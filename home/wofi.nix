{
  pkgs,
  config,
  ...
}: {
  programs.wofi = {
    enable = true;
    #style = ./wofi/style.css;
  };

  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  #xdg.configFile."waybar/style.css".source = ./waybar/style.css;
}
