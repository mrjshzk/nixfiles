{
  pkgs,
  config,
  ...
}:
{
  services.xserver.xkb.layout = "pt";
  systemd.user.services.boot-keyboard-layout-switcher = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "Switch keyboard layout for the appropriate machine :)";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''~/scripts/switch_keyboard.sh pt'';
    };
  };
}
