{
  pkgs,
  config,
  ...
}:
{
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
          format = "{capacity}%   ";
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
          on-click = "~/dotfiles/scripts/open_tui.sh impala";
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
          on-click = "~/dotfiles/scripts/open_tui.sh wiremix";
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
    style = ''
      * {
        min-height :  0;
        padding :  0;
        margin :  0;
        color :  #ffffff;
        font-size :  20px;
        font-family :  "JetBrains Mono Propo";
        color :  #${config.colorScheme.palette.base05};
      }

      window#waybar {
        background-color :  transparent;
      }

      #network, #battery, #language, #pulseaudio, #clock, #cpu {
        padding :  10px 10px 10px 10px;
        margin :  0 6px 0 6px;
        border :  2px solid #${config.colorScheme.palette.base02};
        border-radius :  5px;
        background-color :  #${config.colorScheme.palette.base00};
      }

      #workspaces button {
        transition :  all 150ms ease-in-out;
        border-radius :  5px;
        background-color :  #${config.colorScheme.palette.base00};
        min-width :  40px;
        margin-left :  10px;
        border :  2px solid #${config.colorScheme.palette.base02};
      }

      #workspaces button.active {
        border :  3px dashed #${config.colorScheme.palette.base02};
        min-width :  50px;
      }

      .modules-right {
        margin :  10px 10px 0 0;
      }

      .modules-left {
        margin :  10px 0 0 20px;
      }
    '';
  };

}
