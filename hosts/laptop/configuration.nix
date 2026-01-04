{ pkgs, config, ... }:

import ./keyboard-config.nix { inherit pkgs; } "pt"
