{
  description = "mrjshzk nix configuration";

  inputs = {
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
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      mkSystem =
        hostname: keyboardLayout: extraModules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = extraModules ++ [
            ./hosts/${hostname}/hardware-configuration.nix
            ./common/common.nix
            ./common/hyprland_wm.nix
            ./common/rust.nix
            ./common/home_manager.nix
            ./modules/user_services/user_services.nix
            {
              keyboard.layout = "${keyboardLayout}";
              host.hostname = "${hostname}";
            }
          ];

        };
    in
    {
      nixosConfigurations = {
        desktop = mkSystem "desktop" "us" [
          ./hosts/desktop/nvidia.nix
        ];

        laptop = mkSystem "laptop" "pt" [
          ./hosts/laptop/intel-gpu.nix
        ];
      };
    };
}
