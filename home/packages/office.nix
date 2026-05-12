{ pkgs, ... }: {
  home.packages = with pkgs; [
    libreoffice
    teams-for-linux
    obsidian
    unityhub
  ];
}
