{ pkgs, config, ... }:
{
  programs.waybar.style = with config.colorScheme.palette; ''
    * {
      min-height :  0;
      padding :  0;
      margin :  0;
      font-size :  20px;
      font-family :  "JetBrains Mono Propo";
      color :  #${base07};
    }

    window#waybar {
      background-color :  transparent;
    }

    /* Each module on the right gets unique base16 accent colors */
    #network {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border :  2px solid #${base0B};  /* base16 green */
      border-radius :  5px;
      background-color :  #${base00};
      color :  #${base0B};
    }

    #battery {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border :  2px solid #${base0A};  /* base16 yellow */
      border-radius :  5px;
      background-color :   #${base00};
      color :  #${base0A};
    }

    #language {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border :  2px solid #${base09};  /* base16 orange */
      border-radius :  5px;
      background-color :   #${base00};
      color :  #${base09};
    }

    #pulseaudio {
      padding :  10px 10px 10px 10px;
      margin :   0 6px 0 6px;
      border :  2px solid #${base0E};  /* base16 purple/magenta */
      border-radius :   5px;
      background-color :  #${base00};
      color :  #${base0E};
    }

    #clock {
      padding :  10px 10px 10px 10px;
      margin :   0 6px 0 6px;
      border :  2px solid #${base0D};  /* base16 blue */
      border-radius :  5px;
      background-color :   #${base00};
      color :  #${base0D};
    }

    #cpu {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border :  2px solid #${base08};  /* base16 red */
      border-radius :  5px;
      background-color :   #${base00};
      color :  #${base08};
    }

    /* Cool workspaces with gradient effect and hover animation */
    #workspaces button {
      transition :  all 150ms ease-in-out;
      border-radius :  5px;
      background :  linear-gradient(135deg, #${base00} 0%, #${base02} 100%);
      min-width :  40px;
      margin-left :  10px;
      border :  2px solid #${base04};
      box-shadow :  0 2px 4px rgba(0, 0, 0, 0.3);
    }

    #workspaces button.hover {
      background :  linear-gradient(135deg, #${base02} 0%, #${base04} 100%);
      border :  2px solid #${base06};
      box-shadow :  0 4px 8px rgba(0, 0, 0, 0.5);
    }

    #workspaces button.active {
      background :  linear-gradient(135deg, #${base0A} 0%, #${base09} 100%);
      border :  3px solid #${base0A};
      min-width :   50px;
      box-shadow :  0 4px 12px rgba(29, 32, 33, 0.5);
      color :  #${base00};
      font-weight :  bold;
    }

    .modules-right {
      margin :   10px 10px 0 0;
    }

    .modules-left {
      margin :   10px 0 0 20px;
    }
  '';

}
