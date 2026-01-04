{ pkgs, config, ... }:

import ./keyboard-config.nix { inherit pkgs; } "us"
