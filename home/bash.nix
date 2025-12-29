{
  config,
  pkgs,
  ...
}: {
  # configure bash
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      grep = "rg --color=auto";
      desktop-rebuild = ''        cd ~/.config/nixos &&
                sudo nixos-rebuild switch --flake .#desktop;
                cd ~
      '';
      laptop-rebuild = ''        cd ~/.config/nixos &&
                sudo nixos-rebuild switch --flake .#laptop;
                cd ~
      '';

      ".." = "cd ..";
    };
  };
}
