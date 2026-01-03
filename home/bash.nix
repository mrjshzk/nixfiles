{
  config,
  pkgs,
  ...
}:
let
  rebuild = host: ''
    wdr="$(pwd)"
    cd ~/.config/nixos || exit 1
    sudo nixos-rebuild switch --flake .#${host}
    cd "$wdr"
  '';
in
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      grep = "rg --color=auto";

      desktop-rebuild = rebuild "desktop";
      laptop-rebuild = rebuild "laptop";

      ".." = "cd ..";
      config-edit = ''
        cd ~/.config/nixos || exit 1
        nvim .
      '';
      dunstdiddy = ''
        killall .dunst-wrapped; notify-send 'hello broski'
      '';
    };
  };
}
