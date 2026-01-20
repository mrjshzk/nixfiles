{
  description = "mrjshzk nix configuration";

  inputs = {

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ nix-ld, nixpkgs, ... }:
    let

      mkSystem = hostname: extraModules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = extraModules ++ [

            nix-ld.nixosModules.nix-ld
            ./hosts/${hostname}/hardware-configuration.nix
            ./modules/langs # programming languages and of sort
            ./modules/user_services # custom systemd services
            ./modules/core-apps # core apps definitions
            ./modules/window-manager # sets up nixos modules for wms
            ./main/main.nix # main entry, bootstrapper for home manager
            {
              keyboard.layout = "${hostname}";
              host.hostname = "${hostname}";

              programs.nix-ld.dev.enable = true;

              windowManager.name = "hyprland";
            }
          ];

        };
    in {
      nixosConfigurations = {
        desktop = mkSystem "desktop" [ ./hosts/desktop/nvidia.nix ];

        laptop = mkSystem "laptop" [ ./hosts/laptop/intel-gpu.nix ];
      };
    };
}
