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

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      # Common modules shared by all systems
      commonModules = [
        ./common/common.nix
        ./common/hyprland_wm.nix

        # Rust toolchain - fenix
        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = [ inputs.fenix.overlays.default ];
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
          }
        )

        # Home manager configuration
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mrjshzk = import ./home/home.nix;
          home-manager.extraSpecialArgs = {
            inherit (inputs)
              lazyvim
              spicetify-nix
              nix-doom-emacs-unstraightened
              nix-colors
              ;
            inherit inputs;
          };
        }
      ];
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/desktop/configuration.nix
            ./hosts/desktop/hardware-configuration.nix
            ./hosts/desktop/nvidia.nix
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/laptop/configuration.nix
            ./hosts/laptop/hardware-configuration.nix
            ./hosts/laptop/intel-gpu.nix
          ];
        };
      };
    };
}
