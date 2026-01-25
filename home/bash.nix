{hostname, ...}: let
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
      ghostty = "GTK_IM_MODULE=simple ghostty";
    };
    bashrcExtra = ''
            function y() {
            	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            	command yazi "$@" --cwd-file="$tmp"
            	IFS= read -r -d \'\' cwd < "$tmp"
            	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
            	rm -f -- "$tmp"
            }
      eval "$(zoxide init bash)"
    '';
  };
}
