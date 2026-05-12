{ lib, ... }:

{
  options.user = {
    name = lib.mkOption {
      type = lib.types.strMatching "[a-z][a-z0-9_-]*";
      description = "Primary system username (must be a valid Unix username).";
    };
  };
}
