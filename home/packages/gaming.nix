{ pkgs, ... }: {
  home.packages = with pkgs; [
    steam
    steamcmd
    steam-run
    mangohud
    wivrn # OpenXR runtime for VR
  ];
}
