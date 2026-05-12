{
  description = "mrjshzk nix configuration";

  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nix-ld,
    nixpkgs,
    lanzaboote,
    sops-nix,
    ...
  }: let
    mkSystem = hostname: extraModules:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules =
          extraModules
          ++ [
            lanzaboote.nixosModules.lanzaboote
            nix-ld.nixosModules.nix-ld
            sops-nix.nixosModules.sops

            ./hosts/${hostname}/hardware-configuration.nix
            ./modules/langs # programming languages and of sort
            ./modules/user_services # custom systemd services
            ./modules/user # user identity options
            ./modules/core-apps # core apps definitions
            ./modules/window-manager # sets up nixos modules for wms
            ./main/main.nix # main entry, bootstrapper for home manager
            {
              keyboard.layout = "${hostname}";
              host.hostname = "${hostname}";
              user.name = "mrjshzk";

              programs.nix-ld.dev.enable = true;

              # Enable all language toolchains by default for all hosts.
              # Set any of these to false in a host-specific file to opt out.
              langs.rust.enable = true;
              langs.go.enable = true;
              langs.cc.enable = true;
              langs.python.enable = true;
              langs.web.enable = true;
              langs.vulkan.enable = true;
              langs.others.enable = true;
            }
          ];
      };
  in {
    nixosConfigurations = {
      desktop = mkSystem "desktop" [./hosts/desktop/nvidia.nix];

      laptop = mkSystem "laptop" [./hosts/laptop/intel-gpu.nix];
    };
  };
}
