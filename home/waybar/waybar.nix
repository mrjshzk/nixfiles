{
  pkgs,
  config,
  ...
}:
{
  imports = [ ./style.nix ];
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "cpu"
          "pulseaudio"
          "network"
          "battery"
          "hyprland/language"
          "clock"
        ];
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "battery" = {
          format = "{capacity}%  ";
          format-charging = "{capacity}%  ";
        };
        "network" = {
          format = "{signalStrength}% {icon} ";
          format-icons = [
            "󰤨"
            "󰤥"
            "󰤢"
            "󰤟"
          ];
          interval = 60;
          family = "ipv4_6";
          on-click = "~/scripts/open_tui.sh impala";
        };
        "pulseaudio" = {
          format = "{volume}% {icon} ";
          format-muted = " ";
          format-icons = {
            headphones = "";
            headset = "";
            phone = "";
            phone-muted = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 1;
          on-click = "~/scripts/open_tui.sh wiremix";
        };
        "hyprland/language" = {
          format = "{short}";
        };
        "cpu" = {
          interval = 1;
          format = "{icon0}{icon1}{icon2}{icon3} {usage:>2}%  ";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };
        "hyprland/workspaces" = {
          persistent-workspaces = {
            "*" = [
              1
              2
              3
              4
              5
            ];
          };
          format = "{icon}";
          format-icons = {
            active = " ";
          };
        };
      };
    };
  };

}
