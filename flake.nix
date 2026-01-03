# flake.nix structure example
{
  description = "mrjshzk nix configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim.url = "github:pfassina/lazyvim-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    # Optional, to download less. Neither the module nor the overlay uses this input.
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    lazyvim,
    stylix,
    fenix,
    spicetify-nix,
    nix-doom-emacs-unstraightened,
    nix-colors,
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
          # rust toolchain - fenix
          ({pkgs, ...}: {
            nixpkgs.overlays = [fenix.overlays.default];
            environment.systemPackages = [
              (pkgs.fenix.complete.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
              ])
              pkgs.rust-analyzer-nightly
            ];
          })

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mrjshzk = import ./home/home.nix;

            home-manager.extraSpecialArgs = {
              inherit lazyvim spicetify-nix inputs nix-doom-emacs-unstraightened nix-colors;
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
          # rust toolchain - fenix
          ({pkgs, ...}: {
            nixpkgs.overlays = [fenix.overlays.default];
            environment.systemPackages = [
              (pkgs.fenix.complete.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
              ])
              pkgs.rust-analyzer-nightly
            ];
          })
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users. mrjshzk = import ./home/home.nix;
            home-manager.extraSpecialArgs = {
              inherit lazyvim spicetify-nix inputs nix-doom-emacs-unstraightened nix-colors;
            };
          }
        ];
      };
    };
  };
}
