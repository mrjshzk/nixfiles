{
  pkgs,
  config,
  ...
}:
{
  services.xserver.xkb.layout = "us";
  systemd.user.services.host_specific_boot = {
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "Switch keyboard layout for the appropriate machine :)";
    path = with pkgs; [
      coreutils
      libnotify # provides notify-send
      hyprland # provides hyprctl
      bash
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2"; # Wait 2 seconds
      ExecStart = "${pkgs.bash}/bin/bash %h/scripts/switch_keyboard.sh us";
    };

  };

}
