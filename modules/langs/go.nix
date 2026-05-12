{ pkgs, lib, config, ... }:
{
  options.langs.go.enable = lib.mkEnableOption "Go toolchain";

  config = lib.mkIf config.langs.go.enable {
    environment.systemPackages = with pkgs; [
      go
      gopls
      gomodifytags
      gotests
      gore
      air
    ];
  };
}
