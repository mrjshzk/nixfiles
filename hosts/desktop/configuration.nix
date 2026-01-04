{ pkgs, config, ... }:

import ../..common/keyboard_config.nix { inherit pkgs; } "us"
