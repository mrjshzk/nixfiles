{ pkgs, config, ... }:

{
  services.xserver.xkb.layout = "pt";

  systemd.user.services.host_specific_boot = {
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "Switch keyboard layout for the appropriate machine :)";
    path = with pkgs; [
      coreutils
      libnotify
      hyprland
      bash
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
      ExecStart = "${pkgs.bash}/bin/bash %h/scripts/switch_keyboard.sh pt";
    };
  };
}
