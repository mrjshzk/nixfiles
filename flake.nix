# flake.nix structure example
{
  description = "mrjshzk nix configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lazyvim,
    stylix,
    ...
  }: {
    nixosConfigurations = {
      # Desktop with NVIDIA
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          ./hosts/desktop/nvidia.nix
          ./common/common.nix
          ./common/hyprland_wm.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mrjshzk = ./home/home.nix;

            home-manager.extraSpecialArgs = {
              inherit lazyvim;
            };
          }
        ];
      };

      # Laptop with Intel
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/intel-gpu.nix
          ./common/common.nix
          ./common/hyprland_wm.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mrjshzk = ./home/home.nix;

            home-manager.extraSpecialArgs = {
              inherit lazyvim;
            };
          }
        ];
      };
    };
  };
}
