{ hostname, ... }:
let
  rebuild = ''
    wdr="$(pwd)"
    cd ~/.config/nixos || exit 1
    echo 'Rebuilding NixOS for host: ${hostname}'
    sudo nixos-rebuild switch --flake .#${hostname}
    cd "$wdr"
  '';
in {
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      grep = "rg --color=auto";

      nrs = rebuild;

    };
  };
}
