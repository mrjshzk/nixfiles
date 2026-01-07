{ inputs, config, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mrjshzk = import ../home/home.nix;
    extraSpecialArgs = {
      inherit inputs;
      inherit (inputs)
        lazyvim
        spicetify-nix
        nix-doom-emacs-unstraightened
        nix-colors
        ;

      hostname = config.host.hostname;
    };
  };
}
