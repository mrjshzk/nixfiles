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
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld.url = "github:Mic92/nix-ld";
    # this line assume that you also have nixpkgs as an input
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ nix-ld, nixpkgs, ... }:
    let
      # Shared configuration that can be overridden per-host
      sharedConfig = {
        windowManager.name = "hyprland";
      };

      mkSystem = hostname: extraModules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs sharedConfig; };
          modules = extraModules ++ [

            nix-ld.nixosModules.nix-ld
            ./hosts/${hostname}/hardware-configuration.nix
            ./langs/langs.nix
            ./modules/user_services/user_services.nix
            ./modules/core-apps
            ./modules/window-manager
            ./wm/window_manager.nix
            ./main/main.nix
            {
              keyboard.layout = "${hostname}";
              host.hostname = "${hostname}";

              programs.nix-ld.dev.enable = true;

              # Apply shared configuration
              windowManager.name = sharedConfig.windowManager.name;
            }
          ];

        };
    in {
      nixosConfigurations = {
        desktop = mkSystem "desktop" [ 
          ./hosts/desktop/nvidia.nix
          ./hosts/desktop
        ];

        laptop = mkSystem "laptop" [ 
          ./hosts/laptop/intel-gpu.nix
          ./hosts/laptop
        ];
      };
    };
}
