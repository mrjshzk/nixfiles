# NixOS Configuration

A modular and scalable NixOS configuration with easy window manager switching and centralized application management.

## Features

- **Modular Architecture**: Cleanly separated concerns with reusable modules
- **Core Apps Module**: Define preferred apps in one place, reference everywhere
- **Window Manager Abstraction**: Switch between WMs by changing a single option
- **Per-Host Overrides**: Customize settings for each machine while keeping a shared base
- **Type-Safe Configuration**: Properly typed options with sensible defaults

## Structure

```
.
├── flake.nix                    # Main flake configuration
├── hosts/                       # Host-specific configurations
│   ├── desktop/
│   │   ├── default.nix         # Desktop overrides
│   │   ├── nvidia.nix          # NVIDIA GPU config
│   │   └── hardware-configuration.nix
│   └── laptop/
│       ├── default.nix         # Laptop overrides
│       ├── intel-gpu.nix       # Intel GPU config
│       └── hardware-configuration.nix
├── modules/
│   ├── core-apps/              # Core application definitions
│   │   └── default.nix
│   ├── window-manager/         # Window manager abstraction
│   │   ├── default.nix         # WM options
│   │   └── hyprland.nix        # Hyprland-specific config
│   └── user_services/          # User service modules
├── home/                        # Home Manager configurations
│   ├── home.nix                # Main home config
│   └── wm/
│       └── hyprland.nix        # Hyprland home-manager config
├── main/
│   ├── main.nix                # Main system configuration
│   └── hm_bootstrapper.nix     # Home Manager bootstrap
├── wm/
│   └── window_manager.nix      # Window manager imports
└── langs/                       # Programming language configs
    └── langs.nix
```

## Quick Start

### Building a Configuration

```bash
# Build desktop configuration
sudo nixos-rebuild switch --flake .#desktop

# Build laptop configuration
sudo nixos-rebuild switch --flake .#laptop
```

### Changing the Terminal

Edit `flake.nix` or a host-specific override file:

```nix
{
  core.terminal = {
    package = pkgs.alacritty;
    command = "alacritty";
  };
}
```

### Switching Window Managers

Edit `flake.nix` to change the shared configuration:

```nix
sharedConfig = {
  windowManager.name = "sway";  # Options: hyprland, sway, i3, none
};
```

### Per-Host Customization

Edit `hosts/desktop/default.nix` or `hosts/laptop/default.nix`:

```nix
{
  # Override core apps
  core.browser.command = "firefox";
  
  # Override window manager settings
  windowManager.gaps.inner = 4;
  windowManager.gaps.outer = 8;
  windowManager.rounding = 15;
}
```

## Core Apps Configuration

The `core` module provides centralized application management:

- **terminal**: Terminal emulator (default: ghostty)
- **browser**: Web browser (default: librewolf)
- **fileManager**: File manager (default: yazi)
- **launcher**: Application launcher (default: wofi)
- **editor**: Text editor (default: neovim)

Each app has two properties:
- `package`: The Nix package to install
- `command`: The command to run the application

All core packages are automatically included via `core.packages`.

## Window Manager Configuration

The `windowManager` module provides a unified interface:

- **name**: Select WM (`hyprland`, `sway`, `i3`, `none`)
- **isWayland**: Auto-detected based on WM choice
- **gaps.inner**: Inner gaps between windows (default: 2)
- **gaps.outer**: Outer gaps around windows (default: 5)
- **borderSize**: Window border size (default: 2)
- **rounding**: Corner rounding radius (default: 10)
- **bar.enable**: Enable status bar (default: true)
- **bar.package**: Status bar package (default: waybar)
- **wallpaper.enable**: Enable wallpaper (default: true)
- **wallpaper.path**: Wallpaper image path (default: null)

## Adding a New Host

1. Create hardware configuration:
   ```bash
   sudo nixos-generate-config --show-hardware-config > hosts/newhost/hardware-configuration.nix
   ```

2. Create host override file:
   ```bash
   # hosts/newhost/default.nix
   { config, lib, ... }: {
     # Add host-specific overrides here
   }
   ```

3. Add to `flake.nix`:
   ```nix
   nixosConfigurations = {
     # ... existing configs
     newhost = mkSystem "newhost" [
       ./hosts/newhost
       # Add any extra modules like GPU drivers
     ];
   };
   ```

## Adding a New Window Manager

1. Create WM-specific module in `modules/window-manager/`:
   ```nix
   # modules/window-manager/sway.nix
   { config, lib, pkgs, ... }:
   with lib;
   {
     config = mkIf (config.windowManager.name == "sway") {
       # Sway-specific system configuration
     };
   }
   ```

2. Add import to `modules/window-manager/default.nix`:
   ```nix
   imports = [
     ./hyprland.nix
     ./sway.nix
   ];
   ```

3. Create home-manager config in `home/wm/`:
   ```nix
   # home/wm/sway.nix
   { config, lib, osConfig, ... }:
   with lib;
   {
     config = mkIf (osConfig.windowManager.name == "sway") {
       # Sway home-manager configuration
     };
   }
   ```

4. Add import to `home/home.nix`:
   ```nix
   imports = [
     # ... existing imports
     ./wm/sway.nix
   ];
   ```

## Validation

To validate your configuration:

```bash
# Check flake structure
nix flake check

# Show available configurations
nix flake show

# Evaluate a specific option
nix eval .#nixosConfigurations.desktop.config.windowManager.name
nix eval .#nixosConfigurations.desktop.config.core.terminal.command
```

## Tips

- Keep shared configuration in `flake.nix`
- Use host overrides for machine-specific settings
- Core apps are automatically installed via `core.packages`
- Window manager settings are referenced in home-manager configs via `osConfig`
- Use `mkIf` for conditional module activation

## License

This configuration is provided as-is for personal use.
